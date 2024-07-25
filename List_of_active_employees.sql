-- Company: Tinder
-- Level: Medium

-- Find names of employees who were still employed as of January 2, 2016

-- employees table:
-- +----+-------------+-----------+
-- | id | name        | hire_date |
-- +----+-------------+-----------+
-- | 1  | Ian Jenkins | 2015-06-15|
-- | 2  | Julia Knight| 2014-11-21|
-- | 3  | Tina Underwood | 2015-08-30|
-- | 4  | Kevin Lutz  | 2013-02-10|
-- +----+-------------+-----------+

-- terminations table:
-- +--------+------------+
-- | emp_id | term_date  |
-- +--------+------------+
-- | 2      | 2015-12-20 |
-- +--------+------------+

-- Expected Output:
-- +--------------+
-- | NAME         |
-- +--------------+
-- | Ian Jenkins  |
-- | Tina Underwood|
-- | Kevin Lutz   |
-- +--------------+

SELECT 
    e.name
FROM 
    employees e
LEFT JOIN 
    terminations t
ON 
    e.id = t.emp_id
WHERE 
    e.hire_date < '2016-01-02'
    AND (t.term_date > '2016-01-02' OR t.term_date IS NULL);
