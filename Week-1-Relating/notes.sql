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

-- stopped @ 45mins