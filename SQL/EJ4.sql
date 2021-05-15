SELECT 
	title,
	replacement_cost,
	SUM(amount) income_sum,
	SUM(amount) - replacement_cost profits
FROM 
	film
INNER JOIN inventory USING (film_id)
INNER JOIN rental USING (inventory_id)
INNER JOIN payment USING (rental_id)
GROUP BY 
	title,
	replacement_cost
ORDER BY profits DESC;

