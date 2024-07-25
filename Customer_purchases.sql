-- Company: Amazon
-- Level: Medium

-- List all customers that made at least 2 purchases in any period of six months.

-- customer_purchase table:
-- +-------------+---------------------+
-- | customer_id | purchased_at        |
-- +-------------+---------------------+
-- | 1           | 2023-01-15 10:00:00 |
-- | 1           | 2023-07-20 11:00:00 |
-- | 2           | 2023-03-22 09:00:00 |
-- | 2           | 2023-04-18 14:00:00 |
-- | 3           | 2023-02-11 08:00:00 |
-- +-------------+---------------------+

-- Expected Output:
-- +-------------+
-- | CUSTOMER_ID |
-- +-------------+
-- | 1           |
-- | 2           |
-- +-------------+

WITH previous AS (
    SELECT 
        customer_id, 
        purchased_at,
        LAG(purchased_at) OVER (PARTITION BY customer_id ORDER BY purchased_at) AS previous_date
    FROM 
        customer_purchase
)
SELECT DISTINCT 
    customer_id
FROM 
    previous
WHERE 
    previous_date IS NOT NULL 
    AND purchased_at < previous_date + INTERVAL '6 months';

