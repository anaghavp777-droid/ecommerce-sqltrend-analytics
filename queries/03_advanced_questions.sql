USE ecommerce_project;
-- 1. Rank products by total revenue within each category using RANK() or DENSE_RANK(). 
SELECT product_name,category,revenue ,RANK() OVER (partition by category ORDER BY revenue Desc) FROM sales;
-- 2. Find customers who spent more than the average customer spend (subquery). 
SELECT c.customer_id,c.customer_name, SUM(s.revenue) as sum
FROM customers AS c INNER JOIN sales AS s ON c.customer_id = s.customer_id
GROUP BY c.customer_id,c.customer_name 
HAVING sum> (SELECT AVG(revenue) as average FROM sales)
ORDER BY sum;
-- 4. Identify repeat customers (customers with more than 20 order) using GROUP BY + HAVING. 
SELECT c.customer_id, c.customer_name, COUNT(s.order_id) AS total_orders
FROM customers AS c INNER JOIN sales AS s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(total_orders) > 5
ORDER BY total_orders DESC;
-- 5. Create a view called monthly_sales_summary that a dashboard tool could read directly. 
CREATE VIEW monthly_sales_summary AS
SELECT month(order_date) as months, COUNT(*) AS total_orders,SUM(revenue) AS total_revenue,AVG(revenue) AS avg_order_value
FROM sales GROUP BY months;
SELECT * FROM monthly_sales_summary;
-- 6. Write a stored procedure get_customer_history(customer_id) that returns a customer's full order history.
DELIMITER //
CREATE PROCEDURE get_customer_history(IN cust_id INT)
BEGIN
SELECT s.*,c.* FROM sales AS s INNER JOIN customers AS c ON s.customer_id = c.customer_id
ORDER BY s.order_date;
END 
DELIMITER ;
