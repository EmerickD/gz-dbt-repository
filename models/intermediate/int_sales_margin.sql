-- création du JOIN, de la table du purchase_cost et du margin per Product
WITH margin_product AS (
    SELECT
        sales.products_id,
        sales.quantity,
        sales.revenue,
        CAST(product.purchase_price AS FLOAT64) AS purchase_price
    FROM {{ ref('stg_raw__sales') }} AS sales
    JOIN {{ ref('stg_raw__product') }} AS product
        ON sales.products_id = product.products_id
)

SELECT
    products_id,
    SUM(quantity) AS total_quantity,
    ROUND(SUM(revenue), 2) AS total_revenue,
    ROUND(SUM(quantity * purchase_price), 2) AS total_purchase_cost,
    ROUND(SUM(revenue - (quantity * purchase_price)), 2) AS total_margin
FROM margin_product
GROUP BY products_id


    
