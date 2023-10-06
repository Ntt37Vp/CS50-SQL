-- #1: write a SQL query to list the titles of all episodes in Cyberchase’s original season, Season 1.
-- SELECT "title"
-- FROM episodes
-- WHERE "season" = 1;

-- #2: list the season number of, and title of, the first episode of every season.
-- SELECT season, title
-- FROM episodes
-- WHERE "episode_in_season"=1;

-- #3
-- SELECT production_code
-- FROM episodes
-- WHERE "title" = "Hackerized!";

-- #4
-- SELECT "title"
-- FROM episodes
-- WHERE "topic" IS NULL;

-- #5: 
-- SELECT "title"
-- FROM episodes
-- WHERE "air_date"="2004-12-31";

-- #6: list the titles of episodes from season 6 (2008) that were released early, in 2007.
-- SELECT "title"
-- FROM episodes
-- WHERE "season" = 6 AND "air_date" LIKE "2007%";

-- #7: write a SQL query to list the titles and topics of all episodes teaching fractions.
-- SELECT "title", "topic"
-- FROM episodes
-- WHERE "topic" LIKE "%fraction%";

-- #8: write a query that counts the number of episodes released in the last 5 years, from 2018 to 2023, inclusive.
-- You might find it helpful to know you can use BETWEEN with dates, such as BETWEEN '2000-01-01' AND '2000-12-31'.
-- SELECT COUNT("title")
-- FROM episodes
-- WHERE "air_date" BETWEEN '2018-01-01' AND '2023-12-31';

-- #9: write a query that counts the number of episodes released in Cyberchase’s first 5 years, from 2002 to 2007, inclusive.
-- SELECT COUNT("title")
-- FROM episodes
-- WHERE "air_date" BETWEEN '2002-01-01' AND '2007-12-31';

-- #10
SELECT "id", "title", "production_code"
FROM episodes
ORDER BY "production_code" ASC;

-- #11
SELECT "title"
FROM episodes
WHERE "season" = 5
ORDER BY "title" DESC;

-- In 12.sql, count the number of unique episode titles.
SELECT COUNT(DISTINCT "title")
FROM episodes;

-- In 13.sql, write a SQL query to explore a question of your choice. This query should:
-- Involve at least one condition, using WHERE with AND or OR
SELECT "title"
FROM episodes
WHERE "title" LIKE "%fly%";