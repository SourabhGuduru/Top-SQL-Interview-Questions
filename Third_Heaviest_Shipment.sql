-- Company: Amazon
-- Level: Medium

-- Find the shipment with the 3rd heaviest weight.
-- In cases of tied weights, ranks should be assigned without gaps. 
-- For example, if there are shipments with weights of 100, 100, 50, 40, and 30 pounds, 
-- the first 2 shipments at 100 pounds each would both be ranked 1st, 
-- the 50-pound shipment would be ranked 2nd, and the 40-pound shipment would be ranked 3rd.

-- shipments table:
-- +--------------+--------+--------------+
-- | shipment_id  | weight | shipment_date|
-- +--------------+--------+--------------+
-- | 1001         | 50     | 2023-12-01   |
-- | 1002         | 40     | 2023-12-05   |
-- | 1003         | 30     | 2023-12-10   |
-- | 1004         | 100    | 2023-12-15   |
-- | 1005         | 100    | 2023-12-20   |
-- +--------------+--------+--------------+

-- Expected Output:
-- +--------------+--------+
-- | shipment_id  | weight |
-- +--------------+--------+
-- | 1002         | 40     |
-- +--------------+--------+

WITH shipments_weight AS (
    SELECT 
        shipment_id, 
        weight, 
        DENSE_RANK() OVER (ORDER BY weight DESC) AS rn
    FROM 
        shipments
)
SELECT 
    shipment_id, 
    weight
FROM 
    shipments_weight
WHERE 
    rn = 3;

