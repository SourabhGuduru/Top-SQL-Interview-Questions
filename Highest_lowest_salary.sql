-- Highest and Lowest Salaries
-- Company: Siemens

-- Question:
-- Find employees with the highest and lowest salaries, and include a column categorizing the results as either 'Highest Salary' or 'Lowest Salary'.

-- worker table:
-- +-----------+--------------+----------+--------+--------------+-------------+
-- | worker_id | first_name   | last_name| salary | joining_date | department  |
-- +-----------+--------------+----------+--------+--------------+-------------+
-- | 1         | John         | Doe      | 500000 | 2020-01-01   | Admin       |
-- | 2         | Jane         | Smith    | 45000  | 2019-03-15   | HR          |
-- +-----------+--------------+----------+--------+--------------+-------------+

-- title table:
-- +-------------+--------------+-------------+
-- | worker_ref_id | worker_title | affected_from |
-- +-------------+--------------+-------------+
-- | 1           | Manager       | 2020-01-01    |
-- | 2           | Analyst       | 2019-03-15    |
-- +-------------+--------------+-------------+

-- Expected Output:
-- +-----------+--------+--------------+--------------+
-- | worker_id | salary | department   | salary_type  |
-- +-----------+--------+--------------+--------------+
-- | 1         | 500000 | Admin        | Highest Salary|
-- | 2         | 45000  | HR           | Lowest Salary |
-- +-----------+--------+--------------+--------------+

-- Common Table Expression (CTE) to rank salaries
WITH salary_rank AS (
    SELECT 
        w.worker_id,
        w.salary,
        w.department,
        RANK() OVER (ORDER BY salary DESC) AS high_salary_rank,
        RANK() OVER (ORDER BY salary ASC) AS low_salary_rank
    FROM worker w
    LEFT JOIN title t
    ON w.worker_id = t.worker_ref_id
)

-- Select workers with highest and lowest salaries
SELECT 
    worker_id,
    salary,
    department,
    CASE 
        WHEN high_salary_rank = 1 THEN 'Highest Salary'
        WHEN low_salary_rank = 1 THEN 'Lowest Salary'
    END AS salary_type
FROM salary_rank
WHERE high_salary_rank = 1 OR low_salary_rank = 1;
