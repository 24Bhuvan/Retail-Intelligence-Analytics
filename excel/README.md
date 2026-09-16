# Excel Directory

## Purpose

This directory contains the workbook used as a spreadsheet analysis artifact for the Retail Sales Performance Analytics project. The workbook is a project-level Excel implementation that cross-checks the cleaned source data against core business metrics and pivot summaries.

## Current Contents

- `Retail_Analysis.xlsx` — project Excel workbook

## Verified Workbook Structure

The workbook contains multiple worksheets, including:

- `Orders`
- `Order_Items`
- `Products`
- `Sellers`
- `Customers`
- `Payments`
- `Reviews`
- `Category_Translation`
- `README`
- `Data_Sample`
- `Sales_Summary`
- `Pivot_Sales`
- `Monthly_Sales`
- `Category_Analysis`
- `Product_Analysis`
- `Customer_Analysis`
- `Regional_Analysis`
- `Pivot_Category`
- `Pivot_Region`
- `Calculation_Checks`
- `Validation_Summary`

The workbook includes raw source tables for customers, orders, products, payments, reviews, and seller data, plus summary sheets and pivot tables for sales and category analysis.

## Relationship to the Project Workflow

The workbook is an Excel-based analytical layer that sits alongside the Python / SQL pipeline. The repository metadata describes it as Phase 7 Excel analysis built from the Phase 5 cleaned datasets and the Phase 6 analytical model.

The workflow reflected by the workbook is consistent with:

```text
Cleaned source data
  → Excel workbook tables and summaries
  → KPI and sales checks
  → validation and reporting support
```

## How the Files Are Used

- The workbook stores a ready-to-review version of the Olist source tables and related dimensions.
- Summary sheets provide sales totals, order counts, AOV, category analysis, product analysis, and customer/regional analysis.
- Pivot sheets summarize monthly and category aggregations.
- The `Calculation_Checks` sheet explicitly validates counts and totals, including order count, order-item count, sales total, payment total, freight total, and duplicate checks.
- The `README` sheet describes the workbook purpose and its project-phase positioning.

## Reproducibility Notes

- The workbook reads like a validation and exploratory reporting artifact rather than the primary source-of-truth dataset.
- The `Calculation_Checks` sheet records pass/fail validation for core totals and duplicate metrics, so the workbook is used as a QA support artifact.
- It references the cleaned and analytical project data rather than acting as a replacement for the data pipeline.
- Because the workbook is a binary file, exact workbook logic and formulas were not inferred beyond the workbook’s visible sheet names and sample values.
- The workbook should be treated as a supplemental analytical and validation artifact, not as the canonical data processing layer.
