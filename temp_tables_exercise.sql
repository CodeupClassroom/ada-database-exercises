# Find out how the average pay in each department compares to the overall average pay. 
# In order to make the comparison easier, you should use the Z-score for salaries. 
# In terms of salary, what is the best department to work for? The worst?

# 1. get aggregates
SELECT AVG(salary), STDDEV(salary)
FROM employees.salaries
WHERE to_date > NOW();

# 2. get z
SELECT emp_no, salary, ((salary-72012)/17310) AS z_salary
FROM employees.salaries
WHERE to_date > NOW();

# 3. get dept
SELECT d.dept_name, s.emp_no, s.salary, ((s.salary-72012)/17310) AS z_salary
FROM employees.salaries s
JOIN employees.dept_emp de ON s.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE s.to_date > NOW();

# 4. get avg z by dept

SELECT a.dept_name, AVG(a.z_salary) AS avg_z_salary
FROM  (
	SELECT d.dept_name, s.emp_no, s.salary, ((s.salary-72012)/17310) AS z_salary
	FROM employees.salaries s
	JOIN employees.dept_emp de ON s.emp_no = de.emp_no
	JOIN departments d ON de.dept_no = d.dept_no
	WHERE s.to_date > NOW()
	) a
GROUP BY a.dept_name;

# OPTION 1: create a temp table 
CREATE TEMPORARY TABLE agg AS
SELECT AVG(salary) AS avg_salary, STDDEV(salary) AS stdev_salary
FROM employees.salaries
WHERE to_date > NOW();

# SELECT * FROM agg;

SELECT a.dept_name, AVG(a.z_salary) AS avg_z_salary
FROM  (
SELECT d.dept_name, s.emp_no, s.salary, ((s.salary-a.avg_salary)/a.stdev_salary) AS z_salary
	FROM employees.salaries s
	JOIN agg a
	JOIN employees.dept_emp de ON s.emp_no = de.emp_no
	JOIN departments d ON de.dept_no = d.dept_no
	WHERE s.to_date > NOW()
	) a
GROUP BY a.dept_name;

# OPTION 2: use more subqueries table 

SELECT a.dept_name, AVG(a.z_salary) AS avg_z_salary
FROM  (
	SELECT d.dept_name
					, s.emp_no
                    , s.salary
					, ((s.salary-(SELECT AVG(salary) FROM employees.salaries WHERE to_date > NOW())
						)  / (SELECT STDDEV(salary)  FROM employees.salaries WHERE to_date > NOW())
                        ) AS z_salary
	FROM employees.salaries s
	JOIN employees.dept_emp de ON s.emp_no = de.emp_no
	JOIN departments d ON de.dept_no = d.dept_no
	WHERE s.to_date > NOW()
	) a
GROUP BY a.dept_name;
