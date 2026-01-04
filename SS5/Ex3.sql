CREATE DATABASE order_db;
USE order_db;

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    total_amount DECIMAL(10,2),
    order_date DATE,
    status ENUM('pending', 'completed', 'cancelled')
);

INSERT INTO orders (order_id, customer_id, total_amount, order_date, status) VALUES
(1, 101, 3000000, '2025-01-01', 'completed'),
(2, 102, 7000000, '2025-01-03', 'pending'),
(3, 103, 12000000, '2025-01-05', 'completed'),
(4, 104, 4500000, '2025-01-06', 'cancelled'),
(5, 105, 9000000, '2025-01-07', 'completed'),
(6, 106, 2000000, '2025-01-08', 'pending'),
(7, 107, 15000000, '2025-01-09', 'completed');

SELECT *
FROM orders
WHERE status = 'completed';

SELECT *
FROM orders
WHERE total_amount > 5000000;

SELECT *
FROM orders
ORDER BY order_date DESC
LIMIT 5;

SELECT *
FROM orders
WHERE status = 'completed'
ORDER BY total_amount DESC;
