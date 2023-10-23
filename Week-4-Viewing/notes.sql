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