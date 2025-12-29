USE school_db;

INSERT INTO Student (student_id, full_name, date_of_birth, email)
VALUES (6, 'Nguyen Van Moi', '2004-08-20', 'moi.nguyen@gmail.com');

INSERT INTO Enrollment (student_id, subject_id, enroll_date)
VALUES 
(6, 101, '2024-09-10'),
(6, 102, '2024-09-10');

INSERT INTO Score (student_id, subject_id, mid_score, final_score)
VALUES 
(6, 101, 7.5, 8.0),
(6, 102, 6.5, 7.0);

UPDATE Score
SET final_score = 8.5
WHERE student_id = 6 AND subject_id = 102;

DELETE FROM Enrollment
WHERE student_id = 6 AND subject_id = 101;

SELECT s.student_id, s.full_name, sub.subject_name, sc.mid_score, sc.final_score
FROM Student s
JOIN Score sc ON s.student_id = sc.student_id
JOIN Subject sub ON sc.subject_id = sub.subject_id;
