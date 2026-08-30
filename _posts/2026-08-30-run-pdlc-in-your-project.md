---
layout: post
title: "Getting pdlc-skills Running in Your Own Project"
date: 2026-08-30
lang: en
categories: [blog]
image: /assets/images/posts/run-pdlc-in-your-project-cover-en.png
tags: [ai-engineering, prompt-engineering, loop-engineering, graph-engineering, pdlc, claude-code]
excerpt: "Installing takes one line. What actually stalls people is the first move after that — whether you're starting from a new project, an existing codebase, or one that's already onboarded, the first command is different. And one step gets skipped constantly: skip it and the objective stop-check from the last post degrades into the model feeling good about itself."
---

> The first three posts were blueprints: what each layer is, where it lands, how they interlock. This one turns the other way — **putting the blueprint onto your own project**. By the end you should be able to install it, know which command to start from, and get one feature through. There's one step in the middle that gets skipped constantly; I'll pull it out on its own, because skipping it makes the whole design from last post collapse.

That covers most of the theory. Now let's look at how pdlc-skills actually runs inside a real project.

A lot of people have the same question first: do I need to backfill the tests? Write all the docs? If it's a codebase that's been running for two or three years, piled high, that nobody quite dares touch — does onboarding mean paying off the technical debt on day one?

Here's the answer up front: **none of that. Installing is one line, about a minute.**

What will actually stall you is something else — the "so now what" right after install. The first project I onboarded, I sat staring at a screen full of commands starting with `/pdlc-`, genuinely unsure which one to type. This post answers that "so now what": which command to start from, and which step you absolutely cannot skip.

## Installing: one line, two landing spots

```bash
# Global — every project on this machine can use it
curl -fsSL https://raw.githubusercontent.com/kanfu-panda/pdlc-skills/main/install.sh | bash -s -- --global

# Project-scoped — only this one repo
curl -fsSL https://raw.githubusercontent.com/kanfu-panda/pdlc-skills/main/install.sh | bash -s -- --project /path/to/my-project
```

The first three posts always gave the global line, because it's the shortest and hardest to get wrong. Here's **when project-scoped is worth it**.

The only difference between the two is where it lands: `~/.claude/plugins/pdlc/` or `<project>/.claude/plugins/pdlc/`. What that buys you is real, though — project-scoped installs make **the version travel with the repo**. Someone else clones it and gets the same version you have; and when you've got several projects open at once, one global upgrade doesn't move all of them at the same time.

One person, one machine, not many projects? Go global, don't overthink it.

Confirm it actually took, two steps:

```bash
ls ~/.claude/plugins/pdlc/          # where the global install lands
ls <project>/.claude/plugins/pdlc/  # where the project-scoped one lands
```

Seeing `skills/` `references/` `VERSION` in there means you're good. Then type `/pdlc-` in Claude Code and the dropdown should list 38 commands. If it does, you're installed.

![Two landing spots: global goes in your home directory and covers every project, project-scoped goes in the repo and covers only that one](/assets/images/posts/run-pdlc-in-your-project-fig-scopes-en.png)

## Which starting point are you?

38 commands spread out in front of you is intimidating, but **you only need to recognize three the first time**. Which one depends on what you're holding:

| Your starting point | First command |
|---|---|
| Brand-new project, no code yet | `/pdlc-bootstrap` |
| Existing project, plenty of code | `/pdlc-adopt scan` |
| Already onboarded, day-to-day work | `/pdlc-feature` |

**Brand-new project** uses `/pdlc-bootstrap`: give it one line of description and it picks a stack, generates the directory skeleton and draft documents. Good for when "I want to build an X" is still just an idea.

**Existing project** is where most people are, and it's the row I most want you to notice: the first command is `/pdlc-adopt scan`, and **scan is entirely read-only** — it surveys your stack, service layout, database, existing tests, and produces an onboarding report plus a health check, **without changing a single byte**.

I think that design is worth more than the feature itself. Letting AI touch a live legacy codebase makes anyone hesitate. So it splits "look" and "touch" into two commands: run `scan`, read the report, and only if you like what you see do you run `/pdlc-adopt init` to generate the baseline docs. The cost of trying it drops to zero.

![Three starting points each take their own first command, then merge into the same main flow](/assets/images/posts/run-pdlc-in-your-project-fig-three-starts-en.png)

## Don't skip this: settle what "passing" means, first

**This is the most important section in the post.**

Last post covered the two boxes in the state file: the first box only takes **exit codes from commands that really ran**, and the model's self-assessment sits in a second box, never part of the stop decision.

Which raises a question — **where do those commands come from?**

The answer is `/pdlc-test-setup`. It does four things: detect the stack, verify each command really runs, write them into `docs/00_standards/test-commands.yml`, then scaffold the test directories and wire up local hooks.

The repo is blunt about what this step is for: the whole thing hinges on "checks only accept exit codes, never the model's self-assessment," **but until this point nothing has helped you stand that file up — and without it, the entire objectivity chain is empty**.

It carries one non-negotiable rule: **every command written into that file must have been really run once, with the exit code seen with your own eyes**. Guesses don't get written. The reasoning is the line I find most worth repeating —

> A command that "looks right but doesn't run" is **worse than leaving it empty**.

Empty, and everything downstream knows this stage has nothing to judge, so it stays honestly empty. A fake command that doesn't run hands every stage false checks — and the report still comes out green. There's a mirror image of the same idea: **the most dangerous "auto-fix" is quietly blanking a check that was standing but broke** — the gate loosens on the spot and you can't tell.

So what happens if you skip it? No commands to run → the first box must be left empty by rule → the stop decision has nothing to stand on → what you thought was "objective verification" has been the model feeling good about itself the whole time. **The foundation for last post's design is this one step.**

Worth mentioning: this file goes stale — scripts get renamed, tooling gets replaced, sub-projects come and go. You don't have to watch it; downstream stages will tell you when a command won't run, and you run `/pdlc-test-setup --refresh` when you see the prompt.

![Once test-commands.yml stands up, last post's "only real results" box finally has something to put in it](/assets/images/posts/run-pdlc-in-your-project-fig-foundation-en.png)

## Running your first feature

With the foundation in place, starting work takes one sentence:

```text
/pdlc-feature add phone verification to login
```

From there it works down PRD → design → TDD → implementation → review, stopping and handing off at each stage. Fixing a bug is the same shape with `/pdlc-fix`; to see where things stand, `/pdlc-status`.

**Day to day, those three are all you use.** The other 35 are for when you want fine-grained control — rerun just the design stage, do a single code review, add a database design. Go find them then.

## What shows up on disk, and what belongs in git

After one round, a batch of directories appears under `docs/`: requirements, design, testing, deployment, review each have their place, plus a `docs/.pdlc-state/` holding one JSON per feature.

Those first ones are documents; committing them is your call. But one of them **has to go in**:

**`docs/.pdlc-state/` should be committed to git. Don't put it in `.gitignore`.**

It looks like a cache — a dot-directory full of machine-read JSON, easy to wave off. It isn't a cache, it's **the handoff**. Change sessions, change machines, hand the work to someone else: the only thing that can say "this feature is at this stage, and the last one passed" is that directory. Not in git means losing your memory every time you reopen a session; on a team, nobody else can see where you are.

The repo calls it a "project delivery audit record." Treat it as an audit record and you stop wanting to ignore it.

![The docs directory after a run, with the state-machine directory marked as must-commit](/assets/images/posts/run-pdlc-in-your-project-fig-tree-en.png)

## Two rules for onboarding an existing project

If you came in from a legacy codebase, two rules are worth knowing on their own, because they decide whether this is realistic at all:

**One: documents only, no code changes.** Not a line of business code is touched during onboarding — it only reverse-generates baseline documents.

**Two: incremental onboarding.** Existing code is marked "baselined" wholesale, and **only new features go through the full flow**. You are not asked to clear the historical debt first.

The second one is the load-bearing rule. I've watched plenty of process tools die on day one: you onboard, it reports several hundred existing violations, and one look at that number is enough to make people quit. Fence the existing code off and govern only what's new — that's what gives the process a chance of surviving to day two.

## When not to use it

Worth naming the boundary too. One-off scripts, throwaway demos, pure documentation repos — don't bother, the process doesn't pay for itself there. This is for projects that have to live a long time, get handed over, and answer for their quality.

The test is simple: **will anyone still open this project three months from now?** Yes, it's worth it. No, don't bother.

## Walk it once

Compressed into a single list you can follow directly:

1. **Install**: `curl … | bash -s -- --global` (swap in `--project <path>` for multiple projects or team work)
2. **Verify**: `ls ~/.claude/plugins/pdlc/`, then type `/pdlc-` in Claude Code and check for the 38 commands
3. **Know your starting point**: new project `/pdlc-bootstrap`; existing project `/pdlc-adopt scan` for the report, then `/pdlc-adopt init` if you like it
4. **Stand up the foundation**: `/pdlc-test-setup` — **don't skip this one**, it decides whether every later "did it pass" is real or fake
5. **Start work**: `/pdlc-feature <your one-line requirement>`, with `/pdlc-status` any time to see where it is
6. **Commit**: include `docs/.pdlc-state/`

Step 4 is the only one that looks postponable and isn't. The rest just go in order.

## Next up: can it keep going on its own?

Installed, started, foundation laid, first feature through — that's the line, end to end. If this post leaves you one thing, I'd like it to be this: **settle what "passing" means before you start running** — get that order backwards and every bit of automation afterwards is spinning in place.

Next is the heavy one in this series: **it's installed and running, so can it go round after round on its own, without you watching?** That post covers the convergence loop's mechanics, its contracts, and four non-negotiable guardrails — including the time I got caught myself: talking the model out of burning tokens didn't work, and what finally caught it was a hard budget.

---

**Want to try it**:

```bash
curl -fsSL https://raw.githubusercontent.com/kanfu-panda/pdlc-skills/main/install.sh | bash -s -- --global
```

The repo: https://github.com/kanfu-panda/pdlc-skills

If it's useful, a star goes a long way ⭐

---

I wrote this in the order I actually onboarded my own projects, and spent extra words on the steps that tripped me up. If you get through it, tell me; if you get stuck somewhere, tell me that too and I'll fold it into the next version.
