---
layout: post
title: "Prompt Engineering, Loop Engineering, Graph Engineering: What Are They?"
date: 2026-08-09
lang: en
categories: [blog]
image: /assets/images/posts/prompt-loop-graph-engineering-cover-en.png
tags: [ai-engineering, prompt-engineering, loop-engineering, graph-engineering, ai-agents, claude-code]
excerpt: "These three terms keep showing up in the same comparison table, as if you had to pick one. You don't — they don't even operate at the same level. Prompts govern a single exchange, loops govern how iteration converges, graphs govern which paths exist at all. Sorting that out is worth more than mastering any one of them."
---

> Prompt engineering, loop engineering, graph engineering — these three keep landing in the same comparison table, as if you had to pick one. But they don't operate at the same level. Sorting that out is worth more than mastering any one of them. This post isn't about any specific tool. It covers what each layer actually governs, where each one hits its ceiling, and ends with three questions that tell you which layer your problem belongs to.

## Three terms, three separate origins

These three came from completely different places, so let's start there.

**Prompt engineering** got renamed somewhere along the way. Early on the discussion was about phrasing — what persona to assign, which magic words to use. Then people realized phrasing wasn't what decided the outcome; what the model got to see was. Hence the more accurate label going around now: context engineering.

**Loop engineering** spread through the community on the back of Ralph-style setups. The mechanics are almost disappointingly simple: a one-line `while` loop that feeds the same instruction to the model over and over, lets the tests decide right from wrong, and after enough rounds the version that passes acceptance simply surfaces.

**Graph engineering** arrived with orchestration frameworks like LangGraph, which argue for drawing an agent's execution path explicitly — who hands off to whom, whether you can go back, where it has to stop.

Three separate threads, eventually shoved into the same table for comparison. The table is exactly where things go wrong — these aren't the same kind of thing.

## 🧱 They aren't on the same level

The relationship isn't side-by-side. It's **stacked**:

| Layer | What it governs | Granularity |
|---|---|---|
| Graph engineering | How paths are organized | Stage |
| Loop engineering | How iteration converges | Round |
| Prompt engineering | How a single exchange goes | Token |

![Graph on top, Loop in the middle, prompt at the bottom, with control granularity narrowing from stage to token](/assets/images/posts/prompt-loop-graph-engineering-fig-layers-en.png)

One thing has to be said right here, or you fall into the next trap: **the stack being real doesn't mean every layer is required.**

Once "the standard three-layer architecture" lodges in your head, every task starts looking like it needs all three. In practice, plenty of systems that work well have only one or two:

| Shape | When it looks like this |
|---|---|
| Prompt only | One-shot classification, extraction, rewriting — any orchestration is a net loss |
| Prompt + Loop | Iterate against tests; the path was never drawn at all |
| Prompt + Graph | The path can be fully enumerated; no autonomous iteration needed |
| All three | Production-grade engineering workflows |

Anthropic's principle in *Building effective agents* is a practical one: start with the simplest solution, and only add complexity when it demonstrably improves things.

So the right mental model isn't "a three-layer architecture." It's — **three optional nested layers. Start at the bottom by default, and understand that going up costs you something.**

![Four common shapes: prompt only, prompt plus loop, prompt plus graph, and all three, each with a typical task](/assets/images/posts/prompt-loop-graph-engineering-fig-combos-en.png)

## 🔍 Layer by layer: what each one actually governs

Four things per layer below: what it is, how it's done, one thing people get backwards, and where the ceiling is.

### Prompt engineering: deciding what the model sees this time

It stopped being about "phrasing things nicely" a while ago. What you're really managing is which things the model gets to see this time, and which it doesn't.

The reason it evolved that way is straightforward: once a task spans multiple rounds of reasoning, a well-turned sentence stops being enough, and the job shifts to managing the whole context state — system instructions, tool definitions, external data, message history, all of it.

In practice there are only a handful of moves. The system prompt needs to sit at the right altitude: specific enough to actually steer behavior, without hard-coding every situation — rules that are too granular start contradicting each other the moment something unforeseen shows up, and rules that are too vague say nothing at all. Tool descriptions need to make clear what each tool is for; the more overlap between tools, the more often the model picks wrong. Agree on the output format up front so you're not writing regexes later. Give a diverse handful of examples rather than piling up edge cases.

**What people get backwards**: longer context isn't better. The fuller you pack it, the more the middle gets diluted — that's a real, measurable decay, not the model "not being smart enough." Attention is a budget, and where you spend it is a tradeoff, not a "more is safer" situation. Working out what the model doesn't need to see this time is often easier than working out what to say.

**Ceiling**: it's a soft constraint. The model may not follow you exactly, and you may not be able to tell at the time.

This layer's biggest strength and biggest problem are the same fact — one edited sentence takes effect immediately, which also means you're relying on the model's willingness.

### Loop engineering: a task, plus one check

There's a line here you can treat as an axiom:

> A loop is a task with a check. A task without a check is just hope.

Ralph's shape came up earlier: it's that one `while` line. But the real design isn't in the loop — **it's in the files around it**, three of them, each doing one job. A spec, stating what this project should end up being and what's off limits. A progress list, recording what's done and what's next. And one instruction, fed in verbatim every round, telling the model: read the other two first, then pick one thing and do it. The loop itself is trivial; getting those three files right is the hard part.

**What people get backwards**: the context is wiped clean every round — the model has no memory of what it did last time. That sounds like a defect. It's a feature. Amnesia guarantees every round starts from a clean slate, so a wrong interpretation from one round doesn't get carried the rest of the way. The price is that anything that has to survive across rounds must live on disk — that progress list isn't a note for humans, it's the model's only memory going into the next round.

**Where the stop signal comes from**: how does a loop know it's done? It needs a signal something can decide automatically — test exit codes, compiler output, type checks. "Looks fine to me" doesn't count, because you can't put that in a conditional.

**How it typically crashes**, two ways. One is spinning: every round the model feels like it did something, nothing actually moves, and tokens burn with nothing to show. The other is redoing work: it doesn't find what the last round already built, assumes it isn't there, and builds it again — like a contractor who doesn't see yesterday's pipe, breaks up the floor, and lays it a second time.

**Ceiling**: a loop with no verification signal is mass-producing garbage. And its failures are the hardest to catch — it keeps running, it's just heading the wrong way.

### Graph engineering: two different things with the same name

There's an ambiguity to clear up first. "Graph" refers to two completely different things here:

- **Orchestration graphs**: the LangGraph kind, drawing which path the flow takes
- **Knowledge graphs**: the GraphRAG / code-relationship kind, drawing how entities relate

Same word, different objects. This post is about the first one. The second gets its own post — number seven in this series.

What an orchestration graph does is move "what order does this work go in" out of your head and onto paper: who picks up whose output, which step can be sent back, which step has to stop and wait for a human to nod.

There are five common shapes, each fitting a class of work:

- **Sequential**: one step after another. Writing code works this way — design first, then tests, then the implementation.
- **Routing**: classify first, then decide who handles it. Tickets come in, get sorted, refunds go down the refund path, outages down the outage path.
- **Parallel**: independent pieces run at once, then get merged. Have the same diff reviewed separately for security, performance, and readability, then combine the notes.
- **Orchestrator with workers**: one splits and assigns, several put their heads down and do it.
- **Evaluator-optimizer**: run the output through a review; if it fails, send it back.

Real systems are basically these five in combination. You don't need to invent new ones.

Drawing the graph has two benefits people overlook. One is **recoverability** — every node can be checkpointed, so a crash resumes from the last checkpoint instead of the top. The other is **auditability** — afterwards you can explain why it took that path, which matters when someone's going to ask.

**What people get backwards**: it dictates which paths are off limits, not how to do the work. More on that below.

**Ceiling**: it can only express what you thought of in advance. Anything requiring judgment on the spot, anything you haven't seen before — the graph is useless. There's also a hidden cost: once drawn, the graph becomes a liability, and reality shifting means redrawing it. Redrawing costs a lot more than editing a sentence, so it's worth planning before you start.

![A quick-reference card with one definition, one representative practice, and one ceiling per layer](/assets/images/posts/prompt-loop-graph-engineering-fig-cheatsheet-en.png)

## 🏠 The same thing, told as a renovation

Let's run all three through one analogy:

| Concept | What it maps to in a renovation |
|---|---|
| Prompt engineering | How you tell the contractor what you want |
| Loop engineering | Do it → inspect → fails → redo → inspect again |
| Verification signal | The inspector's straightedge, spirit level, flood test |
| Graph engineering | The trade sequence (plumbing → waterproofing → flood test → tiling → carpentry → paint) |
| Human checkpoint | The owner showing up to sign off at key moments |
| Context wiped each round | A new contractor showing up every morning |

Three sentences for the three personalities:

**A prompt is the brief.** "North-facing wall in the main bedroom, off-white, two coats, tape the edges." Costs nothing, works immediately — but the contractor may decide close enough is close enough, and you won't catch it on the spot.

**A loop is the redo mechanism.** Briefing alone doesn't get you there; you need inspection. The key word isn't "redo," it's the straightedge — redoing without one is just doing it twice.

**A graph is the trade sequence.** It won't tell you what color the wall should be. It just makes "tiling before waterproofing" impossible as a matter of process.

![The renovation flow mapped onto the three layers: briefing, redo-and-inspect, and the trade sequence](/assets/images/posts/prompt-loop-graph-engineering-fig-renovation-en.png)

One line for how the three divide the work: **sequence rules out what you can't do, redoing forces it up to standard, the brief decides how it actually gets done.**

## ⚖️ Three personalities, three ways to crash

|  | Prompt engineering | Loop engineering | Graph engineering |
|---|---|---|---|
| Who's in control | The model | The model (you only set the stop condition) | You (you draw the path, the model fills it in) |
| Determinism | Low | Lowest | High |
| Up-front investment | Minimal | Low, but you need a verification setup first | High |
| Unit cost | 1x | 4x, 15x for multi-agent | 2–3x, but fewer detours |
| Debuggability | Good | Worst | Best |
| Typical failure | The model doesn't comply | Drifts and nobody notices | Wrong graph, or too rigid |

*A note on the cost row: roughly 4x for agents and 15x for multi-agent come from Anthropic's public write-up; the 2–3x for graphs is a rough figure circulating in public material. These are order-of-magnitude references, not measurements.*

The row worth sitting with is the last one. **The three failure modes are nothing alike**: a prompt failure you can see — it didn't comply, it's right there. A loop failure you can't see — it's still running, just pointed the wrong way. A graph failure you can't change — the graph is set and reality moved.

The latter two are far harder to deal with, and they're precisely the new problems you acquire by adding layers. That's what "going up costs you something" means in concrete terms.

![The three layers compared on control, determinism, cost, debuggability, and typical failure](/assets/images/posts/prompt-loop-graph-engineering-fig-compare-en.png)

## 🚧 Two things people get backwards

### A graph doesn't plan; it constrains negatively

It's easy to read the stack as a chain of command: graph plans, loop executes, prompt implements. But the graph says nothing about how to do the work. All it declares is "you don't skip tests and go straight to implementation." Which modules this design splits into, which file to write first — that's the actual planning, and it happens in the two layers below.

Another way to put it:

> **The track** decides where you can go and where you have to stop — it has no opinion on why you left the house.
> **The engine** only pushes forward, until the terminus or a stop signal.
> **The steering wheel** decides how you actually move, within the room the track allows.

The track never plans your trip for you. It just makes "driving off to the side" impossible.

![The track sets direction, the engine supplies force, the steering wheel decides the specifics](/assets/images/posts/prompt-loop-graph-engineering-fig-track-en.png)

### The higher the layer, the weaker it is

The "top layer / bottom layer" framing makes it feel like the top matters more. It's the opposite — **more control means less expressive power**. A graph can only express what you thought of in advance, and the moment reality exceeds what the graph imagined, it can't help at all.

Going one level deeper: none of these three layers *implements* anything. The model does the work. The three layers are just three ways of shaping its behavior — graph through structure, loop through repetition and verification, prompt through language.

Which means: as models get stronger, the upper two layers matter less. What all this is worth is, to some degree, a function of what models currently lack.

## ✅ Three questions for picking a layer

If you take one thing from this post, let it be these three questions:

**Question one: if it's wrong, can a machine catch it automatically?**

Yes → use a loop. Tests, compilers, type systems all work as the straightedge.
No → don't, however tempting it looks. A loop without a verification signal is mass-producing garbage.

The test is plain enough: can "it's correct" be written as a command that exits with a status code? If you can write it, you can loop. If you can't, don't.

**Question two: can I draw the flowchart right now?**

Yes, and this flow needs to be reused, audited, and have human checkpoints → use a graph.
No → don't force it.

By "can't draw it" I mean the kind of work where you can't even say how many steps it takes: maybe three, maybe twenty rounds of back and forth, depending on what turns up. That kind of work should let the model judge as it goes; forcing a graph on it just boxes it in. Anthropic's guidance says the same thing — open-ended problems where the number of steps can't be predicted should go to an agent, not a fixed flow.

Note the question is "can I draw it now," not "could I draw it eventually." A graph only constrains anything if you thought it through first; one you patch as you go is just your mess in a new notation.

**Question three: neither of the above?**

Then use prompt engineering. **That's not a compromise, it's the right answer.** Wrapping a one-shot classification task in a loop and an orchestration graph only makes it slower, pricier, and harder to debug.

![The three-question decision tree: can errors be caught automatically, can the flow be drawn, is neither needed](/assets/images/posts/prompt-loop-graph-engineering-fig-decision-en.png)

## Next up: is there something real where all three grew in together?

That's the concepts covered. One line to close on, and it runs through the rest of this series.

The prompt layer can only *ask*; it can't *guarantee*. You write "go easy on the tokens" and the model will probably comply — but when it blows past the limit, you can't stop it, because that sentence carries no force.

If you want a guarantee, you need a different kind of mechanism. A hard line, for instance: spend past this amount and it stops. That line doesn't negotiate with the model, and it doesn't care whether the model agrees.

> **So: if what you want is a guarantee, the prompt layer can't give it to you. It has to move up a level.**

Next post is about something concrete — [pdlc-skills](/pdlc/), the thing I've been building, and why it lands on these three layers naturally.

---

**Want to try it**:

```bash
curl -fsSL https://raw.githubusercontent.com/kanfu-panda/pdlc-skills/main/install.sh \
  | bash -s -- --global
```

Project page: [kanfu-panda.github.io/pdlc](/pdlc/) · Source: [github.com/kanfu-panda/pdlc-skills](https://github.com/kanfu-panda/pdlc-skills)

If it's useful, a star goes a long way ⭐

---

If this sorted the three terms out for you, a reaction or a follow helps. And if someone around you is tangled up in these words, pass it along.
