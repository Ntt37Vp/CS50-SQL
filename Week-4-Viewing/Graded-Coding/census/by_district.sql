-- In by_district.sql, write a SQL statement to create a view named by_district.
-- This view should contain the sums for each numeric column in census, grouped by district.
-- Ensure the view contains each of the following columns:
CREATE VIEW "by_district" AS
SELECT
    district,
	SUM(families),
	SUM(households),
	SUM(population),
	SUM(male),
	SUM(female)
FROM census
GROUP BY district;