USE school_db;

DROP TABLE IF EXISTS Score;

CREATE TABLE Score (
  student_id INT,
  subject_id INT,
  mid_score DECIMAL(3,1) CHECK (mid_score BETWEEN 0 AND 10),
  final_score DECIMAL(3,1) CHECK (final_score BETWEEN 0 AND 10),
  PRIMARY KEY (student_id, subject_id),
  FOREIGN KEY (student_id) REFERENCES Student(student_id),
  FOREIGN KEY (subject_id) REFERENCES Subject(subject_id)
);

INSERT INTO Score (student_id, subject_id, mid_score, final_score) VALUES
(1, 101, 7.5, 8.0),
(2, 101, 6.0, 7.0),
(1, 102, 8.0, 9.0);

UPDATE Score
SET final_score = 9.5
WHERE student_id = 2 AND subject_id = 101;

SELECT * FROM Score;

SELECT *
FROM Score
WHERE final_score >= 8;
