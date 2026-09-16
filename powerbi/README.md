# Power BI Directory

## Purpose

This directory contains the project’s Power BI report artifact and the repository’s DAX documentation. The Power BI component is the reporting layer that consumes the analytical model and translates it into dashboard visuals and business-facing metrics.

## Current Contents

- `Retail_Sales_Performance_Analytics.pbix` — Power BI report file
- `dax_measures.md` — DAX documentation file for the report

## Verified Repository Information

The project documentation in `docs/powerbi/` describes the Power BI design in detail and confirms the intended analytical architecture:

- the reporting layer should consume PostgreSQL analytical tables from the `analytics` schema
- the semantic model follows a dimensional star-schema approach
- the model is intended to support sales, product, seller, regional, customer, and delivery analysis
- DAX measures should centralize KPI logic rather than duplicate upstream transformations

The project does not contain a separate `wireframes/` folder in this repository, so no verified wireframe files were created or used in the current implementation.

## Relationship to the Project Workflow

The repository indicates this flow for Power BI:

```text
Raw source data
  → cleaned data
  → processed / feature-engineered data
  → PostgreSQL analytics schema
  → Power BI semantic model
  → DAX measures
  → report pages and dashboard visuals
```

This matches the Power BI blueprint documents and the project’s analytical model documentation.

## How the Files Are Used

- The `.pbix` file is the actual dashboard/report deliverable.
- The DAX documentation is intended to support the definitions and logic behind the report measures.
- The blueprint and data model docs under `docs/powerbi/` explain the intended semantic structure and filtering logic for the dashboard layer.
- The analytical outputs from PostgreSQL and the processed/feature datasets are the upstream inputs that should be reflected in the dashboard.

## Reproducibility Notes

- The project’s Power BI design is intended to connect to the PostgreSQL analytical database, especially the `analytics` schema, rather than directly to raw CSV files.
- The repository has explicit documentation for the Power BI model and dashboard structure, but the actual report internals are not programmatically inspectable from the `.pbix` file in a text-based repository review.
- `dax_measures.md` is present in the directory but is empty in the repository state reviewed here, so no DAX measures can be documented from the file itself.
- Any Power BI-specific implementation details beyond the project documentation should be treated as design intent rather than verified repository contents unless directly inspectable.
- Because the `.pbix` file is a binary artifact, the exact visual layout and internal measure definitions cannot be fully verified through file inspection alone.
