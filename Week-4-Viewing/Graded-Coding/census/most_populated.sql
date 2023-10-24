-- In most_populated.sql, write a SQL statement to create a view named most_populated. 
-- This view should contain, in order from greatest to least, 
-- the most populated districts in Nepal. Ensure the view contains each of the following columns:
CREATE VIEW "most_populated" AS
SELECT
	district,
	SUM(families),
	SUM(households),
	SUM(population),
	SUM(male),
	SUM(female)
FROM census
ORDER BY SUM(population) DESC;