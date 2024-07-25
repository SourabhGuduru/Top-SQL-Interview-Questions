-- Company: Tiktok
-- Level: Medium

-- Calculate the email confirmation rate as the percentage of emails that have been confirmed.
-- The result should be rounded to 2 decimal points.

-- emails table:
-- +----------+---------+---------------------+
-- | email_id | user_id | signup_date         |
-- +----------+---------+---------------------+
-- | 1        | 101     | 2024-01-01 08:00:00 |
-- | 2        | 102     | 2024-01-01 09:00:00 |
-- | 3        | 103     | 2024-01-01 10:00:00 |
-- +----------+---------+---------------------+

-- texts table:
-- +---------+----------+----------------+
-- | text_id | email_id | signup_action  |
-- +---------+----------+----------------+
-- | 1       | 1        | Confirmed       |
-- | 2       | 2        | Pending         |
-- | 3       | 3        | Confirmed       |
-- +---------+----------+----------------+

-- Example Output:
-- +----------------+
-- | ACTIVATION_RATE|
-- +----------------+
-- | 0.67           |
-- +----------------+

SELECT ROUND(
    COUNT(DISTINCT t.email_id) * 1.0 / COUNT(DISTINCT e.email_id),
    2
) AS ACTIVATION_RATE
FROM emails e
LEFT JOIN texts t
ON e.email_id = t.email_id AND t.signup_action = 'Confirmed';
