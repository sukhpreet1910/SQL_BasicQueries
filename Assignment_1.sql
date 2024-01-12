-- 1. How many actors are there with the last name ‘Wahlberg’?

SELECT count(last_name) 
from actor
where last_name = 'Wahlberg' -- or last_name like 'wahlberg'
group by last_name

-- 2. How many payments were made between $3.99 and $5.99?

SELECT count(amount)
from payment
where amount BETWEEN 3.99 and 5.99
-- Output is not as shown in answer sheet, bcz there's not even one value present between the given values
-- I think someone messed up with database


-- 3. What film does the store have the most of? (search in inventory)

SELECT count(*) as count, film_id
from inventory
group by film_id
ORDER BY count DESC
limit 1;


-- 4. How many customers have the last name ‘William’?

select COUNT(*) 
from customer
where last_name = 'William'


-- 5. What store employee (get the id) sold the most rentals?

SELECT staff_id, count(*) as count
FROM rental
group by staff_id
ORDER BY count desc
limit 1


-- 6. How many different district names are there?
SELECT count(distinct address.district) 
from address

-- 7. What film has the most actors in it? (use film_actor table and get film_id)

SELECT film_id, count(film_actor.actor_id) as actors
from film_actor
group by film_actor.film_id
order by actors DESC
LIMIT 1


-- 8. From store_id 1, how many customers have a last name ending with ‘es’? (use customer table)

SELECT count(*) as customers_count
from customer
where customer.store_id = 1 and customer.last_name LIKE '%es'
-- it says "use customer table"
-- but its not showing store_id column in customer table 
select * from store



-- 9. How many payment amounts (4.99, 5.99, etc.) had a number of rentals above 250 for customers 
-- with ids between 380 and 430? (use group by and having > 250)

-- I have done this question in different ways, cuz i found this question most ambiguous, it was kind of challenge 



-- Below Code will return information of grouped amound, total count whenever its above 250 with a rank
-- Rank can be useful if there are multiple rows with same count 

select payment.amount, count(*) as rental_count, 
rank() over(order by count(*)) as Rank
from payment 
where payment.customer_id between 380 and 430
group by payment.amount
having count(*) > 250


-- Below Code will return number of rows who meet the requirements using sub query 
select count(*) as rental_count
from (
select count(*) as rental_count, 
row_number() over(order by count(*)) as Row_Number
from payment 
where payment.customer_id between 380 and 430
group by payment.amount
having count(*) > 250) re


-- Below Code will return the same output as above, but using commentable expression 
with rental_count AS
(
select count(*) as rental_count, 
row_number() over(order by count(*)) as Row_Number
from payment 
where payment.customer_id between 380 and 430
group by payment.amount
having count(*) > 250) 

select count(*) as rental_count
from rental_count



-- 10. Within the film table, how many rating categories are there? And what rating has the most movies total

--Rating Categories
SELECT count(DISTINCT film.rating) as count
from film

-- Rating with most movie total
SELECT film.rating, count(*) as movie_count
from film
group by rating 
ORDER BY movie_count DESC
limit 1

