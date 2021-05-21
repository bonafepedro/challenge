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

-- Results

--            title            | replacement_cost | income_sum | profits 
-------------------------------+------------------+------------+---------
-- Telegraph Voyage            |            20.99 |     215.75 |  194.76
-- Zorro Ark                   |            18.99 |     199.72 |  180.73
-- Titans Jerk                 |            11.99 |     186.73 |  174.74
-- Wife Turn                   |            27.99 |     198.73 |  170.74
-- Hustler Party               |            22.99 |     190.78 |  167.79
-- Innocent Usual              |            26.99 |     191.74 |  164.75
-- Saturday Lambs              |            28.99 |     190.74 |  161.75
-- Harry Idaho                 |            18.99 |     177.73 |  158.74
-- Dogma Family                |            16.99 |     168.72 |  151.73
-- Pelican Comforts            |            17.99 |     165.77 |  147.78
-- ...
--------------------------------------------------------------------------
-- The program returns the list of all the films with their replacement cost,
-- sum of income generated and profit/loss for each one.
-- As an example here are the first 10 results. 

