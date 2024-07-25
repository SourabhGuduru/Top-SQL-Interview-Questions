--Assume you are on Waymo’s Data Science team, and you want to analyze customer metrics related to the Waymo One service.

--Let’s say we define an inactive customer as any customer who has not taken any rides in the last 3 months (including customers who have never taken a ride at all)

--How many customers were inactive as of November 30, 2023?

--customers table:

--COLUMN NAME	            DESCRIPTION
--customer_id	            Unique identifier for customers
--business_or_personal	    Indicates type of account

--rides table:

--COLUMN NAME	          DESCRIPTION
--ride_id	              Unique identifier for rides
--date	                  Date of the ride
--customer_id	          Unique identifier for customers
--ride_miles	          Distance of the ride in miles
--ride_minutes	          Duration of the ride in minutes

--Example Output:
--INACTIVE_USERS
--301


WITH CTE AS (Select customer_id
FROM rides
WHERE date between '2023-08-31 00:00:00' AND '2023-11-30 23:59:59' 
)
Select COUNT(customer_id) 
FROM customers
WHERE customer_id NOT in (SELECT customer_id FROM CTE)
