# Repository Cleanup Audit Prompt

Use the following prompt with an AI coding agent or reviewer:

```text
You are auditing the complete repository at:

Retail-Sales-Performance-Analytics/

Goal: inspect every folder and every file and produce an evidence-based inventory of items that are empty, stale, duplicated, placeholder-only, meaningless, unused, misplaced, or no longer useful. Do not delete, move, rename, or rewrite anything during the audit. This is an analysis-only task.

Important rules:
1. Inspect the actual current repository tree, not only project_layout.md.
2. Review every text file, source file, SQL file, Markdown file, notebook, configuration file, CSV, and generated report.
3. For binary files such as .xlsx, .pbix, .pptx, .pdf, .png, and .ipynb attachments, inspect metadata, size, timestamps where available, and extract/read content when tooling supports it. If content cannot be inspected, say so explicitly.
4. Check Git status and Git history when available. Use history to distinguish abandoned work from intentionally retained deliverables.
5. Search the repository for references to every candidate file, folder, module, table, report, notebook, and output. Check Python imports, SQL references, documentation links, configuration references, and README/project documentation references.
6. Compare parallel directories and outputs for duplication, especially data/raw, data/cleaned, data/processed, reports, SQL exports, notebooks, Excel, Power BI, and presentation deliverables.
7. Do not classify a file as useless only because it is short. A short schema, config, marker, license, SQL statement, data dictionary entry, or validation result may be meaningful.
8. Treat an empty file as a likely issue, but verify whether it is an intentional package marker, required tool placeholder, or expected empty artifact.
9. Treat generated files as useful only when their source, reproducibility, or role in the final deliverable is clear. Flag generated files that are duplicated, obsolete, untraceable, or disconnected from the current pipeline.
10. Do not infer that a file is unused merely because no text reference exists. Consider external consumers such as Excel, Power BI, presentation files, manual workflows, and database execution.
11. Do not make destructive recommendations without evidence. Use confidence levels: High, Medium, or Low.
12. Preserve user work and report findings only. Do not modify the repository.

For each file or folder, evaluate:
- Exists and is readable
- Empty or nearly empty
- Meaningful content versus placeholder/content of only a few lines
- Duplicate or near-duplicate of another item
- Referenced by source code, SQL, documentation, notebooks, dashboards, reports, or deliverables
- Source/generated relationship
- Whether it belongs in its current folder
- Whether it is stale compared with the current project structure
- Whether it can be safely archived, consolidated, regenerated, or removed

Use these categories:
A. Confirmed issue: empty, broken, obsolete, duplicate, or clearly unused with strong evidence.
B. Likely issue: suspicious or stale, but external/manual use cannot be ruled out.
C. Intentional and useful: small or generated, but has a clear purpose.
D. Needs manual review: binary/external artifact or ambiguous dependency that cannot be verified automatically.
E. Healthy: relevant, referenced, or part of the active analytical workflow.

Pay special attention to:
- Empty README.md and requirements.txt files
- project_layout.md entries that do not exist in the actual tree
- Empty folders and folders containing only placeholders
- Python files with no executable logic, unused modules, dead imports, or duplicate calculations
- SQL files that duplicate other SQL files or reference missing tables/files
- Markdown documents that are empty, repetitive, contradictory, or disconnected from outputs
- Notebooks with no cells, empty cells, stale paths, broken kernels, or duplicated analysis
- CSV files with headers only, zero rows, duplicate exports, or no downstream consumer
- Reports and charts that cannot be traced to a current source or are superseded by later results
- Raw, cleaned, processed, and feature datasets that duplicate each other without documented purpose
- Excel, Power BI, presentation, PDF, and image artifacts that are missing, stale, or not reflected in documentation
- Folders whose names imply planned content but are empty or absent from the actual project
- Hard-coded paths, broken relative paths, references to missing files, and documentation/tree drift

Required process:
1. Print the complete actual tree.
2. Build a file inventory containing path, type, size, line/cell/row count where applicable, and readability status.
3. Read and inspect all text and structured files.
4. Inspect notebooks as JSON and report cell counts, cell types, empty cells, and referenced paths.
5. Inspect source and SQL dependencies and search all repository references.
6. Compare documentation with the actual tree and identify drift.
7. Check for duplicates using names, hashes, schemas, content similarity, and overlapping outputs.
8. Check Git status/history if available.
9. Produce the final report below.

Required final report format:

# Repository Audit Report

## Executive Summary
- Total files and folders inspected
- Confirmed issues count
- Likely issues count
- Manual-review count
- Most important cleanup risks

## Confirmed Issues
Use a table with:
| Path | Type | Evidence | Impact | Recommended action | Confidence |

Only include items with strong evidence. Recommended actions must be one of: Remove, Archive, Consolidate, Rebuild, Move, or Document.

## Likely Issues
Use the same table and explain what evidence is missing.

## Small but Meaningful Files
List short files that should be retained and explain their purpose. This prevents accidental deletion of valid configuration, schema, license, marker, or documentation files.

## Duplicate or Overlapping Items
For each group, list all paths, explain the overlap, identify the canonical copy, and recommend whether to consolidate or retain both.

## Empty and Placeholder Items
Separate truly empty items from intentionally empty or tool-required items.

## Documentation and Structure Drift
Compare project_layout.md and other documentation to the actual repository tree. List missing, extra, renamed, and misplaced items.

## Dependency and Reference Findings
List broken references, missing inputs, unreferenced outputs, stale paths, imports, SQL dependencies, and external/manual dependencies.

## Binary and External Deliverables Requiring Manual Review
Include Excel, Power BI, PowerPoint, PDF, image, and other files whose business value cannot be confirmed from text inspection alone.

## Recommended Cleanup Sequence
Give a low-risk ordered sequence. Do not include deletion commands. Start with documentation corrections and confirmed empty/broken items, then address duplicates and generated artifacts, and finally items needing manual review.

## Limitations
State exactly which files, formats, dependencies, or external workflows could not be verified.

For every finding, cite the exact repository-relative path and concrete evidence. Do not use vague statements such as "this seems unnecessary." Distinguish "not referenced in this repository" from "proven unused." End by asking for approval before any destructive cleanup.
```
