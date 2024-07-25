-- Friday Purchase Behavior
-- Company: IBM

-- Question:
-- Calculate the average amount users have spent per order for each Friday in the first quarter of the year.
-- Include the week number of that Friday and the average amount spent, rounded to two decimal places.

-- user_purchases table:
-- +---------+------------+-------------+----------+
-- | user_id | date       | amount_spent | day_name |
-- +---------+------------+-------------+----------+
-- | 1       | 2023-01-06 | 500.00      | Friday   |
-- | 2       | 2023-01-13 | 300.00      | Friday   |
-- +---------+------------+-------------+----------+

-- Expected Output:
-- +-------------+-------------+
-- | week_number | mean_amount |
-- +-------------+-------------+
-- | 1           | 400.00      |
-- | 2           | 550.00      |
-- +-------------+-------------+

SELECT 
    DATE_PART('week', date) AS week_number,
    ROUND(AVG(amount_spent), 2) AS mean_amount
FROM 
    user_purchases
WHERE 
    date >= '2023-01-01' AND date <= '2023-03-31'
    AND day_name = 'Friday'
GROUP BY 
    week_number
ORDER BY 
    week_number;
