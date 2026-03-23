/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */

SELECT DISTINCT actor.first_name || ' ' || actor.last_name AS "Actor Name"
FROM film
INNER JOIN film_actor USING (film_id)
INNER JOIN actor USING (actor_id)
WHERE film.film_id IN (
    SELECT film_id
    FROM film
    INNER JOIN film_actor USING (film_id)
    INNER JOIN actor USING (actor_id)
    WHERE actor.actor_id IN (
        SELECT actor_id
        FROM film
        INNER JOIN film_actor USING (film_id)
        INNER JOIN actor USING (actor_id)
        WHERE film.film_id IN (
            SELECT film_id
            FROM film
            INNER JOIN film_actor USING (film_id)
            INNER JOIN actor USING (actor_id)
            WHERE actor.first_name = 'RUSSELL' AND actor.last_name = 'BACALL'
        )
    )
)
AND actor.actor_id NOT IN (
    SELECT actor_id
    FROM actor
    WHERE first_name = 'RUSSELL' AND last_name = 'BACALL'
)
AND actor.actor_id NOT IN (
    SELECT actor_id
        FROM film
        INNER JOIN film_actor USING (film_id)
        INNER JOIN actor USING (actor_id)
        WHERE film.film_id IN (
            SELECT film_id
            FROM film
            INNER JOIN film_actor USING (film_id)
            INNER JOIN actor USING (actor_id)
            WHERE actor.first_name = 'RUSSELL' AND actor.last_name = 'BACALL'
        )
)
ORDER BY "Actor Name";
