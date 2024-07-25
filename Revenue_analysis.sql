-- Company: PwC
-- Level: Medium

-- Identify companies whose revenue consistently increases every year without any dips.

-- company_revenue table:
-- +-------------+------+---------+
-- | company     | year | revenue |
-- +-------------+------+---------+
-- | Facebook    | 2018 | 500000  |
-- | Facebook    | 2019 | 600000  |
-- | Facebook    | 2020 | 700000  |
-- | Microsoft   | 2018 | 700000  |
-- | Microsoft   | 2019 | 800000  |
-- | Microsoft   | 2020 | 900000  |
-- | Apple       | 2018 | 600000  |
-- | Apple       | 2019 | 650000  |
-- | Apple       | 2020 | 630000  |
-- +-------------+------+---------+

-- Expected Output:
-- +-------------+
-- | COMPANY     |
-- +-------------+
-- | Facebook    |
-- | Microsoft   |
-- +-------------+

WITH ranked_revenue AS (
    SELECT 
        company, 
        year, 
        revenue,
        LAG(revenue) OVER (PARTITION BY company ORDER BY year) AS previous_revenue
    FROM 
        company_revenue
),
increasing_revenue AS (
    SELECT 
        company, 
        year,
        revenue,
        previous_revenue,
        CASE 
            WHEN previous_revenue IS NULL OR revenue > previous_revenue THEN 1 
            ELSE 0 
        END AS is_increasing
    FROM 
        ranked_revenue
)
SELECT 
    company
FROM 
    increasing_revenue
GROUP BY 
    company
HAVING 
    MIN(is_increasing) = 1
    AND MAX(is_increasing) = 1;

