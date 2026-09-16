# Source Code Directory

## Purpose

This directory contains the project’s Python implementation for the data pipeline, validation, and analytical calculations. It is the operational core for transforming the source datasets into cleaned, processed, and feature-engineered outputs used throughout the project.

## Current Contents

### `src/data/`

This subdirectory contains the data pipeline scripts:

- `load_data.py` — loads and validates the cleaned source datasets
- `preprocess.py` — shared preprocessing utilities for null handling, text cleaning, categorical normalization, and timestamp parsing
- `clean_data.py` — executes the Phase 5 cleaning rules and writes cleaned CSV outputs
- `process_data.py` — prepares the processed analytical datasets and validates row-level reproducibility and grain
- `feature_engineering.py` — creates the feature datasets used for analysis and KPI work
- `validate_input.py` — input-validation routines used as part of the data pipeline

These scripts work from the project root and write outputs into `data/cleaned/`, `data/processed/`, and the reporting folders under `reports/`.

### `src/analysis/`

This subdirectory contains the analytical scripts that assess quality, calculate metrics, and generate business results:

- `data_quality_assessment.py` — checks raw dataset quality issues and writes reports
- `generate_dataset_profile.py` — produces dataset profiling summaries and validation metadata
- `sql_python_validation.py` — compares Python-generated results with SQL-side analytical outputs
- `cross_validate_postgres.py` — validates Python processing results against PostgreSQL data
- `post_cleaning_validation.py` — checks cleaned outputs after the cleaning step
- `reconciliation_checks.py` — validates cross-dataset reconciliations and aggregates
- `kpi_calculations.py` — calculates the project KPI inventory and related metrics
- `business_metrics.py` — creates detailed business metric tables such as category, regional, and product metrics
- `create_final_kpi_results.py` — combines KPI results into final export-ready outputs

These scripts are the main Python implementation for the KPI and business metric workflow.

## Relationship to the Project Workflow

The actual repository flow is:

```text
raw CSVs
  → src/data/preprocess.py and clean_data.py
  → data/cleaned/
  → src/data/process_data.py
  → data/processed/
  → src/data/feature_engineering.py
  → data/processed/features/
  → src/analysis/kpi_calculations.py and business_metrics.py
  → reports/business_metrics/
  → SQL / Power BI / insight reporting
```

## How the Files Are Used

- The `src/data` scripts are the project’s ETL and transformation layer.
- The `src/analysis` scripts are used after data processing to validate quality and calculate business outputs.
- The feature datasets created by `feature_engineering.py` are the controlled analytical inputs for KPI and metric generation.
- Several scripts explicitly produce files under the `reports/` directory and should be treated as reproducibility artifacts rather than ad hoc analysis.

## Reproducibility Notes

- This source tree depends on the project’s data folders and the repository layout; scripts resolve project paths relative to the repository root.
- The cleaning and processing stages create outputs in `data/cleaned/` and `data/processed/` before feature engineering and KPI work begin.
- Several scripts write report files to `reports/` subfolders, which records the output lineage for audits and validation.
- The scripts are designed around the Olist dataset schema and should not be treated as generic tools for unrelated data sources.
- Some analysis scripts assume PostgreSQL outputs and validation files exist, so the project’s SQL and Python steps should be executed in the intended sequence.
