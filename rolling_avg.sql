-- Company: Twitter
-- Level: Medium

-- Write a query to calculate the 3-day rolling average of tweets for each user in the tweets table,
-- and output the user ID, tweet date, and rolling averages rounded to 2 decimal places.

-- tweets table:
-- +---------+------------+------------+
-- | user_id | tweet_date | tweet_count|
-- +---------+------------+------------+
-- | 111     | 2022-01-01 | 3          |
-- | 111     | 2022-01-02 | 2          |
-- | 111     | 2022-01-03 | 1          |
-- | 111     | 2022-01-04 | 2          |
-- +---------+------------+------------+

-- Example output:
-- +---------+------------+-------------+
-- | user_id | tweet_date | rolling_avg |
-- +---------+------------+-------------+
-- | 111     | 2022-01-03 | 2.00        |
-- | 111     | 2022-01-04 | 1.67        |
-- +---------+------------+-------------+

SELECT 
    user_id, 
    tweet_date, 
    ROUND(AVG(tweet_count) OVER (
        PARTITION BY user_id
        ORDER BY tweet_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ), 2) AS rolling_avg
FROM 
    tweets

