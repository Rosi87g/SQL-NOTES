# Chapter 7 --- Modifying Database Structure

Once a table has been created, its structure is rarely final.
Applications grow, and new requirements appear --- a new column may be
needed, an existing column's type may need to change, or an entire table
may need to be renamed or emptied. The ALTER TABLE command is the DDL
tool used to modify an existing table's structure without rebuilding it
from scratch.

## 7.1 Adding, Modifying and Removing Columns Using ALTER TABLE

Starting table used for all examples in this chapter:

``` sql
CREATE TABLE Students (  StudentID   INT PRIMARY KEY,  StudentName VARCHAR(50),  Branch      VARCHAR(20));
```

### Adding a Column --- ADD COLUMN

Adds a new column to an existing table.

``` sql
ALTER TABLE StudentsADD COLUMN Email VARCHAR(100);
```

You can also control where the new column appears using AFTER or FIRST:

``` sql
ALTER TABLE StudentsADD COLUMN Age INT AFTER StudentName;
```

You can add more than one column in a single statement:

``` sql
ALTER TABLE StudentsADD COLUMN City VARCHAR(30),ADD COLUMN Pincode VARCHAR(10);
```

### Modifying a Column --- MODIFY COLUMN

Changes the data type or definition of an existing column, while keeping
its name the same.

``` sql
ALTER TABLE StudentsMODIFY COLUMN Email VARCHAR(150);
```

MODIFY can also add or remove constraints such as NOT NULL:

``` sql
ALTER TABLE StudentsMODIFY COLUMN Branch VARCHAR(20) NOT NULL;
```

### Renaming and Changing a Column Together --- CHANGE COLUMN

CHANGE lets you rename a column and redefine its type in the same
statement (MODIFY cannot rename a column).

``` sql
ALTER TABLE StudentsCHANGE COLUMN Email StudentEmail VARCHAR(150);
```

### Removing a Column --- DROP COLUMN

Permanently removes a column and all the data stored in it.

``` sql
ALTER TABLE StudentsDROP COLUMN Pincode;
```

DROP COLUMN cannot be undone --- the data in that column is permanently
lost once the statement runs.

### Quick Reference --- ALTER TABLE Column Operations

  -----------------------------------------------------------------------
  Goal                    Syntax                  Can Rename?
  ----------------------- ----------------------- -----------------------
  Add a column            ADD COLUMN col_name     ---
                          datatype                

  Change a column's       MODIFY COLUMN col_name  No
  type/constraints        new_datatype            

  Rename + redefine a     CHANGE COLUMN old_name  Yes
  column                  new_name datatype       

  Remove a column         DROP COLUMN col_name    ---
  -----------------------------------------------------------------------

## 7.2 Renaming Columns and Tables

### Renaming a Table

Two equivalent ways to rename an entire table:

``` sql
RENAME TABLE Students TO Learners;
```

or

``` sql
ALTER TABLE StudentsRENAME TO Learners;
```

### Renaming a Column

MySQL 8.0 and later supports a direct RENAME COLUMN clause:

``` sql
ALTER TABLE StudentsRENAME COLUMN StudentName TO FullName;
```

On older MySQL versions, use CHANGE COLUMN instead (you must repeat the
data type):

``` sql
ALTER TABLE StudentsCHANGE COLUMN StudentName FullName VARCHAR(50);
```

Renaming a table or column does not affect the data inside it --- only
its name changes. However, any queries, views, or application code that
reference the old name must be updated separately.

## 7.3 Understanding TRUNCATE and DROP

TRUNCATE, DROP, and DELETE are sometimes confused because they can all
appear to "remove data" --- but they operate very differently.

### TRUNCATE TABLE

Removes all rows from a table instantly, but keeps the table's structure
(columns, data types, constraints) intact so it can be reused
immediately.

``` sql
TRUNCATE TABLE Students;
```

-   Deletes all rows --- cannot be used with a WHERE clause.

-   Resets any AUTO_INCREMENT counter back to its starting value.

-   Is a DDL operation --- much faster than DELETE for clearing an
    entire table, and generally cannot be rolled back.

-   The table itself still exists and can be used right away.

### DROP TABLE

Permanently deletes the entire table --- its structure, its data, its
indexes, and its constraints --- from the database.

``` sql
DROP TABLE Students;
```

-   The table no longer exists after this command runs.

-   Any indexes, constraints, and permissions tied to the table are
    removed as well.

-   Cannot be undone (without a backup).

DROP can also remove an entire database:

``` sql
DROP DATABASE sql_course;
```

### DELETE (for comparison)

Unlike TRUNCATE and DROP, DELETE is a DML command that removes rows one
at a time and can be filtered with WHERE, making it reversible inside a
transaction.

``` sql
DELETE FROM Students WHERE Branch = 'ECE';
```

### TRUNCATE vs DROP vs DELETE --- Comparison

  -----------------------------------------------------------------------
  Feature           TRUNCATE          DROP              DELETE
  ----------------- ----------------- ----------------- -----------------
  Command type      DDL               DDL               DML

  What it removes   All rows only     Entire table      Selected rows (or
                                      (structure +      all, if no WHERE)
                                      data)             

  Table structure   Still exists,     No longer exists  Still exists
  after             empty                               

  Supports WHERE    No                No                Yes
  clause                                                

  Speed             Very fast         Very fast         Slower
                                                        (row-by-row)

  AUTO_INCREMENT    Reset to start    Removed with the  Not reset
  counter                             table             

  Can be rolled     Generally no      Generally no      Yes, within a
  back                                                  transaction
  -----------------------------------------------------------------------

> 💡 How to Remember ItTRUNCATE empties the room but keeps the house
> standing. DROP demolishes the house completely. DELETE removes chosen
> items from the room, one at a time, and lets you put them back if you
> change your mind before saving.

## 7.4 Interview Questions --- Chapter 7

Q1. What is the difference between MODIFY and CHANGE in ALTER TABLE?

Ideal answer: MODIFY changes a column's data type or constraints but
keeps its name the same. CHANGE can rename the column and redefine its
type in the same statement --- MODIFY alone cannot rename a column.

Q2. What is the difference between TRUNCATE and DELETE?

Ideal answer: TRUNCATE is a DDL command that removes all rows at once,
resets AUTO_INCREMENT, and cannot use a WHERE clause. DELETE is a DML
command that removes rows one at a time, can be filtered with WHERE, and
can be rolled back within a transaction.

Q3. What is the difference between TRUNCATE and DROP?

Ideal answer: TRUNCATE empties a table but keeps its structure so it can
be reused immediately. DROP removes the table entirely --- its
structure, data, indexes, and constraints --- and the table no longer
exists afterward.

Q4. How do you add a new column to an existing table?

Ideal answer: Using ALTER TABLE with ADD COLUMN, e.g. ALTER TABLE
Students ADD COLUMN Email VARCHAR(100);

## Interview Questions — Chapter 7

Q1. MODIFY vs CHANGE in ALTER TABLE?

Ideal answer: MODIFY changes a column's definition while keeping its
name. CHANGE can rename the column and redefine its type.

Q2. TRUNCATE vs DROP?

Ideal answer: TRUNCATE removes all rows but keeps the table structure;
DROP removes the table itself, including its structure and data.

Q3. Can TRUNCATE use WHERE?

Ideal answer: No. TRUNCATE removes all rows.

Q4. What does ALTER TABLE do?

Ideal answer: It changes an existing table's structure, such as adding,
modifying, renaming, or removing columns.

Q5. Does renaming a column automatically update application code?

Ideal answer: No. Queries, views, procedures, or application code that
reference the old name may need separate updates.