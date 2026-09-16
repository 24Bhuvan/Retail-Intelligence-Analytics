# Data Directory

## Purpose

This directory holds the project’s source and analytical datasets for the Retail Sales Performance Analytics workflow. It is the repository’s central data layer: raw source files are kept separate from cleaned and processed outputs, and the processed feature tables feed downstream SQL, Python analysis, KPI calculations, and Power BI reporting.

## Current Contents

The repository currently contains three main data layers:

- `raw/` — original Olist source CSV files
- `cleaned/` — cleaned and standardized copies of the same nine source datasets
- `processed/` — validated analytical datasets, including feature-engineered outputs

### `raw/`

Contains the original source files copied into the project:

- `olist_customers_dataset.csv`
- `olist_geolocation_dataset.csv`
- `olist_orders_dataset.csv`
- `olist_order_items_dataset.csv`
- `olist_order_payments_dataset.csv`
- `olist_order_reviews_dataset.csv`
- `olist_products_dataset.csv`
- `olist_sellers_dataset.csv`
- `product_category_name_translation.csv`

These files are treated as the unmodified source layer and are not intended to be overwritten by the analytical steps.

### `cleaned/`

This directory contains the same nine source datasets after the project’s Phase 5 cleaning rules are applied. The repository uses the cleaned tables as the controlled starting point for downstream validation and analytics.

The files currently present are the same Olist dataset names, with cleaned versions saved as CSVs in the same naming convention.

### `processed/`

This directory contains the project’s analytical transformation outputs that are explicitly created for downstream analysis.

Current files include:

- `customers_processed.csv`
- `geography_processed.csv`
- `orders_processed.csv`
- `order_items_processed.csv`
- `payments_processed.csv`
- `products_processed.csv`
- `reviews_processed.csv`
- `sellers_processed.csv`

And the feature subdirectory contains the engineered feature datasets:

- `orders_features.csv`
- `order_items_features.csv`
- `customer_features.csv`
- `monthly_features.csv`

`interim/` and `external/` are not currently present in the repository and should not be assumed to exist.

## Relationship to the Project Workflow

The actual project flow reflected in the repository is:

```text
Raw Olist data
  → Cleaning / standardization
  → Cleaned datasets
  → Processed analytical datasets
  → Feature-engineered datasets
  → SQL model validation and KPI queries
  → Python analysis and business metrics
  → Power BI / dashboard consumption
  → Reporting and insights
```

This is consistent with the SQL and Python pipeline files, which operate from the cleaned and processed layers rather than directly from the raw CSVs.

## How the Files Are Used

- Analysts use `data/raw/` as the original reference layer.
- Cleaning scripts produce the `data/cleaned/` tables.
- Processing scripts create the `data/processed/` files used in EDA and validation.
- The feature datasets in `data/processed/features/` are the source for KPI design, business metrics, and reporting outputs.
- The repo’s SQL scripts and the EDA notebook use the processed outputs as their main analytical inputs.

## Reproducibility Notes

- The raw and cleaned datasets are distinct layers; the raw files should not be modified by the cleaning pipeline.
- The processed files are expected outputs of the Python ETL/feature-engineering pipeline.
- Feature generation relies on the processed datasets rather than directly on raw data.
- File naming conventions and shape are defined by the implementation in the Python modules and SQL schema comments.
- These folders are not standalone deliverables; they are inputs to the project’s analytical and reporting pipeline.
