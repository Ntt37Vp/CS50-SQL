-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database

-- How many patients do we have?
SELECT COUNT(*) FROM "Patients";
-- Show all records from Providers table
SELECT * FROM "Providers";

-- TODO
INSERT INTO "Claims"()
VALUES()

-- Update Specialty 
UPDATE "Providers"
SET "specialty" = "ENT"
WHERE "specialty" = "Ear Nose and Throat";

-- Remove Resident Doctors
DELETE FROM "Providers"
WHERE "specialty" = "Resident";