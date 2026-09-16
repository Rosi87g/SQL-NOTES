-- ============================================================================
-- CHAPTER 9 — DML: Managing Data (INSERT, UPDATE, DELETE)
-- ============================================================================
-- Purpose : One running "students" table used to demonstrate every DML
--           command from the notes — inserting single and multiple
--           records, updating single/multiple columns and calculated
--           values, and deleting single and multiple rows.
--           This is the same table used as the worked example in the
--           notes document (Chapter 9), so the notes and this script
--           read side by side without any mismatch.
-- Source  : Rewritten and merged from practice.sql (ALTER + repeated
--           UPDATE pattern) and student_structure_db.sql (DELETE ...
--           WHERE ... IN pattern).
-- ============================================================================
CREATE DATABASE IF NOT EXISTS training_db;
USE training_db;

CREATE TABLE IF NOT EXISTS students (
    student_id   INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(60) NOT NULL,
    branch       VARCHAR(30) NOT NULL,
    cgpa         DECIMAL(4,2),
    email        VARCHAR(100) UNIQUE,
    joining_date DATE NOT NULL
);
-- ============================================================================
-- 9.1 INSERT — adding records
-- ============================================================================

-- Insert one complete record (all columns, in table order)
INSERT INTO students
VALUES (101, 'Asha Patil', 'CSE', 8.45, 'asha@gmail.com', '2026-09-07');

-- Insert another single record
INSERT INTO students
VALUES (102, 'Ravi Kumar', 'ECE', 7.90, 'ravi@gmail.com', '2026-09-07');
-- Insert MULTIPLE records in one statement (bulk entry)
INSERT INTO students (student_id, student_name, branch, cgpa, email, joining_date)
VALUES
    (103, 'Zoya Khan', 'CSE', 8.10, 'zoya@gmail.com', '2026-09-07'),
    (104, 'Kabir Rao', 'ECE', 7.55, 'kabir@gmail.com', '2026-09-07');

-- Verify everything inserted so far
SELECT * FROM students;
-- ============================================================================
-- 9.2 UPDATE — modifying existing records
-- ============================================================================

-- Correct a single value
UPDATE students
SET cgpa = 8.75
WHERE student_id = 101;

-- Update the same row again (shows the value change, then change back —
-- useful for seeing UPDATE take effect immediately on re-SELECT)
UPDATE students
SET cgpa = 8.60
WHERE student_id = 101;
-- Update multiple columns for one row in a single statement
UPDATE students
SET branch = 'ISE', cgpa = 8.90
WHERE student_id = 103;

-- Update using a calculation based on the column's current value
UPDATE students
SET cgpa = cgpa + 0.10
WHERE student_id = 102;

-- Verify the changes
SELECT * FROM students;

-- ============================================================================
-- 9.3 DELETE — removing records
-- ============================================================================
-- Insert a few temporary/placeholder rows just so we have
-- something realistic to delete below
INSERT INTO students (student_id, student_name, branch, cgpa, email, joining_date)
VALUES
    (105, 'Temp Record A', 'CSE', NULL, 'tempA@gmail.com', '2026-09-08'),
    (106, 'Temp Record B', 'CSE', NULL, 'tempB@gmail.com', '2026-09-08'),
    (107, 'Temp Record C', 'CSE', NULL, 'tempC@gmail.com', '2026-09-08');

SELECT * FROM students;
-- Delete a single row by its primary key
DELETE FROM students
WHERE student_id = 107;

-- Delete multiple rows at once using WHERE ... IN (...)
DELETE FROM students
WHERE student_id IN (105, 106);

-- Final verification — only the real student records remain
SELECT * FROM students;
DESCRIBE students;
