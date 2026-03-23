/*
 * Compute the country with the most customers in it. 
 */

SELECT country.country FROM country
INNER JOIN city USING (country_id)
INNER JOIN address USING (city_id)
INNER JOIN customer USING (address_id)
GROUP BY country.country
ORDER BY count(country.country) DESC
LIMIT 1;
