---
layout: post
title: "What Is an LLM, Really?"
date: 2026-10-19
lang: en
categories: [blog]
series: ai-coding-principles
image: /assets/images/posts/what-is-an-llm-cover-en.png
tags: [how-ai-coding-works, llm, ai-coding]
excerpt: "You use AI to write code every day, but what is the large language model on the other end? In one sentence: a program that keeps adding the next word. Using a single line of Python, this post shows how it writes code one word at a time, why next-word prediction is enough to write programs, and what that means when you code with AI."
---

> You use AI to write code every day. So what is the large language model (LLM) on the other end, really? The short answer: it's a program that keeps adding the next word. It reads the text so far, works out what is most likely to come next, adds it, and then does it again. That's the whole job, and it's enough to write code, answer questions, and fix bugs. This post walks through how, using a single line of Python.

Ask an AI a question and you've probably noticed that the answer doesn't appear all at once. It trickles out a little at a time, and code shows up line by line. It looks like a typing effect someone added to the interface, but this is simply how the model works: it writes one small piece, then the next.

Why does it work that way? Let's start with what it does at each step.

## What does it do at each step?

Here's some half-written Python, with the cursor sitting right after `return`:

```python
def add(a, b):
    return
```

What comes next? If you write code, you barely have to think: `a + b`. The function is called add and the parameters are a and b, so `a + b` is the natural fit.

An LLM does the same thing. It reads everything before the cursor and scores every possible continuation: `a + b` scores high, `a - b` lower, `None` lower still. Then it picks one and adds it.

![The model reads the preceding text and gives each candidate a likelihood](/assets/images/posts/what-is-an-llm-fig-next-en.png)

Anthropic's official glossary puts it the same way: the model underneath Claude was trained to predict the next word given the text that comes before it.

## How does one word become a whole function?

One word on its own doesn't get you far. The trick is a loop: the model appends the word it just predicted to the text, then uses that longer text to predict the next one.

Once `a` is added, the text ends in `return a`, and the most likely next piece is `+`. Add `+`, and it predicts `b`. After that, it decides the function is finished and stops. Whole functions and whole answers are built this way, one word at a time. The trickle you see in the chat window is this loop moving forward.

![Each predicted word is appended to the text, and the model predicts the next one](/assets/images/posts/what-is-an-llm-fig-loop-en.png)

Strictly speaking, each piece isn't always a full word. It might be part of a word, or a single symbol. The real unit is called a token. To keep things simple, this post just says "word."

## If it only predicts the next word, how can it write code?

At this point you might be thinking: isn't that just the autocomplete on your phone keyboard?

The difference is how accurate the guess has to be. To predict `a + b` after `return`, the model has to know that add means addition and how a Python function is written. In longer code, it also has to keep track of which variables were defined earlier and what each function does.

During training, an LLM reads an enormous amount of text and code. The only way to get good at predicting the next word is to pick up the patterns along the way: grammar, general knowledge, how code is written. CSET, a research center at Georgetown University, explains it the same way: a task as simple as next-word prediction pushes the model toward a broad grasp of language, and that grasp carries over to many other tasks.

![To predict the next word well, the model picks up all kinds of patterns from huge amounts of text](/assets/images/posts/what-is-an-llm-fig-learn-en.png)

There's something more surprising, too: the model doesn't work purely one step at a time. In 2025, Anthropic published research that looked inside Claude to see how it "thinks," and two of the findings stand out.

The first is about poetry. The researchers asked it to write a rhyming couplet that starts with "He saw a carrot and had to grab it." If it really only predicted one word at a time, you'd expect it to look for a rhyme at the very end of the second line. Instead, before it wrote the second line at all, it had already settled on "rabbit" as the ending and wrote the line toward it: "His hunger was like a starving rabbit."

The second is about addition. Ask it what 36 plus 59 is and it says 95. Ask how it got there and it describes the method from school: add the ones, carry the one. But when the researchers looked at what actually happened inside, it was running two paths at once, one estimating the rough size of the answer and the other getting the last digit exactly right. The model itself doesn't know it works this way.

Put the two together and the picture is this: writing one word at a time is how the model works on the outside. To predict well, it has developed its own methods on the inside. Nobody wrote those methods in line by line. The model learned them during training, and even the company that built it needs dedicated research to see them.

## Why does it follow instructions like an assistant?

The training described so far, reading huge amounts of text and practicing next-word prediction, is called pretraining. A model that has only been pretrained is good at continuing text but not very good at answering questions or following instructions. Anthropic's glossary says so directly.

So there's another round of training after that, teaching the model to be an assistant: understand what you're asking, answer properly, and decline things it shouldn't do. The Claude we use day to day has been through this. In the glossary's words, Claude is not a bare language model; it has already been trained to be a helpful assistant.

![First it learns to continue text, then it learns to be an assistant](/assets/images/posts/what-is-an-llm-fig-stages-en.png)

How that round of training works is a topic of its own, and it's what the next post covers.

## What does this mean when you code with AI?

Once you know the model is continuing text, two things become useful right away.

First, everything you give it is part of the text it continues from. Your question, the code you paste in, the instruction files in your project: it reads all of it and writes from there. The clearer that text is, the easier it is to continue correctly. Compare "write me a function" with "write a Python function called add that takes two integers and returns their sum." The second leaves far less to guess.

Second, what it writes is "the most likely thing to come next," not something it went and checked. Most of the time, the most likely answer is also the right one. But now and then it produces a function name or parameter that looks perfectly plausible and doesn't exist. So run the code and read it before you rely on it.

## Is it the same with Codex or DeepSeek?

Yes. Codex runs on OpenAI's models, and DeepSeek runs on models trained by DeepSeek itself. They're all LLMs, and they all work by continuing text one word at a time. What differs is what they read during training, how they were later trained into assistants, and what the tool wrapped around them does on their behalf. The two habits above apply whichever tool you use.

## Summary

- An LLM is a program that keeps adding the next word: it reads the text so far, picks the most likely next word, and repeats.
- To predict well, it picked up grammar, general knowledge, and how code is written during training, and it can even plan ahead.
- Everything you give it becomes text it writes from, so the clearer it is, the better the result. Check the code it writes before you use it.

---

**Next**: how does a model that only knows how to continue text become an assistant that helps you write code?

---

If this made the AI you use every day feel a little less like a black box, a like or a share would mean a lot. Follow along for the rest of the series.
