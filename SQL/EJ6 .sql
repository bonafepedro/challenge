WITH most_rentable_movies AS ( SELECT SUM(amount) - replacement_cost profits,
title
FROM payment
LEFT JOIN rental USING (rental_id)
LEFT JOIN inventory USING (inventory_id)
LEFT JOIN film USING (film_id)
GROUP BY title,
replacement_cost
ORDER BY profits DESC),
most_rentable_categories AS (SELECT name,
SUM(profits) revenues
FROM most_rentable_movies
JOIN film USING (title)
JOIN film_category USING (film_id)
JOIN category USING (category_id)
GROUP BY name
ORDER BY revenues DESC),
most_rentable_movies_bycountry AS (SELECT country,
name 
FROM country 
JOIN city USING (country_id)
JOIN address USING (city_id)
JOIN customer USING (address_id)
JOIN payment USING (customer_id)
JOIN rental USING (rental_id)
JOIN inventory USING (inventory_id)
JOIN film USING (film_id)
JOIN film_category USING (film_id)
JOIN category USING (category_id)
INNER JOIN most_rentable_categories USING (name)
GROUP BY country,
name
ORDER BY country DESC),
TOPTHREE AS (
    SELECT *, ROW_NUMBER() 
    over (
        PARTITION BY country
        order by country
    ) AS RowNo 
    FROM most_rentable_movies_bycountry
) SELECT * FROM TOPTHREE WHERE RowNo <= 3



