-- ============================================================================
-- CHAPTER 8 — Keys and Constraints
-- ============================================================================
-- Purpose : One fully-constrained table, then a series of labelled TEST
--           inserts that each try to break exactly ONE rule — so you can
--           see PRIMARY KEY, UNIQUE, NOT NULL, CHECK, DEFAULT and
--           AUTO_INCREMENT enforced individually, live.
-- Source  : Rewritten and cleaned up from employeee_management_db.sql
--           (fixed the "employeee" typo, tidied formatting, added
--           section comments mapping each constraint to its notes topic).
-- ============================================================================
CREATE DATABASE IF NOT EXISTS employee_constraints_db;
USE employee_constraints_db;

CREATE TABLE employees (

    -- PRIMARY KEY + AUTO_INCREMENT: uniquely identifies each row; MySQL
    -- generates the next ID automatically so it never needs to be typed in.
    employee_id INT PRIMARY KEY AUTO_INCREMENT,

    -- UNIQUE + NOT NULL: a real-world identifier that must never repeat,
    -- but is not the table's own primary key.
    employee_code CHAR(8) NOT NULL UNIQUE,
    -- NOT NULL: every employee must have a name on record.
    employee_name VARCHAR(60) NOT NULL,

    -- UNIQUE + NOT NULL: no two employees may share an email.
    official_email VARCHAR(100) NOT NULL UNIQUE,

    -- UNIQUE, but nullable: phone number must not repeat IF supplied,
    -- though one row is still allowed to leave it NULL.
    phone_number VARCHAR(15) NULL UNIQUE,

    department VARCHAR(40) NOT NULL,
    -- DEFAULT: falls back to 'Full-Time' when not supplied.
    -- (the matching CHECK rule is declared as a named, table-level
    -- constraint below — see chk_employment_type)
    employment_type VARCHAR(20) NOT NULL DEFAULT 'Full-Time',

    -- (CHECK rule: chk_annual_salary, declared below)
    annual_salary DECIMAL(12,2) NOT NULL,
    -- nullable, because a brand-new employee may not have a rating yet
    -- (CHECK rule: chk_performance_rating, declared below)
    performance_rating DECIMAL(3,1) NULL,

    date_of_joining DATE NOT NULL,

    -- DEFAULT: every new employee is active unless told otherwise.
    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    -- DEFAULT CURRENT_TIMESTAMP: automatically records when the row was created.
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    profile_note TEXT,
    -- ------------------------------------------------------------------
    -- Named, table-level CHECK constraints.
    -- Naming a constraint (CONSTRAINT symbol CHECK (...)) is optional,
    -- but it gives you a readable name in error messages instead of a
    -- generic one MySQL/MariaDB would auto-generate.
    -- ------------------------------------------------------------------
    CONSTRAINT chk_employment_type
        CHECK (employment_type IN ('Full-Time', 'Part-Time', 'Intern', 'Contract')),
    CONSTRAINT chk_annual_salary
        CHECK (annual_salary > 0),

    CONSTRAINT chk_performance_rating
        CHECK (performance_rating >= 1.0 AND performance_rating <= 5.0)
);

SHOW DATABASES;
SHOW TABLES;
DESCRIBE employees;

-- ============================================================================
-- TEST CASES — each one isolates a single constraint rule
-- ============================================================================
-- TEST 1: VALID RECORD
-- Every rule is satisfied -> this record is accepted.
INSERT INTO employees (
    employee_code, employee_name, official_email, phone_number,
    department, employment_type, annual_salary, performance_rating, date_of_joining
)
VALUES (
    'EMP00001', 'Asha', 'asha@gmail.com', '9876543210',
    'IT', 'Full-Time', 50000.00, 4.5, '2026-01-10'
);
-- TEST 2: DUPLICATE employee_code
-- Rejected -> employee_code has a UNIQUE constraint, 'EMP00001' already exists.
INSERT INTO employees (
    employee_code, employee_name, official_email, phone_number,
    department, employment_type, annual_salary, performance_rating, date_of_joining
)
VALUES (
    'EMP00001', 'Ravi', 'ravi@gmail.com', '9123456780',
    'HR', 'Full-Time', 40000.00, 4.0, '2026-02-10'
);
-- TEST 3: DUPLICATE official_email
-- Rejected -> official_email has a UNIQUE constraint, 'asha@gmail.com' already exists.
INSERT INTO employees (
    employee_code, employee_name, official_email, phone_number,
    department, employment_type, annual_salary, performance_rating, date_of_joining
)
VALUES (
    'EMP00002', 'Ravi', 'asha@gmail.com', '9123456780',
    'HR', 'Full-Time', 40000.00, 4.0, '2026-02-10'
);
-- TEST 4: MISSING employee_name
-- Rejected -> employee_name is NOT NULL and was left out of the column list.
INSERT INTO employees (
    employee_code, official_email, phone_number,
    department, employment_type, annual_salary, performance_rating, date_of_joining
)
VALUES (
    'EMP00003', 'john@gmail.com', '9123456781',
    'IT', 'Full-Time', 45000.00, 4.0, '2026-03-01'
);
-- TEST 5: INVALID employment_type
-- Rejected -> 'Temporary' is not in the CHECK's allowed list.
INSERT INTO employees (
    employee_code, employee_name, official_email, phone_number,
    department, employment_type, annual_salary, performance_rating, date_of_joining
)
VALUES (
    'EMP00004', 'John', 'john@gmail.com', '9123456781',
    'IT', 'Temporary', 45000.00, 4.0, '2026-03-01'
);
-- TEST 6: ZERO / NEGATIVE annual_salary
-- Rejected -> CHECK requires annual_salary > 0.
INSERT INTO employees (
    employee_code, employee_name, official_email, phone_number,
    department, employment_type, annual_salary, performance_rating, date_of_joining
)
VALUES (
    'EMP00005', 'Mike', 'mike@gmail.com', '9123456782',
    'Finance', 'Full-Time', 0, 4.0, '2026-03-01'
);
-- TEST 7: INVALID performance_rating
-- Rejected -> CHECK allows only 1.0-5.0, and 6.0 is out of range.
INSERT INTO employees (
    employee_code, employee_name, official_email, phone_number, department, employment_type, annual_salary, performance_rating, date_of_joining
)
VALUES (
    'EMP00006', 'Peter', 'peter@gmail.com', '9123456783',
    'IT', 'Full-Time', 50000.00, 6.0, '2026-03-01'
);
-- TEST 8: NULL performance_rating
-- Accepted -> performance_rating is nullable (no NOT NULL on this column).
INSERT INTO employees (
    employee_code, employee_name, official_email, phone_number, department, employment_type, annual_salary, performance_rating, date_of_joining
)
VALUES (
    'EMP00007', 'Sarah', 'sarah@gmail.com', '9123456784',
    'IT', 'Full-Time', 50000.00, NULL, '2026-03-01'
);
-- Only TEST 1, TEST 8 (and any others that satisfy every rule) actually
-- make it into the table — verify below.
SELECT * FROM employees;


-- ============================================================================
-- Composite Key Example
-- ============================================================================
-- A composite primary key uses two or more columns together.
DROP TABLE IF EXISTS order_items;
CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (order_id, product_id)
);

INSERT INTO order_items (order_id, product_id, quantity)
VALUES
    (1001, 501, 2),
    (1001, 502, 1),
    (1002, 501, 3);

SELECT * FROM order_items;

-- ============================================================================
-- Foreign Key Example
-- ============================================================================
-- The child table references a key in the parent table.
DROP TABLE IF EXISTS marks;
DROP TABLE IF EXISTS key_demo_students;

CREATE TABLE key_demo_students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50) NOT NULL
);

CREATE TABLE marks (
    mark_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    subject VARCHAR(50) NOT NULL,
    score INT CHECK (score BETWEEN 0 AND 100),
    CONSTRAINT fk_marks_student
        FOREIGN KEY (student_id)
        REFERENCES key_demo_students(student_id)
);

INSERT INTO key_demo_students (student_id, student_name)
VALUES
    (101, 'Asha'),
    (102, 'Amit');

INSERT INTO marks (student_id, subject, score)
VALUES
    (101, 'SQL', 88),
    (102, 'SQL', 81);

SELECT * FROM marks;

-- This would fail because student_id 999 does not exist in the parent table:
-- INSERT INTO marks (student_id, subject, score)
-- VALUES (999, 'SQL', 75);
