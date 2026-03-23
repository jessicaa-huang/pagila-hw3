/*
 * Management also wants to create a "best sellers" list for each category.
 *
 * Write a SQL query that:
 * For each category, reports the five films that have been rented the most for each category.
 *
 * Note that in the last query, we were ranking films by the total amount of payments made,
 * but in this query, you are ranking by the total number of times the movie has been rented (and ignoring the price).
 */

SELECT DISTINCT
    c.name AS name,
    f.title,
    film_rentals.rental_count AS "total rentals"
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN LATERAL (
    SELECT COUNT(*) AS rental_count
    FROM inventory i
    JOIN rental r ON i.inventory_id = r.inventory_id
    WHERE i.film_id = f.film_id
) AS film_rentals ON TRUE
JOIN LATERAL (
    SELECT
        f2.film_id,
        ROW_NUMBER() OVER (PARTITION BY c2.category_id ORDER BY COUNT(*) DESC, f2.title DESC) AS rank
    FROM film f2
    JOIN film_category fc2 ON f2.film_id = fc2.film_id
    JOIN category c2 ON fc2.category_id = c2.category_id
    JOIN inventory i2 ON f2.film_id = i2.film_id
    JOIN rental r2 ON i2.inventory_id = r2.inventory_id
    WHERE c2.category_id = c.category_id
    GROUP BY f2.film_id, c2.category_id
) AS ranked_films ON ranked_films.film_id = f.film_id
WHERE ranked_films.rank <= 5
ORDER BY c.name, film_rentals.rental_count DESC;
