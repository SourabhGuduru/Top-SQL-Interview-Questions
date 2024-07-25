-- Same Birth Month
-- Company: Block
-- Level: Medium

-- Question:
-- Determine the count of employees within each profession sharing the same birth month.
-- The output should include the profession, birth month, and the number of employees from that department who were born in that month.

-- employee_list table:
-- +--------------+-----------------------------+
-- | Column Name  | Description                 |
-- +--------------+-----------------------------+
-- | first_name   | First name                   |
-- | last_name    | Last name                    |
-- | profession   | Profession name              |
-- | employee_id  | Identifier of employee       |
-- | birthday     | Birthday date                |
-- | birth_month  | Birth month number           |
-- +--------------+-----------------------------+

-- Expected Output:
-- +-------------+---------+---------+---------+---------+---------+---------+---------+---------+---------+---------+---------+
-- | profession   | Month_1 | Month_2 | Month_3 | Month_4 | Month_5 | Month_6 | Month_7 | Month_8 | Month_9 | Month_10| Month_11| Month_12|
-- +-------------+---------+---------+---------+---------+---------+---------+---------+---------+---------+---------+---------+---------+
-- | Accountant   | 0       | 0       | 1       | 0       | 0       | 1       | 1       | 1       | 1       | 0       | 0       | 0       |
-- +-------------+---------+---------+---------+---------+---------+---------+---------+---------+---------+---------+---------+---------+

-- Create the employee_list table
CREATE TABLE employee_list (
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    profession VARCHAR(50),
    employee_id INT PRIMARY KEY,
    birthday DATE,
    birth_month INT
);

-- Write an SQL query to count the number of employees within each profession sharing the same birth month
SELECT profession,
    SUM(CASE WHEN birth_month = 1 THEN 1 ELSE 0 END) AS month_1,
    SUM(CASE WHEN birth_month = 2 THEN 1 ELSE 0 END) AS month_2,
    SUM(CASE WHEN birth_month = 3 THEN 1 ELSE 0 END) AS month_3,
    SUM(CASE WHEN birth_month = 4 THEN 1 ELSE 0 END) AS month_4,
    SUM(CASE WHEN birth_month = 5 THEN 1 ELSE 0 END) AS month_5,
    SUM(CASE WHEN birth_month = 6 THEN 1 ELSE 0 END) AS month_6,
    SUM(CASE WHEN birth_month = 7 THEN 1 ELSE 0 END) AS month_7,
    SUM(CASE WHEN birth_month = 8 THEN 1 ELSE 0 END) AS month_8,
    SUM(CASE WHEN birth_month = 9 THEN 1 ELSE 0 END) AS month_9,
    SUM(CASE WHEN birth_month = 10 THEN 1 ELSE 0 END) AS month_10,
    SUM(CASE WHEN birth_month = 11 THEN 1 ELSE 0 END) AS month_11,
    SUM(CASE WHEN birth_month = 12 THEN 1 ELSE 0 END) AS month_12
FROM employee_list
GROUP BY profession;
