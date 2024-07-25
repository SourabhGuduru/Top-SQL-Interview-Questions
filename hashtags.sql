-- Company: Dataford
-- Level: Medium

-- Given a table of tweets with their respective hashtags, write a SQL query to find the top K (K=2) most frequently mentioned hashtags in the table.

-- tweets table:
-- +----+------------+--------------------------+
-- | id | tweet_text | hashtags                 |
-- +----+------------+--------------------------+
-- | 1  | Text 1     | #foo, #bar, #baz          |
-- | 2  | Text 2     | #foo, #bar                |
-- | 3  | Text 3     | #foo                      |
-- +----+------------+--------------------------+

-- Example output:
-- +----------+--------+
-- | HASHTAG  | COUNT  |
-- +----------+--------+
-- | #foo     | 3      |
-- | #bar     | 2      |
-- +----------+--------+

WITH CTE AS (
    SELECT 
        REGEXP_SPLIT_TO_TABLE(hashtags, ', ') AS hashtag
    FROM 
        tweets
)
SELECT 
    hashtag, 
    COUNT(*) AS count
FROM 
    CTE
GROUP BY 
    hashtag
ORDER BY 
    count DESC
LIMIT 2;




