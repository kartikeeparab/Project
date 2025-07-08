#create a database
CREATE DATABASE StudentResult_DB;
USE StudentResult_DB;

# create table student
CREATE TABLE Students(
 StudentID INT AUTO_iNCREMENT PRIMARY KEY,
 Name VARCHAR(50) NOT NULL,
 Email VARCHAR(50) Unique
);

#create table course
CREATE TABLE Courses (
    CourseID INT AUTO_INCREMENT PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    Credits INT NOT NULL
);

#Create table semesters
CREATE TABLE Semesters (
    SemesterID INT AUTO_INCREMENT PRIMARY KEY,
    SemesterName VARCHAR(50) NOT NULL,
    Year INT NOT NULL
);

#Create table grades
CREATE TABLE Grades (
    GradeID INT AUTO_INCREMENT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    SemesterID INT,
    Marks DECIMAL(5,2),
    Grade CHAR(2),
    GPA DECIMAL(3,2),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
    FOREIGN KEY (SemesterID) REFERENCES Semesters(SemesterID)
);

# Insert 10 Students
INSERT INTO Students (Name, Email) VALUES
('Kartikee Parab', 'kartikee@gmail.com'),
('Swati Shah', 'swati@gmail.com'),
('Hardik Joshi', 'hardik@gmail.com'),
('Riya Mehra', 'riya@gmail.com'),
('Aman Verma', 'aman@gmail.com'),
('Neha Sharma', 'neha.sharma@gmail.com'),
('Rahul Kapoor', 'rahul.kapoor@gmail.com'),
('Ishita Rao', 'ishita.rao@gmail.com'),
('Vivek Singh', 'vivek.singh@gmail.com'),
('Anjali Desai', 'anjali.desai@gmail.com');

select * from Students;

#Insert 4 Courses with Credits
INSERT INTO Courses (CourseName, Credits) VALUES
('SQL Fundamentals', 3),
('Data Structures', 4),
('Operating Systems', 3),
('Python Programming', 4),
('Computer Networks', 3);

select * from Courses;

 # Insert 2 Semesters
INSERT INTO Semesters (SemesterName, Year) VALUES
('Semester 1', 2024),
('Semester 2', 2024);

select * from Semesters;

# Insert Grades for 10 students across different courses and semesters
INSERT INTO Grades (StudentID, CourseID, SemesterID, Marks, Grade, GPA) VALUES
(1, 1, 1, 88.5, 'A', 4.00),
(1, 2, 1, 76.0, 'B', 3.00),
(2, 2, 1, 69.5, 'C', 2.00),
(2, 3, 1, 82.0, 'B', 3.00),
(3, 1, 1, 91.0, 'A', 4.00),
(3, 4, 2, 78.0, 'B', 3.00),
(4, 1, 2, 65.0, 'C', 2.00),
(4, 5, 2, 54.5, 'D', 1.00),
(5, 3, 1, 80.0, 'B', 3.00),
(5, 4, 1, 90.0, 'A', 4.00),
(6, 2, 2, 45.0, 'F', 0.00),
(6, 3, 2, 51.0, 'D', 1.00),
(7, 4, 1, 84.5, 'A', 4.00),
(7, 1, 2, 78.0, 'B', 3.00),
(8, 2, 2, 61.0, 'C', 2.00),
(8, 5, 1, 88.0, 'A', 4.00),
(9, 1, 1, 40.0, 'F', 0.00),
(9, 2, 1, 68.0, 'C', 2.00),
(10, 3, 2, 93.0, 'A', 4.00),
(10, 4, 2, 87.0, 'A', 4.00);

SELECT * FROM grades;

# Show Each Student’s GPA
SELECT 
    StudentID,
    ROUND(AVG(GPA), 2) AS OverallGPA
FROM Grades
GROUP BY StudentID;

# Show Pass or Fail for Each Student’s Subject
SELECT 
    StudentID,
    CourseID,
    Marks,
    CASE 
        WHEN Marks >= 40 THEN 'Pass'
        ELSE 'Fail'
    END AS Result
FROM Grades;

# List of Students Who Passed All Subjects

SELECT 
    StudentID
FROM Grades
GROUP BY StudentID
HAVING MIN(Marks) >= 60;

#  Students by GPA

SELECT 
    StudentID,
    ROUND(AVG(GPA), 2) AS AvgGPA,
    RANK() OVER (ORDER BY AVG(GPA) DESC) AS RankNo
FROM Grades
GROUP BY StudentID;

# GPA by Semester (Simplified)
SELECT 
    StudentID,
    SemesterID,
    ROUND(AVG(GPA), 2) AS SemesterGPA
FROM Grades
GROUP BY StudentID, SemesterID;

 # Simple View to See Full Results
CREATE VIEW StudentFullResult AS
SELECT 
    g.StudentID,
    g.CourseID,
    g.Marks,
    g.Grade,
    g.GPA
FROM Grades g;

SELECT * FROM StudentFullResult;

USE StudentResult_DB;

'''MySQL runs queries line-by-line. But in triggers, we need multiple semicolons inside one statement. So we say:

Temporarily change the delimiter to $$

End the trigger with END$$

Reset it back to normal with DELIMITER ;'''

# Auto set the  Grade and  GPA based on Marks
DELIMITER $$

CREATE TRIGGER trg_auto_calculate_gpa
BEFORE INSERT ON Grades
FOR EACH ROW
BEGIN
  IF NEW.Marks >= 85 THEN
    SET NEW.Grade = 'A';
    SET NEW.GPA = 4.0;
  ELSEIF NEW.Marks >= 70 THEN
    SET NEW.Grade = 'B';
    SET NEW.GPA = 3.0;
  ELSEIF NEW.Marks >= 60 THEN
    SET NEW.Grade = 'C';
    SET NEW.GPA = 2.0;
  ELSEIF NEW.Marks >= 50 THEN
    SET NEW.Grade = 'D';
    SET NEW.GPA = 1.0;
  ELSE
    SET NEW.Grade = 'F';
    SET NEW.GPA = 0.0;
  END IF;
END$$

DELIMITER ;

#checking dlimiter works properly or not
INSERT INTO Grades (StudentID, CourseID, SemesterID, Marks)
VALUES (2, 3, 2, 74);

SELECT * FROM Grades
WHERE StudentID = 2 AND CourseID = 3 AND SemesterID = 2;

# Only GPA by Semester
CREATE VIEW SemesterGPAView AS
SELECT 
    StudentID,
    SemesterID,
    ROUND(AVG(GPA), 2) AS SemesterGPA
FROM Grades
GROUP BY StudentID, SemesterID;


SELECT * FROM SemesterGPAView;

# semester wise topper using a rank 
CREATE VIEW SemesterTopperView AS
SELECT 
    StudentID,
    SemesterID,
    ROUND(AVG(GPA), 2) AS SemesterGPA,
    RANK() OVER (PARTITION BY SemesterID ORDER BY AVG(GPA) DESC) AS RankInSemester
FROM Grades
GROUP BY StudentID, SemesterID;

SELECT * FROM SemesterTopperView;

# View foe failded students 
CREATE VIEW FailedSubjects AS
SELECT 
    StudentID,
    CourseID,
    Marks,
    Grade
FROM Grades
WHERE Marks <= 45;

SELECT * FROM FailedSubjects;

# Create an AllStudentsSummaryView 
CREATE VIEW AllStudentsSummaryView AS
SELECT 
    Grades.StudentID,
    Students.Name,
    ROUND(AVG(Grades.GPA), 2) AS OverallGPA,
    COUNT(Grades.CourseID) AS TotalSubjects,
    COUNT(CASE WHEN Grades.Marks < 50 THEN 1 END) AS FailedSubjects
FROM Grades
JOIN Students ON Grades.StudentID = Students.StudentID
GROUP BY Grades.StudentID;

SELECT * FROM AllStudentsSummaryView; 