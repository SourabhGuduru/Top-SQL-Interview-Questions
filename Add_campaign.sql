-- Company: Accenture
-- Level: Medium

-- Analyze the ad campaign effectiveness by categorizing products based on the total units sold.
-- Benchmark categories are: Outstanding (30 or more), Satisfactory (20 - 29), Unsatisfactory (10 - 19), Poor (1 - 9).

-- marketing_campaign table:
-- +---------+---------------------+------------+----------+-------+
-- | user_id | created_at          | product_id | quantity | price |
-- +---------+---------------------+------------+----------+-------+
-- | 1       | 2023-12-01 08:00:00 | 101        | 5        | 100   |
-- | 2       | 2023-12-01 09:00:00 | 101        | 10       | 100   |
-- | 3       | 2023-12-01 10:00:00 | 116        | 40       | 200   |
-- | 4       | 2023-12-01 11:00:00 | 101        | 20       | 100   |
-- +---------+---------------------+------------+----------+-------+

-- Expected Output:
-- +------------+----------------+
-- | PRODUCT_ID | AD_PERFORMANCE |
-- +------------+----------------+
-- | 101        | Satisfactory    |
-- | 116        | Outstanding     |
-- +------------+----------------+

WITH TotalUnits AS (
    SELECT 
        product_id, 
        SUM(quantity) AS total_quantity
    FROM marketing_campaign
    GROUP BY product_id
),
PerformanceCategories AS (
    SELECT 
        product_id,
        CASE
            WHEN total_quantity >= 30 THEN 'Outstanding'
            WHEN total_quantity BETWEEN 20 AND 29 THEN 'Satisfactory'
            WHEN total_quantity BETWEEN 10 AND 19 THEN 'Unsatisfactory'
            ELSE 'Poor'
        END AS ad_performance
    FROM TotalUnits
)
SELECT 
    product_id,
    ad_performance
FROM PerformanceCategories;

