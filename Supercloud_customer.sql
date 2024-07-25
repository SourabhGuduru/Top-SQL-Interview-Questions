-- Company: Microsoft
-- Level: Medium

-- A Microsoft Azure Supercloud customer is a company which buys at least 1 product from a minimum of 3 different product categories.
-- Write a query to report the company ID(s) that are Supercloud Users.

-- customer_contracts table:
-- +-------------+------------+--------+
-- | customer_id | product_id | amount |
-- +-------------+------------+--------+
-- | 1           | 101        | 500    |
-- | 1           | 102        | 300    |
-- | 2           | 103        | 200    |
-- | 2           | 104        | 400    |
-- | 3           | 105        | 700    |
-- | 3           | 106        | 500    |
-- | 3           | 107        | 150    |
-- | 4           | 108        | 250    |
-- +-------------+------------+--------+

-- products table:
-- +------------+----------------+--------------+
-- | product_id | product_category | product_name |
-- +------------+----------------+--------------+
-- | 101        | Electronics     | Phone        |
-- | 102        | Electronics     | Laptop        |
-- | 103        | Home            | Vacuum        |
-- | 104        | Home            | Blender       |
-- | 105        | Toys            | Lego          |
-- | 106        | Toys            | Action Figure  |
-- | 107        | Books           | Novel         |
-- | 108        | Books           | Magazine      |
-- +------------+----------------+--------------+

-- Example Output:
-- +-------------+
-- | customer_id |
-- +-------------+
-- | 1           |
-- | 3           |
-- +-------------+

SELECT customer_id
FROM customer_contracts c
JOIN products p ON c.product_id = p.product_id
GROUP BY customer_id
HAVING COUNT(DISTINCT p.product_category) >= 3;


