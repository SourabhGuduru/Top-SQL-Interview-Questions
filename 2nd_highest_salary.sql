-- Company: Dataford
-- Level: Medium

-- Write a SQL query to find the second highest salary in the engineering department,
-- considering that there may be multiple employees with the same highest salary.
-- Note: If more than one person shares the highest salary, the query should select the next highest salary.

-- employees table:
-- +----+------------+-----------+--------+--------------+
-- | id | first_name | last_name | salary | department_id|
-- +----+------------+-----------+--------+--------------+
-- | 1  | John       | Doe       | 2500   | 1            |
-- | 2  | Jane       | Smith     | 2300   | 1            |
-- | 3  | Alice      | Johnson   | 2200   | 2            |
-- +----+------------+-----------+--------+--------------+

-- departments table:
-- +----+------------+
-- | id | name       |
-- +----+------------+
-- | 1  | engineering |
-- | 2  | marketing   |
-- +----+------------+

-- Example output:
-- +--------+
-- | SALARY |
-- +--------+
-- | 2300   |
-- +--------+

WITH CTE AS (
    SELECT 
        e.salary,
        DENSE_RANK() OVER (PARTITION BY e.department_id ORDER BY e.salary DESC) AS rank
    FROM 
        employees e
    JOIN 
        departments d
    ON 
        e.department_id = d.id
    WHERE 
        d.name = 'engineering'
)
SELECT DISTINCT 
    salary
FROM 
    CTE
WHERE 
    rank = 2;



