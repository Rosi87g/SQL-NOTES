-- ============================================================================
-- CHAPTER 4 — Database, Schema, Table, Row and Column
-- ============================================================================
-- Purpose : One database holding TWO related tables, so you can see the
--           full hierarchy in action:
--           MySQL Server -> Database -> Table -> Rows & Columns -> Values
-- Source  : Rewritten and expanded from course_lab.sql
--           (original had empty tables — sample rows were added below so
--           the row / column / value concepts have real data to point at).
-- ============================================================================
CREATE DATABASE IF NOT EXISTS course_lab_db;
USE course_lab_db;

-- Table 1: student — one entity (a student) per row
CREATE TABLE IF NOT EXISTS student (
    student_id   INT,
    student_name VARCHAR(50),
    city         VARCHAR(30)
);

-- Table 2: course — a second, independent entity in the SAME database
CREATE TABLE IF NOT EXISTS course (
    course_id       INT,
    course_name     VARCHAR(50),
    duration_weeks  INT
);
-- ----------------------------------------------------------------------------
-- Add sample rows so ROW / COLUMN / VALUE are easy to point at
-- ----------------------------------------------------------------------------

INSERT INTO student (student_id, student_name, city)
VALUES
    (101, 'Aarav', 'Bengaluru'),
    (102, 'Bhavna', 'Pune'),
    (103, 'Charan', 'Hyderabad');

INSERT INTO course (course_id, course_name, duration_weeks)
VALUES
    (1, 'SQL', 6),
    (2, 'Python', 8);
-- ----------------------------------------------------------------------------
-- Explore the structure — this is exactly what a "schema" describes:
-- which tables exist, and what columns/types each one contains.
-- ----------------------------------------------------------------------------

-- See every database on the server (CollegeManagement-style container concept)
SHOW DATABASES;

-- See every table inside THIS database (course_lab_db)
SHOW TABLES;
-- Column structure of each table
DESCRIBE student;
DESC course;

-- ----------------------------------------------------------------------------
-- Rows, columns and values in action
-- ----------------------------------------------------------------------------

-- Every row here = one student record; every column = one property (attribute)
SELECT * FROM student;

-- Every row here = one course record
SELECT * FROM course;
-- A single value — the intersection of one row and one column
SELECT student_name FROM student WHERE student_id = 101;   -- -> 'Aarav'

SHOW TABLES;
