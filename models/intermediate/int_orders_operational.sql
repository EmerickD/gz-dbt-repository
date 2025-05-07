WITH operationnal_margin AS (
    SELECT orders_margin.orders_id,
            orders_margin.date_date,
            orders_margin.total_margin,
            ship.ship_cost,
            ship.shipping_fee,
            ship.logcost    
    FROM {{ ref('int_orders_margin') }} AS orders_margin
    JOIN {{ ref('stg_raw__ship') }} AS ship
    ON orders_margin.orders_id = ship.orders_id
)
SELECT *,
(total_margin + shipping_fee - logcost - ship_cost) AS orders_operationnal_margin
FROM operationnal_margin
ORDER BY orders_id, date_date