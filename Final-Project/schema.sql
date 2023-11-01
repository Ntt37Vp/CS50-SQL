CREATE TABLE IF NOT EXISTS "Providers" (
        "id"    INTEGER,
        "first_name"    TEXT NOT NULL,
        "last_name"     TEXT NOT NULL,
        "npi"   INTEGER UNIQUE,
        "taxonomy_default"      TEXT,
        PRIMARY KEY("id" AUTOINCREMENT)
);

CREATE TABLE IF NOT EXISTS "Claims" (
        "id"    INTEGER,
        "date_service"  NUMERIC NOT NULL,
        "date_billed"   NUMERIC,
        PRIMARY KEY("id")
);

CREATE TABLE IF NOT EXISTS "Patients" (
        "id"    INTEGER,
        "first_name"    TEXT NOT NULL,
        "last_name"     TEXT NOT NULL,
        "date_birth"    NUMERIC,
        PRIMARY KEY("id")
);

CREATE TABLE IF NOT EXISTS "Procedures" (
        "id"    INTEGER,
        "description"   TEXT,
        "cpt"   TEXT,
        PRIMARY KEY("id")
);

CREATE TABLE IF NOT EXISTS "Diagnosis" (
        "id"    INTEGER,
        "description"   INTEGER,
        "icd10" INTEGER,
        PRIMARY KEY("id")
);