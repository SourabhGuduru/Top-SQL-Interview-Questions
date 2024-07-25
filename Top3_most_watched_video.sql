-- Company: Netflix
-- Level: Medium

-- Identify the top 3 videos that most users have watched as their first 3 videos.
-- The output should include the video ID and the count of how many times it has been watched as users' first 3 videos.
-- If there's a tie, all videos in the top 3 will be included.

-- user_video_watch table:
-- +------------+----------+---------------------+
-- | user_id    | video_id | watched_at          |
-- +------------+----------+---------------------+
-- | 1          | 1242     | 2023-01-05 08:00:00 |
-- | 2          | 1243     | 2023-01-05 09:00:00 |
-- | 3          | 1342     | 2023-01-05 10:00:00 |
-- | 1          | 1243     | 2023-01-06 08:00:00 |
-- | 2          | 1342     | 2023-01-06 09:00:00 |
-- | 3          | 1242     | 2023-01-07 10:00:00 |
-- +------------+----------+---------------------+

-- Expected Output:
-- +----------+-------------+
-- | video_id | WATCH_COUNT |
-- +----------+-------------+
-- | 1242    | 3           |
-- | 1243    | 2           |
-- | 1342    | 2           |
-- +----------+-------------+

WITH top3_shows AS (
    SELECT 
        user_id, 
        video_id, 
        watched_at,
        ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY watched_at) AS rn 
    FROM 
        user_video_watch
),
ranking_videos AS (
    SELECT 
        video_id, 
        COUNT(*) AS num_times, 
        DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS ranking
    FROM 
        top3_shows
    WHERE 
        rn IN (1, 2, 3)
    GROUP BY 
        video_id
)
SELECT 
    video_id, 
    num_times AS WATCH_COUNT
FROM 
    ranking_videos
WHERE 
    ranking <= 3
ORDER BY 
    WATCH_COUNT DESC;

