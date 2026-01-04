CREATE DATABASE customer_db;
USE customer_db;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    city VARCHAR(255),
    status ENUM('active', 'inactive')
);

INSERT INTO customers (customer_id, full_name, email, city, status) VALUES
(1, 'Nguyen Van An', 'an@gmail.com', 'TP.HCM', 'active'),
(2, 'Tran Thi Binh', 'binh@gmail.com', 'Ha Noi', 'active'),
(3, 'Le Van Cuong', 'cuong@gmail.com', 'TP.HCM', 'inactive'),
(4, 'Pham Thi Dao', 'dao@gmail.com', 'Da Nang', 'active'),
(5, 'Hoang Van Em', 'em@gmail.com', 'Ha Noi', 'inactive');

SELECT * FROM customers;

SELECT *
FROM customers
WHERE city = 'TP.HCM';

SELECT *
FROM customers
WHERE status = 'active' AND city = 'Ha Noi';

SELECT *
FROM customers
ORDER BY full_name ASC;
