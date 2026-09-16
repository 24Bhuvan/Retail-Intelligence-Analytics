# Reports Directory

## Purpose

This directory stores the project’s evidence, summaries, validation outputs, and business-facing reporting artifacts. It captures the deliverables produced at each phase of the Retail Sales Performance Analytics workflow, including profiling, data quality, cleaning, EDA, feature engineering, KPI generation, business metrics, and final insight reporting.

## Current Contents

The repository contains multiple report categories under this directory:

- `business_understanding/` — stakeholder and business-context reporting
- `business_metrics/` — KPI and business metric tables, including final KPI outputs
- `dashboard_validation/` — validation and QA artifacts for dashboard reporting
- `data_cleaning/` — cleaning logs, summaries, and validation results
- `data_modeling/` — analytical model validation artifacts
- `data_quality/` — data quality assessment outputs and validation results
- `data_understanding/` — inventory, data dictionary, and ER-diagram outputs
- `eda/` — EDA findings, charts, and supporting visuals
- `feature_engineering/` — feature-validation and feature-engineering summaries
- `insights/` — business insight evidence and validation files
- `kpi_design/` — KPI design audit and KPI summary artifacts
- `profiling/` — dataset profiling reports
- `python_processing/` — Python processing validation, reproducibility, and traceability outputs
- `recommendations/` — executive recommendations
- `sql/` — SQL-derived analytical output files

## Relationship to the Project Workflow

The reports folder reflects the project lifecycle:

```text
Business understanding
  → data understanding and profiling
  → data quality and cleaning validation
  → modeling and data validation
  → feature engineering
  → KPI / business metrics
  → insight generation
  → dashboard validation and executive recommendations
```

This is consistent with the files present across the subfolders and the project documentation.

## How the Files Are Used

- The profiling, quality, and cleaning folders preserve the evidence generated during the earlier analytical phases.
- The business metrics folder is the repository’s main KPI and metric output area.
- The insights and recommendation folders capture analytical interpretation and executive-facing guidance.
- The SQL output folder stores analytical exports such as category sales, monthly sales, delivery analysis, payment analysis, and regional sales results.
- The EDA folder contains artifacts such as charts and summary findings used to support exploratory analysis.

## Reproducibility Notes

- The reports directory is an output layer with evidence files, not a source dataset layer.
- Several subfolders contain CSV, JSON, Markdown, PDF, and Excel outputs with validation and traceability metadata.
- Some report directories represent completed project phases; others are present as supporting logs or QA outputs, and the repository should be treated as the source of truth for what actually exists.
- This folder is especially important for traceability: processing, validation, and business metric files are stored here so results can be checked against the underlying SQL and Python workflows.
- Empty or absent subdirectories should not be described as completed outputs if they do not exist in the repository.
