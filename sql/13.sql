/*
 * Management wants to create a "best sellers" list for each actor.
 *
 * Write a SQL query that:
 * For each actor, reports the three films that the actor starred in that have brought in the most revenue for the company.
 * (The revenue is the sum of all payments associated with that film.)
 *
 * HINT:
 * For correct output, you will have to rank the films for each actor.
 * My solution uses the `rank` window function.
 */

WITH film_revenue_per_actor AS (
    SELECT
        fa.actor_id,
        f.film_id,
        f.title,
        COALESCE(SUM(p.amount), 0.00) AS revenue
    FROM film f
    JOIN film_actor fa ON f.film_id = fa.film_id
    LEFT JOIN inventory i ON f.film_id = i.film_id
    LEFT JOIN rental r ON i.inventory_id = r.inventory_id
    LEFT JOIN payment p ON r.rental_id = p.rental_id
    GROUP BY fa.actor_id, f.film_id, f.title
),
ranked_films AS (
    SELECT
        actor_id,
        film_id,
        title,
        revenue,
        RANK() OVER (PARTITION BY actor_id ORDER BY revenue DESC, title ASC) AS rnk
    FROM film_revenue_per_actor
)
SELECT
    actor_id,
    first_name,
    last_name,
    film_id,
    title,
    rnk AS "rank",
    revenue
FROM ranked_films
INNER JOIN actor USING (actor_id)
WHERE rnk <= 3
ORDER BY actor_id, rnk;
