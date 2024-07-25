-- Company: DoorDash
-- Level: Medium

-- Identify the top 2 performing restaurants based on sales. 
-- Exclude any orders with blank values in the actual_delivery_time field as they are considered not received and should not be included in the sales calculation.

-- order_value table:
-- +-------------+--------------+
-- | delivery_id | sales_amount |
-- +-------------+--------------+
-- | 1           | 50           |
-- | 2           | 120          |
-- | 3           | 60           |
-- +-------------+--------------+

-- delivery_orders table:
-- +-------------+---------------------+---------------------+---------------------+--------------+-------------+------------------+-------------+-------------+-------------+-------------+
-- | delivery_id | order_placed_time   | predicted_delivery_time | actual_delivery_time | delivery_rating | driver_id    | restaurant_name | consumer_id | country     | city        |
-- +-------------+---------------------+---------------------+---------------------+--------------+-------------+------------------+-------------+-------------+-------------+-------------+
-- | 1           | 2023-12-05 10:00:00 | 2023-12-05 10:30:00 | 2023-12-05 10:25:00 | 4             | d1           | El Pacifico     | c1          | US          | CityA       |
-- | 2           | 2023-12-10 11:00:00 | 2023-12-10 11:30:00 | NULL                | 5             | d2           | Taj Restaurant  | c2          | US          | CityB       |
-- | 3           | 2023-12-15 09:00:00 | 2023-12-15 09:30:00 | 2023-12-15 09:25:00 | 3             | d3           | El Pacifico     | c3          | US          | CityA       |
-- +-------------+---------------------+---------------------+---------------------+--------------+-------------+------------------+-------------+-------------+-------------+-------------+

-- Expected Output:
-- +------------------+--------+
-- | RESTAURANT_NAME  | SALES  |
-- +------------------+--------+
-- | El Pacifico      | 143.2  |
-- | Taj Restaurant   | 123.2  |
-- +------------------+--------+

SELECT 
    restaurant_name, 
    SUM(sales_amount) AS sales
FROM 
    order_value o
JOIN 
    delivery_orders d
ON 
    o.delivery_id = d.delivery_id
WHERE 
    actual_delivery_time IS NOT NULL
GROUP BY 
    restaurant_name
ORDER BY 
    sales DESC
LIMIT 2;
