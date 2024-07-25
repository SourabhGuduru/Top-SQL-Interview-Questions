-- Company: Dataford
-- Level: Medium

-- Calculate the average time each user spent in a session.
-- A session is defined as the time between a 'page_load' and a 'page_exit' event.
-- If multiple identical events exist in a day, consider the latest 'page_load' and the earliest 'page_exit', ensuring 'page_load' happens before 'page_exit'.

-- user_actions table:
-- +---------+---------------------+-------------+
-- | user_id | timestamp           | action      |
-- +---------+---------------------+-------------+
-- | 1       | 2023-12-01 08:00:00 | page_load   |
-- | 1       | 2023-12-01 08:30:00 | page_exit    |
-- | 1       | 2023-12-01 09:00:00 | page_load   |
-- | 1       | 2023-12-01 09:15:00 | page_exit    |
-- +---------+---------------------+-------------+

-- Expected Output:
-- +---------+----------------+
-- | user_id | avg_session_time |
-- +---------+----------------+
-- | 15      | 1883.5         |
-- | 19      | 35.0           |
-- +---------+----------------+

WITH CTE AS (
    SELECT 
        user_id, 
        DATE(timestamp) AS date,
        MAX(CASE WHEN action = 'page_load' THEN timestamp END) AS latest_load,
        MIN(CASE WHEN action = 'page_exit' THEN timestamp END) AS earliest_exit
    FROM 
        user_actions
    GROUP BY 
        user_id, 
        DATE(timestamp)
),
SessionTimes AS (
    SELECT 
        user_id, 
        EXTRACT(EPOCH FROM (earliest_exit - latest_load)) AS session_time
    FROM 
        CTE
    WHERE 
        earliest_exit > latest_load
)
SELECT 
    user_id, 
    AVG(session_time) AS avg_session_time
FROM 
    SessionTimes
GROUP BY 
    user_id;


