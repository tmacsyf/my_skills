# Science CTS operational workflow

This reference captures reusable operational lessons from a Science initial submission completed on 2026-09-01. It is not a substitute for current official instructions or the live CTS page.

## Source hierarchy

Use, in order:

1. current required markers and help text in CTS;
2. current official Science/AAAS author instructions;
3. the project's approved submission profile;
4. this dated workflow.

When a current requirement is uncertain, verify it on an official `science.org` or `aaas.org` page and cite the page in the user-facing answer. Do not generalize a Science rule to Science Advances or another Science-family journal.

## Official entry points

Use these as navigation anchors, then follow the current page text:

- [Information for Authors](https://www.science.org/content/page/science-information-authors): article types, editorial scope, and current length/figure/reference limits;
- [Instructions for preparing an initial manuscript](https://www.science.org/content/page/instructions-preparing-initial-manuscript): initial manuscript, supplementary material, figures, references, and accepted preparation paths;
- [Preparing manuscripts using LaTeX](https://www.science.org/content/page/preparing-manuscripts-using-latex): current official template and LaTeX compatibility guidance;
- [Science Journals: Editorial Policies](https://www.science.org/content/page/science-journals-editorial-policies): authorship, competing interests, prior publication/preprints, AI use, and data/code/materials policy.

Recheck all numerical limits, file types, and template versions at submission time. There is no stable public page that fully represents each live CTS screen, controlled vocabulary, parser result, or required-field state; treat those as runtime facts.

## Before opening CTS

Create or confirm one project-level submission profile containing:

- target journal and article type;
- initial submission or revision stage;
- title, short title, abstract, and plain-text variants;
- ordered author metadata and roles;
- signed affiliations and identifiers when available;
- funding organization, controlled identifier, grant number, and recipient;
- declarations, data/code plan, and reviewer policy;
- exact upload-file plan;
- authorization boundaries for Submit, email, Git pushes, and public release.

Freeze manuscript content before portal entry. Avoid making editorial changes while simultaneously entering metadata unless the user explicitly reopens the manuscript.

## Observed LaTeX upload set

The 2026-09-01 CTS initial-submission page requested separate `Manuscript` and `Combined PDF` uploads and accepted a PDF manuscript from LaTeX users without a synchronized DOCX. The Additional Files page requested a cover letter and allowed separate supplementary material and LaTeX sources.

Treat that as dated operational evidence. Confirm current labels and allowed types in the live portal.

Typical roles are:

| Portal role | Intended content |
|---|---|
| Manuscript | Main text, main figures, acknowledgments, reference list, and supplementary-material callout/list as required |
| Combined PDF | Complete main manuscript plus all supplementary materials for reviewers |
| Cover Letter | Current submission letter, normally one document |
| Supplementary Material | Separate supplementary file when the portal provides the field |
| Auxiliary/Supporting Files | Complete LaTeX source archive and other permitted files |

Important invariants:

- do not assume the Manuscript and Combined PDF fields should receive the same file;
- keep the reference list in the main-text portion and ensure it covers citations from both main and supplementary content when the portal instructs this;
- do not upload stale Word derivatives merely because DOCX is preferred for extraction;
- package all required `.tex`, `.bib`, `.sty`, `.bst`, and figure assets;
- use relative paths and test the source archive from a clean extraction directory;
- never include secrets, hidden Git data, caches, or unrelated project files in the source archive.

## File verification

At minimum, verify:

- every expected file exists and opens;
- page counts and page dimensions;
- searchable PDF text;
- embedded fonts;
- no undefined citation or reference;
- no unintended overfull content;
- author names, role marks, affiliations, email display, and title layout on page 1;
- complete main and supplementary figure/table numbering;
- a clean source-archive extraction and compile;
- SHA-256 for each exact upload file.

Use `scripts/verify-submission-bundle.sh` for mechanical checks. Inspect visual layout separately; a script cannot confirm cropping, equation appearance, or figure readability.

## Portal entry

### Manuscript and Combined PDF

Upload each file to its named role. Wait for processing to complete. If the portal renames a file, record the original local filename and hash rather than relying on the generated name.

### Additional files

- Upload only one current cover letter to the required field.
- Upload a separate supplementary file when provided and relevant.
- Classify the source ZIP as the closest available LaTeX/TeX source type.
- Leave movie fields empty when the manuscript has no movie.
- Do not add duplicate standalone figures unless CTS explicitly requests them.

### Discovered institutions

Automated institution extraction is provisional. A parent/top-level institution suggestion may be a registry-normalization choice rather than the author's actual signed affiliation.

Safe correction order:

1. add or select the correct institution;
2. associate the correct authors;
3. confirm no author still depends on the wrong entry;
4. remove the wrong entry last.

Record city, country, and ROR/Ringgold identifiers when the system provides them, but prioritize the approved manuscript affiliation over a misleading automatic match.

### Discovered authors

Audit every author against the profile:

- count and order;
- given and family names;
- capitalization;
- unique email;
- ORCID;
- affiliations;
- first-author, corresponding-author, and equal-contribution roles.

The parser may omit an author, split names incorrectly, or infer roles from symbols incorrectly. Adding a missing author can also change order. Recheck the entire list after every correction.

If a name is locked because an email is linked to an existing account, do not create a duplicate identity to fix capitalization. Ask the account owner to update their profile or contact the journal's submission support with the manuscript number.

In portal fields, enter a literal email underscore (`_`), not the LaTeX escape (`\_`).

### Funding

Do not trust acronym matches. Search using the full approved funder name, select the exact controlled-vocabulary entry, then verify:

- funder name and identifier;
- grant number;
- grant recipient;
- correspondence with the manuscript acknowledgment.

Delete obvious false matches rather than saving the closest-looking candidate.

### Manuscript information

- Choose the article type deliberately.
- Paste the title as one plain-text line without LaTeX commands.
- Use the portal's current character and word counters.
- Convert typographic punctuation to accepted plain text when the field requires ASCII.
- Keep the short title distinct from a one-sentence summary.

### Subject areas and transfer

After choosing a subject term, click the portal's `Add` control and verify that the term appears in the selected list. A value remaining in the search box is not necessarily saved.

Transfer preferences are consequential but optional unless the live page says otherwise. Do not choose a transfer journal on the user's behalf.

### Data repositories and ORCID

Link an existing dataset only when the DOI and owner identity are correct and the user intends the linkage. Do not create a Dryad, Zenodo, or other public record merely because the integration is offered.

Do not infer that a repository DOI is mandatory from the existence of an optional repository panel. Follow the manuscript's approved data-availability plan and current journal policy. Science's publication-access policy does not automatically mean that a dataset must be public before initial submission; confidential editor/reviewer access or an approved exception may be appropriate until acceptance or publication.

A GitHub branch link is not automatically a persistent scholarly archive. When publication policy calls for durable deposition, prefer a repository record with a DOI or other unique, versioned identifier. Privacy, law, licensing, or third-party-data restrictions should be disclosed to the editor rather than silently ignored.

### Reviewers

Distinguish required reviewer fields from encouraged or optional fields. Do not invent suggested or excluded reviewers. Add them only when the authors have approved the names and conflict checks.

## Final validation and submission

Before the irreversible step:

1. inspect the system-generated preview;
2. compare title and abstract with the approved profile;
3. verify all author rows, order, roles, and affiliations;
4. verify the exact funder, grant, recipient, and subject terms;
5. verify each upload role and file;
6. confirm declarations, data plan, and reviewer choices;
7. confirm there is no simultaneous active submission elsewhere;
8. list any uncertainty and resolve material discrepancies;
9. obtain or confirm authorization for the final Submit action.

After submission, preserve the displayed status. A state such as `Received` establishes system receipt but does not by itself establish editor assignment or external review.

## Common failure patterns

- trusting automatic author extraction without counting authors;
- correcting one author but not rechecking the order and roles;
- replacing a signed institute with only its parent organization;
- using an acronym that maps to an unrelated funder;
- selecting a subject area without clicking `Add`;
- uploading a combined reviewer PDF as the main-only manuscript;
- uploading a stale DOCX derivative alongside a newer LaTeX PDF;
- preserving only Git commit IDs when uploaded files include uncommitted local changes;
- saving every intermediate screenshot instead of the final receipt evidence;
- storing tokens or portal credentials in handover documents.
