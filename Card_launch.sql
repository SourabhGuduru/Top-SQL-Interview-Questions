-- Company: JPMorgan
-- Level: Medium

-- Your task is to find out how many cards were issued in the first month of previous card launches.
-- Display each credit card's name alongside the quantity issued in its launch month.

-- monthly_cards_issued table:
-- +-------------+------------+--------------------------+----------------+
-- | issue_month | issue_year | card_name                | issued_amount  |
-- +-------------+------------+--------------------------+----------------+
-- | 1           | 2023       | Chase Sapphire Reserve   | 170000         |
-- | 2           | 2023       | Chase Sapphire Reserve   | 12000          |
-- | 1           | 2022       | Chase Freedom Flex       | 65000          |
-- | 3           | 2022       | Chase Freedom Flex       | 7000           |
-- +-------------+------------+--------------------------+----------------+

-- Example output:
-- +--------------------------+----------------+
-- | card_name                | issued_amount  |
-- +--------------------------+----------------+
-- | Chase Sapphire Reserve   | 170000         |
-- | Chase Freedom Flex       | 65000          |
-- +--------------------------+----------------+

WITH CTE AS (
    SELECT
        card_name,
        issued_amount,
        ROW_NUMBER() OVER (PARTITION BY card_name ORDER BY issue_year, issue_month) AS rn
    FROM
        monthly_cards_issued
)

SELECT
    card_name,
    issued_amount
FROM
    CTE
WHERE
    rn = 1;
