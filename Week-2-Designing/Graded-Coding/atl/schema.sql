CREATE TABLE "Passengers" (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "age" NUMERIC NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE "Checkins" (
    "id" INTEGER,
    "passenger_id" TEXT,
    "datetime" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "flight" TEXT NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("passenger_id") REFERENCES "Passengers"("id")
);

CREATE TABLE "Airlines" (
    "id" INTEGER,
    "name" TEXT,
    "concourse" TEXT,
    PRIMARY KEY("id")
);

CREATE TABLE "Flights" (
    "id" INTEGER,
    "flight_number" TEXT,
    "airline" TEXT,
    "airport_origin" TEXT,
    "airport_destination" TEXT,
    "departure" NUMERIC NOT NULL,
    "arrival" NUMERIC NOT NULL,
    FOREIGN KEY("airline") REFERENCES "Airlines"("name")
);