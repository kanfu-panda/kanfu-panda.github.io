---
layout: post
title: "Running pdlc-skills on a Real Project: Three Features, Start to Release"
date: 2026-09-18
lang: en
categories: [blog]
image: /assets/images/posts/pdlc-on-a-real-project-cover-en.png
tags: [ai-engineering, prompt-engineering, loop-engineering, graph-engineering, pdlc, claude-code]
excerpt: "The first seven posts were about mechanics. This one is a single real run: three features handed to pdlc's own loop engine, all three at the review terminal state in 88 minutes, one failed quality gate, then a release and a deploy to two machines. How to split the work, who does what, how the loop runs, how long it took, how much it produced, and what holds quality up, answered with numbers from the event log and from git."
---

> The first seven posts were about mechanics. This one goes back to a real project and answers the six questions you only hit after the thing is installed: how to split the work, who does what, how the loop actually runs, how long it took, how much it produced, and what holds quality up. The project is a console I run for myself. Three features went to pdlc's own loop engine in parallel, all three reached the review terminal state in 88 minutes, and after the quality gate was filled in, the release went out and got deployed to two machines. The machine numbers come from the event log and from git. The hours a human spent are estimates, and I flag them where they appear.

## Where this run started

I scaffolded the project in late August with `/pdlc-bootstrap`, took it from a minimal working version to its third round of console work in five days, then left it alone for three weeks. Reopening it, I did two things before anything else. `/pdlc-test-setup` wrote the unit-test, coverage and lint commands into `test-commands.yml`, and all three have to actually run before they count. Then I migrated a few old state files to the current format. Skip those two and every "check passed" later in the run is resting on nothing. E2E had gone in the day before, with a test behind each of the 45 registered core flows. So the starting line was 421 unit tests, 52 E2E cases, 89.6% coverage.

## How to split the work

Three things to build: let a review run on a different machine, let notifications be filtered by where a task came from, and add two review flags to the benchmark runner. I'll call them cross-node review, origin filtering and benchmark flags. None of them is large, which is what makes them a reasonable test for the loop. I split them on three rules.

Rule one, split by code dependency into chains or independents. Benchmark flags needs the remote dispatch and the verdict-return path that cross-node review builds, so those two form a chain and the second waits for the first to converge. Origin filtering touches neither, so it starts immediately.

Rule two, size a feature so that three steps can finish it, those steps being TDD, implementation and review. The three features here landed between 800 and 1500 lines of diff.

Rule three, features running in parallel should not touch the same file. I did not hold this one. All three had to change the same receipt-aggregation module, and the bill came due at merge time: conflicts to resolve one at a time, about ten extra minutes.

![Three features, one dependency chain and one independent: cross-node review feeds benchmark flags, origin filtering runs on its own](/assets/images/posts/pdlc-on-a-real-project-fig-deps-en.png)

The PRDs came from `/pdlc-prd --autonomous` with a few paragraphs of raw requirements as input, 17 minutes for all three, and the command worked out the dependency between them by itself. Each PRD ends with a handful of open questions, ten across the three. The coordinating session ruled on them one at a time and wrote the answers back: what event to record when a verdict-return query fails, what error to raise when the machine you named isn't in the config. Leave those open and three separate processes will each guess differently.

## Who does what

Four roles: me, one long-lived coordinating session, subprocesses that exit as soon as their step is done, and an outer script. The coordinating session is also AI, but it writes no feature code. It coordinates and it double-checks.

![Four roles: the human sets scope and approves the release, the coordinating session drafts requirements, reviews designs, verifies and opens PRs, subprocesses do the stage work, the script schedules](/assets/images/posts/pdlc-on-a-real-project-fig-roles-en.png)

What gets built and how the parallelism is arranged is mine to decide. The coordinating session drafts the raw requirements, the command turns them into PRDs, and the coordinating session rules on the open questions.

For design, each feature gets a fresh process running `/pdlc-design --autonomous`. Three in parallel took a little over 12 minutes, and the coordinating session spent 15 minutes reviewing them and sent one back. In the benchmark flags design, the cross-node section said the dependency wasn't ready yet, so the code should reject the request and leave a record. But that feature sits on a branch cut after cross-node review, so by the time it runs the remote dispatch exists and the implementation should call it for real.

TDD, implementation and review go to the loop with nobody watching. The model is sonnet throughout, and each feature has a budget ceiling for the whole run. Once a feature converges, the coordinating session reads the diff against the design, runs the three checks itself, and opens a PR; the release, deploy and acceptance commands are its job too. What I do is merge PRs, read the quality report and the retro, and decide whether it ships. Exactly two places need a human: deciding what to build, and deciding whether it ships.

## Running the loop

pdlc's own loop engine is `/pdlc-loop-run`. Starting from the current stage, it hands each segment — TDD, implementation, review — to a fresh subagent, reads the state file after each one, and consults a fixed table to pick the next step. It stops at `review_done` and never releases anything itself. There are two layers here: one process per feature on the outside, and inside each process, loop-run dispatching one subagent per segment. The guardrails are a step cap of 4, stop on a failed step, and stop if the state didn't move.

It handles one feature at a time. Running several in parallel needs a scheduling layer around it, which here is a bash script of a little over 350 lines. It reads `depends_on` from each feature's state file to order them, starts anything without a prerequisite immediately, and for anything with one, waits for the prerequisite to converge and branches off it. Each feature gets its own git worktree, and each feature gets one process:

```bash
claude -p --model sonnet --max-budget-usd 20 --permission-mode acceptEdits \
  "/pdlc-loop-run $fid --max-steps 4 --autonomous"
```

When the process exits, the script reads the state file and commits the work. It also polls that file every 15 seconds to record when stages actually changed, because the timestamps the model writes into the state file can't be trusted.

Cross-node review and origin filtering started together. Origin filtering was the fastest: three steps, 30 minutes. Cross-node review took 51, and 13 seconds after it converged the script branched off it and started benchmark flags, which took another 37. All three reached `review_done` in 88 minutes, each in 3 steps. Nothing hit a rate limit, no step exhausted its budget, and nothing stopped along the way.

![Timeline of the three features: two parallel tracks, the duration of each step, benchmark flags starting after its prerequisite converged](/assets/images/posts/pdlc-on-a-real-project-fig-timeline-en.png)

One thing from the run is worth writing down. The three features did not agree on stage names in their state files: two wrote `review_done` at convergence, one wrote `review`, and one wrote its TDD step as `tdd_done`. Read literally, a `_done` suffix means finished, so the loop could have taken TDD for convergence and stopped there. loop-run wasn't fooled and started the implementation step as usual. But it does mean you cannot decide whether something moved forward from the stage name alone. You have to look at whether the next-step field changed.

## Time and output

Steps, machine time and diff size per feature, with new test cases in parentheses.

![Steps, machine time, code, test and documentation lines for the three features and for filling the quality gate](/assets/images/posts/pdlc-on-a-real-project-fig-output-en.png)

The three features added 3351 lines, 1770 of them tests, roughly three times the feature code itself. PRDs and designs are counted separately at 1833 lines. Unit tests went from 421 to 516, E2E cases from 52 to 65, coverage from 89.6% to 90.3%.

The whole line ran like this: draft the requirements, generate the PRDs, review the designs, start the three features, all converged 88 minutes later, merge the branches, run the quality report, red. Fill in what was missing, report passes, release v0.3.0, deploy to two machines, then acceptance on real hardware. My own time is an estimate, something like two and a half hours, spent writing requirements, reviewing designs, checking each feature after it converged, merging, and filling the gate.

## What holds quality up

With nobody watching, quality rests on four layers.

The first is an objective check on every step. Which commands a step has to run is written in `test-commands.yml`, and only the exit code counts, not the model saying it checked. The TDD step verifies that the newly written tests really fail. Implementation and review verify unit tests, coverage and lint, and two of the three features carried E2E as well. The 85% coverage threshold is a command-line argument. pre-commit runs lint and pre-push runs the unit tests, both taken from that same file. Across three features and three steps each, not one recorded check came back red.

The second is the review after convergence. The coordinating session reads the diff against the design and runs the three checks itself before opening a PR. All three diffs matched their designs, and the single correction in this run happened earlier, at design review, the one described above. Merging produced four conflicts across three files, mostly both sides adding a field, where keeping both is the answer. Then the full suite again: 516 unit tests, 90.3% coverage, 56 E2E cases, all green.

The third is the pre-release quality report. `/pdlc-quality` looks at four things: coverage, E2E core-flow coverage, lint, and a reconciliation between the PRDs and the core-flow registry. The first report was green on the first three and blocked on the fourth. The three new features contributed 19 acceptance items, and not one of them had been registered as a core flow. The report put it plainly: 45 of 45 green does not mean these three features passed the gate, it means the old 45 are still healthy. The subagents inside the loop had in fact written E2E tests for every feature. They just never registered them.

The fix is not a signature, it's the work. Nineteen items into the registry, 4 of them covered by tests that already existed, 9 new E2E tests for the rest. The second report passed all four: 64 core flows, 65 cases, all actually executed.

![Four quality layers, and the two quality reports: 19 items unregistered on the first, 64/64 passing on the second](/assets/images/posts/pdlc-on-a-real-project-fig-gates-en.png)

The fourth is acceptance on real machines after release. Both machines took the deploy and I put real tasks through them. Origin filtering was configured on the live console, with the acceptance and benchmark origins on the mute list, and every task after that carried its origin tag. The behaviour of that filter is verified in E2E: a matching origin suppresses the completion notification, failures still go out.

Cross-node review ran for real too. A review task went to the other machine, that machine executed and archived it, and this one pulled the verdict back and showed which machine had done the review. The verdict was a failure, because the claude command on that machine had never been logged in. What this layer caught was an environment problem, but it did exercise the "review failed, how does the verdict get home" path end to end. Acceptance also turned up a missing lock on the result-collection step: two processes running at once would handle the same result twice.

## Where the loop stops helping

The parts that ran fast are the parts with an objective check. The parts that slowed down or went wrong are the parts where the record was inaccurate.

Time is the clearest case. The timestamps in the state file are written by the model. The retro tool reads them and reports a median TDD stage of 2.1 hours; the real durations, recorded by the outer script's polling, were 10, 21 and 13 minutes. The inconsistent stage names above are the same problem wearing a different hat.

So don't build the outer judgement on fields the model wrote. Take durations from the event log and from git commit times, and take progress from the next-step field or from the completion marker the process prints when it exits. Those are also the two improvements this run sent back to pdlc-skills: make stage names consistent, and get timestamps from a command.

## End of the series

Eight posts: the three-layer model, getting it installed, running the loop, holding quality, making the process visible, and finally one real project from start to finish. All of it is one idea. Move the judgements you can't rely on to where there's an objective check, and a person only has to hold the two ends: what gets built, and whether it ships.

---

**Want to try it**:

```bash
curl -fsSL https://raw.githubusercontent.com/kanfu-panda/pdlc-skills/main/install.sh | bash -s -- --global
```

The repo: https://github.com/kanfu-panda/pdlc-skills

If it's useful, a star goes a long way ⭐

---

Eight posts in, thanks for reading. If you've run something like this on a real project, which part ate the most of your own time? Comments welcome.
