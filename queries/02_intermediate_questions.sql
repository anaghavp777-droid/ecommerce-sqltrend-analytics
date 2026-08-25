USE ecommerce_project;
-- 1. What is the total revenue generated so far? 
SELECT SUM(revenue) as total_revenue FROM sales;
-- 2. Which product category has sold the most units? 
SELECT CATEGORY ,SUM(quantity) as units FROM sales GROUP BY category ORDER BY units desc LIMIT 1;
-- 3. List the top 5 customers by total amount spent. 
SELECT c.customer_id, c.customer_name, SUM(s.quantity*s.unit_price) AS total_spent
FROM customers AS c INNER JOIN sales AS s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC
LIMIT 5;
-- 4. Which sellers have generated more than a set revenue threshold? (HAVING) 
SELECT c.customer_id,c.customer_name ,SUM(s.revenue) as revenue 
FROM customers AS c INNER JOIN sales AS s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.customer_name 
HAVING revenue>5000 ORDER BY revenue;
-- 5. What is the average order value per city? 
SELECT c.city ,SUM(s.revenue) as revenue 
FROM customers AS c INNER JOIN sales AS s ON c.customer_id = s.customer_id
GROUP BY city
ORDER BY revenue desc;
-- 6. How many orders did each payment type handle, and what's the average payment value per type? 
SELECT payment_type, COUNT(*) AS number_of_orders, AVG(quantity * unit_price) AS avg_payment
FROM sales GROUP BY payment_type
ORDER BY number_of_orders DESC;
