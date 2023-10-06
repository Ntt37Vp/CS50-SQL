-- In 1.sql, write a SQL query that a translator might take interest in: 
-- list, side by side, the Japanese title and the English title for each print. 
-- Ensure the Japanese title is the first column, followed by the English title.
-- SELECT
-- 	"japanese_title",
-- 	"english_title"
-- FROM views;

-- In 2.sql, write a SQL query to list the average colors of prints by Hokusai 
-- that include “river” in the English title. 
-- (As an aside, do they have any hint of blue?)
-- SELECT "average_color"
-- FROM views
-- WHERE "english_title" LIKE '%river%' AND "artist"="Hokusai";

-- In 3.sql, write a SQL query to COUNT how many prints by Hokusai 
-- include “Fuji” in the English title. 
-- Though all of Hokusai’s prints focused on Mt. Fuji, in 
-- how many did “Fuji” make it into the title?
-- SELECT COUNT("english_title")
-- FROM views
-- WHERE "english_title" LIKE '%fuji%' AND "artist"="Hokusai";

-- In 4.sql, write a SQL query to count how many prints by Hiroshige 
-- have English titles that refer to the “Eastern Capital”. 
-- Hiroshige’s prints were created in Japan’s “Edo period,” 
-- referencing the eastern capital city of Edo, now Tokyo.
-- SELECT COUNT("english_title")
-- FROM views
-- WHERE "english_title" LIKE '%eastern capital%' AND "artist"="Hiroshige";

-- In 5.sql, write a SQL query to find the highest contrast value of prints 
-- by Hokusai. Name the column “Maximum Contrast”. 
-- Does Hokusai’s prints most contrasting print actually have much contrast?
-- SELECT MAX("contrast") AS "Maximum Contrast"
-- FROM views
-- WHERE "artist"="Hokusai";

-- In 6.sql, write a SQL query to find the average entropy of prints 
-- by Hiroshige, rounded to two decimal places. 
-- Call the resulting column “Hiroshige Average Entropy”.
-- SELECT ROUND(AVG("entropy"), 2) AS "Hiroshige Average Entropy"
-- FROM views
-- WHERE "artist" = "Hiroshige";

-- In 7.sql, write a SQL query to list the English titles 
-- of the 5 brightest prints by Hiroshige, 
-- from most to least bright. 
-- SELECT "english_title"
-- FROM views
-- WHERE "artist"="Hiroshige"
-- ORDER BY "brightness" DESC
-- LIMIT 5;

-- In 8.sql, write a SQL query to list the English titles of the 
-- 5 prints with the least contrast by Hokusai, 
-- from least to highest contrast. 
-- SELECT "english_title"
-- FROM views
-- WHERE "artist"="Hokusai"
-- ORDER BY "contrast"
-- LIMIT 5;

-- In 9.sql, write a SQL query to find the English title and artist 
-- of the print with the highest brightness.
SELECT "english_title", "artist"
FROM views
ORDER BY "brightness" DESC
LIMIT 1;


-- In 10.sql, write a SQL query to answer a question of your choice about the prints. The query should:
/*
Make use of AS to rename a column
Involve at least one condition, using WHERE
Sort by at least one column, using ORDER BY
*/
-- SELECT 
-- 	"english_title" AS "Title",
-- 	"brightness" AS "Brightness",
-- 	"contrast" AS "Contrast"
-- FROM views
-- WHERE "artist"="Hokusai"
-- ORDER BY "brightness" DESC;





