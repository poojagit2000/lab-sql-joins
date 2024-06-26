USE sakila;
-- List the number of films per category.

SELECT c.name as category_name,COUNT(f.film_id) as num_films
FROM sakila.category c
INNER JOIN sakila.film_category fc
ON c.category_id = fc.category_id
INNER JOIN sakila.film f
ON fc.film_id = f.film_id
group by category_name
order by category_name;
-- Retrieve the store ID, city, and country for each store.
SELECT s.store_id,ci.city,co.country
FROM sakila.store s
INNER JOIN sakila.address ad
ON s.address_id = ad.address_id
LEFT JOIN sakila.city ci
ON ad.city_id = ci.city_id
LEFT JOIN sakila.country co
ON ci.country_id = co.country_id;

-- Calculate the total revenue generated by each store in dollars.
SELECT * from rental;
SELECT s.store_id, SUM(p.amount) as total_revenue
FROM sakila.payment p
INNER JOIN sakila.rental r
ON p.rental_id = r.rental_id
INNER JOIN sakila.inventory i
ON r.inventory_id = i.inventory_id
INNER JOIN sakila.store s
ON i.store_id = s.store_id
group by s.store_id;

-- Determine the average running time of films for each category.
SELECT c.name as category_name,AVG(f.length) as avg_running_time
FROM sakila.category c
INNER JOIN sakila.film_category fc
ON c.category_id = fc.category_id
INNER JOIN sakila.film f
ON fc.film_id = f.film_id
group by category_name
order by category_name;
-- BONUS
-- Identify the film categories with the longest average running time.
SELECT c.name as category_name,AVG(f.length) as avg_running_time
FROM sakila.category c
INNER JOIN sakila.film_category fc
ON c.category_id = fc.category_id
INNER JOIN sakila.film f
ON fc.film_id = f.film_id
group by category_name
order by category_name DESC
LIMIT 1;
-- Display the top 10 most frequently rented movies in descending order.
SELECT f.film_id,f.title,COUNT(r.rental_id) as rental_count
FROM sakila.film f
INNER JOIN sakila.inventory i
ON f.film_id = i.film_id
INNER JOIN sakila.rental r
ON i.inventory_id = r.inventory_id
group by f.film_id,f.title
order by rental_count DESC
LIMIT 10;

-- Determine if "Academy Dinosaur" can be rented from Store 1.
SELECT * from film;
SELECT f.title,s.store_id
FROM sakila.film f
INNER JOIN sakila.inventory i
ON f.film_id = i.film_id
INNER JOIN sakila.store s
ON i.store_id = s.store_id
WHERE f.title = 'Academy Dinosaur' AND s.store_id = 1
GROUP BY f.title,s.store_id;
-- Provide a list of all distinct film titles, along with their availability status in the inventory. Include a column indicating whether each title is 'Available' or 'NOT available.' Note that there are 42 titles that are not in the inventory, and this information can be obtained using a CASE statement combined with IFNULL."
SELECT f.title,
IFNULL(CASE WHEN COUNT(i.inventory_id)>0 THEN 'AVAILABLE' ELSE 'NOT AVAILABLE' END,'NOT AVAILABLE') as availability_status
FROM sakila.film f
LEFT JOIN sakila.inventory i
ON f.film_id = i.film_id
group by f.title;

