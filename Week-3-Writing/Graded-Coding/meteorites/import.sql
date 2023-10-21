-- create temp table
CREATE TABLE "meteorites_temp" (
    "name" TEXT,
    "id" INTEGER,
    "nametype" TEXT,
    "class" TEXT,
    "mass" NUMERIC,
    "discovery" TEXT,
    "year" NUMERIC,
    "lat" NUMERIC,
    "long" NUMERIC
);

-- import csv into temp
.import --csv --skip 1 meteorites.csv meteorites_temp

-- cleannup blanks to NULL
UPDATE "meteorites_temp"
SET "mass"= NULL
WHERE "mass" IS NULL;
UPDATE "meteorites_temp"
SET "year"= NULL
WHERE "year" IS NULL;
UPDATE "meteorites_temp"
SET "lat"= NULL
WHERE "lat" IS NULL;
UPDATE "meteorites_temp"
SET "long"= NULL
WHERE "long" IS NULL;

-- cleanup to 2 digits
UPDATE "meteorites_temp"
SET "mass" = (
    ROUND("mass", 2)
)
WHERE "mass" LIKE '%.%';
UPDATE "meteorites_temp"
SET "lat" = (
    ROUND("lat", 2)
)
WHERE "lat" LIKE '%.%';
UPDATE "meteorites_temp"
SET "long" = (
    ROUND("long", 2)
)
WHERE "long" LIKE '%.%';

-- All meteorites with the nametype “Relict” are not included in the meteorites table.
DELETE FROM "meteorites_temp"
WHERE "nametype" = 'Relict';

-- create the official table
CREATE TABLE "meteorites" (
    "id" INTEGER,
    "name" TEXT,
    "class" TEXT,
    "mass" NUMERIC,
    "discovery" TEXT,
    "year" NUMERIC,
    "lat" NUMERIC,
    "long" NUMERIC,
    PRIMARY KEY("id")
);

-- copying important columns from temp to official table w/ auto increment id
INSERT INTO "meteorites" ("name", "class", "mass", "discovery", "year", "lat", "long")
SELECT "name", "class", "mass", "discovery", "year", "lat", "long"
FROM "meteorites_temp"
ORDER BY "year";

-- drop temp table
DROP TABLE "meteorites_temp";