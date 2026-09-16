-- ============================================================================
-- CHAPTER 3 — SQL Command Categories
-- ============================================================================
-- Demonstrates the five SQL command categories taught in the notes:
-- DDL, DML, DQL, DCL and TCL.
-- DCL examples are commented because GRANT/REVOKE require suitable privileges.
-- ============================================================================

CREATE DATABASE IF NOT EXISTS command_categories_db;
USE command_categories_db;

-- ============================================================================
-- 3.1 DDL — Data Definition Language
-- ============================================================================
CREATE TABLE IF NOT EXISTS students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    branch VARCHAR(20)
);

ALTER TABLE students ADD COLUMN score INT;

-- RENAME / DROP examples are shown as comments so the main table remains usable.
-- RENAME TABLE students TO student_records;
-- ALTER TABLE students DROP COLUMN score;

-- ============================================================================
-- 3.2 DML — Data Manipulation Language
-- ============================================================================
INSERT INTO students (student_id, student_name, branch, score)
VALUES
    (101, 'Asha', 'CSE', 88),
    (102, 'Amit', 'ECE', 81);

UPDATE students
SET score = 90
WHERE student_id = 101;

DELETE FROM students
WHERE student_id = 102;

-- ============================================================================
-- 3.3 DQL — Data Query Language
-- ============================================================================
SELECT student_id, student_name, branch, score
FROM students;

-- ============================================================================
-- 3.4 DCL — Data Control Language
-- ============================================================================
-- Replace 'app_user' with an actual MySQL account before running.
-- GRANT SELECT ON command_categories_db.students TO 'app_user'@'localhost';
-- REVOKE SELECT ON command_categories_db.students FROM 'app_user'@'localhost';

-- ============================================================================
-- 3.5 TCL — Transaction Control Language
-- ============================================================================
START TRANSACTION;

UPDATE students
SET score = score + 5
WHERE student_id = 101;

-- Check the uncommitted change.
SELECT * FROM students WHERE student_id = 101;

-- Undo the transaction.
ROLLBACK;

-- Start another transaction and save it.
START TRANSACTION;

UPDATE students
SET score = score + 2
WHERE student_id = 101;

COMMIT;

SELECT * FROM students WHERE student_id = 101;
