CREATE DATABASE ecommerce_orders_avg;
USE ecommerce_orders_avg;

CREATE TABLE orders (
    id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2)
);

INSERT INTO orders (id, customer_id, order_date, total_amount) VALUES
(101, 1, '2025-01-01', 3000000),
(102, 2, '2025-01-03', 5000000),
(103, 3, '2025-01-05', 2000000),
(104, 4, '2025-01-07', 8000000),
(105, 5, '2025-01-10', 4500000),
(106, 6, '2025-01-12', 6000000);

SELECT
    id,
    customer_id,
    order_date,
    total_amount
FROM orders
WHERE total_amount > (
    SELECT AVG(total_amount)
    FROM orders
);
