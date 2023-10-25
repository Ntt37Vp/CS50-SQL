CREATE VIEW "june_vacancies" AS
SELECT
	"availabilities"."listing_id",
	"listings"."property_type",
	"listings"."host_name",
	COUNT("availabilities"."id") AS "days_vacant"
FROM availabilities
JOIN listings
ON listings.id = availabilities.listing_id
WHERE availabilities.available = 'TRUE' AND availabilities.date LIKE '2023-06%'
GROUP BY "listings"."host_name";