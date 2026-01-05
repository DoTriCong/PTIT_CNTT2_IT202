CREATE DATABASE revenue_db;
USE revenue_db;

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    total_amount DECIMAL(10,2)
);

INSERT INTO orders (order_id, order_date, total_amount) VALUES
(1, '2025-01-01', 3000000),
(2, '2025-01-01', 4500000),
(3, '2025-01-02', 7000000),
(4, '2025-01-02', 5000000),
(5, '2025-01-03', 12000000),
(6, '2025-01-03', 3000000),
(7, '2025-01-04', 8000000),
(8, '2025-01-04', 4000000),
(9, '2025-01-05', 15000000);

SELECT
    order_date,
    SUM(total_amount) AS total_revenue
FROM orders
GROUP BY order_date;

SELECT
    order_date,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY order_date;

SELECT
    order_date,
    SUM(total_amount) AS total_revenue
FROM orders
GROUP BY order_date
HAVING SUM(total_amount) > 10000000;
