SELECT
	DATE(rental_date)
FROM 
	rental
GROUP BY
	COUNT(rental_id) DESC
LIMIT 1;

