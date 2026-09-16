# Chapter 4 --- Database, Schema, Table, Row and Column

Relational databases organize data in a clear structure. Before creating
a database, you need to understand the different levels used to store
and arrange data.

The structure can be viewed as: MySQL Server → Database/Schema → Table →
Rows and Columns → Values

## 4.1 Database

A database is an organized collection of related data. It acts as a main
container that holds:

-   Tables

-   Relationships

-   Views

-   Indexes

-   Other database objects

For example, a college may create a database called CollegeManagement,
which can contain information about:

-   Students

-   Courses

-   Trainers

-   Attendance

-   Marks

-   Placements

All this information belongs to the same college application, so it can
be stored inside one database.

## 4.2 Schema

A schema represents the logical organization or design of a database. It
describes:

-   What tables exist

-   What columns each table contains

-   What type of data each column stores

-   How tables are connected

-   What rules are applied to the data

A schema can be understood as the blueprint of a database.

For example, a college database schema may define a Students table, a
Courses table, an Enrollments table, and the relationship between
students and courses.

### Schema in MySQL

In MySQL, the terms database and schema are generally used
interchangeably. Therefore, when MySQL Workbench displays a section
called Schemas, it is showing the databases available on the MySQL
server.

## 4.3 Table

A table stores data about one particular type of entity. An entity is
something about which data is stored. Examples include: Student,
Employee, Product, Customer, Course. A table organizes data using rows
and columns.

Consider a Students table:

  StudentID   StudentName   Branch   City
  ----------- ------------- -------- -----------
  101         Aarav         CSE      Bengaluru
  102         Bhavna        ECE      Pune
  103         Charan        CSE      Hyderabad

The table stores information about multiple students. A database can
contain many tables, and each table should normally represent one main
entity or concept.

## 4.4 Column

A column represents one property or attribute of an entity. In the
Students table:

-   StudentID represents the student's identification number.

-   StudentName represents the student's name.

-   Branch represents the student's branch.

-   City represents the student's city.

Every column has a column name, a data type, and rules or constraints
(when required). A column defines what kind of information can be stored
in that part of the table. Columns are also sometimes called fields or
attributes.

## 4.5 Row

A row represents one complete record in a table. Consider this row:

  StudentID   StudentName   Branch   City
  ----------- ------------- -------- -----------
  101         Aarav         CSE      Bengaluru

This row contains all the stored information about one student. In the
complete Students table, the first row represents Aarav, the second row
represents Bhavna, and the third row represents Charan. Rows are also
called records.

## 4.6 Value

A value is the actual data stored at the intersection of a row and a
column. In the record below:

  StudentID   StudentName   Branch   City
  ----------- ------------- -------- -----------
  101         Aarav         CSE      Bengaluru

-   101 is the value under StudentID.

-   Aarav is the value under StudentName.

-   CSE is the value under Branch.

-   Bengaluru is the value under City.

Each value belongs to one row and one column.

## 4.7 Complete Structure

Suppose a MySQL server contains a college application:

  -----------------------------------------------------------------------
  Level                   Example                 Purpose
  ----------------------- ----------------------- -----------------------
  MySQL Server            Local MySQL Server      Manages databases

  Database / Schema       CollegeManagement       Contains related
                                                  database objects

  Table                   Students                Stores information
                                                  about students

  Column                  StudentName             Defines one property

  Row                     Aarav's complete record Represents one student

  Value                   Aarav                   Stores the actual data
  -----------------------------------------------------------------------

### Database and Table Are Not the Same

A database is the complete container, while a table stores data about
one particular entity. For example, database CollegeManagement may
contain the Students, Courses, Trainers, Attendance, and Marks tables.
The database contains the tables --- a table does not contain the
database.

### Row and Column Are Not the Same

  -----------------------------------------------------------------------
  Row                                 Column
  ----------------------------------- -----------------------------------
  Represents one complete record      Represents one property

  Moves horizontally across the table Moves vertically through the table

  Example: one student                Example: names of all students

  Also called a record                Also called a field or attribute
  -----------------------------------------------------------------------

## 4.8 Mental Model

Think of a database as a collection of organized registers, kept in a
cupboard:

  Real-world object                      Database concept
  -------------------------------------- ------------------
  The complete cupboard                  The database
  The arrangement of registers           The schema
  Each register                          A table
  Each heading in a register             A column
  Each filled entry                      A row
  Each individual piece of information   A value

> 💡 Final TakeawayA database contains related data and database
> objects. A schema describes how the database is organized (in MySQL,
> database and schema usually refer to the same thing). A table stores
> data about one type of entity. A column represents one property. A row
> represents one complete record. A value is the actual data stored
> inside a table.

## Interview Questions — Chapter 4

Q1. Database vs table?

Ideal answer: A database is a container for related database objects; a
table stores records for one entity or concept.

Q2. Row vs column?

Ideal answer: A row is one complete record; a column is one property or
attribute shared by the records.

Q3. What is a schema?

Ideal answer: A schema is the logical blueprint describing tables,
columns, data types, relationships, and rules. In MySQL, database and
schema are generally used interchangeably.

Q4. What is a value?

Ideal answer: A value is the actual piece of data stored at the
intersection of a row and a column.

Q5. Can one database contain multiple tables?

Ideal answer: Yes. A college database can contain Students, Courses,
Attendance, Marks, and Placements tables.