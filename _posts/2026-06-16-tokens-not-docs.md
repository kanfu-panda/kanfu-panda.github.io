---
layout: post
title: "Your docs aren't burning your tokens — your tooling is"
date: 2026-06-16
lang: en
categories: [blog]
image: /assets/images/posts/tokens-not-docs-cover.png
tags: [claudecode, ai, tokens, workflow]
excerpt: "People keep asking: with all those PDLC docs, aren't you burning tokens? Having lots of docs and burning tokens are two different things — and if you want to save tokens, the answer is using your tools right, not cutting docs."
---

People keep asking me the same thing about running projects with PDLC: with all those docs — PRD, design, review at every step — aren't you burning tokens like crazy?

It's a fair question. The process is broken into fine-grained stages, each leaving an artifact behind, and that does look more expensive than just "letting the AI write the code." But I'd argue you can't put the token bill on the docs.

Let me put the conclusion up front. First: having lots of docs and burning lots of tokens are two different things. Second: even if you genuinely want to cut tokens, the answer is using your tools correctly, not cutting the docs.

I haven't measured tokens precisely — I didn't run the same project twice, with and without docs, to get a clean percentage. What I have is hands-on experience and methods.

## The token bill isn't PDLC's fault

Before you settle the bill, find the right debtor.

Most of the time, burning tokens isn't caused by PDLC — it's tooling used wrong. And "wrong" is concrete, in three places:

- **Context**: not clearing it when you should. One conversation running from morning to night, tens of thousands of tokens of history recomputed every single turn. You're asking a new question and paying off old debt.
- **Prompts**: too vague. The AI keeps guessing what you actually want; something you could have said once takes three rounds.
- **Tool calls**: making it read the whole repo when you're only changing one file.

And the most common one: never turning on the token-saving methods at all, then blaming the process for being heavy.

You can't charge any of this to "PDLC has too many docs." Docs sit quietly in `docs/` and never burn a single token on their own. What burns tokens is the usage above.

## What actually burns tokens is rework

In my own experience, the biggest token sink has never been generating docs — it's rework.

Rewriting because the direction was wrong, tearing things down because the requirement was misread, going back because fixing one thing broke another — every one of those round-trips is real tokens. Generating a PRD is a one-time cost; rework from a wrong direction compounds.

This heavy-looking PDLC process is precisely trading "write a bit more up front" for "rework a lot less later." Once you are using it, the whole flow is steadier and so is the final output — no back-and-forth. Less rework is, in itself, fewer tokens burned.

So here is how I see it: docs aren't a cost, they're an asset. They leave a trace of the design decisions and the why, so you can trace back and audit. Next time the AI picks it up, it reads the docs and gets it — I don't re-explain from scratch. That saved stretch is, again, tokens.

![A change that left docs behind: the AI reads them once and carries on, burning fewer tokens. With no trace, it forces rework and rewrites — and rework compounds, which is what actually burns the tokens](/assets/images/posts/tokens-not-docs-fig1-en.png)

## So where should you actually save tokens

Saving tokens isn't about not writing docs — it's saving where saving belongs. The ones I actually use on my machine, roughly:

- **Trim context**: clear it when you should; don't drag tens of thousands of tokens of history through every turn.
- **Tier your models**: don't use a cannon on a mosquito. Hand the grunt work — exploring, searching, reading files — to a cheap small model; only bring out the strongest tier for the real thinking, analysis and code.
- **Read files precisely**: only read what's relevant to this change; don't reflexively "read the whole project."
- **Prompt caching**: the cached portion is billed at a discount, and it isn't a 1:1 linear relationship — used well, the savings are noticeable.
- **Put a token proxy in front of routine commands**: for high-frequency ops like `git status`, squeeze the output; it adds up.
- **Parallelize**: fire off independent work at once, fewer round-trips.

Not one of these is "write fewer docs."

![Saving tokens lives in three layers — context (clear when you should / read precisely), model (grunt work to a small model / caching discount), and tooling (proxy routine commands / parallelize). Not one is "write fewer docs"](/assets/images/posts/tokens-not-docs-fig2-en.png)

## Not every change needs the full process

That said, PDLC doesn't mean running the full suite on every change.

A one-line bug fix — do you need a PRD, a design review? Depends; most of the time there's no need for the heavy process, so trim it. The criterion is simple: is this change worth leaving an asset for? If yes, run the full thing; for one-off small fixes, nobody blames you for cutting a few steps.

And "saving tokens = saving money" needs to be said per billing model, or it misleads:

- On a **flat monthly subscription** with a fixed quota, what you save is **quota headroom** — the same money does more work.
- On **pay-as-you-go API**, you save **actual cash** — every token hits the bill.

I use both. Figure out which one you're on first; that's what tells you what "saving tokens" actually means for you.

![PDLC doesn't need the full suite on every change: a one-off small fix trims the process; only something worth maintaining long-term runs full PDLC — and there the docs are the asset](/assets/images/posts/tokens-not-docs-fig3-en.png)

## Finally

To sum up: lots of docs doesn't equal burning tokens; if you really want to save, save on how you use your tools, not on the docs.

The one thing I most want to say: docs are an asset, not a cost. Trying to save tokens by "not writing docs, just letting the AI emit code" looks like savings short-term, but the project won't go far — no trace, no traceability, and two months later you can't even say why you designed it this way. The rework then burns far more than the doc tokens you saved.

One thing you can do today: look back at whether you've turned on the token-saving methods — is your context trimmed? Are you still sending everything to the strongest model instead of tiering? Did you cut the costs you could? And while you're at it, ask whether you're using PDLC well too.

There's a lot more to unpack on saving tokens — how exactly to tier models, when to clear context, how to actually land the caching discount. I'll pick one and go deeper next time.
