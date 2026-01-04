CREATE DATABASE ecommerce_search;
USE ecommerce_search;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2),
    stock INT,
    status ENUM('active', 'inactive')
);

INSERT INTO products (product_id, product_name, price, stock, status) VALUES
(1, 'Chuột Logitech', 500000, 100, 'active'),
(2, 'Bàn phím cơ', 1200000, 50, 'active'),
(3, 'Tai nghe Bluetooth', 900000, 80, 'active'),
(4, 'Loa Bluetooth', 1500000, 60, 'active'),
(5, 'USB 32GB', 300000, 200, 'active'),
(6, 'Ổ cứng SSD 256GB', 2500000, 30, 'active'),
(7, 'Ổ cứng SSD 512GB', 3200000, 25, 'active'),
(8, 'Webcam Logitech', 1800000, 40, 'active'),
(9, 'Bàn phím thường', 700000, 70, 'inactive'),
(10, 'Tai nghe gaming', 2200000, 35, 'active'),
(11, 'Chuột gaming', 1300000, 55, 'active'),
(12, 'Thẻ nhớ 64GB', 600000, 150, 'active'),
(13, 'Cáp sạc nhanh', 200000, 300, 'active'),
(14, 'Pin sạc dự phòng', 1900000, 45, 'active'),
(15, 'Giá đỡ laptop', 1100000, 65, 'active'),
(16, 'Ổ cứng HDD 1TB', 2800000, 20, 'active');

SELECT *
FROM products
WHERE status = 'active'
  AND price BETWEEN 1000000 AND 3000000
ORDER BY price ASC
LIMIT 10 OFFSET 0;

SELECT *
FROM products
WHERE status = 'active'
  AND price BETWEEN 1000000 AND 3000000
ORDER BY price ASC
LIMIT 10 OFFSET 10;
