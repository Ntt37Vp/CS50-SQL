-- Week 4: Viewing

-- VIEW is a virtual table defined by a query
-- Reasons to use VIEW:
-- Simplifying, Aggregating, Partitioning, Securing

-- Approach 1: nested queries
SELECT "id"
FROM authors
WHERE "name" = 'Fernanda Melchor';
-- output: 24
-- using it for subquery
SELECT "book_id"
FROM authored
WHERE "author_id" = (
    SELECT "id"
    FROM authors
    WHERE "name" = 'Fernanda Melchor'
);
-- output: 14 & 48
SELECT "title"
FROM books
WHERE "id" IN (
    SELECT "book_id"
    FROM authored
    WHERE "author_id" = (
        SELECT "id"
        FROM authors
        WHERE "name" = 'Fernanda Melchor'
    )
);
-- output: Paradais & Hurricane Season

-- Approach 2: Using JOIN instead
SELECT 
    "authors"."name",
    "books"."title"
FROM "authors"
JOIN "authored"
ON "authors"."id" = "authored"."author_id"
JOIN "books"
ON "books"."id" = "authored"."book_id";
-- WHERE "authors"."name" = 'Fernanda Melchor';
-- to save this "temp table" , use VIEW

-- VIEW syntax
CREATE VIEW view_name AS
SELECT column1, column2, ...
FROM table_name
WHERE condition; 
-- to drop view
DROP VIEW view_name

-- improving our query above using VIEW
CREATE VIEW "longlist" AS
SELECT 
    "authors"."name",
    "books"."title"
FROM authors
JOIN authored
ON "authors"."id" = "authored"."author_id"
JOIN books
ON "books"."id" = "authored"."book_id";

-- so to query "longlist" to find books by 'Fernanda Melchor'
SELECT "title"
FROM longlist
WHERE name = 'Fernanda Melchor';


-- AGGREGATING
-- approach using
SELECT 
    "books"."title",
    ROUND(AVG("rating"), 2) AS "avg_rating"
FROM "ratings"
JOIN "books"
ON "books"."id"="ratings"."book_id"
GROUP BY "books"."title";

-- creating a VIEW
CREATE VIEW "average_book_rating" AS
SELECT 
    "ratings"."book_id",
    "books"."title",
    "books"."year",
    ROUND(AVG("ratings"."rating"), 2) AS "avg_rating"
FROM "ratings"
JOIN "books"
ON "books"."id" = "ratings"."book_id"
GROUP BY "ratings"."book_id";

-- Temporary VIEW
CREATE TEMPORARY VIEW "average_ratings_by_year" AS
SELECT
    "year",
    ROUND(AVG("avg_rating"), 2) AS "rating"
FROM "average_book_rating"
GROUP BY "year";
-- this temp view table "average_ratings_by_year" will be dropped once .quit is ran


-- Common Table Expressions (CTE)
-- is a VIEW that exist in the duration of a single query
WITH cte_name AS (
    SELECT ...
), ...
SELECT ...
FROM table_name;

-- an ex of CTE using the same scenario above of "average rating "
-- the following CTE below has the same output as the process above:
WITH "average_book_ratings" AS (
    SELECT 
        "book_id",
        "title",
        "year",
        ROUND(AVG("rating"), 2) AS "Rating"
    FROM "ratings"
    JOIN "books"
    ON "books"."id" = "ratings"."book_id"
    GROUP BY "book_id"
)
SELECT "year", ROUND(AVG("Rating"), 2) AS "Avg_Rating"
FROM "average_book_ratings"
GROUP BY "year";


-- PARTITIONING
SELECT
    "id",
    "title"
FROM books
WHERE "year" = 2022;
-- to save a table/view for this outout of books nominated in 2022:
CREATE VIEW "2022_books" AS
SELECT
    "id",
    "title"
FROM "books"
WHERE "year" = 2022;
-- 2021
CREATE VIEW "2021_books" AS
SELECT
    "id",
    "title"
FROM "books"
WHERE "year" = 2021;


-- SECURING
-- use rideshare.db
SELECT *
FROM rides;
-- to hide/omit rider column
SELECT "id", "origin", "destination", 'Anonymous' AS 'rider'
FROM rides;
-- turn it into a VIEW
CREATE VIEW "analysis" AS 
SELECT "id", "origin", "destination", 'Anonymous' AS 'rider'
FROM rides;


-- Soft Deletions
-- in a table where "deleted" items are marked as 1:
SELECT * 
FROM collections
WHERE "deleted" = 0;

-- Triggers with VIEWS
-- testing mfa.db
-- let's add "deleted" column to collections:
ALTER TABLE "collections"
ADD COLUMN "deleted" INTEGER DEFAULT 0;
-- so... to soft delete an item
UPDATE "collections"
SET "deleted" = 1
WHERE "title" = 'Farmers working at dawn';

-- so let's create a VIEW
CREATE VIEW "current_collections" AS
SELECT "id", "title", "accession_number", "acquired"
FROM "collections"
WHERE "deleted" = 0;

-- VIEWS cannot be modified
-- use TRIGGER instead
CREATE TRIGGER trigger_name
INSTEAD OF DELETE ON view
FOR EACH ROW
BEGIN
    ...;
END;
-- actual code
CREATE TRIGGER "delete"
INSTEAD OF DELETE ON "current_collections"
FOR EACH ROW
BEGIN
    UPDATE "collections"
    SET "deleted" = 1
    WHERE "id" =  OLD."id";
END;
-- output:
-- +----+-------------------------+------------------+------------+---------+
-- | id |          title          | accession_number |  acquired  | deleted |
-- +----+-------------------------+------------------+------------+---------+
-- | 1  | Farmers working at dawn | 11.6152          | 1911-08-03 | 1       |
-- | 2  | Imaginative landscape   | 56.496           |            | 1       |
-- | 3  | Profusion of flowers    | 56.257           | 1956-04-12 | 0       |
-- | 4  | Spring outing           | 14.76            | 1914-01-08 | 0       |
-- +----+-------------------------+------------------+------------+---------+

-- another TRIGGER (to add)
CREATE TRIGGER another_trigger_name
INSTEAD OF INSERT ON view
FOR EACH ROW WHEN condition
BEGIN
    ...;
END;
-- actual code
CREATE TRIGGER "insert_when_exists"
INSTEAD OF INSERT ON "current_collections"
FOR EACH ROW 
WHEN NEW."accession_number" IN (
    SELECT "accession_number"
    FROM collections
)
BEGIN
    UPDATE "collections"
    SET "deleted" = 0
    WHERE "accession_number" = NEW."accession_number";
END;
-- so if we try to insert an item back
-- let's add Imaginative landscape back
-- +----+-------------------------+------------------+------------+---------+
-- | id |          title          | accession_number |  acquired  | deleted |
-- +----+-------------------------+------------------+------------+---------+
-- | 1  | Farmers working at dawn | 11.6152          | 1911-08-03 | 1       |
-- | 2  | Imaginative landscape   | 56.496           |            | 1       |
-- | 3  | Profusion of flowers    | 56.257           | 1956-04-12 | 0       |
-- | 4  | Spring outing           | 14.76            | 1914-01-08 | 0       |
-- +----+-------------------------+------------------+------------+---------+
-- SELECT * FROM current_collections:
-- only shows the 2 rows with 0 
-- +----+----------------------+------------------+------------+
-- | id |        title         | accession_number |  acquired  |
-- +----+----------------------+------------------+------------+
-- | 3  | Profusion of flowers | 56.257           | 1956-04-12 |
-- | 4  | Spring outing        | 14.76            | 1914-01-08 |
-- +----+----------------------+------------------+------------+

INSERT INTO "current_collections" ("title", "accession_number", "acquired")
VALUES ("Imaginative landscape", 56.496, NULL);
-- output:
-- +----+-----------------------+------------------+------------+
-- | id |         title         | accession_number |  acquired  |
-- +----+-----------------------+------------------+------------+
-- | 2  | Imaginative landscape | 56.496           |            |
-- | 3  | Profusion of flowers  | 56.257           | 1956-04-12 |
-- | 4  | Spring outing         | 14.76            | 1914-01-08 |
-- +----+-----------------------+------------------+------------+
