-- The Providers table hold the medical providers information such as their full name, NPI and specialty
-- NPI is the 10-digit identification number issued to health care providers in the United States by 
-- the Centers for Medicare and Medicaid Services (CMS)
CREATE TABLE "Providers" (
        "id" INTEGER,
        "first_name" TEXT NOT NULL,
        "last_name" TEXT NOT NULL,
        "npi" INTEGER UNIQUE,
        "specialty" TEXT,
        PRIMARY KEY("id")
);

-- The Patients table lists the basic patient information such as name and dob. 
-- It could also be expanded to add more attributes.
CREATE TABLE "Patients" (
        "id" INTEGER,
        "first_name" TEXT NOT NULL,
        "last_name" TEXT NOT NULL,
        "date_birth" NUMERIC,
        PRIMARY KEY("id")
);

-- 
CREATE TABLE "Claims" (
        "id" INTEGER,
        "patient_id" INTEGER NOT NULL,
        "provider_id" INTEGER NOT NULL,
        "date_service" NUMERIC NOT NULL,
        "amount_billed" NUMERIC NOT NULL,
        "procedure_codes" TEXT NOT NULL,
        "diagnosis_codes" TEXT NOT NULL,
        PRIMARY KEY("id"),
        FOREIGN KEY("patient_id") REFERENCES "Patients"("id"),
        FOREIGN KEY("provider_id") REFERENCES "Providers"("id")
);

-- The Procedures table lists the medical, surgical, and diagnostic services performed by the Medical Providers
-- It is designed to communicate uniform information about medical services and procedures among physicians, 
-- coders, patients, accreditation organizations, and payers for administrative, financial, and analytical purposes.
CREATE TABLE "Procedures" (
        "id" INTEGER,
        "cpt_code" TEXT NOT NULL,
        "description" TEXT NOT NULL,
        PRIMARY KEY("id")
);

-- The Diagnosis table holds the representation of a "diseases, signs and symptoms, abnormal findings, complaints, 
-- social circumstances, and external causes of injury or diseases"
-- ICD-10 is the 10th revision of the International Statistical Classification of Diseases and Related Health Problems (ICD), 
-- a medical classification list by the World Health Organization (WHO).
CREATE TABLE "Diagnosis" (
        "id" INTEGER,
        "icd10_code" TEXT NOT NULL,
        "description" TEXT NOT NULL,
        PRIMARY KEY("id")
);

-- TODO
CREATE INDEX

-- TODO
CREATE VIEW