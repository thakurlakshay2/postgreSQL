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

--------------------------------------Updating a table-------------------------------

