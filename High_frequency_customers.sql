-- Company: DoorDash
-- Level: Medium

-- Calculate the % of high-frequency customers for January 2023.
-- High-frequency customers are those who place more than 5 orders in a month.

-- delivery_order table:
-- +---------------+-------------+-------------+---------------------+
-- | restaurant_id | delivery_id | customer_id | order_timestamp     |
-- +---------------+-------------+-------------+---------------------+
-- | 1             | 1001        | c1          | 2023-01-05 10:00:00 |
-- | 1             | 1002        | c1          | 2023-01-10 11:00:00 |
-- | 2             | 1003        | c2          | 2023-01-15 09:00:00 |
-- | 3             | 1004        | c3          | 2023-01-20 14:00:00 |
-- | 1             | 1005        | c1          | 2023-01-25 12:00:00 |
-- | 1             | 1006        | c1          | 2023-01-28 16:00:00 |
-- +---------------+-------------+-------------+---------------------+

-- Expected Output:
-- +--------+
-- | RATIO  |
-- +--------+
-- | 0.24   |
-- +--------+

WITH CTE AS (
    SELECT 
        customer_id, 
        COUNT(delivery_id) AS num_of_delivery
    FROM 
        delivery_order
    WHERE 
        EXTRACT(MONTH FROM order_timestamp) = 1 
        AND EXTRACT(YEAR FROM order_timestamp) = 2023
    GROUP BY 
        customer_id
)

SELECT 
    ROUND(COUNT(customer_id) * 1.0 / (SELECT COUNT(customer_id) FROM CTE), 2) AS RATIO
FROM 
    CTE
WHERE 
    num_of_delivery > 5;

