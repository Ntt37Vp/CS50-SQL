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