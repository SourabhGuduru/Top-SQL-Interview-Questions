-- Company: DoorDash
-- Level: Medium

-- Evaluate the performance of delivery drivers with precision.
-- Find the average order value for drivers who've successfully completed deliveries within 45 minutes.

-- delivery_details table:
-- +-------------------------------+-----------------------------+----------------------------+-------------------------------+-----------+--------------+-------------+--------------+
-- | customer_placed_order_datetime| placed_order_with_restaurant_datetime | driver_at_restaurant_datetime | delivered_to_consumer_datetime | driver_id | restaurant_id | consumer_id | order_total |
-- +-------------------------------+-----------------------------+----------------------------+-------------------------------+-----------+--------------+-------------+--------------+
-- | 2023-12-01 10:00:00           | 2023-12-01 10:10:00         | 2023-12-01 10:15:00         | 2023-12-01 10:30:00             | 225       | 101          | 201         | 120.50       |
-- | 2023-12-01 11:00:00           | 2023-12-01 11:05:00         | 2023-12-01 11:10:00         | 2023-12-01 11:45:00             | 225       | 102          | 202         | 90.75        |
-- | 2023-12-01 12:00:00           | 2023-12-01 12:20:00         | 2023-12-01 12:30:00         | 2023-12-01 13:05:00             | 34        | 103          | 203         | 48.22        |
-- +-------------------------------+-----------------------------+----------------------------+-------------------------------+-----------+--------------+-------------+--------------+

-- Expected Output:
-- +-----------+------------+
-- | DRIVER_ID | AVG_TOTAL  |
-- +-----------+------------+
-- | 225       | 105.63     |
-- | 34        | 48.22      |
-- +-----------+------------+

SELECT 
    driver_id, 
    AVG(order_total) AS avg_total
FROM 
    delivery_details
WHERE 
    EXTRACT(EPOCH FROM (delivered_to_consumer_datetime - customer_placed_order_datetime)) / 60 <= 45
GROUP BY 
    driver_id;

