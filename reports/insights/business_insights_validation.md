# Step 15 — Final Insight Report Validation

## Validation Objective

Validate every headline insight in `reports/insights/business_insights.md` for numerical existence, calculation accuracy, time-period correctness, valid comparison, double-counting risk, cross-tool consistency, causal wording, business interpretation, and documented evidence.

## Overall Result

**FINAL RESULT: PASS WITH MINOR DOCUMENTATION CORRECTIONS RECOMMENDED**

All 8 headline insights are supported by the project's available evidence and do not contain unsupported causal conclusions. The numerical calculations checked below are correct.

Two items require caution but do not invalidate the insights:

1. The **regional SQL output conflicts with the reconciled regional baseline**. The final report correctly excludes that conflicting SQL output from regional evidence and uses the reconciled regional values.
2. Some detailed findings use different analytical populations/grains. The report explicitly documents these differences instead of silently combining them.

No headline insight should be removed.

---

## Insight-by-Insight Validation

### Insight 1 — Category revenue is highly concentrated

| Check | Result |
|---|---|
| Number exists in source data | PASS |
| Calculation correct | PASS |
| Time period correct | PASS |
| Comparison valid | PASS |
| No double counting | PASS |
| SQL/Python/Excel/Power BI contradiction | PASS |
| Unsupported causal statement | PASS |
| Business interpretation follows evidence | PASS |
| Source/evidence documented | PASS |

**Verified values**
- Health & Beauty: R$1,258,681.34
- Watches & Gifts: R$1,205,005.68
- Top 3 share: 25.76%
- Top 5 share: 39.74%
- Top 10 share: 62.36%
- 18 of 72 valid translated categories: approximately 81.2%

**Calculation check**
- Top 3 = (1,258,681.34 + 1,205,005.68 + 1,036,988.68) / 13,591,643.70 = **25.7561%**
- Top 5 = **39.7353%**
- The reported rounded values are correct.

**Conclusion: PASS.**

---

### Insight 2 — Regional revenue is concentrated

| Check | Result |
|---|---|
| Number exists in source data | PASS |
| Calculation correct | PASS |
| Time period correct | PASS |
| Comparison valid | PASS |
| No double counting | PASS |
| SQL/Python/Excel/Power BI contradiction | PASS WITH DOCUMENTED SQL EXCEPTION |
| Unsupported causal statement | PASS |
| Business interpretation follows evidence | PASS |
| Source/evidence documented | PASS |

**Verified values**
- São Paulo: R$5,202,955.05
- Rio de Janeiro: R$1,824,092.67
- Minas Gerais: R$1,585,308.03
- SP share: approximately 38.28%
- Top 3 share: approximately 63.37%

**Calculation check**
- SP / total sales = **38.2805%**
- (SP + RJ + MG) / total sales = **63.3651%**

The report correctly does **not** use the conflicting SQL `regional_sales.csv` result as final evidence. The reconciled regional baseline is supported by the regional analysis/EDA evidence. The underlying EDA findings explicitly report SP at R$5,202,955.05 and the top three at roughly 63%. fileciteturn8file1

**Conclusion: PASS.**

---

### Insight 3 — Repeat-customer participation is low

| Check | Result |
|---|---|
| Number exists in source data | PASS |
| Calculation correct | PASS |
| Time period correct | PASS |
| Comparison valid | PASS |
| No double counting | PASS |
| SQL/Python/Excel/Power BI contradiction | PASS WITH POPULATION QUALIFICATION |
| Unsupported causal statement | PASS |
| Business interpretation follows evidence | PASS |
| Source/evidence documented | PASS |

**Verified values**
- Full-order unique customers: 96,096
- Repeat customers: 2,997
- Repeat rate: 3.12%

**Calculation check**
- 2,997 / 96,096 × 100 = **3.118756%**

The report correctly separates the full-order KPI from the item-backed customer analysis. The item-backed analysis separately reports 2,913 repeat customers and AOV values of R$123.93 versus R$138.67; the underlying findings confirm that comparison. fileciteturn8file1

**Conclusion: PASS.**

---

### Insight 4 — Delivery performance and review association

| Check | Result |
|---|---|
| Number exists in source data | PASS |
| Calculation correct | PASS |
| Time period correct | PASS |
| Comparison valid | PASS |
| No double counting | PASS |
| SQL/Python/Excel/Power BI contradiction | PASS WITH DEFINITION QUALIFICATION |
| Unsupported causal statement | PASS |
| Business interpretation follows evidence | PASS |
| Source/evidence documented | PASS |

**Verified values**
- Average total delivery duration: 12.56 days
- Average handoff-to-customer duration: 9.34 days
- Early: 89.1% of the classified comparison population
- Late: 7.9%
- Unclassified: approximately 3%

The report deliberately states that delivery and review score are **associated**, not that delivery delay causes low ratings.

The review analysis separately confirms the five-star and one-star groups used in the report. fileciteturn9file3

**Important wording validation:** the report says “late delivery is associated with weaker customer ratings,” which is acceptable because the analysis does not claim causation.

**Conclusion: PASS.**

---

### Insight 5 — Sales growth and monthly pattern

| Check | Result |
|---|---|
| Number exists in source data | PASS |
| Calculation correct | PASS |
| Time period correct | PASS |
| Comparison valid | PASS |
| No double counting | PASS |
| SQL/Python/Excel/Power BI contradiction | PASS WITH MONTHLY-COUNT QUALIFICATION |
| Unsupported causal statement | PASS |
| Business interpretation follows evidence | PASS |
| Source/evidence documented | PASS |

**Verified values**
- November 2017: R$1,010,271.37
- April 2018: R$996,647.75
- May 2018: R$996,517.68
- Validated YoY growth: approximately 20.0% / 19.99%

Revenue values are reconciled. Some monthly order counts differ between analytical outputs, so the report correctly avoids using the disputed monthly order counts as headline evidence.

The dataset profile confirms that the order-purchase period runs from September 2016 through October 2018, supporting the report's warning about incomplete terminal periods. fileciteturn9file2

**Conclusion: PASS.**

---

### Insight 6 — Payment value is concentrated in credit cards

| Check | Result |
|---|---|
| Number exists in source data | PASS |
| Calculation correct | PASS |
| Time period correct | PASS |
| Comparison valid | PASS |
| No double counting | PASS |
| SQL/Python/Excel/Power BI contradiction | PASS WITH MEASURE DISTINCTION |
| Unsupported causal statement | PASS |
| Business interpretation follows evidence | PASS |
| Source/evidence documented | PASS |

**Verified values**
- Credit-card payment value: R$12,542,084.19
- Credit-card value share: 78.34%
- Boleto value share: 17.92%
- Total payment value: R$16,008,872.12

The 78.34% figure is a **payment-value share**, not a payment-transaction-count share. This distinction is important because the dataset profile separately reports credit-card transaction frequency at 73.92%. fileciteturn9file3

The report correctly labels the headline measure as payment value.

**Calculation check**
- Sum of listed payment values = **R$16,008,872.12**, matching the stated total.

**Conclusion: PASS.**

---

### Insight 7 — Individual product revenue is highly diversified

| Check | Result |
|---|---|
| Number exists in source data | PASS |
| Calculation correct | PASS |
| Time period correct | PASS |
| Comparison valid | PASS |
| No double counting | PASS |
| SQL/Python/Excel/Power BI contradiction | PASS |
| Unsupported causal statement | PASS |
| Business interpretation follows evidence | PASS |
| Source/evidence documented | PASS |

**Verified values**
- Product catalog: 32,951
- Top product: R$63,885.00
- Top 10 revenue share: 3.32%
- Top 20 revenue share: 5.38%
- Approximately 8,536 products reach approximately 80% cumulative revenue.

**Calculation check**
- 8,536 / 32,951 × 100 = **25.9051%**, correctly rounded to approximately 26%.

The conclusion that product-level revenue is diversified follows from the low concentration of the top 10/top 20 products and the large cumulative product count.

**Conclusion: PASS.**

---

### Insight 8 — Customer satisfaction is high overall, but dissatisfaction is material

| Check | Result |
|---|---|
| Number exists in source data | PASS |
| Calculation correct | PASS |
| Time period correct | PASS |
| Comparison valid | PASS |
| No double counting | PASS |
| SQL/Python/Excel/Power BI contradiction | PASS |
| Unsupported causal statement | PASS |
| Business interpretation follows evidence | PASS |
| Source/evidence documented | PASS |

**Verified values**
- Average review score: 4.09/5
- Five-star reviews: 57,328 / 57.78%
- One-star reviews: 11,424 / 11.51%
- Total review records: 99,224

The review counts sum exactly to 99,224:
57,328 + 19,142 + 8,179 + 3,151 + 11,424 = **99,224**.

The review distribution is independently documented in the dataset profile. fileciteturn9file3

The report does not claim that the one-star reviews have a specific root cause.

**Conclusion: PASS.**

---

## Cross-Report Validation

### Double-counting

**PASS.**

The report distinguishes:
- order-level metrics,
- order-item revenue,
- payment-level value,
- review-level metrics,
- full-order customer population,
- item-backed customer population.

The documented 775 orders without item records are explicitly excluded from item-level calculations.

### Cross-tool contradiction

**PASS WITH KNOWN EXCEPTIONS DOCUMENTED.**

The final report does not blindly require every tool to produce identical results because some outputs use different grains or definitions.

Known exceptions:
- Regional SQL output conflicts with the reconciled regional baseline.
- Customer counts differ between full-order and item-backed populations.
- Monthly order counts differ while monthly revenue reconciles.
- Payment **value share** differs from payment **transaction-count share** because they are different measures.

These are documented in the report's limitations rather than hidden.

### Causal language

**PASS.**

No headline insight claims:
- category performance was caused by marketing,
- regional performance was caused by logistics,
- delivery delay caused low ratings,
- repeat purchasing caused lower AOV,
- sales generated profit,
- product concentration caused business outcomes.

The delivery/review relationship is explicitly identified as an association.

### Business interpretation

**PASS.**

The interpretations stay at the level supported by the evidence:
- concentration,
- diversification,
- customer-mix structure,
- payment mix,
- delivery/review association,
- sales trend,
- satisfaction distribution.

No Phase 19 recommendations are embedded in the insight conclusions.

---

## Validation Decision

**Step 15 — PASS**

The final business insight report is sufficiently validated for Phase 18.

### Required status

| Validation Area | Status |
|---|---|
| All 8 insights numerically supported | PASS |
| Calculations checked | PASS |
| Time periods checked | PASS |
| Comparisons checked | PASS |
| Double-counting reviewed | PASS |
| Cross-tool contradictions reviewed | PASS |
| Causal wording reviewed | PASS |
| Business interpretation reviewed | PASS |
| Evidence documentation reviewed | PASS |
| Final report ready for next phase | **PASS** |

**No headline insight requires removal.**

The report is ready to proceed to **Step 16 — Final Insight QA**.
