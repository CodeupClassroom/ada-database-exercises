USE employees;
-- Find all employees with first names 'Irena', 'Vidya', or 'Maya' — 709 rows (Hint: Use IN).
SELECT * FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name;

-- Find all employees whose last name starts with 'E' — 7,330 rows.

SELECT 
	UPPER(LOWER(CONCAT(
		UPPER(first_name),
        UPPER(' '),
        UPPER(last_name)
	))) AS full_name
FROM employees
WHERE last_name LIKE 'E%'
ORDER BY emp_no DESC;





-- Find all employees hired in the 90s — 135,214 rows.
SELECT * FROM employees
WHERE hire_date LIKE '199%';
-- Find all employees born on Christmas — 842 rows.
SELECT * FROM employees
WHERE birth_date LIKE '%12-25';
-- Find all employees with a 'q' in their last name — 1,873 rows.
SELECT * FROM employees
WHERE last_name LIKE '%q%';
-- Update your query for 'Irena', 'Vidya', or 'Maya' to use OR instead of IN — 709 rows.
SELECT * FROM employees
WHERE first_name = 'Irena' OR first_name = 'Vidya'  OR first_name = 'Maya';
-- Add a condition to the previous query to find everybody with those names who is also male — 441 rows.
SELECT * FROM employees
WHERE
	(first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya')
	AND gender = 'M';

SELECT * FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
	AND gender = 'M';
-- Find all employees whose last name starts or ends with 'E' — 30,723 rows.
SELECT * FROM employees
WHERE last_name LIKE 'E%' OR last_name LIKE '%e';
-- Duplicate the previous query and update it to find all employees whose last name starts and ends with 'E' — 899 rows.
SELECT * FROM employees
WHERE last_name LIKE 'E%' AND last_name LIKE '%e';
-- OR
SELECT * FROM employees
WHERE last_name LIKE 'E%e';
-- Find all employees hired in the 90s and born on Christmas — 362 rows.
-- employees hired in the 90s and born on Christmas such that the
-- first result is the oldest employee who was hired last. It should be Khun Bernini.

	
SELECT
	first_name,
    last_name,
    hire_date,
	DATEDIFF(NOW(), hire_date) AS days_working_for_company,
    ROUND(DATEDIFF(NOW(), hire_date) / 365.25, 1) AS years_working_for_company
FROM employees
-- WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
-- 	AND birth_date LIKE '%-12-25'
ORDER BY ROUND(DATEDIFF(NOW(), hire_date) / 365.25, 1) DESC
LIMIT 10;






-- Find all employees with a 'q' in their last name but not 'qu' — 547 rows.
SELECT * FROM employees
WHERE last_name LIKE '%q%'
	AND last_name NOT LIKE '%qu%';

SELECT first_name, last_name
FROM employees
ORDER BY last_name, first_name;















-- smallest & largest salaries
SELECT MIN(salary), MAX(salary)
FROM salaries;

SELECT salary AS min_salary
FROM salaries ORDER BY salary LIMIT 1;

SELECT salary AS max_salary
FROM salaries ORDER BY salary DESC LIMIT 1;







-- A username should be all lowercase, and consist of the first character of the employees first name,
-- the first 4 characters of the employees last name, an underscore,
-- the month the employee was born, and the last two digits of the year that they were born.
-- Below is an example of what the first 10 rows will look like

SELECT
	first_name,
    last_name,
    birth_date,
	LOWER(CONCAT(
		LEFT(first_name, 1),
        LEFT(last_name, 4),
        '_',
        SUBSTR(birth_date, 6, 2),
        SUBSTR(birth_date, 3, 2)
    )) AS username
FROM employees
LIMIT 10;

