-- SEQUENCES

--# Create seq
CREATE SEQUENCE IF NOT EXISTS test_seq

--# Advance squences and return new value\
SELECT nextval('test_seq')


--# Return most current value ofthe squence
SELECT currval('test_seq');

--#Set custom value
SELECT setval('test_seq',100)

--# Set a seq and do not skip over
SELECT setval('test_seq',120,false);

--#6. Control the sequence START value
CREATE SEQUENCE IF NOT EXISTS  test_seq2 START WITH 100

-- Alter a sequence

ALTER SEQUENCE test_seq RESTART WITH  200 
SELECT nextval('test_seq')

ALTER SEQUENCE test_seq RENAME TO my_seq
SELECT nextval('my_seq')

ALTER SEQUENCE public.my_seq INCREMENT 20 CYCLE;

--# Use multiple sequence parameters to reate a sequence
CREATE SEQUENCE IF NOT EXISTS test_seq3
INCREMENT 50
MINVALUE 400
MAXVALUE 6000
START WITH 500

SELECT nextval('test_seq3')

SELECT currval('test_seq3');

--# Speciy the data type of a sequence (SMALLINT| INT| BIGINT)
CREATE SEQUENCE IF NOT EXISTS test_seq_smallint as SMALLINT

SELECT nextval('test_seq_smallint')

--# Create a Descending sequence  and CYCLE (loops back to min/max value depending on asc or desc)| NO CYCLE
CREATE SEQUENCE seq_des
INCREMENT -1
MINVALUE 1
MAXVALUE 3
START 3
CYCLE

CREATE SEQUENCE seq_des_noCycle
INCREMENT -1
MINVALUE 1
MAXVALUE 3
START 3
NO CYCLE

SELECT nextval('seq_des')
SELECT nextval('seq_des_noCycle')



--# Delete drop a sequence

DROP SEQUENCE  seq_des_noCycle
SELECT nextval('seq_des_noCycle')

------------## Attach sequence to a table
-- to attach a sequence to an existing table 

-- Step 1 Create sequence and attached to a table

DROP FUNCTION IF EXISTS fn_event_abort_create_table;
CREATE TABLE users(
	user_id SERIAL PRIMARY KEY,
	user_name VARCHAR(50)
)


CREATE TABLE users2(
	user2_id INT PRIMARY KEY,
	user2_name VARCHAR(50)
)

INSERT INTO users (user_name) VALUES ('ADNAN')
SELECT * FROM users;


--Create sequence name
CREATE SEQUENCE users_user_id_seq RESTART WITH 100

CREATE SEQUENCE users2_user2_id_seq  START WITH 100 OWNED BY users2.user2_id 

-- alter table column and set sequence

ALTER TABLE users2
ALTER COLUMN user2_id SET DEFAULT nextval('users2_user2_id_seq')

INSERT INTO users2 (user2_name) VALUES ('ADAM2')

SELECT * FROM users2

-- Listem all sequence

SELECT relname sequence_name
FROM pg_class
WHERE relkind= 'S';

--Sharing sequenc between multiple tables

CREATE SEQUENCE common_fruits_seq START WITH 100

CREATE TABLE apples (
	FRUIT_ID INT DEFAULT nextval('common_fruits_seq') NOT NULL,
	fruit_name VARCHAR(50)
);

CREATE TABLE mangoes (
	FRUIT_ID INT DEFAULT nextval('common_fruits_seq') NOT NULL,
	fruit_name VARCHAR(50)
);

INSERT INTO apples (fruit_name) VALUES ('big apple2')
INSERT INTO mangoes (fruit_name) VALUES ('big mango')

SELECT * from apples
SELECT * from mangoes

--Creating alpha numberic sequence
-- By default sequenc eonly consists of numner
-- first lelts see how normallt sequence are worked

--Create a sequence
CREATE SEQUENCE table_seq;

--create table

CREATE TABLE contacts (
contact_id TEXT NOT NULL DEFAULT ('ID' || nextval('table_seq')),
contact_name VARCHAR(150)
);

--Alter sequence
ALTER SEQUENCE table_seq OWNED BY contacts.contact_id

INSERT INTO contacts(contact_name) VALUES ('ADNAN2')

SELECT * FROM contacts
