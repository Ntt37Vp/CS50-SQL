-- In 1.sql, write a SQL query to find the average player salary by year.
-- Sort by year in descending order.
-- Round the salary to two decimal places and call the column “average salary”.
-- Your query should return a table with two columns, one for year and one for average salary.
-- SELECT 
-- 	year,
-- 	ROUND(AVG("salary"), 2) AS "average salary"
-- FROM salaries
-- GROUP BY year
-- ORDER BY year DESC;

-- In 2.sql, write a SQL query to find Cal Ripken Jr.’s salary history.
-- Sort by year in descending order.
-- Your query should return a table with two columns, one for year and one for salary.
-- SELECT year, salary
-- FROM salaries
-- WHERE player_id = (
-- 	SELECT id
-- 	FROM players
-- 	WHERE last_name='Ripken' AND first_name='Cal'
-- )
-- ORDER BY year DESC;

-- In 3.sql, write a SQL query to find Ken Griffey Jr.’s home run history.
-- Sort by year in descending order.
-- Note that there may be two players with the name “Ken Griffey.” This Ken Griffey was born in 1969.
-- Your query should return a table with two columns, one for year and one for home runs.
-- SELECT "year", "HR"
-- FROM performances
-- WHERE player_id = (
-- 	SELECT id
-- 	FROM players
-- 	WHERE last_name='Griffey' AND first_name='Ken' AND birth_year=1969
-- )
-- ORDER BY "year" DESC;


-- In 4.sql, write a SQL query to find the 50 players paid the least in 2001.
-- Sort players by salary, lowest to highest.
-- If two players have the same salary, sort alphabetically by first name and then by last name.
-- If two players have the same first and last name, sort by player ID.
-- Your query should return three columns, one for players’ first names, one for their last names, and one for their salaries.
-- SELECT 
-- 	players.first_name,
-- 	players.last_name,
-- 	salaries.salary
-- FROM salaries
-- INNER JOIN players
-- ON players.id=salaries.player_id
-- WHERE year=2001
-- ORDER BY salary, first_name, last_name, player_id;


-- In 5.sql, write a SQL query to find all teams that Satchel Paige played for.
-- Your query should return a table with a single column, one for the name of the teams.
-- SELECT DISTINCT 
-- 	teams.name
-- FROM performances
-- INNER JOIN teams
-- ON teams.id = performances.team_id
-- WHERE player_id = (
-- 	SELECT id
-- 	FROM players
-- 	WHERE first_name='Satchel'
-- );


-- In 6.sql, write a SQL query to return the top 5 teams, sorted by the total number of hits by players in 2001.
-- Call the column representing total hits by players in 2001 “total hits”.
-- Sort by total hits, highest to lowest.
-- Your query should return two columns, one for the teams’ names and one for their total hits in 2001.
-- SELECT
-- 	teams.name,
-- 	SUM(H) AS "total hits"
-- FROM performances
-- INNER JOIN teams
-- ON teams.id = performances.team_id
-- WHERE performances.year=2001
-- GROUP BY team_id
-- ORDER BY "total hits" DESC
-- LIMIT 5;
-- CORRECT!


-- In 7.sql, write a SQL query to find the name of the player who’s been paid the highest salary, of all time, in Major League Baseball.
-- your query should return a table with two columns, one for the player’s first name and one for their last name.
-- SELECT first_name, last_name
-- FROM players
-- WHERE id = (
--     SELECT player_id
--     FROM salaries
--     ORDER BY salary DESC
--     LIMIT 1
-- );

-- In 8.sql, write a SQL query to find the 2001 salary of the player who hit the most home runs in 2001.
-- Your query should return a table with one column, the salary of the player.
-- SELECT salary
-- FROM salaries
-- WHERE player_id = (
-- 	SELECT player_id
-- 	FROM performances
-- 	ORDER BY "HR" DESC
-- 	LIMIT 1
-- )
-- AND year = 2001;

-- In 9.sql, write a SQL query to find the 5 lowest paying teams (by average salary) in 2001.
-- Round the average salary column to two decimal places and call it “average salary”.
--  the teams by average salary, least to greatest.
-- Your query should return a table with two columns, one for the teams’ names and one for their average salary.
-- SELECT
--     teams.name AS "Team",
--     ROUND(AVG(salary),2) AS "Average Salary"
-- FROM salaries
-- INNER JOIN teams
-- ON teams.id=salaries.team_id
-- WHERE salaries.year=2001
-- GROUP BY "team_id"
-- ORDER BY "Average Salary"
-- LIMIT 5;

-- In 10.sql, write a query to return just such a table.
-- The general manager has asked you for a report which details each player’s name, their salary for each year they’ve been playing,
-- and their number of home runs for each year they’ve been playing. To be precise, the table should include:
-- All player’s first names
-- All player’s last names
-- All player’s salaries
-- All player’s home runs
-- The year in which the player was paid that salary and hit those home runs
-- Order the results, first and foremost, by player’s IDs (least to greatest).
-- Order rows about the same player by year, in descending order.
-- Consider a corner case: suppose a player has multiple salaries or performances for a given year.
-- Order them first by number of home runs, in descending order, followed by salary, in descending order.
-- Be careful to ensure that, for a single row, the salary’s year and the performance’s year match.
-- Your query should return a table with five columns, per the above.
SELECT
	players.first_name,
	players.last_name,
	salaries.salary,
	performances.HR,
	performances.year
FROM performances
INNER JOIN players
ON players.id = performances.player_id
INNER JOIN salaries
ON salaries.player_id=performances.player_id AND salaries.year=performances.year
ORDER BY players.id, performances.year DESC, performances.HR DESC, salaries.salary DESC;

-- In 11.sql, write a SQL query to find the 10 least expensive players per hit in 2001.
-- You can calculate a player’s salary per hit by dividing their 2001 salary by the number of hits they made in 2001.
-- Call the column “dollars per hit”.
-- As in 10.sql, ensure that the salary’s year and the performance’s year match.
-- Dividing a salary by 0 hits will result in a NULL value. Avoid the issue by filtering out players with 0 hits.
-- Sort the table by the “dollars per hit” column, least to most expensive. If two players have the same “dollars per hit”,
-- order by first name, followed by last name, in alphabetical order.
-- Your query should return a table with three columns, one for the players’ first names, one of their last names, and one called “dollars per hit”.
-- You may assume, for simplicity, that a player will only have one salary and one performance in 2001.
SELECT 
	players.first_name,
	players.last_name,
	salaries.salary / SUM(performances.H) AS "dollars per hit"
FROM performances
INNER JOIN players
ON players.id=performances.player_id
INNER JOIN salaries
ON salaries.player_id=performances.player_id AND salaries.year=performances.year
WHERE performances.year=2001 and performances.H > 0
GROUP BY performances.player_id
ORDER BY "dollars per hit", players.first_name, players.last_name
LIMIT 10;

-- #12 - Hits are great, but so are RBIs! 
-- In 12.sql, write a SQL query to find the players among the 10 least expensive players per hit and among the 10 least expensive players per RBI in 2001.
-- You can calculate a player’s salary per RBI by dividing their 2001 salary by their number of RBIs in 2001.
-- Keep in mind the lessons you’ve learned in 10.sql and 11.sql!
-- Your query should return two columns, one for the players’ first names and one of their last names.
-- Order your results by player ID, least to greatest.
-- You may assume, for simplicity, that a player will only have one salary and one performance in 2001.
SELECT 
	players.first_name,
	players.last_name
FROM performances
INNER JOIN players
ON players.id=performances.player_id
INNER JOIN salaries
ON salaries.player_id=performances.player_id AND salaries.year=performances.year
WHERE performances.year=2001 and performances.RBI > 0
ORDER BY players.id, salaries.salary / performances.RBI 
LIMIT 10;




-- Checking:
-- check50 cs50/problems/2023/sql/moneyball

-- Submitting:
-- submit50 cs50/problems/2023/sql/moneyball