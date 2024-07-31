-- Company: Facebook
-- Level: Hard

-- This is the same question as problem #23 in the SQL Chapter of Ace the Data Science Interview!

-- Assume you're given a table containing information on Facebook user actions. 
-- Write a query to obtain the number of monthly active users (MAUs) in July 2022, including the month in numerical format "1, 2, 3".

-- An active user is defined as a user who has performed actions such as 'sign-in', 'like', or 'comment' in both the current month and the previous month.

-- user_actions Table:
-- Column Name   Type
-- user_id       integer
-- event_id      integer
-- event_type    string ("sign-in", "like", "comment")
-- event_date    datetime

-- user_actions Example Input:
-- user_id | event_id | event_type | event_date
-- --------|----------|------------|---------------------
-- 445     | 7765     | sign-in    | 2022-06-30 12:00:00
-- 742     | 6458     | sign-in    | 2022-07-03 12:00:00
-- 445     | 3634     | like       | 2022-07-05 12:00:00
-- 742     | 1374     | comment    | 2022-07-05 12:00:00
-- 648     | 3124     | like       | 2022-07-18 12:00:00

-- Example Output for June 2022:
-- month | monthly_active_users
-- ------|---------------------
-- 6     | 1

-- In June 2022, there was only one monthly active user (MAU) with the user_id 445.

-- Please note that the output provided is for June 2022 as the user_actions table only contains event dates for that month. 
-- You should adapt the solution accordingly for July 2022.

-- The dataset you are querying against may have different input & output - this is just an example!

-- Output should look like:
-- month | monthly_active_users
-- ------|---------------------
-- 7     | 1

WITH June AS
(
    SELECT DISTINCT user_id 
    FROM user_actions 
    WHERE event_date >= '2022-06-01' AND event_date < '2022-07-01'
),
July AS
(
    SELECT DISTINCT user_id 
    FROM user_actions 
    WHERE event_date >= '2022-07-01' AND event_date < '2022-08-01'
)

SELECT '7' AS month, COUNT(DISTINCT a.user_id) AS MAU
FROM June a
JOIN July b
ON a.user_id = b.user_id;
