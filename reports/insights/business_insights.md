# Business Insights

## 1. Executive Summary

The Retail Sales Performance Analytics analysis shows a marketplace with substantial sales volume, strong concentration at the category and regional levels, low repeat-customer participation, broad diversification across individual products and sellers, heavy dependence on credit-card payments, and generally positive customer reviews with a meaningful dissatisfied segment.

The validated headline sales baseline is **R$13,591,643.70 across 99,441 orders and 112,650 items**, with an **AOV of R$136.68**. The dashboard baseline also records **96,096 customers**, **2,997 repeat customers (3.12%)**, **3,095 sellers**, **32,951 products**, **74 categories**, and **R$16,008,872.12 in total payment value**.

The strongest business findings are:

1. Revenue is concentrated across a relatively small number of categories: **18 of 72 valid translated categories generate approximately 81.2% of category revenue**.
2. Revenue is geographically concentrated: **São Paulo contributes R$5.20M (38.28%)**, while the top three states contribute approximately **63.37%**.
3. Repeat-customer participation is low: **2,997 of 96,096 customers (3.12%)** are repeat customers.
4. Delivery performance is generally strong among classified deliveries, but late delivery is associated with weaker customer ratings.
5. Sales reached a validated monthly peak of **R$1,010,271.37 in November 2017**, and the analysis shows strong growth into a higher sales plateau through 2018.
6. **Credit cards account for 78.34% of payment value**, making the payment channel highly concentrated.
7. Individual product revenue is highly distributed: the **top 10 products account for 3.32%** and the **top 20 for 5.38%** of revenue.
8. Customer satisfaction is high overall (**4.09/5 average**), but **11.51% of reviews are one-star**, indicating a material dissatisfied segment.

These findings describe the observed business pattern. They do not establish causality or profitability because the dataset does not contain complete cost, margin, inventory, or causal-experiment information.

---

## 2. Overall Sales Performance

### Validated baseline

| Metric | Value |
|---|---:|
| Total Sales / Item Revenue | R$13,591,643.70 |
| Total Orders | 99,441 |
| Total Items | 112,650 |
| Average Order Value | R$136.68 |
| Total Customers | 96,096 |
| Repeat Customers | 2,997 |
| Repeat Customer Rate | 3.12% |
| Total Payment Value | R$16,008,872.12 |
| Sellers | 3,095 |
| Products | 32,951 |
| Categories | 74 |
| States | 23 |

The total-sales baseline is defined from the order-item price measure used in the validated dashboard and reporting layer. The dashboard QA confirmed the core KPI values against the established PostgreSQL/Python baseline.

The item-sales total and payment total are different measures and should not be treated as interchangeable. Payment value is approximately R$2.42M higher than item sales. The analysis indicates that freight explains much of the difference, but the reconciliation is not exact.

---

## 3. Sales Trends

Sales increased substantially from the early period and reached a higher-volume level during 2017–2018.

The validated monthly revenue peaks include:

| Month | Sales |
|---|---:|
| November 2017 | R$1,010,271.37 |
| April 2018 | R$996,647.75 |
| May 2018 | R$996,517.68 |

The dashboard validation also confirmed approximately **20.0% YoY sales growth**, with the PostgreSQL comparison reporting **19.99%** for the validated comparison.

The late-2018 near-zero monthly values must **not** be interpreted as a genuine business collapse. The source period is incomplete and contains a dataset/extraction cutoff. Therefore, incomplete September/October 2018 values are excluded from business conclusions about a sales decline.

---

## 4. Category Performance

Category-level revenue is materially concentrated.

| Rank | Category | Sales | Revenue Share |
|---|---|---:|---:|
| 1 | health_beauty | R$1,258,681.34 | 9.26% |
| 2 | watches_gifts | R$1,205,005.68 | 8.87% |
| 3 | bed_bath_table | R$1,036,988.68 | 7.63% |
| 4 | sports_leisure | R$988,048.97 | 7.27% |
| 5 | computers_accessories | R$911,954.32 | 6.71% |

The top three categories account for approximately **25.76%** of category revenue, the top five approximately **39.74%**, and the top ten approximately **62.36%**.

Approximately **18 of 72 valid translated categories account for 81.2% of category revenue**.

This indicates that category performance is concentrated even though the individual-product level is much more diversified.

---

## 5. Product Performance

The product catalog contains **32,951 products**, but revenue is not dependent on a small group of individual products.

- Top 10 products: **3.32% of total revenue**
- Top 20 products: **5.38% of total revenue**
- Top product: **R$63,885.00**
- Approximately **8,536 products (26% of the catalog)** are needed to reach approximately 80% cumulative revenue.

The top-product SQL cross-validation matched exactly for the top 20 products.

The business pattern is therefore different at the category and SKU levels: **categories are concentrated, while individual products are highly distributed**.

---

## 6. Regional Performance

Regional revenue is concentrated in a small number of states.

| State | Sales | Revenue Share |
|---|---:|---:|
| São Paulo (SP) | R$5,202,955.05 | 38.28% |
| Rio de Janeiro (RJ) | R$1,824,092.67 | 13.42% |
| Minas Gerais (MG) | R$1,585,308.03 | 11.66% |

The top three states contribute approximately **63.37% of total sales**.

São Paulo is the largest regional market in the validated reporting baseline. The analysis also shows substantial seller concentration in São Paulo, but the observed regional concentration should not be attributed to a specific cause such as marketing effectiveness, logistics proximity, or demand without additional causal analysis.

---

## 7. Customer Behavior

Customer behavior shows a very large one-time-customer population and a relatively small repeat segment.

The validated full-order customer baseline is:

- **96,096 unique customers**
- **2,997 repeat customers**
- **3.12% repeat-customer rate**

For the item-backed population used in the customer-segment analysis:

| Segment | Customers | Orders | Revenue | AOV |
|---|---:|---:|---:|---:|
| One-time | 92,507 | 92,507 | R$12,828,351.84 | R$138.67 |
| Repeat | 2,913 | 6,159 | R$763,291.86 | R$123.93 |

Repeat customers represent approximately **3.05% of the item-backed customer population** and approximately **5.6% of item-backed revenue**.

The segment analysis also shows that repeat customers have a lower AOV (**R$123.93**) than one-time customers (**R$138.67**). This is an observed difference, not evidence that repeat purchasing causes lower order value.

The difference between the 96,096/2,997 full-order population and the 95,420/2,913 item-backed population is a documented grain/population difference. The validated dashboard KPI uses the full-order population.

---

## 8. Seller Performance

There are **3,095 sellers** in the dataset.

Seller revenue is distributed more broadly than category revenue:

- Top seller: **R$229,472.63**
- Top 5 sellers: **7.61% of revenue**
- Top 10 sellers: **13.15% of revenue**
- Top 20 sellers: **21.09% of revenue**

This indicates that marketplace revenue is not dependent on a very small number of sellers.

The seller-level findings are descriptive. They do not establish why particular sellers perform better or worse.

---

## 9. Payment / Operational Findings

### Payment concentration

Credit cards dominate payment value.

| Payment Type | Payment Value | Share |
|---|---:|---:|
| credit_card | R$12,542,084.19 | 78.34% |
| boleto | R$2,869,361.27 | 17.92% |
| voucher | R$379,436.87 | 2.37% |
| debit_card | R$217,989.79 | 1.36% |
| not_defined | R$0.00 | 0.00% |

Credit-card payment value is therefore more than four times the value of boleto and represents the dominant payment channel.

Single-installment payments are the most common installment plan, while payment records also contain plans extending up to 24 installments.

Payment-method revenue was cross-validated against SQL with exact matches.

### Delivery performance

For the delivery analysis population:

- Average total delivery duration: **12.56 days**
- Average handoff-to-customer duration: **9.34 days**
- **89.1%** of classified deliveries arrived early
- **7.9%** arrived late
- Approximately **3%** were unclassified for the early/late comparison

The late-delivery group has materially weaker review outcomes than the early-delivery group. The analysis supports an **association** between delivery performance and customer satisfaction; it does not prove that delivery delay is the sole or direct cause of lower ratings.

### Reviews

Average review score is **4.09/5**.

| Score | Reviews | Share |
|---|---:|---:|
| 5 | 57,328 | 57.78% |
| 4 | 19,142 | 19.29% |
| 3 | 8,179 | 8.24% |
| 2 | 3,151 | 3.18% |
| 1 | 11,424 | 11.51% |

The distribution is polarized: five-star reviews dominate, but one-star reviews are substantially more common than two- or three-star reviews.

### Freight and payment reconciliation

Total freight is approximately **R$2.25M**, while total payment value is approximately **R$16.01M** and item sales are approximately **R$13.59M**.

The freight amount is close to the difference between payment value and item sales, but the reconciliation is **not exact**. Therefore, the analysis identifies freight as a material component requiring further investigation rather than claiming an exact accounting reconciliation.

---

## 10. Key Business Insights

### Insight 1 — Category revenue is highly concentrated

- **Finding:** A relatively small number of categories generate most marketplace revenue.
- **Evidence:** The top 3 categories contribute approximately 25.76%, the top 5 39.74%, the top 10 62.36%, and 18 of 72 valid translated categories approximately 81.2%.
- **Business Meaning:** Category-level performance is substantially concentrated.
- **Implication:** Category mix is a major structural characteristic of marketplace revenue and should be considered when interpreting overall sales performance.

### Insight 2 — Regional revenue is concentrated

- **Finding:** A small number of states account for a large share of sales.
- **Evidence:** São Paulo contributes R$5.20M (38.28%); São Paulo, Rio de Janeiro, and Minas Gerais together contribute approximately 63.37%.
- **Business Meaning:** Sales are geographically imbalanced toward a small group of states.
- **Implication:** Regional performance is an important dimension for understanding marketplace revenue distribution.

### Insight 3 — Repeat-customer participation is low

- **Finding:** Only a small proportion of customers make repeat purchases.
- **Evidence:** 2,997 of 96,096 customers are repeat customers, producing a validated repeat rate of 3.12%.
- **Business Meaning:** The observed customer base is dominated by one-time purchasers.
- **Implication:** Customer retention is a significant characteristic of the current customer mix and deserves separate analysis from acquisition-driven sales.

### Insight 4 — Delivery performance is generally strong, but weaker delivery outcomes align with lower reviews

- **Finding:** Most classified deliveries arrive before the estimated date, while late deliveries form a smaller but meaningful segment associated with weaker ratings.
- **Evidence:** 89.1% of classified deliveries were early and 7.9% late. Review-score analysis shows delivery timing moving closer to or beyond the estimated date as review scores decline.
- **Business Meaning:** Delivery experience and customer satisfaction move together in the observed data.
- **Implication:** Delivery performance is an important operational dimension when evaluating customer experience.
- **Caution:** This is an association, not a causal finding.

### Insight 5 — Sales grew into a higher-volume period, with November 2017 as the validated monthly peak

- **Finding:** The marketplace experienced strong growth before reaching a higher sales level through the later observed period.
- **Evidence:** November 2017 recorded R$1,010,271.37, followed by April 2018 at R$996,647.75 and May 2018 at R$996,517.68. Validated YoY growth is approximately 20.0%.
- **Business Meaning:** The business moved from early-period growth into a substantially higher sales level.
- **Implication:** Monthly and year-over-year trends provide important context for evaluating category, regional, and customer performance.
- **Caution:** Partial 2016 and late-2018 periods should not be used as complete calendar-year comparisons.

### Insight 6 — Payment value is highly concentrated in credit cards

- **Finding:** Credit cards are the dominant payment channel.
- **Evidence:** Credit cards represent R$12,542,084.19, or 78.34% of total payment value; boleto represents 17.92%.
- **Business Meaning:** The payment mix is heavily dependent on one channel.
- **Implication:** Payment-channel performance is commercially significant to the marketplace's transaction flow.

### Insight 7 — Individual product revenue is highly diversified

- **Finding:** No small group of individual products dominates total revenue.
- **Evidence:** The top 10 products account for 3.32% and the top 20 for 5.38% of revenue. Approximately 8,536 products are needed to reach 80% cumulative revenue.
- **Business Meaning:** Product-level revenue has a long tail even though category-level revenue is concentrated.
- **Implication:** Marketplace sales are structurally diversified across individual SKUs.

### Insight 8 — Customer satisfaction is high overall, but dissatisfaction is materially present

- **Finding:** The average review score is high, but the review distribution contains a substantial one-star segment.
- **Evidence:** Average score is 4.09/5; 57.78% of reviews are five-star while 11.51% are one-star.
- **Business Meaning:** Overall satisfaction looks positive, but the average masks a meaningful group of severe negative experiences.
- **Implication:** Overall average rating should not be used alone to evaluate customer experience quality.

---

## 11. Data Limitations

1. **Partial time periods:** 2016 begins partway through the year and late 2018 is incomplete. Near-zero September/October 2018 values are treated as a dataset/extraction cutoff rather than a business collapse.
2. **Orders without item records:** 775 of 99,441 orders do not have order-item records. They are excluded from item-level sales, product, category, and related item-backed revenue calculations.
3. **Payment coverage:** one order lacks a payment record.
4. **Category translation:** 1,627 order items lack a translated category and are grouped as Unknown/Untranslated in the relevant analysis.
5. **Customer population differences:** full-order and item-backed populations produce slightly different unique-customer and repeat-customer counts. The dashboard baseline uses the full-order population.
6. **Regional SQL definition mismatch:** one SQL regional output did not reconcile with the validated regional baseline and therefore is not used as evidence for the final regional finding. The final regional values come from the reconciled reporting baseline/Excel/EDA analysis.
7. **Monthly order-count discrepancy:** monthly revenue reconciles, but some monthly order counts differ between analysis outputs because of population/grain definitions. The final trend analysis therefore emphasizes reconciled revenue values rather than unreconciled monthly order counts.
8. **No profitability data:** the dataset does not provide sufficient cost, margin, or profit information to make profitability claims.
9. **No inventory data:** inventory availability, stockouts, and inventory turnover cannot be concluded from this dataset.
10. **No causal inference:** observed relationships, particularly delivery versus review score, are associations. The analysis does not establish causality.
11. **Review limitations:** review scores identify customer satisfaction levels but do not by themselves identify the root cause of dissatisfaction.
12. **Freight reconciliation:** freight is close to, but does not exactly explain, the gap between item sales and payment value.
13. **Currency definition:** project outputs use R$ in the reporting artifacts, but the underlying dataset documentation does not formally establish a currency definition independent of the project processing/reporting convention.
14. **Extreme values:** unusually large order values and long delivery durations were treated as observations requiring interpretation, not automatically as errors.

---

## 12. Evidence Sources

The final insights were derived from and cross-checked against the project's completed analytical layers:

### Validated baseline and dashboard QA
- `reports/dashboard_validation/dashboard_qa_report.md`
- `reports/dashboard_validation/validation_baseline.csv`
- `reports/dashboard_validation/dashboard_validation_log.csv`

The dashboard QA established the frozen KPI baseline and validated core measures, model relationships, Top-N rankings, date logic, filters, and dashboard visuals. The YoY measure and other dashboard issues identified during QA were corrected/retested as part of the completed validation process.

### Business metrics
- `reports/business_metrics/business_metrics_summary.md`
- `reports/business_metrics/final_kpi_results.csv`
- `reports/business_metrics/category_metrics.csv`
- `reports/business_metrics/customer_metrics.csv`
- `reports/business_metrics/delivery_metrics.csv`
- `reports/business_metrics/monthly_metrics.csv`
- `reports/business_metrics/payment_metrics.csv`
- `reports/business_metrics/product_metrics.csv`
- `reports/business_metrics/regional_metrics.csv`
- `reports/business_metrics/review_metrics.csv`
- `reports/business_metrics/seller_metrics.csv`
- `reports/business_metrics/reconciliation_checks.csv`

### SQL analytical outputs
- `reports/sql/analytical_outputs/category_sales.csv`
- `reports/sql/analytical_outputs/monthly_sales.csv`
- `reports/sql/analytical_outputs/payment_analysis.csv`
- `reports/sql/analytical_outputs/product_ranking.csv`
- `reports/sql/analytical_outputs/seller_performance.csv`
- `reports/sql/analytical_outputs/delivery_analysis.csv`
- `reports/sql/analytical_outputs/customer_metrics.csv`
- `reports/sql/analytical_outputs/regional_sales.csv`

SQL results were used selectively. Where a SQL output conflicted with the reconciled final baseline, the conflicting output was not used as final evidence.

### Python processing and validation
- `reports/python_processing/processing_summary.json`
- `reports/python_processing/processing_execution.log`
- `reports/python_processing/postgresql_metrics.txt`
- `reports/python_processing/processing_validation.csv`
- `reports/python_processing/join_validation.csv`
- `reports/python_processing/traceability_validation.csv`
- `reports/python_processing/reproducibility_hashes.csv`

Python independently validated core dataset counts, totals, joins, traceability, grain checks, and reproducibility.

### Excel analysis
- `excel/Retail_Analysis.xlsx`

The workbook contains sales summaries, monthly sales, category analysis, product analysis, customer analysis, regional analysis, payment/review sheets, calculation checks, and validation summaries.

### EDA findings
- `reports/eda/findings.md`
- `reports/eda/eda_findings.csv`
- EDA charts under `reports/eda/charts/`

EDA supplied the detailed descriptive findings for delivery, review distribution, customer behavior, category/product concentration, and payment behavior.

---

## Final Interpretation

The strongest validated business story is:

**The marketplace achieved substantial sales growth and operates at meaningful scale, but revenue is concentrated by category and geography while individual-product and seller revenue is comparatively diversified. The customer base is dominated by one-time buyers, payment value is heavily concentrated in credit cards, and customer satisfaction is generally high but contains a meaningful one-star segment. Delivery performance is generally strong, yet poorer delivery outcomes are associated with weaker customer ratings.**

This report intentionally stops at **business insight generation**. Specific actions, priorities, interventions, and management recommendations belong to the next phase: **Phase 19 — Executive Recommendations**.
