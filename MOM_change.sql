-- Company: Amazon
-- Level: Medium

-- Write a SQL query to calculate the month-over-month percentage change in revenue.
-- The output should include the year-month date (in YYYY-MM format) and percentage change, rounded to 2 decimal points.

-- purchases table:
-- +---------------+---------+
-- | purchase_date | revenue |
-- +---------------+---------+
-- | 2022-01-01    | 500     |
-- | 2022-02-01    | 1000    |
-- | 2022-03-01    | 1500    |
-- +---------------+---------+

-- Example output:
-- +-----------+------------+
-- | YEAR_MONTH | PCT_CHANGE |
-- +-----------+------------+
-- | 2022-01    | NULL       |
-- | 2022-02    | 100.00     |
-- | 2022-03    | 50.00      |
-- | 2022-04    | -16.67     |
-- | 2022-05    | 60.00      |
-- +-----------+------------+

WITH CTE AS (
    SELECT 
        TO_CHAR(purchase_date, 'YYYY-MM') AS year_month,
        SUM(revenue) AS total_revenue,
        LAG(SUM(revenue)) OVER (ORDER BY TO_CHAR(purchase_date, 'YYYY-MM')) AS previous_revenue
    FROM 
        purchases
    GROUP BY 
        TO_CHAR(purchase_date, 'YYYY-MM')
)
SELECT 
    year_month,
    ROUND((total_revenue - previous_revenue) * 100.0 / NULLIF(previous_revenue, 0), 2) AS PCT_CHANGE
FROM 
    CTE;



