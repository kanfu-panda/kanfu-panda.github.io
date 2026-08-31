---
layout: post
title: "How pdlc-skills Runs Unattended"
date: 2026-08-31
lang: en
categories: [blog]
image: /assets/images/posts/run-pdlc-unattended-cover-en.png
tags: [ai-engineering, prompt-engineering, loop-engineering, graph-engineering, pdlc, claude-code]
excerpt: "One feature needs a single command to take TDD, implementation and review to done on its own — no script required. The script belongs one layer out: a dozen feature points batched by dependency, one batch checked by a human before the next starts. Four guardrails hold it together, and I've watched every one of them fire."
---

> The last post got the first feature through. The next problem shows up fast: it stops at every stage waiting for your nod, so you're still parked in front of the screen. **Can it go round after round on its own while you do something else?** It can. But "running on its own" and "asking you at every step" are further apart than they look.

## That run wasn't a loop at all

I've run a full loop on my own machine before, and it went smoothly — 60-odd PRs pushed through in one stretch, and it never once turned around to ask me something. So when I ran it again on a different machine, something felt off almost immediately.

That time I'd asked the AI to "advance through the stages in a loop" **inside a single session**. It was moving forward, all right, but it came back to me at every step: is this design OK? Should I keep going? Want me to continue?

What I said at the time was roughly: **why is your loop different from the one I've been using? A normal loop doesn't turn around and ask me this stuff — it just keeps working until the job is done.**

The problem wasn't that it asked. It's that **everything it asked about was already settled**. The PRD was settled, the design was settled, how the tests would be written was settled — and it still came back for confirmation. That kind of check-in does nothing but tie me to the chair. I can't go do anything else, because I don't know whether the next interruption is three minutes away or thirty.

On the surface it was looping. In practice I was the one jogging alongside it.

That's what made it click: **there's exactly one line between a fake loop and a real one — who holds control of the loop.**

![Fake loop vs real loop across four points: loop written inside the session or driven by code, whether each round starts on clean context, whether trouble means asking a human or hitting a guardrail, and whether the stop decision reads the model's mood or a file on disk](/assets/images/posts/run-pdlc-unattended-fig-fake-vs-real-en.png)

It has nothing to do with how smart the model is, and nothing to do with whether the prompt says "please work autonomously, don't interrupt me." If control lives in the model's willingness, the loop is fake. If it lives in code, it's real.

## One feature: one command is enough

The hard prerequisite first: **PRD and design must be signed off by a human. Nothing enters the loop until the design is final.**

The loop speeds up the `TDD → implement → review` convergence stretch. It does not speed up figuring out what to build. Whether this feature is worth doing, where its boundaries sit, how it splits — those are judgement calls, and no command can hand you an exit code for them.

Once that's settled, the rest is one command:

```text
/pdlc-loop-run F20260825-XXXXXX
```

It picks up from whatever stage the feature is parked at and drives `tdd → implement → review` forward until review passes or it stops on a block. Each stage goes to a brand-new subagent; when that returns, the loop reads the state machine and decides whether to advance, stop, or hand back to you. Four steps by default.

**This assumes the `test-commands.yml` from the last post is already in place.** Stop decisions rest on exit codes from real command runs — no file, no commands to run. Skip that step and everything here spins in place.

What the command takes off your hands is exactly what I fumbled the first time I tried this by hand: **the decision about whether to go one more round is taken away from the model.** Three design points hold it up.

![One round in three beats: ask what's next (output filtered through a whitelist), do that step (clean context), read the state file to decide whether to stop; the in-plugin runner and an external script keep the same beat](/assets/images/posts/run-pdlc-unattended-fig-one-round-en.png)

**One: control flow is code, not something in the model's head.** Each round asks the model two things only — which command comes next, and getting that step done. The answer to the first has to pass a whitelist that accepts five tokens and nothing else; a single extra word of explanation gets filtered out. **Rambling gets the model nowhere, because nothing downstream reads it.**

**Two: every stage starts on clean context.** The previous stage's hesitation, misreadings and self-inflicted detours don't carry over. Everything that has to survive across stages lives in the state file on disk — the one from post 3. **Sessions can die; state doesn't.**

**Three: the stop decision reads a file, not an opinion.** After each step the loop doesn't ask "do you think that passed?" — it reads `last_phase_result.ok`, the on-disk result of actually running the commands. Post 3 covered the two slots in that file; **the stop decision uses only the one that holds real run results**.

## A dozen features: now you want an external script

`/pdlc-loop-run` runs inside the plugin, which suits one feature's short convergence. You can also write your own bash loop — every round gets a genuinely separate process, so context isolation is stricter and long runs hold up better — but **running one feature point that way isn't worth much on its own**: it does the same job as `/pdlc-loop-run` with a different process boundary.

The script's real place is one layer out. Post 3 sketched the two-level structure: split the work into N reasonably independent feature points, and have the outer layer start a loop for each, every one in its own worktree. The outer layer starts loops, collects results and queues the next batch — it doesn't push any single feature through its stages. What this post adds is how that outer layer is arranged: **batched by dependency**.

An earlier project of mine had something like a dozen feature points, and I ran them in three batches: **foundation first, then the ones other work depends on, then everything mutually independent all at once.** Each batch runs in parallel internally; when a batch finishes I check it, then the next batch starts, until the whole set has converged.

![A dozen feature points in three dependency batches: foundation, then depended-upon features, then mutually independent ones all at once; parallel within a batch, with a human check between batches](/assets/images/posts/run-pdlc-unattended-fig-batches-en.png)

The order can't be flipped. Without the foundation everything after it rests on nothing; until the depended-upon work is done, whatever depends on it just waits. That last batch waits on nobody, so opening it all at once is the cheapest — feature IDs use date-plus-timestamp precisely so parallel runs don't collide.

To be clear: **this batching layer is mine, not something pdlc provides.** What pdlc gives you is "how one feature point drives itself to done," plus the `/pdlc-relate` dependency graph to see who depends on whom. How to split the batches, and how many go in each, stays a judgement call — and stays outside the loop.

## Four guardrails, and I've watched every one of them work

Anyone can write guardrails into a doc. What's worth looking at is whether they've ever actually fired.

![What each of the four guardrails does and the time it actually fired: hard budget twice, fail-stop as everyday backstop, blocked escalation once, step ceiling once](/assets/images/posts/run-pdlc-unattended-fig-guardrails-en.png)

### ① Hard budget: `--max-budget-usd` per round

Put a spend ceiling on each round's process; hit it and the process is **killed outright**, no negotiation. This one is required for the external-script form.

**It fired twice in a single run.** I set the first round's ceiling at 5 and implementation got cut off partway; I checked the half-finished work on disk, confirmed it could be resumed, raised the ceiling to 8 and ran again — capped again; 12 finally got it through.

The thing worth saying about being cut off is this: **what's on disk is intact.** The documents landed, the state machine kept its ledger, and what I lost was "this round didn't finish," not "start over." Writing to disk plus keeping a ledger is what turns a blunt process kill into a pause you can resume from.

![One budget-capped round: the process is cut off, but the documents and the state machine on disk are intact, so the next round resumes in place instead of starting over](/assets/images/posts/run-pdlc-unattended-fig-budget-cut-en.png)

One honest note so those numbers don't get misread: **5, 8 and 12 are ceilings I set per round, not what I actually paid.** I'm on a subscription billed by weekly volume, and per-token prices differ between vendors anyway. Treat those three as a rough sense of scale, not a price list — if you want real cost, look at token consumption and estimate it against your own vendor's published pricing.

### ② and ④: stop when it's not ok, stop when the steps run out

**fail-stop** covers the failure that's easiest to miss: **a failed stage being treated as "done" by the next round**. Once that happens, every later round rests on a false premise, and the further it runs the worse it gets — all with a green light on.

**The step ceiling** guards against oscillation: break it, fix it, break it again, every round looking like work while nothing moves. Four steps by default = three convergence stages plus one for slack. I set it to 1 once, conservatively, and it stopped exactly as promised.

### ③ blocked escalation: it really did stop when it should have

If review turns up something that needs a product decision, it writes `blocked` into the state machine, stops, and waits for a person.

**The time this one fired is what convinced me the whole thing was trustworthy.**

During review it found that the three config fields added that round had **no consumer anywhere in the backend**. The code was correct and the tests were green — this wasn't a bug, it was a product-level gap: should the fields be cut, or was the pipeline left unfinished? **That's not a call the AI gets to make for me.**

It didn't guess, and it didn't quietly delete the fields to keep the tests green — it wrote `blocked`, stopped, and handed the question back. I decided to keep the fields and finish the pipeline, then let it continue. The follow-up surprised me: on the re-review it also fixed 2 genuine bugs in that pipeline implementation.

It stopped where it should have, and it checked what it should have. That's what I wanted from it.

## What that run produced

The work was a three-phase iteration on a console project: 4 backend endpoint groups, 3 frontend pages, plus a notification ruleset. `TDD → implement → review` ran unattended end to end, with **301 tests passing and coverage above 87%**.

Human involvement came to three moments total: two verification calls when extending the budget, plus the one product decision at the block.

![An afternoon on a timeline: after design sign-off, TDD, implementation and review run unattended; implementation is budget-capped twice, review stops once for a human decision, and the run ends at review-complete handed back to a person](/assets/images/posts/run-pdlc-unattended-fig-run-summary-en.png)

That's an afternoon's worth of work, and I don't want to make it sound bigger than it was. But during the loop it was completely silent toward me — what I came back to wasn't a queue of "shall I do the next one?" but a terminal state. **It isn't that it runs fast. It's that it doesn't need me present.**

## Where the line between human and machine sits

The test hasn't changed since post 2: **only hand the loop what can find its own errors.** Draw that line and two things never get handed over:

- **Figuring out what to build (human decision required).** PRD and design have to clear a human. That's a precondition for entering the loop, not a suggestion.
- **Shipping.** The loop's terminal state is review-complete; it stops there and a person decides whether to ship. `--autonomous` has no effect on ship or deploy — once it's out, it's out.

That marks off which work can be handed over. There's a companion question: **once it's handed over, what keeps it from going off the rails?**

When post 1 covered prompt engineering, I gave that layer a ceiling: it's a soft constraint, the model may not fully follow you, and you may not notice at the time. Back then it was just a principle. This run gave it a concrete instance.

Writing "go easy, watch the consumption" into a prompt is easy, but it belongs to the prompt layer — it can steer, it can't guarantee. `--max-budget-usd` belongs to the process layer; it doesn't read what you wrote, it just cuts at the ceiling. Both overruns on this run were stopped by the latter, not talked down by the former.

**Anything that steers but doesn't guarantee eventually has to move up a layer.** This time it moved to a process argument.

## Next up

If this post leaves you one thing, I'd like it to be this: **to tell a real loop from a fake one, look at one thing only — whether the control flow lives in code or in the model's willingness.** A loop that turns around to ask you isn't a loop.

Next post is about **quality**: the pipeline runs fast and unattended, so why should anyone trust what comes out of it? What the red-test gate, the review gate and coverage each hold back — and what they still don't catch together.

---

**Want to try it**:

```bash
curl -fsSL https://raw.githubusercontent.com/kanfu-panda/pdlc-skills/main/install.sh | bash -s -- --global
```

The repo: https://github.com/kanfu-panda/pdlc-skills

If it's useful, a star goes a long way ⭐

---

I wrote these four guardrails straight off the record of that run, including the parts where it got cut off and the part where it got stuck. If it left you thinking "all right, this can actually be trusted," let me know. And if you've run loops yourself — smooth ones or crooked ones — the comments are open — happy to talk it through.
