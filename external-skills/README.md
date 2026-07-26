# External Skills

本目录以 Git 子模块保存经过明确标注的第三方 Skills，便于跨设备安装和固定版本，同时避免重复复制上游源码。

这些内容不是本仓库所有者的原创作品。每个 Skill 的来源、版本和许可证以相邻的 `*-UPSTREAM.md` 与子模块内许可证文件为准。

| Skill | 固定版本 | 上游 |
|---|---|---|
| `academic-research-suite` | `0.1.22` / ARS `v3.19.0` | [Imbad0202/academic-research-skills-codex](https://github.com/Imbad0202/academic-research-skills-codex) |

使用或再分发前，请遵守相应上游许可证。

克隆时使用：

```bash
git clone --recurse-submodules https://github.com/tmacsyf/my_skills.git
```

已有仓库初始化子模块：

```bash
git submodule update --init --recursive
```
