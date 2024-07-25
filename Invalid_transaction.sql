-- Company: Chase
-- Level: Medium

-- Identify unauthorized transactions during December 2022.
-- Transactions are considered invalid if they fall outside regular bank hours:
-- Monday to Friday 09:00 - 16:00, closed on Saturdays, Sundays, and Irish Public Holidays (25th and 26th December).

-- transactions table:
-- +---------------+---------------------+
-- | transaction_id | time_stamp         |
-- +---------------+---------------------+
-- | 1001          | 2022-12-01 08:30:00 |
-- | 1341          | 2022-12-25 10:00:00 |
-- | 1413          | 2022-12-27 17:00:00 |
-- +---------------+---------------------+

-- Expected Output:
-- +---------------+
-- | TRANSACTION_ID |
-- +---------------+
-- | 1001          |
-- | 1341          |
-- | 1413          |
-- +---------------+

SELECT transaction_id
FROM transactions
WHERE time_stamp BETWEEN '2022-12-01 00:00:00' AND '2022-12-31 23:59:59'
AND (
    EXTRACT(ISODOW FROM time_stamp) IN (6, 7) -- Saturday and Sunday
    OR EXTRACT(DAY FROM time_stamp) IN (25, 26) -- Public Holidays
    OR EXTRACT(HOUR FROM time_stamp) < 9 -- Before 09:00 AM
    OR EXTRACT(HOUR FROM time_stamp) >= 16 -- After 04:00 PM
);
