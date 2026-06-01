---
layout: post
title: "Differentiation Rules: Lecture Notes"
date: 2026-05-30
categories: tech
math: true
---

These are condensed notes on the core rules of differentiation. Each section covers the concept and two worked examples. Good for revision before an exam or before diving into integration.

---

## 1. Derivatives of Polynomial, Exponential, and Logarithmic Functions

**Power Rule:** For any real number $n$, if $f(x) = x^n$, then $f'(x) = nx^{n-1}$.

**Constant Rule:** The derivative of any constant is 0.

**Constant Multiple Rule:** $\frac{d}{dx}[cf(x)] = cf'(x)$

**Sum/Difference Rule:** $\frac{d}{dx}[f(x) \pm g(x)] = f'(x) \pm g'(x)$

**Exponential Functions:**
- $\frac{d}{dx}[e^x] = e^x$ — the only function that is its own derivative.
- $\frac{d}{dx}[e^{f(x)}] = e^{f(x)} \cdot f'(x)$.
- $\frac{d}{dx}[a^x] = a^x \ln a$ for any positive constant $a \neq 1$.
- $\frac{d}{dx}[a^{f(x)}] = a^{f(x)} \ln(a) \cdot f'(x)$ for any positive constant $a \neq 1$.

**Logarithmic Functions:**
- $\frac{d}{dx}[\ln(f(x))] = \frac{f'(x)}{f(x)}$, where $f(x) > 0$.
- $\frac{d}{dx}[\log_a(f(x))] = \frac{f'(x)}{f(x)\ln(a)}$ for any positive constant $a \neq 1$, where $f(x) > 0$.

---

**Example 1.** Find $f'(x)$ if $f(x) = 3x^4 - 5x^2 + 7x - 2$.

Apply the power rule term by term:

$$f'(x) = 12x^3 - 10x + 7$$

The constant $-2$ drops out. Each term's exponent steps down by 1, and the original exponent becomes the new coefficient.

---

**Example 2.** Find $\frac{d}{dx}[4e^x - 2x^3 + 6]$.

$$\frac{d}{dx}[4e^x - 2x^3 + 6] = 4e^x - 6x^2 + 0 = 4e^x - 6x^2$$

$e^x$ is unchanged. The constant 6 vanishes.

---

## 2. The Product and Quotient Rules

You cannot just differentiate two functions multiplied or divided together term by term. These rules handle the interaction between them.

**Product Rule:** If $f$ and $g$ are differentiable, then:

$$\frac{d}{dx}[f(x)g(x)] = f'(x)g(x) + f(x)g'(x)$$

Think of it as: derivative of the first times the second, plus the first times the derivative of the second.

**Quotient Rule:** If $g(x) \neq 0$, then:

$$\frac{d}{dx}\left[\frac{f(x)}{g(x)}\right] = \frac{f'(x)g(x) - f(x)g'(x)}{[g(x)]^2}$$

A common mnemonic: "low d-high minus high d-low, over low squared."

---

**Example 1.** Differentiate $h(x) = x^2 e^x$.

Let $f(x) = x^2$ and $g(x) = e^x$. Then $f'(x) = 2x$ and $g'(x) = e^x$.

$$h'(x) = 2x \cdot e^x + x^2 \cdot e^x = e^x(2x + x^2) = x e^x(x + 2)$$

---

**Example 2.** Differentiate $h(x) = \dfrac{x^2 + 1}{x - 3}$.

Let $f(x) = x^2 + 1$ and $g(x) = x - 3$. Then $f'(x) = 2x$ and $g'(x) = 1$.

$$h'(x) = \frac{2x(x-3) - (x^2+1)(1)}{(x-3)^2} = \frac{2x^2 - 6x - x^2 - 1}{(x-3)^2} = \frac{x^2 - 6x - 1}{(x-3)^2}$$

---

## 3. Derivatives of Trigonometric Functions

The six core trig derivatives. Knowing the first two well enough to derive the others is the goal.

$$\frac{d}{dx}[\sin x] = \cos x \qquad \frac{d}{dx}[\cos x] = -\sin x$$

$$\frac{d}{dx}[\tan x] = \sec^2 x \qquad \frac{d}{dx}[\cot x] = -\csc^2 x$$

$$\frac{d}{dx}[\sec x] = \sec x \tan x \qquad \frac{d}{dx}[\csc x] = -\csc x \cot x$$

Notice the pattern: the co-functions (cosine, cotangent, cosecant) all carry a negative sign.

---

**Example 1.** Differentiate $f(x) = x^2 \sin x$.

Product rule with $f(x) = x^2$ and $g(x) = \sin x$:

$$f'(x) = 2x \sin x + x^2 \cos x$$

---

**Example 2.** Differentiate $f(x) = \dfrac{\tan x}{1 + \cos x}$.

Quotient rule. Let $f = \tan x$, $g = 1 + \cos x$. Then $f' = \sec^2 x$, $g' = -\sin x$.

$$f'(x) = \frac{\sec^2 x (1 + \cos x) - \tan x (-\sin x)}{(1 + \cos x)^2}$$

$$= \frac{\sec^2 x (1 + \cos x) + \tan x \sin x}{(1 + \cos x)^2}$$

You can simplify further by writing $\tan x \sin x = \frac{\sin^2 x}{\cos x}$ and $\sec^2 x = \frac{1}{\cos^2 x}$, but the above form is already correct.

---

## 4. The Chain Rule

The chain rule handles composite functions — functions inside other functions.

If $y = f(g(x))$, then:

$$\frac{dy}{dx} = f'(g(x)) \cdot g'(x)$$

In words: differentiate the outer function (leaving the inner function alone), then multiply by the derivative of the inner function.

With Leibniz notation, if $y = f(u)$ and $u = g(x)$:

$$\frac{dy}{dx} = \frac{dy}{du} \cdot \frac{du}{dx}$$

This form makes it clear why it is called a chain — you multiply the rates of change along each link.

---

**Example 1.** Find $\frac{d}{dx}[\sin(x^3)]$.

Outer function: $\sin(\cdot)$, inner function: $x^3$.

$$\frac{d}{dx}[\sin(x^3)] = \cos(x^3) \cdot 3x^2 = 3x^2 \cos(x^3)$$

---

**Example 2.** Find $\frac{d}{dx}[(2x^2 + 5)^7]$.

Outer: $(\cdot)^7$, inner: $2x^2 + 5$.

$$\frac{d}{dx}[(2x^2+5)^7] = 7(2x^2+5)^6 \cdot 4x = 28x(2x^2+5)^6$$

---

## 5. How Derivatives Affect the Shape of a Graph

The derivative encodes information about the shape of $f$. These are the key connections.

**Increasing / Decreasing:**
- $f'(x) > 0$ on an interval means $f$ is increasing there.
- $f'(x) < 0$ means $f$ is decreasing.
- $f'(x) = 0$ or $f'(x)$ is undefined: these are critical numbers — candidates for local extrema.

**First Derivative Test:** At a critical number $c$:
- If $f'$ changes from positive to negative at $c$, then $f(c)$ is a local maximum.
- If $f'$ changes from negative to positive at $c$, then $f(c)$ is a local minimum.
- If $f'$ does not change sign, it is neither.

**Concavity:**
- $f''(x) > 0$: $f$ is concave up (curves like a cup). $f'$ is increasing.
- $f''(x) < 0$: $f$ is concave down. $f'$ is decreasing.

**Inflection Points:** Where concavity changes. Requires $f''(c) = 0$ or $f''(c)$ undefined, and a sign change in $f''$ on either side of $c$.

**Second Derivative Test:** At a critical number $c$ where $f'(c) = 0$:
- $f''(c) > 0$: local minimum.
- $f''(c) < 0$: local maximum.
- $f''(c) = 0$: inconclusive, fall back to the first derivative test.

---

**Example 1.** Let $f(x) = x^3 - 3x + 1$. Find intervals of increase/decrease and local extrema.

$f'(x) = 3x^2 - 3 = 3(x-1)(x+1)$

Critical numbers: $x = -1$ and $x = 1$.

Sign analysis of $f'$:
- $x < -1$: $f'(x) > 0$ (increasing)
- $-1 < x < 1$: $f'(x) < 0$ (decreasing)
- $x > 1$: $f'(x) > 0$ (increasing)

Local max at $x = -1$: $f(-1) = 3$. Local min at $x = 1$: $f(1) = -1$.

---

**Example 2.** For the same $f(x) = x^3 - 3x + 1$, find inflection points.

$f''(x) = 6x$

$f''(x) = 0$ at $x = 0$. Sign changes from negative (concave down) to positive (concave up) at $x = 0$.

Inflection point at $(0, 1)$.

---

## 6. Derivatives of Logarithmic Functions and Inverse Trig Functions

**Logarithmic Derivatives:**

$$\frac{d}{dx}[\ln x] = \frac{1}{x}, \quad x > 0$$

$$\frac{d}{dx}[\ln |x|] = \frac{1}{x}, \quad x \neq 0$$

$$\frac{d}{dx}[\log_a x] = \frac{1}{x \ln a}$$

**Logarithmic Differentiation** is useful when the function involves products, quotients, or variable exponents that would be messy to differentiate directly. Take $\ln$ of both sides, differentiate implicitly, then solve for $y'$.

**Inverse Trig Derivatives:**

$$\frac{d}{dx}[\arcsin x] = \frac{1}{\sqrt{1-x^2}} \qquad \frac{d}{dx}[\arccos x] = -\frac{1}{\sqrt{1-x^2}}$$

$$\frac{d}{dx}[\arctan x] = \frac{1}{1+x^2} \qquad \frac{d}{dx}[\text{arccot}\, x] = -\frac{1}{1+x^2}$$

$$\frac{d}{dx}[\text{arcsec}\, x] = \frac{1}{|x|\sqrt{x^2-1}} \qquad \frac{d}{dx}[\text{arccsc}\, x] = -\frac{1}{|x|\sqrt{x^2-1}}$$

Again, the co-versions carry a negative sign.

---

**Example 1.** Differentiate $f(x) = \ln(x^2 + 3)$.

Chain rule: outer is $\ln(\cdot)$, inner is $x^2 + 3$.

$$f'(x) = \frac{1}{x^2+3} \cdot 2x = \frac{2x}{x^2+3}$$

---

**Example 2.** Differentiate $f(x) = \arctan(3x)$.

Chain rule: outer is $\arctan(\cdot)$, inner is $3x$.

$$f'(x) = \frac{1}{1+(3x)^2} \cdot 3 = \frac{3}{1+9x^2}$$

---

## 7. Rates of Change in Natural and Social Sciences

The derivative $\frac{dy}{dx}$ is a rate of change. The specific meaning depends on context.

**Physics / Natural Sciences:**
- Position $s(t)$: velocity is $v(t) = s'(t)$, acceleration is $a(t) = v'(t) = s''(t)$.
- Speed is $|v(t)|$. The object speeds up when velocity and acceleration have the same sign; slows down when they differ.

**Biology:** If $P(t)$ is a population at time $t$, then $P'(t)$ is the growth rate. If $P'(t) > 0$, the population is growing; if $P'(t) < 0$, it is shrinking.

**Economics:**
- If $C(x)$ is the cost of producing $x$ units, then $C'(x)$ is the **marginal cost** — the approximate cost of producing one more unit.
- Similarly, **marginal revenue** is $R'(x)$ and **marginal profit** is $P'(x) = R'(x) - C'(x)$.

The key insight across all these contexts: the derivative tells you the instantaneous rate of change of one quantity with respect to another.

---

**Example 1.** A particle moves along a line with position $s(t) = t^3 - 6t^2 + 9t + 2$ (in metres, $t$ in seconds). Find the velocity and acceleration at $t = 2$.

$$v(t) = s'(t) = 3t^2 - 12t + 9$$

$$a(t) = v'(t) = 6t - 12$$

At $t = 2$: $v(2) = 12 - 24 + 9 = -3$ m/s. $a(2) = 12 - 12 = 0$ m/s².

The particle is moving in the negative direction at $t = 2$, and at that exact moment its velocity is neither increasing nor decreasing.

---

**Example 2.** A company's cost function is $C(x) = 0.01x^2 + 4x + 500$ dollars, where $x$ is units produced. Find the marginal cost at $x = 100$.

$$C'(x) = 0.02x + 4$$

$$C'(100) = 0.02(100) + 4 = 2 + 4 = \$6 \text{ per unit}$$

The 101st unit costs approximately 6 dollars to produce. Compare this to the actual cost: $C(101) - C(100) = 6.01$, so the approximation is tight.

---

## 8. Linear Approximation and Differentials

**Linear Approximation (Tangent Line Approximation):**

Near $x = a$, a differentiable function $f$ looks like its tangent line:

$$f(x) \approx f(a) + f'(a)(x - a)$$

This is called the **linearization** of $f$ at $a$, often written $L(x) = f(a) + f'(a)(x-a)$.

It works well when $x$ is close to $a$. The further you move from $a$, the worse the approximation.

**Differentials:**

If $y = f(x)$, the differential $dy$ is defined as:

$$dy = f'(x)\,dx$$

Here $dx$ is an independent variable (a small change in $x$), and $dy$ is the corresponding change in $y$ predicted by the tangent line. The actual change in $y$ is $\Delta y = f(x + dx) - f(x)$. When $dx$ is small, $dy \approx \Delta y$.

Differentials are useful for approximating errors. If $x$ is measured with a small error $dx$, then the propagated error in $y$ is approximately $dy = f'(x)\,dx$.

---

**Example 1.** Use linear approximation to estimate $\sqrt{9.04}$.

Let $f(x) = \sqrt{x}$, and approximate near $a = 9$ (since $\sqrt{9} = 3$).

$$f'(x) = \frac{1}{2\sqrt{x}}, \quad f'(9) = \frac{1}{6}$$

$$L(x) = 3 + \frac{1}{6}(x - 9)$$

$$L(9.04) = 3 + \frac{1}{6}(0.04) = 3 + 0.00\overline{6} \approx 3.0067$$

The actual value is $\sqrt{9.04} \approx 3.00666$. The approximation is accurate to 5 significant figures.

---

**Example 2.** The radius of a sphere is measured as 5 cm with a possible error of $\pm 0.02$ cm. Use differentials to estimate the maximum error in the calculated volume.

Volume: $V = \frac{4}{3}\pi r^3$, so $\frac{dV}{dr} = 4\pi r^2$.

$$dV = 4\pi r^2 \, dr = 4\pi (5)^2 (0.02) = 4\pi (25)(0.02) = 2\pi \approx 6.28 \text{ cm}^3$$

The maximum error in the volume is approximately $6.28$ cm$^3$. The relative error is $\frac{dV}{V} = \frac{2\pi}{\frac{4}{3}\pi(125)} = \frac{2}{\frac{500}{3}} = \frac{6}{500} = 1.2\%$.

---

*These notes cover the differentiation rules typically encountered in a first-year calculus course. For a deeper treatment of any section, Stewart's Calculus is worth having on your desk.*
