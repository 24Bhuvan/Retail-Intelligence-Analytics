# SQL Directory

## Purpose

The SQL directory contains the project’s PostgreSQL scripts for schema creation, profiling, validation, data cleaning, analytical modeling, and KPI/business analysis. These scripts are the repository’s database-side implementation for the analytics layer of the Retail Sales Performance Analytics project.

## Current Contents

The directory currently contains the following SQL scripts:

- `schema.sql` — creates the analytic database structure and the `analytics` schema
- `data_profiling.sql` — read-only profiling of the raw Olist datasets
- `data_validation.sql` — data-quality checks and validation rules
- `data_cleaning.sql` — cleaned database tables in a separate `cleaned` schema
- `data_modeling_load.sql` — analytical dimension loads
- `data_modeling_fact_load.sql` — analytical fact-table loads
- `data_modeling_validation.sql` — validation checks for the analytical model
- `business_queries.sql` — business analysis queries on the analytical tables
- `business_metrics_queries.sql` — metric queries aligned to the business metrics workflow
- `analytical_queries.sql` — additional SQL analysis examples using the analytical model
- `kpi_queries.sql` — KPI calculations and business metric extracts
- `python_cross_validation.sql` — PostgreSQL-side validation of Python-generated outputs
- `feature_engineering_validation.sql` — validation for feature-engineering outputs
- `sql_validation.sql` — higher-level SQL validation logic
- `export_analytical_outputs.sql` — export-oriented analytical output queries
- `validation/` — validation-related SQL scripts including PostgreSQL validation helpers

## Relationship to the Project Workflow

The SQL layer supports the following sequence in the current repository:

```text
Source Olist datasets
  → data_profiling.sql
  → data_validation.sql
  → data_cleaning.sql
  → schema.sql
  → data_modeling_load.sql
  → data_modeling_fact_load.sql
  → business_queries.sql / analytical_queries.sql
  → kpi_queries.sql / business_metrics_queries.sql
  → validation scripts and export-oriented outputs
```

This aligns with the project documentation, which treats PostgreSQL as the analytical database serving the reporting and KPI layers.

## How the Files Are Used

- Database creation and analytical schema design are handled in `schema.sql`.
- Profiling and validation scripts are used to assess data quality before and during model design.
- `data_cleaning.sql` creates the `cleaned` schema and preserves raw-source integrity.
- `data_modeling_load.sql` and `data_modeling_fact_load.sql` populate the star-schema tables in the `analytics` schema.
- `business_queries.sql`, `analytical_queries.sql`, and `business_metrics_queries.sql` are used to quantify trends and operational metrics.
- `kpi_queries.sql` is the primary script for KPI calculation using the validation and cleaned data layers.
- Validation scripts are used to confirm row counts, grain, model integrity, and project outputs.

## Reproducibility Notes

- The scripts are written for PostgreSQL and reference schemas such as `analytics` and `cleaned`.
- The project documentation identifies the database name as `retail_sales_analytics`.
- The repository’s SQL and Python implementations treat the cleaned and processed layers as the controlled source for the analytical model.
- The scripts are intentionally separated by purpose: profiling, validation, cleaning, modeling, and business analysis.
- Some SQL files are validation utilities rather than final production scripts, and they should be treated as part of the project’s evidence and QA workflow rather than as generic database setup files.
- The SQL flow assumes the raw Olist tables are already available in PostgreSQL before the analytical objects are built.
