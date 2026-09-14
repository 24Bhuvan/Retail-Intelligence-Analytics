\echo '=============================================='
\echo 'STEP 2 - POSTGRESQL REPORTING LAYER VERIFICATION'
\echo '=============================================='

\echo ''
\echo '1. REQUIRED TABLES'
\echo '----------------------------------------------'

SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'analytics'
AND table_name IN (
    'fact_orders',
    'fact_order_items',
    'fact_payments',
    'fact_reviews',
    'dim_date',
    'dim_customer',
    'dim_product',
    'dim_seller',
    'dim_order_status'
)
ORDER BY table_name;


\echo ''
\echo '2. ROW COUNTS'
\echo '----------------------------------------------'

SELECT 'fact_orders' AS table_name, COUNT(*) AS row_count
FROM analytics.fact_orders
UNION ALL
SELECT 'fact_order_items', COUNT(*)
FROM analytics.fact_order_items
UNION ALL
SELECT 'fact_payments', COUNT(*)
FROM analytics.fact_payments
UNION ALL
SELECT 'fact_reviews', COUNT(*)
FROM analytics.fact_reviews
UNION ALL
SELECT 'dim_date', COUNT(*)
FROM analytics.dim_date
UNION ALL
SELECT 'dim_customer', COUNT(*)
FROM analytics.dim_customer
UNION ALL
SELECT 'dim_product', COUNT(*)
FROM analytics.dim_product
UNION ALL
SELECT 'dim_seller', COUNT(*)
FROM analytics.dim_seller
UNION ALL
SELECT 'dim_order_status', COUNT(*)
FROM analytics.dim_order_status
ORDER BY table_name;


\echo ''
\echo '3. PRIMARY KEYS'
\echo '----------------------------------------------'

SELECT
    tc.table_name,
    kcu.column_name,
    tc.constraint_name
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage kcu
    ON tc.constraint_name = kcu.constraint_name
    AND tc.table_schema = kcu.table_schema
WHERE tc.table_schema = 'analytics'
AND tc.constraint_type = 'PRIMARY KEY'
ORDER BY tc.table_name, kcu.ordinal_position;


\echo ''
\echo '4. FOREIGN KEYS'
\echo '----------------------------------------------'

SELECT
    tc.table_name,
    kcu.column_name,
    ccu.table_name AS referenced_table,
    ccu.column_name AS referenced_column,
    tc.constraint_name
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage kcu
    ON tc.constraint_name = kcu.constraint_name
    AND tc.table_schema = kcu.table_schema
JOIN information_schema.constraint_column_usage ccu
    ON tc.constraint_name = ccu.constraint_name
    AND tc.table_schema = ccu.table_schema
WHERE tc.table_schema = 'analytics'
AND tc.constraint_type = 'FOREIGN KEY'
ORDER BY tc.table_name, kcu.column_name;


\echo ''
\echo '5. DATA TYPES'
\echo '----------------------------------------------'

SELECT
    table_name,
    column_name,
    data_type,
    is_nullable
FROM information_schema.columns
WHERE table_schema = 'analytics'
ORDER BY table_name, ordinal_position;


\echo ''
\echo '6. DATE FIELDS'
\echo '----------------------------------------------'

SELECT
    table_name,
    column_name,
    data_type
FROM information_schema.columns
WHERE table_schema = 'analytics'
AND (
    column_name ILIKE '%date%'
    OR column_name ILIKE '%time%'
)
ORDER BY table_name, column_name;


\echo ''
\echo '7. REVENUE / PAYMENT FIELDS'
\echo '----------------------------------------------'

SELECT
    table_name,
    column_name,
    data_type
FROM information_schema.columns
WHERE table_schema = 'analytics'
AND column_name IN (
    'price',
    'order_revenue',
    'freight_value',
    'payment_value'
)
ORDER BY table_name, column_name;


\echo ''
\echo '8. CUSTOMER FIELDS'
\echo '----------------------------------------------'

SELECT
    table_name,
    column_name,
    data_type
FROM information_schema.columns
WHERE table_schema = 'analytics'
AND (
    column_name ILIKE '%customer%'
    OR column_name IN (
        'customer_state',
        'customer_city'
    )
)
ORDER BY table_name, column_name;


\echo ''
\echo '9. PRODUCT FIELDS'
\echo '----------------------------------------------'

SELECT
    table_name,
    column_name,
    data_type
FROM information_schema.columns
WHERE table_schema = 'analytics'
AND (
    column_name ILIKE '%product%'
    OR column_name ILIKE '%category%'
)
ORDER BY table_name, column_name;


\echo ''
\echo '10. SELLER FIELDS'
\echo '----------------------------------------------'

SELECT
    table_name,
    column_name,
    data_type
FROM information_schema.columns
WHERE table_schema = 'analytics'
AND (
    column_name ILIKE '%seller%'
    OR column_name IN (
        'seller_state',
        'seller_city'
    )
)
ORDER BY table_name, column_name;


\echo ''
\echo '=============================================='
\echo 'STEP 2 VERIFICATION COMPLETE'
\echo '=============================================='
