USE employees;
-- unique titles from the titles table

SELECT title FROM titles GROUP BY title;



-- Find your query for employees whose last names start and end with 'E'. 
-- Update the query find just the unique last names that start and end with 'E' using GROUP BY.


SELECT last_name
FROM employees
WHERE last_name LIKE 'e%e'
GROUP BY last_name;

-- find unique combinations of first and last name where the last name starts and ends with 'E'

SELECT last_name, first_name, COUNT(*)
FROM employees
WHERE last_name LIKE 'e%e'
GROUP BY last_name, first_name;

SELECT last_name, COUNT(*), MAX(birth_date), MIN(birth_date)
FROM employees
WHERE last_name LIKE '%q%'
	AND last_name NOT LIKE '%qu%'
GROUP BY last_name;

-- Which (across all employees) name is the most common, the least common?
-- Find this for both first name, last name, and the combination of the two.


SELECT first_name, COUNT(*)
FROM employees
GROUP BY first_name
ORDER BY COUNT(first_name) DESC;


SELECT last_name, COUNT(last_name)
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;

SELECT 
    CONCAT(first_name, ' ', last_name), COUNT(*)
FROM
    employees
GROUP BY CONCAT(first_name, ' ', last_name)
ORDER BY COUNT(*) DESC;

SELECT gender, COUNT(*)
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY gender;


-- For the bonus
SELECT 
    COUNT(*)
FROM
    (SELECT 
        username, COUNT(*) AS count
    FROM
        (SELECT 
        LOWER(CONCAT(LEFT(first_name, 1), LEFT(last_name, 4), '_', SUBSTR(birth_date, 6, 2), SUBSTR(birth_date, 3, 2))) AS username
    FROM
        employees) AS usernames
    GROUP BY username) AS username_counts
WHERE
    count > 1;






