# Docs Directory

## Purpose

This directory holds the repository’s project documentation and design artifacts. It contains the written definitions for the project scope, business context, analytics requirements, KPI logic, data model design, and Power BI/reporting blueprint. The content in this folder explains both the intended architecture and the actual project implementation decisions captured during the repository workflow.

## Current Contents

The directory contains the following major documentation sections:

- `business_background.md` — business problem and market context
- `business_requirements.md` — user and stakeholder requirements
- `feature_dictionary.md` — definitions for engineered and source features
- `kpi_dictionary.md` — definitions for KPI dimensions and measures
- `kpi_specification.md` — KPI measurement logic and design details
- `project_charter.md` — project goals, scope, and governance framing
- `project_scope.md` — in-scope and out-of-scope boundaries
- `references.md` — links and references used during the analytical project
- `repository_audit_prompt.md` — audit prompt used to assess repository completeness and implementation accuracy
- `schema_design.md` — schema and modeling rationale
- `archive/` — historical draft materials, including an earlier KPI dictionary draft
- `powerbi/` — Power BI reporting blueprint, data model, report plan, visual plan, filter interaction plan, and DAX plan

## Relationship to the Project Workflow

This folder is the documentation backbone of the repository and sits alongside the project’s technical and reporting layers:

```text
Business understanding
  → requirements and scope
  → schema and KPI definitions
  → Power BI blueprint and report planning
  → implementation in SQL, Python, Excel, and Power BI
  → reporting and validation outputs
```

The documents here are not the processing data itself; they are governance and design artifacts that explain how the project should be interpreted and implemented.

## How the Files Are Used

- The planning and requirements files define the business problem and expected outputs.
- The KPI and feature dictionaries provide formal naming and logic for the metrics described in the analysis.
- The schema and modeling documents describe the relational and analytical structure used in the SQL layer.
- The Power BI documentation explains how the dashboard should be structured, filtered, and measured.
- The archive folder preserves earlier drafts that may not reflect the final project state.

## Reproducibility Notes

- This directory is descriptive and design-oriented rather than data-driven.
- The repo contains both finalized documents and historical draft content, so the archive folder should be treated separately from current implementation docs.
- The project’s actual implementation is grounded in the SQL scripts, processed datasets, reports, and Power BI deliverables; the documentation here provides context and specification rather than raw results.
- Because some project artifacts are incomplete or partially populated, the docs should be treated as evidence of the intended process and analytical framing rather than as a complete inventory of every downstream deliverable.
