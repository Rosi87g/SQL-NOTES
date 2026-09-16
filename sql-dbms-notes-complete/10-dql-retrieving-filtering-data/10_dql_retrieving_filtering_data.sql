-- ============================================================================
-- CHAPTER 10 — DQL: Retrieving and Filtering Data
-- ============================================================================
-- Purpose : One runnable MySQL script covering the DQL topics from Chapter 10:
--           SELECT, selecting specific columns, aliases, calculated columns,
--           DISTINCT, ORDER BY, LIMIT / OFFSET,
--           WHERE, comparison operators, AND / OR / NOT, parentheses,
--           IN / NOT IN, BETWEEN / NOT BETWEEN, LIKE / wildcards,
--           IS NULL / IS NOT NULL, dates, and combined filtering.
--
-- Notes   : The examples use realistic students, employees, products,
--           customers, job applications, and orders tables.
--           Run this script from top to bottom.
-- ============================================================================

CREATE DATABASE IF NOT EXISTS dql_practice_db;
USE dql_practice_db;

-- ============================================================================
-- 10.0 SETUP — Practice Tables
-- ============================================================================

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS job_applications;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS students;

CREATE TABLE students (
    student_id      INT PRIMARY KEY,
    student_name    VARCHAR(60) NOT NULL,
    branch          VARCHAR(30) NOT NULL,
    score           INT,
    placement_status VARCHAR(30)
);

CREATE TABLE employees (
    employee_id     INT PRIMARY KEY,
    employee_name   VARCHAR(60) NOT NULL,
    salary          DECIMAL(10,2) NOT NULL,
    bonus           DECIMAL(10,2) DEFAULT 0,
    department      VARCHAR(40) NOT NULL
);

CREATE TABLE products (
    product_id      INT PRIMARY KEY,
    product_name    VARCHAR(60) NOT NULL,
    price           DECIMAL(10,2) NOT NULL,
    quantity        INT,
    discount        DECIMAL(10,2) DEFAULT 0
);

CREATE TABLE customers (
    customer_id     INT PRIMARY KEY,
    customer_name   VARCHAR(60) NOT NULL,
    city            VARCHAR(40),
    email           VARCHAR(100)
);

CREATE TABLE job_applications (
    application_id  INT PRIMARY KEY,
    candidate_name  VARCHAR(60) NOT NULL,
    score           INT,
    status          VARCHAR(30),
    applied_date    DATE
);

CREATE TABLE orders (
    order_id        INT PRIMARY KEY,
    customer_name   VARCHAR(60) NOT NULL,
    order_date      DATE,
    order_amount    DECIMAL(10,2)
);

-- ============================================================================
-- Sample Data
-- ============================================================================

INSERT INTO students
    (student_id, student_name, branch, score, placement_status)
VALUES
    (101, 'Asha',  'CSE', 82, 'Placed'),
    (102, 'Ravi',  'ECE', 74, 'Not Placed'),
    (103, 'Meera', 'CSE', 91, 'Placed'),
    (104, 'Arjun', 'ISE', 68, 'Not Placed'),
    (105, 'Neha',  'ECE', 86, 'Placed'),
    (106, 'Kiran', 'CSE', 76, 'In Progress');

INSERT INTO employees
    (employee_id, employee_name, salary, bonus, department)
VALUES
    (201, 'Asha', 45000, 5000, 'Development'),
    (202, 'Ravi', 38000, 3000, 'Testing'),
    (203, 'Meera', 52000, 8000, 'Development'),
    (204, 'Arjun', 48000, 4000, 'Testing'),
    (205, 'Neha', 65000, 10000, 'HR');

INSERT INTO products
    (product_id, product_name, price, quantity, discount)
VALUES
    (301, 'Keyboard', 1200, 2, 100),
    (302, 'Mouse',     600, 3, 50),
    (303, 'Monitor', 15000, 1, 1500),
    (304, 'Laptop',   55000, 2, 5000),
    (305, 'Webcam',    2500, NULL, 200);

INSERT INTO customers
    (customer_id, customer_name, city, email)
VALUES
    (401, 'Aarav',  'Bengaluru', 'aarav@gmail.com'),
    (402, 'Ananya', 'Hyderabad', NULL),
    (403, 'Rohan',  'Chennai',   'rohan@gmail.com'),
    (404, 'Karan',  'Bengaluru', 'karan@yahoo.com'),
    (405, 'Aman',   NULL,        'aman@gmail.com');

INSERT INTO job_applications
    (application_id, candidate_name, score, status, applied_date)
VALUES
    (501, 'Asha',  82, 'Shortlisted', '2026-08-10'),
    (502, 'Ravi',  68, 'Rejected',    '2026-08-12'),
    (503, 'Meera', 91, 'Shortlisted', '2026-08-15'),
    (504, 'Arjun', 75, 'Under Review','2026-08-18'),
    (505, 'Neha',  88, 'Shortlisted', '2026-08-20');

INSERT INTO orders
    (order_id, customer_name, order_date, order_amount)
VALUES
    (601, 'Aarav',  '2026-08-10', 2500),
    (602, 'Ananya', '2026-08-15', 4500),
    (603, 'Rohan',  '2026-08-18', 7200),
    (604, 'Karan',  '2026-08-20', 1800),
    (605, 'Aman',   '2026-08-25', 5200);

-- ============================================================================
-- 10.1 SELECT — Selecting All Columns and Specific Columns
-- ============================================================================

-- Select every column.
SELECT *
FROM students;

-- Select one specific column.
SELECT student_name
FROM students;

-- Select multiple specific columns.
SELECT student_name, score
FROM students;

-- Column order in the result follows the SELECT list.
SELECT score, student_name
FROM students;

-- SELECT controls columns; without WHERE, all rows are returned.
SELECT student_name, score
FROM students;

-- ============================================================================
-- 10.2 Column Aliases Using AS
-- ============================================================================

-- Alias changes the result heading, not the original table column.
SELECT employee_name AS name
FROM employees;

-- Multiple aliases.
SELECT
    employee_name AS name,
    salary AS monthly_salary
FROM employees;

-- Alias containing spaces in MySQL: use backticks.
SELECT
    employee_name AS `Employee Name`,
    salary AS `Monthly Salary`
FROM employees;

-- AS is optional in MySQL, but AS is clearer.
SELECT employee_name AS name
FROM employees;

-- ============================================================================
-- 10.3 Calculated Columns
-- ============================================================================

-- Calculated column: price * quantity.
SELECT
    product_name,
    price,
    quantity,
    price * quantity AS total_value
FROM products;

-- Addition.
SELECT
    employee_name,
    salary,
    bonus,
    salary + bonus AS total_pay
FROM employees;

-- Subtraction.
SELECT
    product_name,
    price,
    discount,
    price - discount AS final_price
FROM products;

-- Percentage calculation: 18% tax.
SELECT
    product_name,
    price,
    price * 18 / 100 AS tax_amount
FROM products;

-- Calculated final amount including 18% tax.
SELECT
    product_name,
    price,
    price + (price * 18 / 100) AS final_amount
FROM products;

-- Multiple calculations in one query.
SELECT
    product_name,
    price,
    price * 10 / 100 AS discount_amount,
    price - (price * 10 / 100) AS final_price
FROM products;

-- Parentheses make the intended calculation explicit.
SELECT
    product_name,
    price,
    price * (1 + 18 / 100) AS final_amount
FROM products;

-- IMPORTANT:
-- Calculated columns in SELECT do NOT modify stored table data.


-- ============================================================================
-- 10.4 DISTINCT — Removing Duplicate Results
-- ============================================================================

-- Repeated branch values are shown as they occur in the table.
SELECT branch
FROM students;

-- DISTINCT returns each branch only once.
SELECT DISTINCT branch
FROM students;

-- DISTINCT applies to the combination of selected columns.
SELECT DISTINCT branch, placement_status
FROM students;

-- ============================================================================
-- 10.5 ORDER BY — Sorting One or More Columns
-- ============================================================================

-- Sort by one column in ascending order.
SELECT student_id, student_name
FROM students
ORDER BY student_id ASC;

-- ASC is the default.
SELECT student_id, student_name
FROM students
ORDER BY student_id;

-- Sort by score from highest to lowest.
SELECT student_id, student_name, score
FROM students
ORDER BY score DESC;

-- Sort by more than one column.
-- First sort by branch, then sort equal-branch rows by score descending.
SELECT student_id, student_name, branch, score
FROM students
ORDER BY branch ASC, score DESC;

-- ============================================================================
-- 10.6 LIMIT and OFFSET — Restricting Result Rows
-- ============================================================================

-- Return only the first 3 rows.
SELECT student_id, student_name
FROM students
LIMIT 3;

-- Return the top 3 students by score.
SELECT student_id, student_name, score
FROM students
ORDER BY score DESC
LIMIT 3;

-- Skip 2 rows, then return the next 3 rows.
SELECT student_id, student_name
FROM students
ORDER BY student_id
LIMIT 3 OFFSET 2;

-- MySQL shortcut: LIMIT offset, row_count
SELECT student_id, student_name
FROM students
ORDER BY student_id
LIMIT 2, 3;

-- Pagination examples.
SELECT *
FROM students
ORDER BY student_id
LIMIT 3 OFFSET 0;  -- Page 1

SELECT *
FROM students
ORDER BY student_id
LIMIT 3 OFFSET 3;  -- Page 2

SELECT *
FROM students
ORDER BY student_id
LIMIT 3 OFFSET 6;  -- Page 3


-- ============================================================================
-- 10.7 WHERE — Filtering Rows
-- ============================================================================

-- WHERE returns only rows that satisfy the condition.
SELECT *
FROM students
WHERE branch = 'CSE';

-- Filter by text.
SELECT *
FROM students
WHERE placement_status = 'Placed';

-- Filter by a numeric value.
SELECT *
FROM students
WHERE student_id = 103;

-- Select specific columns and filter rows.
SELECT student_name, score
FROM students
WHERE branch = 'CSE';

-- Correct clause order:
-- SELECT ... FROM ... WHERE ...

-- ============================================================================
-- 10.8 Comparison Operators
-- ============================================================================
-- =     Equal to
-- <>    Not equal to
-- >     Greater than
-- <     Less than
-- >=    Greater than or equal to
-- <=    Less than or equal to

-- Greater than.
SELECT candidate_name, score
FROM job_applications
WHERE score > 80;

-- Greater than or equal to.
SELECT candidate_name, score
FROM job_applications
WHERE score >= 75;

-- Less than.
SELECT candidate_name, score
FROM job_applications
WHERE score < 75;

-- Less than or equal to.
SELECT candidate_name, score
FROM job_applications
WHERE score <= 75;

-- Exactly equal to.
SELECT candidate_name, score
FROM job_applications
WHERE score = 75;

-- Not equal to.
SELECT candidate_name, status
FROM job_applications
WHERE status <> 'Rejected';

-- Text comparison.
SELECT candidate_name, status
FROM job_applications
WHERE status = 'Shortlisted';

-- Date comparison.
SELECT candidate_name, applied_date
FROM job_applications
WHERE applied_date > '2026-08-15';

SELECT candidate_name, applied_date
FROM job_applications
WHERE applied_date >= '2026-08-15';

SELECT candidate_name, applied_date
FROM job_applications
WHERE applied_date < '2026-08-18';

-- ============================================================================
-- 10.9 AND — Every Condition Must Be True
-- ============================================================================

-- CSE students AND score at least 80.
SELECT
    student_name,
    branch,
    score
FROM students
WHERE branch = 'CSE'
AND score >= 80;

-- Three conditions: every condition must be satisfied.
SELECT
    student_name,
    branch,
    score,
    placement_status
FROM students
WHERE branch = 'CSE'
AND score >= 80
AND placement_status = 'Placed';

-- Employee department AND salary requirement.
SELECT
    employee_name,
    department,
    salary
FROM employees
WHERE department = 'Development'
AND salary >= 50000;

-- ============================================================================
-- 10.9 OR — At Least One Condition Must Be True
-- ============================================================================

-- Students from CSE OR ISE.
SELECT
    student_name,
    branch
FROM students
WHERE branch = 'CSE'
OR branch = 'ISE';

-- Score above 90 OR placement status is Placed.
SELECT
    student_name,
    score,
    placement_status
FROM students
WHERE score > 90
OR placement_status = 'Placed';

-- ============================================================================
-- 10.9 NOT — Reverse a Condition
-- ============================================================================

-- Students who are NOT placed.
SELECT
    student_name,
    placement_status
FROM students
WHERE NOT placement_status = 'Placed';

-- Same requirement using <>.
SELECT
    student_name,
    placement_status
FROM students
WHERE placement_status <> 'Placed';

-- ============================================================================
-- 10.9 More Than Two Conditions
-- ============================================================================

-- Every condition must be true.
SELECT
    student_name,
    branch,
    score,
    placement_status
FROM students
WHERE branch = 'CSE'
AND score >= 80
AND placement_status = 'Placed';

-- ============================================================================
-- 10.10 Parentheses — Controlling Condition Priority
-- ============================================================================
-- Logical priority:
-- 1. Parentheses
-- 2. NOT
-- 3. AND
-- 4. OR

-- Intended meaning:
-- (CSE OR ISE) AND score >= 80
SELECT
    student_name,
    branch,
    score
FROM students
WHERE (branch = 'CSE' OR branch = 'ISE')
AND score >= 80;

-- Without parentheses, AND is evaluated before OR:
-- branch = 'CSE'
-- OR (branch = 'ISE' AND score >= 80)
SELECT
    student_name,
    branch,
    score
FROM students
WHERE branch = 'CSE'
OR branch = 'ISE'
AND score >= 80;

-- A second example: department group + salary requirement.
SELECT
    employee_name,
    department,
    salary
FROM employees
WHERE (department = 'Development' OR department = 'Testing')
AND salary >= 50000;

-- Different grouping = different business requirement.
SELECT
    employee_name,
    department,
    salary
FROM employees
WHERE department = 'Development'
OR (department = 'Testing' AND salary >= 50000);

-- CSE AND (Placed OR score >= 90).
SELECT
    student_name,
    branch,
    score,
    placement_status
FROM students
WHERE branch = 'CSE'
AND (placement_status = 'Placed' OR score >= 90);

-- ============================================================================
-- 10.11 IN — Filtering from a List
-- ============================================================================

-- IN is a clean alternative to multiple OR conditions.
SELECT
    student_name,
    branch
FROM students
WHERE branch IN ('CSE', 'ISE', 'ECE');

-- Equivalent OR version.
SELECT
    student_name,
    branch
FROM students
WHERE branch = 'CSE'
OR branch = 'ISE'
OR branch = 'ECE';

-- Employee departments in a list.
SELECT
    employee_name,
    department
FROM employees
WHERE department IN ('Development', 'Testing');

-- ============================================================================
-- 10.11 NOT IN — Excluding a List
-- ============================================================================

SELECT
    student_name,
    branch
FROM students
WHERE branch NOT IN ('CSE', 'ISE');

-- IMPORTANT:
-- If the tested column can contain NULL, NOT IN can behave unexpectedly.
-- Handle NULL explicitly when the column may contain missing values.

-- ============================================================================
-- 10.12 BETWEEN — Filtering an Inclusive Range
-- ============================================================================

-- BETWEEN includes both boundaries.
-- score 70 and score 80 are included.
SELECT
    student_name,
    score
FROM students
WHERE score BETWEEN 70 AND 80;

-- Equivalent explicit condition.
SELECT
    student_name,
    score
FROM students
WHERE score >= 70
AND score <= 80;

-- NOT BETWEEN: outside the inclusive range.
SELECT
    student_name,
    score
FROM students
WHERE score NOT BETWEEN 70 AND 80;

-- Salary range.
SELECT
    employee_name,
    salary
FROM employees
WHERE salary BETWEEN 40000 AND 55000;

-- Date range.
SELECT
    candidate_name,
    applied_date
FROM job_applications
WHERE applied_date BETWEEN '2026-08-10' AND '2026-08-20';

-- ============================================================================
-- 10.13 LIKE — Pattern Matching
-- ============================================================================
-- % = zero or more characters
-- _ = exactly one character

-- Starts with A.
SELECT
    customer_name
FROM customers
WHERE customer_name LIKE 'A%';

-- Ends with a specific domain.
SELECT
    customer_name,
    email
FROM customers
WHERE email LIKE '%@gmail.com';

-- Contains "an".
SELECT
    customer_name
FROM customers
WHERE customer_name LIKE '%an%';

-- Second character is "a".
SELECT
    customer_name
FROM customers
WHERE customer_name LIKE '_a%';

-- NOT LIKE — does not match the pattern.
SELECT
    customer_name
FROM customers
WHERE customer_name NOT LIKE 'A%';

-- Exact equality is different from pattern matching:
-- =  -> exact value
-- LIKE -> pattern

-- ============================================================================
-- 10.14 IS NULL — Finding Missing Values
-- ============================================================================

-- Find customers whose email is missing.
SELECT
    customer_name,
    email
FROM customers
WHERE email IS NULL;

-- Find products whose quantity is missing.
SELECT
    product_name,
    quantity
FROM products
WHERE quantity IS NULL;

-- ============================================================================
-- 10.14 IS NOT NULL — Finding Existing Values
-- ============================================================================

SELECT
    customer_name,
    email
FROM customers
WHERE email IS NOT NULL;

-- IMPORTANT:
-- Do NOT write:
-- WHERE email = NULL
--
-- Correct:
-- WHERE email IS NULL
--
-- Correct:
-- WHERE email IS NOT NULL

-- ============================================================================
-- 10.15 Combining DQL Features
-- ============================================================================

-- Selected columns + aliases + calculated column + filtering.
SELECT
    product_name AS `Product Name`,
    price AS `Unit Price`,
    quantity,
    price * quantity AS `Total Value`
FROM products
WHERE price BETWEEN 500 AND 5000
AND quantity >= 2;

-- IN + LIKE + IS NOT NULL + parentheses.
SELECT
    customer_name,
    city,
    email
FROM customers
WHERE (city IN ('Bengaluru', 'Hyderabad')
       OR email LIKE '%@gmail.com')
AND email IS NOT NULL;

-- Job application filtering.
SELECT
    candidate_name,
    score,
    status,
    applied_date
FROM job_applications
WHERE status IN ('Shortlisted', 'Under Review')
AND score >= 75;

-- Orders by date and amount.
SELECT
    order_id,
    order_date,
    order_amount
FROM orders
WHERE order_date >= '2026-08-15'
AND order_amount > 3000;

-- ============================================================================
-- 10.18 PRACTICE — Student Score Filtering
-- ============================================================================

SELECT
    student_name,
    score
FROM students
WHERE score >= 75;

-- ============================================================================
-- 10.19 PRACTICE — Employee Department and Salary
-- ============================================================================

SELECT
    employee_name,
    department,
    salary
FROM employees
WHERE department = 'Development'
AND salary >= 50000;

-- ============================================================================
-- 10.20 PRACTICE — Orders by Date and Amount
-- ============================================================================

SELECT
    order_id,
    order_date,
    order_amount
FROM orders
WHERE order_date >= '2026-08-15'
AND order_amount > 3000;

-- ============================================================================
-- 10.21 PRACTICE — Students Using IN and BETWEEN
-- ============================================================================

SELECT
    student_name,
    branch,
    score
FROM students
WHERE branch IN ('CSE', 'ISE')
AND score BETWEEN 75 AND 95;

-- ============================================================================
-- 10.22 PRACTICE — Customer Search Using LIKE
-- ============================================================================

SELECT
    customer_name,
    email
FROM customers
WHERE customer_name LIKE 'A%';

-- ============================================================================
-- 10.23 PRACTICE — Find Records Containing Missing Values
-- ============================================================================

SELECT
    customer_name,
    email
FROM customers
WHERE email IS NULL;

-- ============================================================================
-- 10.24 INTERVIEW CHECK — Boundary Conditions
-- ============================================================================

-- Exactly 75.
SELECT candidate_name, score
FROM job_applications
WHERE score = 75;

-- At least 75.
SELECT candidate_name, score
FROM job_applications
WHERE score >= 75;

-- Above 75.
SELECT candidate_name, score
FROM job_applications
WHERE score > 75;

-- At most 75.
SELECT candidate_name, score
FROM job_applications
WHERE score <= 75;

-- Below 75.
SELECT candidate_name, score
FROM job_applications
WHERE score < 75;

-- ============================================================================
-- 10.25 FINAL VERIFICATION
-- ============================================================================

SELECT 'Students' AS table_name, COUNT(*) AS row_count FROM students
UNION ALL
SELECT 'Employees', COUNT(*) FROM employees
UNION ALL
SELECT 'Products', COUNT(*) FROM products
UNION ALL
SELECT 'Customers', COUNT(*) FROM customers
UNION ALL
SELECT 'Job Applications', COUNT(*) FROM job_applications
UNION ALL
SELECT 'Orders', COUNT(*) FROM orders;

-- ============================================================================
-- END OF CHAPTER 10 — DQL
-- ============================================================================
