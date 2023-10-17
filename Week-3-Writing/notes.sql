-- Week 3: Writing

-- Inserting
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
