-- Company: Dataford
-- Level: Medium

-- Given a table of transactions with transaction dates and amounts, write a SQL query to calculate the running total for each day.
-- For instance, if transactions on the first day total $20 and on the second day total $30, the output for the first day should be $20 and for the second day $50 (which is $20 from the first day plus $30 from the second).

-- transactions table:
-- +----+-----------------+--------+
-- | id | transaction_date | amount |
-- +----+-----------------+--------+
-- | 1  | 2022-01-01      | 300    |
-- | 2  | 2022-01-02      | 50     |
-- | 3  | 2022-01-03      | 350    |
-- +----+-----------------+--------+

-- Example output:
-- +------------+--------------+
-- | DATE       | RUNNING_TOTAL|
-- +------------+--------------+
-- | 2022-01-01 | 300.00       |
-- | 2022-01-02 | 350.00       |
-- | 2022-01-03 | 700.00       |
-- +------------+--------------+

WITH CTE AS (
    SELECT 
        DATE(transaction_date) AS date,
        SUM(amount) AS transaction_amount
    FROM 
        transactions
    GROUP BY 
        DATE(transaction_date)
)
SELECT 
    date,
    SUM(transaction_amount) OVER (ORDER BY date) AS running_total
FROM 
    CTE;



