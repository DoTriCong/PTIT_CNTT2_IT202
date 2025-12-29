CREATE DATABASE IF NOT EXISTS school_db;
USE school_db;

DROP TABLE IF EXISTS Subject;

CREATE TABLE Subject (
    subject_id INT PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL,
    credit INT CHECK (credit > 0)
);

INSERT INTO Subject (subject_id, subject_name, credit) VALUES
(1, 'Toán học', 3),
(2, 'Lập trình C', 4),
(3, 'Cơ sở dữ liệu', 3);

UPDATE Subject
SET credit = 5
WHERE subject_id = 2;

UPDATE Subject
SET subject_name = 'Lập trình C nâng cao'
WHERE subject_id = 2;

SELECT * FROM Subject;
