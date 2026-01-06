CREATE DATABASE ecommerce_avg_customer;
USE ecommerce_avg_customer;

CREATE TABLE orders (
    id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2)
);

INSERT INTO orders (id, customer_id, order_date, total_amount) VALUES
(101, 1, '2025-01-01', 3000000),
(102, 1, '2025-01-05', 4500000),
(103, 2, '2025-01-03', 2500000),
(104, 2, '2025-01-07', 3500000),
(105, 3, '2025-01-10', 6000000),
(106, 3, '2025-01-12', 4000000),
(107, 4, '2025-01-15', 1500000),
(108, 5, '2025-01-18', 8000000);

SELECT
    customer_id,
    SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
HAVING SUM(total_amount) > (
    SELECT AVG(customer_total)
    FROM (
        SELECT SUM(total_amount) AS customer_total
        FROM orders
        GROUP BY customer_id
    ) AS temp
);
