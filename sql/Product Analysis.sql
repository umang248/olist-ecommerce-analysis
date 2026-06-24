--Top Products
SELECT 
    product_id, 
    SUM(price) AS total_revenue,
    COUNT(order_id) AS units_sold
FROM order_items
GROUP BY product_id
ORDER BY total_revenue DESC
LIMIT 10;
--Most profitable categories
SELECT 
    p.product_category_name, 
    SUM(oi.price) AS total_revenue,
    SUM(oi.price - oi.freight_value) AS estimated_profit_margin
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY estimated_profit_margin DESC;
