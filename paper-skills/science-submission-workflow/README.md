# Science Submission Workflow

A reusable Codex Skill for preparing, guiding, auditing, and archiving manuscript submissions to the AAAS flagship journal **Science** through CTS.

It was distilled from a completed LaTeX initial-submission workflow and is deliberately separated from the original manuscript, author data, and submission archive.

This is an independent community workflow and is not affiliated with or endorsed by AAAS or Science.

## What it does

- prepares and audits Science CTS upload packages;
- guides form entry from the current portal page or screenshot;
- catches author, affiliation, role, funder, and subject-area extraction errors;
- verifies PDFs and source ZIPs mechanically;
- creates evidence-based, privacy-conscious submission archives.

It does not revise scientific content, choose reviewers, publish data, send correspondence, push Git changes, or perform the final Submit action without explicit authorization.

## Repository contents

```text
science-submission-workflow/
├── SKILL.md
├── agents/openai.yaml
├── assets/submission-profile-template.md
├── references/cts-workflow.md
├── references/archive-standard.md
└── scripts/verify-submission-bundle.sh
```

## Install locally

From the root of the `my_skills` collection, copy this Skill into the Codex skills directory:

```bash
cp -R paper-skills/science-submission-workflow ~/.codex/skills/
```

Then start a new conversation and invoke:

```text
$science-submission-workflow Help me prepare and audit my Science CTS submission.
```

## Verify a bundle

```bash
scripts/verify-submission-bundle.sh \
  --main path/to/main-manuscript.pdf \
  --combined path/to/combined.pdf \
  --cover path/to/cover-letter.pdf \
  --supplement path/to/supplement.pdf \
  --source path/to/latex-source.zip
```

The script reports file sizes, PDF metadata, searchable text, font embedding, ZIP integrity, and SHA-256. It does not replace visual inspection, clean LaTeX compilation, metadata review, or current-policy verification.

## Privacy and publication

This repository should contain only reusable workflow material. Keep manuscript files, author contact details, submission numbers, emails, screenshots, tokens, and private datasets in the manuscript project—not in this Skill repository.

Before publishing on GitHub, run a secret/personal-data scan. Add an explicit license if you intend to grant reuse or redistribution rights. Official Science and CTS requirements can change; the live portal and current official guidance always take priority over dated experience captured here.
