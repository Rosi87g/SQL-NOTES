-- ============================================================================
-- CHAPTER 2 — Understanding DBMS, RDBMS and SQL
-- ============================================================================
-- Purpose : First "hello world" script — creates a database, creates a
--           table, and runs one example of each basic SQL command
--           (CREATE, INSERT, SELECT, UPDATE, DELETE) exactly as covered
--           in Chapter 2 of the notes.
-- Source  : Rewritten and cleaned up from company_db.sql
--           (fixed the "emplpoyees" table-name typo).
-- ============================================================================
-- Step 1: Create the database (only if it doesn't already exist)
CREATE DATABASE IF NOT EXISTS company_db;

-- Step 2: Select the database to work inside
USE company_db;
-- Step 3: Create a simple table — no keys/constraints yet, that comes in
--          Chapter 8. This table only demonstrates basic column definitions.
CREATE TABLE IF NOT EXISTS employees (
    employee_id   INT,
    employee_name VARCHAR(50),
    department    VARCHAR(40),
    job_role      VARCHAR(50),
    work_city     VARCHAR(30),
    joining_year  INT
);
-- ----------------------------------------------------------------------------
-- SQL command examples (matches "Examples of SQL Commands" in Chapter 2)
-- ----------------------------------------------------------------------------

-- INSERT — add a new record
INSERT INTO employees (employee_id, employee_name, department, job_role, work_city, joining_year)
VALUES (101, 'Aarav Sharma', 'Engineering', 'Software Developer', 'Bengaluru', 2023);

-- SELECT — retrieve records (DQL)
SELECT * FROM employees;
-- UPDATE — modify an existing record
UPDATE employees
SET department = 'Product Engineering'
WHERE employee_id = 101;

-- DELETE — remove a record
-- (kept commented out so the demo row survives for you to inspect;
--  uncomment to see DELETE in action)
-- DELETE FROM employees WHERE employee_id = 101;
-- ----------------------------------------------------------------------------
-- Exploring the server, the database, and the table (DBMS/RDBMS tooling)
-- ----------------------------------------------------------------------------

-- SHOW DATABASES — list every database on this MySQL server
SHOW DATABASES;

-- SHOW TABLES — list every table inside the currently selected database
SHOW TABLES;

-- DESCRIBE / DESC — show a table's column structure (name, type, keys, etc.)
DESCRIBE employees;
-- Final check — see the current state of the table
SELECT * FROM employees;
