---
layout: post
title: "AI getting dumber the longer you chat? It's not the model—time to take control"
date: 2026-06-18
lang: en
categories: [blog]
image: /assets/images/posts/tier-models-trim-context-cover-en.png
tags: [claudecode, ai, tokens, context, productivity]
excerpt: "The last two posts were about saving tokens before things hit the context. This one's about two things you do mid-session—one decides who does the work (model tiering), the other decides how much memory it carries (context management). When the AI gets dumber as you go, it's usually not the model."
---

One day I had the AI keep building out a feature, and partway through something felt off: replies got slower, it started rambling, it re-asked things I'd already told it, and with the work clearly unfinished it told me "all done, you can take a break now."

At first I figured the model was just having an off day. Then I looked at the context—it had crept past 80%. I'd been so busy pushing forward I forgot to clear it. Cleared it, asked again, and instantly it was sharp again: fast and on point.

That's when I started taking this seriously. The last two posts were all about squeezing the volume down *before* things hit the context—that's pre-work. This one is about two things you do *after* you start, mid-session—they decide how many tokens the same work costs, how fast it runs, how stable it stays.

## There are actually two knobs in one conversation

There are two knobs you can turn mid-session, pointing in different directions.

One is horizontal: within a single task, different chunks of work should go to different "brains." Grunt work like exploring and searching doesn't need the priciest model; only the parts that genuinely need thinking—writing code, making judgments—are worth putting the good model on. I call this **model tiering**.

The other is vertical: how much you stuff into the same brain at once. The fatter the context, the more the model has to recompute that whole pile every turn—slow, expensive, and error-prone. Managing how fast it grows and when to clear it is **context management**.

What these two save lands in two different places: on pay-as-you-go it's real cash; on a flat monthly plan it's quota headroom. I use both, so both moves are a double saving for me. Let me take them one at a time.

## Don't put the priciest model on all the work

Start with the horizontal one.

Once I was about to dispatch a batch of subagents on a project, still on pay-as-you-go API billing, and the budget was a bit tight. So I tried a cheapskate move: design-and-code-from-the-plan went to Sonnet, the relatively mechanical unit tests went to the cheaper Haiku, and I left the top model (Opus) to oversee overall progress and quality with a review pass.

It worked surprisingly well. Saved a good chunk of tokens, and it was noticeably faster too—the cheap small models are quick by nature, so handing grunt work to them lightened the whole pipeline. The most expensive compute only got spent where it mattered most.

This split isn't set in stone. Which work gets which tier, I wrote straight into CLAUDE.md (both user and project level), so the AI tiers itself each time without me assigning by hand. If a step feels especially critical, I can also name a specific model for it on the spot, for more precision. The principle is one line: don't use a cannon to swat a mosquito—and don't bring a slingshot to a tank.

![Model tiering: one task split horizontally across model tiers—grunt work like exploring, searching, and running unit tests goes to the cheap fast small model; design and code-writing to the mid-tier model; overall oversight and review to the top model, so the most expensive compute only gets spent where it matters most](/assets/images/posts/tier-models-trim-context-fig-tiering-en.png)

## Mid-conversation, remember to clear its head

Now the vertical one—the actual culprit behind that "getting dumber" opening.

Context just keeps climbing; leave it alone and it keeps getting fatter. My own approach is two lines: around 50% I start paying attention, and by 70% I almost always clear once. The usual rhythm—the moment the task at hand is done, I clear while things are clean, so the next stretch of work travels light, sharp and fast.

To be clear: these two lines, and the "dumber by 80%" from the opening, are just my own feel and habit, not some hard metric. It works for me, but the vendors and other people may not see it this way—you can absolutely set your own pace. I'm only suggesting: don't just let it climb forever unmanaged.

The clearing step has one trap worth flagging: `/compact`, `/clear`, or just opening a new session does clean up the context, but done carelessly the model forgets everything it just did, and you're re-explaining from scratch. My fix—before clearing, have it jot down the current state: where it's at, what's next, and which key decisions are already locked in. Write that handoff well before clearing, and the new session catches up at a glance instead of staring blankly.

Honestly, the handoff has basically never failed me so far. On the off chance it doesn't catch—no panic—I just have it re-analyze, give me a conclusion, and I verify and judge it myself. Small loss.

![Mid-session, clear the context's head: context keeps climbing; at my own warning line (around 50%) I start paying attention, at my clear line (around 70%) I clear once—but these two lines are just my personal habit, for reference only. Before clearing, have it jot a handoff (where it's at / what's next / key decisions), then compact or open a new session, which catches up at a glance](/assets/images/posts/tier-models-trim-context-fig-context-en.png)

## A side note: read precisely, carry less

The above is about managing what's already in. There's another layer: making what comes in small and precise to begin with.

I've got tools like codegraph and claude-mem running on these projects. In short, they take the AI from "read the source cover to cover, scan everything" to "hit just the core bits, pick up the memory saved from prior sessions"—scan less, and what enters the context naturally slims down.

I'm only mentioning this in passing, not unpacking it. For one, unpacking the details turns into a sales pitch; for two, these aren't the only such tools out there—there may well be better ones I just haven't used and don't know about. If you know a handy one, use it; the idea carries over: let the model read precisely, and it won't have to haul so much along.

## A few honest words

Saving is saving, but I should state the limits, or this turns into another all-good-news piece.

The worry people have most with model tiering: won't the small model get things wrong? It will. But I left the top model on a final review pass, so the small model's occasional slip-up mostly gets caught there—no big errors so far. The catch is you can't skip that review: skip it, and the tokens you saved with tiering eventually get paid back.

Same on the context side: clear too often, write the handoff too sloppily, and you'll still lose things. So I don't clear mindlessly on a timer—I pick a clean moment right after a task wraps, and jot the handoff while I'm at it. The point of saving tokens is to cut the real waste, not to cut the memory that should travel along.

## Recap: three things to just do

What you can actually act on here is three:

One, don't put the priciest model on all the work. Hand grunt work (exploring, searching, running tests) to a cheap small model, spend the good steel on writing code and making judgments, and keep a top tier on the final review. Write the standard into CLAUDE.md so the AI tiers itself.

Two, don't let context climb forever. Set yourself a line—mine is 50% attention, 70% clear, yours can be your own; clear once whenever a task wraps, don't wait until it's bloated and dumb.

Three, before clearing, have it write a handoff. Where it's at, what's next, key decisions—write it down before you compact or open a new session, and the relay won't drop.

One thing you can do today after reading this: open your CLAUDE.md, hard-code a few rules for "which model does which work," and set yourself a context red line you clear past. The two together take under ten minutes, but every conversation after that keeps saving for you.

Next time I want to talk about prompts themselves—the same task, said differently, comes out at noticeably different quality; plus how to orchestrate multiple agents working together. If you're interested, let me know in the comments.
