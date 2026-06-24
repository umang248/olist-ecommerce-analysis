--Top Customers
SELECT 
    c.customer_unique_id, 
    SUM(oi.price) AS total_spent_lifetime
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_unique_id
ORDER BY total_spent_lifetime DESC
LIMIT 10;

--Repeat Customers
SELECT 
    c.customer_unique_id, 
    COUNT(DISTINCT o.order_id) AS total_lifetime_orders
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_unique_id
HAVING COUNT(DISTINCT o.order_id) > 1
ORDER BY total_lifetime_orders DESC;

--Customer Geography
SELECT 
    customer_state, 
    COUNT(DISTINCT customer_unique_id) AS distinct_customer_count
FROM customers
GROUP BY customer_state
ORDER BY distinct_customer_count DESC;