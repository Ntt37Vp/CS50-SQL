CREATE VIEW "frequently_reviewed" AS
SELECT 
	"listings"."id",
	"listings"."property_type",
	"listings"."host_name",
	COUNT(reviews.id) AS "reviews"
FROM reviews
JOIN listings
ON listings.id = reviews.listing_id
GROUP BY "listings"."host_name"
ORDER BY "reviews" DESC
LIMIT 100;