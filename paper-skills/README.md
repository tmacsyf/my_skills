# paper-skills：学术论文写作与投稿辅助技能集

> 让 AI 帮你**检查论文、消除 AI 味、提升学术表达并核验投稿流程**——而不是替代作者作出学术或投稿决定。

---

## 技能列表

| 技能 | 目录 | 核心功能 | 触发词 |
|------|------|----------|--------|
| **De-AI Writing** | `de-ai-writing/` | 扫描并修正学术论文中的 10 类 AI 写作痕迹 | 去AI味、AI痕迹、humanize |
| **NIPS File Naming** | `nips-file-naming/` | 统一论文项目文件命名 | 新建文件、重命名、项目整理 |
| **Paper Review Draft** | `paper-review-draft/` | 构建核心叙事并诊断论文初稿 | 提纲、初稿诊断、主线取舍 |
| **Science Submission Workflow** | `science-submission-workflow/` | 准备、核验、引导填写并归档 Science CTS 投稿 | Science投稿、CTS、投稿包、Received归档 |
| **Topic Modeling Writing Style** | `topic-modeling-writing-style/` | Topic Modeling 术语表达与 NeurIPS 写作规范 | 主题建模、论文润色、NeurIPS |

---

## de-ai-writing：AI 痕迹扫描与修正

### 解决的问题

LLM 辅助写作的论文会留下一系列可被审稿人识别的"指纹"：

| 编号 | 痕迹类型 | 风险等级 |
|------|---------|---------|
| R10 | 假精确与虚构数据 | 🔴 高（学术诚信） |
| R8 | 全程零犹豫（过度确定） | 🔴 高（overclaim 风险） |
| R9 | 面面俱到的折中观点 | 🟠 中（论点乏力） |
| R5 | 句尾拔高/空洞升华 | 🟠 中（内容空洞） |
| R4 | 高频连接词堆砌句首 | 🟠 中（最易识别） |
| R2 | "不是A，是B"伪转折 | 🟡 低（节奏） |
| R3 | 案例凑"3"模式 | 🟡 低（节奏） |
| R6 | 句式节奏固定 | 🟡 低（节奏） |
| R7 | 段落结尾金句泛滥 | 🟡 低（节奏） |
| R1 | 破折号滥用 | 🟢 风格偏好 |

### 工作流程

```
提交文本 → 扫描10条规则 → 输出报告（表格） → 确认修改 → 二次扫描确认清零
```

### 学术约束

- 保持学术规范性，不过度口语化
- 保留论证逻辑，改表达不改论点
- 尊重学科 hedging 惯例（医学 > CS > 工程）
- 保留 LaTeX 命令（`\cite{}`、`\ref{}` 等）原样不动

### 示例

```
❌ Furthermore, these findings underscore the critical need for institutional guidelines.
✅ These findings suggest that institutional guidelines may help mitigate LLM-induced quality decline.

命中规则：R4（连接词堆砌）+ R5（句尾拔高）+ R8（零犹豫）
```

---

## science-submission-workflow：Science CTS 投稿工作流

### 核心功能

- 区分主文、Combined PDF、Cover Letter、补充材料与LaTeX源文件等投稿角色；
- 从CTS当前页面或截图逐步指导填写；
- 重点核对作者顺序与角色、机构、Funding、Subject Area及数据仓库选择；
- 机械检查PDF页数、页面尺寸、可搜索文本、字体嵌入、ZIP完整性与SHA-256；
- 在显示`Received`后生成保护隐私的不可变投稿快照。

该技能不会擅自修改科研内容、选择审稿人、公开数据、发送邮件、推送Git或执行最终Submit。Science政策和CTS字段可能变化，因此实时系统页面与最新官方指南始终优先。

---

## 安装

**Codex**：把 `paper-skills/science-submission-workflow/` 复制到 `~/.codex/skills/`，然后在新会话中使用 `$science-submission-workflow`。

**Qoder CLI**：把 `paper-skills/` 下任一技能目录复制到 `~/.qoder/skills/` 或项目的 `.qoder/skills/` 目录。

**Claude Code**：放到 `~/.claude/skills/`，新会话自动识别。

**其他 Agent**：把对应 `SKILL.md` 作为系统提示/上下文加载。

---

## 其他技能说明

- `nips-file-naming`：通过类型、主题、日期和版本号形成一致的文件命名。
- `paper-review-draft`：强调“一条主线打透”，用于提纲搭建、支线取舍和初稿诊断。
- `science-submission-workflow`：面向Science CTS的投稿准备、元数据核对、文件验证和归档。
- `topic-modeling-writing-style`：沉淀 Topic Modeling 领域惯用表达，并叠加 NeurIPS 写作规范。
