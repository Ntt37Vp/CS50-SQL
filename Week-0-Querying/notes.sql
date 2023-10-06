-- Week 0 - Querying

-- Database is a collection of data organized for creating, reading, updating & deleting (CRUD ;)
-- Database Management System (DBMS) software to interact with db, ex: SQLite, PostgreSQL, MySQL, MS SQL Server, Oracle, DB2

-- SQL (Structured Query Language) is the language of the db
-- do CRUD ;

-- in this course, we will use the longlist.db ()

-- the SELECT statement
SELECT * FROM longlist;
SELECT "title" FROM longlist;
SELECT "title", "author" FROM longlist;

-- using the LIMIT
SELECT * FROM longlist LIMIT 10;
SELECT "title" FROM longlist LIMIT 5;


-- the WHERE statement
-- SELECT "title", "author" FROM longlist WHERE "year"=2023;

/*
Here are some Operators in SQL
= equal
!= not equal, same as
<>
*/

-- using NOT EQUAL logic in WHERE
SELECT "title", "format" FROM longlist WHERE "format" != "hardcover";


-- the NULL
-- meaning no value, it does not exist
-- IS NULL
-- IS NOT NULL
-- sample codes:
SELECT "title" , "translator" FROM "longlist"
WHERE "translator" IS NULL;
SELECT "title" , "translator" FROM "longlist"
WHERE "translator" IS NOT NULL;

-- the LIKE to match
-- commonly used with wildcards % and _
SELECT "title" FROM "longlist"
WHERE "title" LIKE '%love%';


-- continue @ 40 mins

-- using single char _
SELECT "title" FROM longlist
WHERE "title" LIKE 'P_re';

-- Range Condition using > < >= <= operators
SELECT "title", "year" FROM longlist
WHERE "year" > 2020;

-- using BETWEEN ... AND ...
SELECT "title", "year" FROM longlist
WHERE "year" BETWEEN 2019 and 2020;

-- another example 
SELECT "title", "rating" FROM longlist
WHERE "rating" > 4.0
ORDER BY "rating" DESC;

-- refining the code above...
SELECT "title", "rating", "votes" FROM longlist
WHERE "rating" > 4.0 AND "votes" > 5000
ORDER BY "votes" DESC;


-- ORDER BY keyword
-- the most famous/best-selling books on our list
SELECT "title", "rating", "votes" FROM longlist
ORDER BY "votes" DESC
LIMIT 10;
-- now the highest-rated books:
SELECT "title", "rating", "votes" FROM longlist
ORDER BY "votes", "rating" DESC
LIMIT 10;


-- continue @ 57 mins