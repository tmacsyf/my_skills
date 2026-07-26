---
name: topic-modeling-writing-style
version: 1.0.0
description: "Topic Modeling 领域论文写作风格指南，双层设计：底层为领域惯用表达（从7篇核心参考论文蒸馏），上层为NeurIPS写作规范。覆盖全论文各章节。"
---

# Topic Modeling Writing Style Guide

> **双层架构**：底层 = 领域术语搭配（从 TopicGPT, LiSA, BERTopic, FASTopic, GPTopic, PromptTopic, TopicMistral 蒸馏）；上层 = NeurIPS 投稿风格规范。

## Layer 1: 领域惯用表达词库

### 1.1 Topic Modeling 核心概念表述

| 概念 | 推荐表达 | 避免表达 |
|------|---------|---------|
| 主题建模任务定义 | "discover latent topics in a text collection" / "uncover underlying thematic structures" | "find topics" / "extract themes" (过于口语) |
| LDA 定位 | "represent documents as mixtures of topics, where each topic is a distribution over words" | "use probability to find topics" |
| 话题-词分布 | "topic-word distribution" | "word distribution of topic" |
| 文档-话题分布 | "doc-topic distribution" / "document-topic distribution" | "topic distribution of document" (语序不自然) |
| 词袋表示的局限 | "bag-of-words representations disregard semantic relationships among words" | "bag-of-words is bad" |
| 嵌入式方法优势 | "contextual embeddings encode semantic similarity in vector space" | "embeddings are better" |
| 聚类方法 | "cluster document embeddings to identify topics" / "clustering-based topic modeling" | "group similar documents" |
| LLM 做 topic modeling | "leverage the language understanding and generation capabilities of LLMs" | "use LLMs to generate topics" |
| 主题粒度问题 | "topics of inconsistent granularity" / "coarse-grained topics" / "long-tail distribution" | "topics are too broad" |
| 主题幻觉 | "hallucinated topics" / "topics not grounded in the source documents" | "wrong topics" / "fake topics" |
| 近似重复 | "near-duplicate topics" / "semantically redundant topic words" | "similar topics" |
| 话题表示 | "topic representation" (用自然语言 label + description) vs "bag-of-words topic representation" (用词分布) | 混用两者 |

### 1.2 方法描述惯用搭配

| 动作 | 领域惯用表达 | 出处 |
|------|------------|------|
| 提出方法 | "We introduce / propose X, a [形容词] framework that..." | TopicGPT, LiSA, FASTopic |
| 描述流程 | "X consists of K main stages: (1)... (2)... (3)..." | TopicGPT, LiSA, PromptTopic |
| 生成话题词 | "prompt an LLM to generate a candidate topic word for each document" | LiSA, TopicGPT |
| 合并话题 | "merge near-duplicate / semantically redundant topics" / "refine the generated topics" | TopicGPT, PromptTopic |
| 聚类 | "cluster both candidate topic representations and document representations into K categories" | LiSA |
| 分配话题 | "assign one or more topics to the given document" / "establish a mapping from document to topic" | TopicGPT, LiSA |
| 语义关系建模 | "model the semantic relations among document, topic, and word embeddings" | FASTopic |
| 评估 | "assess the alignment between predicted assignments and ground-truth labels" | TopicGPT, LiSA |
| 消融 | "ablation studies to investigate the impact of..." | LiSA, FASTopic |
| 处理长尾 | "alleviate / mitigate the long-tail distribution" / "address the relation bias issue" | LiSA, FASTopic |

### 1.3 评估指标标准表述

| 指标 | 标准写法 | 说明 |
|------|---------|------|
| 纯度 | "harmonic mean of purity (P₁)" | Amigó et al., 2009 |
| ARI | "Adjusted Rand Index (ARI)" | 校正 chance |
| NMI | "Normalized Mutual Information (NMI)" | 归一化互信息 |
| 话题连贯性 | "Topic Coherence (CV)" / "Normalized Pointwise Mutual Information (NPMI)" | CV 优于 NPMI |
| 话题多样性 | "Topic Diversity (TD): the percentage of unique words across all topics" | Dieng et al., 2020 |
| 对齐 | "topical alignment with ground-truth human-annotated labels" | TopicGPT, LiSA |

### 1.4 问题陈述与动机常用句式

**问题存在性**:
- "However, this approach necessitates that LLMs generate topics with consistent granularity"
- "The issues of topic granularity... are vital to LLM-based topic modelling, as they impact the quality of topics prior to any downstream applications"
- "Existing topic models generally struggle with either effectiveness, efficiency, or stability"
- "These representations are not straightforward to interpret"

**Gap 陈述**:
- "relying on LLMs to merge similar topic words from a large set introduces significant randomness"
- "refining topic words only based on their intrinsic semantic information fails to fully uncover the underlying topic structure"
- "directly assigning documents to the cluster corresponding to its topic words... could lead to inaccurate cluster assignments"
- "They require more resources... and cannot produce precise distributions for topics and documents"

**方法动机**:
- "To address these limitations, we introduce X"
- "To tackle these challenges, we propose X"
- "Motivated by the above analysis, we propose..."
- "Rather than [旧方法], [新方法] explicitly [改进点]"

### 1.5 实验叙述标准句式

**主实验**:
- "Our experiments show that X identifies topics that are substantially more aligned with..."
- "X outperforms state-of-the-art methods on topic alignment / topic quality"
- "The main results of topical alignment with ground truth are shown in Table X"

**稳定性/鲁棒性**:
- "We assess the robustness of X to changes in [变量]"
- "X produces comparable topical alignment across all modified experimental settings"
- "X demonstrated greater stability than [baseline] in terms of..."

**消融**:
- "To investigate the impact of different [组件] on X..."
- "Ablation studies demonstrate that [组件] contributes to..."

---

## Layer 2: NeurIPS 写作规范

### 2.1 NeurIPS vs NLP 会议（ACL/EMNLP）核心差异

| 维度 | NeurIPS 偏好 | NLP 会议偏好 | 调整策略 |
|------|------------|-------------|---------|
| **问题表述** | 形式化定义优先，insight-driven | 任务描述 + 经验观察 | 先给数学定义，再给直觉 |
| **方法描述** | design rationale + 数学推导 | pipeline 流程描述 | 强调"为什么这样设计"而非"怎么做" |
| **实验叙述** | key finding + 分析图 | 全面覆盖 + 表格为主 | 突出 insight，不堆数字 |
| **贡献表述** | "We identify/formalize X" | "We propose X that achieves Y" | 强调认知贡献而非性能提升 |
| **语言密度** | 极简紧凑，每句都要有信息量 | 可以稍有冗余 | 砍掉所有不改变读者认知的句子 |
| **数学化** | 公式是论证工具 | 公式是方法描述 | 关键 claim 尽量用数学表达 |
| **Related Work** | 简洁，聚焦技术差异 | 全面综述 | 2-3 段即可，不写成 survey |
| **导航段** | 几乎不出现 | 部分论文保留 | 删除 "The remainder of this paper is organized as follows..." |

### 2.2 各章节 NeurIPS 风格指南

#### Abstract（4-6 句极简）

**模板**:
```
[1句 背景+问题] Topic modeling with LLMs has shown promise, yet [核心问题].
[1句 根因分析] We trace this to [形式化的根因].
[1句 方法] We propose X, a [定语] framework that [核心机制，一句话].
[1句 关键设计] X operates via [阶段概述], providing [为什么有效].
[1句 结果] Experiments on [数据集] show that X [关键指标提升].
```

**NeurIPS 风格要点**:
- 不展开方法细节，一句话概括核心机制
- 根因分析比方法描述更重要
- 数字只放一个最有说服力的
- 不用 "To the best of our knowledge" / "novel" 等空洞词

#### Introduction（5 段制，删导航段）

**Para 1 — 背景 + 问题浮现**:
- 1-2 句大背景（topic modeling 任务）
- 1-2 句 LLM 带来的新范式
- 1-2 句引出核心问题（如 topic dilution）
- NeurIPS 风格：直接切入，不铺垫历史

**Para 2 — 问题诊断（形式化）**:
- 用数学/形式化语言定义问题
- "We formalize this as..."
- 追溯根因：不只说"有问题"，要说"为什么有问题"
- NeurIPS 风格：insight-driven，不是 observation-driven

**Para 3 — 现有方法局限（精准打击）**:
- 只列与核心问题直接相关的局限
- 每个局限一句话，不展开
- 指向一个共同 gap
- NeurIPS 风格：不写成 mini related work

**Para 4 — 方法概述（high-level design rationale）**:
- "Based on this diagnosis, we propose X"
- 只说 what + why，不说 how（留给 Method）
- 突出设计理念（如 Coarse-to-Fine），不列实现步骤
- NeurIPS 风格：读者读完这段应理解为什么这样设计

**Para 5 — 贡献点（3 bullets）**:
- Bullet 1: Problem formalization / Insight（认知贡献）
- Bullet 2: Method / Framework（方法贡献）
- Bullet 3: Empirical validation + new metric（实验贡献）
- NeurIPS 风格："We identify/formalize" > "We propose"

#### Related Work（2-3 段，紧凑）

**结构**:
```
段1: Traditional + Neural Topic Models（1段合并）
段2: LLM-based Topic Modeling（核心对比段）
段3: [可选] 与本文最相关的 1-2 个方法的精确区分
```

**NeurIPS 风格要点**:
- 不写成 survey，只突出与本文的技术差异
- 用 "Different from X, our method..." 做精确对比
- 关键对比方法必须在 Introduction 已提及

#### Methodology

**问题形式化** (Section 3.1):
- 符号定义最小集合
- 用数学定义核心概念
- "Consider a collection D = {d₁, ..., d_N}..."
- NeurIPS 风格：形式化是论证的基础，不是装饰

**方法主体**:
- 每个组件：what → why → how（设计理念优先）
- 关键设计选择需要 justify："This design provides two natural remedies: (1)... (2)..."
- 公式后必须有直觉解释
- NeurIPS 风格：读者应理解每个设计选择的 rationale

**NeurIPS 方法描述禁忌**:
- ❌ 纯流程描述（"首先...然后...最后..."）
- ❌ 实现细节（具体 prompt 模板、超参数）→ 放 Appendix
- ❌ 没有 justify 的设计选择
- ✅ "We design X because..." / "This addresses Y by..."

#### Experiments

**结构**:
```
4.1 Setup（极简：数据集 + Baselines + Metrics，各1段）
4.2 Main Results（1-2 个核心表 + 分析）
4.3 Analysis（消融 + 机制解释 + 案例研究）
```

**NeurIPS 实验叙述风格**:
- 表格后不逐行复述数字，而是提炼 key finding
- "We observe that..." → "This confirms our hypothesis that..."
- 消融实验要回答"为什么有效"，不只是"去掉它会变差"
- Case study 要展示 insight，不只是"看效果"

**标准句式**:
- "Table X reports [指标] on [数据集]. We highlight three findings."
- "The gain is particularly pronounced when..., confirming that..."
- "Removing [组件] leads to a [X%] drop in [指标], suggesting that [组件] is critical for..."

### 2.3 NeurIPS 语言风格细则

#### 措辞规范

| 场景 | 推荐 | 避免 |
|------|-----|------|
| 描述改进 | "X mitigates / alleviates / addresses Y" | "X solves Y" (过于绝对) |
| 描述优势 | "X shows superior / competitive performance" | "X is the best" |
| 描述局限 | "A limitation of the current approach is..." | "Our method cannot..." |
| 描述发现 | "We observe / identify / find that..." | "We notice / discover that..." (discover 太强) |
| 引出方法 | "We introduce / propose / present X" | "We create / make / build X" |
| 形式化 | "We formalize X as..." / "We define X to be..." | "We think of X as..." |
| 因果关系 | "This stems from / arises from / is attributed to" | "This is because" (口语化) |
| 对比 | "In contrast to X, Y..." / "Unlike X, Y..." / "Different from X, our..." | "Compared with X, Y is better" |
| 强调 | "Notably / Importantly / Crucially" | "Obviously / Clearly" (预设读者同意) |
| 递进 | "Furthermore / Moreover / In addition" | "Also / And / Besides" |

#### 句式紧凑化

**原则：每句话必须有信息增量，删掉不改变读者认知的词**

| 冗余模式 | 紧凑改写 |
|---------|---------|
| "It is worth noting that X" | "X" (直接说) |
| "In this paper, we propose" | "We propose" |
| "As shown in Table 1, we can see that" | "Table 1 shows" |
| "The reason for this is that" | "This stems from" |
| "In order to address this issue" | "To address this" |
| "We conduct experiments to verify" | "We verify" |
| "The experimental results demonstrate that" | "Results show" / "X outperforms Y" |

#### 学术写作禁忌（NeurIPS）

- ❌ 拟人化 LLM："LLMs understand / know / decide" → ✅ "LLMs generate / produce / yield"
- ❌ 非形式化 claim："obviously better" → ✅ "statistically significant (p < 0.05)"
- ❌ 空洞修饰："very important" / "extremely effective" → ✅ 用数据说话
- ❌ 第一人称过多："We think" / "We believe" → ✅ "The results suggest" / "This indicates"
- ❌ "novel" / "first" 无根据使用 → ✅ 只在确实是 first 时使用，且需引用支撑

### 2.4 数学符号与公式风格

**NeurIPS 偏好**:
- 关键定义用 `\textbf{Definition X.}` 或 `\begin{definition}` 环境
- 公式后接一句直觉解释："Intuitively, this captures..."
- 用 `\text{}` 在公式中标注语义：$H_{\text{sem}}$ 而非 $H_{sem}$
- 向量用粗体小写 $\mathbf{x}$，矩阵用粗体大写 $\mathbf{X}$
- 集合用花体 $\mathcal{D}$

---

## 使用指南

### 触发场景

| 场景 | 触发关键词 |
|------|-----------|
| 写新章节 | "帮我写/改 introduction / related work / methodology / experiments" |
| 表达润色 | "这段表达不够学术"、"帮我改一下措辞"、"NeurIPS 风格" |
| 术语检查 | "这个术语对吗"、"怎么描述这个概念" |
| 全文审查 | "检查一下整篇论文的表达"、"语言风格统一吗" |

### 执行流程

1. **识别章节** → 确定当前修改的是哪个章节
2. **查 Layer 1** → 检查领域术语搭配是否正确
3. **查 Layer 2** → 检查是否符合 NeurIPS 风格规范
4. **输出修改** → 给出具体修改建议或直接修改 LaTeX

### 修改优先级

1. **P0 — 术语错误**：领域术语使用不当（如混淆 topic-word distribution 和 doc-topic distribution）
2. **P1 — 风格违规**：不符合 NeurIPS 规范（如导航段、过度拟人化、空洞修饰）
3. **P2 — 措辞优化**：可以更紧凑、更精准的表达
4. **P3 — 句式改进**：冗余句式、信息密度不足

## 参考论文来源

本 Skill 的领域表达从以下 7 篇论文蒸馏：

1. **TopicGPT** (Pham et al., 2024) — ACL prompt-based topic modeling, 定义了 LLM topic modeling 的基本范式
2. **LiSA** (Liu et al., 2025) — ACL LLM-guided clustering, 双语义空间对齐
3. **TopicMistral / Addressing Granularity** (Mu et al., 2024) — DPO fine-tuning for granularity + hallucination
4. **BERTopic** (Grootendorst, 2022) — 聚类 + c-TF-IDF 的经典方法
5. **FASTopic** (Wu et al., 2024) — NeurIPS 2024, DSR 范式 + Optimal Transport（本文的 NeurIPS 风格参考标杆）
6. **GPTopic** (Reuter et al., 2024) — 动态交互式 topic representation
7. **PromptTopic** (Wang et al., 2023) — 句子级 topic generation + collapsing

> **FASTopic 是 NeurIPS 2024 接收论文**，其写作风格是本 Skill 上层 NeurIPS 规范的直接参考。
