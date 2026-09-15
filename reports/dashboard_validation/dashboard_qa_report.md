# Dashboard QA Report

## 1. Validation Scope

Phase 18 validation covered the completed Power BI dashboard pages:

- Executive Sales Overview
- Product & Category Analysis
- Regional & Seller Performance
- Customer Analysis

Validation used PostgreSQL reporting-layer results, Phase 14 Python validation outputs, Power BI visuals and DAX measures, and Power BI model inspection.

## 2. Validation Baseline

| Metric | Baseline |
|---|---:|
| Total Revenue / Sales | 13,591,643.70 |
| Total Orders | 99,441 |
| Total Items | 112,650 |
| AOV | 136.680480888 |
| Total Customers | 96,096 |
| Repeat Customers | 2,997 |
| Repeat Customer Rate | 3.118756% |
| Total Payment Value | 16,008,872.12 |
| Categories | 74 |
| Products | 32,951 |
| States | 23 |
| Sellers | 3,095 |

## 3. KPI Validation

Core dashboard KPIs were checked against the established PostgreSQL/Python baseline.

- Total Sales: PASS
- Total Orders: PASS
- Total Items: PASS
- AOV: PASS
- YTD Sales: displayed approximately R$7.39M; exact reconciliation retained as pending in the validation log.
- YoY Sales Growth: the original result was incorrect and was identified during validation. The measure was corrected and retested to approximately 20.0%, consistent with the PostgreSQL 2018 YoY result of 19.99%.

## 4. DAX Validation

Implemented DAX measures were reviewed for aggregation, filter context, denominators, percentage calculations, and date logic.

Validated examples include:

- Total Sales uses `SUM(fact_order_items[price])`.
- Total Orders uses `DISTINCTCOUNT(order_id)`.
- Total Customers uses `DISTINCTCOUNT(customer_unique_id)`.
- Repeat Customers counts customers with more than one distinct order.
- AOV uses Total Sales divided by Total Orders.
- Product Sales % was validated at approximately 0.47% for the top product.
- YoY logic was identified as requiring correction during QA.

A performance limitation was identified for the cumulative product sales calculation because the implemented measure evaluates product sales across a large product set.

## 5. PostgreSQL Validation

The reporting layer passed the structural and integrity checks:

- Required tables: 9/9 present.
- Primary keys: present; duplicate PK groups = 0.
- Foreign keys: present; relationship orphan rows = 0.
- Required-key NULLs = 0.
- Required row counts verified.
- Date ranges verified.
- Required date, revenue, payment, customer, product and seller fields verified.

Reporting database: `retail_sales_analytics`.

## 6. Relationship Validation

The Power BI model was inspected.

- Dimension-to-fact relationships: PASS.
- Cardinality: expected 1:*.
- Filter direction: single.
- No unexpected many-to-many relationships identified.
- No direct fact-to-fact relationships identified.
- No ambiguous filter paths identified.
- Multiple date relationships from the date dimension to the order fact were expected because the fact contains multiple order-date roles.

No relationship changes were required.

## 7. Date & Time Logic

The model uses `dim_date[full_date]` for date intelligence.

YTD and YoY calculations were reviewed. The original YoY result exposed a filter-context/date-range issue and was corrected during validation.

## 8. Filters & Interactions

An unintended slicer selection was identified during KPI validation. It reduced Total Sales from the expected R$13.59M to approximately R$1.09M.

The slicer was cleared and the dashboard returned to the expected total.

This confirms that the underlying Total Sales measure was correct and the discrepancy was caused by filter context.

## 9. Top/Bottom N

Validated rankings include:

- Top Category: `health_beauty`
- Top Product: `bb50f2e236e5eea0100680137654686c`
- Top Region: `SP`

The PostgreSQL Top-10 product cumulative benchmark was also generated for QA.

## 10. Tooltip Validation

Supplied dashboard visuals were inspected for tooltip presentation and visible calculation errors. No blocking tooltip error was identified.

## 11. Visual Accuracy

The following visual issues were identified during validation:

### Product & Category Analysis

The Category Sales visual was found to be using the Product Hierarchy/product level rather than only the category field.

Required correction:

`product_category_name_english` should be used as the category axis.

### Executive Sales Overview

The Monthly Sales Trend was found to be incorrectly sorted, displaying month-year values out of chronological order.

Required correction:

`month_year` must be sorted chronologically using an appropriate date/month sort column.

## 12. Performance

The Cumulative Product Sales % visual was found to be computationally expensive because the DAX calculation evaluates product sales across approximately 32,951 products.

The visual remained slow during QA.

This was recorded as a performance issue rather than masking the problem by marking it as a pass.

## 13. Usability

General dashboard readability, KPI presentation, labels, units and navigation were inspected.

The full product detail table contains approximately 32,951 products, making unrestricted scrolling impractical. Top-N filtering or focused navigation is more appropriate for analysis.

## 14. Issues & Resolutions

| Issue | Resolution / Required Action | Status |
|---|---|---|
| Unintended slicer reduced KPI values | Cleared slicer selection | Resolved |
| Incorrect YoY result | Corrected YoY DAX and retested | Resolved |
| Category Sales at product level | Replace Product Hierarchy with category field | Retest required |
| Monthly Sales Trend sorting | Sort month_year chronologically | Retest required |
| Cumulative Product Sales performance | Restrict/focus calculation or redesign expensive visual | Retest required |

## 15. Final QA Status

**PHASE 18 QA STATUS: IN PROGRESS**

Core KPI, PostgreSQL, customer, regional/seller, product ranking and relationship validations have been substantially completed.

The dashboard should not be marked fully final until the remaining visual corrections and cumulative-product performance issue are retested and the final PBIX review is completed.

## 16. Validation Artifacts

- `reports/dashboard_validation/validation_baseline.csv`
- `reports/dashboard_validation/step2_postgresql_validation.log`
- `reports/dashboard_validation/step2_additional_validation.log`
- `reports/dashboard_validation/dashboard_validation_log.csv`
