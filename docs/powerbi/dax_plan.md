# Phase 16 — Final DAX Measure Plan

## 1. Revenue Governance

| Metric         | Authoritative Source              | Definition                                   |
| -------------- | --------------------------------- | -------------------------------------------- |
| Total Sales    | `fact_payments[payment_value]`    | Sum of payment value                         |
| Category Sales | `fact_order_items[price]`         | Sum of item price                            |
| Product Sales  | `fact_order_items[price]`         | Sum of item price                            |
| Seller Sales   | `fact_order_items[price]`         | Sum of item price                            |
| Freight        | `fact_order_items[freight_value]` | Separate metric; not included in Total Sales |

**No `order_revenue` column is required in `fact_orders`.**

---

# 2. Core Sales Measures

## 2.1 Total Sales

```DAX
Total Sales =
SUM ( fact_payments[payment_value] )
```

## 2.2 Total Orders

```DAX
Total Orders =
DISTINCTCOUNT ( fact_orders[order_id] )
```

## 2.3 Total Items

```DAX
Total Items =
COUNTROWS ( fact_order_items )
```

## 2.4 AOV

```DAX
AOV =
DIVIDE (
    [Total Sales],
    [Total Orders]
)
```

---

# 3. Time-Based Sales Measures

`dim_date` is the authoritative date dimension.

## 3.1 MoM Sales Growth %

```DAX
MoM Sales Growth % =
VAR CurrentSales =
    [Total Sales]
VAR PreviousMonthSales =
    CALCULATE (
        [Total Sales],
        DATEADD (
            dim_date[full_date],
            -1,
            MONTH
        )
    )
RETURN
    DIVIDE (
        CurrentSales - PreviousMonthSales,
        PreviousMonthSales
    )
```

## 3.2 YoY Sales Growth %

```DAX
YoY Sales Growth % =
VAR CurrentSales =
    [Total Sales]
VAR PreviousYearSales =
    CALCULATE (
        [Total Sales],
        DATEADD (
            dim_date[full_date],
            -1,
            YEAR
        )
    )
RETURN
    DIVIDE (
        CurrentSales - PreviousYearSales,
        PreviousYearSales
    )
```

## 3.3 YTD Sales

```DAX
YTD Sales =
TOTALYTD (
    [Total Sales],
    dim_date[full_date]
)
```

`Monthly Sales` does not require a separate measure. `[Total Sales]` evaluated against `dim_date` month context provides monthly sales.

---

# 4. Product & Category Measures

## 4.1 Category Sales

```DAX
Category Sales =
SUM ( fact_order_items[price] )
```

## 4.2 Product Sales

```DAX
Product Sales =
SUM ( fact_order_items[price] )
```

## 4.3 Category Sales %

```DAX
Category Sales % =
DIVIDE (
    [Category Sales],
    CALCULATE (
        [Category Sales],
        REMOVEFILTERS (
            dim_product[product_category_name_english]
        )
    )
)
```

## 4.4 Product Sales %

```DAX
Product Sales % =
DIVIDE (
    [Product Sales],
    CALCULATE (
        [Product Sales],
        REMOVEFILTERS (
            dim_product[product_id]
        )
    )
)
```

## 4.5 Top Product

```DAX
Top Product =
VAR RankedProducts =
    TOPN (
        1,
        ALLSELECTED ( dim_product[product_id] ),
        [Product Sales],
        DESC
    )
RETURN
    CONCATENATEX (
        RankedProducts,
        dim_product[product_id],
        ", "
    )
```

## 4.6 Top Category

```DAX
Top Category =
VAR RankedCategories =
    TOPN (
        1,
        ALLSELECTED (
            dim_product[product_category_name_english]
        ),
        [Category Sales],
        DESC
    )
RETURN
    CONCATENATEX (
        RankedCategories,
        dim_product[product_category_name_english],
        ", "
    )
```

## 4.7 Cumulative Product Sales %

```DAX
Cumulative Product Sales % =
VAR SelectedProducts =
    ALLSELECTED ( dim_product[product_id] )

VAR CurrentProductSales =
    [Product Sales]

VAR CumulativeSales =
    CALCULATE (
        [Product Sales],
        FILTER (
            SelectedProducts,
            [Product Sales] >= CurrentProductSales
        )
    )

VAR TotalSelectedSales =
    CALCULATE (
        [Product Sales],
        SelectedProducts
    )

RETURN
    DIVIDE (
        CumulativeSales,
        TotalSelectedSales
    )
```

This measure must be validated against a manually calculated sample before final dashboard acceptance.

---

# 5. Regional Measures

Regional sales use the payment fact because the approved Total Sales definition is payment-based.

## 5.1 Regional Sales

```DAX
Regional Sales =
[Total Sales]
```

Customer-state filtering propagates through:

```text
dim_customer
        ↓
fact_payments
        ↓
payment_value
```

## 5.2 Regional Sales %

```DAX
Regional Sales % =
DIVIDE (
    [Regional Sales],
    CALCULATE (
        [Regional Sales],
        REMOVEFILTERS (
            dim_customer[customer_state]
        )
    )
)
```

## 5.3 Top Region

```DAX
Top Region =
VAR RankedRegions =
    TOPN (
        1,
        ALLSELECTED (
            dim_customer[customer_state]
        ),
        [Regional Sales],
        DESC
    )
RETURN
    CONCATENATEX (
        RankedRegions,
        dim_customer[customer_state],
        ", "
    )
```

---

# 6. Seller Measures

Seller sales use order-item price.

## 6.1 Seller Sales

```DAX
Seller Sales =
SUM ( fact_order_items[price] )
```

## 6.2 Seller Orders

```DAX
Seller Orders =
DISTINCTCOUNT ( fact_order_items[order_id] )
```

---

# 7. Customer Measures

Customer KPIs use `customer_unique_id` for unique-customer counting.

## 7.1 Total Customers

```DAX
Total Customers =
DISTINCTCOUNT (
    dim_customer[customer_unique_id]
)
```

## 7.2 Repeat Customers

```DAX
Repeat Customers =
COUNTROWS (
    FILTER (
        VALUES (
            dim_customer[customer_unique_id]
        ),
        CALCULATE (
            DISTINCTCOUNT (
                fact_orders[order_id]
            )
        ) > 1
    )
)
```

## 7.3 Repeat Customer %

```DAX
Repeat Customer % =
DIVIDE (
    [Repeat Customers],
    [Total Customers]
)
```

## 7.4 Customer Sales

```DAX
Customer Sales =
[Total Sales]
```

Customer Sales therefore uses the approved payment-based sales definition.

## 7.5 Orders per Customer

```DAX
Orders per Customer =
DIVIDE (
    [Total Orders],
    [Total Customers]
)
```

## 7.6 Customer Orders

```DAX
Customer Orders =
DISTINCTCOUNT (
    fact_orders[order_id]
)
```

## 7.7 Repeat vs Non-Repeat Customer Count

```DAX
Repeat vs Non-Repeat Customer Count =
VAR RepeatCustomerCount =
    [Repeat Customers]

VAR NonRepeatCustomerCount =
    [Total Customers] - RepeatCustomerCount

RETURN
    NonRepeatCustomerCount
```

For a repeat/non-repeat visual, use customer classification as the category and the appropriate customer-count measure in the visual. This measure represents the non-repeat count and should not be used as a replacement for the repeat-customer measure.

---

# 8. Supporting Measures

## 8.1 Product Item Volume

```DAX
Product Item Volume =
COUNTROWS (
    fact_order_items
)
```

---

# 9. Final Measure Inventory

|  # | Measure                             |
| -: | ----------------------------------- |
|  1 | Total Sales                         |
|  2 | Total Orders                        |
|  3 | Total Items                         |
|  4 | AOV                                 |
|  5 | MoM Sales Growth %                  |
|  6 | YoY Sales Growth %                  |
|  7 | YTD Sales                           |
|  8 | Category Sales                      |
|  9 | Product Sales                       |
| 10 | Category Sales %                    |
| 11 | Product Sales %                     |
| 12 | Top Product                         |
| 13 | Top Category                        |
| 14 | Cumulative Product Sales %          |
| 15 | Regional Sales                      |
| 16 | Regional Sales %                    |
| 17 | Top Region                          |
| 18 | Seller Sales                        |
| 19 | Seller Orders                       |
| 20 | Total Customers                     |
| 21 | Repeat Customers                    |
| 22 | Repeat Customer %                   |
| 23 | Customer Sales                      |
| 24 | Orders per Customer                 |
| 25 | Customer Orders                     |
| 26 | Product Item Volume                 |
| 27 | Repeat vs Non-Repeat Customer Count |

---

# 10. Source Validation

| Measure Group          | PostgreSQL Source                              |
| ---------------------- | ---------------------------------------------- |
| Total Sales            | `fact_payments.payment_value`                  |
| Orders                 | `fact_orders.order_id`                         |
| Product/Category Sales | `fact_order_items.price`                       |
| Seller Sales           | `fact_order_items.price`                       |
| Customer Sales         | `fact_payments.payment_value`                  |
| Regional Sales         | `fact_payments.payment_value` + `dim_customer` |
| Customer Count         | `dim_customer.customer_unique_id`              |
| Delivery Metrics       | `fact_orders`                                  |
| Review Metrics         | `fact_reviews`                                 |

---

# 11. Architecture Rules

1. Do **not** create a fact-to-fact relationship.
2. Do **not** create `fact_orders[order_revenue]`.
3. Do **not** include `freight_value` in Total Sales.
4. Use `fact_payments[payment_value]` for the approved Total Sales KPI.
5. Use `fact_order_items[price]` for product/category/seller sales.
6. Use `dim_customer[customer_unique_id]` for unique customer KPIs.
7. Use `dim_date[full_date]` for time intelligence.
8. Keep `dim_geography` outside the active Power BI model.
9. Validate Pareto calculations against manually calculated samples.
10. Validate every implemented measure against the existing SQL KPI outputs.

---

# 12. Phase 16 DAX Decision

**DAX PLAN — FINALIZED FOR IMPLEMENTATION**

The DAX plan now covers the additional metrics previously identified as missing:

* Category Sales
* Product Sales
* Seller Sales
* Seller Orders
* Customer Sales
* Orders per Customer
* Customer Orders
* Product Item Volume
* Repeat vs Non-Repeat Customer Count

The plan is aligned with the approved Business Understanding KPI definitions and the actual PostgreSQL reporting schema.
