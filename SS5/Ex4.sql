CREATE DATABASE products_db;
USE products_db;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2),
    stock INT,
    sold_quantity INT,
    status ENUM('active', 'inactive')
);

INSERT INTO products (product_id, product_name, price, stock, sold_quantity, status) VALUES
(1, 'Laptop Dell', 15000000, 10, 120, 'active'),
(2, 'Laptop HP', 14000000, 8, 95, 'active'),
(3, 'Dien thoai Samsung', 8000000, 20, 200, 'active'),
(4, 'Dien thoai Xiaomi', 6000000, 25, 180, 'active'),
(5, 'Tai nghe Bluetooth', 900000, 50, 300, 'active'),
(6, 'Chuột Logitech', 500000, 100, 250, 'active'),
(7, 'Ban phim co', 1200000, 40, 160, 'active'),
(8, 'Man hinh Samsung', 3500000, 15, 140, 'inactive'),
(9, 'USB 32GB', 300000, 200, 400, 'active'),
(10, 'SSD 512GB', 2500000, 30, 170, 'active'),
(11, 'Webcam Logitech', 1800000, 25, 130, 'active'),
(12, 'Loa Bluetooth', 1600000, 35, 155, 'active');

SELECT *
FROM products
ORDER BY sold_quantity DESC
LIMIT 10;

SELECT *
FROM products
ORDER BY sold_quantity DESC
LIMIT 5 OFFSET 10;

SELECT *
FROM products
WHERE price < 2000000
ORDER BY sold_quantity DESC;
