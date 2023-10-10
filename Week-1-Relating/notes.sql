-- Week 1 - Relating

-- the new version of the longlist.db (version week 1) has more tables:
-- authored, authors, books, publishers, ratings, translated, translators

-- Relationships:
-- one to one, one to many, many to one, many to many
-- ER Diagram or "Entity Relationship Diagrams"
-- uses cross foot notation



-- KEYS!
-- primary key and foreign key  :)
-- like book's ISBN

-- Subqueries or nested query
-- Without using queries, we might write 2 separate queries like
SELECT "id" FROM "publishers"
WHERE "publisher"='Fitzcarraldo Editions';
-- output is 5
-- and then:
SELECT "title" FROM books
WHERE "publisher_id" = 5

-- using subqueries instead:
SELECT "title" FROM books
WHERE "publisher_id" = (
    SELECT "id" FROM "publishers"
    WHERE "publisher"='Fitzcarraldo Editions'
);

-- another example 
SELECT "id" FROM books WHERE "title"="In Memory of Memory";
-- output:33
SELECT rating FROM ratings WHERE "book_id" = 33;
-- using subquery:
SELECT rating FROM ratings WHERE "book_id" = (
    SELECT "id" 
    FROM books 
    WHERE "title"="In Memory of Memory"
);
-- improving the code above using AVG of ratings only:
SELECT AVG(rating) FROM ratings WHERE "book_id" = (
    SELECT "id" 
    FROM books 
    WHERE "title"="In Memory of Memory"
);
-- output: 3.86036036036036



-- Many to many example:
-- first, get the id of 'Flights':
SELECT "id" FROM books
WHERE "title" = 'Flights';
-- output: 78
-- nest it into the "authored" query to get the "author id"
SELECT "author_id" FROM "authored"
WHERE "book_id" = (
    SELECT "id" FROM books
WHERE "title" = 'Flights'
);
-- then nest this new query into authors 
SELECT "name" FROM authors
WHERE "id" = (
    SELECT "author_id" FROM "authored"
    WHERE "book_id" = (
        SELECT "id" FROM books
        WHERE "title" = 'Flights'
    )
);
-- final output that we are looking for: Olga Tokarczuk

-- continue @ 45mins

-- the IN keyword
-- to find a value INSIDE a set
-- example:
-- get author's id
SELECT "id" FROM authors
WHERE "name" = 'Fernanda Melchor';
-- then nest into the authored
SELECT "book_id" FROM authored
WHERE "author_id" = (
    SELECT "id" FROM authors
    WHERE "name" = 'Fernanda Melchor'
);
-- the output is 14 & 48, nest it inside the new query using IN
SELECT "title" FROM books
WHERE "id" IN (
    SELECT "book_id" FROM authored
    WHERE "author_id" = (
        SELECT "id" FROM authors
        WHERE "name" = 'Fernanda Melchor'
    )
);


-- JOINS!
SELECT books.title, publishers.publisher
FROM books
JOIN publishers 
ON publishers.id=books.publisher_id;


-- continue @ 1H 1M

-- the NATURAL JOIN
SELECT *
FROM books
NATURAL JOIN publishers;

-- SETS
-- values that appear in both tables
-- example: 
-- authors INTERSECT translators

-- if either of the two SETS, it's a UNION
-- W3: The UNION operator is used to combine the result-set of two or more SELECT statements.

-- continue @ 1H 20M