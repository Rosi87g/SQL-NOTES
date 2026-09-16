# Chapter 2 --- Understanding DBMS, RDBMS and SQL

Applications generate and use huge amounts of data. That data has to be
stored, retrieved, updated, and protected efficiently. DBMS, RDBMS, and
SQL work together to make this possible.

The relationship in one line: A database stores the data, an RDBMS
manages relational databases, and SQL is the language used to
communicate with the RDBMS.

## 2.1 What Is a Database?

A database is an organized collection of related data. For example, a
college database may store:

-   Student details

-   Course details

-   Attendance

-   Examination marks

-   Placement information

A database contains the data, but software is required to manage it ---
that software is called a DBMS.

## 2.2 What Is a DBMS?

DBMS stands for Database Management System. It is software that allows
you to create, store, retrieve, update, and delete data in a database. A
DBMS provides an interface between:

-   The user or application

-   The stored data

Without a DBMS, applications would need to manage stored data directly.

### Responsibilities of a DBMS

A DBMS helps you:

-   Create databases

-   Store data

-   Retrieve required data

-   Modify existing data

-   Remove unwanted data

-   Control access to data

-   Protect data from unauthorized users

-   Maintain consistency

-   Support backup and recovery

Examples of database management systems: MySQL, PostgreSQL, Oracle
Database, Microsoft SQL Server, SQLite, MongoDB. These systems do not
all store data using the same model --- systems based on the relational
model are called RDBMSs.

## 2.3 What Is an RDBMS?

RDBMS stands for Relational Database Management System. An RDBMS is a
type of DBMS that stores data in related tables. Each table contains:

-   Columns --- the properties or attributes of the data

-   Rows --- the individual records

-   Keys --- columns used to identify and connect records

### Example --- a Students table

  StudentID   StudentName   Branch
  ----------- ------------- --------
  101         Aarav         CSE
  102         Bhavna        ECE
  103         Charan        CSE

-   Students is the table.

-   StudentID, StudentName and Branch are columns.

-   Each student is represented by one row.

-   StudentID can uniquely identify each student.

### Relationships Between Tables

Suppose the database also contains a Marks table:

  MarkID   StudentID   Subject   Score
  -------- ----------- --------- -------
  1        101         SQL       85
  2        102         SQL       78
  3        101         Python    90

The StudentID column connects the Students and Marks tables. This
relationship lets the database answer questions such as:

-   What marks did Aarav receive?

-   Which students scored above 80?

-   What is the average score of each student?

### Important Features of an RDBMS

-   Data is organized into tables.

-   Every table can have a primary key.

-   Tables can be connected using foreign keys.

-   Constraints maintain valid data.

-   Duplicate and inconsistent data can be reduced.

-   Multiple users can work with the database.

-   Transactions help maintain data consistency.

Examples of RDBMSs: MySQL, PostgreSQL, Oracle Database, Microsoft SQL
Server, SQLite.

## 2.4 DBMS vs RDBMS

RDBMS is not separate from DBMS --- it is a specialized type of DBMS.
Every RDBMS is a DBMS, but every DBMS is not necessarily an RDBMS.

  -----------------------------------------------------------------------
  DBMS                                RDBMS
  ----------------------------------- -----------------------------------
  General term for software that      A DBMS based on the relational
  manages databases                   model

  Can use different data models       Organizes data into related tables

  Relationships are not required in   Relationships are established using
  every model                         keys

  Structure depends on the database   Uses rows, columns, tables and
  model                               constraints

  Examples include relational and     Examples include MySQL, PostgreSQL
  non-relational systems              and Oracle Database
  -----------------------------------------------------------------------

## 2.5 What Is SQL?

SQL stands for Structured Query Language. SQL is the language used to
communicate with a relational database management system. You write SQL
commands, and the RDBMS executes them on the database.

SQL can be used to:

-   Create databases and tables

-   Insert records

-   Retrieve records

-   Filter and sort data

-   Update records

-   Delete records

-   Combine data from multiple tables

-   Calculate totals and averages

-   Control user permissions

-   Manage transactions

### Examples of SQL Commands

Create a table:

``` sql
CREATE TABLE Students (  StudentID   INT PRIMARY KEY,  StudentName VARCHAR(50),  Branch      VARCHAR(20));
```

Insert a record:

``` sql
INSERT INTO StudentsVALUES (101, 'Aarav', 'CSE');
```

Retrieve records:

``` sql
SELECT *FROM Students;
```

Update a record:

``` sql
UPDATE StudentsSET Branch = 'ISE'WHERE StudentID = 101;
```

Delete a record:

``` sql
DELETE FROM StudentsWHERE StudentID = 101;
```

## 2.6 How They Work Together

Suppose a college wants to manage student data:

-   The student information is stored in a database.

-   MySQL manages that database, so MySQL is the RDBMS.

-   You write SQL commands to create, retrieve, and modify the data.

  Term       Role in the College Application
  ---------- -----------------------------------------
  Database   Contains student, course and marks data
  DBMS       Software that manages the database
  RDBMS      Manages data using related tables
  MySQL      The RDBMS being used
  SQL        Language used to communicate with MySQL

### SQL and MySQL Are Not the Same

-   SQL is a language.

-   MySQL is an RDBMS that understands SQL.

Other RDBMSs --- such as PostgreSQL, Oracle Database, and SQL Server ---
also use SQL, though their syntax may differ slightly for some
operations.

A useful comparison: SQL is the language, while MySQL is the software
that understands and executes that language.

### Common Confusions, Cleared Up

  -----------------------------------------------------------------------
  Question                            Answer
  ----------------------------------- -----------------------------------
  Is a database the same as a DBMS?   No. A database contains the data. A
                                      DBMS is the software used to manage
                                      that data.

  Are DBMS and RDBMS opposites?       No. RDBMS is one type of DBMS.

  Is SQL a database?                  No. SQL is a language used to work
                                      with relational databases.

  Is MySQL a programming language?    No. MySQL is an RDBMS. It accepts
                                      and executes SQL commands.

  Can SQL be used with every          SQL is mainly used with relational
  database?                           databases. Non-relational databases
                                      may use different query languages
                                      or APIs.
  -----------------------------------------------------------------------

## Interview Questions — Chapter 2

Q1. Is every DBMS an RDBMS?

Ideal answer: No. RDBMS is a type of DBMS based on the relational model.

Q2. Is MySQL the same as SQL?

Ideal answer: No. SQL is a language; MySQL is an RDBMS that accepts and
executes SQL.

Q3. Why are relationships important in an RDBMS?

Ideal answer: Relationships connect related records across tables using
keys, allowing related information to be retrieved without storing
everything in one table.

Q4. What is the role of a DBMS?

Ideal answer: It manages operations such as storing, retrieving,
updating, deleting, access control, consistency, backup, and recovery.

Q5. Can non-relational databases use SQL?

Ideal answer: Some non-relational systems may provide SQL-like languages
or SQL interfaces, but SQL is primarily associated with relational
databases.