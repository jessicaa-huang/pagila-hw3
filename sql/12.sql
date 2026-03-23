/* 
 * A new James Bond movie will be released soon, and management wants to send promotional material to "action fanatics".
 * They've decided that an action fanatic is any customer where at least 4 of their 5 most recently rented movies are action movies.
 *
 * Write a SQL query that finds all action fanatics.
 */

/*
 * Find all 'action fanatics': customers where at least 4/5 most recent rentals are action movies.
 */

SELECT
    customer.customer_id,
    customer.first_name,
    customer.last_name
FROM customer
CROSS JOIN LATERAL (
    SELECT film.film_id
    FROM rental
    JOIN inventory ON rental.inventory_id = inventory.inventory_id
    JOIN film ON inventory.film_id = film.film_id
    WHERE rental.customer_id = customer.customer_id
    ORDER BY rental.rental_date DESC
    LIMIT 5
) AS last5
JOIN film_category ON last5.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Action'
GROUP BY customer.customer_id, customer.first_name, customer.last_name
HAVING COUNT(*) >= 4
ORDER BY customer.customer_id;
