CREATE DATABASE ecommerce_product_sale;
USE ecommerce_product_sale;

CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    price DECIMAL(10,2)
);

CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT
);

INSERT INTO products (id, name, price) VALUES
(1, 'Chuột Logitech', 500000),
(2, 'Bàn phím cơ', 1200000),
(3, 'Tai nghe Bluetooth', 900000),
(4, 'Ổ cứng SSD', 2500000),
(5, 'Màn hình Samsung', 3500000);

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(101, 1, 5),
(102, 2, 3),
(103, 1, 4),
(104, 4, 2),
(105, 5, 6);

SELECT
    id,
    name,
    price
FROM products
WHERE id IN (
    SELECT product_id
    FROM order_items
);
