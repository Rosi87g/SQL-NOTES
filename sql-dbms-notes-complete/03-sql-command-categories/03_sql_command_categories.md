# Chapter 3 --- SQL Command Categories

SQL can perform many different types of operations. To make these
operations easier to understand, SQL commands are divided into five main
categories, each with a specific responsibility.

-   DDL --- Data Definition Language

-   DML --- Data Manipulation Language

-   DQL --- Data Query Language

-   DCL --- Data Control Language

-   TCL --- Transaction Control Language

## 3.1 DDL --- Data Definition Language

DDL is used to define and manage the structure of a database. It works
with databases, tables, columns, data types, constraints, and other
database objects.

Common DDL commands:

  Command    Purpose
  ---------- ------------------------------------------------------
  CREATE     Creates a new database, table, or object
  ALTER      Changes the structure of an existing table
  RENAME     Renames a table or column
  TRUNCATE   Removes all rows from a table, keeping its structure
  DROP       Permanently deletes a table or database

Simple understanding: DDL creates or changes the structure that will
hold the data.

## 3.2 DML --- Data Manipulation Language

DML is used to manage the records stored inside database tables. It lets
you add new records, modify existing records, and remove selected
records.

  Command   Purpose
  --------- -----------------------------
  INSERT    Adds new records to a table
  UPDATE    Modifies existing records
  DELETE    Removes selected records

Simple understanding: DML works with the data stored inside the
structure.

## 3.3 DQL --- Data Query Language

DQL is used to retrieve information from a database. It lets you view
stored records, search for required information, filter and sort
records, calculate summaries, and combine information from different
tables.

The main DQL command is SELECT.

``` sql
SELECT column1, column2FROM table_nameWHERE condition;
```

Simple understanding: DQL asks questions about the stored data.

## 3.4 DCL --- Data Control Language

DCL is used to control access to databases and tables. It determines who
can access the database, what data a user can view, what operations a
user can perform, and which permissions should be removed.

  Command   Purpose
  --------- ----------------------------------------
  GRANT     Gives a user specific permissions
  REVOKE    Removes previously granted permissions

Simple understanding: DCL controls who is allowed to use the data.

## 3.5 TCL --- Transaction Control Language

TCL is used to manage related database changes as a single transaction.
It lets you permanently save changes, cancel changes, create checkpoints
during a transaction, and keep multi-step operations consistent.

  -----------------------------------------------------------------------
  Command                             Purpose
  ----------------------------------- -----------------------------------
  COMMIT                              Permanently saves all changes made
                                      in the transaction

  ROLLBACK                            Cancels changes made in the
                                      transaction

  SAVEPOINT                           Creates a checkpoint within a
                                      transaction to roll back to
  -----------------------------------------------------------------------

Simple understanding: TCL decides whether related changes should be
saved or cancelled.

## 3.6 How the Categories Connect

Imagine you are building a student management database:

  Category   Responsibility
  ---------- -------------------------------------------
  DDL        Creates the database and table structures
  DML        Adds or changes student records
  DQL        Retrieves required student information
  DCL        Controls who can access the information
  TCL        Saves or cancels related changes

### Quick Comparison Table

  -----------------------------------------------------------------------
  Category          Full Form         Main Purpose      Key Commands
  ----------------- ----------------- ----------------- -----------------
  DDL               Data Definition   Defines database  CREATE, ALTER,
                    Language          structure         DROP, TRUNCATE,
                                                        RENAME

  DML               Data Manipulation Manages stored    INSERT, UPDATE,
                    Language          records           DELETE

  DQL               Data Query        Retrieves         SELECT
                    Language          information       

  DCL               Data Control      Controls          GRANT, REVOKE
                    Language          permissions       

  TCL               Transaction       Manages           COMMIT, ROLLBACK,
                    Control Language  transactions      SAVEPOINT
  -----------------------------------------------------------------------

> 💡 Final TakeawaySQL is the language used to work with relational
> databases. DDL defines the structure, DML manages the records, DQL
> retrieves the data, DCL controls access, and TCL manages transactions.
> Each category is learned separately with its own commands and
> practical examples.

## Interview Questions — Chapter 3

Q1. What is the difference between DDL and DML?

Ideal answer: DDL changes database structure; DML changes the records
stored inside that structure.

Q2. What is DQL used for?

Ideal answer: DQL retrieves data. SELECT is the main DQL command in the
course notes.

Q3. What do DCL commands do?

Ideal answer: GRANT gives permissions and REVOKE removes previously
granted permissions.

Q4. What is TCL used for?

Ideal answer: TCL manages transactions using commands such as COMMIT,
ROLLBACK, and SAVEPOINT.

Q5. Which category does SELECT belong to?

Ideal answer: DQL in the classification used in these notes.