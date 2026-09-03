---
layout: post
title: "How pdlc-skills Keeps Quality Up When AI Writes the Code"
date: 2026-09-01
lang: en
categories: [blog]
image: /assets/images/posts/pdlc-quality-chain-cover-en.png
tags: [ai-engineering, prompt-engineering, loop-engineering, graph-engineering, pdlc, claude-code]
excerpt: "AI made writing code faster. It didn't make judging that code any faster, and that gap is the risk. So in AI-assisted development, quality assurance isn't a drag on speed; it's what makes the speed usable. This post walks through the seven-link chain I use in pdlc, one link at a time, and what the chain still can't catch."
---

> The last post covered how the loop runs on its own. The faster it runs, the sharper an old question gets: **who vouches for the quality of what the AI produces?** It doesn't get tired. In one afternoon it can write more code than a person can review in days. This post is about how I handle that in pdlc: not with one gate, but with a chain of seven links.

## Why quality matters more when AI writes the code

Code quality used to rest on two things: the person writing it had a feel for whether it was right, and there wasn't so much of it that reviewers couldn't keep up. AI removes both at once.

**It has no "feel for whether it's right."** Ask an AI to grade its own work and it grades generously. It isn't lying; it genuinely thinks it did fine. That's why in pdlc the model's self-check is recorded in its own column and never feeds into any stop-or-continue decision.

**The volume changed too.** The unattended run from the last post finished a three-phase iteration in one afternoon: four backend API groups, three frontend pages, a full set of notification rules. That used to be days of work. Output sped up; "is this correct?" did not. Same eyes, same hours.

That gap is the risk. The faster you go, the further a mistake travels before anyone notices. So quality assurance isn't the thing slowing you down; it's the brakes and steering that make the speed usable. And it clearly can't be a human reading every line, because that hands back the time you just saved.

## The short version: seven links, one chain

I split quality into seven links:

**Requirements → Design → TDD → Implementation → Unit tests → E2E → Review by a different AI**

The first two are written by AI, reviewed by AI, and checked once by a human at the end. The middle four are enforced by machine with no room for argument: TDD sets the red light, implementation is judged by exit codes, unit tests have to be plentiful, E2E guards only the core flows. The last link hands review to a different AI. The links are in series, not in parallel: if one fails, the guarantees of the ones before it are worth less. Get the requirements wrong and the strictest testing only builds the wrong thing more solidly.

![The seven links of the quality chain: requirements and design are written by AI, reviewed by AI and checked by a human; TDD, implementation, unit tests and E2E are enforced by machine; the final review goes to a different AI](/assets/images/posts/pdlc-quality-chain-fig-chain-en.png)

Here they are in order.

## Links 1 and 2: requirements and design. AI writes, AI reviews, a human checks

Counting requirements and design as quality control might seem odd, but they sit furthest upstream: they decide what every test after them is actually verifying.

Both documents are written by AI. The PRD stage has an eight-point self-check: is the background and goal clear, are there enough user stories, are the acceptance criteria measurable, does the feature list carry priorities, and so on. Fail the self-check and you don't move to the next stage. That last item looks the least important; by the time we get to false greens you'll see it's the one that bites.

Once written, a different AI reviews it first, and a human checks it last. The order matters. If a human had to write and proofread requirements and design from scratch, the faster the AI produced, the more the human would be the bottleneck, which is the gap we started with. **The human's job is to check, not to execute.**

But that check can't be skipped. Whether to build it, where the boundaries are, how to split it: those are judgment calls, and no command returns an exit code for them. That's why the autonomous loop from post 5 never touches these two links and only takes over `TDD → implement → review`. What a machine can detect goes to the machine; what it can't stays with a person.

## Link 3: TDD. Write the failing tests first

Before any code, write a batch of tests that are guaranteed to fail. This isn't "we recommend writing tests first"; it's a hard requirement. And it buys something concrete: from this moment on, "is it done?" has an answer that doesn't depend on the model. Run the tests. Exit code 0 means done; anything else means not done.

This gate only holds if the `test-commands.yml` from the last post is in place. The verdict comes entirely from running commands. The model saying "I think it's good" doesn't count here.

## Link 4: implementation. Judged by exit codes only

Now the code gets written. People assume this step can't be controlled: the AI writes it, and you can't watch every line. In fact it's the most tightly controlled step, because there's a check on the way in and another on the way out.

The way in checks one thing: **the relevant tests must exist, and they must be red right now.** This is one of pdlc's iron rules. If no tests are found, the implement command refuses to run and sends you back to TDD. "I'll write the code first and add tests later" isn't accepted.

Writing the code has one rule: the minimum code that turns the tests green, then refactor under their protection. The rule targets the laziest route an AI can take. When a test fails, editing the test is always easier than fixing the code. So the implementation stage isn't allowed to touch test files, and pdlc's automated acceptance suite has an assertion for exactly that: a modified test file is an automatic fail.

The way out has three checks: unit tests, coverage, lint. All three run real commands and read exit codes. Lint means zero warnings, not "fewer warnings than last time." The results go into the state file, and pdlc is explicit that these three fields may only hold command exit codes; the model's own assessment can't stand in for them. One failure and the stage isn't complete, and the flow doesn't advance.

![Implementation and the code review that follows it: implementation requires red tests on the way in and three exit codes on the way out; code review only accepts green tests, flags what it can't fix for a human, and writes blocked when it hits a product decision](/assets/images/posts/pdlc-quality-chain-fig-impl-review-en.png)

Getting through that door isn't the end. The code goes to review next, and review has its own entry condition: if the tests aren't fully green, review doesn't start. Between implementation and review sit the next two links.

## Link 5: plenty of unit tests, but they only prove the parts

With those two gates in place, the next job is building up the unit tests. One of my larger projects has over 4,000 unit tests and 90%+ coverage. But at that scale I'm also clearer about their limit: unit tests prove each part is correct on its own. That's all they prove.

There's a number people treat as insurance: coverage. It measures "this line was executed," not "this logic is correct." This test maxes out a function's coverage:

```javascript
it('calculates order total', () => {
  expect(calcTotal(order)).toBeDefined();
});
```

The function ran, the branches ran, the report shows green. Whether the total is right, this test says nothing. Nobody is cheating here; coverage can only see execution, never assertions. The more you use it as an acceptance criterion, the more it drifts toward "make the number look good."

So I still write 90%, but what it proves is "the tests are spread wide," not "the quality is high." For that, you need the next link.

## Link 6: E2E for the core flows

The same project has just over a hundred E2E tests for its core business flows. Four thousand to a hundred: the ratio itself tells you how the work is divided.

Production incidents are rarely one function computing the wrong value. Usually it's several individually correct parts that don't fit together: state didn't get passed, the order was wrong, the two sides read a boundary differently. Unit tests can't see this by design. They mock the dependencies away, and the problem lives between the dependencies.

So the core flows need E2E. I use Playwright driving Chrome against real pages: actually click through, actually wait for the API, actually check what rendered. It's slow and flakier, but it's the only thing that answers "does this flow still work today?"

![Unit tests mock dependencies away and verify a single part; E2E runs real pages and real APIs and verifies the whole flow still works once the parts are connected](/assets/images/posts/pdlc-quality-chain-fig-unit-vs-e2e-en.png)

`/pdlc-quality` checks E2E bluntly: every core flow has to map to a test in the mapping file, and that test has to show as passed in this run's actual results. One missing is red. "I think another test already covers that flow" isn't allowed to fill the gap; that's exactly the subjective judgment being removed.

## Link 7: a different AI reviews every stage

The last link is review, and it happens more than once: requirements review, design review, code review, each its own gate.

The key word is *different*. As noted at the start, an AI grades itself generously, and the AI that just designed something and is then asked to review it is no exception. So I start each review separately: a new session, a subagent running a different AI, sometimes a different model. A reviewer with clean context sees what the author can't. The author's mental footnotes ("I considered that, here's why") don't exist in the new session, so whatever the design document actually fails to say finally shows.

![Self-review in the same session is grading your own homework; a subagent running a different AI has clean context and actually finds things](/assets/images/posts/pdlc-quality-chain-fig-review-swap-en.png)

Code review is the most detailed of the three. It checks the implementation against the design document item by item: do the API parameters and return shapes match, is error handling consistent, is there string-built SQL, are there missing auth checks, list endpoints without pagination, N+1 queries. What it can fix on the spot, it fixes. What it can't, such as architectural trade-offs or disputes about business logic, goes into the report marked for a human.

The reviewer is still an AI, not a person. Human time shouldn't go to "read the whole thing and look for problems"; an AI can do that. People handle only the few points it reports and isn't sure about. When review hits something that needs a human decision, pdlc stops and writes `blocked`. The "three config fields with no backend consumer" case from post 5 was caught exactly this way.

## Seven links in place. Now guard against false greens

Chain complete, report all green: can you trust it? Not yet. The dangerous state was never red; red is at least honest. The dangerous state is a false green: everything looks fine while something underneath has already gone wrong.

There are two kinds, and neither is fixed by trying harder.

**One: the list rots.** The E2E coverage matrix compares against a "core flows list," and someone has to remember to update the list. Add a new core flow, forget to add it to the list, and the matrix stays green. It has turned "we don't know" into "we've covered it." That's worse than no check at all, because it comes with a green report that lets you keep being wrong in comfort. The fix is a forced reconciliation against the PRD on every run: in the PRD but not on the list means red, directly.

**Two: "can't be judged" gets read as "no problem."** Remember the least impressive item on the PRD self-check, that feature lists must carry priorities? The reconciliation keys off those P0/P1 marks. If a PRD never had them, extraction yields an empty set; compare that to the list and there's zero drift, so the report says "reconciliation passed." What actually happened is that the entire PRD never entered the check. Old PRDs are the usual victims, and old PRDs are exactly the ones behind the flows already in production.

![Two sources of false green: list rot lets new flows slip through silently, and a PRD without priority marks never enters the check at all; both produce a green report](/assets/images/posts/pdlc-quality-chain-fig-false-green-en.png)

So the rule changed: any PRD that skipped reconciliation for lack of priority marks must be listed separately as a warning, and the reconciliation item can't be marked passed, only "⚠️ no drift, but N PRDs could not be judged." It's the same principle as post 3's "no command to run means leave the cell empty, never fill in pass": if you can't measure it, write "not measured," and never let a blank pose as green.

## What this doesn't catch

Seven links plus false-green guards still leave things out of reach.

**If the requirements themselves are wrong, it's green anyway.** The chain guarantees "what you meant to build was built solidly," not "this was the right thing to build."

**It doesn't guarantee you actually set everything up.** I have my own counterexample: a smaller project where unit tests and E2E both run, but coverage tooling was never configured. With a link missing, you don't get to say "quality is assured." Installing pdlc doesn't make you compliant; it lists what needs doing.

**A human still signs off.** `/pdlc-quality` only turns measured data into a report you can verify. It doesn't rule on pass or fail; whether to ship is a person's call. If the party writing the code is also the party ruling on it, everything that put the machine in charge of the verdict is pointless.

## What this buys

Back to the gap from the start: AI made output faster and judgment didn't keep up. What these seven links do, in the end, is speed up judgment until it keeps pace.

For me personally, the result isn't "no bugs"; nobody can promise that. The result is **I'm willing to let it run by itself**. That unattended afternoon in the last post finished a three-phase iteration with me stepping in three times. Not luck: I know a mistake will get stopped at some link instead of waiting for a user in production to find it.

The AI will still make the mistakes it was going to make. What the chain does is bring them into the open early, while each one is still a bug and cheap to fix, not after it has become an incident.

## Next post

Next time, a change of direction: **visibility**. How to record dependencies between features, how to tell what a change will touch, whether you can see the state of the project at a glance, and how to keep retrospectives around.

---

**Want to try it**:

```bash
curl -fsSL https://raw.githubusercontent.com/kanfu-panda/pdlc-skills/main/install.sh | bash -s -- --global
```

The repo: https://github.com/kanfu-panda/pdlc-skills

If it's useful, a star goes a long way ⭐

---

This seven-link setup is what I've arrived at on my own projects; it won't fit everyone. If you run a leaner combination, or think one of these links can go, I'd like to hear about it in the comments.
