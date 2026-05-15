---
layout: post
title: "PDLC: turn AI-assisted development from soft conventions into hard contracts"
date: 2026-05-15
lang: en
categories: [blog]
tags: [PDLC, Claude Code, AI engineering, workflow, open source, MIT]
excerpt: "AI says 'I built the feature' but the PRD only lives in the chat transcript. Tests get 'added later'. Across sessions, nobody remembers which stage anything is at. PDLC fixes these via 31 standardized stages + an Iron Law of 5 invariants. From motivation to implementation to applied use cases to outcomes — one read."
---

## Motivation: AI's recurring engineering bad habits

You've probably run into all of these:

- You ask the AI to build a feature. It says "done", **but the PRD lives only in that chat transcript**. Close the window and it's gone. Next time you want to revisit "why did we design it this way?", all you have is the commit message.
- You ask it to write tests after the implementation. It happily produces **tests that pass 100% — because they were written against the finished code**. They don't constrain the design at all.
- It skips the design step entirely. **Architectural drift goes undetected**. Three months later you try to add a feature and discover the code no longer looks like the plan.
- Across sessions, **there is no memory**. "Where are we on feature X?" — you have to keep that in your head.

What's the underlying issue? **AI assistants treat engineering process as soft conventions** — easy to skip, easy to forget.

[PDLC](/pdlc/) (**P**roduct **D**evelopment **L**ife **C**ycle) is a Claude Code plugin whose entire purpose is one thing: **upgrade those soft conventions into hard contracts**. Once an AI works inside PDLC, it **cannot** skip the PRD, cannot write code before tests exist, cannot forget which stage anything is at.

## Implementation: three layers + Iron Law + state machine

### 31 commands, three layers

| Layer | Count | Role |
|---|---:|---|
| Layer 1 · Entry points | 3 | `/pdlc-feature`, `/pdlc-fix`, `/pdlc-status` — one-sentence prompts drive the whole chain |
| Layer 2 · Stages | 11 | `/pdlc-prd`, `/pdlc-tdd`, `/pdlc-implement`, `/pdlc-review`, `/pdlc-ship`, etc. — fine-grained per-stage control |
| Layer 3 · Tools | 17 | UI / DB / architecture / security / perf / code-gen / i18n / migration and other specialized tools |

In day-to-day use, Layer 1 is what you reach for:

```bash
# Inside Claude Code
/pdlc-feature add a captcha to login
```

That single command takes you through PRD → Design → TDD red light → Implement → Review → Ship. Every stage is forced to satisfy the Iron Law.

### Iron Law: five invariants

Every Layer 1 / Layer 2 stage that **produces artifacts** must satisfy:

1. **Artifacts persist to disk** — not just chat output; a real file lands under `docs/`
2. **State machine updates** — every completed stage writes `docs/.pdlc-state/<feature-id>.json`
3. **Tests first** — implementation is blocked until failing tests exist (TDD red light)
4. **Self-check** — every stage runs a self-audit before handing off
5. **One-shot auto-repair** — auto-fix runs at most once; stubborn failures escalate to humans

These are **enforced**, not suggested. Layer 1 / Layer 2 artifact-producing stages cannot skip them — skipping triggers self-check failure.

### State machine: one per feature

Every new feature (`/pdlc-feature ...`) gets an ID like `F20260515-01` and a corresponding file:

```
docs/.pdlc-state/F20260515-01.json
```

Sample content:

```json
{
  "feature_id": "F20260515-01",
  "slug": "captcha-login",
  "current_stage": "implement",
  "history": [
    {"stage": "prd", "ts": "2026-05-15T10:30:00Z", "self_audit": "8/8 passed"},
    {"stage": "design", "ts": "2026-05-15T11:05:00Z", "self_audit": "6/6 passed"},
    {"stage": "tdd", "ts": "2026-05-15T11:40:00Z", "tests_written": 14, "all_failing": true}
  ],
  "next_step": "/pdlc-implement"
}
```

The value? **Cross-session continuity for every feature.** Open Claude Code tomorrow, run `/pdlc-status`, and you see "F20260515-01 is at implement, next step is review." It doesn't depend on your memory or the AI's context window.

### Target-project layout

PDLC reads and writes these paths in your project:

```
docs/00_standards/coding/                          # coding standards (read-only)
docs/01_requirements/prd/                          # PRDs
docs/02_design/{api,database,architecture,ui-ux}/  # technical design
docs/03_development/                               # developer manuals
docs/04_testing/{unit-tests,e2e-tests,defects,...} # tests & defects
docs/05_deployment/                                # deployment docs
docs/06_tasks/                                     # in-stage task tracking
docs/07_reviews/{doc,code,design,retro}/           # review records
docs/.pdlc-state/<feature-id>.json                 # per-feature state machine
```

Everything is a real file on disk. You can `git diff` what the AI wrote in the PRD stage a week ago.

## Applied use cases

### Case 1: ship a feature end-to-end

```bash
# Inside Claude Code
/pdlc-feature add phone-number verification to login
```

PDLC automatically chains:

```
→ Allocating feature ID F20260515-01 (user-auth-phone)
→ Stage 1: writing PRD
   ✓ docs/01_requirements/prd/F20260515-01-user-auth-phone-prd.md
   ✓ self-check 8/8 passed
→ Stage 2: technical design
   ✓ docs/02_design/api/F20260515-01-user-auth-phone-api.md
   ✓ docs/02_design/database/F20260515-01-user-auth-phone-db.md
→ Stage 3: TDD red light
   ✓ 14 tests written, all failing as expected
→ Stage 4: implementation
   ✓ 14/14 tests now passing
→ Stage 5: code review + auto-repair
   ✓ 3 lint issues auto-fixed
   ✓ docs/07_reviews/code/F20260515-01-user-auth-phone-review.md
→ Stage 6: handoff
   📦 docs/.pdlc-state/F20260515-01.json updated
   👉 Next: /pdlc-ship
```

After running this you have, in your git working tree: 1 PRD, 2 design docs, N test files, 1 review record, 1 state-machine update, plus the actual code change. **All real files**, not just chat.

### Case 2: fix a bug with a full audit trail

```bash
/pdlc-fix the pagination crash on empty lists
```

PDLC doesn't just "look around and change two lines". It walks:

1. **Locate**: search the code for the likely cause
2. **Reproduce**: write a stable repro test first (filed under `docs/04_testing/defects/`)
3. **Fix**: only then edit the code
4. **Verify**: repro test goes green
5. **Record**: defect report archived

When a similar bug reappears in six months, you can `grep` past defects to see how you fixed it before.

### Case 3: see the whole project at a glance

```bash
/pdlc-status
```

Approximate output:

```
Project PDLC status (read from docs/.pdlc-state/):

F20260512-01  user-auth-phone     ✓ shipped
F20260513-01  captcha-login       ⏵ in review
F20260514-01  password-reset      ⚠ stuck in TDD (3 tests failing)
F20260515-01  email-verify        ⏵ in PRD
```

No more chasing the AI with "where are we?" — just read the state machine.

## Outcomes: what you actually get

### 1. Engineering documents land alongside your code

Every PRD, every design doc, every review record is a real file in git history. A year later you can pin down *why we did it this way / how the design was decided / what review caught*. **A step-change in long-term maintainability.**

### 2. TDD actually happens, not just lip service

Implementation is blocked by failing tests. The AI wants to skip? Can't — not just by rule, but **enforced by the state machine**.

### 3. Auto-repair runaway risk gets capped

Many AI tools have a quiet bug: **fix → check → not fixed → fix again → break something else → fix again…** infinite loop, burning tokens and time. PDLC forces "auto-repair runs at most once" — when stuck, the AI stops and surfaces to a human.

### 4. Cross-session engineering continuity

Today you reach the implement stage; tomorrow `/pdlc-status` tells you the next step. **No dependency on the conversation context window**, no dependency on your memory.

### 5. Legacy projects can join too

New projects are easy to bootstrap from scratch. Legacy ones are the painful case. PDLC has `/pdlc-adopt`, which surveys an existing codebase — **without rewriting your code** — fills in missing standards / design docs / directory structure, and gets the project to a point where PDLC stages can take over from there.

## Getting started

Full install steps, command catalog, customization, and FAQ are on the [PDLC product page](/pdlc/) and in the repo.

**One-liner**:

```bash
curl -fsSL https://raw.githubusercontent.com/kanfu-panda/pdlc-skills/main/install.sh \
  | bash -s -- --global
```

Then in Claude Code:

```
/pdlc-feature <one-sentence description of what you want>
```

Repo: [**github.com/kanfu-panda/pdlc-skills**](https://github.com/kanfu-panda/pdlc-skills) (MIT)

## A bit of design philosophy

PDLC isn't "add an AI assistant" — it's **the continuation of pre-AI engineering discipline**:

> Decades of software engineering boil down to "process discipline". When AI shows up, the discipline doesn't go away — it has to be **enforced by tools** that AI can't slip past.

If "AI finished the code = project delivered" feels like a dangerous simplification to you, PDLC is probably what you've been looking for.

Try it out. Questions go to [GitHub Discussions](https://github.com/kanfu-panda/pdlc-skills/discussions), or reach me via the [About page](/about/).
