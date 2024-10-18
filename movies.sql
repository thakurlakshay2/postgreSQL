--# Create the actor table
--function : CREATE TABLE

-- CREATE TABLE actors (
-- 	actor_id SERIAL PRIMARY KEY,
-- 	first_name VARCHAR(150),
-- 	last_name VARCHAR(150) NOT NULL,
-- 	gender CHAR(1),
-- 	data_of_birth DATE,
-- 	add_date DATE,
-- 	update_date DATE,
-- 	add_by VARCHAR(100)
	
-- );

--# Create directors table
-- CREATE TABLE directors (
-- 	director_id SERIAL PRIMARY KEY,
-- 	first_name VARCHAR(150),
-- 	last_name VARCHAR(150) NOT NULL,
-- 	data_of_birth DATE,
-- 	nationality VARCHAR(150),
-- 	add_date DATE,
-- 	update_date DATE
-- );

-- SELECT * FROM director;



--# Create movies table
-- Movies > Directors
-- CREATE TABLE movies (
-- 	movie_id SERIAL PRIMARY KEY,
-- 	move_name VARCHAR(100) NOT NULL,
-- 	movie_length INT,
-- 	movie_language VARCHAR(20),
-- 	age_certification VARCHAR(10),
-- 	release_date DATE,
-- 	director_id  INT REFERENCES directors (director_id)
-- );
-- SELECT * FROM movies;

--# Creating movies_Revenues table

-- CREATE TABLE movies_revenues (
-- 	revenue_id SERIAL PRIMARY KEY,
-- 	movie_id INT REFERENCES movies (movie_id),
-- 	revenues_domestic NUMERIC (10,2),
-- 	revenues_international NUMERIC (10,2)
-- )
-- SELECT * FROM movies_revenues;

--# Creating movies_actors table

-- CREATE TABLE movies_actors (
-- 	movie_id INT REFERENCES movies (movie_id),
-- 	actor_id INT REFERENCES actors (actor_id),
-- 	PRIMARY KEY (movie_id, actor_id)
-- )
-- SELECT * FROM movies_actors;




-------------------------------EDITING THE TABLE NOW------------------------------
-- CREATE TABLE customers (
-- 	customer_id SERIAL  PRIMARY KEY,
-- 	first_name VARCHAR(50),
-- 	last_name VARCHAR(50),
-- 	email VARCHAR(150),
-- 	age INT
-- )

SELECT * FROM customers;

--# Insert 1 record into a table
-- INSERT INTO customers (first_name, last_name, email,age)
-- VALUES ('lakshay','thakur','a@b.com',40);

--# Insert multiple records into a table
-- INSERT INTO customers (first_name, last_name, email,age)
-- VALUES 
-- ('lucky','chaba','mmm@b.com',20), 
-- ('ut','verma','kkk@b.com',33); -- Inportatn the last one has 'semicolor' while rest have 'comma'

--# How to add data which has quotes
-- INSERT INTO customers (first_name)
-- VALUES('lakshay''O thakur');

--# USE 'RETURNING' to get ubfi on returns rows

--## returning all  rows
-- INSERT INTO customers (first_name)
-- VALUES('JAMEY') RETURNING *;

--## retuning a single column value
-- INSERT INTO customers (first_name)
-- VALUES('JAMEY') RETURNING customer_id;

--------------------------------------# Updating a table (includes delete)-------------------------------
SELECT * FROM customers;

--# Updating One record at a time
-- UPDATE customers
-- SET 
-- email = 'aUpdated@b.com'
-- last_name = 'updated'
-- WHERE customer_id =1

--## Updating and returning updated value

-- UPDATE customers
-- SET 
-- last_name = 'updated'
-- WHERE customer_id =3
-- RETURNING *

--## Updating All Records in a table
-- UPDATE customers
-- SET 
-- is_enable = true


-- # Deleting a record
-- DELETE FROM customers
-- WHERE customer_id=5


--------------------------------------# UPSERT (Update + insert) a table-------------------------------
SELECT * FROM t_tags;
-- CREATE TABLE t_tags( 
-- 	id SERIAL PRIMARY KEY,
-- 	tag text UNIQUE,
-- 	update_date TIMESTAMP DEFAULT NOW()
-- )

-- Insert data
-- INSERT INTO t_tags (tag) values
-- ('PEN'),
-- ('PENCIL');

-- Let's insert a record m on conflict do nothing
-- INSERT INTO t_tags (tag) values
-- ('PEN')
-- ON CONFLICT (tag)
-- DO
-- 	NOTHING;


-- Let's insert a record m on conflict set new values
-- INSERT INTO t_tags (tag) values
-- ('PEN')
-- ON CONFLICT (tag)
-- DO
-- 	UPDATE SET
-- 	tag = EXCLUDED.tag,
-- 	update_date=NOW();


--------------------------_Select-----------------
SELECT * FROM movies

--# Select Columns from table
SELECT movie_id, movie_name FROM movies

--# Adding Alias to column. names
SELECT movie_name AS movieName FROM movies --lower cased
SELECT movie_name AS "movieName" FROM movies -- Camel casing is there eve add space here

SELECT movie_id AS "Movie ID", movie_name AS "Movie Name" FROM movies

SELECT movie_id  "Movie ID", movie_name  "Movie Name" FROM movies --AS is optional

--# Assign Column Alias for expressions
SELECT first_name || last_name FROM actors 
SELECT first_name || ' ' || last_name   FROM actors  --Adding Space between names


SELECT first_name || ' ' || last_name  AS "Movie Name" FROM actors  --Adding Alias


----------------------- Order By -------------------

--# Sort based on single column

SELECT * FROM movies ORDER BY release_date DESC

--# multiple columns
SELECT * FROM movies ORDER BY release_date DESC, movie_name ASC

--# Using alias
SELECT movie_name AS "MOVIES NAME" FROM movies ORDER BY release_date DESC, movie_name ASC

--# Get length 
SELECT first_name, LENGTH(first_name) FROM actors

--# Sort by length
SELECT first_name, LENGTH(first_name) AS len FROM actors ORDER BY len


--# Sort all recorsds using column number 
SELECT * FROM actors ORDER BY first_name ASC, date_of_birth DESC

SELECT first_name, date_of_birth FROM actors ORDER BY 1 ASC, 2 DESC


--# Order by NULL
SELECT * FROM actors ORDER BY first_name ASC -- by default null is last for the DESC option
SELECT * FROM actors ORDER BY first_name NULLS LAST -- by default null is last
--Both above have same result
SELECT DISTINCT date_of_birth FROM actors  NULLS FIRST
 -- Null first

SELECT DISTINCT date_of_birth FROM actors ORDER BY 1 NULLS FIRST
 --  Decending and null FISRT


--# Select DISCTINCT VALUES

SELECT DISTINCT date_of_birth FROM actors ORDER BY 1 DESC NULLS FIRST

SELECT DISTINCT director_id FROM directors ORDER BY 1

SELECT DISTINCT * FROM directors ORDER BY 1. -- all unique records in movies table


-------------------------------_Filtering Data ------------------------------------
--Three Types of Operator : comparison  , logical and arithmetic

-----------Using Logical Operator

--# Adding condition using comparison operator
SELECT * FROM movies WHERE movie_language = 'English';

--# Adding multiple conditions use AND
SELECT * FROM movies 
WHERE 
	movie_language = 'English'
	AND age_certification='18';

--# using OR
SELECT * FROM movies 
WHERE 
	movie_language = 'English'
	OR movie_language='Chinese';

 
--# combining AND , OR
SELECT * FROM movies 
WHERE 
	(movie_language = 'English'
	OR movie_language='Chinese') 
	AND age_Certification='12'
ORDER BY movie_language;

--# Using WHERE before from
-- SYNTAX ERROR , cannot do this
SELECT  * WHERE 
	(movie_language = 'English'
	OR movie_language='Chinese') 
	AND age_Certification='12' FROM movies

--# using WHERE after ORDER BY
--SYntax error
SELECT * FROM movies ORDER BY movie_language WHERE 
	(movie_language = 'English'
	OR movie_language='Chinese') 
	AND age_Certification='12';

--# using column aliases with WHERE
--No you cannot use alias for column name to run WHERE clause
SELECT first_name , last_name AS surname
FROM actors
WHERE surname= 'Allen';


--# order of execution  FROM | WHERE | SELECT | ORDER BY
SELECT * 
FROM movies 
WHERE  movie_language = 'English'
ORDER BY age_Certification

-------- Using Comparison Operator

--# select  from a range  > < >= <= = , <>

SELECT * 
FROM movies 
WHERE  movie_length<100
ORDER BY movie_length ASC;


--# Can this work on dates?? assume we need movies after 2000
SELECT * FROM movies
ORDER BY release_date ASC;

SELECT * FROM movies
WHERE release_date > '1999-12-31'
ORDER BY release_date ASC;


--# we can also get movies greater than English
SELECT * FROM movies
WHERE movie_language > 'English'

--# Exclusion
SELECT * FROM movies
WHERE movie_language <> 'English'


--------------use LIMIT and OFFSET

--# getting top 5 movies
SELECT * FROM movies 
ORDER BY movie_name LIMIT 10;

--# getting top 5 oldest american directors
SELECT * FROM directors;
SELECT * FROM directors WHERE nationality='American' ORDER BY date_of_birth LIMIT 5;

--# Getting to 10 youngest female actors
SELECT * FROM actors WHERE gender='F' ORDER BY date_of_birth DESC LIMIT 10;

--# Getting top 10 most domestic profictable movie;
SELECT * FROM movies_revenues ORDER BY revenues_domestic DESC NULLS LAST LIMIT 10;



------Using OFFSET
--# Get 5 films from 4th one order by movie_id;

SELECT * FROM movies ORDER BY movie_id LIMIT 5 OFFSET 4;

--# List all top 5 movies after top 5 highest domestic profict movies
SELECT * FROM movies_revenues ORDER BY revenues_domestic DESC NULLS LAST LIMIT 10 OFFSET 5;


----------------- FETCH------

--# Get first row of movie table 
SELECT * FROM movies
FETCH FIRST 5 ROW ONLY

--# Get top 5 movies by movies length
SELECT * FROM movies
ORDER BY movie_length DESC 
FETCH FIRST 5 ROW ONLY

--# Get top 5 oldest americal directors

SELECT * FROM directors 
WHERE nationality='American' 
ORDER BY date_of_birth 
FETCH FIRST 5 ROW ONLY;

--# Getting to 10 youngest female actors
SELECT * FROM actors WHERE gender='F' 
ORDER BY date_of_birth DESC
FETCH FIRST 10 ROW ONLY;

--# List all top 5 movies after top 5 highest domestic profict movies
SELECT * FROM movies_revenues ORDER BY revenues_domestic DESC NULLS LAST FETCH FIRST 5 ROW ONLY OFFSET 5;


------------------ IN , NOT IN

--# get moives in english chinese , japanese 
SELECT * FROM movies 
WHERE movie_language IN ('English','Chinese','Japanese')
ORDER BY 

--# all movie wiere age certificate is 13 and pg

SELECT * FROM movies
WHERE age_certification IN ('12','PG');

--# all movies where director is. not 13 or 10
SELECT * FROM movies WHERE director_id NOT IN ('13','10')
