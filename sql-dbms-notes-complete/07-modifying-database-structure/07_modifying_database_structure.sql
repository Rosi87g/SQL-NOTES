-- ============================================================================
-- CHAPTER 7 — Modifying Database Structure
-- ============================================================================
-- Purpose : Full walkthrough of ALTER TABLE — adding columns (with FIRST /
--           AFTER positioning), modifying columns, renaming columns and
--           tables, dropping a column, and finally TRUNCATE vs DROP.
-- Source  : Rewritten and merged from training_student_db.sql (ADD/MODIFY/
--           DROP + FIRST/AFTER positioning) and compnay_db.sql
--           (RENAME COLUMN / RENAME TABLE).
-- ============================================================================
CREATE DATABASE IF NOT EXISTS alter_table_lab;
USE alter_table_lab;

-- Start with a minimal table — everything else is added step by step below
CREATE TABLE IF NOT EXISTS student (
    student_id   INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(50) NOT NULL,
    branch       VARCHAR(30) NOT NULL
);

-- ----------------------------------------------------------------------------
-- 7.1 Adding columns with ADD COLUMN
-- ----------------------------------------------------------------------------
-- Add a single column (goes to the end of the table by default)
ALTER TABLE student
ADD COLUMN email VARCHAR(100);

-- Add a column at the very START of the table using FIRST
ALTER TABLE student
ADD COLUMN registration_number CHAR(10) FIRST;

-- Add a column right AFTER a specific existing column
ALTER TABLE student
ADD COLUMN phone_number VARCHAR(15) AFTER student_name;
-- Add MULTIPLE columns in a single ALTER TABLE statement
ALTER TABLE student
ADD COLUMN city VARCHAR(30),
ADD COLUMN graduation_year YEAR;

-- A column added just to demonstrate DROP COLUMN further below
ALTER TABLE student
ADD COLUMN secondary_email VARCHAR(50) AFTER email;

-- ----------------------------------------------------------------------------
-- 7.2 Changing a column's definition with MODIFY COLUMN
-- ----------------------------------------------------------------------------
-- Tighten a column that was left optional — make it mandatory
ALTER TABLE student
MODIFY COLUMN email VARCHAR(100) NOT NULL;

-- MODIFY can also reposition a column while changing its definition
ALTER TABLE student
MODIFY COLUMN registration_number CHAR(10) NOT NULL FIRST;

ALTER TABLE student
MODIFY COLUMN phone_number VARCHAR(15) NOT NULL AFTER student_name;
-- Modify two columns in one statement
ALTER TABLE student
MODIFY COLUMN city VARCHAR(30) NOT NULL AFTER email,
MODIFY COLUMN graduation_year YEAR NOT NULL AFTER city;

-- Add a boolean flag with a sensible default, then tighten it to NOT NULL
ALTER TABLE student
ADD COLUMN is_active BOOLEAN DEFAULT TRUE;

ALTER TABLE student
MODIFY COLUMN is_active BOOLEAN NOT NULL DEFAULT TRUE;

-- Add one more useful column for later chapters
ALTER TABLE student
ADD COLUMN cgpa DECIMAL(4,2);
-- ----------------------------------------------------------------------------
-- 7.3 Removing a column with DROP COLUMN
-- ----------------------------------------------------------------------------

-- secondary_email was only added for this demo — remove it
ALTER TABLE student
DROP COLUMN secondary_email;

-- ----------------------------------------------------------------------------
-- 7.4 Renaming columns and the table
-- ----------------------------------------------------------------------------
-- Rename a single column (MySQL 8.0+ syntax)
ALTER TABLE student
RENAME COLUMN branch TO department;

-- Rename several columns in one statement
ALTER TABLE student
RENAME COLUMN student_name TO full_name,
RENAME COLUMN department TO student_department;

-- Rename the whole table (two equivalent ways — only one is needed)
RENAME TABLE student TO students;
-- ALTER TABLE students RENAME TO students;   -- alternative syntax, same result
-- Check the final structure after every ADD / MODIFY / RENAME above
SHOW TABLES;
DESCRIBE students;
SELECT * FROM students;

-- ----------------------------------------------------------------------------
-- 7.5 TRUNCATE vs DROP
-- ----------------------------------------------------------------------------
-- Demonstrated on a separate throwaway table so the "students" table above
-- is left intact for you to keep experimenting with.
CREATE TABLE IF NOT EXISTS scratch_table (
    id    INT PRIMARY KEY AUTO_INCREMENT,
    label VARCHAR(30)
);

INSERT INTO scratch_table (label) VALUES ('sample row 1'), ('sample row 2');

SELECT * FROM scratch_table;

-- TRUNCATE removes every row but KEEPS the table structure (fast, resets
-- AUTO_INCREMENT, cannot be filtered with WHERE)
TRUNCATE TABLE scratch_table;

SELECT * FROM scratch_table;    -- empty, but the table still exists
DESCRIBE scratch_table;         -- structure is unchanged
-- DROP removes the table completely — structure AND data are gone for good
DROP TABLE scratch_table;

-- SHOW TABLES;   -- uncomment to confirm scratch_table no longer exists
