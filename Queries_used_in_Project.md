### 1. Creating the Tables

**Employees Table:**

```sql
CREATE TABLE employees (
  emp_no INT PRIMARY KEY,
  birth_date DATE,
  first_name VARCHAR(14),
  last_name VARCHAR(16),
  gender CHAR(1),
  hire_date DATE
);
```

**Customers Table (Final Version):**

```sql
CREATE TABLE customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    bracket_cust_id VARCHAR(50),
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    age INT,
    country VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    postal_code VARCHAR(20),
    region VARCHAR(50)
);
```


### 2. Basic CASE Statement (Categorizing Gender)

```sql
SELECT
  emp_no,
  first_name,
  last_name,
  gender,
  CASE
    WHEN gender = 'M' THEN 'Male'
    WHEN gender = 'F' THEN 'Female'
    ELSE 'Unknown'
  END AS gender_full
FROM employees;
```


### 3. CASE Statement on Customer Data (Categorizing Age)

```sql
SELECT
  customer_name,
  segment,
  age,
  CASE
    WHEN age < 30 THEN 'Young'
    WHEN age BETWEEN 30 AND 59 THEN 'Adult'
    WHEN age >= 60 THEN 'Senior'
    ELSE 'Unknown'
  END AS age_category
FROM customers;
```


### 4. Multiple Conditions in CASE (Categorizing by Hire Date)

```sql
SELECT
  emp_no,
  first_name,
  last_name,
  hire_date,
  CASE
    WHEN EXTRACT(YEAR FROM hire_date) < 1990 THEN 'Before 1990'
    WHEN EXTRACT(YEAR FROM hire_date) BETWEEN 1990 AND 1995 THEN 'Between 1990 and 1995'
    ELSE 'After 1995'
  END AS employment_period
FROM employees;
```


### 5. CASE with Aggregate Functions (Salary Analysis)

**Categorizing Average Salary per Employee (with rounding):**

```sql
SELECT
    emp_no,
    ROUND(AVG(salary), 2) AS average_salary,
    CASE
        WHEN AVG(salary) >= 80000 THEN 'High Salary'
        WHEN AVG(salary) >= 60000 AND AVG(salary) < 80000 THEN 'Medium Salary'
        ELSE 'Low Salary'
    END AS salary_category
FROM
    salaries
GROUP BY
    emp_no
ORDER BY
    emp_no;
```

**Counting Employees in Each Salary Category (using Subquery):**

```sql
SELECT
    salary_category,
    COUNT(*) AS number_of_employees
FROM
    (
        SELECT
            CASE
                WHEN AVG(salary) >= 80000 THEN 'High Salary'
                WHEN AVG(salary) >= 60000 AND AVG(salary) < 80000 THEN 'Medium Salary'
                ELSE 'Low Salary'
            END AS salary_category
        FROM
            salaries
        GROUP BY
            emp_no
    ) AS SalaryCategories
GROUP BY
    salary_category;
```


### 6. CASE with Joins (Identifying Current Employees)

**Counting Current vs. Former Employees:**

```sql
SELECT
    CASE
        WHEN to_date = '9999-01-01' THEN 'Current'
        ELSE 'Former'
    END AS employment_status,
    COUNT(DISTINCT emp_no) AS employee_count
FROM
    dept_emp
GROUP BY
    employment_status;
```


### 7. Transposing Data / Pivoting (Gender Count by Department)

```sql
SELECT
    d.dept_name,
    SUM(CASE WHEN e.gender = 'M' THEN 1 ELSE 0 END) AS male_count,
    SUM(CASE WHEN e.gender = 'F' THEN 1 ELSE 0 END) AS female_count
FROM
    employees AS e
JOIN
    dept_emp AS de ON e.emp_no = de.emp_no
JOIN
    departments AS d ON de.dept_no = d.dept_no
GROUP BY
    d.dept_name
ORDER BY
    d.dept_name;
```


### 8. Final Report (Comprehensive Join and Filter)

```sql
SELECT
    e.emp_no,
    e.first_name || ' ' || e.last_name AS full_name,
    d.dept_name,
    s.salary
FROM
    employees AS e
JOIN
    dept_emp AS de ON e.emp_no = de.emp_no
JOIN
    departments AS d ON de.dept_no = d.dept_no
JOIN
    salaries AS s ON e.emp_no = s.emp_no
WHERE
    de.to_date = '9999-01-01' AND s.to_date = '9999-01-01'
ORDER BY
    e.emp_no;
```

