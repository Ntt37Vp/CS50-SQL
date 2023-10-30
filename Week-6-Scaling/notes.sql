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

CREATE TABLE `cards` (
    `id` INT AUTO_INCREMENT,
    PRIMARY KEY(`id`)
);
SHOW TABLES;
DESCRIBE `cards`;

CREATE TABLE `stations` (
    `id` INT AUTO_INCREMENT,
    `name` VARCHAR(32) NOT NULL UNIQUE,
    `line` ENUM('blue', 'green', 'orange', 'red') NOT NULL,
    PRIMARY KEY(`id`)
);
SHOW TABLES;
DESCRIBE `stations`;

CREATE TABLE `swipes` (
    `id` INT AUTO_INCREMENT,
    `card_id` INT,
    `station_id` INT,
    `type` ENUM('enter', 'exit', 'deposit') NOT NULL,
    `datetime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `amount` DECIMAL(5,2) NOT NULL CHECK(`amount` != 0),
    PRIMARY KEY(`id`),
    FOREIGN KEY(`card_id`) REFERENCES `cards` (`id`),
    FOREIGN KEY(`station_id`) REFERENCES `stations`(`id`)
);
SHOW TABLES;
DESCRIBE `swipes`;

-- altering tables in mysql
-- say we wanted to add a new line 'silver'
ALTER TABLE `stations`
MODIFY `line` ENUM('blue', 'green', 'orange', 'red', 'silver') NOT NULL;
-- check:
DESCRIBE `stations`;


-- Stored Procedures (56min 30sec)

-- PostgreSQL

-- Replication

-- Sharding

-- Access Control

-- SQL Injections


-- Prepared Statements
