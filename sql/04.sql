/*
 * List the first and last names of all actors who:
 * 1. have appeared in at least one movie in the "Children" category,
 * 2. but that have never appeared in any movie in the "Horror" category.
 */

SELECT DISTINCT actor.first_name, actor.last_name
FROM actor
INNER JOIN film_actor USING (actor_id)
INNER JOIN film USING (film_id)
INNER JOIN film_category USING (film_id)
INNER JOIN category USING (category_id)
WHERE category.name = 'Children'
  AND NOT EXISTS (
    SELECT 1
    FROM film_actor fa2
    INNER JOIN film f2 USING (film_id)
    INNER JOIN film_category fc2 USING (film_id)
    INNER JOIN category c2 USING (category_id)
    WHERE fa2.actor_id = actor.actor_id AND c2.name = 'Horror'
  )
ORDER BY actor.last_name;
