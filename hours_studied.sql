-- Find the 80th percentile of hours studied

-- sat_scores table:
-- +----+---------+---------+------------+-------------+-------------+----------+-------------+
-- | id | school  | teacher | student_id | sat_writing | sat_verbal  | sat_math | hrs_studied |
-- +----+---------+---------+------------+-------------+-------------+----------+-------------+
-- | 1  | SchoolA | Mr. X   | 1001       | 620         | 580         | 650      | 150         |
-- | 2  | SchoolB | Ms. Y   | 1002       | 600         | 590         | 640      | 170         |
-- +----+---------+---------+------------+-------------+-------------+----------+-------------+

-- Expected Output:
-- +-------------+
-- | hrs_studied |
-- +-------------+
-- | 163         |
-- +-------------+

SELECT 
    PERCENTILE_CONT(0.80) WITHIN GROUP (ORDER BY hrs_studied) AS hrs_studied
FROM 
    sat_scores;
