-- Week 3: Writing

-- INSERTING
-- approach 1: specify both column and values
INSERT INTO table_name (column1, column2, column3, ...)
VALUES (value1, value2, value3, ...); 
-- approach #2: just the table name (critical: the values must be in order)
INSERT INTO table_name
VALUES (value1, value2, value3, ...); 

-- let's create mfa.db to practice!
-- sqlite3 mfa.db
-- insert using the approach #1, complete syntax
INSERT INTO "collections" ("id", "title", "accession_num", "acquired")
VALUES (1, 'Profusion of Flowers', '56.257', '1956-04-12');
-- another example using approach #2, just the table name
INSERT INTO "collections"
VALUES (2, 'Farmers Working at Dawn', '11.6152', '1911-08-03');
-- an example wherein the Primary Key was not placed
INSERT INTO "collections" ("title", "accession_num", "acquired")
VALUES ('Spring Outing', '14.76', '1914-01-08');

-- inserting multiple lines at once
INSERT INTO "collections" ("title", "accession_num", "acquired")
VALUES
('Imaginative Landscape', '56.496', NULL),
('Peonies and butterflies', '06.18', '1906-01-01');



-- IMPORTING
-- csv can be used to import into sql
-- Let's DELETE the initial version of our mfa.db
-- rm mfa.db
-- re-create a blank mfa.db
-- using .IMPORT
.import --csv --skip 1 mfa.csv collections

-- importing csv without the primary key column
-- use the newly created mfa_v2.csv
-- let's use a temporary table, do not skip header
.import --csv mfa_v2.csv temp

-- inserting rows from separate table 
INSERT INTO table0 (column0, ...)
SELECT column0, ... FROM table1;

-- actual code for our example:
INSERT INTO "collections" ("title", "accession_num", "acquired")
SELECT *
FROM temp;
-- OR verbose:
INSERT INTO "collections" ("title", "accession_num", "acquired")
SELECT ("title", "accession_num", "acquired")
FROM temp;
-- once the data is transferred to the official table, drop the temp table
-- DROP TABLE temp;


-- DELETING
-- syntax:
DELETE FROM table_name WHERE condition;
-- on the actual data:
DELETE FROM collections
WHERE "title" = 'SpringOuting';
-- effect/output: 
-- 3  | SpringOuting  was deleted from the table
-- statement below should delete NULL val in acquired:
DELETE FROM collections
WHERE "acquired" IS NULL;
-- deleting based on the acquired date condition
DELETE FROM collections
WHERE "acquired" < '1909-01-01';


-- FOREIGN KEY Constraints
-- rows/values used/referenced in other tables cannot be deleted immediately
DELETE FROM "created" WHERE "artist_id" = (
    SELECT "id" FROM "artists" WHERE "name" = 'Unidentified artist'
);
DELETE FROM "artist" WHERE "name"='Unidentified artist';


-- ON DELETE attribute for the FOREIGN KEY ... REFERENCES
FOREIGN KEY("artist_id") REFERENCES "artists"("id")
ON DELETE ...
-- RESTRICT, NO ACTION, SET NULL, SET DEFAULT, CASCADE
-- ON DELETE CASCADE will remove the row with the deleted Foreign Key association


-- UPDATING
-- syntax:
UPDATE table_name
SET column1 = value1, column2 = value2, ...
WHERE condition; 

-- stopped at 1 H 3 min