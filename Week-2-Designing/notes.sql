-- Week 2 - Designing

-- use .SCHEMA to view details about the db 
-- output:
-- CREATE TABLE IF NOT EXISTS "longlist" (
--     "isbn" TEXT,
--     "title" TEXT,
--     "author" TEXT,
--     "translator" TEXT,
--     "format" TEXT,
--     "pages" INTEGER,
--     "publisher" TEXT,
--     "published" TEXT,
--     "year" INTEGER,
--     "votes" INTEGER,
--     "rating" REAL
-- );
-- using .SCHEMA on the improved version of the db in Week-1-Relating
-- output:
-- CREATE TABLE IF NOT EXISTS "authors" (
--     "id" INTEGER,
--     "name" TEXT,
--     "country" TEXT,
--     "birth" INTEGER,
--     PRIMARY KEY("id")
-- );
-- CREATE TABLE IF NOT EXISTS "authored" (
--     "author_id" INTEGER,
--     "book_id" INTEGER,
--     FOREIGN KEY("author_id") REFERENCES "authors"("id"),
--     FOREIGN KEY("book_id") REFERENCES "books"("id")
-- );
-- CREATE TABLE IF NOT EXISTS "books" (
--     "id" INTEGER,
--     "isbn" TEXT,
--     "title" TEXT,
--     "publisher_id" INTEGER,
--     "format" TEXT,
--     "pages" INTEGER,
--     "published" TEXT,
--     "year" INTEGER,
--     PRIMARY KEY("id"),
--     FOREIGN KEY("publisher_id") REFERENCES "publishers"("id")
-- );
-- CREATE TABLE IF NOT EXISTS "publishers" (
--     "id" INTEGER,
--     "publisher" TEXT,
--     PRIMARY KEY("id")
-- );
-- CREATE TABLE IF NOT EXISTS "ratings" (
--     "book_id" INTEGER,
--     "rating" INTEGER,
--     FOREIGN KEY("book_id") REFERENCES "books"("id")
-- );
-- CREATE TABLE IF NOT EXISTS "translators" (
--     "id" INTEGER,
--     "name" TEXT,
--     PRIMARY KEY("id")
-- );
-- CREATE TABLE IF NOT EXISTS "translated" (
--     "translator_id" INTEGER,
--     "book_id" INTEGER,
--     FOREIGN KEY("translator_id") REFERENCES "translators"("id"),
--     FOREIGN KEY("book_id") REFERENCES "books"("id")
-- );

-- NORMALIZING of data
-- to normalize is to breakdown
-- RELATING of data
-- linking tables relationship
-- so the ER diagram for Rider to Stations is
-- Rider -> Station (one to many) (a Rider must be associated to a Station)
-- Station -> Rider (zero to many) (a Station can have ZERO to Many Riders)

-- CREATE TABLE 
-- before that, create a db: sqlite3 mbta.db
-- doing .SCHEMA shows blank, same with .TABLES
-- create your first table: 
CREATE TABLE "Riders" (
    "id" ,
    "name"
);
CREATE TABLE "Stations" (
    "id",
    "name",
    "line"
);
-- Relate or Associate the tables
CREATE TABLE "Visits" (
    "rider_id",
    "station_id"
);

-- Data Types & Storage Classes 
-- SQLite has 5 Storage Classes:
    -- NULL
    -- INTEGER
    -- REAL 
    -- TEXT ()
    -- BLOB (binary large obj)(like images)

-- the INTEGER class has 8 data types
-- 0-byte int
-- 1-byte int
-- 2-byte int
-- 4-byte int
-- 6-byte int
-- 7-byte int
-- 8-byte int

-- "TYPE affinities"
-- TEXT
-- NUMERIC
-- INTEGER
-- REAL
-- BLOB

-- going back to the tables,let's delete/drop so we can improve
DROP TABLE "Riders";
DROP TABLE "Stations";

-- instead of using sqlite cli, let's create a SCHEMA file
-- schema.sql

-- run/read the schema file
-- .read schema.sql

-- Table Constraints
-- like Primary keys must not be NULL
-- improving the schema file:
CREATE TABLE "riders" (
    "id" INTEGER,
    "name" TEXT,
    PRIMARY KEY ("id")
);
CREATE TABLE "stations" (
    "id" INTEGER,
    "name" TEXT,
    "line" TEXT,
    PRIMARY KEY("id")
);


-- Column Constraints
CHECK
DEFAULT
NOT NULL
UNIQUE
-- improving the schema file:
CREATE TABLE "riders" (
    "id" INTEGER,
    "name" TEXT,
    PRIMARY KEY ("id")
);
CREATE TABLE "stations" (
    "id" INTEGER,
    "name" TEXT NOT NULL UNIQUE,
    "line" TEXT,
    PRIMARY KEY("id")
);


-- Altering Tables

-- improving our Design here, instead of using RIDERS, we will consider CARDS
-- I will drop Riders table
DROP TABLE "riders"

-- altering using ALTER TABLE
-- ADD
ALTER TABLE table_name
ADD column_name datatype; 
-- DROP Column
ALTER TABLE table_name
DROP COLUMN column_name; 
-- RENAME
ALTER TABLE table_name
RENAME COLUMN old_name to new_name; 

-- Let's rename "visits" table into "swipes"
ALTER TABLE "visits"
RENAME TO "swipes";
-- adding column "types" to "swipes"
ALTER TABLE "swipes"
ADD COLUMN "type" TEXT;
