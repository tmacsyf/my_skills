# Submission archive standard

Use this standard to preserve what was actually submitted without turning the working directory into a screenshot dump.

## Recommended structure

```text
submission-archive/
└── YYYY-MM-DD_science_initial_submission/
    ├── README.md
    ├── files/
    │   ├── main-manuscript.pdf
    │   ├── combined-manuscript-and-supplement.pdf
    │   ├── cover-letter.pdf
    │   ├── supplementary-material.pdf
    │   └── latex-source.zip
    └── evidence/
        └── science-cts-received.png
```

For a revision, create a new directory such as `YYYY-MM-DD_science_revision_R1/`. Never overwrite the initial-submission snapshot.

## README requirements

Record only facts supported by evidence:

### Submission state

- journal and article type;
- exact title;
- submission date and time zone when relevant;
- displayed CTS status;
- manuscript number location, preferably a private record rather than a public repository;
- final evidence filename.

### File manifest

For every uploaded file, record:

- local filename;
- portal role;
- byte size;
- page count for PDFs;
- SHA-256;
- whether it is an immutable copy or a working file.

### Source provenance

Record:

- authoritative source-file hash;
- Git/Overleaf commit when applicable;
- dirty-worktree state;
- whether uploaded artifacts contain uncommitted changes;
- clean-compilation result and environment notes.

A commit ID alone is insufficient when the actual upload was built from local uncommitted content.

### Metadata baseline

Record the intended:

- author order and roles;
- affiliations;
- funding and grant recipient;
- data/code availability plan;
- reviewer decisions.

Avoid unnecessary duplication of private author contact information in a repository intended to become public.

### Verification boundary

Separate:

- **verified**: confirmed by the final receipt, downloadable submission details, confirmation email, or exact file hash;
- **pending**: entered during the workflow but not independently preserved on a final page;
- **inferred**: reasonable but not evidenced; do not present these as confirmed facts.

## Evidence minimization

Keep:

- final receipt/status screenshot;
- downloadable submission summary or preview;
- confirmation email saved privately when useful;
- exact uploaded files and hashes.

Usually omit:

- every intermediate form screenshot;
- screenshots containing full author contact details when a text profile already exists;
- browser cookies, URLs containing session tokens, or login screens;
- transient validation messages once the final receipt is available.

## Immutability rule

After the snapshot is created:

- do not edit files in `files/`;
- do not replace evidence under the same filename;
- do not rewrite hashes after modifying working copies;
- create a new dated snapshot for resubmissions or revisions;
- keep ongoing editorial correspondence in a separate status log or dated record.

## Public-repository gate

Before publishing an archive or Skill repository, scan for:

- manuscript numbers and private decision letters;
- author emails and personal identifiers not intended for release;
- unpublished manuscripts, source data, and private repository URLs;
- API keys, Git tokens, session cookies, passwords, and credential-bearing URLs;
- absolute local paths and organization-internal hostnames;
- copyrighted journal templates whose redistribution terms are unclear.

Publish the reusable workflow separately from project submission archives unless the authors have explicitly approved the project materials for release.
