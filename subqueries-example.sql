
USE quotes_db;

SELECT * FROM quotes;

-- The "manual" way
SELECT * FROM authors;
-- writing down ids from the authors table
-- use those ids in another

SELECT * FROM quotes WHERE author_id IN (1, 2)\G

-- With subqueries
SELECT * FROM quotes WHERE author_id IN (
    SELECT id
    FROM authors
    WHERE first_name in ('Douglas', 'Mark')
)\G

SELECT id
FROM authors
WHERE first_name in ('Douglas', 'Mark');


USE employees;

-- employees without a filter
SELECT first_name, last_name, birth_date
FROM employees
LIMIT 10;

-- The "manual" process
SELECT emp_no FROM dept_manager;
SELECT * FROM employees
WHERE emp_no in (110022, 110039, 110085, 110114, 110183, 110228, 110303, 110344, 110386, 110420, 110511, 110567, 110725, 110765, 110800, 110854, 111035, 111133, 111400, 111534, 111692, 111784, 111877, 111939);

-- doint it with a subquery
SELECT *
FROM employees
WHERE emp_no IN (
    SELECT emp_no
    FROM dept_manager
);

-- a JOIN for comparison
SELECT * FROM dept_manager dm
LEFT JOIN employees e ON dm.emp_no = e.emp_no;
