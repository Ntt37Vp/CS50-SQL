-- CREATE TABLE "riders" (
--     "id" INTEGER,
--     "name" TEXT
-- );

-- CREATE TABLE "stations" (
--     "id" INTEGER,
--     "name" TEXT,
--     "line" TEXT
-- );

-- CREATE TABLE "visits" (
--     "rider_id" INTEGER,
--     "station_id" INTEGER
-- );

-- to run this schema file, run 
-- sqlite3 mbta.db
-- .read schema.sql

-- Improving the schema file above identifying the PRIMARY KEYS
-- CREATE TABLE "riders" (
--     "id" INTEGER,
--     "name" TEXT,
--     PRIMARY KEY("id")
-- );
-- CREATE TABLE "stations" (
--     "id" INTEGER,
--     "name" TEXT,
--     "line" TEXT,
--     PRIMARY KEY("id")
-- );
-- CREATE TABLE "visits" (
--     "rider_id" INTEGER,
--     "station_id" INTEGER,
--     FOREIGN KEY("rider_key") REFERENCES "riders"("id"),
--     FOREIGN KEY("station_id") REFERENCES "stations"("id")
-- );


-- improving the schema file using the COLUMN CONSTRAINTS
CREATE TABLE "riders" (
    "id" INTEGER,
    "name" TEXT,
    PRIMARY KEY ("id")
);
-- added NOT NULL in station name
CREATE TABLE "stations" (
    "id" INTEGER,
    "name" TEXT NOT NULL UNIQUE,
    "line" TEXT NOT NULL,
    PRIMARY KEY("id")
);
CREATE TABLE "visits" (
    "rider_id" INTEGER,
    "station_id" INTEGER,
    FOREIGN KEY("rider_key") REFERENCES "riders"("id"),
    FOREIGN KEY("station_id") REFERENCES "stations"("id")
);