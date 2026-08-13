---
layout: post
title: "Why Does pdlc-skills Fit All Three Engineering Paradigms So Naturally?"
date: 2026-08-13
lang: en
categories: [blog]
image: /assets/images/posts/why-pdlc-fits-three-paradigms-cover-en.png
tags: [ai-engineering, prompt-engineering, loop-engineering, graph-engineering, pdlc, claude-code]
excerpt: "I didn't design these three layers in. I hadn't even heard the terms loop engineering or graph engineering when I built it. It just follows the product development lifecycle that software engineering has had for decades — requirements, design, tests, implementation, review. Only afterwards did I hold the three paradigms up against it and find they matched everywhere. That's a coincidence, but there's a reason behind it."
---

> Once the three concepts are sorted out, the next question is the interesting one: is there anything real where all three layers grew in together? This post holds one up against them — [pdlc-skills](/pdlc/), the thing I've been building. Conclusion first: the fit **is a coincidence**. But there's a reason behind the coincidence, and that reason is what this post is about.

Last time we separated three terms that get mixed up constantly:

- prompt engineering governs how you talk to the model this one time;
- loop engineering governs how many rounds a thing repeats and what condition stops it;
- graph engineering governs which steps along the path can't be skipped.

They're not on the same level. It isn't a choice of one — they stack.

Which raises the obvious question: all three sound reasonable, but **is there anything real where all three layers grew in together**?

Let's hold one up against them — pdlc-skills, the thing I've been building.

## What is pdlc-skills?

It's a [Claude Code](https://docs.anthropic.com/) plugin, and what it does fits in one line: **it turns AI-written code from something you chatted about into something that lands on disk.**

Install it and you get 38 slash commands, one per stage of the workflow. The one you'll use most is `/pdlc-feature` — start a new feature with it and the AI works down the line: PRD → design → TDD → implementation → review → ship, stopping to hand off at each stage.

Three things separate it from "hey, build me this feature":

- **Artifacts must land on disk.** PRD, design, review notes are real files under `docs/`, not a passage in a chat transcript.
- **Every feature carries state.** Which stage it's at, whether the last one passed — all recorded on disk. Pick it up in a new session and it knows where it is.
- **Tests must be red first.** No failing test, no implementation. That's a hard gate, not a suggestion.

MIT licensed. It's most complete on Claude Code; the same methodology runs on other AI coding tools through adapters.

## Its origins are unremarkable

**I didn't design these three layers in. I hadn't even heard the terms "loop engineering" or "graph engineering" when I built it.**

It just follows the product development lifecycle that software engineering already had. Requirements, design, tests, implementation, review, ship — that flow has been lying around the industry for decades, and there's nothing new in it. All I did was translate it for the AI: what each stage does, what it produces, what counts as passing, written out as commands, so the AI works down the flow instead of wherever its attention lands.

One rule came with it: **every stage has to write something to disk.**

- PRDs go to `docs/01_requirements/`
- Designs go to `docs/02_design/`
- Review notes go to `docs/07_reviews/`
- Each feature also gets its own state file

All plain text. You can open any of it, and you can `git diff` exactly what the AI did this round.

Then these new terms started circulating. I held them up against what I'd built and found matches everywhere — not because I built toward them, but because it had grown that way on its own.

So let's go layer by layer, in order: prompt, loop, graph.

## 🔵 Prompt layer: matches "one copy of the spec"

**What it corresponds to in the flow.** Software engineering has an old rule: there's one copy of the spec, not one version here and a different one there. Applied to pdlc, that means the rules every command has to honor — artifacts land on disk, self-check before handoff, repair only once — can't be written out separately inside each command.

**How it's actually done.** Common rules are pulled into fragments and expanded into each skill at build time. Currently that's **13 fragments compiled into 36 of the 38 skills** (the two without them are `pdlc-loop-next` and `pdlc-status` — too light to share anything). The six invariants — files must land on disk, each stage must be recorded (appending to history), tests must be red first, self-check is mandatory, repair happens once, and state must advance (`current_stage` has to actually change, so an outer loop can't spin on a stale value) — live in one of those fragments. Change it once, everything changes.

![13 shared fragments expand into 36 skills at build time; one edit propagates everywhere](/assets/images/posts/why-pdlc-fits-three-paradigms-fig-fragments-en.png)

**Which layer it matches.** Prompt engineering governs what the model sees this time. Nothing about that changed here — it's just managed the way you'd manage code: extract the common part, expand at build time, single source of truth.

The new term is prompt engineering; the old rule is single source of truth. Same thing, two vocabularies — **that's coincidence number one**.

## 🟢 Loop layer: matches the TDD red-light gate

**What it corresponds to in the flow.** TDD is old news in software engineering, and the rule is one line: write a failing test, then write the implementation, until the test goes green. pdlc copies that straight across — no red test, no implementation.

**What that rule brings with it.** Writing tests before implementation means "is it done" gets an answer that has nothing to do with the model: run it, exit code 0 means it passed, anything else means it didn't.

What makes that answer valuable is that it doesn't route through the model. Ask the model that wrote the code to grade its own code and it will grade generously and consistently — not because it's lying, but because it genuinely thinks the code is fine. So in pdlc the model's self-check is recorded separately, treated as a reference, and **never as grounds for stopping**.

**Which is why this stretch can go to a loop**: `tdd → implement → review` runs on its own until review passes. The PRD and design before it can't — whether to build this feature at all, how many modules to split it into, where the boundary goes, are judgment calls, and no command returns an exit code for those. Judgment calls stay with the human. That line is drawn clearly.

![Which stretch of the flow can be handed to a loop and which must stay with a human, with the criteria alongside](/assets/images/posts/why-pdlc-fits-three-paradigms-fig-loopable-en.png)

**Which layer it matches.** Loop engineering has a line you can treat as an axiom: a loop is a task with a check; a task without a check is just hope. TDD is exactly that check.

I do TDD because software engineering says test before you write, **not to prepare a straightedge for a loop**. But the straightedge was sitting right there — **coincidence number two**.

Guardrails, step limits, budgets — I'm saving those for post five.

## 🟣 Graph layer: matches stage gating and review

**What it corresponds to in the flow.** The phrase "lifecycle" carries order in it: requirements before design, design before implementation, review after implementation, ship after review. In software engineering that order isn't advice, it's discipline — the industry has already paid decades of tuition for skipping steps.

**How it's actually done.** Each stage writes its state to disk on completion; the next stage reads that state first and won't start unless the preconditions hold. No skipping tests to implement. No shipping without review.

Beyond the vertical order there's a horizontal layer: how features relate to each other. `/pdlc-relate` records those relationships explicitly, with **six directed edge types** — extends, depends on, supersedes, resolves, conflicts with, relates to. Then `impact <feature-id>` gives you the blast radius in one command: 🔴 directly depends on it, 🟡 one hop away, 🟢 already finished, ignore it.

![The vertical axis is a linear pipeline with gates; the horizontal one is the actual directed graph](/assets/images/posts/why-pdlc-fits-three-paradigms-fig-two-directions-en.png)

**And here's the honest part.** That vertical line isn't a graph, strictly speaking. It's a linear pipeline with a few gates: no conditional branches, no parallel nodes, no rolling back to an arbitrary point — nearly nothing that makes a graph a graph. The thing that actually qualifies is the horizontal dependency graph: directed, traversable, cycle-detectable, and able to catch references pointing at features that don't exist.

**Which layer it matches.** So why does the vertical count as the graph layer at all? Because **the essence of the graph layer isn't "drawn as a graph," it's negative constraint** — declaring which paths are off limits. To reuse the line from last time: the track doesn't plan your trip, it just makes certain directions impossible.

Stage gates constrain order, the dependency graph constrains blast radius; both do the same job. And "advance by stage, review at key points" was written into the flow by software engineering a long time ago — **coincidence number three**.

![Six directed edge types form the graph; impact marks the blast radius by distance](/assets/images/posts/why-pdlc-fits-three-paradigms-fig-relations-en.png)

## Three coincidences stop being a coincidence

One match could be luck. Three matches is worth asking about.

My answer: **these two things were solving the same set of problems all along.**

The three paradigms are new vocabulary, distilled over the last couple of years out of AI agent practice. The software engineering flow was beaten into shape over decades by real projects. And the mistakes humans and AI make on engineering work overlap heavily — working wherever attention lands, keeping several copies of the spec, declaring something done without verifying it, changing one thing without knowing what else breaks. The rules the old flow set up to treat those still work when you translate them onto an AI.

So the constraints the new vocabulary describes had already been written down, in another language:

| What the three paradigms say | What software engineering already required |
|---|---|
| Prompt engineering: unify the context | One copy of the spec, don't scatter it |
| Loop engineering: needs an objective check | Write the test before the implementation |
| Graph engineering: apply negative constraints | Advance by stage, review at key points |

**That's what "fits naturally" means here**: I didn't fit three layers into it. The old flow already had those three layers — nobody had called them by these three names before.

There's one more thing, which the old flow didn't have and which showed up on its own during implementation: **the three layers ended up sharing one thing — the state on disk.**

> The graph reads it to know which step it's on,
> the loop reads it to know whether this round advanced anything,
> the prompt reads it to get the context for this call.

![The three layers share one state file on disk](/assets/images/posts/why-pdlc-fits-three-paradigms-fig-shared-state-en.png)

Which hands you a ready-made test: **to judge whether a tool's three layers are genuinely joined, check whether they share one state.** Sharing is integration; each keeping its own is three mechanisms living in the same repository.

## Next up: when does each one actually kick in?

If this post leaves you with one line, I'd like it to be this: **if you want AI to do engineering work, you'll get further picking up the engineering process you already have than inventing a new framework.** That process isn't new, but the ailments it treats, AI has too.

Now that we know where each layer landed, the next question is: **in one real feature, when does each of them actually kick in?** Next post follows a single feature from start to finish, marking the timeline for all three layers and how they hand off to each other.

---

**Want to try it**:

```bash
curl -fsSL https://raw.githubusercontent.com/kanfu-panda/pdlc-skills/main/install.sh \
  | bash -s -- --global
```

Project page: [kanfu-panda.github.io/pdlc](/pdlc/) · Source: [github.com/kanfu-panda/pdlc-skills](https://github.com/kanfu-panda/pdlc-skills)

If it's useful, a star goes a long way ⭐

---

If this gave you a concrete picture of how the three layers land, a reaction or a follow helps. And if someone near you is working out how to get AI to follow a process, pass it along.
