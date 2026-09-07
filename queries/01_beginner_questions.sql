CREATE DATABASE ecommerce_project;
USE ecommerce_project;
SHOW TABLES;
DESC customers;
DESC sales;
UPDATE customers SET order_date =str_to_date(order_date,'d-m-Y');
UPDATE customers SET signup_date =str_to_date(signup_date,'d-m-Y');
ALTER TABLE customers MODIFY signup_date date;
ALTER TABLE sales MODIFY order_date date;
SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM sales;
-- 1. List all customers from a specific city.
SELECT * FROM customers WHERE city='Mumbai'; 
-- 2. Show all orders placed in the last 30 days.
SELECT MAX(order_date) FROM sales; 
SELECT * FROM sales WHERE order_date >= '2025-07-21';
-- 3. Find the 10 most expensive products.
SELECT product_name , unit_price FROM  sales ORDER BY unit_price desc LIMIT 10;
-- 4. List all orders with status = 'delivered'. 
SELECT * FROM sales WHERE status='Delivered';
-- 5. Find customers who signed up in 2025.
SELECT * FROM customers WHERE signup_date BETWEEN '2025-01-01' AND '2025-12-31'ORDER BY signup_date;

-- 1. List all distinct product categories.
SELECT DISTINCT category FROM sales;
 -- 2. Find all orders with quantity greater than 5.
SELECT * FROM sales WHERE quantity > 5;
 -- 3. Display customer names and their signup dates, sorted oldest first.
SELECT customer_name, signup_date FROM customers ORDER BY signup_date ASC;
 -- 4. List all sales records where payment_type is 'Credit Card'.
SELECT * FROM sales WHERE payment_type = 'Credit Card';
 -- 5. Find the total number of customers.
SELECT COUNT(*) AS total_customers FROM customers;
 -- 6. List all orders placed on a specific date.
SELECT * FROM sales WHERE order_date = '2025-07-01';
 -- 7. Display all products priced above 1000.
SELECT product_name, unit_price FROM sales WHERE unit_price > 1000;
 -- 8. Find customers whose city is not Mumbai.
SELECT * FROM customers WHERE city <> 'Mumbai';
 -- 9. List all orders with quantity between 1 and 3.
SELECT * FROM sales WHERE quantity BETWEEN 1 AND 3;
 -- 10. Show the earliest order date in the sales table.
SELECT MIN(order_date) AS earliest_order FROM sales;
 -- 11. Find all distinct payment types used.
SELECT DISTINCT payment_type FROM sales;
 -- 12. List all orders where the product name contains 'Pan'.
SELECT * FROM sales WHERE product_name LIKE '%Pan%';
 -- 13. Display the 5 cheapest products.
SELECT product_name, unit_price FROM sales ORDER BY unit_price ASC LIMIT 5;
 -- 14. Count the total number of orders.
SELECT COUNT(*) AS total_orders FROM sales;
 -- 15. List all customers ordered alphabetically by name.
SELECT * FROM customers ORDER BY customer_name ASC;
-- 16. Find orders with status = 'Cancelled'.
SELECT * FROM sales WHERE status = 'Cancelled';
 -- 17. Display all sales made in the year 2024.
SELECT * FROM sales WHERE YEAR(order_date) = 2024;
 -- 18. List customer_id and city for all customers.
SELECT customer_id, city FROM customers;
 -- 19. Find the number of distinct customers who placed orders.
SELECT COUNT(DISTINCT customer_id) AS distinct_customers FROM sales;
 -- 20. Show all columns from sales table for order_id = 101.
SELECT * FROM sales WHERE order_id = 101;
 
