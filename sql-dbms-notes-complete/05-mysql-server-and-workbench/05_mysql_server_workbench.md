# Chapter 5 --- Installing MySQL Server and MySQL Workbench

To practise SQL on your computer, you need to install two applications:

  -----------------------------------------------------------------------
  Application                         Role
  ----------------------------------- -----------------------------------
  MySQL Server                        Stores databases and executes SQL
                                      queries

  MySQL Workbench                     Provides a graphical interface for
                                      writing queries and working with
                                      MySQL Server
  -----------------------------------------------------------------------

MySQL Workbench alone is not enough --- the server must also be
installed and running.

## 5.1 System Requirements

-   A Windows computer

-   Administrator access

-   A stable internet connection

-   At least 2 GB of free storage

## 5.2 Step-by-Step Installation

### Step 1 --- Download the MySQL Installer

-   Open the official MySQL Installer download page.

-   You will see two installer options --- Web Installer (smaller,
    downloads components during installation) or Full Installer (larger,
    contains all required components). Download the Web Installer if you
    have a stable internet connection.

-   Click Download.

-   If the website asks you to sign in, click "No thanks, just start my
    download".

### Step 2 --- Start the Installer

-   Open the downloaded .msi file and allow it to make changes to your
    computer.

-   Select Developer Default as the setup type. This normally installs
    MySQL Server, MySQL Workbench, MySQL Shell, and required
    connectors/tools.

-   Click Next. (If Developer Default is unavailable, select Custom and
    manually choose MySQL Server and MySQL Workbench.)

### Step 3 --- Install the Required Components

-   The installer may check for additional software required by MySQL
    --- click Execute to install the requirements.

-   Wait until all required components show a completed status, then
    click Next.

-   Click Execute again to install MySQL Server and MySQL Workbench.

-   After all products are installed successfully, click Next.

### Step 4 --- Configure MySQL Server

Use the following settings and keep everything else at its default:

  Setting                Value
  ---------------------- ----------------------------
  Server Configuration   Standalone MySQL Server
  Configuration Type     Development Computer
  Connectivity           TCP/IP
  Port                   3306
  Authentication         Strong Password Encryption

### Step 5 --- Create the Root Password

The root user is the administrator account for MySQL.

-   Enter a password for the root user.

-   Re-enter the same password to confirm it.

-   Write down or safely store the password --- you will need it to
    connect through Workbench (Username: root, Password: the one you
    just created).

Do not forget the root password.

### Step 6 --- Configure the Windows Service

MySQL runs as a Windows service in the background.

-   Keep "Configure MySQL Server as a Windows Service" selected.

-   Keep the default service name shown by the installer.

-   Select "Start the MySQL Server at System Startup".

-   Keep "Standard System Account" selected, then click Next.

Starting MySQL with Windows ensures the server is available whenever you
open Workbench.

### Step 7 --- Apply the Configuration

-   Click Execute and wait while the installer applies the
    configuration.

-   Confirm that every configuration step shows a success status.

-   Click Finish, then continue through the remaining screens to
    complete the installation.

### Step 8 --- Open MySQL Workbench

-   Open the Windows Start menu and search for MySQL Workbench.

-   Under MySQL Connections, select the local connection (it may appear
    as "Local instance MySQL" or "Local instance 3306").

-   Enter the root password created during installation.

-   Optionally select "Save password in vault" so you don't enter it
    every time, then click OK.

The SQL Editor will open once the connection is successful.

### Step 9 --- Verify the Installation

Open a new SQL tab and execute:

``` sql
SELECT VERSION();
```

This displays the installed MySQL Server version. Next, execute:

``` sql
SHOW DATABASES;
```

You should see the databases currently available on your server.

### Step 10 --- Create a Test Database

``` sql
CREATE DATABASE sql_course;USE sql_course;CREATE TABLE Students (  StudentID   INT PRIMARY KEY,  StudentName VARCHAR(50));INSERT INTO StudentsVALUES (101, 'Aarav');SELECT * FROM Students;
```

Expected output:

  StudentID   StudentName
  ----------- -------------
  101         Aarav

If this result appears, MySQL Server and MySQL Workbench have been
installed and connected successfully.

## 5.3 How the Connection Works

You write a query in MySQL Workbench → Workbench sends the query to
MySQL Server → MySQL Server executes the query → Workbench displays the
result. MySQL Workbench is the interface, while MySQL Server performs
the actual database operations.

## 5.4 Common Installation Problems

  -----------------------------------------------------------------------
  Problem                             Likely Cause / Fix
  ----------------------------------- -----------------------------------
  Cannot connect to MySQL Server      The MySQL service may not be
                                      running. Press Windows + R, enter
                                      services.msc, find the MySQL
                                      service, right-click it and select
                                      Start or Restart.

  Access denied for user root         The entered root password is
                                      incorrect. Enter the same password
                                      created during server
                                      configuration.

  Workbench installed but no local    MySQL Server may not have been
  connection appears                  installed. Run MySQL Installer
                                      again and add MySQL Server.

  Port 3306 is unavailable            Another application may already be
                                      using port 3306. Select another
                                      available port, such as 3307, and
                                      use it when creating the Workbench
                                      connection.
  -----------------------------------------------------------------------

### Server Connection Settings (Local Installation)

  Setting    Value
  ---------- -------------------------------------------
  Hostname   localhost
  Port       3306
  Username   root
  Password   Root password created during installation

> 💡 Final CheckYour installation is complete when: MySQL Server is
> installed, the MySQL Windows service is running, MySQL Workbench opens
> successfully, Workbench connects to the local server, and SQL queries
> execute without connection errors.

## Interview Questions — Chapter 5

Q1. Is MySQL Workbench the database server?

Ideal answer: No. Workbench is a graphical client/interface; MySQL
Server stores data and executes SQL.

Q2. What is the default MySQL port used in the notes?

Ideal answer: 3306.

Q3. What does localhost mean in a local MySQL connection?

Ideal answer: It refers to the same computer on which the MySQL Server
is running.

Q4. Why can Workbench open but queries still fail?

Ideal answer: Workbench can be installed while the MySQL Server service
is stopped or misconfigured; the client still needs a working server
connection.

Q5. How do you verify a successful installation?

Ideal answer: Connect to the server and run SELECT VERSION() and SHOW
DATABASES, then create a small test database/table and execute a SELECT.