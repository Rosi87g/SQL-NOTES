-- ============================================================================
-- CHAPTER 6 — SQL Data Types
-- ============================================================================
-- Purpose : One table that showcases every data-type category covered in
--           Chapter 6: numeric (incl. UNSIGNED), CHAR / VARCHAR / TEXT,
--           DATE / DATETIME / YEAR, and BOOLEAN.
--           No keys or constraints here on purpose — that is Chapter 8.
-- Source  : Rewritten and merged from employee_management_db.sql
--           (base table) + student_profile.sql (YEAR type) +
--           order_management_db.sql (INT UNSIGNED usage).
-- ============================================================================
CREATE DATABASE IF NOT EXISTS employee_management_db;
USE employee_management_db;

CREATE TABLE IF NOT EXISTS employee_management (
    -- Numeric types -----------------------------------------------------
    employee_id          INT,                    -- whole number, general-purpose ID
    years_of_experience  INT UNSIGNED,            -- never negative -> UNSIGNED doubles usable range
    annual_salary        DECIMAL(10,2),           -- exact fixed-point value -> correct choice for money
    performance_rating   DECIMAL(2,1),            -- small exact decimal, e.g. 4.5
    -- Text types ----------------------------------------------------------
    employee_name    VARCHAR(50),   -- variable-length text, length differs per person
    official_email   VARCHAR(100),  -- variable-length text
    phone_number     VARCHAR(15),   -- stored as text, not a number (no arithmetic needed on it)
    department_code  CHAR(5),       -- always the SAME length -> fixed-length CHAR is efficient here
    job_title        VARCHAR(50),
    profile_notes    LONGTEXT,      -- long free-form text with no fixed maximum in practice
    -- Date & time types -----------------------------------------------------
    date_of_joining  DATE,          -- only the date is needed (no time-of-day component)
    graduation_year  YEAR,          -- stores just a 4-digit year, e.g. 2026
    last_login_at    DATETIME,      -- date + time together, not tied to a time zone

    -- Boolean --------------------------------------------------------------
    is_active  BOOLEAN              -- MySQL alias for TINYINT(1): 0 = FALSE, 1 = TRUE
);
-- ----------------------------------------------------------------------------
-- Inspect the structure
-- ----------------------------------------------------------------------------
SHOW TABLES;
DESCRIBE employee_management;
-- ----------------------------------------------------------------------------
-- Insert one sample row to see quoting rules from Chapter 6 in practice:
--   - text values          -> single quotes
--   - numeric values       -> no quotes
--   - date/year values     -> single quotes, YYYY-MM-DD format
--   - boolean value        -> plain TRUE / FALSE (stored internally as 1 / 0)
-- ----------------------------------------------------------------------------
INSERT INTO employee_management (
    employee_id, years_of_experience, annual_salary, performance_rating,
    employee_name, official_email, phone_number, department_code, job_title, profile_notes,
    date_of_joining, graduation_year, last_login_at, is_active
)
VALUES (
    101, 3, 650000.00, 4.5,
    'Asha Patil', 'asha@company.com', '9876543210', 'ENG01', 'Software Developer',
    'Consistently delivers high-quality work.',
    '2023-06-10', 2020, '2026-09-10 09:15:00', TRUE
);
-- Verify the inserted row and see how each data type is stored/displayed
SELECT * FROM employee_management;
