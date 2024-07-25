-- Company: Shopify
-- Level: Medium

-- Determine the top employee based on customer votes.
-- We're interested in employees who've received votes when customers leave their 10-digit phone numbers in the "customer_response" field.
-- Remember, we're looking for valid 10-digit phone numbers.
-- If 2, or more employees have the same number of votes, display all of them.

-- customer_responses table:
-- +---------------------+--------------+---------------------+
-- | response_date       | employee_id  | customer_response   |
-- +---------------------+--------------+---------------------+
-- | 2023-12-01 10:00:00 | 12413        | 1234567890          |
-- | 2023-12-01 11:00:00 | 3112         | 0987654321          |
-- | 2023-12-01 12:00:00 | 12413        | 1234567890          |
-- +---------------------+--------------+---------------------+

-- Expected Output:
-- +-------------+--------------+
-- | EMPLOYEE_ID | CUST_NUMBERS |
-- +-------------+--------------+
-- | 12413       | 15           |
-- | 3112        | 15           |
-- +-------------+--------------+

WITH CTE AS (
    SELECT 
        employee_id, 
        COUNT(*) AS customers,
        RANK() OVER (ORDER BY COUNT(*) DESC) AS rn
    FROM customer_responses
    WHERE customer_response ~ '^[0-9]{10}$'  -- Regex for 10-digit phone number
    GROUP BY employee_id
)
SELECT 
    employee_id, 
    customers AS cust_numbers
FROM CTE
WHERE rn = 1;
