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

-- either Translators or Authors
SELECT "name" FROM translators;
SELECT "name" FROM authors;
-- combine the two sets using UNION:
SELECT "name" FROM translators
UNION
SELECT "name" FROM authors;

-- creating a list from authors
SELECT 
"author" AS "profession",
"name"
FROM authors;
-- combining or UNION
SELECT 
"author" AS "profession",
"name"
FROM authors
UNION
SELECT "translator" AS "profession",
"name"
FROM translators;

-- using INTERSECT
SELECT "name" FROM authors
INTERSECT
SELECT "name" FROM translators;
-- output: Ngũgĩ wa Thiong'o

-- using EXCEPT
SELECT "name" FROM authors
EXCEPT
SELECT "name" FROM translators;

-- 
SELECT "book_id" FROM translated
WHERE "translator_id" = (
    SELECT "id" FROM translators
    WHERE "name" = 'Sophie Hughes'
)
INTERSECT
SELECT "book_id" FROM translated
WHERE "translator_id" = (
    SELECT "id" translators
    WHERE "name" = 'Margaret Jull Costa'
);
-- output should be book_id: 50


SELECT AVG("rating") FROM ratings;
-- output: 3.83644
-- only spits out the avg for all books
-- to get the book rating avg
SELECT 
    book_id,
    AVG("rating") AS "Average rating"
FROM ratings
GROUP BY book_id;
-- only showing the top 10
SELECT 
    book_id,
    ROUND(AVG("rating"), 2) AS "Average rating"
FROM ratings
GROUP BY book_id
ORDER BY "Average rating" DESC
LIMIT 10;
-- now I feel like adding the name of the books into this query...
SELECT 
    ratings.book_id,
    books.title,
    ROUND(AVG("rating"), 2) AS "Average rating"
FROM ratings
INNER JOIN books 
ON ratings.book_id=books.id
GROUP BY book_id
ORDER BY "Average rating" DESC
LIMIT 10;
-- OUTPUT IS AWESOME
-- +---------+---------------------------------------+----------------+
-- | book_id |                 title                 | Average rating |
-- +---------+---------------------------------------+----------------+
-- | 42      | The Eighth Life                       | 4.51           |
-- | 22      | A New Name: Septology VI-VII          | 4.5            |
-- | 45      | The Other Name: Septology I-II        | 4.19           |
-- | 65      | The Years                             | 4.18           |
-- | 28      | When We Cease to Understand the World | 4.14           |
-- | 11      | Still Born                            | 4.14           |
-- | 71      | The Flying Mountain                   | 4.11           |
-- | 18      | Elena Knows                           | 4.09           |
-- | 48      | Hurricane Season                      | 4.08           |
-- | 5       | Time Shelter                          | 4.06           |
-- +---------+---------------------------------------+----------------+

-- using HAVING to filter ROWS
SELECT
    "book_id",
    ROUND(AVG("rating"), 2) AS "Average Rating"
FROM ratings
GROUP BY "book_id"
HAVING "Average Rating" > 4.0;
-- let's say I wanted to add the # of reviews/ratings
SELECT
    "book_id",
    COUNT("rating") AS "Review Count",
    ROUND(AVG("rating"), 2) AS "Average Rating"
FROM ratings
GROUP BY "book_id"
HAVING "Average Rating" > 4.0
ORDER BY "Review Count" DESC;
-- let's add the title of the book_ids haha
SELECT
    ratings.book_id,
    books.title,
    COUNT("rating") AS "Review Count",
    ROUND(AVG("rating"), 2) AS "Average Rating"
FROM ratings
INNER JOIN books
ON ratings.book_id=books.id
GROUP BY "book_id"
HAVING "Average Rating" > 4.0
ORDER BY "Review Count" DESC;
-- the AWESOME OUTPUT:
-- +---------+---------------------------------------+--------------+----------------+
-- | book_id |                 title                 | Review Count | Average Rating |
-- +---------+---------------------------------------+--------------+----------------+
-- | 28      | When We Cease to Understand the World | 23251        | 4.14           |
-- | 48      | Hurricane Season                      | 22551        | 4.08           |
-- | 65      | The Years                             | 16888        | 4.18           |
-- | 42      | The Eighth Life                       | 16350        | 4.51           |
-- | 18      | Elena Knows                           | 8212         | 4.09           |
-- | 11      | Still Born                            | 7647         | 4.14           |
-- | 25      | The Books of Jacob                    | 5664         | 4.05           |
-- | 20      | More Than I Love My Life              | 3705         | 4.04           |
-- | 5       | Time Shelter                          | 3142         | 4.06           |
-- | 10      | Pyre                                  | 1302         | 4.04           |
-- | 45      | The Other Name: Septology I-II        | 1245         | 4.19           |
-- | 22      | A New Name: Septology VI-VII          | 479          | 4.5            |
-- | 71      | The Flying Mountain                   | 323          | 4.11           |
-- +---------+---------------------------------------+--------------+----------------+

