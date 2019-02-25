USE employees;

-- Find all the employees with the same hire date as employee 101010 using a sub-query.

SELECT * FROM employees
WHERE hire_date = (
	SELECT hire_date FROM employees
    WHERE emp_no = 101010
);


SELECT * FROM employees
WHERE hire_date = '1990-10-22';

-- Find all the titles held by all employees with the first name Aamod.

SELECT DISTINCT title
FROM titles
WHERE emp_no IN (
	SELECT emp_no FROM employees
    WHERE first_name = 'Aamod'
);

-- How many people in the employees table are no longer working for the company?

SELECT COUNT(*)
FROM employees
WHERE emp_no NOT IN (
	SELECT emp_no
	FROM salaries
	WHERE to_date > NOW()
);

-- Find all the current department managers that are female.

SELECT first_name, last_name
FROM employees
WHERE gender = 'F'
	AND emp_no IN (
		SELECT emp_no FROM dept_manager WHERE to_date > NOW()
	);

-- how to identify "current" employees
SELECT * FROM dept_manager WHERE to_date = '9999-01-01';
SELECT * FROM dept_manager WHERE to_date > NOW();

-- how to check for data issues with the to_date
SELECT * FROM dept_manager
WHERE to_date > NOW()
	AND to_date != '9999-01-01';

-- Find all the employees that currently have a higher than average salary.
-- 1. find the average salary

SELECT e.first_name, e.last_name, s.salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
WHERE s.salary > (
	SELECT AVG(salary) FROM salaries
) AND s.to_date > NOW();

SELECT e.first_name, e.last_name, s.salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
WHERE s.salary > (
	SELECT AVG(salary) FROM salaries
    WHERE s.to_date > NOW()
);

-- How many current salaries are within 1 standard deviation of the highest salary?
-- (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?


SELECT (COUNT(*) / (SELECT COUNT(*) FROM salaries WHERE to_date > NOW())) * 100
FROM salaries
WHERE salary >= (
	SELECT MAX(salary) - STDDEV(salary) FROM salaries
) AND to_date > NOW();

-- Using operators as part of a SELECT
SELECT
	emp_no,
    emp_no + 1,
    emp_no > 10004
FROM employees
WHERE emp_no < 20000;











-- BONUS --

-- Find all the department names that currently have female managers.

SELECT dept_name
FROM departments
WHERE dept_no IN (
	SELECT dept_no
    FROM dept_manager
    WHERE emp_no IN (
		SELECT emp_no
        FROM employees
        WHERE gender = 'F'
    ) AND to_date > NOW()
);


-- Find the first and last name of the employee with the highest salary.

SELECT first_name, last_name
FROM employees
WHERE emp_no = (
	SELECT emp_no
	FROM salaries
	WHERE salary = (
		SELECT MAX(salary)
		FROM salaries
	)
);

SELECT first_name, last_name
FROM employees
WHERE emp_no = (
	SELECT emp_no
	FROM salaries
	ORDER BY salary DESC
	LIMIT 1
);

-- Find the department name that the employee with the highest salary works in.

SELECT dept_name
FROM departments
WHERE dept_no = (
	SELECT dept_no
	FROM dept_emp
	WHERE emp_no = (
		SELECT emp_no
		FROM employees
		WHERE emp_no = (
			SELECT emp_no
			FROM salaries
			ORDER BY salary DESC
			LIMIT 1
		)
	)
);


