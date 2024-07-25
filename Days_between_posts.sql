-- Company: Google
-- Level: Medium

-- Write a SQL query to calculate the sum of odd-numbered and even-numbered measurements separately for a particular day.
-- The resulting table should have 3 columns: measurement_day, odd_sum, and even_sum.

-- Assumptions:
-- Within a day, measurements taken at 1st, 3rd, and 5th times are considered odd-numbered measurements,
-- and measurements taken at 2nd, 4th, and 6th times are considered even-numbered measurements.

-- measurements table:
-- +----------------+------------------+---------------------+
-- | measurement_id | measurement_value | measurement_time   |
-- +----------------+------------------+---------------------+
-- | 1              | 5                | 2022-06-01 00:00:00 |
-- | 2              | 4                | 2022-06-01 00:01:00 |
-- | 3              | 7                | 2022-06-01 00:02:00 |
-- | 4              | 2                | 2022-06-01 00:03:00 |
-- | 5              | 6                | 2022-06-01 00:04:00 |
-- | 6              | 3                | 2022-06-01 00:05:00 |
-- | 7              | 8                | 2022-06-02 00:00:00 |
-- +----------------+------------------+---------------------+

-- Example output:
-- +------------+----------+----------+
-- | day        | odd_sum  | even_sum |
-- +------------+----------+----------+
-- | 2022-06-01 | 18       | 6        |
-- | 2022-06-02 | 8        | 0        |
-- +------------+----------+----------+

WITH CTE AS (
    SELECT 
        DATE(measurement_time) AS measurement_day, 
        measurement_value,
        ROW_NUMBER() OVER (PARTITION BY DATE(measurement_time) ORDER BY measurement_time) AS measurement_order
    FROM 
        measurements
)

SELECT 
    measurement_day,
    SUM(CASE WHEN measurement_order % 2 = 1 THEN measurement_value ELSE 0 END) AS odd_sum,
    SUM(CASE WHEN measurement_order % 2 = 0 THEN measurement_value ELSE 0 END) AS even_sum
FROM 
    CTE
GROUP BY 
    measurement_day;

