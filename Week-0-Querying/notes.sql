-- Week 0 - Querying

-- Database is a collection of data organized for creating, reading, updating & deleting (CRUD ;)
-- Database Management System (DBMS) software to interact with db, ex: SQLite, PostgreSQL, MySQL, MS SQL Server, Oracle, DB2

-- SQL (Structured Query Language) is the language of the db
-- do CRUD ;

-- in this course, we will use the longlist.db ()

-- the SELECT statement
-- SELECT * FROM longlist;
-- SELECT "title" FROM longlist;
-- SELECT "title", "author" FROM longlist;

-- using the LIMIT
-- SELECT * FROM longlist LIMIT 10;
-- SELECT "title" FROM longlist LIMIT 5;


-- the WHERE statement
-- SELECT "title", "author" FROM longlist WHERE "year"=2023;

/*
Here are some Operators in SQL
= equal
!= not equal, same as
<>
*/

-- using NOT EQUAL logic in WHERE
-- SELECT "title", "format" FROM longlist WHERE "format" != "hardcover";
