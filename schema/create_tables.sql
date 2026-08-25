-- E-Commerce Sales & Customer Analytics
-- Database schema

CREATE DATABASE IF NOT EXISTS ecommerce_project;
USE ecommerce_project;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    signup_date DATE
);

CREATE TABLE sales (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    category VARCHAR(50),
    product_name VARCHAR(100),
    quantity INT,
    unit_price DECIMAL(10,2),
    payment_type VARCHAR(30),
    status VARCHAR(20),
    revenue DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
