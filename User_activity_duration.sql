-- Company: Shopify
-- Level: Medium

-- Calculate the total active hours for each user based on session start and end times.
-- Sessions are defined by the state: '1' for session start and '0' for session end.

-- user_sessions table:
-- +-------------+-------+---------------------+
-- | customer_id | state | timestamp           |
-- +-------------+-------+---------------------+
-- | c001        | 1     | 2024-07-01 09:00:00 |
-- | c001        | 0     | 2024-07-01 11:00:00 |
-- | c002        | 1     | 2024-07-01 10:00:00 |
-- | c002        | 0     | 2024-07-01 12:00:00 |
-- +-------------+-------+---------------------+

-- Expected Output:
-- +-------------+----------------+
-- | CUSTOMER_ID | TOTAL_HOURS    |
-- +-------------+----------------+
-- | c001        | 2.00           |
-- | c002        | 2.00           |
-- +-------------+----------------+

WITH session_durations AS (
    SELECT 
        customer_id, 
        timestamp AS start_time,
        LEAD(timestamp) OVER (PARTITION BY customer_id ORDER BY timestamp) AS end_time
    FROM 
        user_sessions
    WHERE 
        state = 1
)
SELECT 
    customer_id,
    ROUND(SUM(TIMESTAMPDIFF(MINUTE, start_time, end_time)) / 60.0, 2) AS total_active_hours
FROM 
    session_durations
WHERE 
    end_time IS NOT NULL
GROUP BY 
    customer_id;
