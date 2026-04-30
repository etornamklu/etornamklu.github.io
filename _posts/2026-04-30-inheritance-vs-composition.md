---
layout: post
title: "Inheritance vs Composition: The Trial"
date: 2026-04-30
categories: interviews
---

*Composition made a brief appearance in my [OOP pillars post](/interviews/2026/04/30/oop-pillars-interview.html), dropped one line, and walked out before Inheritance could respond. I thought that was unfair. So I gave them a proper room, a proper format, and told them both to make their case.*

*The charges: that Inheritance creates tight coupling, encourages fragile designs, and is routinely used in situations where Composition would have been the better choice. Inheritance has entered a plea of not guilty.*

*I'll be presiding.*

---

## The Court Is in Session

**Judge:** Before we begin, each of you state what you do for the record.

**Inheritance:** I allow one class to build on another. When you have a `Car` and need an `ElectricCar`, you extend `Car`. The subclass gets everything the parent established and adds what's new. The relationship is enforced by the language: an `ElectricCar` *is a* `Car`, and the compiler knows it.

**Composition:** I allow one class to *use* another. Instead of `ElectricCar` extending `Car`, it holds an `Engine` object, a `Battery` object, a `GearBox`. It's assembled from parts. No parent required.

**Inheritance:** No identity either. Just a bag of objects with no lineage.

**Composition:** A bag of objects you can swap at any time without rewriting the family tree.

**Judge:** We'll get to the swapping. Prosecution, your opening statement.

---

## Opening Statement for the Prosecution

**Composition:** Your Honor, the case is straightforward. Inheritance makes a promise it frequently cannot keep. It tells you that a subclass *is a* parent, that the relationship is stable, that changes to the parent won't cause unexpected behaviour downstream. In practice, that promise breaks. Developers change a parent class in one place and silently break five subclasses. They build deep hierarchies that become impossible to reason about. They use inheritance not because a genuine "is-a" relationship exists, but because it's the first tool they reach for.

I offer flexibility instead. Compose a class from the behaviours it needs. Swap those behaviours independently. Add new ones without touching anything that already works. The prosecution's position is that this is almost always the better default.

**Judge:** Noted. Defense.

---

## Opening Statement for the Defense

**Inheritance:** Your Honor, I am being charged for how people misuse me, not for what I actually am. When a genuine "is-a" relationship exists, I am not just convenient. I am correct. A `SavingsAccount` *is an* `Account`. A `Dog` *is an* `Animal`. An `AdminUser` *is a* `User`. In those cases, the subclass should be substitutable for the parent anywhere the parent is expected. That substitutability is not just a design nicety. It is the foundation of polymorphism. The prosecution would have you compose everything and call it flexibility. I would ask: flexible toward what, exactly?

```java
class User {
    protected String name;
    protected String email;

    public void login() {
        System.out.println(name + " logged in.");
    }
}

class AdminUser extends User {
    public void deleteUser(User user) {
        System.out.println(name + " deleted " + user.name);
    }
}

// Works cleanly because AdminUser IS a User
User u = new AdminUser();
u.login();
```

The Liskov Substitution Principle says: if `S` is a subtype of `T`, you should be able to use `S` wherever `T` is expected without breaking anything. I make that possible. Composition does not.

---

## The Prosecution's Case: Exhibit A

**Judge:** Prosecution, present your evidence.

**Composition:** Exhibit A. The fragile base class problem.

```java
class Car {
    protected int speed = 0;

    public void accelerate() {
        speed += 10;
        logSpeed();  // added later, seemed harmless
    }

    private void logSpeed() {
        System.out.println("Speed logged: " + speed);
    }
}

class SportsCar extends Car {
    @Override
    public void accelerate() {
        super.accelerate();  // calls logSpeed() now, whether SportsCar wants it or not
        speed += 20;
    }
}
```

`SportsCar` did not ask for logging. It got it anyway. A developer added `logSpeed()` to `Car` because it seemed useful. `SportsCar` was not consulted. `SportsCar` had no say. That is what tight coupling looks like in practice. A change in the parent silently changed the behaviour of a subclass that had nothing to do with it.

**Judge:** Defense, respond.

**Inheritance:** That is a legitimate problem caused by a specific mistake: `SportsCar` calls `super.accelerate()` without knowing what it does. The fix is straightforward. Document what the parent method does. Override fully when necessary. Do not expose internal methods as part of the inheritance contract if subclasses shouldn't rely on them. This is bad inheritance. It is not an argument against inheritance.

**Composition:** The point is that the coupling makes this mistake easy to make and hard to catch. With composition, there is no `super`. The engine is injected. If you want different logging behaviour, you inject a different engine.

```java
class Engine {
    public void start() {
        System.out.println("Engine running.");
    }
}

class LoggingEngine {
    public void start() {
        System.out.println("Engine running.");
        System.out.println("Speed logged.");
    }
}

class Car {
    private Engine engine;

    public Car(Engine engine) {
        this.engine = engine;
    }

    public void accelerate() {
        engine.start();
    }
}

// Two different behaviours, zero changes to Car
Car standard = new Car(new Engine());
Car logged = new Car(new LoggingEngine());
```

`Car` does not change. The engine changes. Nothing breaks.

---

## Cross-Examination

**Judge:** Prosecution, the defense raised Liskov. A composed `Car` is not a subtype of anything. How do you handle substitutability?

**Composition:** Through interfaces. Define a `Driveable` interface with `accelerate()` and `brake()`. Any class that implements it is substitutable. You get the polymorphism without the inheritance tax.

```java
interface Driveable {
    void accelerate();
    void brake();
}

class Car implements Driveable {
    private Engine engine;

    public Car(Engine engine) {
        this.engine = engine;
    }

    public void accelerate() { engine.start(); }
    public void brake() { System.out.println("Braking."); }
}

class ElectricCar implements Driveable {
    private ElectricMotor motor;

    public ElectricCar(ElectricMotor motor) {
        this.motor = motor;
    }

    public void accelerate() { motor.start(); }
    public void brake() { System.out.println("Regenerative braking."); }
}

// Polymorphism without inheritance
List<Driveable> vehicles = new ArrayList<>();
vehicles.add(new Car(new Engine()));
vehicles.add(new ElectricCar(new ElectricMotor()));

for (Driveable v : vehicles) {
    v.accelerate();
}
```

**Judge:** Defense, your response.

**Inheritance:** That works for behaviour. It does not capture the relationship. An `ElectricCar` is not merely something that can be driven. It is a car. That distinction matters when the codebase grows and other systems need to know what type a thing actually is, not just what it can do.

**Composition:** In most systems, what a thing can do is exactly what other code needs to know. The type identity is a smaller concern than people think.

**Inheritance:** In most systems you've designed, perhaps.

---

## Closing Arguments

**Judge:** Each of you, final statement.

**Composition:** Your Honor, I am not asking you to never use Inheritance. I am asking you to pause before you reach for it. Ask whether the "is-a" relationship is genuine or whether you are just trying to share some behaviour. If it's the latter, I am the right answer. The Gang of Four said it plainly: favour composition over inheritance. That advice exists because the default is wrong more often than people admit.

**Inheritance:** Your Honor, I am the right tool when the relationship is real. A `Shape` and a `Circle`. A `Vehicle` and a `Truck`. A `User` and an `AdminUser`. Deep, stable hierarchies of genuinely related types. Composition in those cases adds structure without adding meaning. I do not ask to be used everywhere. I ask to be used where I belong, and to be judged by correct usage rather than by the mistakes of developers who extended when they should have composed.

---

## The Verdict

**Judge:** Both arguments are sustained.

The advice to favour Composition is a default, not a verdict. It exists because the "is-a" relationship is rarer than it appears, and because Inheritance is the first tool most developers reach for regardless. When the relationship is shallow, volatile, or behavioural rather than structural, Composition is the right call.

When the relationship is genuine and stable, Inheritance is not just acceptable. It is precise.

The question to ask before either decision: **is-a or has-a?**

| | Inheritance | Composition |
|---|---|---|
| Relationship | "is-a" | "has-a" |
| Coupling | Tight (subclass bound to parent) | Loose (parts are swappable) |
| Flexibility | Lower (hierarchy is fixed) | Higher (behaviours change independently) |
| Best for | Stable, genuine type hierarchies | Behaviour that varies independently |
| Risk | Fragile base class problem | More objects to wire up upfront |

If you find yourself overriding most of what the parent provides, the inheritance relationship was never real. That is the clearest sign to reach for Composition instead.

Court adjourned.

---

*No concepts were held in contempt. Inheritance and Composition declined to comment on the way out.*
