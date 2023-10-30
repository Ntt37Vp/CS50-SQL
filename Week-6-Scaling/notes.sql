-- Week 6: Scaling

-- MySQL
-- mysql -u username -h 127.0.9.1 -P 3306 -p
CREATE DATABASE `mbta`;
SHOW DATABASES;
USE `mbta`;

-- DataTypes in MySQL
-- tinyint (1byte), smallint, mediumint, int, bigint (8byte)

CREATE TABLE `cards` (
    `id` INT AUTO_INCREMENT,
    PRIMARY KEY(`id`)
);
SHOW TABLES;
DESCRIBE `cards`;


-- Stored Procedures

-- PostgreSQL

-- Replication

-- Sharding

-- Access Control

-- SQL Injections


-- Prepared Statements
