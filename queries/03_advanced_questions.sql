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

-- 1. Rank customers by total spend.
SELECT customer_id, SUM(revenue) AS total_spend,
RANK() OVER (ORDER BY SUM(revenue) DESC) AS spend_rank
FROM sales GROUP BY customer_id;

-- 2. Show a running total of revenue by order date.
SELECT order_id, order_date, revenue,
SUM(revenue) OVER (ORDER BY order_date) AS running_total FROM sales;

-- 3. Find each customer's latest order date.
SELECT customer_id, MAX(order_date) AS latest_order FROM sales
GROUP BY customer_id;

-- 5. Show total revenue for each month.
SELECT MONTH(order_date) AS month_num, SUM(revenue) AS total_revenue
FROM sales GROUP BY MONTH(order_date) ORDER BY month_num;

-- 6. Find the top-selling product in each category.
SELECT category, product_name, SUM(revenue) AS total_revenue
FROM sales GROUP BY category, product_name ORDER BY category, total_revenue DESC;

-- 7. Find customers whose last order was cancelled.
SELECT customer_id, status
FROM sales WHERE status = 'Cancelled';

-- 8. Find categories with above-average revenue.
SELECT category, AVG(revenue) AS avg_revenue
FROM sales GROUP BY category
HAVING AVG(revenue) > (SELECT AVG(revenue) FROM sales);

-- 9. Count how many different categories each customer has bought from.
SELECT customer_id, COUNT(DISTINCT category) AS categories_bought
FROM sales GROUP BY customer_id;


-- 14. Combine cancelled and pending orders into one list.
SELECT order_id, customer_id, 'Cancelled' AS reason FROM sales WHERE status = 'Cancelled'
UNION
SELECT order_id, customer_id, 'Pending' AS reason FROM sales WHERE status = 'Pending';

-- 15. List all orders along with customer names and cities.
SELECT s.order_id, c.customer_name, c.city, s.revenue
FROM sales AS s JOIN customers AS c ON s.customer_id = c.customer_id;

-- 13. Create a view showing total orders and spend per customer.
CREATE VIEW customer_summary AS
SELECT customer_id, COUNT(*) AS total_orders, SUM(revenue) AS total_spend
FROM sales GROUP BY customer_id;

SELECT * FROM customer_summary;

-- 14. Find duplicate orders (same customer, product, and date).
SELECT customer_id, product_name, order_date, COUNT(*) AS duplicate_count
FROM sales GROUP BY customer_id, product_name, order_date
HAVING COUNT(*) > 1;

-- 15. Show total revenue by payment type.
SELECT payment_type, SUM(revenue) AS total_revenue
FROM sales GROUP BY payment_type;
-- 16. Find the total revenue for a specific category.
SELECT category, SUM(revenue) AS total_revenue
FROM sales
WHERE category = 'Electronics'
GROUP BY category;

-- 17. List customers along with the number of orders they've placed.
SELECT c.customer_id, c.customer_name, COUNT(s.order_id) AS order_count
FROM customers AS c
JOIN sales AS s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.customer_name;

-- 18. Find the highest revenue order for each customer.
SELECT customer_id, MAX(revenue) AS highest_order_revenue
FROM sales
GROUP BY customer_id;

-- 19. Show all orders that used 'Cash' as the payment type.
SELECT * FROM sales
WHERE payment_type = 'Cash';

-- 20. List the most recent 5 orders overall.
SELECT order_id, customer_id, product_name, order_date
FROM sales ORDER BY order_date DESC
LIMIT 5;
