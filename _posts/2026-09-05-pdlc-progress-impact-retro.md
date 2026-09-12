---
layout: post
title: "How pdlc-skills Makes Progress, Change Impact, and Quality Trends Visible"
date: 2026-09-05
lang: en
categories: [blog]
image: /assets/images/posts/pdlc-progress-impact-retro-cover-en.png
tags: [ai-engineering, prompt-engineering, loop-engineering, graph-engineering, pdlc, claude-code]
excerpt: "An AI can push three features forward in an afternoon. If you can't see where the project stands, what a change will touch, or how the last month went, all that automation is running in a black box. pdlc has three tools for this, all reading the same state files: the statusline and /pdlc-status for where things are now, /pdlc-relate impact for what a change will affect, and /pdlc-retro for the monthly trend. This post covers how they work, what one real run produced, and the limit they share: they only show what was recorded."
---

> The last post covered the quality chain. This one is about **visibility**. An AI can push three features forward in an afternoon. If you can't tell where the project stands, what a change will touch, or how the last stretch went, the automation is running in a black box. pdlc has three tools for this: the statusline together with `/pdlc-status`, `/pdlc-relate`, and `/pdlc-retro`. They watch three timescales: right now, before a change, and month by month.

## Three tools, one data source

All three only read the state files under `docs/.pdlc-state/`. They don't parse documents and they don't guess. Post 3 described how the three layers coordinate through one shared scoreboard; these tools read that same scoreboard and differ only in the question they answer. The statusline and `/pdlc-status` answer "where are we now?". `impact` answers "what does changing this touch?". `retro` answers "how did this stretch go?".

![Three tools read the same state directory and answer questions on three timescales: the statusline shows where things are right now, impact checks the blast radius before a change, retro shows the trend month by month](/assets/images/posts/pdlc-progress-impact-retro-fig-timescale-en.png)

How accurately the state files are written decides whether what these tools show is true. I'll come back to that at the end.

## Where are we now: the statusline and /pdlc-status

Here is a statusline entry from a real project, with the stage labels translated (the current release prints them in Chinese):

```
● PDLC console-p3 · PRD·Design·TDD·Impl·[Review]·Ship · →ship · 🤖 · ✓unit ✓lint ✓cov · ⏱9d
```

Left to right: the feature name; the six-stage track (PRD, design, TDD, implementation, review, ship) with the current stage highlighted; the next step; the run mode (🤖 autonomous loop, 👤 manual); the three check results; and how long the feature has sat in the current stage.

![The six fields of one statusline entry: feature name, six-stage track, next step, run mode, check results, time in stage; below it, the full-line format used when a feature is blocked](/assets/images/posts/pdlc-progress-impact-retro-fig-statusline-en.png)

Three design choices in this one line are worth spelling out.

1. It doesn't show "step 4 of 6". A bug fix doesn't go through all six stages, so a counter would mislead. Instead it shows the fixed track and highlights where you are.
2. The three checks only show by default in autonomous mode. In manual mode you're running the tests yourself and the ticks are noise. Their value is being able to tell at a glance whether an unattended loop is healthy.
3. When a feature is blocked, the whole line changes format: `⛔ PDLC xxx blocked: needs a product decision · ⏱12m`. A loop that has stopped and is waiting for a human must be the first thing you see. That is the statusline's main job.

One command turns it on: `/pdlc-settings statusline`. It appends itself after whatever statusline command you already have and leaves the rest alone. `/pdlc-status` is the command-line view of the same data: in progress, done, and suggested to-dos, plus a relation tree if the relation index exists. It verifies rather than just listing. When three features had sat at "review done, not shipped" for over ten days, it went to the CHANGELOG and the git tags to confirm that nothing had actually shipped. `--stale 3` tabulates how many days each feature has been sitting.

That is as far as a tool goes: it puts the problem in front of you. What to do about it is a person's call.

## What does a change touch: the relation graph

Which feature extends, depends on, or replaces which: there are six relation types. Four are directed: `extends`, `depends_on`, `supersedes`, `resolves`. Two are symmetric: `conflicts_with`, `relates_to`. Nobody fills these in by hand. When `/pdlc-feature` assigns a feature ID it scans the existing features, and `/pdlc-prd` scans the requirements text for words like "based on", "extends", "depends on", and "replaces"; whatever it finds goes into the PRD and the state file with a reason attached. In one real project with three iterations, phase 2 and phase 3 both extend phase 1, and phase 1 extends the original MVP.

Run `rebuild` once and it scans the state files, builds an index of nodes and edges, and draws a mermaid graph. The MVP predates the project's adoption of pdlc and has no state file. Rather than reporting a dangling reference, rebuild kept it as a historical terminal node.

![The example project's relation graph: phase 2 and phase 3 extend phase 1, phase 1 extends the MVP; running impact on phase 1, red marks the direct downstream features and green the historical node](/assets/images/posts/pdlc-progress-impact-retro-fig-graph-en.png)

`impact` is the reason the graph exists. Run it on phase 1 and the output has three tiers: 🔴 direct impact (phase 2 and phase 3), 🟡 indirect impact (anything one hop further; none here), 🟢 historical (the MVP, audit only). It also gives advice: phase 1 is already extended by two features that have passed review, so a change to it should be a new feature that `supersedes` it, not an in-place edit, or the downstream review results become void.

The other subcommands: `query` shows one feature's inbound and outbound edges, `orphans` lists features with no relations at all, and `validate` checks five rules: dangling references, self-references, cycles, contradictory pairs, and whether symmetric relations are recorded on both sides. `set` is the only one that writes state files: add a symmetric relation and both files get a line, then the index is rebuilt.

## How did this stretch go: the retrospective

`/pdlc-retro` looks at the last 30 days by default and aggregates the history in the state files into a report: features delivered, self-check pass rate per stage, median stage duration, and sticking points, written to a monthly file under `docs/07_reviews/retro/`.

Pass rates from one real run: requirements, design, and TDD at 100%, implementation 93.8%, review 54.9%. The rate is the share of self-check items that passed. The forty-odd percent that didn't pass at review are the items flagged for a person to decide, about seven per feature.

![Retrospective for the example project: self-check pass rate and median duration for the five stages; human intervention is concentrated in review](/assets/images/posts/pdlc-progress-impact-retro-fig-retro-en.png)

That number is right. The first four stages settle everything a machine can judge, and whatever it can't judge is left for review. A low review "pass rate" means the earlier stages did their job. If review also came out at 100%, I'd want to know whether it actually looked.

Median durations: requirements 0.0 hours, design 0.1, TDD 0.6, implementation 0.9, review 5.0. Take the review figure with a grain of salt. It measures wall-clock time from entering review to finishing it, overnight hours included, not working time.

How the report handles bad data is worth noting. One feature's review had a completion timestamp earlier than its implementation. Instead of producing a negative duration, the report dropped the sample and listed it separately as "data anomaly, check the write timing". Re-run with a seven-day window that contained no activity, and all four sections said "no data" and explained why. Same rule as the false greens in the last post: if it can't be judged, say so, and never paint it green.

## The limit: they only show what was recorded

All three tools only read state files; none of them checks the code. The state files are written by the AI at the end of each stage, and they drift. When they do, the tools don't fail; they quietly show one item less or count one stage less. The example project has two cases. The check keys: older features wrote `tests_green`, newer ones use the standard `tests_pass`, and the statusline only reads the standard set, so the older features' checks don't show. And the history has no start timestamps, so durations can only be computed from consecutive completion times. Relations are the same: they're recorded automatically once, at kickoff. If the requirements change later, you `set` the new relation yourself.

So the precondition for all three tools is treating the state files as data to be maintained: fields, timestamps, and relations written to spec.

## Once you can see

Back to the opening question: the AI pushes three features in an afternoon, so how does a person keep up? Each tool answers one question, where things are, what a change touches, how the stretch went, and all the answers come from the same state files, with no digging through documents and no guessing. They don't make decisions. Whether to push a stalled feature, whether to touch a baseline, how to schedule the items review left for a person: still a human call, now made with data in hand. When the statusline is missing an item or the retro is missing a stage, suspect the records first, then the tool.

## Next post

With the three tools covered, the mechanics part of this series is done. Next time we go back to a real project and walk it from the first command to the last release, to see how all of this gets used once it's installed.

---

**Want to try it**:

```bash
curl -fsSL https://raw.githubusercontent.com/kanfu-panda/pdlc-skills/main/install.sh | bash -s -- --global
```

The repo: https://github.com/kanfu-panda/pdlc-skills

If it's useful, a star goes a long way ⭐

---

What's the longest any feature in your project has sat untouched? Comments welcome.
