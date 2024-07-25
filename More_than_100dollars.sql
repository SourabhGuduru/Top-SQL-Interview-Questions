-- Company: DoorDash
-- Level: Medium

-- Calculate the percentage of restaurants, out of those that fulfilled any orders in a given month,
-- that fulfilled more than $100 in monthly sales for each month of 2021.

-- delivery_orders table:
-- +-------------+---------------------+----------------------+---------------------+---------------+--------------+----------------+-------------+-------------+-------------+---------------+
-- | delivery_id | order_placed_time   | predicted_delivery_time | actual_delivery_time | delivery_rating | dasher_id    | restaurant_id | consumer_id | order_value | sales_amount | 
-- +-------------+---------------------+----------------------+---------------------+---------------+--------------+----------------+-------------+-------------+-------------+---------------+
-- | 1           | 2021-01-05 10:00:00 | 2021-01-05 10:30:00  | 2021-01-05 10:25:00 | 4             | d1           | r1             | c1          | 50          | 50            |
-- | 2           | 2021-01-10 11:00:00 | 2021-01-10 11:30:00  | 2021-01-10 11:15:00 | 5             | d2           | r2             | c2          | 120         | 120           |
-- | 3           | 2021-02-15 09:00:00 | 2021-02-15 09:30:00  | 2021-02-15 09:25:00 | 3             | d3           | r1             | c3          | 60          | 60            |
-- +-------------+---------------------+----------------------+---------------------+---------------+--------------+----------------+-------------+-------------+-------------+---------------+

-- order_value table:
-- +-------------+--------------+
-- | delivery_id | sales_amount |
-- +-------------+--------------+
-- | 1           | 50           |
-- | 2           | 120          |
-- | 3           | 60           |
-- +-------------+--------------+

-- Expected Output:
-- +-----------+----------------+
-- | MONTH     | AVERAGE_SALES  |
-- +-----------+----------------+
-- | 1         | 50.00          |
-- | 2         | 60.00          |
-- +-----------+----------------+

WITH MonthlySales AS (
    SELECT
        restaurant_id,
        EXTRACT(MONTH FROM order_placed_time) AS order_month,
        SUM(sales_amount) AS monthly_sales
    FROM
        delivery_orders d
    JOIN
        order_value o ON d.delivery_id = o.delivery_id
    WHERE
        EXTRACT(YEAR FROM order_placed_time) = 2021
    GROUP BY
        restaurant_id,
        EXTRACT(MONTH FROM order_placed_time)
),
RestaurantCounts AS (
    SELECT
        order_month,
        COUNT(restaurant_id) AS total_restaurants,
        COUNT(CASE WHEN monthly_sales > 100 THEN 1 END) AS restaurants_above_100
    FROM
        MonthlySales
    GROUP BY
        order_month
)
SELECT
    order_month AS MONTH,
    ROUND((restaurants_above_100 * 100.0 / total_restaurants), 2) AS AVERAGE_SALES
FROM
    RestaurantCounts
ORDER BY
    order_month;
