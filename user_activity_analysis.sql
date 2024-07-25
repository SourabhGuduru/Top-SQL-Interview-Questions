-- Company: Snapchat
-- Level: Medium

-- Calculate the percentage of time spent sending vs. opening snaps for each age group.
-- The total time spent should only include sending and opening activities.

-- activities table:
-- +------------+---------+--------------+------------+---------------------+
-- | activity_id| user_id | activity_type| time_spent | activity_date       |
-- +------------+---------+--------------+------------+---------------------+
-- | 1          | 101     | sending      | 10         | 2024-01-01 08:00:00 |
-- | 2          | 101     | opening      | 5          | 2024-01-01 09:00:00 |
-- | 3          | 102     | sending      | 15         | 2024-01-02 10:00:00 |
-- +------------+---------+--------------+------------+---------------------+

-- age_breakdown table:
-- +---------+------------+
-- | user_id | age_bucket  |
-- +---------+------------+
-- | 101     | 26-30      |
-- | 102     | 31-35      |
-- +---------+------------+

-- Example output:
-- +------------+-----------+-----------+
-- | AGE_BUCKET | SEND_PERC | OPEN_PERC |
-- +------------+-----------+-----------+
-- | 26-30      | 0.67      | 0.33      |
-- | 31-35      | 1.00      | 0.00      |
-- +------------+-----------+-----------+

WITH CTE AS(Select age_bucket,
SUM(CASE WHEN activity_type='send' THEN time_spent ELSE 0 END) as send_time,
SUM(CASE WHEN activity_type='open' THEN time_spent ELSE 0 END) as open_time
FROM activities a
JOIN age_breakdown b
ON a.user_id=b.user_id
GROUP BY age_bucket )

Select age_bucket, ROUND(send_time/(send_time+open_time),2) as SEND_PERC,
ROUND(open_time/(send_time+open_time),2) as OPEN_PERC
FROM CTE