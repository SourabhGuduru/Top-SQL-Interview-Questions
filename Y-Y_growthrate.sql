-- Company: Wayfair
-- Level: Hard

-- This is the same question as problem #32 in the SQL Chapter of Ace the Data Science Interview!

-- Assume you're given a table containing information about Wayfair user transactions for different products.
-- Write a query to calculate the year-on-year growth rate for the total spend of each product, grouping the results by product ID.

-- The output should include the year in ascending order, product ID, current year's spend, previous year's spend and year-on-year growth percentage, rounded to 2 decimal places.

-- user_transactions Table:
-- Column Name      Type
-- transaction_id   integer
-- product_id       integer
-- spend            decimal
-- transaction_date datetime

-- user_transactions Example Input:
-- transaction_id | product_id | spend  | transaction_date
-- ---------------|------------|--------|---------------------
-- 1341           | 123424     | 1500.60| 2019-12-31 12:00:00
-- 1423           | 123424     | 1000.20| 2020-12-31 12:00:00
-- 1623           | 123424     | 1246.44| 2021-12-31 12:00:00
-- 1322           | 123424     | 2145.32| 2022-12-31 12:00:00

-- Example Output:
-- year | product_id | curr_year_spend | prev_year_spend | yoy_rate
-- -----|------------|-----------------|-----------------|----------
-- 2019 | 123424     | 1500.60         | NULL            | NULL
-- 2020 | 123424     | 1000.20         | 1500.60         | -33.35
-- 2021 | 123424     | 1246.44         | 1000.20         | 24.62
-- 2022 | 123424     | 2145.32         | 1246.44         | 72.12

-- Explanation:
-- Product ID 123424 is analyzed for multiple years: 2019, 2020, 2021, and 2022.

-- In the year 2020, the current year's spend is 1000.20, and there is no previous year's spend recorded (indicated by an empty cell).
-- In the year 2021, the current year's spend is 1246.44, and the previous year's spend is 1000.20.
-- In the year 2022, the current year's spend is 2145.32, and the previous year's spend is 1246.44.

WITH yearly_spend_cte AS (
  SELECT 
    EXTRACT(YEAR FROM transaction_date) AS yr,
    product_id,
    SUM(spend) AS curr_year_spend,
    LAG(SUM(spend)) OVER (
      PARTITION BY product_id 
      ORDER BY 
        EXTRACT(YEAR FROM transaction_date)) AS prev_year_spend 
  FROM user_transactions
  GROUP BY 
    EXTRACT(YEAR FROM transaction_date),
    product_id
)

SELECT 
  yr,
  product_id, 
  curr_year_spend, 
  prev_year_spend, 
  ROUND(100 * 
    (curr_year_spend - prev_year_spend)
    / prev_year_spend
  , 2) AS yoy_rate 
FROM yearly_spend_cte
ORDER BY 
  product_id,
  yr;
