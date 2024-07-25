-- Top 3 Sellers in Each Product Category for January
-- Company: Amazon

-- Question:
-- Identify and list the top 3 sellers in each product category for the month of January.

-- sales_data table:
-- +--------------+--------------+------------------+--------------+--------+
-- | Column Name  | Description  |                  |              |        |
-- +--------------+--------------+------------------+--------------+--------+
-- | seller_id    | Identifier of seller |         |              |        |
-- | total_sales  | Total sales |                  |              |        |
-- | product_category | Category of product |     |              |        |
-- | market_place | Market place |                  |              |        |
-- | month        | Month        |                  |              |        |
-- +--------------+--------------+------------------+--------------+--------+

-- Expected Output:
-- +------------+-------------+------------------+--------------+--------+
-- | seller_id  | total_sales | product_category | market_place | month  |
-- +------------+-------------+------------------+--------------+--------+
-- | s195       | 45633.35    | books            | de           | 2024-01|
-- | s728       | 29158.51    | books            | us           | 2024-01|
-- | s918       | 24286.4     | books            | uk           | 2024-01|
-- +------------+-------------+------------------+--------------+--------+

-- Use a Common Table Expression (CTE) to rank sellers within each product category
WITH ranking AS (
    SELECT
        seller_id,
        total_sales,
        product_category,
        market_place,
        month,
        RANK() OVER (PARTITION BY product_category ORDER BY total_sales DESC) AS rn
    FROM sales_data
    WHERE month = '2024-01'
)

-- Select the top 3 sellers in each product category
SELECT
    seller_id,
    total_sales,
    product_category,
    market_place,
    month
FROM ranking
WHERE rn <= 3;
