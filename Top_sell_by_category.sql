-- Company: Amazon
-- Level: Medium

-- Write a query to identify the top highest-grossing products within each category in 2022.
-- Your output should include the category and the top product for each category.
-- Assume there are no sales ties between products within the same category.

-- product_spend table:
-- +------------+---------+--------------+-------+---------------------+
-- | category   | product | user_id      | spend | transaction_date    |
-- +------------+---------+--------------+-------+---------------------+
-- | Electronics| Laptop  | 1001         | 500   | 2022-01-01 08:00:00 |
-- | Home       | Bed     | 1002         | 300   | 2022-01-02 09:00:00 |
-- +------------+---------+--------------+-------+---------------------+

-- Example Output:
-- +------------+---------+
-- | CATEGORY   | PRODUCT |
-- +------------+---------+
-- | Electronics| Laptop  |
-- | Home       | Bed     |
-- +------------+---------+

WITH CTE AS (
    SELECT 
        category, 
        product, 
        SUM(spend) AS total_sales, 
        RANK() OVER (PARTITION BY category ORDER BY SUM(spend) DESC) AS rn
    FROM 
        product_spend
    WHERE 
        EXTRACT(YEAR FROM transaction_date) = 2022
    GROUP BY 
        category, product
)

SELECT 
    category, 
    product
FROM 
    CTE
WHERE 
    rn = 1
