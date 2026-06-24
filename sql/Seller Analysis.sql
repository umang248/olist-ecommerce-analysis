--Best Sellers
SELECT 
    seller_id, 
    COUNT(DISTINCT order_id) AS total_orders_fulfilled,
    SUM(price) AS total_revenue
FROM order_items
GROUP BY seller_id
ORDER BY total_revenue DESC;

--Lowest Rated Sellers
SELECT 
    oi.seller_id, 
    AVG(r.review_score) AS average_rating,
    COUNT(r.review_id) AS total_reviews
FROM order_items oi
JOIN order_reviews r ON oi.order_id = r.order_id
GROUP BY oi.seller_id
HAVING COUNT(r.review_id) > 10 
ORDER BY average_rating ASC
LIMIT 10;

--Delivery Performance
SELECT 
    oi.seller_id, 
    AVG(o.order_delivered_carrier_date - o.order_approved_at) AS avg_processing_time,
    COUNT(DISTINCT o.order_id) AS total_orders_processed
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_delivered_carrier_date IS NOT NULL 
  AND o.order_approved_at IS NOT NULL
GROUP BY oi.seller_id
HAVING COUNT(DISTINCT o.order_id) > 10 
ORDER BY avg_processing_time ASC
LIMIT 10;