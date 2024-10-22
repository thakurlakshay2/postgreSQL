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


---------------- BETWEEN , low , high....
-- Range include
SELECT * FROM actors 
WHERE date_of_birth BETWEEN '1991-01-01' AND '1995-12-31'
ORDER BY date_of_birth 

-- Range exlcude
SELECT * FROM actors 

--------------- LIKE and ILIKE
--Used for pattern matching
--% - matches any sequence of zero or more characters
-- _ Matches any single character


WHERE date_of_birth NOT BETWEEN '1991-01-01' AND '1995-12-31'
ORDER BY date_of_birth 

SELECT 'hello' LIKE 'hello';

SELECT 'hello' LIKE 'h%';

SELECT 'hello' LIKE '%ll_';


SELECT * FROM actors
WHERE first_name LIKE 'A%'
ORDER BY first_name


---------------- Using is NULL  , IS NOT NULL


--IS NULL checks if value is null

SELECT * FROM actors 
WHERE date_of_birth IS NULL
ORDER BY date_of_birth;

--get one with missing birthdate of missing name


SELECT * FROM actors 
WHERE date_of_birth IS NULL OR
		first_name IS NULL
ORDER BY date_of_birth;


--------------------------------- Triggers -----------------------------------------------
-- 1. Trigger is defined as any event that sets a course of action in motion
-- 2. A postgres trigger is function invoked automatically whenever 'event' associated with a table occurs.
-- 3. An event could be any of the following:
	--Insert
	-- Update
	-- Delete
	-- truncate
-- 4. A trigger can be associated with a specified.
	-- Table ,
	-- View
	-- Foreign Table
-- 5. A trigger is a special 'user-defined function'
--6. different between trigger and user defiend function is that a trigger is automatically invoked
	--   a trigger is automatically invoked
--7. We can trigger trigger
	--Before - invoked just before event . it can skip operation for the current row
	--AFTER
	-- INSTEAD
--8. If there are more tan 1 trigger they are fired in alphabatical order. 
	-- We can have unlimited triggers
--9. Triggers can modify data before or after the actual modifications . generally a good idea
	-- to verify data and to error out if some custom restrictions are violated.
--10. Triggers cannot br manually executed by user
	-- also no chance for trigger to receive parameters

-- TYPES OF TRIGGERS
-- Row level Trigger - 
	-- If trigger is marked FOR EACH ROW , then reigger will be called for each row that is
	-- modified by the event
	-- eg: if we update 20 rows, Update trigges is called 20 times
-- Statement level Trigger
	-- For each statement option will call the trigger funciton only once for wch statement, regardless the numbers
	-- of rows affcted

CREATE FUNCTION trigger_function()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$ 
BEGIN
-- all trigger logic
END
$$

--CREATE FUNCTION
CREATE  TRIGGER trigger_name
{BEFORE|AFTER} {event}
ON table_name
[FOR [EACH] {ROW|STATEMENT}]
EXECUTE PROCEDURE trigger_function



CREATE TABLE players (player_id SERIAL PRIMARY KEY,
name VARCHAR(100))


CREATE TABLE players_audits (
player_audit_id SERIAL PRIMARY KEY,
player_id INT NOT NULL,
name VARCHAR(100) NOT NULL,
edit_date TIMESTAMP NOT NULL);


--binding function our tablr
--beow old represents before the update
CREATE OR REPLACE FUNCTION fn_player_name_change_log()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS 
$$ 
BEGIN
 -- COMPARE THE new value vs OLD value
 IF NEW.name <> OLD.name THEN 
 	INSERT INTO players_audits 
	 (
		player_id,
		name,
		edit_date
	 )
	 VALUES
	 (
			OLD.player_id,
			OLD.name,
			NOW()
	 );

 END IF;

 return NEW;
END
$$


--CREATE TRIGGER
CREATE TRIGGER trg_players_name_changes
	BEFORE UPDATE
	ON players
	FOR EACH ROW
	EXECUTE PROCEDURE fn_player_name_change_log();

-- Insert data
INSERT INTO players (name) VALUES ('Adam'),
('Linda');

SELECT * FROM players;

--updating data, trigger should run
UPDATE players SET name='Linda3' WHERE player_id =2

SELECT * FROM players_audits;



--Trigger for date modification for INSERT

CREATE TABLE t_temprature_log (
id_temprature_log SERIAL PRIMARY KEY,
add_date TIMESTAMP,
temprature numeric
);

CREATE OR REPLACE FUNCTION fn_tempratire_value_check_at_insert()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS
$$
	BEGIN
	-- temprature <-30 : temperature =0
	IF
		NEW.temprature < -30 THEN NEW.temprature=0;
	END IF;

	RETURN NEW;

	END
$$

CREATE TRIGGER trg_tempratire_Value_check_at_insert
BEFORE INSERT
ON t_temprature_log
FOR EACH ROW
EXECUTE PROCEDURE fn_tempratire_value_check_at_insert();


INSERT INTO t_temprature_log (add_date,temprature) VALUES ('2020-10-01',24)

SELECT * FROM t_temprature_log



------------Add new function which display some key trigger variable data

CREATE OR REPLACE FUNCTION fn_trigger_variables_display()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
	BEGIN
		RAISE NOTICE 'TG_NAME: %', TG_NAME;
		RAISE NOTICE 'TG_RELNAME: %', TG_RELNAME;
		RAISE NOTICE 'TG_WHEN: %', TG_WHEN;
		RAISE NOTICE 'TG_TABLE_NAME: %', TG_TABLE_NAME;
		RAISE NOTICE 'TG_TABLE_SCHEMA %', TG_TABLE_SCHEMA;
		
		RETURN NEW;
	END
$$


CREATE TRIGGER trg_trigger_varaibles_display
AFTER INSERT ON t_temprature_log
FOR EACH ROW
EXECUTE PROCEDURE fn_trigger_variables_display();

INSERT INTO t_temprature_log (add_date,temprature) VALUES ('2020-12-01',34);

--3. Disallow Delete on table using trigger

CREATE TABLE test_delete (
id INT
);

INSERT INTO test_delete (id) VALUES(2),(3);

SELECT * FROM test_delete;

CREATE OR REPLACE FUNCTION fn_generic_cancel_op()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS
$$
	BEGIN
	IF TG_WHEN = 'AFTER' THEN
	RAISE EXCEPTION 'YOU ARE NOT ALLOWED TO % ROW in %.%',TG_OP, TG_TABLE_SCHEMA, TG_TABLE_NAME;

	END IF;
	RAISE NOTICE '% ON ROWS IN %.% WONT HAPPEN',
	TG_OP, TG_TABLE_SCHEMA, TG_TABLE_NAME;
	RETURN NULL;
	END
$$


CREATE TRIGGER trg_disallow_delete
AFTER DELETE ON test_delete
FOR EACH ROW
EXECUTE PROCEDURE fn_generic_cancel_op();


DELETE FROM  test_delete WHERE id=1; 

SELECT * FROM  test_delete;

CREATE TRIGGER trg_skip_delete
BEFORE DELETE ON test_delete
FOR EACH ROW
EXECUTE PROCEDURE fn_generic_cancel_op();


--# Disallow TRUNCATE

--TRUNCATE IS much faster than delete as it does not actuallty scan the tables .
-- And it reclaims disk space immediately rather that requiring VACCUM operation.


CREATE TRIGGER trg_disallow_truncate
AFTER TRUNCATE 
ON test_delete
FOR EACH STATEMENT
EXECUTE PROCEDURE fn_generic_cancel_op();


TRUNCATE test_delete;

--# Audit Trigger

CREATE TABLE audit(
id INT
);

--2. Lets Create an audit_log table. --
CREATE TABLE audit_log(
username TEXT,
add_time TIMESTAMP,
table_name TEXT,
operation TEXT,
row_before JSON,
row_after JSON
);

CREATE OR REPLACE FUNCTION fn_Audit_trigger()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS
$$
	DECLARE 
		old_row json = null;
		new_row json = null;
	BEGIN

		--tg operations
		-- update , delete 
			--old_row 
		IF TG_OP IN('UPDATE','DELETE') THEN
			old_row=row_to_json(OLD);
		END IF;

		-- insert update
		IF TG_OP IN('INSERT','UPDATE') THEN
			new_row=row_to_json(NEW);
		END IF;
			--new row


		--INSERT AUDIT_log
		INSERT INTO audit_log(username , add_time, table_name, operation,row_before,row_after)
			VALUES	(session_user,CURRENT_TIMESTAMP AT TIME ZONE 'UTC',TG_TABLE_SCHEMA || '.'|| TG_TABLE_NAME,
					TG_OP,old_row,new_row);
		RETURN NEW;
	END;
$$


CREATE TRIGGER trg_audit_trigger
AFTER INSERT OR UPDATE OR DELETE
ON audit
FOR EACH ROW
EXECUTE PROCEDURE fn_Audit_trigger();

INSERT INTO audit(id) values (1);
INSERT INTO audit(id) values (2);

SELECT * FROM audit;
SELECT * FROM audit_log;

--UPDATE

UPDATE audit SET id= '100' WHERE id=1

--DELETE
DELETE FROM audit  WHERE id=2



---5#. Create conditional triggers


CREATE TABLE myTask (
	task_id SERIAL PRIMARY KEY,
	task TEXT
);

CREATE OR REPLACE FUNCTION fn_cancel_With_message()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS
$$
	BEGIN
		RAISE EXCEPTION '%',TG_ARGV[0];
		RETURN NULL;
	END;
$$

CREATE TRIGGER trg_no_update_on_friday_afternoon_chill
BEFORE INSERT OR UPDATE OR DELETE OR TRUNCATE
ON myTask
FOR EACH STATEMENT
WHEN (
	EXTRACT('DOW' FROM CURRENT_TIMESTAMP)= 5
	AND CURRENT_TIME >'12:00'
)
EXECUTE PROCEDURE fn_cancel_With_message('No update allowed on friday afternoon');

INSERT INTO myTask (task) VALUES ('test');
SELECT EXTRACT('DOW' FROM CURRENT_TIMESTAMP)= 5,CURRENT_TIME;

SELECT * FROM myTask

--remove trigger

DROP TRIGGER trg_no_update_on_friday_afternoon ON myTask;


--Disallow change on primary key data

--usecase raise an error each time someone tries to change a promary key

-- .1 Lets create our master table
CREATE TABLE pk_table (
id SERIAL PRIMARY KEY,
t TEXT
);

INSERT INTO pk_table(t) VALUES('t1'),('t2');
SELECT * FROM pk_table;

CREATE OR REPLACE FUNCTION fn_generic_cancel_op()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS
$$
	BEGIN
	IF TG_WHEN = 'AFTER' THEN
	RAISE EXCEPTION 'YOU ARE NOT ALLOWED TO % ROW in %.%',TG_OP, TG_TABLE_SCHEMA, TG_TABLE_NAME;

	END IF;
	RAISE NOTICE '% ON ROWS IN %.% WONT HAPPEN',
	TG_OP, TG_TABLE_SCHEMA, TG_TABLE_NAME;
	RETURN NULL;
	END
$$


CREATE TRIGGER disallow_pk_change
AFTER UPDATE OF id
ON pk_table
FOR EACH ROW
EXECUTE PROCEDURE fn_generic_cancel_op();

UPDATE pk_table SET id=100
WHERE id=1


-----------------USE KEY VERY CAREFULLY
-- -- 1. DO NOT CHANGE 
-- 	-- - Primary key
-- 	-- - foreign key
-- 	-- - unique key columns

-- 2. DO not update records in tables that you normaly read during the transactions
-- 3. do not read data from a table that is upadting during same transactiond
-- 4. do not aggrefate/summarized over the table that you are updating