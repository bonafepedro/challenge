WITH movies_bycustomer AS (SELECT title,
customer_id, DATE(rental_date) date_rental
FROM customer 
INNER JOIN rental USING (customer_id)
INNER JOIN inventory USING (inventory_id)
INNER JOIN film USING (film_id)
GROUP BY customer_id, title, date_rental
ORDER BY date_rental),
first_movie_percustomer AS(

SELECT 
    customer_id,
    FIRST_VALUE(title) 
    OVER(
	PARTITION BY customer_id
        ORDER BY date_rental
        RANGE BETWEEN 
            UNBOUNDED PRECEDING AND 
            UNBOUNDED FOLLOWING
    ) first_movie_bycustomer
FROM 
    movies_bycustomer
GROUP BY customer_id, title, date_rental)
    
SELECT COUNT(a.customer_id), a.first_movie_bycustomer
FROM first_movie_percustomer a JOIN first_movie_percustomer b USING (customer_id)
WHERE a.first_movie_bycustomer = b.first_movie_bycustomer
GROUP BY a.first_movie_bycustomer
ORDER BY COUNT(a.customer_id) DESC
LIMIT 3; 
