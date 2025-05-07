WITH margin_order AS (
    SELECT
        sales.*,
        CAST(product.purchase_price AS FLOAT64) AS purchase_price,
        sales.quantity * CAST(product.purchase_price AS FLOAT64) AS purchase_cost,
        sales.revenue - (sales.quantity * CAST(product.purchase_price AS FLOAT64)) AS margin
    FROM {{ ref('stg_raw__sales') }} AS sales
    JOIN {{ ref('stg_raw__product') }} AS product
        ON sales.products_id = product.products_id
)

SELECT
    date_date,
    orders_id,
    SUM(quantity) AS total_quantity,
    ROUND(SUM(revenue), 2) AS total_revenue,
    ROUND(SUM(purchase_cost), 2) AS total_purchase_cost,
    ROUND(SUM(margin), 2) AS total_margin
FROM margin_order
GROUP BY date_date, orders_id
