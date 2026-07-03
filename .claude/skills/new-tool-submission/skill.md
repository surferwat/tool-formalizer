---
description: Accept a filled-out math tool template, lint it, and save it as a markdown file to the Obsidian vault
---

The user has submitted a filled-out math tool template. Follow these steps exactly.

## Step 0 — Check configuration

Read the `## Configuration` section of `CLAUDE.md`. If `TOOLS_PATH` is not set, stop and tell the user: `TOOLS_PATH is not configured. Please run /setup first.`

## Step 1 — Lint

Extract the four field values from the submitted table: **Tool**, **Formal source**, **What it accomplishes**, **Example**.

Run every check below. Collect all failures before reporting.

| # | Check | Pass condition |
| --- | --- | --- |
| 1 | All 4 fields present and non-empty | `Tool`, `Formal source`, `What it accomplishes`, `Example` rows all exist with content |
| 2 | **Tool** is general and atomic | Does not name a specific exercise, problem number, or ad-hoc special value, and describes exactly one atomic mathematical operation |
| 3 | **Formal source** cites mathematics | Names a theorem, proposition, lemma, definition, or similar — not merely a textbook exercise |
| 4 | **What it accomplishes** answers *why* | Explains motivation or the class of problems solved, not just a mechanical restatement |
| 5 | **Example** is self-contained | A reader can follow the worked example without consulting the reference |
| 6 | **Example** ends with a `Reference:` line | A bibliographic citation is present at the end |
| 7 | Math is in LaTeX delimiters | No bare math expressions outside `$...$` or `$$...$$` |

If any check fails, print a numbered list of errors and **stop — do not save**. Ask the user to fix and resubmit.

If all checks pass, print: `Lint passed. Saving...` and continue.

## Step 2 — Derive filename

**Determine the next sequence number:**
List all `.md` files in `TOOLS_PATH`. Find any filenames that begin with a three-digit number (e.g. `003-...`). Take the highest such number and add 1. If none exist, start at `001`. Zero-pad to three digits.

**Slugify the Tool field value:**
- Lowercase
- Strip punctuation
- Replace spaces with hyphens
- Truncate to 60 characters

Combine as: `<NNN>-<slug>.md`

Example: `003-reduction-of-quadratic-to-depressed-form.md`

## Step 3 — Save

Write the following to `<TOOLS_PATH>/<slug>.md`, where `TOOLS_PATH` is defined in the `## Configuration` section of `CLAUDE.md`:

```
| Field | Value |
| --- | --- |
| **Tool** | <Tool value> |
| **Formal source** | <Formal source value> |
| **What it accomplishes** | <What it accomplishes value> |
| **Example** | <Example value> |
```

Do not include the guidelines block.

Confirm to the user: `Saved to <TOOLS_PATH>/<slug>.md`
