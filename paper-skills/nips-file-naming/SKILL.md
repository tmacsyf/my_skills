---
name: nips-file-naming
description: Enforce consistent file naming conventions for NIPS/NeurIPS academic paper projects. Use when creating new files, renaming existing files, or organizing project structure for academic paper writing.
---

# NIPS项目文件命名规范

## 核心规则

```
[类型]_[主题]_[日期]_[版本].md
```

## 类型标识 (Type Prefix)

| 类型 | 用途 | 示例 |
|------|------|------|
| `outline` | 论文提纲/结构 | `outline_topic_dilution_0409_v1.md` |
| `draft` | 章节初稿 | `draft_introduction_0412_v1.md` |
| `review` | 审阅意见/讨论记录 | `review_advisor_feedback_0420.md` |
| `idea` | 灵感/待验证思路 | `idea_prompt_limitation_0410.md` |
| `ref` | 参考文献/资料 | `ref_topicgpt_paper.pdf` |
| `fig` | 图表素材 | `fig_semantic_entropy_0422.png` |
| `exp` | 实验数据/结果 | `exp_ablation_study_0425.csv` |

## 日期格式

统一使用 `MMDD` (4位) 或 `YYYYMMDD` (8位)：
- 当年内项目：`0409` (4月9日)
- 跨年项目：`20250409`

## 版本标识 (可选)

| 版本 | 含义 | 使用场景 |
|------|------|---------|
| `v1`, `v2`... | 迭代版本 | 同一内容的多个修改版本 |
| `final` | 最终版 | 合并/定稿版本 |
| `backup` | 备份 | 保留历史但不再使用 |

## 命名检查清单

创建或重命名文件时，逐项检查：

- [ ] 使用英文小写字母
- [ ] 单词间用下划线 `_` 连接
- [ ] 包含正确的类型前缀
- [ ] 主题描述简洁明确（2-4个单词）
- [ ] 日期格式统一
- [ ] 不含人名（如 `syf_`, `gemini_`）
- [ ] 不含中文
- [ ] 不含特殊字符（除 `_` 和 `.`）

## 常见错误

| 错误示例 | 问题 | 正确示例 |
|---------|------|---------|
| `syf_outline_0409.md` | 含人名 | `outline_topic_dilution_0409_v1.md` |
| `idea0410.md` | 语义不清 | `idea_prompt_limitation_0410.md` |
| `沟通讨论0409.md` | 含中文 | `review_meeting_notes_0409.md` |
| `merged_outline_0409.md` | 无版本标识 | `outline_topic_dilution_0409_final.md` |
| `outline-topic-dilution.md` | 用连字符 | `outline_topic_dilution_0409_v1.md` |

## 目录结构示例

```
nips_llm/
├── outline/
│   ├── outline_topic_dilution_0409_v1.md
│   ├── outline_topic_dilution_0409_v2.md
│   └── outline_topic_dilution_0409_final.md
├── draft/
│   ├── draft_abstract_0412_v1.md
│   ├── draft_introduction_0413_v2.md
│   └── draft_methodology_0415_v1.md
├── review/
│   ├── review_initial_thoughts_0409.md
│   ├── review_meeting_notes_0409.md
│   └── review_advisor_feedback_0420.md
├── idea/
│   ├── idea_prompt_limitation_0410.md
│   └── idea_visualization_design_0418.md
├── ref/
│   ├── ref_topicgpt_paper.pdf
│   └── ref_bertopic_survey.pdf
├── fig/
│   ├── fig_semantic_entropy_0422.png
│   └── fig_dilution_comparison_0423.pdf
└── exp/
    ├── exp_ablation_study_0425.csv
    └── exp_main_results_0426.xlsx
```

## 重命名现有文件流程

1. 识别文件类型和内容主题
2. 按规范生成新文件名
3. 使用 `search_replace` 更新文件内引用（如有）
4. 删除旧文件
5. 更新 CHANGELOG.md

## 快速参考

| 我要创建... | 命名示例 |
|------------|---------|
| 论文提纲 | `outline_[主题]_[日期]_v1.md` |
| 章节初稿 | `draft_[章节名]_[日期]_v1.md` |
| 导师反馈 | `review_advisor_feedback_[日期].md` |
| 灵感记录 | `idea_[简要描述]_[日期].md` |
| 参考文献 | `ref_[作者/标题缩写].pdf` |
| 实验数据 | `exp_[实验类型]_[日期].csv` |
