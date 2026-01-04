CREATE DATABASE ecommerce;
USE ecommerce;

CREATE TABLE Product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2),
    stock INT,
    status ENUM('active', 'inactive')
);

INSERT INTO Product (product_id, product_name, price, stock, status) VALUES
(1, 'Laptop Dell', 15000000, 10, 'active'),
(2, 'Chuột Logitech', 500000, 50, 'active'),
(3, 'Bàn phím cơ', 1200000, 30, 'active'),
(4, 'Màn hình Samsung', 3500000, 15, 'inactive'),
(5, 'Tai nghe Bluetooth', 900000, 40, 'inactive');

SELECT * FROM Product;

SELECT *
FROM Product
WHERE status = 'active';

SELECT *
FROM Product
WHERE price > 1000000;

SELECT *
FROM Product
WHERE status = 'active'
ORDER BY price ASC;
