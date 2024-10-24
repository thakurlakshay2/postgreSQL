-- Database: my Data
--Section 8 AND ABOVE


CREATE DATABASE mydata
WITH
	OWNER = postgres
	ENCODING = 'UTF8'
	LC_COLLATE = 'C'
	LC_CTYPE = 'C'
	TABLESPACE = pg_default
	CONNECTION LIMIT = -1;

CREATE TABLE persons(
	person_id SERIAL PRIMARY KEY,
	first_name VARCHAR(20) NOT NULL,
	last_name VARCHAR(20) NOT NULL
)
--# ADDING COLUMN TO TABLE
ALTER TABLE persons
ADD COLUMN age INT NOT NULL;

ALTER TABLE persons
ADD COLUMN nationality VARCHAR(20) NOT NULL,
ADD COLUMN email VARCHAR(100) UNIQUE

SELECT * FROM persons

--RENAME TABLE

ALTER TABLE persons
RENAME TO users;

ALTER TABLE users
RENAME TO persons;

-- Rename a column

ALTER TABLE persons
RENAME COLUMN age TO person_age

--Drop a column
ALTER TABLE persons
DROP COLUMN person_age;

ALTER TABLE persons
ADD COLUMN age VARCHAR(10) ;


--CHANGE the data type of a column
ALTER TABLE persons
ALTER COLUMN age TYPE int 
USING age::integer;

ALTER TABLE persons
ALTER COLUMN age TYPE VARCHAR(20); 


--Set default calues of a column

ALTER TABLE persons
ADD COLUMN is_enable VARCHAR(1);


ALTER TABLE persons
ALTER COLUMN is_enable SET DEFAULT 'Y';

INSERT INTO persons (
first_name,
last_name,
nationality,
age,
link_target,
link_url
)
VALUES(
'JOHN',
'bene',
'indian',
22,
'googl.com',
'_blank'
);

SELECT * FROM persons;


--ADD unique Constraints to a table , connot add same data in link_url
ALTER TABLE persons
ADD COLUMN link_target VARCHAR(20) ;

ALTER TABLE persons
ADD COLUMN link_url VARCHAR(20);

ALTER TABLE persons
ADD CONSTRAINT unique_web_url UNIQUE (link_url);


--set column to accept only defined allowed value.

ALTER TABLE persons
ADD CHECK(is_enable IN ('Y','N'));

INSERT INTO persons (
first_name,
last_name,
nationality,
age,
link_target,
link_url,
is_enable
)
VALUES(
'JOHN',
'bene',
'indian',
22,
'googlqsq.com',
'_blsqank',
'L'
);