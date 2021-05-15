SELECT 
	first_name || ' ' || last_name full_name 
FROM
	film                     
INNER JOIN film_actor USING(film_id)
INNER JOIN actor USING (actor_id)
GROUP BY 
	full_name
ORDER BY SUM (rental_duration) DESC
LIMIT 1;

