SELECT COUNT(*) AS total_orders
FROM orders;

SELECT COUNT(*) AS total_order_items
FROM order_items;

SELECT COUNT(*) AS total_products
FROM products;

SELECT
order_id,
COUNT() AS id_count
FROM orders
GROUP BY order_id
HAVING COUNT() > 1;

SELECT
product_id,
COUNT() AS id_count
FROM products
GROUP BY product_id
HAVING COUNT() > 1;

SELECT COUNT(*) AS missing_product_ids
FROM order_items
WHERE product_id IS NULL;

SELECT COUNT(*) AS unmatched_products
FROM order_items oi
LEFT JOIN products p
ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

SELECT COUNT(*) AS orders_without_items
FROM orders o
LEFT JOIN order_items oi
ON o.order_id = oi.order_id
WHERE oi.order_id IS NULL;