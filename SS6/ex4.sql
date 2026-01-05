CREATE DATABASE ecommerce_report;
USE ecommerce_report;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    price DECIMAL(10,2)
);

CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO products (product_id, product_name, price) VALUES
(1, 'Chuột Logitech', 500000),
(2, 'Bàn phím cơ', 1200000),
(3, 'Tai nghe Bluetooth', 900000),
(4, 'Ổ cứng SSD 256GB', 2500000),
(5, 'Màn hình Samsung', 3500000);

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(101, 1, 10),
(102, 2, 5),
(103, 3, 8),
(104, 4, 4),
(105, 5, 3),
(106, 2, 6),
(107, 4, 5);

SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name;

SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity * p.price) AS revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name;

SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity * p.price) AS revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
HAVING SUM(oi.quantity * p.price) > 5000000;
