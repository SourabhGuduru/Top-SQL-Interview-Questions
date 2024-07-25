-- Company: Lyft
-- Level: Medium

-- Determine the city that had the most profitable month in the year 2023.
-- The output will display the city, the corresponding most profitable month, and the profit achieved during that period.
-- In case of ties in profit, display all results that share the top spot.

-- orders table:
-- +---------+-------------+-------------+---------+-----------------+
-- | order_id| customer_id | driver_id   | city    | country         |
-- +---------+-------------+-------------+---------+-----------------+
-- | 1       | c1          | d1          | CityA   | US              |
-- | 2       | c2          | d2          | CityB   | US              |
-- | 3       | c3          | d3          | CityA   | US              |
-- +---------+-------------+-------------+---------+-----------------+

-- payment_details table:
-- +---------+---------------------+-----------+-----------+
-- | order_id| order_date          | promo_code| order_fare|
-- +---------+---------------------+-----------+-----------+
-- | 1       | 2023-01-15 14:00:00 | false     | 100       |
-- | 2       | 2023-03-20 09:00:00 | true      | 150       |
-- | 3       | 2023-03-25 16:00:00 | false     | 200       |
-- +---------+---------------------+-----------+-----------+

-- Expected Output:
-- +-------------+-------+--------+
-- | CITY        | MONTH | PROFIT |
-- +-------------+-------+--------+
-- | CityA       | 3     | 200    |
-- +-------------+-------+--------+

WITH CTE AS (
    SELECT 
        city,
        EXTRACT(MONTH FROM order_date) AS Month,
        SUM(order_fare) AS profit,
        RANK() OVER (ORDER BY SUM(order_fare) DESC) AS rn
    FROM 
        orders o
    JOIN 
        payment_details p ON o.order_id = p.order_id
    WHERE 
        EXTRACT(YEAR FROM order_date) = 2023
    GROUP BY 
        city, EXTRACT(MONTH FROM order_date)
)

SELECT 
    city, 
    Month, 
    profit
FROM 
    CTE
WHERE 
    rn = 1;
