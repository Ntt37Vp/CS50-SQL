-- Week 6: Scaling

-- MySQL
-- mysql -u username -h 127.0.9.1 -P 3306 -p

-- DataTypes in MySQL
-- tinyint (1byte), smallint, mediumint, int, bigint (8byte)
-- CHAR(M) , VARCHAR(M), TEXT
-- BLOB
-- ENUM ("enumerate" like tshirt sizes: S, M, L) (choose only 1)
-- SET (can choose more than 1)
-- DATE, TIME(fsp) DATETIME(fsp), TIMESTAMP(fsp), YEAR
-- FLOAT (4 bytes), DOUBLE PRECISION (8 bytes)
-- DECIMAL (5, 2) (5 digits with 2 decimal; ex: 999.99)


CREATE DATABASE `mbta`;
SHOW DATABASES;
USE `mbta`;

CREATE TABLE `cards`
(
    `id` INT AUTO_INCREMENT,
    PRIMARY KEY
(`id`)
);
SHOW TABLES;
DESCRIBE `cards`;

CREATE TABLE `stations`
(
    `id` INT AUTO_INCREMENT,
    `name` VARCHAR
(32) NOT NULL UNIQUE,
    `line` ENUM
('blue', 'green', 'orange', 'red') NOT NULL,
    PRIMARY KEY
(`id`)
);
SHOW TABLES;
DESCRIBE `stations`;

CREATE TABLE `swipes`
(
    `id` INT AUTO_INCREMENT,
    `card_id` INT,
    `station_id` INT,
    `type` ENUM
('enter', 'exit', 'deposit') NOT NULL,
    `datetime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `amount` DECIMAL
(5,2) NOT NULL CHECK
(`amount` != 0),
    PRIMARY KEY
(`id`),
    FOREIGN KEY
(`card_id`) REFERENCES `cards`
(`id`),
    FOREIGN KEY
(`station_id`) REFERENCES `stations`
(`id`)
);
SHOW TABLES;
DESCRIBE `swipes`;

-- altering tables in mysql
-- say we wanted to add a new line 'silver'
ALTER TABLE `stations`
MODIFY `line` ENUM
('blue', 'green', 'orange', 'red', 'silver') NOT NULL;
-- check:
DESCRIBE `stations`;


-- STORED PROCEDURES (56min 30sec)
-- syntax
CREATE PROCEDURE proc_name
BEGIN
    ...
END;
-- let's use the collections db
CREATE DATABASE `collections`;
USE `collections`;
CREATE TABLE `collections` (
    `id` INT AUTO_INCREMENT,
    `title` VARCHAR(64) NOT NULL,
    `accession_number` VARCHAR(9) NOT NULL,
    `acquired` DATE,
    PRIMARY KEY(`id`)
);
CREATE TABLE `artists` (
...
)
CREATE TABLE `created` (
...
)

-- alter table to add `deleted` column 
ALTER TABLE `collections`
ADD COLUMN `deleted` TINYINT DEFAULT 0;
DESCRIBE `collections`;

-- stored procedure steps
-- change the mysql delimiter from ; to //
DELIMITER //
CREATE PROCEDURE `current_collection`()
BEGIN
    SELECT `title`, `accession_number`, `acquired`
    FROM `collections`
    WHERE `deleted` = 0;
END//
DELIMITER ;
-- change delimiter back to ;
-- you may then call that 'procedure' or function
CALL `current_collection`();

-- add new table for sold collections
CREATE TABLE `transactions` (
    `id` INT AUTO_INCREMENT,
    `title` VARCHAR(64) NOT NULL,
    `action` ENUM('bought', 'sold') NOT NULL,
    PRIMARY KEY(`id`)
);

-- let's create that new procedure
-- notice that this new func takes an input IN
DELIMITER //
CREATE PROCEDURE `sell`(IN `sold_id` INT)
BEGIN
    UPDATE `collections`
    SET `deleted` = 1
    WHERE `id` = `sold_id`;
    INSERT INTO `transactions` (`title`, `action`)
    VALUES((SELECT `title` FROM `collections` WHERE `id` = `sold_id`), 'sold');
END//
DELIMITER;
-- let's call
CALL `sell`(2);
-- stored procedure can take these conditional statements
-- IF, ELSEIF, ELSE
-- LOOP
-- REPEAT
-- WHILE


-- PostgreSQL
-- DataTypes in PostgreSQL
-- smallint (2 bytes) (min max -32768 +32767)
-- int (4 bytes)
-- bigint (8 bytes)
-- smallserial, bigserial
-- SERIAL (good for prime keys because of default auto incre)
-- TIMESTAMP, DATE, TIME, INTERVAL
-- MONEY
-- NUMERIC (precision, scale)
-- Double quotes are back! ;)
-- port 5432

-- connect
psql postgresql://postgres@127.0.0.1:5432/postgres
-- show
\l
-- create mbta
CREATE DATABASE "mbta";
-- connect to specified db
\c "mbta"
-- list tables
\dt
-- create
CREATE TABLE "cards" (
    "id" SERIAL,
    PRIMARY KEY("id")
);
-- schema:
\d "cards"
-- let's create more tables
CREATE TABLE "stations" (
    "id" SERIAL,
    "name" VARCHAR(32) NOT NULL,
    "line" VARCHAR(32) NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE "swipes" (
    "type" swipe_type,
    "datetime" ,
    "amount"
)
-- ENUM is supported but we have to CREATE TYPE first
CREATE TYPE "swipe_type"
AS ENUM('enter', 'exit', 'deposit');



-- Replication

-- Sharding

-- Access Control

-- SQL Injections


-- Prepared Statements
