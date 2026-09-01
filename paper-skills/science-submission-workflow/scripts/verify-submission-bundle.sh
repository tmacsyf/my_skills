#!/usr/bin/env bash
set -euo pipefail

usage() {
  printf '%s\n' \
    'Usage:' \
    '  verify-submission-bundle.sh --main FILE --combined FILE [options]' \
    '' \
    'Required:' \
    '  --main FILE          Main-manuscript PDF' \
    '  --combined FILE      Combined reviewer PDF' \
    '' \
    'Optional artifacts:' \
    '  --cover FILE         Cover-letter PDF' \
    '  --supplement FILE    Separate supplementary-material PDF' \
    '  --source FILE        LaTeX/source ZIP' \
    '' \
    'Output:' \
    '  --output FILE        Write Markdown report to FILE instead of stdout' \
    '  --force              Allow overwriting --output FILE' \
    '  -h, --help           Show this help'
}

main_file=''
combined_file=''
cover_file=''
supplement_file=''
source_file=''
output_file=''
force=0

while (($#)); do
  case "$1" in
    --main|--combined|--cover|--supplement|--source|--output)
      if (($# < 2)); then
        printf 'ERROR: %s requires a value.\n' "$1" >&2
        exit 2
      fi
      case "$1" in
        --main) main_file=$2 ;;
        --combined) combined_file=$2 ;;
        --cover) cover_file=$2 ;;
        --supplement) supplement_file=$2 ;;
        --source) source_file=$2 ;;
        --output) output_file=$2 ;;
      esac
      shift 2
      ;;
    --force)
      force=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      printf 'ERROR: unknown option: %s\n' "$1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

if [[ -z $main_file || -z $combined_file ]]; then
  printf 'ERROR: --main and --combined are required.\n' >&2
  usage >&2
  exit 2
fi

if [[ -n $output_file && -e $output_file && $force -ne 1 ]]; then
  printf 'ERROR: output exists; pass --force to overwrite: %s\n' "$output_file" >&2
  exit 2
fi

if command -v sha256sum >/dev/null 2>&1; then
  sha256_file() { sha256sum "$1" | awk '{print $1}'; }
elif command -v shasum >/dev/null 2>&1; then
  sha256_file() { shasum -a 256 "$1" | awk '{print $1}'; }
else
  printf 'ERROR: sha256sum or shasum is required.\n' >&2
  exit 2
fi

declare -a roles=()
declare -a paths=()
declare -a kinds=()
declare -a rows=()
declare -a checks=()
failed=0
warned=0

add_artifact() {
  roles+=("$1")
  paths+=("$2")
  kinds+=("$3")
}

add_check() {
  local level=$1
  local message=$2
  checks+=("- **${level}**: ${message}")
  case "$level" in
    FAIL) failed=1 ;;
    WARN) warned=1 ;;
  esac
}

md_escape() {
  local value=$1
  value=${value//|/\\|}
  printf '%s' "$value"
}

add_artifact 'Manuscript' "$main_file" 'pdf'
add_artifact 'Combined PDF' "$combined_file" 'pdf'
[[ -n $cover_file ]] && add_artifact 'Cover Letter' "$cover_file" 'pdf'
[[ -n $supplement_file ]] && add_artifact 'Supplementary Material' "$supplement_file" 'pdf'
[[ -n $source_file ]] && add_artifact 'Source Archive' "$source_file" 'zip'

for index in "${!paths[@]}"; do
  role=${roles[$index]}
  path=${paths[$index]}
  kind=${kinds[$index]}
  filename=$(basename "$path")
  pages='—'
  page_size='—'

  if [[ ! -f $path ]]; then
    add_check 'FAIL' "${role}: file not found: $(md_escape "$path")"
    rows+=("| $(md_escape "$role") | $(md_escape "$filename") | — | — | — | — |")
    continue
  fi

  bytes=$(wc -c < "$path" | tr -d '[:space:]')
  digest=$(sha256_file "$path")
  add_check 'PASS' "${role}: file exists and SHA-256 was calculated."

  if [[ $kind == 'pdf' ]]; then
    if command -v pdfinfo >/dev/null 2>&1; then
      if pdf_metadata=$(pdfinfo "$path" 2>&1); then
        pages=$(printf '%s\n' "$pdf_metadata" | awk -F: '/^Pages:/ {sub(/^[[:space:]]+/, "", $2); print $2; exit}')
        page_size=$(printf '%s\n' "$pdf_metadata" | awk -F: '/^Page size:/ {sub(/^[[:space:]]+/, "", $2); print $2; exit}')
        [[ -n $pages ]] || pages='unknown'
        [[ -n $page_size ]] || page_size='unknown'
        add_check 'PASS' "${role}: PDF metadata is readable (${pages} page(s))."
        if [[ $page_size != *'612 x 792'* && $page_size != *'letter'* && $page_size != *'Letter'* ]]; then
          add_check 'WARN' "${role}: page size is not recognized as US Letter (${page_size}); confirm against current CTS requirements."
        fi
      else
        add_check 'FAIL' "${role}: pdfinfo could not read the PDF."
      fi
    else
      add_check 'WARN' "${role}: pdfinfo is unavailable; page count and dimensions were not checked."
    fi

    if command -v pdftotext >/dev/null 2>&1; then
      if pdftotext "$path" - >/dev/null 2>&1; then
        add_check 'PASS' "${role}: PDF text extraction succeeded."
      else
        add_check 'FAIL' "${role}: PDF text extraction failed."
      fi
    else
      add_check 'WARN' "${role}: pdftotext is unavailable; searchable text was not checked."
    fi

    if command -v pdffonts >/dev/null 2>&1; then
      if font_report=$(pdffonts "$path" 2>&1); then
        font_rows=$(printf '%s\n' "$font_report" | awk 'NR > 2 && NF {count++} END {print count+0}')
        if [[ $font_rows -eq 0 ]]; then
          add_check 'WARN' "${role}: no font rows were reported; inspect the PDF manually."
        elif printf '%s\n' "$font_report" | awk '
          NR == 1 { emb_col = index($0, "emb"); next }
          NR <= 2 || !NF { next }
          emb_col > 0 && substr($0, emb_col, 3) != "yes" { bad = 1 }
          END { exit bad }
        '; then
          add_check 'PASS' "${role}: all reported fonts are embedded."
        else
          add_check 'FAIL' "${role}: at least one reported font is not embedded."
        fi
      else
        add_check 'FAIL' "${role}: pdffonts could not inspect the PDF."
      fi
    else
      add_check 'WARN' "${role}: pdffonts is unavailable; font embedding was not checked."
    fi
  else
    if command -v unzip >/dev/null 2>&1; then
      if unzip -tqq "$path" >/dev/null 2>&1; then
        add_check 'PASS' "${role}: ZIP integrity test passed."
        archive_listing=$(unzip -Z1 "$path")
        if printf '%s\n' "$archive_listing" | awk -F/ '$NF ~ /\.tex$/ {found=1} END {exit !found}'; then
          add_check 'PASS' "${role}: archive contains at least one TeX source file."
        else
          add_check 'FAIL' "${role}: archive contains no TeX source file."
        fi
        if printf '%s\n' "$archive_listing" | awk -F/ '$NF == "main.tex" {found=1} END {exit !found}'; then
          add_check 'PASS' "${role}: archive contains main.tex."
        else
          add_check 'WARN' "${role}: main.tex was not found; confirm the intended root file and portal description."
        fi
      else
        add_check 'FAIL' "${role}: ZIP integrity test failed."
      fi
    else
      add_check 'WARN' "${role}: unzip is unavailable; archive integrity and contents were not checked."
    fi
  fi

  rows+=("| $(md_escape "$role") | $(md_escape "$filename") | ${bytes} | ${pages} | $(md_escape "$page_size") | ${digest} |")
done

if [[ $failed -eq 1 ]]; then
  overall='FAIL'
elif [[ $warned -eq 1 ]]; then
  overall='PASS WITH WARNINGS'
else
  overall='PASS'
fi

report_tmp=$(mktemp)
trap 'rm -f "$report_tmp"' EXIT
{
  printf '# Submission bundle verification\n\n'
  printf -- '- Generated: %s\n' "$(date -u '+%Y-%m-%dT%H:%M:%SZ')"
  printf -- '- Result: **%s**\n\n' "$overall"
  printf '| Role | File | Bytes | Pages | Page size | SHA-256 |\n'
  printf '|---|---|---:|---:|---|---|\n'
  printf '%s\n' "${rows[@]}"
  printf '\n## Checks\n\n'
  printf '%s\n' "${checks[@]}"
  printf '\n## Boundary\n\n'
  printf '%s\n' 'This report checks file mechanics only. It does not validate scientific content, citation correctness, visual layout, portal metadata, or current journal policy.'
} > "$report_tmp"

if [[ -n $output_file ]]; then
  mkdir -p "$(dirname "$output_file")"
  cp "$report_tmp" "$output_file"
  printf 'Wrote report: %s\n' "$output_file"
else
  cat "$report_tmp"
fi

if [[ $failed -eq 1 ]]; then
  exit 1
fi
