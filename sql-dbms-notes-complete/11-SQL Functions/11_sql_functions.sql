-- ============================================================
-- CHAPTER 11: SQL FUNCTIONS
-- MySQL Practice Script
-- ============================================================

DROP DATABASE IF EXISTS sql_functions_lab;
CREATE DATABASE sql_functions_lab;
USE sql_functions_lab;

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department VARCHAR(50),
    salary DECIMAL(10,2),
    phone VARCHAR(20),
    email VARCHAR(100),
    hire_date DATE
);

INSERT INTO employees VALUES
(1,'Ravi','Kumar','IT',65000.50,'9876543210','ravi@example.com','2025-01-15'),
(2,'Anita','Sharma','HR',48000.75,NULL,'anita@example.com','2024-06-20'),
(3,'Arjun','Reddy','IT',85000.25,'9123456780','arjun@example.com','2025-08-10'),
(4,'Meena','Patel','Finance',55000.00,NULL,'meena@example.com','2023-03-05'),
(5,'Kiran','Das','Sales',42000.90,'9988776655','kiran@example.com','2026-02-12');

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    marks DECIMAL(5,2)
);

INSERT INTO students VALUES
(1,'Ravi',92.50),(2,'Anita',78.00),(3,'Arjun',65.50),
(4,'Meena',39.00),(5,'Kiran',88.25);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    phone VARCHAR(20),
    email VARCHAR(100)
);

INSERT INTO customers VALUES
(1,'Ravi','9876543210','ravi@example.com'),
(2,'Anita',NULL,'anita@example.com'),
(3,'Arjun',NULL,NULL);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10,3)
);

INSERT INTO products VALUES
(1,'Keyboard',1299.567),(2,'Mouse',599.456),(3,'Monitor',12500.789);

-- ============================================================
-- STRING FUNCTIONS
-- ============================================================

SELECT UPPER('hello world');
SELECT LOWER('HELLO WORLD');
SELECT name, LENGTH(name) AS name_length FROM students;
SELECT name, CHAR_LENGTH(name) AS character_count FROM students;
SELECT CONCAT(first_name,' ',last_name) AS full_name FROM employees;
SELECT CONCAT_WS(', ',first_name,last_name,department) FROM employees;
SELECT SUBSTRING('DATABASE',1,4);
SELECT LEFT('DATABASE',4);
SELECT RIGHT('DATABASE',4);
SELECT TRIM('   Hello   ');
SELECT LTRIM('   Hello');
SELECT RTRIM('Hello   ');
SELECT REPLACE('I like Java','Java','SQL');
SELECT REVERSE('SQL');
SELECT LOCATE('SQL','I am learning SQL');
SELECT POSITION('SQL' IN 'I am learning SQL');
SELECT INSTR('I am learning SQL','SQL');
SELECT LPAD('123',5,'0');
SELECT RPAD('123',5,'0');

-- ============================================================
-- NUMERIC FUNCTIONS
-- ============================================================

SELECT ABS(-100);
SELECT CEIL(10.2);
SELECT CEILING(10.2);
SELECT FLOOR(10.9);
SELECT ROUND(10.567,2);
SELECT TRUNCATE(10.567,2);
SELECT MOD(10,3);
SELECT 10 % 3;
SELECT POWER(2,3);
SELECT SQRT(25);
SELECT SIGN(-50);
SELECT RAND();
SELECT GREATEST(10,25,15);
SELECT LEAST(10,25,15);
SELECT product_name, ROUND(price,2) AS rounded_price FROM products;

-- ============================================================
-- DATE AND TIME FUNCTIONS
-- ============================================================

SELECT NOW();
SELECT CURRENT_DATE();
SELECT CURRENT_TIME();
SELECT CURRENT_TIMESTAMP();
SELECT DATE('2026-09-17 18:30:45');
SELECT TIME('2026-09-17 18:30:45');
SELECT YEAR('2026-09-17');
SELECT MONTH('2026-09-17');
SELECT MONTHNAME('2026-09-17');
SELECT DAY('2026-09-17');
SELECT DAYNAME('2026-09-17');
SELECT DAYOFWEEK('2026-09-17');
SELECT HOUR('18:30:45');
SELECT MINUTE('18:30:45');
SELECT SECOND('18:30:45');
SELECT DATE_ADD('2026-09-17',INTERVAL 10 DAY);
SELECT DATE_SUB('2026-09-17',INTERVAL 10 DAY);
SELECT DATEDIFF('2026-09-17','2026-09-01');
SELECT TIMESTAMPDIFF(YEAR,'2000-05-10','2026-09-17');
SELECT DATE_FORMAT('2026-09-17','%d-%m-%Y');

SELECT first_name, DATE_FORMAT(hire_date,'%d-%m-%Y') AS joining_date
FROM employees;

SELECT first_name, YEAR(hire_date) AS joining_year
FROM employees;

-- ============================================================
-- AGGREGATE FUNCTIONS
-- ============================================================

SELECT COUNT(*) AS total_employees FROM employees;
SELECT COUNT(phone) AS employees_with_phone FROM employees;
SELECT SUM(salary) AS total_salary FROM employees;
SELECT AVG(salary) AS average_salary FROM employees;
SELECT MIN(salary) AS minimum_salary FROM employees;
SELECT MAX(salary) AS maximum_salary FROM employees;

SELECT COUNT(*) AS total_employees,
       SUM(salary) AS total_salary,
       AVG(salary) AS average_salary,
       MIN(salary) AS minimum_salary,
       MAX(salary) AS maximum_salary
FROM employees;

-- Basic GROUP BY example; detailed GROUP BY/HAVING is later.
SELECT department, COUNT(*) AS employee_count
FROM employees
GROUP BY department;

SELECT department, AVG(salary) AS average_salary
FROM employees
GROUP BY department;

-- ============================================================
-- NULL-HANDLING FUNCTIONS
-- ============================================================

SELECT IFNULL(NULL,'Not Available');

SELECT first_name, IFNULL(phone,'No Phone') AS phone
FROM employees;

SELECT COALESCE(NULL,NULL,'Hello','World');

SELECT name, COALESCE(phone,email,'No Contact') AS contact
FROM customers;

SELECT NULLIF(10,10);
SELECT NULLIF(10,20);

-- ============================================================
-- CONDITIONAL FUNCTIONS
-- ============================================================

SELECT IF(80 >= 40,'Pass','Fail');

SELECT name, marks,
       IF(marks >= 40,'Pass','Fail') AS result
FROM students;

SELECT name, marks,
       CASE
           WHEN marks >= 90 THEN 'A'
           WHEN marks >= 75 THEN 'B'
           WHEN marks >= 60 THEN 'C'
           WHEN marks >= 40 THEN 'D'
           ELSE 'F'
       END AS grade
FROM students;

SELECT first_name, salary,
       CASE
           WHEN salary >= 100000 THEN 'High'
           WHEN salary >= 50000 THEN 'Medium'
           ELSE 'Low'
       END AS salary_category
FROM employees;

-- ============================================================
-- CONVERSION FUNCTIONS
-- ============================================================

SELECT CAST('100' AS UNSIGNED);
SELECT CAST(price AS DECIMAL(10,2)) FROM products;
SELECT CONVERT('100',UNSIGNED);
SELECT CONVERT('2026-09-17',DATE);

-- ============================================================
-- SYSTEM / INFORMATION FUNCTIONS
-- ============================================================

SELECT VERSION();
SELECT DATABASE();
SELECT USER();
SELECT CONNECTION_ID();

-- ============================================================
-- JSON FUNCTIONS
-- ============================================================

SELECT JSON_OBJECT('name','Ravi','age',22);
SELECT JSON_ARRAY('Java','SQL','Python');
SELECT JSON_EXTRACT('{"name":"Ravi","age":22}','$.name');

-- ============================================================
-- FUNCTIONS WITH SELECT / WHERE / ORDER BY
-- ============================================================

SELECT first_name,
       UPPER(first_name) AS uppercase_name,
       LENGTH(first_name) AS name_length,
       ROUND(salary,2) AS rounded_salary
FROM employees;

SELECT *
FROM employees
WHERE UPPER(first_name) = 'RAVI';

SELECT *
FROM employees
WHERE YEAR(hire_date) = 2025;

SELECT first_name, salary
FROM employees
ORDER BY ROUND(salary,0) DESC;

-- ============================================================
-- COMBINING FUNCTIONS
-- ============================================================

SELECT CONCAT(UPPER(first_name),' ',UPPER(last_name)) AS full_name,
       ROUND(salary,2) AS salary,
       DATE_FORMAT(hire_date,'%d-%m-%Y') AS joining_date
FROM employees;

-- ============================================================
-- END OF CHAPTER 11
-- ============================================================
