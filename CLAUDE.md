# Blog Configuration

## About the Blog

Personal blog by Alfred Etornam Klu. Posts cover software engineering, payment systems, risk systems, finance, systems programming, and concurrency. Not limited to technical topics.

The writing tone is direct and educational. No em dashes. No excessive formatting. Prose over bullet points. Analogies are welcome. The goal is to explain things clearly, not to sound impressive.

The blog runs on Jekyll with a custom layout. Categories map to nav pages.

---

## Navigation Structure

- **Home** — recent posts
- **About** — about Alfred
- **Tech** — standard tech writing
- **Interviews** — concept interview format posts (see below)
- **Archive** — all posts

---

## Categories

- `tech` — software engineering posts, walkthroughs, explanations
- `interviews` — posts written in one of the concept formats below

---

## The Interview Format

Inspired by the Head First books, which were Alfred's first programming books (Head First HTML, then Python, JavaScript, Go, SQL). Head First interviews concepts as if they were people — each concept gets a personality, a perspective, and occasionally some beef with others.

The Interviews nav section carries this description so individual posts don't need to repeat the Head First backstory.

Posts in this format use `**Me:**` for Alfred's voice, not `**Interviewer:**`.

The format is not limited to tech topics.

---

## Available Settings

These are the formats available for interview-style posts. Each suits different types of content.

### Interview
The default format. Concepts seated in a room, introduced one at a time. Alfred asks questions, each concept explains itself and takes the occasional dig at the others. Good for introducing multiple related concepts and giving each a distinct personality.

*Used in: "I Interviewed the Four Pillars of OOP"*

Best for: introducing 2-4 concepts, giving each a voice, showing how they relate.

---

### Courtroom
One concept is on trial. Another is prosecuting. Alfred presides as Judge. Evidence is presented as exhibits. Ends with a verdict. Good when there is a genuine dispute between two approaches and one is frequently misused or accused of causing problems.

*Used in: "Inheritance vs Composition: The Trial"*

Best for: two concepts with real beef, one defending itself against specific charges, cases where both sides have a legitimate argument.

---

### Panel Discussion
Multiple concepts seated together, responding to each other in real time. No one-at-a-time structure — they interrupt, agree, disagree. Good when three or more ideas all intersect and you want them pushing back on each other, not just taking turns.

Best for: 3+ concepts that all touch the same problem, nuanced debates where the answer isn't binary.

---

### Job Interview
A concept applying for a role, being grilled on its qualifications and weaknesses. Good for design patterns, data structures, or language features that need to justify their existence in a specific context.

Example framing: "So, why should I use a HashMap here?"

Best for: a single concept defending its usefulness, posts where the question is "when do I actually reach for this?"

---

### Therapy Session
A concept working through its issues with a therapist. Good for things with genuine flaws or identity crises — things that know they cause problems. Mutable state. Global variables. The `null` type.

Best for: concepts that are widely used but widely criticised, posts that are honest about tradeoffs and problems.

---

### Debate
Two concepts given equal time to make their case. No cross-examination, no judge. Structured arguments, clean format. Good when both sides are genuinely valid and you don't want either framed as the defendant.

Best for: genuinely even disagreements, posts where the conclusion is "it depends" and you want to lay out both sides fairly.

---

### Post-Mortem / Incident Review
Concepts explaining what went wrong after a failure. The format of an engineering post-mortem: timeline, contributing factors, what each party did. Good for bugs, outages, or bad design decisions told from the inside.

Example framing: "Walk us through what happened on the night of the deadlock."

Best for: concurrency bugs, system failures, bad architectural decisions — especially strong given Alfred's interests in concurrency and systems programming.

---

### Press Conference
A concept just released or updated, fielding questions from a skeptical room. Good for new or controversial things: a language feature, a framework, an architectural pattern someone keeps arguing about.

Best for: announcing or defending something new, posts written from the perspective of a decision that needs to justify itself to a room of doubters.

---

## Existing Interview Posts

1. **I Interviewed the Four Pillars of OOP** (`/interviews/2026/04/30/oop-pillars-interview.html`)
   Abstraction, Encapsulation, Inheritance, Polymorphism — all explaining their contribution to a `Car` object. Abstraction and Encapsulation have beef. Composition makes a cameo at the end and links to post 2.

2. **Inheritance vs Composition: The Trial** (`/interviews/2026/04/30/inheritance-vs-composition.html`)
   Courtroom format. Composition prosecutes Inheritance on charges of tight coupling and fragile base classes. Inheritance defends itself. Verdict: both have their place, but the default should be Composition.

---

## Style Notes

- No em dashes anywhere, including in code comments
- `**Me:**` not `**Interviewer:**`
- Each concept introduces itself before questions begin
- Concepts have distinct personalities but the interviewer/judge voice matches the blog tone: direct, curious, educational, dry
- Scene-setting in italics before each section
- Closing footnote in italics, usually a one-liner about what happened after
- The Head First backstory lives on the Interviews page, not in individual posts
