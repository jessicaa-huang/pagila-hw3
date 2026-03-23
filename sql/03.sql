/*
 * List the total amount of money that customers from each country have payed.
 * Order the results from most to least money.
 */

SELECT country.country, SUM(payment.amount) AS total_payments
FROM country
INNER JOIN city USING (country_id)
INNER JOIN address USING (city_id)
INNER JOIN customer USING (address_id)
INNER JOIN payment USING (customer_id)
GROUP BY country.country
ORDER BY total_payments DESC, country ASC;

