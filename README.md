# SQL Data Analysis with CASE Statements

## Project Overview
This project demonstrates the use of advanced SQL, particularly the `CASE` statement, to perform data analysis on an employee and customer database. The queries cover data transformation, categorization, aggregation with joins, and data pivoting.

## Tools Used
- **Database:** PostgreSQL
- **IDE:** pgAdmin 4

## Key SQL Concepts Demonstrated
- **`CASE` Statements:** For conditional logic and data transformation.
- **Aggregate Functions:** `COUNT()`, `SUM()`, `AVG()`.
- **`JOIN`s:** Combining data from multiple tables (`employees`, `departments`, `salaries`, etc.).
- **Subqueries / CTEs:** For complex, multi-step queries.
- **Data Pivoting:** Transforming row data into columns.

## How to Run
1.  Create a new database in PostgreSQL.
2.  Run the `01_create_tables.sql` script to create the necessary table structures.
3.  Run the `02_import_employee_data.sql` script to populate the `employees` table.
4.  Import the `customers.csv` file into the `customers` table.
5.  The remaining `.sql` files contain the analysis queries and can be run to see the project's results.

## Example Query: Gender Count by Department (Pivoting)
