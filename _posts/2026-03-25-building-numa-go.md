---
layout: post
title: "numa-go: From FastAPI to a Production Go Backend"
date: 2026-03-25
categories: tech
---

## How It Started

[Numa](https://4ward.co) is a branded, modular piped water network — filtered, treated, and distributed to kiosks, schools, clinics, homes, and businesses across its service areas. The guarantee is simple: wherever you find NUMA water, it's safe, convenient, and reliable.

The backend I built handles how customers pay for it. They dial a USSD code, enter their meter number and an amount, pay via mobile money through Hubtel, and get a token delivered by SMS. No smartphone, no data connection needed. Just a phone.

The current version is the result of a rewrite. Before Go, there was Python. Before Redis, there was a dictionary. Before Postgres, there was nothing. This is the story of how it got here.

---

## Version 1: FastAPI

The first version was written in FastAPI. I had no professional experience building production APIs at the time. I figured it out as I went.

The USSD flow required session state, when a user enters their meter number, you need to remember it by the time they confirm their amount a few seconds later. I reached for what was simplest: an in-memory TTL cache from the `cachetools` library.

```python
from cachetools import TTLCache

cache = TTLCache(maxsize=100, ttl=600)
```

The router handled the USSD callbacks — validating the meter number, checking the amount, and returning the right response to Hubtel at each step:

```python
@router.post("/callback", response_model=HubtelResponse)
async def service_interaction(request: HubtelRequest):
    response = MESSAGES[request.Sequence]
    response["SessionId"] = request.SessionId

    if request.Sequence == 2:
        response["Message"] = await get_customer_by_meter_number(request.Message)
        cache[request.SessionId] = request.Message

    if request.Sequence == 3:
        if int(request.Message) >= 10:
            response["Type"] = "AddToCart"
            response["Item"]["Price"] = request.Message
            return response
        response["Type"] = "release"
        response["Message"] = "The amount entered is below the minimum required..."

    return response
```

No database. No persistent storage. The server was deployed with a systemd unit file, when it crashed, systemd restarted it; when the server rebooted, systemd brought it back up. It worked. It was in production, handling real payments.

---

## The Scaling Problem

Then users started coming in.

Requests began timing out. FastAPI runs as a single process by default - one worker , one event loop. When the external APIs were slow to respond, requests stacked up and the server fell behind.

The fix was two things. First, swap the in-memory cache for Redis — a proper external cache that survives restarts and works across multiple processes. Second, use Gunicorn to run multiple workers:

```
gunicorn -w 3 -k uvicorn.workers.UvicornWorker main:app
```

Three processes. Requests could now be handled concurrently, and session data was no longer tied to any one process's memory. That bought time. But the product was growing.

---

## Why Rewrite in Go

The next phase of Numa required more than just USSD. Customers who didn't want to dial a code needed a proper interface — transaction history, complaints, direct debit. On the admin side, there had to be a panel for managing users, settings, and reports.

That's a meaningful jump in scope. More endpoints, more auth logic, more moving parts. I started thinking about whether to keep building on the FastAPI base or start fresh.

I chose Go. Not because I was already good at it — I had no professional Go experience at the time. I chose it because I wanted to learn it properly, and a real project forces that in a way tutorials don't. Beyond that: Go's concurrency model fit the async write problem I knew I'd have, the standard library covers a lot without needing third-party dependencies, and a compiled binary is straightforward to deploy.

---

## Architecture

The rewrite was an opportunity to do things properly. The project is organized into strict, unidirectional layers:

```
cmd/numa/        ← entry point
internal/
  handlers/      ← HTTP layer: parse requests, write responses
  services/      ← business logic
  store/         ← data access (Postgres + Redis)
  clients/       ← external API wrappers
  worker/        ← background transaction writer
  models/        ← shared types
  config/        ← environment config
  crypto/        ← encryption for sensitive credentials
  db/            ← migrations and seeding
```

Handlers call services. Services call stores and clients. Nothing reaches across layers. Compare this to the FastAPI version where a single handler function was calling external APIs, updating the cache, and building HTTP responses all at once.

The discipline pays off when things change. Adding a new feature means adding one function per layer, each doing its part. Breaking changes stay contained.

---

## The USSD Flow

USSD is stateless — every request from Hubtel is a fresh HTTP call. The challenge is stitching those calls into a coherent session across steps.

**Step 1** is handled by Hubtel directly — it shows the welcome screen and prompts for a meter number.

**Step 2** — the user submits their meter number. The server validates it against the utility API and caches the result in Redis:

```go
func (s *UssdService) ValidateMeterNumber(ctx context.Context, sessionID, meterNumber string) (string, error) {
    name, err := s.utility.GetCustomerByMeterNumber(ctx, meterNumber)
    if err != nil {
        return "", fmt.Errorf("customer not found: %w", err)
    }

    if err := s.cache.Set(ctx, sessionID, meterNumber); err != nil {
        return "", fmt.Errorf("failed to save session: %w", err)
    }

    return fmt.Sprintf("You have requested to top up %s %s.\n\nEnter top up amount:",
        meterNumber, strings.ToUpper(name)), nil
}
```

The meter number goes into Redis keyed by Hubtel's `sessionId` — that's the same job `cachetools.TTLCache` was doing in Python, just properly external this time.

**Step 3** — the user enters an amount. Instead of a hardcoded `>= 10` check, the limit now comes from configurable settings stored in Postgres and cached in Redis. If valid, the response tells Hubtel to present a payment prompt.

**Fulfillment** — after the customer pays, Hubtel calls the fulfillment endpoint. The service confirms payment, retrieves the cached meter number, calls the utility API for the vend token, sends it by SMS, cleans up the session, and queues the transaction record for the database.

---

## Design Patterns

The Go rewrite wasn't just a language change — it was a chance to apply patterns that make the system easier to work with as it grows. Here are the ones worth calling out.

### Repository Pattern

In the FastAPI version there was no database, so data access was scattered — whatever needed to persist went into the in-memory cache. In numa-go, every data access concern is behind an interface:

```go
type PaymentStore interface {
    Create(ctx context.Context, payment *models.Payment) error
    List(ctx context.Context, filter PaymentQuery) (*PaginatedPayments, error)
}

type UserStore interface {
    GetByEmail(ctx context.Context, email string) (*models.User, error)
    Create(ctx context.Context, user *models.User) error
}
```

Services never write a SQL query. They call methods on these interfaces. The actual Postgres implementation lives in the `store` package and is swappable without touching any business logic.

### Strategy Pattern — Mock Clients

The external APIs the system depends on are live production services with no sandbox environment. Every call in development is a real call — real latency, potential charges, and behaviour that's hard to control.

Both external clients are defined as interfaces, and a flag at startup decides which implementation to wire in:

```go
if cfg.UseMockClients {
    hubtelClient = clients.NewMockHubtelClient()
    utilityClient = clients.NewMockUtilityClient()
} else {
    hubtelClient = clients.NewHubtelClient(cfg)
    utilityClient = clients.NewUtilityClient(cfg)
}
```

The mock and real implementations satisfy the same interface. Business logic — the `UssdService`, `CustomerService` and so on — never knows which one it's talking to. The whole USSD flow can run end-to-end locally without touching a live API.

This was a direct lesson from the FastAPI version, where there was no clean way to test without hitting real services.

### Dependency Injection

Nothing in the codebase is global. Services are constructed with their dependencies passed in explicitly:

```go
ussdSvc    := services.NewUssdService(utilityClient, hubtelClient, cacheStore, txWorker, cfg, settingsSvc)
customerSvc := services.NewCustomerService(stores.Payments, utilityClient, hubtelClient, cacheStore, txWorker, cfg)
```

Every dependency is visible at the construction site. This is what makes the strategy pattern above work — you can swap the mock client in because it was injected, not hardcoded. It also makes the code easier to reason about: to understand what a service depends on, you just look at its constructor.

### Decorator Pattern — Middleware Chain

Cross-cutting concerns (logging, rate limiting, body size limits, CORS, auth) are each their own handler wrapper:

```go
srv := &http.Server{
    Handler: handlers.RequestLogger(
        handlers.RateLimiter(/* config */)(
            handlers.MaxBodySize(1 << 20)(
                handlers.CORSMiddleware(mux),
            ),
        ),
    ),
}
```

Each wrapper takes an `http.Handler` and returns one — the same interface, wrapping the next layer. Adding or removing a concern like rate limiting is a one-line change that touches nothing else. In the FastAPI version these were absent.

### RBAC at Multiple Layers

The admin panel has two roles: `ADMIN` and `SUPER_ADMIN`. Rather than a single permission check somewhere, access control is enforced at three independent points: the `RequireSuperAdmin` middleware rejects the request before it reaches the handler, the handler itself checks the JWT claims, and the service layer refuses to operate on super admin accounts even if a request somehow got through.

Defence in depth — no single missed check grants access.

### Background Worker

In the FastAPI version there was no database, so there was no write latency to worry about. In the Go version, writing every transaction synchronously in the request cycle would mean the customer waits for a DB write before getting their SMS confirmation.

The solution is a worker pool that handles DB writes in the background:

```go
func (w *TransactionWorker) SubmitCreate(p *models.Payment) error {
    select {
    case w.jobs <- &job{payment: p}:
        return nil
    default:
        // Queue full — write directly rather than lose the record
        slog.Warn("worker queue full, writing payment synchronously", "orderID", p.OrderID)
        ctx, cancel := context.WithTimeout(context.Background(), 30*time.Second)
        defer cancel()
        return w.payments.Create(ctx, p)
    }
}
```

The HTTP handler calls `SubmitCreate` and returns a response immediately. Multiple goroutines drain the queue in the background. The `default` branch is the safety valve: if the queue is ever full, the write falls back to synchronous rather than dropping the record.

Shutdown is deliberate — the HTTP server drains open requests first, then the worker drains the queue. If you get the order wrong, you either drop in-flight jobs or the process hangs.

### Cache-Aside Pattern

The `SettingsService` manages app-wide configuration — things like the minimum top-up amount and whether USSD is currently enabled. These settings are read on almost every USSD request, so hitting Postgres every time would be wasteful.

The pattern is: read from Redis first, fall back to Postgres on a cache miss, then populate the cache for the next read.

```go
func (s *SettingsService) GetSettings(ctx context.Context) (*models.AppSettings, error) {
    // Try cache first
    if raw, err := s.cache.Get(ctx, settingsCacheKey); err == nil {
        var settings models.AppSettings
        if jsonErr := json.Unmarshal([]byte(raw), &settings); jsonErr == nil {
            return &settings, nil
        }
    }

    // Cache miss — load from Postgres
    settings, err := s.db.Get(ctx)
    if err != nil {
        return nil, fmt.Errorf("get settings: %w", err)
    }

    // Populate cache for next read
    if raw, jsonErr := json.Marshal(settings); jsonErr == nil {
        s.cache.Set(ctx, settingsCacheKey, string(raw))
    }

    return settings, nil
}
```

On writes, the service updates Postgres first, then immediately writes the new value to the cache — so the next read never sees stale data.

### Context Propagation

After the auth middleware validates a JWT, it doesn't pass the claims down through every function signature. Instead it stores them in the request context with a typed key:

```go
ctx := context.WithValue(r.Context(), adminClaimsKey, claims)
next.ServeHTTP(w, r.WithContext(ctx))
```

Any handler downstream can pull the claims out cleanly:

```go
claims, ok := adminClaimsFrom(r)
```

This keeps function signatures clean and is the idiomatic Go way to pass request-scoped data through a handler chain.

### Fire-and-Forget Audit Logging

Every privileged action — creating an admin, resetting a password, changing settings — is recorded in an audit log. But a failed audit write should never crash a legitimate operation. The `AuditService` makes this explicit:

```go
func (s *AuditService) Log(ctx context.Context, entry *models.AuditLogEntry) {
    if err := s.store.Log(ctx, entry); err != nil {
        slog.Warn("audit log write failed", "action", entry.Action, "error", err)
    }
}
```

No error is returned to the caller. A failed write emits a warning and the request continues. Audit logging is observability infrastructure — degraded observability is better than broken operations.

### Short-Lived Access Tokens + Revocable Refresh Tokens

Access tokens are short-lived and validated statelessly — no DB lookup on every request. Refresh tokens are stored in Postgres, which means they can be explicitly revoked on logout.

This is a deliberate tradeoff. Pure JWT is fast but you can't invalidate a token before it expires. Storing refresh tokens in the DB gives you revocation without paying for a DB lookup on every single request — only on token refresh.

### Fail-Fast Configuration

Every required environment variable is validated at startup:

```go
func getEnv(key string) string {
    v := os.Getenv(key)
    if v == "" {
        log.Fatalf("required env var %q is not set", key)
    }
    return v
}
```

The process refuses to start if something is missing. This is far better than starting up and then crashing mid-request when the first code path that needs the missing config is hit. If there's a misconfiguration, you find out immediately at boot — not in production at 2am.

### Rate Limiter with Memory-Leak Prevention

The rate limiter tracks a `*rate.Limiter` per client IP in an in-memory map. The obvious problem: if you create a new entry for every IP and never clean up, the map grows forever.

The fix is a background goroutine that evicts stale entries periodically:

```go
func (rl *rateLimiterMiddleware) cleanup() {
    for {
        time.Sleep(5 * time.Minute)
        rl.mu.Lock()
        for ip, entry := range rl.limiters {
            if time.Since(entry.lastSeen) > 5*time.Minute {
                delete(rl.limiters, ip)
            }
        }
        rl.mu.Unlock()
    }
}
```

The USSD and payment callback endpoints are also exempt from rate limiting entirely — they receive traffic from Hubtel's servers, not from end users, so IP-based limiting would do more harm than good.

---

## What Changed Between Versions

Looking back, the differences between the two versions map directly to problems that actually happened:

The **in-memory cache** became Redis — a shared cache that survives restarts and works across processes. The `cachetools` dictionary worked until the app needed more than one process.

The **hardcoded validation rules** became configurable settings stored in Postgres — because operators need to change the minimum top-up amount without a code deployment.

The **structure** became more strictly layered — handlers, services, stores, and clients each in their own package with clear boundaries, because a growing surface area of endpoints and logic made looser separation hard to maintain.

The **no-mock development** became an interface-based mock/real split — because you can't build confidently against services you can't control.

The **systemd unit file** became Docker and Docker Compose — the Go binary, Postgres, and Redis each run in their own container, with Nginx sitting in front as a reverse proxy. The whole stack spins up with a single command, and the deployment environment matches the development environment exactly.

None of this was over-engineering from the start. The FastAPI version was in production and it worked. Each change was a response to a real constraint — traffic, scope, or the limits of the previous approach.
