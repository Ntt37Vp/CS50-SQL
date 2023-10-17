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
