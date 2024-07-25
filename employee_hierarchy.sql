-- Company: Dataford
-- Level: Medium

-- Given a table of employees with their respective managers, write a SQL query to generate a report that displays the name of each employee along with the name of their manager (if any) and the number of direct reports each manager has.

-- employees table:
-- +----+-------+------------+
-- | id | name  | manager_id |
-- +----+-------+------------+
-- | 1  | Alice | 4          |
-- | 2  | Bob   | 3          |
-- | 3  | Carol | 4          |
-- | 4  | Dave  | NULL       |
-- +----+-------+------------+

-- Example output:
-- +--------------+-------------+------------------+
-- | EMPLOYEE_NAME | MANAGER_NAME | DIRECT_REPORTS   |
-- +--------------+-------------+------------------+
-- | Alice        | Dave        | 2                |
-- | Bob          | Carol       | 1                |
-- | Carol        | Dave        | 2                |
-- | Dave         | NULL        | 2                |
-- +--------------+-------------+------------------+

WITH ManagerCounts AS (
    SELECT
        manager_id,
        COUNT(*) AS direct_reports
    FROM
        employees
    GROUP BY
        manager_id
)
SELECT
    e.name AS employee_name,
    m.name AS manager_name,
    mc.direct_reports AS number_of_direct_reports
FROM
    employees e
LEFT JOIN
    employees m ON e.manager_id = m.id
LEFT JOIN
    ManagerCounts mc ON m.id = mc.manager_id
ORDER BY
    e.id;





