CREATE DATABASE admin_order_db;
USE admin_order_db;

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    total_amount DECIMAL(10,2),
    order_date DATE,
    status ENUM('pending', 'completed', 'cancelled')
);

INSERT INTO orders (order_id, customer_id, total_amount, order_date, status) VALUES
(1, 101, 3000000, '2025-01-01', 'completed'),
(2, 102, 7000000, '2025-01-02', 'pending'),
(3, 103, 12000000, '2025-01-03', 'completed'),
(4, 104, 4500000, '2025-01-04', 'cancelled'),
(5, 105, 9000000, '2025-01-05', 'completed'),
(6, 106, 2000000, '2025-01-06', 'pending'),
(7, 107, 15000000, '2025-01-07', 'completed'),
(8, 108, 6000000, '2025-01-08', 'pending'),
(9, 109, 8000000, '2025-01-09', 'completed'),
(10, 110, 4000000, '2025-01-10', 'completed'),
(11, 111, 5000000, '2025-01-11', 'pending'),
(12, 112, 9500000, '2025-01-12', 'completed'),
(13, 113, 3500000, '2025-01-13', 'pending'),
(14, 114, 11000000, '2025-01-14', 'completed'),
(15, 115, 2500000, '2025-01-15', 'completed'),
(16, 116, 7800000, '2025-01-16', 'cancelled'),
(17, 117, 6600000, '2025-01-17', 'completed'),
(18, 118, 8800000, '2025-01-18', 'pending');

SELECT *
FROM orders
WHERE status <> 'cancelled'
ORDER BY order_date DESC
LIMIT 5 OFFSET 0;

SELECT *
FROM orders
WHERE status <> 'cancelled'
ORDER BY order_date DESC
LIMIT 5 OFFSET 5;

SELECT *
FROM orders
WHERE status <> 'cancelled'
ORDER BY order_date DESC
LIMIT 5 OFFSET 10;
