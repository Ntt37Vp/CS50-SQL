CREATE TABLE IF NOT EXISTS "Providers" (
        "id"    INTEGER,
        "first_name"    TEXT NOT NULL,
        "last_name"     TEXT NOT NULL,
        "npi"   INTEGER UNIQUE,
        "specialty"      TEXT,
        PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "Patients" (
        "id"    INTEGER,
        "first_name"    TEXT NOT NULL,
        "last_name"     TEXT NOT NULL,
        "date_birth"    NUMERIC,
        PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "Claims" (
        "id"    INTEGER,
        "patient_id" INTEGER NOT NULL,
        "provider_id" INTEGER NOT NULL,
        "date_service"  NUMERIC NOT NULL,
        "amount_billed" NUMERIC NOT NULL,
        "procedure_codes" TEXT NOT NULL,
        "diagnosis_codes" TEXT NOT NULL,
        PRIMARY KEY("id"),
        FOREIGN KEY("patient_id") REFERENCES "Patients"("id"),
        FOREIGN KEY("provider_id") REFERENCES "Providers"("id")
);
CREATE TABLE IF NOT EXISTS "Procedures" (
        "id"    INTEGER,
        "description"   TEXT NOT NULL,
        "cpt_code"   TEXT NOT NULL,
        PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "Diagnosis" (
        "id"    INTEGER,
        "description"   TEXT NOT NULL,
        "icd10_code" TEXT NOT NULL,
        PRIMARY KEY("id")
);