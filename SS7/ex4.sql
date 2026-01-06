CREATE DATABASE ecommerce_subquery_select_demo;
USE ecommerce_subquery_select_demo;

CREATE TABLE customers (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255)
);

CREATE TABLE orders (
    id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2)
);

INSERT INTO customers (id, name, email) VALUES
(1, 'Nguyen Van A', 'a@gmail.com'),
(2, 'Tran Thi B', 'b@gmail.com'),
(3, 'Le Van C', 'c@gmail.com'),
(4, 'Pham Thi D', 'd@gmail.com'),
(5, 'Hoang Van E', 'e@gmail.com');

INSERT INTO orders (id, customer_id, order_date, total_amount) VALUES
(101, 1, '2025-01-01', 3000000),
(102, 1, '2025-01-05', 4500000),
(103, 2, '2025-01-03', 2500000),
(104, 3, '2025-01-07', 6000000),
(105, 3, '2025-01-10', 3500000),
(106, 5, '2025-01-12', 1500000),
(107, 5, '2025-01-15', 2200000);

SELECT
    name,
    (
        SELECT COUNT(*)
        FROM orders
        WHERE orders.customer_id = customers.id
    ) AS total_orders
FROM customers;
