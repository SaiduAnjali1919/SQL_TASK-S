USE StudentDB;

CREATE TABLE StudentsData
(
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT
);

CREATE TABLE StudentsMarks
(
    StudentID INT,
    Subject VARCHAR(50),
    Marks INT,
    FOREIGN KEY (StudentID)
    REFERENCES StudentsData(StudentID)
);

show tables;

DESC StudentsData;
DESC StudentsMarks;

INSERT INTO StudentsData
VALUES
(101, 'Monika', 21),
(102, 'Vedha', 22),
(103, 'Sravya', 20);

SELECT * FROM StudentsData;

INSERT INTO StudentsMarks
VALUES
(101, 'SQL', 95),
(102, 'Python', 88),
(103, 'Java', 91);

SELECT * FROM StudentsMarks;

SELECT
    StudentsData.StudentID,
    StudentsData.Name,
    StudentsMarks.Subject,
    StudentsMarks.Marks
FROM StudentsData
INNER JOIN StudentsMarks
ON StudentsData.StudentID = StudentsMarks.StudentID;