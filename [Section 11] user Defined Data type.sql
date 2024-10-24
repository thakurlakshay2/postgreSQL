--User Defined Data Types

--CREATE DOMAIN data type
----------######################
-- 1. Create Domain statement create a user-defined data type with a range , optional DEFAULT,
-- 		NOT NULL and CHECK constraint.
-- 2. They have to be unique  within a schema scope , Cannot be re use outside of scope where they
-- 		are defined
-- 3. help to STANDERDIZE you db data types in one place.
-- 4. A domain data type is common data type and can be re-use in multiple columns , write once and share
-- 5. NULL is default
-- 6. Composite Type: Only single value return.


--CREATE DOMAIN name AS data_type contraint

CREATE DOMAIN addr VARCHAR(100) NOT NULL

CREATE TABLE locations (
	address addr
);

SELECT * FROM locations

INSERT INTO locations (address) VALUES ('123 london');

INSERT INTO locations (address) VALUES ('123 londond123 londond123 londond123 londond123 londond123 londond123 londond123 londond123 londond123 londond123 londond123 londond123 londond123 londond123 londond123 londond');



-- Positive numeric
CREATE DOMAIN positive_numeric AS INT
CHECK (VALUE IS NULL OR VALUE > 0);

ALTER TABLE locations
ADD COLUMN value_num positive_numeric;

UPDATE locations
SET value_num = 10  -- Replace <condition> with a specific condition to target the row(s).

INSERT INTO locations (address, value_num) VALUES('china',-10)


--- Postal Code
CREATE DOMAIN in_postal_code AS TEXT
CHECK (
VALUE ~'^[1-9]{1}[0-9]{2}\\s{0,1}[0-9]{3}$'
)

CREATE TABLE addresses (
	address_id SERIAL PRIMARY KEY,
	postal_code in_postal_code
);

INSERT INTO addresses (postal_code) VALUES('dawpodijwa');


---email

CREATE DOMAIN proper_email VARCHAR(150)
CHECK (
	VALUE ~*'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'
);
