---
layout: post
title: "Four Pillars of OOP."
date: 2026-04-30
categories: in-session
---

*I sat down with Abstraction, Encapsulation, Inheritance, and Polymorphism to talk about one thing: how each of them contributed to building a `Car` object. They were all already seated when I arrived. Abstraction and Encapsulation were not making eye contact.*

---

## Abstraction

*Already mid-thought when I sit down. Has clearly been waiting.*

**Me:** Why don't you start by introducing yourself.

**Abstraction:** I'm the one who decides what a thing looks like from the outside. Not what it does internally, not how it works under the hood. Just what you need to see in order to use it. With a `Car`, that means I ask: what does the person driving this car actually need? They need to `accelerate()`, they need to `brake()`, they need to `refuel()`. They do not need to know how combustion works. I make that distinction.

```java
abstract class Car {
    // What the outside world needs
    public abstract void accelerate();
    public abstract void brake();
    public abstract void refuel();

    // The "what", not the "how"
}
```

**Me:** Some people describe that as hiding things.

**Abstraction:** I'd say it's more about surfacing what's relevant. There's a difference. A car has a steering wheel, a pedal, and a gear. It does not have a dashboard full of combustion data. I gave the `Car` class its public interface because that's what enables everyone else to work with it cleanly. The complexity exists. I just decide it doesn't need to be your problem.

**Me:** What if someone says you're just deferring the hard work?

**Abstraction:** Then I'd ask them to show me their code. Usually that answers the question.

**Me:** People mix you up with Encapsulation a lot. Does that bother you?

**Abstraction:** *(sets down coffee)* It bothers me because the confusion is understandable but also completely avoidable. We are not the same thing. I am a *design decision*. I look at a complex system and ask: what should the user of this thing even think about? That is a question of intent. Encapsulation is a mechanism. It's the lock. I'm the decision about which rooms to build in the first place.

**Me:** How would you describe the difference in one sentence?

**Abstraction:** I decide *what* to show. Encapsulation enforces *that* you can't see the rest. One is design, the other is implementation. They cooperate, but they are not the same thought.

*From across the room, Encapsulation looks up.*

---

## Encapsulation

*Sitting upright. Has been listening the whole time.*

**Me:** Go ahead and introduce yourself.

**Encapsulation:** I protect the internals. Abstraction decided what you need to see. I make sure that what you *don't* need to see stays out of reach. In the `Car`, things like `fuelLevel` and `speed` are private. You can't set them directly. If you want fuel, you call `refuel()`. If you want to go faster, you call `accelerate()`. I control what comes in and what goes out.

```java
class Car {
    private String model;
    private int speed;
    private double fuelLevel;  // nobody sets this directly

    public double getFuelLevel() {
        return fuelLevel;
    }

    public void refuel(double amount) {
        if (amount > 0 && fuelLevel + amount <= 100) {
            fuelLevel += amount;
        }
        // Bad values? Rejected. Quietly. Professionally.
    }

    public void accelerate() {
        if (fuelLevel > 0) {
            speed += 10;
            fuelLevel -= 0.5;
        }
    }
}
```

**Me:** What actually goes wrong when people skip you?

**Encapsulation:** You get a `Car` with `-500` fuel. You get speed values that nobody intentionally set. You get a system that passes every test and then breaks in production because something external reached in and changed a field directly. None of those bugs are dramatic. They're just quietly wrong until they aren't quiet anymore.

**Me:** Abstraction just said you're a mechanism. That the real thinking is theirs.

**Encapsulation:** *(slowly)* A mechanism. Right. So when `fuelLevel` is private and `refuel()` validates input before writing anything, that's just a mechanism. When the `Car` can guarantee its own state is always valid regardless of what the rest of the codebase tries to do to it, that's just a mechanism. Fine. Without my mechanism, Abstraction's clean interface is decoration. A well-named method that any class can bypass is not a design. It's a suggestion.

**Me:** But they have a point that you're different things, right? That the confusion between you two isn't really a mix-up, it's just that you work so closely together?

**Encapsulation:** We do work closely together. But "working closely together" is not the same as "being the same thing." Abstraction looks at a car and says the driver should think about pedals and a wheel, not pistons and injectors. That's a design choice. I'm the one who actually makes the engine unreachable. Both matter. Neither replaces the other.

*Abstraction nods, just barely.*

---

## A note on the two of them

This is where a lot of people get tripped up, so it's worth being direct about it.

Abstraction is about **what** you expose. It's the decision that a `Car` user should think in terms of `accelerate()` and `brake()`, not in terms of fuel injection and rotational force. It operates at the level of intent.

Encapsulation is about **how** you protect what you chose not to expose. It's the `private` keyword. It's the setter that validates before writing. It's the getter that returns what you need without giving access to the underlying field. It's enforcement.

You need both. Abstraction without Encapsulation is a clean interface with nothing preventing misuse. Encapsulation without Abstraction is access control on a class nobody thought carefully about to begin with. Together, they're why you can hand a `Car` class to another developer and trust they won't accidentally break it.

---

## Inheritance

*Brought a printed agenda. Refers to it once before putting it away.*

**Me:** How would you introduce yourself in the context of this `Car`?

**Inheritance:** I'm the reason you don't start from scratch every time you want a new kind of car. The base `Car` class has `accelerate()`, `brake()`, `speed`, `model`. If you want an `ElectricCar` or a `SportsCar`, you shouldn't have to rewrite any of that. You extend `Car`, you get everything it already established, and then you add or change what's specific to you.

```java
class Car {
    protected String model;
    protected int speed;

    public void accelerate() {
        speed += 10;
        System.out.println(model + " accelerating. Speed: " + speed);
    }

    public void brake() {
        speed = Math.max(0, speed - 10);
    }
}

class ElectricCar extends Car {
    private int batteryLevel;

    public void chargeBattery() {
        batteryLevel = 100;
        System.out.println("Battery fully charged.");
    }

    @Override
    public void accelerate() {
        batteryLevel -= 5;
        speed += 15;  // Electric motors are quick off the line
        System.out.println(model + " accelerating silently. Speed: " + speed);
    }
}
```

**Me:** `ElectricCar` overrides `accelerate`. Is that rejection?

**Inheritance:** It's refinement. It kept the concept and changed the implementation. That's exactly what it should do. I give the foundation. What they build on it is their business, as long as the relationship makes sense. An `ElectricCar` *is a* `Car`. That's not just naming. That's a contract.

**Me:** The argument for Composition over Inheritance comes up a lot. What do you say to that?

**Inheritance:** Composition is a good tool. But it doesn't give you the "is-a" relationship. When you need something to genuinely *be* a type, not just *use* one, that's where I come in. The `ElectricCar` isn't just car-adjacent. It is a car. That distinction matters when you start passing things around your codebase.

*At this point, the door opens. Composition leans in, doesn't sit down.*

**Composition:** Sorry to interrupt. Just one thing. An `ElectricCar` doesn't need to *be* a `Car` to accelerate like one. It just needs an engine. Give it an engine object. Swap the engine whenever you want. No family tree required.

**Inheritance:** That's not the same thing and you know it.

**Composition:** *(already leaving)* We'll talk.

*The door closes.*

**Me:** We did talk, actually. [That conversation has its own post.](/interviews/2026/04/30/inheritance-vs-composition.html)

---

## Polymorphism

*The only one who seems to be enjoying this.*

**Me:** Introduce yourself.

**Polymorphism:** I'm what makes it useful that the others did their jobs. Abstraction gave every car the same interface. Inheritance gave you a family of car types. Encapsulation kept the internals safe. I'm the part where you put a regular `Car`, an `ElectricCar`, and a `SportsCar` in the same list, call `accelerate()` on all of them, and each one just does the right thing.

```java
class SportsCar extends Car {
    @Override
    public void accelerate() {
        speed += 30;
        System.out.println(model + " LAUNCHES. Speed: " + speed);
    }
}

// The point of all of this
List<Car> garage = new ArrayList<>();
garage.add(new Car());
garage.add(new ElectricCar());
garage.add(new SportsCar());

for (Car car : garage) {
    car.accelerate();  // Each one does it differently. No extra instructions needed.
}
```

**Me:** Walk me through what actually happens there.

**Polymorphism:** The regular `Car` cruises. The `ElectricCar` glides. The `SportsCar` launches. Same call, three different behaviours, resolved at runtime based on what each object actually is. The code calling `accelerate()` doesn't know or care which type it's dealing with. I handle that. This is what makes it possible to write general code that still behaves specifically.

**Me:** What do you need from the other three to do that?

**Polymorphism:** Everything, honestly. Without Abstraction, there's no shared interface to call through. Without Inheritance, the `ElectricCar` can't legally stand in for a `Car`. Without Encapsulation, the internal differences between types would leak out and break the whole idea. They set it up. I'm where it lands.

*Encapsulation: "That was almost gracious."*
*Abstraction: "Almost."*

---

## The Takeaway

Each of the four pillars handles a distinct part of the problem:

| Pillar | Contribution to `Car` |
|---|---|
| **Abstraction** | Decides *what* a `Car` exposes, designing the interface around the user and not the implementation |
| **Encapsulation** | Protects what wasn't exposed and ensures internal state can only change in valid ways |
| **Inheritance** | Lets `ElectricCar` and `SportsCar` build on `Car` without rewriting it |
| **Polymorphism** | Makes one `accelerate()` call work correctly across every car type |

None of them is optional. Abstraction without Encapsulation is a well-labelled door with no lock. Inheritance without Polymorphism is reuse that still requires you to know too much. They're designed to work together, which is the point. OOP isn't four separate ideas. It's one idea with four parts.

---

*Interview responses have been lightly edited for clarity. No concepts were harmed in the making of this post.*
