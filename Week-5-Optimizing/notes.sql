-- Week 5: Optimizing

-- Optimizing Intro
-- the IMDB db
-- SELECT * FROM movies
-- WHERE "title" = 'Cars';
-- How long did it take to run this query?
-- .timer on
-- 84ms

-- INDEX is a structure used to speed up the retrieval of rows
-- syntax
-- CREATE INDEX index_name
-- ON table_name (column1, column2, ...); 
-- actual command on our movies.db
CREATE INDEX "title_index"
ON movies ("tile");
-- .timer on
-- Run Time: real 0.029 user 0.029006 sys 0.000000
-- wow! 65.4% improvement (from 84ms to 29ms) or 3x as fast!

-- EXPLAIN QUERY PLAN
EXPLAIN QUERY PLAN
SELECT ...
FROM ...;
-- TO DROP AN INDEX
DROP INDEX index_name; 

-- take this subquery for ex where we nest 2 SELECTS
SELECT "title"
FROM movies
WHERE "id" IN (
	SELECT "movie_id"
	FROM stars
	WHERE "person_id" = (
		SELECT "id"
		FROM people
		WHERE "name" = 'Tom Hanks'
	)
);
-- Run Time: real 0.089 user 0.066153 sys 0.010426
-- ran EXPLAIN QUERY PLAN
-- |--SEARCH movies USING INTEGER PRIMARY KEY (rowid=?)
-- `--LIST SUBQUERY 2
--    |--SCAN stars
--    `--SCALAR SUBQUERY 1
--       `--SCAN people

-- So let's create an Index for PEOPLE and STARS tables
CREATE INDEX "person_index"
ON "stars" ("person_id");
CREATE INDEX "name_index"
ON "people" ("name");
-- WHEN THE SELECT (with 2 subqueries) code above is re-ran the time is
--Run Time: real 0.010 user 0.003378 sys 0.006995
-- That was 8 to 9x faster!
-- getting the EXPLAIN QUERY PLAN:
-- QUERY PLAN
-- |--SEARCH movies USING INTEGER PRIMARY KEY (rowid=?)
-- `--LIST SUBQUERY 2
--    |--SEARCH stars USING INDEX person_index (person_id=?)
--    `--SCALAR SUBQUERY 1
--       `--SEARCH people USING COVERING INDEX name_index (name=?)


-- COVERING INDEX
-- is an index in w/c queried data can be retrieved from the index itself
 CREATE INDEX "person_index" ON "stars" ("person_id", "movie_id");


 -- B-Trees
 -- INDEX use Balance Tree data structure
 
 -- PARTIAL INDEX
 -- index that only contains a subset of rows from a table
 -- let's create a partial index
 CREATE INDEX "recents"
 ON "movies" ("title")
 WHERE "year" = 2023;
-- then let's query
SELECT "title" FROM "movies" 
WHERE "year" = 2023;
-- Run Time: real 0.124 user 0.009492 sys 0.030444
EXPLAIN QUERY PLAN 
--  QUERY PLAN
--SCAN movies USING INDEX recents

-- VACUUM
-- to give back the unused bytes
-- unix cmd: du -b filename
-- run VACUUM in sqlite then run 'du -b' in order to get the actual memory


-- CONCURRENCY
-- A transaction is an individual unit of work
-- A.C.I.D.
-- Atomicity, Consistency, Isolation, Durability
-- syntax
BEGIN transaction;
...
COMMIT;
-- Scenario: Say, Alice sends her 10 bal to Bob
-- if we do this using 2 txn: Alice deduct 10 , then Bob add 10
-- if we use BEGIN TRANSACTION instead:
BEGIN TRANSACTION;
UPDATE "accounts"
SET "balance" = "balance" + 10
WHERE "id" = 2;
UPDATE "accounts"
SET "balance" = "balance" - 10
WHERE "id" = 1;
COMMIT;
-- output:
-- +----+---------+---------+
-- | id |  name   | balance |
-- +----+---------+---------+
-- | 1  | Alice   | 0       |
-- | 2  | Bob     | 30      |
-- | 3  | Charlie | 30      |
-- +----+---------+---------+

-- say Alice (0 bal) wanted to transfer another 10
-- this will break the schema CHECK constraint
-- to revert, instead of "COMMIT", use "ROLLBACK"
BEGIN TRANSACTION;
UPDATE "accounts"
SET "balance" = "balance" + 10
WHERE "id" = 2;
UPDATE "accounts"
SET "balance" = "balance" - 10
WHERE "id" = 1;
ROLLBACK;
