-- How many patients do we have?
SELECT COUNT(*) AS "Patient Count"
FROM "Patients";
-- How many patients do we have?
SELECT COUNT(*) AS "Provider Count"
FROM "Providers";

-- Show all records from Providers table
SELECT * FROM "Providers";

-- Update Specialty 
UPDATE "Providers"
SET "specialty" = "Ear Nose and Throat"
WHERE "specialty" = "ENT";

-- Remove Resident Doctors
DELETE FROM "Providers"
WHERE "specialty" = "Resident";

-- show the updated Providers table
SELECT * FROM "Providers";

-- insert new claim entry
INSERT INTO "Claims" ("patient_id","provider_id","date_service","amount_billed","procedure_codes","diagnosis_codes")
VALUES(5,5,"5/1/2022",500.00,5,5);