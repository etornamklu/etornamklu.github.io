---
layout: post
title: "Calculus Exam Revision: Limits, Derivatives, and Integrals"
date: 2026-06-24
categories: tech
math: true
---

This is a compact exam recap of limits, differentiation rules, implicit differentiation, applications of derivatives, antiderivatives, integrals, and both parts of the Fundamental Theorem of Calculus. Each section includes a worked example and the main idea to remember under exam pressure.

---

## 1. Limits and Derivatives

A **limit** describes the value a function approaches as $x$ approaches a number. Start every limit by trying direct substitution.

If substitution gives an ordinary number, that is the limit. If it gives an indeterminate form such as $\frac{0}{0}$, simplify the expression by factoring, rationalizing, or using another suitable method.

The derivative is defined using a limit:

$$f'(x)=\lim_{h\to 0}\frac{f(x+h)-f(x)}{h}$$

It represents the instantaneous rate of change of $f$ and the slope of the tangent line to its graph.

**Example 1: Evaluate a limit.**

$$\lim_{x\to 3}\frac{x^2-9}{x-3}$$

Direct substitution gives $\frac{0}{0}$, so factor the numerator:

$$\frac{x^2-9}{x-3}=\frac{(x-3)(x+3)}{x-3}=x+3 \qquad (x\neq 3)$$

Therefore:

$$\lim_{x\to 3}\frac{x^2-9}{x-3}=3+3=6$$

The original function is undefined at $x=3$, but the limit still exists because the nearby values approach 6.

**Example 2: Use the definition of the derivative.**

Let $f(x)=x^2$. Then:

$$f'(x)=\lim_{h\to 0}\frac{(x+h)^2-x^2}{h}$$

Expand and simplify:

$$f'(x)=\lim_{h\to 0}\frac{x^2+2xh+h^2-x^2}{h}$$

$$=\lim_{h\to 0}(2x+h)=2x$$

So the slope of $f(x)=x^2$ at any $x$ is $2x$.

---

## 2. Differentiation Rules

The essential rules are:

**Power Rule**

$$\frac{d}{dx}(x^n)=nx^{n-1}$$

**Product Rule**

$$\frac{d}{dx}[f(x)g(x)]=f'(x)g(x)+f(x)g'(x)$$

**Quotient Rule**

$$\frac{d}{dx}\left[\frac{f(x)}{g(x)}\right]
=\frac{f'(x)g(x)-f(x)g'(x)}{[g(x)]^2}$$

**Chain Rule**

$$\frac{d}{dx}[f(g(x))]=f'(g(x))g'(x)$$

Useful basic derivatives:

$$\frac{d}{dx}(e^x)=e^x, \qquad
\frac{d}{dx}(\ln x)=\frac{1}{x}$$

$$\frac{d}{dx}(\sin x)=\cos x, \qquad
\frac{d}{dx}(\cos x)=-\sin x$$

**Example 1: Product rule.** Differentiate $f(x)=x^2e^x$.

$$f'(x)=2xe^x+x^2e^x$$

$$f'(x)=e^x(x^2+2x)$$

**Example 2: Chain rule.** Differentiate $g(x)=(3x^2+1)^5$.

Differentiate the outer power, then multiply by the derivative of the inside:

$$g'(x)=5(3x^2+1)^4(6x)$$

$$g'(x)=30x(3x^2+1)^4$$

**Exam trap:** Do not forget the derivative of the inner function when using the chain rule.

---

## 3. Implicit Differentiation

Use implicit differentiation when $x$ and $y$ appear together and solving for $y$ first would be difficult. Treat $y$ as a function of $x$, so differentiating a term involving $y$ produces a factor of $\frac{dy}{dx}$.

For example:

$$\frac{d}{dx}(y^n)=ny^{n-1}\frac{dy}{dx}$$

**Example.** Find $\frac{dy}{dx}$ if:

$$x^2+xy+y^2=7$$

Differentiate both sides with respect to $x$. The term $xy$ requires the product rule:

$$2x+\left(x\frac{dy}{dx}+y\right)+2y\frac{dy}{dx}=0$$

Group the terms containing $\frac{dy}{dx}$:

$$x\frac{dy}{dx}+2y\frac{dy}{dx}=-2x-y$$

Factor and solve:

$$(x+2y)\frac{dy}{dx}=-2x-y$$

$$\boxed{\frac{dy}{dx}=-\frac{2x+y}{x+2y}}$$

At the point $(1,2)$, the slope is:

$$\frac{dy}{dx}=-\frac{2(1)+2}{1+2(2)}=-\frac{4}{5}$$

---

## 4. Critical Numbers and Local Extrema

A **critical number** is a value $c$ in the domain of $f$ where:

$$f'(c)=0$$

or $f'(c)$ does not exist.

Critical numbers are candidates for local maxima and minima, but a critical number is not automatically an extremum.

Use the **First Derivative Test**:

- If $f'$ changes from positive to negative, $f$ has a local maximum.
- If $f'$ changes from negative to positive, $f$ has a local minimum.
- If $f'$ does not change sign, the point is neither.

**Example.** Find the local extrema of:

$$f(x)=x^3-3x^2-9x+5$$

Differentiate and factor:

$$f'(x)=3x^2-6x-9=3(x-3)(x+1)$$

The critical numbers are $x=-1$ and $x=3$.

The sign of $f'$ is:

- Positive on $(-\infty,-1)$
- Negative on $(-1,3)$
- Positive on $(3,\infty)$

Therefore, $x=-1$ is a local maximum and $x=3$ is a local minimum.

$$f(-1)=-1-3+9+5=10$$

$$f(3)=27-27-27+5=-22$$

The local maximum is $(-1,10)$, and the local minimum is $(3,-22)$.

---

## 5. Absolute Maximum and Minimum Values

On a closed interval $[a,b]$, use the **Closed Interval Method**:

1. Find the critical numbers inside $(a,b)$.
2. Evaluate $f$ at every critical number and both endpoints.
3. Compare the results. The greatest value is the absolute maximum, and the least is the absolute minimum.

**Example from the revision page.** Find the absolute maximum and minimum of:

$$f(x)=3x^2-12x+5$$

on $[0,3]$.

First find the critical numbers:

$$f'(x)=6x-12$$

$$6x-12=0 \Rightarrow x=2$$

Now test the two endpoints and the critical number:

$$f(0)=5$$

$$f(2)=3(2)^2-12(2)+5=-7$$

$$f(3)=3(3)^2-12(3)+5=-4$$

Therefore:

- The absolute maximum value is $5$ at $x=0$.
- The absolute minimum value is $-7$ at $x=2$.

**Exam trap:** Endpoints can be absolute extrema even though they are not found by solving $f'(x)=0$.

---

## 6. Antiderivative Rules

An **antiderivative** reverses differentiation. A function $F$ is an antiderivative of $f$ if:

$$F'(x)=f(x)$$

The main power rule is:

$$\int x^n\,dx=\frac{x^{n+1}}{n+1}+C, \qquad n\neq -1$$

Other useful rules include:

$$\int \frac{1}{x}\,dx=\ln|x|+C$$

$$\int e^x\,dx=e^x+C$$

$$\int \cos x\,dx=\sin x+C$$

$$\int \sin x\,dx=-\cos x+C$$

**Example.** Find the general antiderivative of:

$$f(x)=6x^2-4x+3$$

Integrate term by term:

$$\int(6x^2-4x+3)\,dx
=2x^3-2x^2+3x+C$$

Differentiate the result to check:

$$\frac{d}{dx}(2x^3-2x^2+3x+C)=6x^2-4x+3$$

**Exam trap:** Always include $C$ for an indefinite integral because infinitely many functions have the same derivative.

---

## 7. Indefinite Integrals

An indefinite integral represents the whole family of antiderivatives:

$$\int f(x)\,dx=F(x)+C$$

If an initial condition is given, use it to find $C$.

**Example.** Find $F(x)$ if:

$$F'(x)=3x^2-4x, \qquad F(1)=5$$

First integrate:

$$F(x)=x^3-2x^2+C$$

Use $F(1)=5$:

$$5=1^3-2(1)^2+C$$

$$5=-1+C \Rightarrow C=6$$

Therefore:

$$\boxed{F(x)=x^3-2x^2+6}$$

---

## 8. Definite Integrals and Net Area

A definite integral gives a number:

$$\int_a^b f(x)\,dx$$

Geometrically, it represents **net signed area** between the graph and the $x$-axis. Area above the axis is positive; area below it is negative.

Important properties:

$$\int_a^a f(x)\,dx=0$$

$$\int_a^b f(x)\,dx=-\int_b^a f(x)\,dx$$

$$\int_a^b f(x)\,dx+\int_b^c f(x)\,dx=\int_a^c f(x)\,dx$$

**Example.** Evaluate:

$$\int_0^2(3x^2+1)\,dx$$

An antiderivative is $x^3+x$. Therefore:

$$\int_0^2(3x^2+1)\,dx=[x^3+x]_0^2$$

$$=(2^3+2)-(0^3+0)=10$$

---

## 9. Fundamental Theorem of Calculus, Part 1

Part 1 connects accumulation with differentiation. If:

$$G(x)=\int_a^x f(t)\,dt$$

and $f$ is continuous, then:

$$G'(x)=f(x)$$

With a function in the upper limit, use the chain rule:

$$\frac{d}{dx}\left[\int_a^{g(x)}f(t)\,dt\right]=f(g(x))g'(x)$$

**Example 1.** Find $G'(x)$ if:

$$G(x)=\int_1^x(t^3+2t)\,dt$$

By Part 1 of the Fundamental Theorem:

$$\boxed{G'(x)=x^3+2x}$$

**Example 2.** Find $H'(x)$ if:

$$H(x)=\int_0^{x^2}\cos t\,dt$$

Evaluate the integrand at $t=x^2$, then multiply by the derivative of $x^2$:

$$\boxed{H'(x)=2x\cos(x^2)}$$

---

## 10. Fundamental Theorem of Calculus, Part 2

Part 2 gives a practical way to evaluate definite integrals. If $F'(x)=f(x)$, then:

$$\int_a^b f(x)\,dx=F(b)-F(a)$$

**Example.** Evaluate:

$$\int_1^3(2x+4)\,dx$$

An antiderivative is:

$$F(x)=x^2+4x$$

Apply the bounds:

$$\int_1^3(2x+4)\,dx=[x^2+4x]_1^3$$

$$=(9+12)-(1+4)=21-5=16$$

Unlike an indefinite integral, a definite integral does not need $+C$ because the constants cancel in $F(b)-F(a)$.

---

## Final Exam Checklist

Before finishing a calculus problem, ask:

- Did I try direct substitution for the limit first?
- Did I choose the correct differentiation rule?
- Did I include $\frac{dy}{dx}$ when differentiating a $y$-term?
- Did I check every critical number and endpoint for absolute extrema?
- Did I include $+C$ for an indefinite integral?
- Did I apply the chain rule when an integral has a variable upper limit?
- Did I compute $F(b)-F(a)$ in the correct order?

The quickest way to revise these topics is to cover the solution, work each example independently, and then explain why every step is valid. If you can explain the method without looking at the notes, you are ready to use it in the exam.
