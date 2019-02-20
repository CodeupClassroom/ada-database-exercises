USE numbers;

SELECT * FROM numbers;

SELECT CONCAT('Here is a number: ', n) FROM numbers;

SELECT CONCAT(n, n) FROM numbers;

SELECT n, n + 1 FROM numbers;

SELECT CONCAT(n, ' plus 1 is ', n + 1) FROM numbers;

USE fruits_db;

SELECT * FROM fruits;

SELECT CONCAT('We have ', quantity, ' of the fruit ', name)
FROM fruits;

SELECT name
FROM fruits
WHERE name REGEXP 'e.';

SELECT name, SUBSTR(name, 3)
FROM fruits
WHERE id >= 2
LIMIT 2 OFFSET 2;

SELECT name, UPPER(name), LOWER(name)
FROM fruits;

SELECT
    CONCAT(UPPER(SUBSTR(name, 1, 1)), LOWER(SUBSTR(name, 2))) AS cap_name
FROM fruits;


SELECT
    CONCAT(UPPER(SUBSTR(name, 1, 1)), LOWER(SUBSTR(name, 2)))
FROM fruits;

SELECT name, LENGTH(name)
FROM fruits;

SELECT name, REPLACE(name, 'a', 'AAAA')
FROM fruits
WHERE name LIKE '%a%';



SELECT NOW(), CURDATE(), CURTIME();

USE employees;

SELECT * FROM employees
WHERE hire_date < NOW();

SELECT DATEDIFF(NOW(), '2019-02-04') AS days_since_ada_day_one;

SELECT UNIX_TIMESTAMP();

SELECT CONCAT(
    'Teaching people to code for ',
    UNIX_TIMESTAMP() - UNIX_TIMESTAMP('2014-02-04'),
    ' seconds'
);


SELECT CAST('123.9999999999' AS UNSIGNED);



USE employees;

SELECT
	hire_date AS start_date,
	DATEDIFF(NOW(), hire_date) as days_working_for_company
FROM employees;



