-- First, let's create a temp table
-- .import --csv code.csv temp_table
-- DID NOT WORK! let's manually create a table instead of using an upload csv
-- I think because the creator of CS50SQL did not expect users to use upload csv

CREATE TABLE "temp_table" (
    line INTEGER,
    start INTEGER,
    length INTEGER
);

INSERT INTO "temp_table" ("line", "start", "length")
VALUES
(14,98,4),
(114,3,5),
(618,72,9),
(630,7,3),
(932,12,5),
(2230,50,7),
(2346,44,10),
(3041,14,5);

-- TODO:
CREATE VIEW "message" AS
SELECT
    SUBSTR("sentence", "temp_table"."start", "temp_table"."length") AS "phrase"
FROM "temp_table"
JOIN "sentences"
ON "sentences"."id" = "temp_table"."line";


-- Expected behavior:
SELECT "phrase" FROM "message";

-- TODO: drop the temp_table at the end
-- DROP TABLE temp_table;