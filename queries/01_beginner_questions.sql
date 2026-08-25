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
