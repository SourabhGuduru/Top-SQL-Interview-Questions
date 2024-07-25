-- Highly Engaged Posts
-- Company: Meta
-- Level: Medium

-- Question:
-- You are part of the content strategy team at Instagram, and have access to a table called posts.
-- What percentage of posts in December 2023 received more than 500 likes?

-- posts table:
-- +-------------------+----------------------------------+
-- | COLUMN NAME       | DESCRIPTION                      |
-- +-------------------+----------------------------------+
-- | post_id           | unique ID for the post           |
-- | user_id           | ID of the user who posted        |
-- | post_time         | timestamp the post was made      |
-- | like_count        | number of likes the post received|
-- | like_update_time  | timestamp of the last update     |
-- +-------------------+----------------------------------+

-- Expected Output:
-- +-----------+
-- | PERCENTAGE|
-- +-----------+
-- | 0.43      |
-- +-----------+

-- Create the posts table
CREATE TABLE posts (
    post_id INT PRIMARY KEY,
    user_id INT,
    post_time TIMESTAMP,
    like_count INT,
    like_update_time TIMESTAMP
);

-- Calculate the percentage of posts in December 2023 that received more than 500 likes
WITH DecemberPosts AS (
    SELECT 
        COUNT(post_id) AS total_posts,
        SUM(CASE WHEN like_count > 500 THEN 1 ELSE 0 END) AS posts_with_500_likes
    FROM posts
    WHERE EXTRACT(MONTH FROM post_time) = 12 
      AND EXTRACT(YEAR FROM post_time) = 2023
)
SELECT 
    posts_with_500_likes * 1.0 / total_posts AS percentage
FROM 
    DecemberPosts;
