---
layout: post
title: "PDLC：把 AI 写代码从'软规范'升级为'硬契约'"
date: 2026-05-15
lang: zh
categories: [blog]
tags: [PDLC, Claude Code, AI 工程, 工作流, 开源, MIT]
excerpt: "AI 助手说'我把功能做完了'但 PRD 只活在对话里、测试'我等会儿补'、跨会话就忘了某功能进展到哪。这些痛点 PDLC 通过 31 个标准化阶段 + Iron Law 5 不变量解决。从动机、实现、应用到能达到的效果，一篇看完。"
---

## 动机：AI 写代码的几个老毛病

你有没有遇到过这种场景：

- 让 AI 做一个新功能，它说"好的，我把功能做完了"，**但 PRD 只活在你刚才那段对话里**。一关窗口就找不到了。下次想回顾"当时为啥这么设计"，只剩 git log 里的 commit message。
- 让它做完功能再补测试，它**轻轻松松写出 100% 通过的"测试"**——因为代码已经写完了，测试是回头照着实现配齐的，**对设计没有约束力**。
- 跳过设计阶段直接干，**架构腐烂悄无声息**。三个月后你想加新功能，发现现在的代码已经不是当初规划的那种结构了。
- 跨会话**没有任何记忆**。某个功能"我们做到哪了？"——靠你自己记。

这些问题的本质是：**AI 助手把工程流程当成"软约定"在执行**——能省就省、能跳就跳。

[PDLC](/zh/pdlc/)（**P**roduct **D**evelopment **L**ife **C**ycle）这个 Claude Code plugin 的目标就一句话：**把这些软约定升级成硬契约**。让 AI 一旦走这套工作流，就**没法**跳过 PRD、没法不先写测试、没法忘记当前阶段。

## 实现：三层架构 + Iron Law + 状态机

### 31 条命令，分三层

| 层级 | 命令数 | 角色 |
|---|---:|---|
| 第一层 · 入口 | 3 | `/pdlc-feature`、`/pdlc-fix`、`/pdlc-status` —— 一句话 prompt 驱动整条链路 |
| 第二层 · 阶段 | 11 | `/pdlc-prd`、`/pdlc-tdd`、`/pdlc-implement`、`/pdlc-review`、`/pdlc-ship` 等 —— 单独控制某个阶段 |
| 第三层 · 工具 | 17 | UI 设计 / 数据库设计 / 架构 / 安全 / 性能 / 代码脚手架 / i18n / 迁移等专项工具 |

日常用最多的是第一层：

```bash
# 在 Claude Code 里
/pdlc-feature 给登录加图形验证码
```

这一条命令 PDLC 会带你走完 PRD → 设计 → TDD 红灯 → 实现 → 评审 → 发布。每个阶段都**强制**满足下面这套"铁律"。

### Iron Law：5 条不变量

每一条**产出产物**的第一/第二层阶段都得满足：

1. **产物必须落盘** —— 不能只写在对话里，必须有个真实文件在 `docs/` 目录下
2. **状态机必须更新** —— 每个阶段结束都得写 `docs/.pdlc-state/<feature-id>.json`
3. **测试先行** —— 实现阶段被失败的测试挡住，没红灯不能写代码
4. **自检** —— 每个阶段交接前自己跑一遍审计
5. **自动修复仅一轮** —— 自动修复死循环？没门，最多一轮，搞不定就抛给人

这五条是**强约束**。第一层 / 第二层产物阶段不能跳，跳了 AI 自己会自检失败。

### 状态机：每个功能一份

每开一个新功能（`/pdlc-feature ...`），PDLC 会分配一个 ID 如 `F20260515-01`，对应文件：

```
docs/.pdlc-state/F20260515-01.json
```

这文件长这样（示意）：

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

意义在哪？**跨会话也知道每个功能进展到哪**。明天打开 Claude Code，`/pdlc-status` 一眼看到："F20260515-01 在 implement 阶段，下一步跑 review"。不再依赖你的记性，也不靠 AI 的"上下文窗口"。

### 产物目录约定

PDLC 在你项目里读写这些目录：

```
docs/00_standards/coding/                          # 编码规范（只读）
docs/01_requirements/prd/                          # PRD
docs/02_design/{api,database,architecture,ui-ux}/  # 技术设计
docs/03_development/                               # 开发者手册
docs/04_testing/{unit-tests,e2e-tests,defects,...} # 测试 & 缺陷
docs/05_deployment/                                # 部署文档
docs/06_tasks/                                     # 阶段内任务跟踪
docs/07_reviews/{doc,code,design,retro}/           # 评审记录
docs/.pdlc-state/<feature-id>.json                 # 每功能一份状态机
```

所有东西都是磁盘上的真实文件。可以 `git diff` 看一周前 AI 在 PRD 阶段到底写了啥。

## 应用：3 个典型场景

### 场景 1：端到端做一个新功能

```bash
# Claude Code 里
/pdlc-feature 给用户登录加手机号验证
```

PDLC 自动串联：

```
→ 分配 ID F20260515-01（user-auth-phone）
→ 阶段一：生成 PRD
   ✓ docs/01_requirements/prd/F20260515-01-user-auth-phone-prd.md
   ✓ 自检 8/8 通过
→ 阶段二：技术设计
   ✓ docs/02_design/api/F20260515-01-user-auth-phone-api.md
   ✓ docs/02_design/database/F20260515-01-user-auth-phone-db.md
→ 阶段三：TDD 红灯
   ✓ 写了 14 条测试，全部预期失败
→ 阶段四：实现
   ✓ 14/14 测试转绿
→ 阶段五：代码评审 + 自动修复
   ✓ 自动修复 3 个 lint 问题
   ✓ docs/07_reviews/code/F20260515-01-user-auth-phone-review.md
→ 阶段六：交接
   📦 docs/.pdlc-state/F20260515-01.json 已更新
   👉 下一步：/pdlc-ship
```

整个流程下来你的 git 工作区有：1 份 PRD、2 份设计文档、N 份测试代码、1 份评审记录、1 份状态机更新、外加真正的代码改动。**全是文件**，不是对话。

### 场景 2：修 bug 留下完整审计

```bash
/pdlc-fix 翻页在空列表上崩溃
```

PDLC 走的不是"看一眼 → 改两行"，而是：

1. **定位**：搜代码找出可能的相关位置
2. **复现**：先写一个能稳定复现的测试（这个测试加到 `docs/04_testing/defects/` 下）
3. **修**：才真正动代码
4. **验证**：复现测试转绿
5. **记录**：缺陷报告归档

下次类似的问题来，你能 `grep` 历史缺陷记录，看上次怎么修的。

### 场景 3：一眼看全项目进展

```bash
/pdlc-status
```

输出大致这样：

```
Project PDLC status (read from docs/.pdlc-state/):

F20260512-01  user-auth-phone     ✓ shipped
F20260513-01  captcha-login       ⏵ in review
F20260514-01  password-reset      ⚠ stuck in TDD (3 tests failing)
F20260515-01  email-verify        ⏵ in PRD
```

不再追着 AI 问"我们做到哪儿了"——直接读状态机。

## 效果：你能得到什么

### 1. 工程文档跟代码同步落盘

每份 PRD、每份设计、每份评审都是 git 历史里的真实文件。一年后回看，能精确知道"当时是为啥要做这个、设计是怎么决策的、评审是怎么过的"。**对项目可维护性是质的提升**。

### 2. TDD 真的落实，不是嘴上说说

实现阶段被失败测试挡住。AI 想跳？跳不掉 —— 不仅是规则，**还是被状态机强制约束的**。

### 3. 自动修复的失控风险被压住

很多 AI 工具有个隐性 bug：**修复 → 检查 → 没好 → 再修复 → 又改坏 → 再修……** 死循环烧 token 烧时间。PDLC 强制"自动修复至多一轮"，让 AI 卡住时主动停下来等人。

### 4. 跨会话的工程连续性

今天做到 implement，明天 `/pdlc-status` 一查就知道下一步。**不依赖对话上下文窗口**，也不靠你脑子记。

### 5. 老项目也能接入

新项目从零搭好结构容易，老项目麻烦。PDLC 的 `/pdlc-adopt` 命令会扫描既有代码库，**不重写你的代码**，只补齐缺失的规范 / 设计文档 / 目录结构，让老项目从某个起点开始走 PDLC 流程。

## 怎么开始

完整安装步骤、命令清单、定制方法、FAQ 都在 [PDLC 产品页](/zh/pdlc/) 和项目仓库里。

**一句话上手**：

```bash
curl -fsSL https://raw.githubusercontent.com/kanfu-panda/pdlc-skills/main/install.sh \
  | bash -s -- --global
```

然后在 Claude Code 里：

```
/pdlc-feature <一句话描述你的需求>
```

仓库地址：[**github.com/kanfu-panda/pdlc-skills**](https://github.com/kanfu-panda/pdlc-skills)（MIT 协议）

## 一点设计哲学

PDLC 不是"加个 AI 帮忙"——它是**用 AI 之前的工程化思考的延续**：

> 软件工程几十年下来沉淀的核心是"流程纪律"。AI 来了之后，纪律不能少，反而该被工具强制保证。

如果你也觉得"AI 写完代码 = 项目交付"是个危险的简化，PDLC 可能是你想要的。

欢迎试用，遇到问题去 [GitHub Discussions](https://github.com/kanfu-panda/pdlc-skills/discussions) 聊，或在 [关于页](/zh/about/) 找我交流。
