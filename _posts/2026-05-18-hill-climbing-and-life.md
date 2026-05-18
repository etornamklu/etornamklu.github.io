---
layout: post
title: "What Hill Climbing Taught Me About Getting Stuck"
date: 2026-05-18
categories: everything-else
---

Saturday, 8am. I should be cuddling. Instead I find myself in [Prof. Justice Appati's](https://www.linkedin.com/in/prof-justice-kwame-appati-7a2738156/) Intelligent Systems class, trying to follow a lecture on iterative search algorithms. The first algorithm on the list is hill climbing. He explains it, shows the pseudocode, and moves on. I stay on one slide longer than everyone else. Not because the algorithm was complicated. Because I recognized something.

---

## The Algorithm

Hill climbing works like this. You start somewhere. You look at your neighbors, the positions you could move to from where you currently are. You pick the best one. You move there. You repeat until none of your neighbors are better than where you already are. Then you stop. That position is your answer.

It is a simple rule. Only move if the next step is an improvement. Never go backward. Never go sideways without gain. The moment you can't find anything better nearby, you declare success.

The algorithm has a name for that stopping point. A local maximum. The highest point in your immediate neighborhood, even if it is not the highest point in the entire landscape.

---

## The Landscape Problem

To understand why this matters, you have to picture the search space as a physical landscape. Hills and valleys, peaks and flat terrain. The algorithm is trying to find the highest peak. It does this by always climbing.

The problem is what that strategy misses.

If you start on a small hill and climb to its top, you stop there. You have no way of knowing that there is a larger mountain on the other side of the valley. The valley is down. Your rule says don't go down. So you never cross it, and you never find the mountain, and you spend your whole time optimizing a position that was never the best option available to you.

This is the local maximum problem. You are at the best point you can reach from where you are, given the constraint that you will never accept a worse position. But the best point you can reach and the best point that exists are not the same thing.

---

## The Plateau

There is a second trap, different from the first. The plateau.

Sometimes the landscape is flat. All your neighbors look the same. None better, none worse. Hill climbing's rule says move only if something is better. On a plateau, nothing is. So you stop, not because you've peaked but because you can't tell where to go next.

This is the cruelest version of being stuck because there's no peak to point at. There's no clear mistake. You're just sitting in the middle of something undifferentiated, doing everything correctly by the rules you have, and making zero progress. People who have been working hard and felt nothing move for months know what a plateau feels like. Not failure. Not success. Just flatness.

---

## The Ridge

The third trap is the ridge. A ridge is a narrow path of high ground that runs in one direction. The peak is at one end of it. But the steps available to you don't follow the ridge neatly. They cut across it. Every move toward the peak also moves you slightly off the ridge and downward. So again, your rule rejects it. Again, you stop short.

Ridges are the trap of almost-right paths. You can see where you need to go. The direction is obvious. But every actual step available to you looks like a step down, and so you never take any of them.

---

## What This Has to Do With Anything

I don't think the algorithm is just describing search problems.

Think about a job that pays well and is comfortable enough, but is slowly becoming the wrong fit. Hill climbing says stay. Every measurable dimension of the next position is a step down: lower pay, less certainty, new skills to build, a longer commute. The rule says don't move unless the next step is better. So you don't move. You stay optimized for a position that is good by every local measure and wrong by every other one.

Or think about a habit you've built over years. It serves you, mostly. It has a peak. You've found it. But somewhere in the part of the landscape you've never explored, there are better configurations you've never reached because your whole strategy has been to move locally and never step backward.

The local maximum isn't a failure state. That's the uncomfortable part. It feels like success. It is success, by the only measure the algorithm uses. You can't feel the difference from the inside between being at a local maximum and being at the global one. Both feel like the highest point you can see. Both feel like done.

The signal is usually indirect. A creeping sense that this is fine but not right. A moment in a lecture, or a conversation, or a very ordinary Tuesday, where you look around and realize you've been standing still for longer than you meant to.

---

## The Question Nobody Can Answer

Here is what makes the local maximum problem genuinely hard, and not just a motivational poster about leaving your comfort zone.

When you are at a local maximum and considering moving down into the valley, you do not know what is on the other side. And the algorithm doesn't really know either. Hill climbing never surveys the whole landscape. It only evaluates the moves available from where it is and follows improvement until improvement disappears. You are in a similar position. You only have your current position, your immediate neighbors, and whatever incomplete map you've built from your own experience.

Leaving a local maximum is not a guaranteed upgrade. The valley might lead somewhere higher. It also might lead nowhere. Some people leave the stable job for the startup and build something. Some leave the stable job for the startup and lose two years. The landscape does not announce itself. You step into the valley not knowing how deep it goes or what's waiting on the other side.

This is the part the algorithm leaves out. Hill climbing at least has a defined landscape to search. You're making decisions on a landscape you can't fully observe, that changes as you move through it, that other people are also moving through, and that doesn't stay still long enough to find its own peaks.

Knowing you're at a local maximum is not the same as knowing whether you should leave.

---

## Simulated Annealing

There's an algorithm that addresses this directly. Simulated Annealing.

It starts from the same place as hill climbing but adds one thing: it will sometimes accept a worse move. Not randomly, and not forever. The probability of accepting a worse move is controlled by a parameter called temperature. At high temperature, the algorithm explores freely. It takes bad moves. It wanders rather than climbing the nearest hill. As temperature decreases over time, it becomes progressively more selective, until eventually it behaves more like a conservative hill climber.

The acceptance probability at any moment is `e^(-delta/T)`, where delta is how much worse the new position is, and T is the current temperature. A small downward move at high temperature gets accepted often. A large downward move at low temperature gets rejected almost every time. The algorithm controls its own willingness to take losses based on where it is in the process.

The name comes from metallurgy. When you heat metal and cool it slowly, the atoms settle into a low-energy, stable configuration. Cool it too fast and you get a brittle structure, locked into whatever arrangement the atoms happened to be in when things solidified. The slow cooling is what produces something durable.

---

## What It Means to Apply This to Life

I'm not sure you can apply simulated annealing to life in any precise way. You can't calculate the acceptance probability. You don't know your temperature. You don't have a cooling schedule that tells you how much risk is appropriate at 28 versus 38 versus 48.

But the shape of it maps onto something real.

When you are young, your temperature is naturally high. Not in a reckless sense, but in the sense that the cost of a bad move is lower and the time to recover is longer. Taking a downward step at 23 means something different than taking the same step at 43. The losses are the same in absolute terms. But the compounding works differently. The 23-year-old who spends two years in the wrong valley and then climbs out has decades left to use what they learned. The stakes of exploration are lower because there is more time to make use of whatever the exploration finds.

This is why people talk about taking risks when you're young as though it's a platitude, but it's actually just the math. Simulated Annealing works because it front-loads the exploration. The erratic, expensive, wide-ranging moves come first, when the algorithm can afford them. The slow careful convergence comes later, after it has seen the landscape and earned its certainty.

The people who get stuck in local maxima early and stay there are, in some sense, cooling too fast. They found something good, declared it optimal, and stopped searching before they had enough information to know whether it was.

---

## The Part That Still Bothers Me

Even with all of this, the question I started with doesn't fully resolve.

Simulated Annealing can accept a worse move systematically because it has a fixed acceptance rule on a stable objective function. You do not. When you consider leaving something that is working reasonably well, you are not running a probability calculation. You are making a guess with incomplete information about a landscape that might look different by the time you get to where you think you're going.

The valley might be deeper than it looks. The mountain on the other side might not be as high as you imagine. Some of the people who left the local maximum found the global one. Some found a worse local maximum. Some found nothing and came back to a local maximum that had moved on without them.

I don't think the lesson is to always leave. I think the lesson is to be honest about what keeping the rule costs you. Hill climbing's rule is not inherently wrong. It is wrong when it is applied without awareness, when you mistake a local maximum for a global one because it's the only peak you can see, when you reject the valley not because you've thought about it but because the rule says valleys are bad.

The algorithm doesn't know it's on a small hill. You have the advantage of knowing you might be.

---

## Move Anyway

But here is the thing about uncertainty: it is not a reason to stay still. It is just the condition. It has always been the condition. The landscape was never going to announce itself. The mountain on the other side was never going to come with a guarantee. That is not a special feature of your situation. That is just what it means to be alive and making decisions with incomplete information.

Life is not a stable landscape. It shifts while you are moving through it. Other people are moving through it too, changing its shape. The peak you are climbing toward might not exist by the time you arrive. The valley you were afraid to enter might have become something else entirely. You cannot account for this. The algorithm certainly cannot. No model survives contact with the full complexity of an actual human life.

Which means the honest answer to the local maximum problem is not a strategy. It is a disposition. You stay curious about whether where you are is where you should be. You resist the comfort of declaring yourself done. And when you decide to move, you move with the knowledge that you might be wrong, that the valley might be deeper than it looks, that the other side is not promised.

You move anyway. Not because you are certain, but because staying still is also a choice, and it is usually the one with the most familiar outcome.

The best case for motion is not that it guarantees a better peak. It is that it keeps the search alive. It keeps you in contact with the landscape rather than settled into one small corner of it. Hopeful is not the same as naive. Hopeful is just what it looks like to believe that the best version of the landscape you are searching is still somewhere ahead of you, and that you are still capable of finding it.
