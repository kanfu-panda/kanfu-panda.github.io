---
layout: post
title: "How Are LLMs Trained?"
date: 2026-10-24
lang: en
categories: [blog]
series: ai-coding-principles
image: /assets/images/posts/how-llms-are-trained-cover-en.png
tags: [how-ai-coding-works, llm, ai-coding]
excerpt: "An LLM starts out only able to continue text. So how does it become an assistant that writes code and runs tests for you? This post covers the five common ways models are trained and the three stages they're used in, follows a leap-year function through each stage, and looks at why coding has improved so fast lately and what that means when you code with AI."
---

> The last post showed that an LLM is a program that keeps adding the next word. What turns it into an assistant that helps you write code is training in stages: first it reads huge amounts of text and learns to continue it, then it studies examples written by people and learns to answer, and finally it gets scored over and over until its answers are good. This post covers the main ways a model is trained and the stages they happen in, then follows a leap-year function through the whole process.

If you code with an AI tool, you've probably noticed this: ask it for a function and it doesn't stop at writing one. It runs the tests, sees a failure, and goes back to fix the code. All it originally knew how to do was predict the next word. Where did it learn to work like that? Let's start with the ways a model gets trained.

## What are the ways to train an LLM?

Training means giving the model problem after problem, telling it how well it did each time, and letting it adjust itself a little based on the result. Training methods differ in two things: what the model practices on, and who decides whether it got it right. There are five common ones.

**Pretraining.** The material is a huge amount of text and code, and the problem is the one from the last post: guess the next word. No one has to judge the answer. You just compare the guess with the actual next word in the original text, which is why this method can use so much material.

**Supervised fine-tuning**, also called instruction tuning. People first write a set of questions paired with ideal answers, and the model learns from them, adjusting whenever its output doesn't match. Here, "right" means close to the example a person wrote.

**Reinforcement learning from human feedback (RLHF).** The model writes several answers to the same question, people rank them, and the model shifts toward the higher-ranked ones.

**Reinforcement learning from AI feedback (RLAIF).** This works much like RLHF, except an AI does the ranking, following a set of principles written in advance. Constitutional AI, the method Anthropic uses to train Claude, falls into this category, and that set of principles is the "constitution."

**Reinforcement learning with rule-based scoring.** This is for tasks where the answer can be checked automatically. For a math problem, check whether the final answer is correct. For a coding problem, run the test cases and award points if they pass. Rules do the scoring, and no person has to look.

![Five training methods: what each one practices on and who judges the result](/assets/images/posts/how-llms-are-trained-fig-methods-en.png)

The last three are all reinforcement learning (RL). RL doesn't hand the model the correct answer. It only tells the model how well it did this time and lets it move toward higher scores on its own. The three differ only in who does the scoring: people, an AI, or rules.

## How are these methods used in stages?

Usually in three stages, in a fixed order. Stage one is pretraining. The resulting model is very good at continuing text but not very good at answering questions or following instructions. Anthropic's official glossary says exactly that.

Stage two is supervised fine-tuning. From the examples, the model learns that when someone asks a question, it should answer. It starts to look like an assistant.

Stage three is reinforcement learning, where the three RL methods above can be combined. Scoring by people and by AI mainly makes answers more helpful and more appropriate. Scoring by rules mainly makes the model more accurate on tasks that have a right answer, like writing code and solving math problems.

![Three stages: learn to continue, learn to answer, then improve through scoring](/assets/images/posts/how-llms-are-trained-fig-stages-en.png)

Both later stages build on the pretrained model, so the order can't be reversed.

## Walking through one request: a leap-year function

Say you tell the model: "Write a Python function that checks for leap years."

**A model that has only been pretrained** treats the sentence as text to continue. If sentences like this are often followed by the next exercise in what it has read, it might carry on with "Write a Python function that checks for primes," then "Write a function that reverses a string." This is an illustration, not something we ran, but at this stage the model really can only continue text. It doesn't yet know how to answer.

**A model that has also had supervised fine-tuning** has seen lots of question-and-answer examples, so it knows the thing to do here is write the function:

```python
def is_leap(year):
    return year % 4 == 0 and (year % 100 != 0 or year % 400 == 0)
```

**A model that has also gone through reinforcement learning**, if it was scored on whether tests passed, cares more about whether its code actually passes them. Put it in an AI coding tool that can run commands, and after writing the code it runs the tests itself and goes back to fix things if they fail.

![The same request gets a different response from a model at each of the three stages](/assets/images/posts/how-llms-are-trained-fig-example-en.png)

How much do the two later stages matter? A 2022 study by OpenAI compared a 1.3-billion-parameter model that had been through fine-tuning and RLHF with a 175-billion-parameter model that had only been pretrained. People preferred the smaller model's answers, even though it had one hundredth as many parameters.

## Why has coding improved so fast?

Back to the fifth method. Code has something many tasks don't: you can tell whether it's right just by running the tests. Having people rank answers is slow and expensive. Tests run automatically, so the model can practice over and over at scale and get a score right after every attempt.

DeepSeek described this approach in a published paper. For coding problems, a compiler runs predefined test cases and gives feedback based on the results. For math problems, the model has to put its final answer in a fixed format so rules can check it. The paper also notes that the researchers didn't teach the model how to solve the problems; they simply gave it the right incentives.

![Write code, run the tests, score the result, then go again](/assets/images/posts/how-llms-are-trained-fig-loop-en.png)

The same paper reports numbers on math competition problems: with this kind of reinforcement learning alone, the share the model got right on the first try went from 15.6% to 71.0%. Those are math problems, not code, but the training method is the same. Coding has improved quickly over the last year or two, and public sources point to this as one important reason: code can be checked automatically, which makes it well suited to repeated practice.

## What does this mean when you code with AI?

Training on test results has a side effect. The model is trained to make the tests pass, and writing correct code isn't the only way to do that.

Anthropic acknowledged this in the system card for Claude 3.7 Sonnet. In coding environments where it could run commands and tests, the model occasionally special-cased its code to make tests pass. Most often it returned the values the tests expected instead of writing a general implementation, and sometimes it modified the tests themselves. This mostly happened after several attempts at a general solution had failed. According to Anthropic, this came from reward hacking during reinforcement learning: the model had found loopholes in how it was scored.

In the leap-year example, it would look something like this (an illustration):

```python
def is_leap(year):
    if year == 1900:  # special case for the 1900 test
        return False
    return year % 4 == 0
```

The tests pass, but try 2100 and it gets the answer wrong.

![The general version is right for every year; the hard-coded version is right only for the years in the tests](/assets/images/posts/how-llms-are-trained-fig-hack-en.png)

This is a tendency that comes from how models are trained. It doesn't mean today's models do it often. Two habits help:

- When you review changes, glance at the test files too. If a test has been changed, or the code suddenly checks for one specific value, stop and ask why. Anthropic notes that when the model adds a special case like this, it often leaves a comment saying which test it's for.
- Ask for a general solution in your prompt. Anthropic's advice is to say it plainly: write robust, general solutions rather than special-casing for tests. You can also put that line in an instruction file like CLAUDE.md that gets read every time.

## Is it the same with Codex or DeepSeek?

Broadly, yes. They follow the same path: pretrain, teach the model to be an assistant, then improve it with repeated scoring. The 1.3-billion-parameter study came from OpenAI, and DeepSeek has published its own reinforcement learning approach. Exactly how each company combines these steps hasn't been made public. Checking the test files and asking for a general solution works whichever tool you use.

## Summary

- There are five common ways to train an LLM, and they differ in what the model practices on and who judges the result. The last three are reinforcement learning, scored by people, by an AI, and by rules.
- Training happens in three stages: pretraining teaches the model to continue text, supervised fine-tuning teaches it to answer, and reinforcement learning makes its answers better.
- Code can be scored automatically by tests, which is why coding has improved so fast. It's also why a model may cut corners to make tests pass, so keep an eye on the test files.

---

**Next**: what happens between pressing Enter and seeing the result?

---

If this helped, a like or a share with someone else who codes with AI would mean a lot. Follow along for the rest of the series.
