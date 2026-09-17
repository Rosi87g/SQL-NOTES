-- ============================================================
-- CHAPTER 11: SQL FUNCTIONS
-- MySQL 8.x / 8.4
-- ============================================================
-- Scope:
-- String, Numeric, Date/Time, Aggregate, NULL handling,
-- Conditional, Conversion, Information/System, JSON,
-- REGEXP/RLIKE, and combining functions.
--
-- Deliberately NOT covered in depth:
-- JOINs, Subqueries, Set Operators, Views, Indexes,
-- Transactions, CTEs, Window Functions, Stored Programs.
-- ============================================================

DROP DATABASE IF EXISTS sql_functions_lab;
CREATE DATABASE sql_functions_lab;
USE sql_functions_lab;

-- ------------------------------------------------------------
-- 11.1 SAMPLE TABLES
-- ------------------------------------------------------------

CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    employee_name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    phone VARCHAR(20),
    email VARCHAR(100),
    join_date DATE,
    login_time DATETIME,
    status VARCHAR(20)
);

INSERT INTO employees
(first_name, last_name, employee_name, department, salary, phone, email, join_date, login_time, status)
VALUES
('  Rameez  ', 'Raja', '  Rameez Raja  ', 'IT', 65000.456, '9876543210', 'rameez@example.com', '2024-06-15', '2026-09-17 09:15:00', 'Active'),
('Aarav', 'Kumar', 'Aarav Kumar', 'HR', 48000.75, NULL, 'aarav@example.com', '2025-01-20', '2026-09-17 10:05:00', 'Active'),
('Bhavna', 'Sharma', 'Bhavna Sharma', 'Finance', 82000.99, '9123456780', NULL, '2023-03-12', '2026-09-17 08:45:00', 'Inactive'),
('Charan', 'Reddy', 'Charan Reddy', 'IT', 105000.10, NULL, 'charan@example.com', '2022-11-05', '2026-09-17 09:30:00', 'Active'),
('Divya', 'Patel', 'Divya Patel', 'IT', 51000.25, '9988776655', 'divya@example.com', '2026-02-10', '2026-09-17 11:00:00', 'Active');

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    score DECIMAL(5,2),
    department VARCHAR(50)
);

INSERT INTO students VALUES
(101, 'Aarav', 85.50, 'CSE'),
(102, 'Bhavna', 78.25, 'ECE'),
(103, 'Charan', 91.75, 'CSE'),
(104, 'Divya', NULL, 'CSE');

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    metadata JSON
);

INSERT INTO customers VALUES
(1, 'Rameez', '9876543210', 'rameez@example.com',
 '{"city":"Bengaluru","role":"Developer"}'),
(2, 'Aarav', NULL, 'aarav@example.com',
 '{"city":"Hyderabad","role":"Tester"}'),
(3, 'Bhavna', NULL, NULL,
 '{"city":"Chennai","role":"Analyst"}');

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10,2),
    quantity INT
);

INSERT INTO products VALUES
(1, 'Laptop', 65000.456, 2),
(2, 'Mouse', 850.75, 10),
(3, 'Keyboard', 1450.50, 0),
(4, 'Monitor', 12500.99, 4);

-- ------------------------------------------------------------
-- 11.2 STRING FUNCTIONS
-- ------------------------------------------------------------

SELECT UPPER('mysql') AS upper_text;
SELECT LOWER('MYSQL') AS lower_text;

SELECT LENGTH('Rameez') AS byte_length;
SELECT CHAR_LENGTH('Rameez') AS character_length;

SELECT CONCAT('Shaik', ' ', 'Rameez') AS full_name;
SELECT CONCAT_WS(' - ', 'Java', 'SQL', 'React') AS skills;

SELECT SUBSTRING('DATABASE', 1, 4) AS extracted_text;
SELECT LEFT('DATABASE', 4) AS left_text;
SELECT RIGHT('DATABASE', 4) AS right_text;

SELECT TRIM('   SQL   ') AS trimmed_text;
SELECT LTRIM('   SQL') AS left_trimmed;
SELECT RTRIM('SQL   ') AS right_trimmed;

SELECT REPLACE('I like Java', 'Java', 'SQL') AS replaced_text;
SELECT REVERSE('SQL') AS reversed_text;

SELECT LOCATE('SQL', 'I am learning SQL') AS position_found;
SELECT POSITION('SQL' IN 'I am learning SQL') AS position_found;
SELECT INSTR('I am learning SQL', 'SQL') AS position_found;

SELECT LPAD('123', 5, '0') AS left_padded;
SELECT RPAD('123', 5, '0') AS right_padded;

SELECT employee_name,
       UPPER(TRIM(employee_name)) AS cleaned_name
FROM employees;

SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM employees;

-- ------------------------------------------------------------
-- 11.3 NUMERIC / MATHEMATICAL FUNCTIONS
-- ------------------------------------------------------------

SELECT ABS(-25) AS absolute_value;
SELECT ROUND(123.4567, 2) AS rounded_value;
SELECT CEIL(12.1) AS ceiling_value;
SELECT FLOOR(12.9) AS floor_value;
SELECT TRUNCATE(123.4567, 2) AS truncated_value;

SELECT MOD(10, 3) AS remainder;
SELECT 10 % 3 AS remainder_operator;

SELECT POWER(2, 3) AS power_value;
SELECT SQRT(64) AS square_root;
SELECT SIGN(-10) AS sign_value;

SELECT GREATEST(10, 25, 15) AS greatest_value;
SELECT LEAST(10, 25, 15) AS least_value;

SELECT RAND() AS random_value;

SELECT product_name,
       price,
       ROUND(price, 2) AS rounded_price,
       TRUNCATE(price, 1) AS truncated_price
FROM products;

SELECT student_id
FROM students
WHERE MOD(student_id, 2) = 0;

-- ------------------------------------------------------------
-- 11.4 DATE AND TIME FUNCTIONS
-- ------------------------------------------------------------

SELECT NOW() AS current_datetime;
SELECT CURRENT_DATE() AS current_date_value;
SELECT CURRENT_TIME() AS current_time_value;
SELECT CURRENT_TIMESTAMP() AS current_timestamp_value;

SELECT DATE('2026-09-17 18:30:00') AS date_part;
SELECT TIME('2026-09-17 18:30:00') AS time_part;

SELECT YEAR(join_date) AS join_year
FROM employees;

SELECT MONTH(join_date) AS join_month
FROM employees;

SELECT MONTHNAME(join_date) AS join_month_name
FROM employees;

SELECT DAY(join_date) AS join_day
FROM employees;

SELECT DAYNAME(join_date) AS join_day_name
FROM employees;

SELECT HOUR(login_time) AS login_hour,
       MINUTE(login_time) AS login_minute,
       SECOND(login_time) AS login_second
FROM employees;

SELECT DATE_ADD('2026-09-17', INTERVAL 7 DAY) AS plus_7_days;
SELECT DATE_SUB('2026-09-17', INTERVAL 30 DAY) AS minus_30_days;

SELECT DATEDIFF('2026-09-17', '2026-09-01') AS days_difference;

SELECT TIMESTAMPDIFF(
    YEAR,
    '2005-01-01',
    '2026-01-01'
) AS years_difference;

SELECT DATE_FORMAT('2026-09-17 18:30:00', '%d-%m-%Y %H:%i:%s')
AS formatted_datetime;

SELECT employee_name,
       TIMESTAMPDIFF(YEAR, join_date, CURRENT_DATE()) AS years_of_service
FROM employees;

SELECT employee_name,
       DATE_FORMAT(join_date, '%d-%m-%Y') AS formatted_join_date
FROM employees;

-- ------------------------------------------------------------
-- 11.5 AGGREGATE FUNCTIONS
-- ------------------------------------------------------------

SELECT COUNT(*) AS total_employees
FROM employees;

SELECT COUNT(phone) AS employees_with_phone
FROM employees;

SELECT SUM(salary) AS total_salary
FROM employees;

SELECT AVG(salary) AS average_salary
FROM employees;

SELECT MIN(salary) AS minimum_salary
FROM employees;

SELECT MAX(salary) AS maximum_salary
FROM employees;

-- Basic GROUP BY bridge examples:
-- Detailed GROUP BY/HAVING is reserved for a later chapter.

SELECT department, AVG(salary) AS average_salary
FROM employees
GROUP BY department;

SELECT department, COUNT(*) AS employee_count
FROM employees
GROUP BY department;

SELECT department,
       AVG(salary) AS average_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 50000;

-- ------------------------------------------------------------
-- 11.6 NULL HANDLING
-- ------------------------------------------------------------

SELECT employee_name,
       IFNULL(phone, 'Not Provided') AS phone_display
FROM employees;

SELECT customer_name,
       COALESCE(phone, email, 'No Contact') AS best_contact
FROM customers;

SELECT NULLIF(10, 10) AS result_1;
SELECT NULLIF(10, 20) AS result_2;

-- Prevent division by zero:
SELECT product_name,
       price / NULLIF(quantity, 0) AS price_per_unit
FROM products;

-- ------------------------------------------------------------
-- 11.7 CONDITIONAL / FLOW CONTROL
-- ------------------------------------------------------------

SELECT employee_name,
       IF(salary >= 50000, 'High', 'Normal') AS salary_level
FROM employees;

SELECT employee_name,
       CASE
           WHEN salary >= 100000 THEN 'Senior'
           WHEN salary >= 50000 THEN 'Mid-Level'
           ELSE 'Junior'
       END AS employee_level
FROM employees;

SELECT employee_name,
       CASE department
           WHEN 'IT' THEN 'Technology'
           WHEN 'HR' THEN 'People'
           WHEN 'Finance' THEN 'Business'
           ELSE 'Other'
       END AS department_group
FROM employees;

-- ------------------------------------------------------------
-- 11.8 CONVERSION FUNCTIONS
-- ------------------------------------------------------------

SELECT CAST('2026-09-17' AS DATE) AS converted_date;
SELECT CAST('125.50' AS DECIMAL(10,2)) AS converted_number;
SELECT CONVERT('125', UNSIGNED) AS converted_integer;

-- ------------------------------------------------------------
-- 11.9 INFORMATION / SYSTEM FUNCTIONS
-- ------------------------------------------------------------

SELECT VERSION() AS mysql_version;
SELECT DATABASE() AS current_database;
SELECT USER() AS current_user;
SELECT CONNECTION_ID() AS connection_id;

-- ------------------------------------------------------------
-- 11.10 JSON FUNCTIONS
-- ------------------------------------------------------------

SELECT JSON_OBJECT(
    'name', 'Rameez',
    'skill', 'SQL'
) AS json_object_value;

SELECT JSON_ARRAY('Java', 'SQL', 'React') AS json_array_value;

SELECT JSON_EXTRACT(
    '{"name":"Rameez","age":21}',
    '$.name'
) AS extracted_json_value;

SELECT JSON_UNQUOTE(
    JSON_EXTRACT(
        '{"name":"Rameez"}',
        '$.name'
    )
) AS unquoted_name;

SELECT JSON_VALID('{"name":"Rameez"}') AS valid_json;

SELECT customer_name,
       JSON_EXTRACT(metadata, '$.city') AS city
FROM customers;

-- ------------------------------------------------------------
-- 11.11 REGEXP / RLIKE
-- ------------------------------------------------------------

SELECT email
FROM customers
WHERE email REGEXP '^[A-Za-z0-9._%+-]+@';

SELECT customer_name
FROM customers
WHERE customer_name RLIKE '^A';

-- ------------------------------------------------------------
-- 11.12 FUNCTIONS IN SELECT / WHERE / ORDER BY
-- ------------------------------------------------------------

SELECT employee_name,
       UPPER(employee_name) AS name_upper,
       ROUND(salary, 2) AS rounded_salary
FROM employees;

SELECT *
FROM employees
WHERE UPPER(department) = 'IT';

SELECT *
FROM employees
WHERE YEAR(join_date) = 2026;

SELECT employee_name, salary
FROM employees
ORDER BY ROUND(salary, -3) DESC;

-- ------------------------------------------------------------
-- 11.13 FUNCTIONS IN GROUP BY
-- ------------------------------------------------------------

SELECT YEAR(join_date) AS join_year,
       COUNT(*) AS employee_count
FROM employees
GROUP BY YEAR(join_date);

-- ------------------------------------------------------------
-- 11.14 FUNCTIONS IN HAVING
-- ------------------------------------------------------------

SELECT department,
       AVG(salary) AS avg_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 50000;

-- ------------------------------------------------------------
-- 11.15 COMBINING FUNCTIONS
-- ------------------------------------------------------------

SELECT
    UPPER(TRIM(employee_name)) AS cleaned_name,
    ROUND(salary * 1.10, 2) AS revised_salary
FROM employees;

SELECT
    CONCAT(
        employee_name,
        ' - ',
        COALESCE(department, 'Unknown')
    ) AS employee_info
FROM employees;

SELECT
    DATE_FORMAT(join_date, '%d-%m-%Y') AS formatted_date
FROM employees;

SELECT
    COUNT(IF(status = 'Active', 1, NULL)) AS active_count
FROM employees;

-- ------------------------------------------------------------
-- 11.16 PRACTICE TASKS
-- ------------------------------------------------------------
-- 1. Display all employee names in uppercase.
-- 2. Display cleaned employee names using TRIM and UPPER.
-- 3. Display first and last names as one full name.
-- 4. Display salary rounded to 2 decimal places.
-- 5. Find employees whose employee_id is even.
-- 6. Display employees' joining year.
-- 7. Display years of service for each employee.
-- 8. Display NULL phone numbers as 'Not Provided'.
-- 9. Categorize salaries using CASE.
-- 10. Find total, average, minimum, and maximum salary.
-- 11. Display department-wise employee count.
-- 12. Extract city from customer JSON metadata.
-- 13. Find emails matching a basic email prefix pattern.
-- 14. Combine UPPER, TRIM, CONCAT, and COALESCE in one query.
-- 15. Use NULLIF to avoid division by zero.
