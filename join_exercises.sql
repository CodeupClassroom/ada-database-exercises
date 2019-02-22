USE employees;

-- each department along with the name of the current manager for that department
SELECT
	d.dept_name,
    CONCAT(e.first_name, ' ', e.last_name) as manager
FROM departments d
JOIN dept_manager dm ON d.dept_no = dm.dept_no
JOIN employees e ON dm.emp_no = e.emp_no
WHERE dm.to_date > NOW();

-- Find the name of all departments currently managed by women.
SELECT
	d.dept_name,
    CONCAT(e.first_name, ' ', e.last_name) as manager
FROM departments d
JOIN dept_manager dm ON d.dept_no = dm.dept_no
JOIN employees e ON dm.emp_no = e.emp_no
WHERE dm.to_date > NOW()
	AND e.gender = 'F';
    
-- Find the current titles of employees currently working in the Customer Service department.

SELECT
	t.title as 'Title',
    COUNT(t.title) as 'Count'
FROM departments d
JOIN dept_emp de ON d.dept_no = de.dept_no
JOIN titles t ON de.emp_no = t.emp_no
WHERE d.dept_name = 'Customer Service'
	AND de.to_date > NOW()
	AND t.to_date > NOW()
GROUP BY t.title;

-- 5 Find the current salary of all current managers.

SELECT
	d.dept_name as 'Department Name',
    CONCAT(e.first_name, ' ', e.last_name) as 'Manager Name',
    s.salary as 'Salary'
FROM employees e
JOIN dept_manager dm ON e.emp_no = dm.emp_no
JOIN departments d ON dm.dept_no = d.dept_no
JOIN salaries s ON e.emp_no = s.emp_no
WHERE dm.to_date > NOW()
	AND s.to_date > NOW()
ORDER BY d.dept_name;


-- 6 Find the number of employees in each department.

SELECT
	d.dept_no,
	d.dept_name,
	COUNT(*)
FROM departments d
JOIN dept_emp de ON d.dept_no = de.dept_no
WHERE de.to_date > NOW()
GROUP BY d.dept_name, d.dept_no
ORDER BY d.dept_no;

-- 7 Which department has the highest average salary?

SELECT
	d.dept_name,
	AVG(s.salary)
FROM departments d
JOIN dept_emp de ON d.dept_no = de.dept_no
JOIN salaries s ON de.emp_no = s.emp_no
WHERE de.to_date > NOW() AND s.to_date > NOW()
GROUP BY d.dept_name
ORDER BY AVG(s.salary) DESC
LIMIT 1;


-- 8 Who is the highest paid employee in the Marketing department?
SELECT
	e.first_name, e.last_name
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
JOIN salaries s ON e.emp_no = s.emp_no
WHERE d.dept_name = 'Marketing'
	AND de.to_date > NOW()
	AND s.to_date > NOW()
ORDER BY s.salary DESC
LIMIT 1;




-- 9 Which current department manager has the highest salary?
SELECT
	d.dept_name as 'Department Name',
    CONCAT(e.first_name, ' ', e.last_name) as 'Manager Name',
    s.salary as 'Salary'
FROM employees e
JOIN dept_manager dm ON e.emp_no = dm.emp_no
JOIN departments d ON dm.dept_no = d.dept_no
JOIN salaries s ON e.emp_no = s.emp_no
WHERE dm.to_date > NOW()
	AND s.to_date > NOW()
ORDER BY s.salary DESC
LIMIT 1;

-- 10 Find the names of all current employees, their department name, and their current manager's name.
SELECT
	CONCAT(e.first_name, ' ', e.last_name) as 'Employee Name',
    d.dept_name as 'Department Name',
    CONCAT(m.first_name, ' ', m.last_name) as 'Manager Name'
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
JOIN dept_manager dm ON d.dept_no = dm.dept_no
JOIN employees m ON dm.emp_no = m.emp_no
WHERE de.to_date > NOW() AND dm.to_date > NOW()
LIMIT 100;














































