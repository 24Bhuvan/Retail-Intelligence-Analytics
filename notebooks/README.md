# Notebooks Directory

## Purpose

This directory contains the project’s interactive analysis work and is currently centered on exploratory data analysis for the processed datasets. The repository has a single notebook, `eda.ipynb`, and it is the main analytical notebook in the project workflow.

## Current Contents

- `eda.ipynb` — exploratory analysis notebook for the processed Olist datasets

## Relationship to the Project Workflow

The notebook sits after the processed data layer and before the reporting and KPI interpretation phases:

```text
data/processed/
  → EDA notebook
  → business metrics / KPI interpretation
  → reporting and insight artifacts
```

The notebook explicitly loads the eight processed datasets, validates their existence, and uses them to explore product, customer, geography, order, payment, review, and seller patterns.

## How the Files Are Used

The EDA notebook:

- resolves the project root based on the presence of `data/processed/`
- checks that all expected processed datasets are present
- loads the processed CSV files into pandas DataFrames
- performs exploratory analysis on order, product, customer, and operational metrics
- supports trend, distribution, and anomaly identification
- is designed to work with the repository’s Phase 9 processed outputs rather than the raw source files

## Reproducibility Notes

- The notebook depends on the processed datasets under `data/processed/` and will fail if they are missing.
- It uses the project’s validated datasets rather than raw source files.
- The script includes assertions to confirm the expected number of processed datasets and data frame types.
- Relevant dependency packages include `pandas`, `matplotlib`, and `seaborn`.
- The notebook is a descriptive analysis artifact; it does not replace the SQL data model or the KPI calculation scripts.
