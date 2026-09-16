# Retail Sales Performance Analytics

**An end-to-end, evidence-backed business intelligence case study built on the Olist Brazilian E-commerce dataset — from business charter to validated KPIs to a Power BI semantic model.**

<p>
<img alt="Methodology" src="https://img.shields.io/badge/methodology-CRISP--DM-0F172A">
<img alt="Python" src="https://img.shields.io/badge/Python-3.10-3776AB?logo=python&logoColor=white">
<img alt="PostgreSQL" src="https://img.shields.io/badge/PostgreSQL-analytics%20schema-336791?logo=postgresql&logoColor=white">
<img alt="Power BI" src="https://img.shields.io/badge/Power%20BI-star%20schema-F2C811?logo=powerbi&logoColor=black">
<img alt="Excel" src="https://img.shields.io/badge/Excel-QA%20workbook-217346?logo=microsoftexcel&logoColor=white">
<img alt="License" src="https://img.shields.io/badge/license-MIT-green">
</p>

---

## Table of Contents

- [Overview](#overview)
- [Why this project is different](#why-this-project-is-different)
- [Headline results](#headline-results)
- [Architecture](#architecture)
- [Repository structure](#repository-structure)
- [Data layers](#data-layers)
- [Analytical data model](#analytical-data-model)
- [Feature engineering](#feature-engineering)
- [KPI framework](#kpi-framework)
- [Validation and quality evidence](#validation-and-quality-evidence)
- [Business insights](#business-insights)
- [Executive recommendations](#executive-recommendations)
- [Power BI deliverable](#power-bi-deliverable)
- [Getting started](#getting-started)
- [Reproducing the pipeline](#reproducing-the-pipeline)
- [Tech stack](#tech-stack)
- [Known gaps and open items](#known-gaps-and-open-items)
- [Limitations and analytical integrity](#limitations-and-analytical-integrity)
- [Project governance](#project-governance)
- [License](#license)

---

## Overview

This repository implements a complete retail analytics engagement on the **Olist Brazilian E-commerce Public Dataset** — nine relational tables covering the full commercial lifecycle: customer registration, product listings, orders, order items, payments, shipping, delivery and post-purchase reviews.

The work follows **CRISP-DM** end to end and is delivered across four parallel implementation layers — **Python**, **PostgreSQL**, **Excel** and **Power BI** — with every headline number independently cross-validated between at least two of them before it is allowed into a business report.

| Attribute | Value |
| --- | --- |
| Project type | Portfolio case study (simulated business context) |
| Methodology | CRISP-DM, executed across 22 tracked phases |
| Source dataset | Olist Brazilian E-commerce Public Dataset (9 tables) |
| Coverage period | 2016-09-04 → 2018-10-17 |
| Analytical database | PostgreSQL — `retail_sales_analytics` |
| Implementation size | ~18,400 lines of Python across 15 modules; ~11,200 lines of SQL across 17 scripts |
| Deliverables | Star schema, feature store, 32-KPI framework, Power BI report, insight and recommendation reports |

> **Simulation notice.** The sponsor, stakeholders, governance and approvals documented in `docs/project_charter.md` are simulated for portfolio purposes. The *data*, *calculations* and *validation evidence* are real and reproducible.

---

## Why this project is different

Most portfolio analytics repositories stop at "I made a dashboard." This one is built like an audited engagement:

- **Dual implementation with forced reconciliation.** Every one of the 32 KPIs is computed independently in Python and in SQL. All 32 agree — largest absolute divergence across the entire framework is `1.9e-09`, i.e. floating-point noise. Evidence: `reports/business_metrics/sql_python_validation.csv`.
- **Raw data is never mutated.** Cleaning writes to a separate layer; the cleaning log records all 32 actions with a stated *rule*, *rationale* and *rows affected* per action.
- **Cleaning decisions are defended, not defaulted.** `review_id` duplicates are deliberately *not* removed because `review_id` is not unique in the source model. Invalid chronology timestamps are nullified rather than fabricated. Zero freight values are retained because zero is semantically valid.
- **Findings are stated at the strength the evidence supports.** The delivery/review relationship is reported as an *association*, never a cause. Where a SQL output failed to reconcile with the validated baseline, it was excluded from the final evidence chain rather than quietly averaged in.
- **QA failures are published, not hidden.** The dashboard QA report records an incorrect YoY measure found during validation, a slow cumulative-product visual, and open retest items — and marks the phase **IN PROGRESS** rather than declaring success.

---

## Headline results

All figures below are the **validated reporting baseline**, reconciled across PostgreSQL, Python, Excel and the Power BI model.

| KPI | Value |
| --- | ---: |
| Total revenue (item price, freight excluded) | **R$ 13,591,643.70** |
| Total orders | **99,441** |
| Total order items | **112,650** |
| Average order value | **R$ 136.68** |
| Total customers (`customer_unique_id`) | **96,096** |
| Repeat customers | **2,997** (**3.12%**) |
| Total payment value | **R$ 16,008,872.12** |
| Total freight value | **R$ 2,251,909.54** |
| On-time delivery rate | **91.89%** |
| Average delivery time | **12.56 days** |
| Average review score | **4.09 / 5** |
| Sellers · Products · Categories · States | **3,095 · 32,951 · 74 · 23** |

**Revenue standard used throughout:** `Item Revenue = price`; freight is excluded from revenue and payment value is never treated as revenue. This single governance rule is why revenue (R$13.59M), order value (R$15.84M) and payment value (R$16.01M) are three distinct, deliberately non-interchangeable measures.

---

## Architecture

```text
                 ┌──────────────────────────────────────────────┐
                 │  data/raw/ — 9 Olist CSVs (immutable)        │
                 └───────────────────────┬──────────────────────┘
                                         │  src/data/preprocess.py + clean_data.py
                                         ▼
                 ┌──────────────────────────────────────────────┐
                 │  data/cleaned/ — 32 logged cleaning actions  │
                 └───────────┬──────────────────────┬───────────┘
                             │                      │
        src/data/process_data.py             sql/data_cleaning.sql
                             ▼                      ▼
        ┌────────────────────────────┐   ┌──────────────────────────────┐
        │ data/processed/ (8 tables) │   │ PostgreSQL  cleaned schema   │
        └─────────────┬──────────────┘   └───────────────┬──────────────┘
                      │                                  │ schema.sql
   src/data/feature_engineering.py      data_modeling_load.sql + fact_load.sql
                      ▼                                  ▼
        ┌────────────────────────────┐   ┌──────────────────────────────┐
        │ processed/features/ (4)    │   │ analytics schema: 6 dims,    │
        │ orders · items · customer  │   │ 4 facts, 33 indexes, FKs     │
        │ · monthly                  │   └───────────────┬──────────────┘
        └─────────────┬──────────────┘                   │
                      │                                  │
    src/analysis/kpi_calculations.py          sql/kpi_queries.sql
    src/analysis/business_metrics.py          sql/business_queries.sql
                      │                                  │
                      └──────────────┬───────────────────┘
                                     ▼
                  ╔══════════════════════════════════════╗
                  ║  sql_python_validation.py            ║
                  ║  32/32 KPIs reconciled — PASS        ║
                  ╚══════════════════┬═══════════════════╝
                                     ▼
        ┌────────────────────────────────────────────────────────┐
        │ Power BI semantic model → 28 DAX measures → 4 report   │
        │ pages + 3 tooltip pages;  Excel QA workbook;           │
        │ EDA notebook + 11 charts;  insight & recommendation    │
        │ reports                                                │
        └────────────────────────────────────────────────────────┘
```

---

## Repository structure

```text
Retail-Sales-Performance-Analytics/
├── data/
│   ├── raw/                     9 immutable Olist source CSVs
│   ├── cleaned/                 Phase 5 cleaning applied, same 9 tables
│   └── processed/               8 analytical datasets
│       └── features/            4 feature tables (order, item, customer, monthly)
├── src/
│   ├── data/                    ETL — load, preprocess, clean, process, engineer, validate
│   └── analysis/                Profiling, DQ, KPIs, business metrics, reconciliation, cross-validation
├── sql/                         17 PostgreSQL scripts: schema, profiling, cleaning, modeling,
│   └── validation/              business analysis, KPIs, cross-validation, exports
├── notebooks/eda.ipynb          101-cell exploratory analysis over the processed layer
├── excel/Retail_Analysis.xlsx   21-sheet independent QA + pivot workbook
├── powerbi/                     .pbix report (9 pages, 28 measures)
├── diagrams/                    ER diagram + star schema renders
├── docs/                        Charter, scope, requirements, KPI dictionary & spec,
│   ├── archive/                 feature dictionary, schema design
│   └── powerbi/                 Blueprint, data model, report/visual/filter/DAX plans
├── reports/                     Every phase's evidence: profiling, DQ, cleaning, modeling,
│                                EDA, features, KPI design, business metrics, dashboard QA,
│                                insights, recommendations, SQL analytical outputs
├── presentation/                Case-study deck
├── project_layout.md            Formal repository layout specification
└── LICENSE                      MIT
```

Every top-level directory carries its own `README.md` documenting purpose, contents, workflow position and reproducibility notes.

---

## Data layers

The pipeline enforces a strict one-way flow: **raw → cleaned → processed → features**. No stage writes backwards.

| Layer | Rows | Notes |
| --- | ---: | --- |
| `data/raw/` | 1,550,922 | Immutable. Never written to by any script. |
| `data/cleaned/` | 1,289,091 | 32 logged actions; 261,831 rows removed |
| `data/processed/` | 569,703 | 8 analysis-ready datasets with enforced grain |
| `data/processed/features/` | 4 tables | 99,441 orders · 112,650 items · 96,096 customers · 25 months |

**What the cleaning actually did.** The 261,831 removed rows are *entirely* exact full-row duplicates in the geolocation reference table (1,000,163 → 738,332) — a dataset with no source primary key where duplicate rows carry zero analytical information. Reviews were reduced 104,719 → 99,224 at the order grain. **No order, customer, item, product, seller or payment record was deleted.** Other actions were deliberately conservative:

| Issue | Action | Rows | Rationale |
| --- | --- | ---: | --- |
| Carrier date before purchase timestamp | `SET_INVALID_TIMESTAMP_TO_NULL` | 166 | Chronology violated; correct value cannot be inferred, so it is removed rather than fabricated |
| Delivery date before carrier handover | `SET_INVALID_TIMESTAMP_TO_NULL` | 23 | Same principle |
| Delivered order missing carrier timestamp | `RETAIN_NULL` | 167 | Transaction remains valid; nothing is invented |
| Delivered order missing delivery timestamp | `RETAIN_NULL` | 31 | Order is not deleted over one missing field |
| Customer ZIP with no geolocation match | `RETAIN` | 278 | Geolocation is enrichment; a miss does not invalidate a customer |
| Zero freight value | `RETAIN` | 383 | Zero freight is semantically valid, not an error |

Full audit trail: `reports/data_cleaning/cleaning_log.csv`.

---

## Analytical data model

`sql/schema.sql` builds a dimensional model in a dedicated `analytics` schema, leaving the raw schema untouched. Foreign keys are enforced at the analytics layer and 33 indexes support the reporting workload.

**Dimensions (6)**

| Table | Grain |
| --- | --- |
| `dim_date` | One row per calendar date — role-playing across purchase, approval, carrier, delivery and estimate dates |
| `dim_customer` | One row per `customer_id` |
| `dim_seller` | One row per `seller_id` |
| `dim_product` | One row per `product_id` (includes English category translation) |
| `dim_geography` | One row per ZIP-code prefix |
| `dim_order_status` | One row per distinct order status |

**Facts (4)**

| Table | Grain | Why it is separate |
| --- | --- | --- |
| `fact_orders` | One row per order | Order lifecycle spine |
| `fact_order_items` | `order_id` + `order_item_id` | Kept apart from payments to prevent many-to-many row multiplication |
| `fact_payments` | `order_id` + `payment_sequential` | Same reason — an order can have several payments |
| `fact_reviews` | One source review per order | Separate because `review_id` is **not** unique in the source |

Those three design decisions — separating items from payments, isolating reviews, and role-playing the date dimension — are the difference between a model that reconciles and one that silently double-counts.

Renders: `diagrams/er_diagram.png`, `diagrams/star_schema.png`. Design rationale: `docs/schema_design.md`.

---

## Feature engineering

`src/data/feature_engineering.py` produces four governed feature tables. Every column is documented in `docs/feature_dictionary.md` with its source, exact derivation formula and business purpose.

| Feature table | Grain | Covers |
| --- | --- | --- |
| `orders_features.csv` | `order_id` | Time and seasonality keys, `order_revenue`, `total_order_value`, `items_per_order`, processing/delivery/estimate durations, on-time and late flags, installment and multi-payment flags, order-level review score and satisfaction band |
| `order_items_features.csv` | `order_id` + `order_item_id` | `item_revenue`, freight, `freight_to_price_ratio`, product weight and volume, weight and dimension classification |
| `customer_features.csv` | `customer_unique_id` | Order count, repeat flag, lifetime revenue, average order value |
| `monthly_features.csv` | `year_month` | Monthly revenue and demand, 3-month rolling revenue and orders, MoM growth, cumulative revenue |

**Result: 48 validation checks, 0 failures** (`reports/feature_engineering/feature_engineering_summary.json`).

The flag design is worth calling out: `on_time_delivery_flag` and `late_delivery_flag` are `NaN` — not `0` — for orders that cannot be classified. Unclassifiable orders are therefore excluded from delivery-rate denominators instead of being silently counted as failures.

---

## KPI framework

`docs/kpi_dictionary.md` (1,011 lines) is the single source of truth. Each KPI carries a business definition, formula, numerator/denominator, unit, source dataset and columns, grain, filters, exclusions, aggregation, time basis, hierarchy tier, business importance, and both its SQL and DAX implementations.

**32 KPIs across 9 business areas**

| Tier | Count | KPIs |
| --- | ---: | --- |
| **Primary** | 9 | Total Revenue · Total Orders · Average Order Value · Monthly Revenue Growth · Total Customers · Repeat Customer Rate · On-Time Delivery Rate · Average Delivery Time · Average Review Score |
| **Supporting** | 20 | Total Order Value · Monthly Revenue · Average Items per Order · Customer Lifetime Revenue · Average Customer Order Value · Category Revenue (+ Share) · Product Revenue · Seller Revenue · Seller Order Count · Revenue by Customer State · Total Payment Value · Payment Method Share · Average Payment Installments · Average Processing Time · Late Delivery Rate · Average Delivery Difference · Total Freight Value · Low/High Satisfaction Rate |
| **Diagnostic** | 3 | Rolling 3-Month Revenue · Multi-Payment Order Rate · Freight-to-Price Ratio |

Business-area coverage: Sales (8), Delivery (5), Customer (4), Payment (4), Customer Experience (3), Product (3), Seller (2), Shipping (2), Regional (1).

**Governance rules that make the numbers reconcile**

- Revenue excludes freight; payment value is not revenue.
- Order-level KPIs use distinct `order_id`; multi-item orders are aggregated to order grain first.
- Customer identity is `customer_unique_id`; a repeat customer has `customer_order_count > 1`.
- Delivery KPIs require valid timestamps; on-time is `delivery_difference_days <= 0`.
- Missing values are excluded from the relevant KPI, never coerced to zero unless zero is semantically correct. Zero or missing denominators return NULL.

---

## Validation and quality evidence

Validation is not a closing formality here — it is a distinct, instrumented layer with its own scripts and its own report directory.

### SQL ↔ Python KPI parity

| Metric | Result |
| --- | --- |
| KPIs cross-validated | **32 / 32 PASS** |
| Largest absolute difference | `1.86e-09` (floating-point representation only) |
| Evidence | `reports/business_metrics/sql_python_validation.csv` |

### Cross-dataset reconciliation

All five structural identities hold exactly (`reports/business_metrics/reconciliation_checks.csv`):

```
Order revenue        = Item revenue          → PASS  (Δ 0.0)
Customer revenue     = Total revenue         → PASS  (Δ 0.0)
Category revenue     = Total revenue         → PASS  (Δ 1.9e-09)
Regional revenue     = Total revenue         → PASS  (Δ 0.0)
Product revenue      = Total revenue         → PASS  (Δ 1.9e-09)
```

If revenue sliced by category, region, product and customer each sum back to the same total, the joins are not multiplying rows. That is the check most dashboards never run.

### Data quality assessment — 202 tests

| Dimension | Tests | Passed | Failed | Critical | High | Medium | Low |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| Completeness | 70 | 57 | 13 | 0 | 0 | 13 | 0 |
| Conformity | 66 | 66 | 0 | 0 | 0 | 0 | 0 |
| Validity | 37 | 33 | 4 | 0 | 0 | 0 | 4 |
| Uniqueness | 16 | 15 | 1 | 0 | 0 | 1 | 0 |
| Referential Integrity | 9 | 6 | 3 | 0 | 0 | 1 | 2 |
| Consistency | 4 | 2 | 2 | 0 | 2 | 0 | 0 |
| **Total** | **202** | **179** | **23** | **0** | **2** | **15** | **6** |

Zero critical failures. The 23 failures are documented rather than silently patched, and each one's downstream treatment is stated in the cleaning log.

### Reporting layer integrity (PostgreSQL)

- Required tables: **9 / 9** present
- Duplicate primary-key groups: **0**
- Relationship orphan rows: **0**
- Required-key NULLs: **0**
- Row counts, date ranges and required revenue/payment/customer/product/seller fields: verified

### Independent layers

Beyond Python and SQL, results are checked against the **Excel workbook** (`Calculation_Checks` and `Validation_Summary` sheets validate order count, item count, sales total, payment total, freight total and duplicates) and against the **EDA notebook**, which independently reproduced the product-level and payment-level revenue with zero difference.

### Full evidence index

```
reports/data_quality/          202-test assessment, dimension + dataset summaries, logs
reports/data_cleaning/         cleaning log, summary, post-cleaning validation
reports/python_processing/     join, grain, traceability validation + reproducibility hashes
reports/feature_engineering/   48 feature validation checks
reports/data_modeling/         Analytical_Model_Validation_Report.pdf, PG reporting-layer log
reports/business_metrics/      KPI results, 32-KPI SQL↔Python parity, reconciliation checks
reports/insights/              insight evidence matrix, validation log, audit raw exports
reports/dashboard_validation/  dashboard QA report, validation baseline, PG validation logs
reports/sql/analytical_outputs/ 8 SQL-derived analytical extracts
```

`reports/python_processing/reproducibility_hashes.csv` records content hashes of processed outputs so a re-run can be proven byte-identical.

---

## Business insights

Full narrative with evidence and caveats: `reports/insights/business_insights.md`.

**1 · Category revenue is concentrated, product revenue is not.** 18 of 72 translated categories generate ~81.2% of category revenue (top 3 = 25.76%, top 10 = 62.36%). Yet the top 10 *products* account for only 3.32% of revenue and it takes ~8,536 products (26% of the catalog) to reach 80% cumulative revenue. A "hit categories, long-tail SKUs" structure.

| Rank | Category | Revenue | Share |
| ---: | --- | ---: | ---: |
| 1 | health_beauty | R$ 1,258,681.34 | 9.26% |
| 2 | watches_gifts | R$ 1,205,005.68 | 8.87% |
| 3 | bed_bath_table | R$ 1,036,988.68 | 7.63% |
| 4 | sports_leisure | R$ 988,048.97 | 7.27% |
| 5 | computers_accessories | R$ 911,954.32 | 6.71% |

**2 · Revenue is geographically concentrated.** São Paulo alone contributes R$5,202,955 (38.28%); SP + RJ + MG together reach ~63.37%.

**3 · The customer base is overwhelmingly one-time buyers.** 2,997 of 96,096 customers repeat (3.12%). Repeat customers also show a *lower* AOV (R$123.93) than one-time customers (R$138.67) — an observed difference, not evidence that repeat purchasing depresses order value.

**4 · Delivery is strong; the late tail tracks with worse ratings.** 89.1% of classified deliveries arrive early, 7.9% late, ~3% unclassified. Delivery timing and review score move together. Reported explicitly as an **association, not causation**.

**5 · Sales grew into a high plateau.** Peak month November 2017 at R$1,010,271.37, followed by April 2018 (R$996,647.75) and May 2018 (R$996,517.68); validated YoY growth ~20.0% (PostgreSQL: 19.99%). Near-zero Sep/Oct 2018 values are a **data-extraction cutoff, not a demand collapse**, and are excluded from trend conclusions.

**6 · Payment value is concentrated in one channel.** Credit card R$12,542,084 (78.34%), boleto 17.92%, voucher 2.37%, debit 1.36%.

**7 · Seller revenue is comparatively diversified.** Top 5 sellers = 7.61%, top 10 = 13.15%, top 20 = 21.09% of revenue.

**8 · Satisfaction is high but polarized.** Average 4.09/5, with 57.78% five-star against **11.51% one-star** — one-star reviews outnumber two- and three-star combined. The average alone hides a material dissatisfied segment.

---

## Executive recommendations

`reports/recommendations/executive_recommendations.md` converts the validated insights into five prioritized recommendations, each with its supporting insight, business problem, recommended action, measurement plan, assumptions and risk profile.

| # | Recommendation | Priority | Anchored in |
| ---: | --- | --- | --- |
| 1 | Improve repeat-customer participation | **HIGH** | 3.12% repeat rate across 96,096 customers |
| 2 | Investigate and improve delivery performance | **HIGH** | 7.9% late deliveries; association with lower review scores |
| 3 | Address one-star customer experiences | **HIGH** | 11.51% of reviews are one-star |
| 4 | Manage category revenue concentration | MEDIUM | 18 of 72 categories ≈ 81.2% of revenue |
| 5 | Evaluate regional expansion opportunities | MEDIUM | Top 3 states ≈ 63.37% of revenue |

Each recommendation states explicitly what the data **cannot** tell you. Recommendation 1 does not claim to know *why* customers fail to return; Recommendation 2 does not assert that delay *causes* poor ratings. **No revenue, retention or rating uplift is forecast anywhere**, because the dataset contains no cost, margin or experimental data that would justify one.

---

## Power BI deliverable

`powerbi/Retail_Sales_Performance_Analytics.pbix` — a semantic model over the PostgreSQL `analytics` schema with a custom theme (`RetailAnalyticsModern`).

**Report pages**

| Page | Purpose |
| --- | --- |
| Executive Overview | Headline KPI cards, monthly sales trend, regional sales by state |
| Product & Category Analysis | Category mix and share, top-10 products, product detail |
| Regional & Seller Performance | Seller sales by geography, regional share, bottom-10 sellers |
| Customer Analysis | Repeat vs non-repeat segmentation, orders per customer |
| Tooltip pages ×3 | Product, Seller and Customer drill-through context |
| DAX Validation ×2 | In-report measure verification surfaces retained as QA evidence |

**28 DAX measures**, centralizing KPI logic rather than duplicating upstream transformations:

```
Total Sales · Total Orders · Total Items · Total Customers · AOV
YTD Sales · YoY Sales Growth % · Item Price Total · Payment Value Total
Category Sales (+ %) · Product Sales (+ %) · Product Item Volume
Regional Sales (+ %) · Seller Sales · Seller Orders
Repeat Customers · Non-Repeat Customers · Repeat Customer % · Customer Type Count
Customer Sales · Customer Orders · Orders per Customer
Top Category · Top Product · Top Region
```

**Model validation** — dimension-to-fact relationships PASS, cardinality 1:*, single-direction filters, no many-to-many, no fact-to-fact relationships, no ambiguous filter paths. Multiple date relationships to the order fact are expected and intentional (role-playing dates).

**QA outcome — reported honestly.** `reports/dashboard_validation/dashboard_qa_report.md` marks the phase **IN PROGRESS**:

| Issue found | Resolution | Status |
| --- | --- | --- |
| Unintended slicer cut Total Sales from R$13.59M to ~R$1.09M | Slicer cleared; confirmed the measure itself was correct | Resolved |
| YoY Sales Growth returned an incorrect value | DAX corrected and retested to ~20.0% vs PostgreSQL 19.99% | Resolved |
| Category Sales visual bound to product level, not category | Rebind axis to `product_category_name_english` | Retest required |
| Monthly Sales Trend sorted non-chronologically | Sort `month_year` by a proper date sort column | Retest required |
| Cumulative Product Sales % evaluates across ~32,951 products | Restrict scope or redesign the visual | Retest required |

Design documentation lives in `docs/powerbi/` — blueprint, data model, report page plan, visual plan, filter interaction plan and DAX plan (~6,400 lines total).

---

## Getting started

### Prerequisites

- Python 3.10+
- PostgreSQL 13+
- Power BI Desktop (to open the `.pbix`)
- Microsoft Excel (to open the QA workbook)

### Setup

```bash
git clone https://github.com/24Bhuvan/Retail-Sales-Performance-Analytics.git
cd Retail-Sales-Performance-Analytics

python -m venv .venv
source .venv/bin/activate          # Windows: .venv\Scripts\activate

pip install pandas numpy matplotlib seaborn openpyxl psycopg2-binary jupyter
```

### Source data

`data/raw/`, `data/cleaned/` and `data/processed/` are excluded from version control by `.gitignore`. Download the nine Olist CSVs and place them in `data/raw/` using their original filenames:

```
olist_customers_dataset.csv          olist_order_reviews_dataset.csv
olist_geolocation_dataset.csv        olist_orders_dataset.csv
olist_order_items_dataset.csv        olist_products_dataset.csv
olist_order_payments_dataset.csv     olist_sellers_dataset.csv
product_category_name_translation.csv
```

### Database

```bash
createdb retail_sales_analytics
```

Then load the raw Olist tables into the raw schema before running any analytics script. `src/analysis/cross_validate_postgres.py` connects to `localhost:5432/retail_sales_analytics` — update the connection constants at the top of that module for your environment.

---

## Reproducing the pipeline

Scripts resolve paths relative to the repository root and must run in order.

**Python track**

```bash
python src/analysis/data_quality_assessment.py      # 202 quality tests → reports/data_quality/
python src/analysis/generate_dataset_profile.py     # profiling → reports/profiling/
python src/data/clean_data.py                       # → data/cleaned/ + cleaning log
python src/analysis/post_cleaning_validation.py     # verify the cleaned layer
python src/data/process_data.py                     # → data/processed/ + reproducibility hashes
python src/data/validate_input.py                   # grain, join and key validation
python src/data/feature_engineering.py              # → data/processed/features/ (48 checks)
python src/analysis/kpi_calculations.py             # → reports/business_metrics/kpi_results.csv
python src/analysis/business_metrics.py             # detailed metric tables by dimension
python src/analysis/create_final_kpi_results.py     # → final_kpi_results.csv (with metadata)
python src/analysis/reconciliation_checks.py        # 5 cross-dataset revenue identities
python src/analysis/cross_validate_postgres.py      # Python vs PostgreSQL
python src/analysis/sql_python_validation.py        # 32-KPI parity report
```

**SQL track** (`psql -d retail_sales_analytics -f <script>`)

```
data_profiling.sql → data_validation.sql → data_cleaning.sql → schema.sql
  → data_modeling_load.sql → data_modeling_fact_load.sql → data_modeling_validation.sql
  → business_queries.sql / analytical_queries.sql
  → kpi_queries.sql / business_metrics_queries.sql
  → feature_engineering_validation.sql → python_cross_validation.sql → sql_validation.sql
  → validation/postgresql_reporting_layer_validation.sql
  → validation/postgresql_additional_validation.sql
  → export_analytical_outputs.sql
```

**EDA**

```bash
jupyter notebook notebooks/eda.ipynb
```

The notebook resolves the project root by locating `data/processed/`, asserts all eight processed datasets exist before proceeding, and writes 11 charts to `reports/eda/charts/`.

---

## Tech stack

| Layer | Technology | Role |
| --- | --- | --- |
| Ingestion & transformation | Python 3.10, pandas, NumPy | Cleaning, processing, feature engineering |
| Analytical database | PostgreSQL | `raw` / `cleaned` / `analytics` schemas, star schema, KPI SQL |
| Connectivity | psycopg2 | Python ↔ PostgreSQL cross-validation |
| Exploratory analysis | Jupyter, matplotlib, seaborn | EDA notebook and chart generation |
| Spreadsheet QA | Excel, openpyxl | 21-sheet independent validation workbook |
| Business intelligence | Power BI Desktop, DAX | Semantic model, 28 measures, 7 user-facing pages |
| Version control | Git / GitHub | 192 commits, phase-tagged (`phase-22-baseline`) |
| Documentation | Markdown | ~10,300 lines across `docs/` |

---

## Known gaps and open items

Stated plainly rather than implied complete:

| Item | State |
| --- | --- |
| `powerbi/dax_measures.md` | Empty — measure definitions currently live only inside the `.pbix`. The 28 measure names are recoverable from the report definition; formulas are not documented in the repo. |
| `docs/references.md` | Empty placeholder |
| `presentation/Retail_Sales_Case_Study.pptx` | 0 bytes — deck not yet produced |
| `reports/business_metrics/business_metrics_summary.md` | Empty; the detailed per-dimension CSVs in the same directory are populated |
| `reports/business_metrics/sql_kpi_results.csv` | Empty; SQL-side KPI values are captured in `sql_python_validation.csv` |
| `reports/feature_engineering/feature_cross_validation.csv` | Empty; `feature_validation.csv` is populated |
| Dashboard QA | **IN PROGRESS** — 3 retest items open (see Power BI section) |
| `Payment Method Share` KPI | Computes as a distribution rather than a scalar; carried as null in the single-value KPI export |
| Absolute paths in logs | Several report artifacts embed the original Windows author paths; cosmetic only, no effect on reproduction |

---

## Limitations and analytical integrity

These constraints are inherent to the dataset and are respected throughout every report:

1. **Partial periods at both ends.** 2016 begins in September; 2018 truncates after 17 October. Near-zero Sep/Oct 2018 figures are an extraction cutoff, not a demand collapse, and are excluded from trend conclusions. Year-level comparisons must account for incomplete coverage.
2. **Orders without items.** 775 of 99,441 orders carry no order-item record and are excluded from item-level revenue, product and category analysis. This is the documented reason order-level AOV (R$136.68, 99,441 orders) differs from item-backed AOV (R$137.75, 98,666 orders) — both are correct at their stated grain.
3. **Population/grain differences are disclosed, not smoothed.** The full-order customer population (96,096 / 2,997 repeat) and the item-backed population (95,420 / 2,913) differ. The dashboard baseline uses the full-order population.
4. **Category translation gaps.** 1,627 order items (1.44%) lack a translated category and are grouped as Unknown/Untranslated.
5. **Payment coverage.** One order lacks a payment record.
6. **Freight does not exactly reconcile the payment gap.** Freight (~R$2.25M) is close to but does not precisely explain the difference between payment value (R$16.01M) and item revenue (R$13.59M). Reported as requiring further investigation rather than claimed as a clean reconciliation.
7. **One SQL regional output failed to reconcile** with the validated baseline and was therefore excluded from the final regional evidence chain rather than used.
8. **Monthly order counts differ between outputs** due to population/grain definitions, so trend conclusions emphasize reconciled revenue rather than unreconciled order counts.
9. **No profitability data.** No cost, margin or COGS fields exist. Every figure is gross revenue. No profitability claim is made anywhere.
10. **No inventory data.** Stockouts, availability and turnover cannot be assessed.
11. **No causal inference.** All relationships — particularly delivery versus review score — are associations. No experimental or counterfactual data exists.
12. **Currency convention.** Reporting artifacts use R$; the underlying dataset documentation does not formally establish a currency, so the EDA layer deliberately labels values as monetary units.
13. **Outliers are observations, not errors.** The largest order (R$13,440.00, 8 items) and highest single item price (R$6,735.00) are both legitimate delivered transactions and were retained.

**Out of scope by design:** demand forecasting, CLV prediction, churn modeling, machine learning, marketing attribution, inventory optimization, real-time streaming, cloud deployment and ERP/CRM integration.

---

## Project governance

The engagement was executed across 22 tracked CRISP-DM phases, each producing versioned evidence under `reports/`:

```
1  Business Understanding      9  Python Data Processing      18  Dashboard QA & Validation
2  Stakeholder Analysis       10  Exploratory Data Analysis    19  Business Insights
3  Data Understanding         12  Feature Engineering          20  Executive Recommendations
4  Data Quality Assessment    13  KPI Design                   21  Repository Audit
5  Data Cleaning              14  Business Metrics             22  Project Finalization
6  Data Modeling              15-17  Dashboard Development
7  Excel Analysis
8  SQL Development
```

Repository: **192 commits**, tagged `phase-22-baseline`. Version-control policy is formalized in `project_layout.md` — code, SQL, notebooks, documentation, reports, validation outputs and binary deliverables are tracked; datasets, environments, secrets, logs and machine-specific artifacts are not.

**Key documents**

| Document | Contents |
| --- | --- |
| `docs/project_charter.md` | Objectives, deliverables, stakeholders, risks, success criteria, governance |
| `docs/project_scope.md` | In-scope / out-of-scope boundaries, dataset and technology scope |
| `docs/business_requirements.md` | 10 functional + 6 non-functional requirements, business questions |
| `docs/kpi_dictionary.md` | Definitive KPI definitions, formulas, SQL and DAX (1,011 lines) |
| `docs/kpi_specification.md` | KPI measurement logic and design detail (730 lines) |
| `docs/feature_dictionary.md` | Every engineered feature with source, formula and purpose |
| `docs/schema_design.md` | Dimensional model rationale (876 lines) |
| `docs/powerbi/` | Blueprint, data model, report/visual/filter/DAX plans |

---

## License

This project is proprietary and all rights are reserved by Bhuvan Ummidisetti.

The source code may be viewed for personal, educational, evaluation, and
recruitment purposes only. Copying, modifying, redistributing, sublicensing,
selling, or commercially exploiting the source code is not permitted without
prior written permission.

See `LICENSE` for the full terms.

The Olist Brazilian E-commerce Public Dataset is provided by Olist under its
own terms and is not redistributed in this repository.

---

**Author:** Bhuvan Ummidisetti · [github.com/24Bhuvan](https://github.com/24Bhuvan)

*Built to demonstrate that an analytics deliverable is only as credible as the validation chain behind it.*
