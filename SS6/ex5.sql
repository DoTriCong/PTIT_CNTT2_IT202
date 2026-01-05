CREATE DATABASE vip_customer_db;
USE vip_customer_db;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    full_name VARCHAR(255),
    city VARCHAR(255)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    status ENUM('completed', 'pending', 'cancelled'),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (customer_id, full_name, city) VALUES
(1, 'Nguyen Van An', 'Ha Noi'),
(2, 'Tran Thi Binh', 'TP.HCM'),
(3, 'Le Van Cuong', 'Da Nang'),
(4, 'Pham Thi Dao', 'Ha Noi'),
(5, 'Hoang Van Em', 'Can Tho');

INSERT INTO orders (order_id, customer_id, order_date, total_amount, status) VALUES
(101, 1, '2025-01-01', 3000000, 'completed'),
(102, 1, '2025-01-05', 4500000, 'completed'),
(103, 1, '2025-01-10', 5000000, 'completed'),

(104, 2, '2025-01-03', 2000000, 'completed'),
(105, 2, '2025-01-07', 2500000, 'completed'),

(106, 3, '2025-01-04', 4000000, 'completed'),
(107, 3, '2025-01-08', 3500000, 'completed'),
(108, 3, '2025-01-12', 3800000, 'completed'),

(109, 4, '2025-01-06', 1500000, 'completed'),

(110, 5, '2025-01-02', 6000000, 'completed'),
(111, 5, '2025-01-09', 5500000, 'completed'),
(112, 5, '2025-01-15', 3000000, 'completed');

SELECT
    c.customer_id,
    c.full_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_spent,
    AVG(o.total_amount) AS avg_order_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.status = 'completed'
GROUP BY c.customer_id, c.full_name
HAVING COUNT(o.order_id) >= 3
   AND SUM(o.total_amount) > 10000000
ORDER BY total_spent DESC;
