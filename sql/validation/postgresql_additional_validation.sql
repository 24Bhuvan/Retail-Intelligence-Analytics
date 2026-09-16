\echo '================================================'
\echo 'STEP 2 - ADDITIONAL POSTGRESQL VALIDATION'
\echo '================================================'

\echo ''
\echo '11. NULL COUNTS — REQUIRED KEYS'
\echo '------------------------------------------------'

SELECT 'fact_orders.order_key' AS field, COUNT(*) AS null_count
FROM analytics.fact_orders WHERE order_key IS NULL
UNION ALL
SELECT 'fact_orders.customer_key', COUNT(*)
FROM analytics.fact_orders WHERE customer_key IS NULL
UNION ALL
SELECT 'fact_orders.order_status_key', COUNT(*)
FROM analytics.fact_orders WHERE order_status_key IS NULL
UNION ALL
SELECT 'fact_order_items.order_item_key', COUNT(*)
FROM analytics.fact_order_items WHERE order_item_key IS NULL
UNION ALL
SELECT 'fact_order_items.product_key', COUNT(*)
FROM analytics.fact_order_items WHERE product_key IS NULL
UNION ALL
SELECT 'fact_order_items.seller_key', COUNT(*)
FROM analytics.fact_order_items WHERE seller_key IS NULL
UNION ALL
SELECT 'fact_payments.payment_key', COUNT(*)
FROM analytics.fact_payments WHERE payment_key IS NULL
UNION ALL
SELECT 'fact_reviews.review_key', COUNT(*)
FROM analytics.fact_reviews WHERE review_key IS NULL
UNION ALL
SELECT 'dim_customer.customer_key', COUNT(*)
FROM analytics.dim_customer WHERE customer_key IS NULL
UNION ALL
SELECT 'dim_product.product_key', COUNT(*)
FROM analytics.dim_product WHERE product_key IS NULL
UNION ALL
SELECT 'dim_seller.seller_key', COUNT(*)
FROM analytics.dim_seller WHERE seller_key IS NULL
UNION ALL
SELECT 'dim_date.date_key', COUNT(*)
FROM analytics.dim_date WHERE date_key IS NULL
UNION ALL
SELECT 'dim_order_status.order_status_key', COUNT(*)
FROM analytics.dim_order_status WHERE order_status_key IS NULL
ORDER BY field;


\echo ''
\echo '12. DUPLICATE PRIMARY KEYS'
\echo '------------------------------------------------'

SELECT 'fact_orders.order_key' AS key_name, COUNT(*) AS duplicate_groups
FROM (
    SELECT order_key
    FROM analytics.fact_orders
    GROUP BY order_key
    HAVING COUNT(*) > 1
) x
UNION ALL
SELECT 'fact_order_items.order_item_key', COUNT(*)
FROM (
    SELECT order_item_key
    FROM analytics.fact_order_items
    GROUP BY order_item_key
    HAVING COUNT(*) > 1
) x
UNION ALL
SELECT 'fact_payments.payment_key', COUNT(*)
FROM (
    SELECT payment_key
    FROM analytics.fact_payments
    GROUP BY payment_key
    HAVING COUNT(*) > 1
) x
UNION ALL
SELECT 'fact_reviews.review_key', COUNT(*)
FROM (
    SELECT review_key
    FROM analytics.fact_reviews
    GROUP BY review_key
    HAVING COUNT(*) > 1
) x
UNION ALL
SELECT 'dim_customer.customer_key', COUNT(*)
FROM (
    SELECT customer_key
    FROM analytics.dim_customer
    GROUP BY customer_key
    HAVING COUNT(*) > 1
) x
UNION ALL
SELECT 'dim_product.product_key', COUNT(*)
FROM (
    SELECT product_key
    FROM analytics.dim_product
    GROUP BY product_key
    HAVING COUNT(*) > 1
) x
UNION ALL
SELECT 'dim_seller.seller_key', COUNT(*)
FROM (
    SELECT seller_key
    FROM analytics.dim_seller
    GROUP BY seller_key
    HAVING COUNT(*) > 1
) x
UNION ALL
SELECT 'dim_date.date_key', COUNT(*)
FROM (
    SELECT date_key
    FROM analytics.dim_date
    GROUP BY date_key
    HAVING COUNT(*) > 1
) x
UNION ALL
SELECT 'dim_order_status.order_status_key', COUNT(*)
FROM (
    SELECT order_status_key
    FROM analytics.dim_order_status
    GROUP BY order_status_key
    HAVING COUNT(*) > 1
) x;


\echo ''
\echo '13. RELATIONSHIP KEY INTEGRITY'
\echo '------------------------------------------------'

SELECT 'fact_orders -> dim_customer' AS relationship,
       COUNT(*) AS orphan_rows
FROM analytics.fact_orders f
LEFT JOIN analytics.dim_customer d
    ON f.customer_key = d.customer_key
WHERE f.customer_key IS NOT NULL
  AND d.customer_key IS NULL

UNION ALL

SELECT 'fact_orders -> dim_order_status',
       COUNT(*)
FROM analytics.fact_orders f
LEFT JOIN analytics.dim_order_status d
    ON f.order_status_key = d.order_status_key
WHERE f.order_status_key IS NOT NULL
  AND d.order_status_key IS NULL

UNION ALL

SELECT 'fact_orders -> dim_date (purchase)',
       COUNT(*)
FROM analytics.fact_orders f
LEFT JOIN analytics.dim_date d
    ON f.purchase_date_key = d.date_key
WHERE f.purchase_date_key IS NOT NULL
  AND d.date_key IS NULL

UNION ALL

SELECT 'fact_order_items -> dim_product',
       COUNT(*)
FROM analytics.fact_order_items f
LEFT JOIN analytics.dim_product d
    ON f.product_key = d.product_key
WHERE f.product_key IS NOT NULL
  AND d.product_key IS NULL

UNION ALL

SELECT 'fact_order_items -> dim_seller',
       COUNT(*)
FROM analytics.fact_order_items f
LEFT JOIN analytics.dim_seller d
    ON f.seller_key = d.seller_key
WHERE f.seller_key IS NOT NULL
  AND d.seller_key IS NULL

UNION ALL

SELECT 'fact_order_items -> dim_date',
       COUNT(*)
FROM analytics.fact_order_items f
LEFT JOIN analytics.dim_date d
    ON f.order_date_key = d.date_key
WHERE f.order_date_key IS NOT NULL
  AND d.date_key IS NULL

UNION ALL

SELECT 'fact_payments -> dim_customer',
       COUNT(*)
FROM analytics.fact_payments f
LEFT JOIN analytics.dim_customer d
    ON f.customer_key = d.customer_key
WHERE f.customer_key IS NOT NULL
  AND d.customer_key IS NULL

UNION ALL

SELECT 'fact_payments -> dim_date',
       COUNT(*)
FROM analytics.fact_payments f
LEFT JOIN analytics.dim_date d
    ON f.payment_date_key = d.date_key
WHERE f.payment_date_key IS NOT NULL
  AND d.date_key IS NULL

UNION ALL

SELECT 'fact_reviews -> dim_customer',
       COUNT(*)
FROM analytics.fact_reviews f
LEFT JOIN analytics.dim_customer d
    ON f.customer_key = d.customer_key
WHERE f.customer_key IS NOT NULL
  AND d.customer_key IS NULL

UNION ALL

SELECT 'fact_reviews -> dim_date',
       COUNT(*)
FROM analytics.fact_reviews f
LEFT JOIN analytics.dim_date d
    ON f.review_date_key = d.date_key
WHERE f.review_date_key IS NOT NULL
  AND d.date_key IS NULL;


\echo ''
\echo '14. ACTUAL DATE RANGES'
\echo '------------------------------------------------'

SELECT 'dim_date.full_date' AS date_field,
       MIN(full_date) AS min_date,
       MAX(full_date) AS max_date
FROM analytics.dim_date

UNION ALL

SELECT 'fact_orders.purchase_date',
       MIN(d.full_date),
       MAX(d.full_date)
FROM analytics.fact_orders f
JOIN analytics.dim_date d
    ON f.purchase_date_key = d.date_key

UNION ALL

SELECT 'fact_orders.approved_date',
       MIN(d.full_date),
       MAX(d.full_date)
FROM analytics.fact_orders f
JOIN analytics.dim_date d
    ON f.approved_date_key = d.date_key

UNION ALL

SELECT 'fact_orders.delivered_customer_date',
       MIN(d.full_date),
       MAX(d.full_date)
FROM analytics.fact_orders f
JOIN analytics.dim_date d
    ON f.delivered_customer_date_key = d.date_key

UNION ALL

SELECT 'fact_orders.estimated_delivery_date',
       MIN(d.full_date),
       MAX(d.full_date)
FROM analytics.fact_orders f
JOIN analytics.dim_date d
    ON f.estimated_delivery_date_key = d.date_key;


\echo ''
\echo '================================================'
\echo 'STEP 2 ADDITIONAL VALIDATION COMPLETE'
\echo '================================================'
