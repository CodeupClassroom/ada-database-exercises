USE zachs_personal_db; -- yours will be ada_xxx where xxx is your ID numbers

-- Creating a table "from scratch"
CREATE TEMPORARY TABLE my_numbers(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	n INT UNSIGNED NOT NULL,
    PRIMARY KEY (id)
);
INSERT INTO my_numbers(n) VALUES
	(1), (123), (45), (42);

SELECT * FROM my_numbers;

-- adding and removing columns
UPDATE my_numbers SET n = n - 1;
ALTER TABLE my_numbers ADD n_plus_one INT UNSIGNED;
UPDATE my_numbers SET n_plus_one = n + 1;
ALTER TABLE my_numbers ADD n2 INT UNSIGNED;
UPDATE my_numbers SET n2 = (n * 3) + 6;
ALTER TABLE my_numbers DROP COLUMN n;

SELECT * FROM my_numbers;

-- creating a temp table based on query results
SELECT *
FROM employees.employees e
JOIN employees.salaries s
	ON e.emp_no = s.emp_no
WHERE to_date > NOW()
LIMIT 100;

-- note we have to specify the individual columns here
CREATE TEMPORARY TABLE employees_with_current_salaries AS
SELECT
	e.emp_no, birth_date, first_name, last_name, gender, hire_date, salary as current_salary
FROM employees.employees e
JOIN employees.salaries s
	ON e.emp_no = s.emp_no
WHERE to_date > NOW()
LIMIT 100;

SELECT * FROM employees_with_current_salaries;

