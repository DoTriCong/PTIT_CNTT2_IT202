CREATE DATABASE school_db;
USE school_db;

CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    email VARCHAR(100) UNIQUE
);

INSERT INTO Student (student_id, full_name, date_of_birth, email) VALUES
(1, 'Nguyen Van A', '2002-01-15', 'a@gmail.com'),
(2, 'Tran Thi B', '2001-05-20', 'b@gmail.com'),
(3, 'Le Van C', '2000-09-10', 'c@gmail.com'),
(5, 'Pham Van D', '2003-03-25', 'd@gmail.com');

UPDATE Student
SET email = 'c_new@gmail.com'
WHERE student_id = 3;

UPDATE Student
SET date_of_birth = '2001-06-01'
WHERE student_id = 2;

DELETE FROM Student
WHERE student_id = 5;

SELECT * FROM Student;
