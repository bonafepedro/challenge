WITH first_rental_dates as (
   SELECT customer_id, min(rental_date) as rental_date 
    FROM rental
    GROUP BY customer_id
),
first_inventories AS (
  SELECT inventory_id 
   FROM rental 
   JOIN first_rental_dates USING (customer_id, rental_date)
)
SELECT title, count(*)
 FROM first_inventories
 JOIN inventory USING (inventory_id)
 JOIN film USING (film_id)
GROUP BY title
ORDER BY count(*) DESC
LIMIT 3;

