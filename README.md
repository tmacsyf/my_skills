# My Skills

个人 AI Agent 技能与协作规则库——覆盖**股票量化分析**、**学术论文写作**、**个人工作与决策**以及**内容获取工具**。

---

## 技能索引

| 领域 | 目录 | 技能数 | 简介 |
|------|------|--------|------|
| 股票技术分析 | [`finance-skills/`](finance-skills/) | 3 | 缠论 · 四步分析法 · 八句口诀，三层体系 |
| 学术论文写作 | [`paper-skills/`](paper-skills/) | 4 | 文件命名、初稿诊断、领域风格、AI 痕迹修正 |
| 个人工作与决策 | [`personal-skills/`](personal-skills/) | 3 | 第一性原理、科研汇报、个人决策校准 |
| 内容获取工具 | [`utility-skills/`](utility-skills/) | 1 | 微信公众号文章下载与格式导出 |

根目录的 [`AGENTS.md`](AGENTS.md) 保存跨项目复用的 AI 协作原则。

---

## finance-skills：股票技术分析三层体系

> 把 A 股技术分析变成一套**可执行、可复核、不自欺**的分析流程。

### 技能架构

```
stock-unified-analysis（统一调度入口）
    ├── 场景识别 → 自动路由
    │
    ├── chanlun-trading-system（缠论 · 战略层）
    │   回答：现在处于什么阶段？什么结构？
    │   来源：RedSkill 商店安装
    │
    ├── stock-technical-analysis（四步分析法 · 战术层）
    │   回答：该买还是该卖？什么价位？什么仓位？
    │   核心：均线 → MACD/KDJ → 量价 → 仓位管理
    │
    └── eight-maxims-trading（八句口诀 · 执行层）
        回答：现在盘中怎么操作？
        核心：早盘急跌T+0、尾盘异动、涨停板、20日生命线
```

### 四类场景自动路由

| 场景 | 关键词 | 主力技能 |
|------|--------|----------|
| 战略研判 | "处于什么阶段""缠论""中枢""背驰" | 缠论 |
| 战术分析 | "今天怎么样""复盘""该买该卖""被套" | 四步分析法 |
| 盘中执行 | "早盘""尾盘""急跌""涨停""T+0" | 八句口诀 |
| 完整复盘 | "全面复盘""三合一""完整分析" | 三层全走 |

---

## paper-skills：学术论文写作辅助

> 让 AI 帮你**检查论文、消除 AI 味、提升学术表达**——而不是让论文读起来更像 AI 写的。

### de-ai-writing：AI 痕迹扫描与修正

**解决的核心问题**：LLM 辅助写作的论文会留下可被审稿人识别的"指纹"。本技能扫描 10 类典型 AI 写作痕迹，按风险等级排序后给出逐条修正建议。

| 风险等级 | 覆盖规则 |
|---------|---------|
| 🔴 **高** | R10 假精确、R8 零犹豫 |
| 🟠 **中** | R9 假平衡、R5 句尾拔高、R4 连接词堆砌 |
| 🟡 **低** | R2 伪转折、R3 凑3、R6 节奏固定、R7 金句泛滥、R1 破折号 |

**工作流**：提交文本 → 扫描 → 报告表格 → 确认修改 → 二次扫描清零

**适用格式**：纯文本、Markdown、LaTeX（保留所有 `\cite{}`、`\ref{}` 命令）

---

## paper-skills：其他论文技能

- **nips-file-naming**：统一 NeurIPS/NIPS 项目中的文件命名。
- **paper-review-draft**：围绕核心叙事构建提纲并诊断初稿。
- **topic-modeling-writing-style**：Topic Modeling 领域表达与 NeurIPS 写作规范。

---

## personal-skills：个人工作与决策

### syf-decision-system：SYF 处事体系

以个人长期目标和既定原则为决策校准器，用于分析事业发展、论文与项目、执行拖延、人际边界、沟通汇报、情绪内耗和投资纪律。它不会机械套用规则，而会根据事实检查旧规则是否仍然适用。

### principles：第一性原理工作准则

在执行前澄清真实目标、检查假设和成功标准；目标清晰但路径低效时，主动提出更短、更可靠的方案。

### report：科研岗向上汇报

把科研进展、成果、问题、资源需求和职业规划整理成简洁版、详细版及成果导向版汇报话术。

---

## utility-skills：内容获取工具

### wechat-article-download-api

通过公开接口下载微信公众号文章，并导出为 HTML、Markdown、纯文本或 JSON。

---

## 安装

### Qoder CLI（推荐）

把任一技能目录复制到 `~/.qoder/skills/`（全局）或项目的 `.qoder/skills/`（项目级）：

```bash
# 安装全部论文技能
cp -r paper-skills/* ~/.qoder/skills/

# 安装全部股票技能
cp -r finance-skills/* ~/.qoder/skills/

# 安装个人工作与决策技能
cp -r personal-skills/* ~/.qoder/skills/
```

### Claude Code

放到 `~/.claude/skills/`，新会话自动识别。

### 其他 Agent

把对应 `SKILL.md` 作为系统提示/上下文加载即可。

---

## 目录结构

```
my_skills/
├── AGENTS.md                     # 跨项目 AI 协作原则
├── README.md
├── finance-skills/               # 股票技术分析
│   ├── README.md
│   ├── stock-unified-analysis/   # 统一调度入口
│   ├── stock-technical-analysis/ # 四步分析法（战术层）
│   └── eight-maxims-trading/     # 八句口诀（执行层）
├── paper-skills/                 # 学术论文写作
│   ├── README.md
│   ├── de-ai-writing/
│   ├── nips-file-naming/
│   ├── paper-review-draft/
│   └── topic-modeling-writing-style/
├── personal-skills/              # 个人工作与决策
│   ├── README.md
│   ├── principles/
│   ├── report/
│   └── syf-decision-system/
└── utility-skills/               # 内容获取工具
    ├── README.md
    └── wechat-article-download-api/
```

---

## 免责声明

- **股票技能**：仅用于技术研究与学习，**不构成投资建议，不给具体买卖指令，不承诺任何收益**。任何据此产生的盈亏由使用者自负。
- **论文技能**：辅助写作质量检查，不替代导师/同行的学术审查。
