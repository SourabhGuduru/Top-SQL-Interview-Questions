-- Company: Zomato
-- Level: Medium

-- Zomato is a leading online food delivery service that connects users with various restaurants and cuisines, allowing them to browse menus, place orders, and get meals delivered to their doorsteps.
-- Recently, Zomato encountered an issue with their delivery system. Due to an error in the delivery driver instructions, each item's order was swapped with the item in the subsequent row. 
-- As a data analyst, you're asked to correct this swapping error and return the proper pairing of order ID and item.
-- If the last item has an odd order ID, it should remain as the last item in the corrected data.

-- orders Schema:
-- Column Name   Type    Description
-- order_id      integer The ID of each Zomato order.
-- item          string  The name of the food item in each order.

-- orders Example Input:
-- order_id   item
-- 1          Chow Mein
-- 2          Pizza
-- 3          Pad Thai
-- 4          Butter Chicken
-- 5          Eggrolls
-- 6          Burger
-- 7          Tandoori Chicken

-- Example Output:
-- corrected_order_id   item
-- 1                    Pizza
-- 2                    Chow Mein
-- 3                    Butter Chicken
-- 4                    Pad Thai
-- 5                    Burger
-- 6                    Eggrolls
-- 7                    Tandoori Chicken

-- Explanation:
-- Order ID 1 is now associated with Pizza and Order ID 2 is paired with Chow Mein. This adjustment ensures that each order is correctly aligned with its respective item, addressing the initial swapping error.
-- Order ID 7 remains unchanged and is still associated with Tandoori Chicken. This preserves the order sequence ensuring that the last odd order ID remains unaltered.

-- SQL Query to solve the problem:

WITH CTE AS (
    SELECT 
        order_id, 
        item,
        ROW_NUMBER() OVER (ORDER BY order_id) AS row_num,
        COUNT(*) OVER () AS total_orders
    FROM orders
)
SELECT 
    CASE 
        WHEN row_num % 2 != 0 AND row_num = total_orders THEN order_id
        WHEN row_num % 2 != 0 THEN LEAD(order_id) OVER (ORDER BY row_num)
        ELSE LAG(order_id) OVER (ORDER BY row_num)
    END AS corrected_order_id,
    CASE 
        WHEN row_num % 2 != 0 AND row_num = total_orders THEN item
        WHEN row_num % 2 != 0 THEN LEAD(item) OVER (ORDER BY row_num)
        ELSE LAG(item) OVER (ORDER BY row_num)
    END AS item
FROM CTE
ORDER BY corrected_order_id;
