

-- Company: Google
-- Level: Medium

-- Your goal is to return the names of the student that starts with the letter 'A' (it can also start with lower caps) along with their count.
-- Let’s say the table has "Alan" and "adam" as entries. The output should be 2, Alan, Adam (delimited by a comma and a space).

SELECT 
    CONCAT(COUNT(first_name), ', ', STRING_AGG(first_name, ', ' ORDER BY first_name)) AS OUTPUT
FROM 
    students
WHERE 
    LOWER(first_name) LIKE 'a%'
