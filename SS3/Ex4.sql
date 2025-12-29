USE school_db;

DROP TABLE IF EXISTS Enrollment;
DROP TABLE IF EXISTS Subject;
DROP TABLE IF EXISTS Student;

CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    email VARCHAR(100) UNIQUE
);

INSERT INTO Student VALUES
(1, 'Nguyen Van A', '2003-05-10', 'a@gmail.com'),
(2, 'Tran Thi B', '2002-08-20', 'b@gmail.com'),
(3, 'Le Van C', '2003-12-15', 'c@gmail.com');

CREATE TABLE Subject (
    subject_id INT PRIMARY KEY,
    subject_name VARCHAR(100),
    credit INT CHECK (credit > 0)
);

INSERT INTO Subject VALUES
(101, 'Database Systems', 3),
(102, 'Web Programming', 4),
(103, 'Operating Systems', 3);

UPDATE Subject SET credit = 5 WHERE subject_id = 102;
UPDATE Subject SET subject_name = 'Advanced Database' WHERE subject_id = 101;

CREATE TABLE Enrollment (
    student_id INT,
    subject_id INT,
    enroll_date DATE,
    PRIMARY KEY (student_id, subject_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (subject_id) REFERENCES Subject(subject_id)
);

INSERT INTO Enrollment VALUES
(1, 101, '2024-09-01'),
(1, 102, '2024-09-02'),
(2, 101, '2024-09-01');

SELECT * FROM Enrollment;
SELECT * FROM Enrollment WHERE student_id = 1;
