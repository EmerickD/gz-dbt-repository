  Select 
    date_date,
    COUNT(DISTINCT orders_id) AS total_transactions,
    ROUND(SUM(total_revenue), 2) AS revenue,
    ROUND(SUM(total_revenue) / COUNT(DISTINCT orders_id), 2) AS average_basket,
    ROUND(SUM(total_margin), 2) AS margin,
    ROUND(SUM(orders_operationnal_margin), 2) AS operational_margin,
    ROUND(SUM(total_purchase_cost), 2) AS total_purchase_cost,
    ROUND(SUM(shipping_fee), 2) AS total_shipping_fee,
    ROUND(SUM(logcost), 2) AS total_logcost,
    SUM(total_quantity) AS total_quantity
  FROM {{ref('int_orders_operational')}}
  GROUP BY date_date
  ORDER BY date_date