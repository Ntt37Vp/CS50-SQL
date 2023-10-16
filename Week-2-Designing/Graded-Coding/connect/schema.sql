CREATE TABLE "Users" (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "username" TEXT NOT NULL UNIQUE,
    "password" TEXT NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE "Schools" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "type" TEXT NOT NULL CHECK("type" IN(
        'Elementary School', 'Middle School', 'High School', 'Lower School', 'Upper School', 'College', 'University', 'etc'
        )),
    "location" TEXT,
    "founded" NUMERIC,
    PRIMARY KEY("id")
);

CREATE TABLE "Companies" (
    "id" INTEGER,
    "name" TEXT,
    "industry" TEXT,
    "location" TEXT,
    PRIMARY KEY("id")
);

CREATE TABLE "Connections_companies" (
    "id" INTEGER,
    "user" INTEGER,
    "company" INTEGER,
    "start_date" NUMERIC,
    "end_date" NUMERIC,
    "title" TEXT,
    PRIMARY KEY("id"),
    FOREIGN KEY("user") REFERENCES "Users"("id"),
    FOREIGN KEY("company") REFERENCES "Companies"("id")
);

CREATE TABLE "Connections_schools" (
    "id" INTEGER,
    "user" INTEGER,
    "school" INTEGER,
    "start_date" NUMERIC,
    "end_date" NUMERIC,
    "degree" TEXT,
    PRIMARY KEY("id"),
    FOREIGN KEY("user") REFERENCES "Users"("id"),
    FOREIGN KEY("school") REFERENCES "Schools"("id")
);

CREATE TABLE "Connections_users" (
    "id" INTEGER,
    "user_A" INTEGER,
    "user_B" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("user_A") REFERENCES "Users"("id"),
    FOREIGN KEY("user_B") REFERENCES "Users"("id")
);