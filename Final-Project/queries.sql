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

-- TODO
-- INSERT INTO "Claims"()
-- VALUES()