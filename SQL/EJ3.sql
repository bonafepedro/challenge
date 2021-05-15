SELECT 
	first_name || ' ' || last_name full_name,
	SUM (amount)
FROM 
	payment
INNER JOIN rental USING (rental_id)
INNER JOIN inventory USING (inventory_id)
INNER JOIN film USING (film_id)
INNER JOIN film_actor USING (film_id)
INNER JOIN actor USING (actor_id)
GROUP BY 
	full_name
ORDER BY SUM(amount) DESC
LIMIT 1;
