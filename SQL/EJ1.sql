SELECT
	DATE(rental_date) date_rental
FROM 
	rental
GROUP BY
	date_rental
ORDER BY
	COUNT(rental_id) DESC
LIMIT 1;


--@Results 

-------------
-- 2005-07-31
--(1 row)

