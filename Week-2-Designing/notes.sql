-- Week 2 - Designing

-- use .SCHEMA to view details about the db
-- output:
CREATE TABLE IF NOT EXISTS "longlist" (
    "isbn" TEXT,
    "title" TEXT,
    "author" TEXT,
    "translator" TEXT,
    "format" TEXT,
    "pages" INTEGER,
    "publisher" TEXT,
    "published" TEXT,
    "year" INTEGER,
    "votes" INTEGER,
    "rating" REAL
);