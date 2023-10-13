-- In 1.sql, write a SQL query to find the names and cities of all public schools in Massachusetts.
-- SELECT
-- 	name,
-- 	city
-- FROM schools
-- WHERE type='Public School';


-- In 2.sql, write a SQL query to find the names of districts that are no longer operational.
-- SELECT name
-- FROM districts
-- WHERE name LIKE '%non-op%';


-- In 3.sql, write a SQL query to find the average per-pupil expenditure. 
-- Name the column “Average District Per-Pupil Expenditure”.
-- SELECT 
-- 	AVG(per_pupil_expenditure) AS 'Average District Per-Pupil Expenditure'
-- FROM expenditures;


-- In 4.sql, write a SQL query to find the 10 cities with the most public schools. 
-- Your query should return the names of the cities and the number of public schools
-- within them, ordered from greatest number of public schools to least. 
-- If two cities have the same number of public schools, order them alphabetically
-- SELECT
-- 	"city",
-- 	COUNT(id)
-- FROM schools
-- WHERE type='Public School'
-- GROUP BY "city"
-- ORDER BY 
-- 	COUNT(id) DESC,
-- 	"city"
-- LIMIT 10;


-- In 5.sql, write a SQL query to find cities with 3 or fewer public schools. 
-- Your query should return the names of the cities and the number of public schools
-- within them, ordered from greatest number of public schools to least. 
-- If two cities have the same number of public schools, order them alphabetically.
-- SELECT
-- 	"city",
-- 	COUNT(id) AS '# of Public Schools'
-- FROM schools
-- WHERE type='Public School'
-- GROUP BY "city"
-- HAVING COUNT(id) <= 3
-- ORDER BY COUNT(id) DESC, 'city';


-- In 6.sql, write a SQL query to find the names of schools (public or charter!)
-- that reported a 100% graduation rate.
-- SELECT 
-- 	schools.name
-- FROM graduation_rates
-- INNER JOIN schools
-- ON schools.id=graduation_rates.school_id
-- WHERE graduated=100;


-- In 7.sql, write a SQL query to find the names of schools (public or charter!) 
-- in the Cambridge school district.
-- SELECT "name"
-- FROM schools
-- WHERE district_id = (
-- 	SELECT id
-- 	FROM districts
-- 	WHERE name LIKE 'Cambridge%'
-- );


-- In 8.sql, write a SQL query to display the names of all school districts 
-- and the number of pupils enrolled in each.
-- SELECT 
-- 	districts.name,
-- 	expenditures.pupils
-- FROM expenditures
-- INNER JOIN districts
-- ON districts.id = expenditures.district_id;


-- In 9.sql, write a SQL query to find the name (or names) of the school district(s)
-- with the single least number of pupils. Report only the name(s).
-- SELECT name
-- FROM districts
-- WHERE id = (
--     SELECT
--         district_id
--     FROM expenditures
--     ORDER BY pupils
--     LIMIT 1
-- );


-- In 10.sql, write a SQL query to find the 10 public school districts 
-- with the highest per-pupil expenditures. Your query should return the 
-- names of the districts and the per-pupil expenditure for each.
-- SELECT
-- 	districts.name,
-- 	expenditures.per_pupil_expenditure
-- FROM expenditures
-- INNER JOIN districts 
-- ON districts.id = expenditures.district_id
-- WHERE type='Public School District'
-- ORDER BY per_pupil_expenditure DESC
-- LIMIT 10;


-- In 11.sql, write a SQL query to display the names of schools, their per-pupil expenditure, 
-- and their graduation rate. Sort the schools from greatest per-pupil expenditure 
-- to least. If two schools have the same per-pupil expenditure, sort by school name.
-- You should assume a school spends the same amount per-pupil their district as a whole spends.
-- SELECT 
-- 	schools.name AS "School name",
-- 	expenditures.per_pupil_expenditure AS "Expenditure",
-- 	graduation_rates.graduated
-- FROM schools
-- INNER JOIN expenditures
-- ON expenditures.district_id = schools.district_id
-- INNER JOIN graduation_rates
-- ON graduation_rates.school_id = schools.id
-- ORDER BY "Expenditure" DESC, "School name";


-- In 12.sql, write a SQL query to find public school districts 
-- with above-average per-pupil expenditures and an 
-- above-average percentage of teachers rated “exemplary”. 
-- Your query should return the districts’ names, along with their per-pupil expenditures and percentage of teachers rated exemplary. 
-- Sort the results first by the percentage of teachers rated exemplary (high to low), then by the per-pupil expenditure (high to low).
-- You might find it helpful to know that subqueries can be inserted into most any part of a SQL query, including conditions. 
-- For instance, the following is valid SQL syntax:
-- SELECT "column" FROM "table"
-- WHERE "column" > (
--     SELECT AVG("column")
--     FROM "table"
-- );
SELECT 
	districts.name,
	expenditures.per_pupil_expenditure AS "Per Pupil Exp",
	staff_evaluations.exemplary AS "Teacher rating"
FROM districts
INNER JOIN expenditures
ON expenditures.district_id = districts.id
INNER JOIN staff_evaluations
ON staff_evaluations.district_id = districts.id
WHERE type = 'Public School District'
AND "Per Pupil Exp" > (
	SELECT AVG(expenditures.per_pupil_expenditure)
	FROM expenditures
)
AND "Teacher rating" > (
	SELECT AVG(staff_evaluations.exemplary)
	FROM staff_evaluations
)
ORDER BY "Teacher rating" DESC, "Per Pupil Exp" DESC;


-- In 13.sql, write a SQL query to answer a question you have about the data! The query should:
-- Involve at least one JOIN or subquery
-- SELECT
-- 	districts.city AS "City",
-- 	expenditures.pupils AS "# of Pupils",
-- 	expenditures.per_pupil_expenditure
-- FROM expenditures
-- INNER JOIN districts
-- ON districts.id = expenditures.district_id
-- ORDER BY expenditures.pupils DESC
-- LIMIT 5;


-- Tests:
-- Executing 1.sql results in a table with 2 columns and 1,761 rows.
-- Executing 2.sql results in a table with 1 column and 121 rows.
-- Executing 3.sql results in a table with 1 column and 1 row.
-- Executing 4.sql results in a table with 2 columns and 10 rows.
-- Executing 5.sql results in a table with 2 columns and 201 rows.
-- Executing 6.sql results in a table with 1 column and 9 rows.
-- Executing 7.sql results in a table with 1 column and 17 rows.
-- Executing 8.sql results in a table with 2 columns and 396 rows.
-- Executing 9.sql results in a table with 1 column and 1 row.
-- Executing 10.sql results in a table with 2 columns and 10 rows.
-- Executing 11.sql results in a table with 3 columns and 391 rows.
-- Executing 12.sql results in a table with 3 columns and 65 rows.

-- Checking:
-- check50 cs50/problems/2023/sql/dese

-- Submitting:
-- submit50 cs50/problems/2023/sql/dese
