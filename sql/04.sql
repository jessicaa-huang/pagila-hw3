/*
 * List the first and last names of all actors who:
 * 1. have appeared in at least one movie in the "Children" category,
 * 2. but that have never appeared in any movie in the "Horror" category.
 */

SELECT first_name, last_name 
FROM actor
WHERE EXISTS (
    SELECT
    1
    FROM
    film_actor 
    INNER JOIN film USING (film_id)
    INNER JOIN film_category USING (film_id)
    INNER JOIN category USING (category_id)
    WHERE film_actor.actor_id = actor.actor_id
   AND category.name = 'Children' 
)
AND NOT EXISTS (
    SELECT 1
    FROM film_actor
    INNER JOIN film USING (film_id)
    INNER JOIN film_category USING (film_id)
    INNER JOIN category USING (category_id)
    WHERE film_actor.actor_id = actor.actor_id
    AND category.name = 'Horror'
)
ORDER BY last_name ASC;
