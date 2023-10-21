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

