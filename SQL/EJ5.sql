WITH most_rentable_movies AS (
				SELECT SUM(amount) - replacement_cost 				profits,
				title
				FROM 
					payment 
				LEFT JOIN rental USING (rental_id)
				LEFT JOIN inventory USING (inventory_id)
				LEFT JOIN film USING (film_id)
				GROUP BY 
					title, 
					replacement_cost
				ORDER BY profits DESC
				LIMIT 10
			)
SELECT 
	country,
	SUM (profits) revenues
FROM 
	country
LEFT JOIN city USING (country_id)
LEFT JOIN address USING (city_id)
LEFT JOIN customer USING (address_id)
LEFT JOIN payment USING (customer_id)
LEFT JOIN rental USING (rental_id)
LEFT JOIN inventory USING (inventory_id)
LEFT JOIN film USING (film_id)
INNER JOIN most_rentable_movies USING (title)
GROUP BY 
	country
ORDER BY revenues DESC;

-- Using INNER JOIN in line 27 we limit the list of countries to to only those that have earnings from the 10 most profitable films
--If we use LEFT JOIN in line 27 we select all the countries and those that do not have earnings from the 10 most profitable movies have the earnings column empty
--Usando INNER JOIN en la linea 27 limitamos los paises del listado a solo aquellos que poseen ganancias de las 10 películas mas rentables. Si en la linea 21 usamos LEFT JOIN se incluyen todos los paises y aquellos que no tienen ninguna ganancia que aparecen con la columna de ganancias vacía

-- Results
--      country       | revenues 
----------------------+----------
-- India              |  6069.75
-- China              |  3176.17
-- United States      |  3074.48
-- Brazil             |  2532.19
-- Mexico             |  2158.70
-- Russian Federation |  2075.94
-- Nigeria            |  1901.30
-- Philippines        |  1460.90
-- Japan              |  1434.82
-- Turkey             |  1163.28

--The program returns a list of all the countries with their revenues for the top 10 most popular movies in terms of
--overall rentals for each one, as an example here are the first 10 results. 

