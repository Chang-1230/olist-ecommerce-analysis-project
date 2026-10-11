SELECT
COUNT(DISTINCT order_id) AS total_orders,
COUNT(*) AS total_items,
ROUND(SUM(price), 2) AS total_revenue,
ROUND(SUM(freight_value), 2) AS total_freight,
ROUND(SUM(price + freight_value), 2) AS total_order_value,
ROUND(SUM(price) / COUNT(DISTINCT order_id), 2)
AS average_order_value
FROM order_items;

SELECT
DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS month,
COUNT(DISTINCT o.order_id) AS orders,
ROUND(SUM(oi.price), 2) AS revenue,
ROUND(
SUM(oi.price) / COUNT(DISTINCT o.order_id),
2
) AS average_order_value
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m')
ORDER BY month;

WITH monthly_sales AS (
SELECT
DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS month,
COUNT(DISTINCT o.order_id) AS orders,
ROUND(SUM(oi.price), 2) AS revenue
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m')
)
SELECT
month,
orders,
revenue,
ROUND(
(
revenue - LAG(revenue) OVER (ORDER BY month)
) / LAG(revenue) OVER (ORDER BY month) * 100,
2
) AS revenue_growth_pct
FROM monthly_sales
ORDER BY month;