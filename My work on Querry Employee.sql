SELECT
 emp_no,
 first_name,
 last_name,
 hire_date,
 CASE
  WHEN EXTRACT(YEAR FROM hire_date) < 1990 THEN 'Before 1990'
  WHEN EXTRACT(YEAR FROM hire_date) BETWEEN 1990 AND 1995 THEN 'Between 1990 and 1995'
  ELSE  'After 1995'
  END AS employment_period
FROM employees;



SELECT
 emp_no,
 AVG(salary) AS salaries
 FROM
 salaries
GROUP BY
 emp_no





SELECT
 emp_no,
 ROUND(AVG(salary),2) AS salaries,
 CASE
  WHEN AVG(salary) > 80000 THEN 'High Salary'
  WHEN AVG(salary) BETWEEN 60000 AND 79999 THEN 'Medium Salary'
  ELSE 'Low Salary'
  END AS salary_category 
FROM
 salaries
GROUP BY
 emp_no




SELECT
  SalarCategories,
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
 ) AS SalarCategories
 GROUP BY
    SalarCategories;




SELECT
  e.emp_no,
  e.first_name,
  e.last_name,
 CASE
  WHEN EXISTS (
            SELECT 1
			FROM dept_emp AS d
			WHERE d.emp_no = e.emp_no AND d.to_date = '9999-01-01' 
  ) THEN 'Manager'
  ELSE 'Employee'
  END AS is_manager
FROM employees AS e;




SELECT 
 e.emp_no,
 e.first_name,
 e.last_name,
 CASE
  WHEN EXISTS(
            SELECT 1
			FROM dept_emp AS d
			WHERE d.emp_no = e.emp_no AND d.to_date = '9999-01-01'
  ) THEN 'Manager'
  ELSE 'Employee'
  END AS is_manager
FROM
  employees AS e;  




SELECT
  CASE
     WHEN to_date= '9999-01-01' THEN 'Current'
     ELSE 'Former'
  END AS employment_status,
  COUNT(DISTINCT emp_no) AS employee_count
FROM
 dept_emp
GROUP BY 
    employment_status;
  


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







--most important query of the project
SELECT
  d.dept_name,
  SUM(CASE WHEN e.gender = 'M' THEN 1 ELSE 0 END) AS male_count,
  SUM(CASE WHEN e.gender = 'F' THEN 1 ELSE 0 END) AS female_count
FROM employees AS e
JOIN 
    dept_emp AS de ON e.emp_no = de.emp_no
JOIN
   departments AS d ON d.dept_no=de.dept_no
GROUP BY
   d.dept_name
ORDER BY
    d.dept_name;





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
    departments AS d ON d.dept_no = de.dept_no
JOIN
    salaries AS s ON s.emp_no = e.emp_no
WHERE
  de.to_date = '9999-01-01' AND s.to_date = '9999-01-01'
ORDER BY
  e.emp_no;	











