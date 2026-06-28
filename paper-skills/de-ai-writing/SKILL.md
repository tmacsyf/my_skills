---
name: de-ai-writing
description: Scan academic prose for 10 common AI-generated writing traces and fix them in place. Triggers on "de-AI", "去AI味", "AI痕迹", "写作痕迹", "去机器味", "humanize", "更像人写的", "更自然", or any request to remove AI-flavored patterns from a paper or manuscript. Also auto-triggers when polishing LaTeX manuscripts if the user mentions AI traces.
---

# De-AI Writing — 学术论文 AI 痕迹扫描与修正

## When to use

用户提交论文段落/全文，要求：
- 检查或消除 AI 写作痕迹
- 让文本更自然、更像真人写的
- 去除"AI味"/"机器味"
- humanize academic prose

## Workflow

1. 接收文本（纯文本 / Markdown / LaTeX 均可）
2. 逐条扫描下方 10 条规则，标注命中位置
3. 输出**扫描报告**（表格形式）
4. 用户确认后执行修正，输出修改后文本
5. 二次扫描确认残留痕迹已清零

> LaTeX 文本：保留所有 `\cite{}`、`\ref{}`、`\label{}`、`\section{}` 等命令原样不动。

## Output format

### 扫描报告

| # | 规则编号 | 原文片段 | 修改建议 | 严重程度 |
|---|---------|---------|---------|---------|
| 1 | R4 | "Furthermore, the results show..." | 删除 "Furthermore,"，直接以 "The results show..." 开头 | 中 |

严重程度：**高** = 明显 AI 痕迹，必须修改；**中** = 可疑模式，建议修改；**低** = 轻微倾向，可选修改。

### 修正后文本

直接在原文基础上修改，用 `\st{删除}` 和 `\textcolor{blue}{新增}` 标注变更（LaTeX），或用 ~~删除~~ / **新增** 标注（Markdown）。

---

## The 10 Rules

### R1 — 破折号滥用 (Em-dash overuse)

**识别**
- 英文 `—` (em-dash) 或中文 `——` 出现频率 > 每500字1次
- 用于插入解释而非语义断裂

**修正**
- 保留真正需要"语义急转弯"的破折号（全文 ≤ 2-3处）
- 其余替换为：逗号对 `, ...,` / 括号 `(...)` / 拆成独立句

**示例**
```
❌ Our approach—unlike prior methods that rely on static thresholds—adapts dynamically.
✅ Our approach, unlike prior methods that rely on static thresholds, adapts dynamically.
✅ Our approach adapts dynamically (unlike prior methods that rely on static thresholds).
```

---

### R2 — "不是A，是B" 伪转折 (Pseudo-contrast)

**识别**
- `not merely X, but rather Y`
- `not simply X, but Y`
- `并非 A，而是 B`
- `不是...而是...`
- `rather than X, we Y`（高频出现时）

**修正**
- 全文保留 ≤ 2-3 次
- 其余改为直接肯定句

**示例**
```
❌ This is not merely a technical improvement, but rather a paradigm shift.
✅ This represents a paradigm shift.
```

---

### R3 — 案例凑"3" (Rule-of-three pattern)

**识别**
- `first... second... third...`
- `X, Y, and Z` 三元素并列（高频出现）
- 每段都恰好举3个例子

**修正**
- 合并为2个（保留最关键的）
- 或扩展到4-5个（打破节奏）
- 或改为概述 + 1个详例

**示例**
```
❌ LLMs affect (1) grammar, (2) structure, and (3) originality.
✅ LLMs affect grammar and originality most visibly; structural changes are subtler but equally consequential.
```

---

### R4 — 高频连接词堆砌句首 (Transition-word stacking)

**识别** — 以下词出现在句首/段首频率过高：
- `Furthermore` / `Moreover` / `Additionally`
- `Notably` / `Importantly` / `Interestingly`
- `It is worth noting that` / `It should be noted that`
- `此外` / `值得注意的是` / `需要指出的是`

**修正**
- 直接删除，让句子以主语开头
- 或替换为更具体的过渡：`In the ICLR subset, ...` / `For conference papers, ...`

**示例**
```
❌ Furthermore, the effect size increases with journal impact factor.
✅ The effect size increases with journal impact factor.
```

---

### R5 — 句尾拔高 / 空洞升华 (Grandiose tail)

**识别**
- `...underscoring the critical importance of X.`
- `...highlighting the urgent need for Y.`
- `...paving the way for future research in Z.`
- `...opening new avenues for...`
- `这为...开辟了新方向`
- `凸显了...的迫切需求`

**修正**
- 删除拔高尾句
- 改为具体数据或平实陈述

**示例**
```
❌ These findings underscore the critical need for institutional guidelines.
✅ These findings suggest that institutional guidelines may help mitigate LLM-induced quality decline.
```

---

### R6 — 句式节奏固定 (Monotonous rhythm)

**识别**
- 连续 3+ 句长度差 < 5 词
- 连续 3+ 句结构相同（如全是 SVO）
- 整段读起来"匀速"无起伏

**修正**
- 穿插短句（< 10词）与长句（> 25词）
- 混用从句、分词短语、倒装
- 偶尔用一个 only-one-clause 的短段落制造停顿

**示例**
```
❌ The model was trained on 10,000 papers. The results showed significant differences. The effect was consistent across venues.
❌ (三句全约 7 词，SVO)
✅ We trained the model on 10,000 papers. Results were significant—and consistent.
```

---

### R7 — 段落结尾金句泛滥 (Summary sentence in every paragraph)

**识别**
- 每段末句都是"总结性升华"
- 段末出现 `In sum, ...` / `Thus, ...` / `Therefore, ...` 频率过高

**修正**
- 仅在全篇**结论段**末尾保留一个总结句
- 其他段落以事实、数据、或向下一段的过渡自然收尾

---

### R8 — 全程零犹豫 (Zero hedging / over-certainty)

**识别**
- 全文无 `may` / `might` / `suggests` / `appears to` / `potentially`
- 所有结论都是 `X causes Y` / `X proves Y` 式绝对陈述

**修正**
- 在证据不够强（p > 0.01、单一样本、相关性研究）处加入 hedging：
  - `may` / `might` / `could`
  - `suggests` / `indicates`（而非 `proves`）
  - `appears to` / `seems to`
  - `potentially` / `likely`
- 强证据处（p < 0.001、大样本、实验设计）可保留确定语气

**示例**
```
❌ LLM usage causes a 0.3-point decline in review scores.
✅ LLM usage is associated with an approximately 0.3-point decline in review scores.
```

---

### R9 — 面面俱到的折中观点 (False balance / fence-sitting)

**识别**
- `Some argue X, while others contend Y.`
- `On one hand ... on the other hand ...`（且两手都没结论）
- `There are both proponents and critics of ...`
- `一方面...另一方面...`（无后续立场）

**修正**
- 亮明作者立场，用证据支持一方
- 可以承认反面，但要有明确倾向

**示例**
```
❌ Some researchers argue LLMs improve writing, while others worry about quality degradation.
✅ Although LLMs can assist with grammar, our evidence suggests they systematically reduce originality—a trade-off that, on balance, harms scholarly quality.
```

---

### R10 — 假精确与虚构数据 (False precision / fabricated numbers)

**识别**
- 无 `\cite{}` 或来源的精确百分比：`78.3%`、`提升了37%`
- 可疑的精确小数（非测量值却精确到小数点后2位）
- 虚构的案例故事或对话

**修正**
- 删除无来源的精确数字
- 替换为有引用的真实数据
- 使用模糊表达：`approximately` / `roughly` / `nearly half` / `a majority`
- 虚构案例改为真实引用或作者自身经历

**示例**
```
❌ 78.3% of researchers reported using LLMs for writing.
✅ A recent survey \cite{author2024} found that roughly four in five researchers have used LLMs in their writing workflow.
```

---

## Scan priority

扫描时按**严重程度**排序：
1. **R10 假精确** — 学术诚信风险，最高优先
2. **R8 零犹豫** — 可能被审稿人质疑 overclaim
3. **R9 假平衡** — 削弱论文论点力度
4. **R5 句尾拔高** — 显得空洞
5. **R4 连接词堆砌** — 最易识别的 AI 味
6. R2 / R3 / R6 / R7 — 节奏问题
7. R1 破折号 — 风格偏好

## Academic constraints

修正时必须遵守：
- **保持学术规范**：不过度口语化，不降低严谨性
- **保留论证逻辑**：改表达不改论点
- **尊重学科惯例**：hedging 程度因学科而异（医学 > CS > 工程）
- **保留 LaTeX 结构**：`\cite{}`、`\ref{}`、公式、表格代码原样保留
