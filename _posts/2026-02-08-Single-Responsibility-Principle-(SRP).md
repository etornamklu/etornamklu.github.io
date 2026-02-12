---
layout: post
title: "Single Responsibility Principle (SRP)"
date: 2026-02-08
categories: design-patterns
---

> Part of the **SOLID** principles — a set of 5 guidelines for writing clean, maintainable code.

---

## Core Idea

**A class should have only one reason to change.**

In plain terms: each class should do *one thing* and own *one responsibility*. If a class is doing multiple unrelated jobs, it becomes harder to maintain, test, and update over time.

> **Note:** SRP doesn't mean a class can only have *one method*. It means all the methods inside a class should serve the **same single purpose**.

---

## Real-World Analogy

Think of a restaurant kitchen. You wouldn't want your **chef** to also take orders, handle billing, and clean tables.

- If the billing system changes → the chef shouldn't be affected
- If the cleaning schedule changes → the chef shouldn't be affected

Each staff member has **one clear job title**. SRP says your classes should work the same way.

---

## Why It Matters

Without SRP, a single class can end up doing too many things. This causes:

- **Fragility** — a small change in one method risks breaking others
- **Hard to test** — changing anything means retesting the whole class
- **Hard to maintain** — unrelated logic is tangled together
- **Hard to reuse** — you can't reuse one part without dragging the rest along

---

## Code Example

### ❌ Bad — Violates SRP

The `Employee` class below does three completely different jobs:

```java
class Employee {
    public String firstName, lastName, empId;
    public double experienceInYears;

    // Job 1: Display employee info
    public void displayEmpDetail() {
        System.out.println("The employee name: " + lastName + ", " + firstName);
        System.out.println("Experience: " + experienceInYears + " years.");
    }

    // Job 2: Generate an employee ID
    public String generateEmpId(String empFirstName) {
        int random = new Random().nextInt(1000);
        return empFirstName.substring(0, 1) + random;
    }

    // Job 3: Check seniority level
    public String checkSeniority(double experienceInYears) {
        return experienceInYears > 5 ? "senior" : "junior";
    }
}
```

**The problem:** If management wants to change the seniority rules *or* use a new ID format, you must modify `Employee` — even though those changes have nothing to do with displaying employee details. Every change risks breaking something else.

---

### ✅ Good — Follows SRP

Split the three jobs into three separate classes:

```java
// Responsibility 1: Store and display employee data
class Employee {
    public String firstName, lastName;
    public double experienceInYears;

    public void displayEmpDetail() {
        System.out.println("Name: " + lastName + ", " + firstName);
        System.out.println("Experience: " + experienceInYears + " years.");
    }
}

// Responsibility 2: Generate employee IDs
class EmployeeIdGenerator {
    public String generateEmpId(String empFirstName) {
        int random = new Random().nextInt(1000);
        return empFirstName.substring(0, 1) + random;
    }
}

// Responsibility 3: Determine seniority level
class SeniorityChecker {
    public String checkSeniority(double experienceInYears) {
        return experienceInYears > 5 ? "senior" : "junior";
    }
}
```

**Now each class has one reason to change:**

| Class | Only changes if... |
|---|---|
| `Employee` | The way employee info is stored or displayed changes |
| `EmployeeIdGenerator` | The ID generation algorithm changes |
| `SeniorityChecker` | The seniority criteria changes |

---

## Common Mistakes to Avoid

**1. Confusing SRP with "one method per class"**
SRP is about *one reason to change*, not one method. A class can have many methods as long as they all serve the same purpose.

**2. Making classes too granular**
Splitting every single line of code into its own class is overkill. Ask yourself: *"Do these methods change for the same reason?"* If yes, they belong together.

**3. Putting unrelated utilities in one "helper" class**
A catch-all `Utils` or `Helper` class that does everything is a common SRP violation. Group utilities by what they relate to instead.

**4. Letting a class grow over time without refactoring**
Classes often start simple and gradually take on new responsibilities. Revisit your classes as requirements grow.

---

## Key Takeaway

> **"A class should have only one reason to change."** — Robert C. Martin

When you follow SRP:
- Code is **smaller** and **cleaner**
- Changes are **isolated** — fixing one thing doesn't break another
- Classes are **easier to test** individually
- Code is **easier to reuse** in other projects

A simple way to apply it: *if you're struggling to name a class because it does too many things, that's a sign it needs to be split up.*
