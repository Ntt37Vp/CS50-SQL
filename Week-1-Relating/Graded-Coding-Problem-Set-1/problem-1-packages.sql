-- #1: THE LOST LETTER - SOLVED
/*
Clerk, my name’s Anneke. I live over at 900 Somerville Avenue. 
Not long ago, I sent out a special letter. 
It’s meant for my friend Varsha. 
She’s starting a new chapter of her life at 2 Finnegan Street, uptown. 
(That address, let me tell you: 
it was a bit tricky to get right the first time.) 
The letter is a congratulatory note—a cheery little paper hug
from me to her, to celebrate this big move of hers. 
Can you check if it’s made its way to her yet?
*/
-- first get the address id 
-- SELECT id
-- FROM addresses
-- WHERE address='900 Somerville Avenue';
-- output: 432
-- then, query the packages table
-- SELECT to_address_id
-- FROM packages
-- WHERE from_address_id = (
-- 	SELECT id
-- 	FROM addresses
-- 	WHERE address='900 Somerville Avenue'
-- ) 
-- AND contents = 'Congratulatory letter'
-- output: 4 rows with packages from address_id 432
-- we are looking for "Congratulatory letter"
-- output is to_address_id of 854
-- we will then query it back to address table
-- SELECT *
-- FROM addresses
-- WHERE id = (
-- 	SELECT to_address_id
-- 	FROM packages
-- 	WHERE from_address_id = (
-- 		SELECT id
-- 		FROM addresses
-- 		WHERE address='900 Somerville Avenue'
-- 	) 
-- 	AND contents = 'Congratulatory letter'
-- );

-- # 2: The Devious Delivery - SOLVED!
-- Your second report of a missing package comes from a mysterious fellow 
-- from out of town. They walk up to your counter and tell you the following:
/*
Good day to you, deliverer of the mail. 
You might remember that not too long ago I made my way over from the 
town of Fiftyville. I gave a certain box into your reliable hands and asked you
 to keep things low. My associate has been expecting the package for a while now. 
 And yet, it appears to have grown wings and flown away. Ha! 
 Any chance you could help clarify this mystery? 
 Afraid there’s no “From” address. It’s the kind of parcel that would add a bit more…
 quack to someone’s bath times, if you catch my drift.
*/
-- At what type of address did the Devious Delivery end up?:
-- First, get the NULL
-- SELECT "id"
-- FROM packages
-- WHERE from_address_id IS NULL
-- then query the scans
-- SELECT "address_id"
-- FROM scans
-- WHERE package_id = (
-- 	SELECT "id"
-- 	FROM packages
-- 	WHERE from_address_id IS NULL
-- ) AND action = "Drop";
-- then query the address
-- SELECT "type"
-- FROM addresses
-- WHERE id = (
-- 	SELECT "address_id"
-- 	FROM scans
-- 	WHERE package_id = (
-- 		SELECT "id"
-- 		FROM packages
-- 		WHERE from_address_id IS NULL
-- 	) AND action = "Drop"
-- );

-- What were the contents of the Devious Delivery?
-- SELECT "contents"
-- FROM packages
-- WHERE from_address_id IS NULL;


-- #3 The Forgotten Gift - 
-- Your third report of a missing package comes
-- from a grandparent who lives down the street from the post office.
-- They approach your counter and tell you the following:

/*
Oh, excuse me, Clerk. I had sent a mystery gift, you see, 
to my wonderful granddaughter, off at 728 Maple Place. 
That was about two weeks ago. 
Now the delivery date has passed by seven whole days and 
I hear she still waits, her hands empty and heart filled with anticipation. 
I’m a bit worried wondering where my package has gone. 
I cannot for the life of me remember what’s inside, 
but I do know it’s filled to the brim with my love for her. 
Can we possibly track it down so it can fill her day with joy? 
I did send it from my home at 109 Tileston Street.
*/
-- What are the contents of the Forgotten Gift?
-- Who has the Forgotten Gift?
-- get the address id of sender
-- SELECT id
-- FROM addresses
-- WHERE address='109 Tileston Street';
-- output: 9873

-- get the address id of receiver:
-- SELECT id
-- FROM addresses
-- WHERE address='728 Maple Place';
-- output: 4983

-- query the packages
-- SELECT *
-- FROM packages
-- WHERE from_address_id = (
-- 	SELECT id
-- 	FROM addresses
-- 	WHERE address='109 Tileston Street'
-- );

-- Who has the Forgotten Gift?:
-- SELECT "id"
-- FROM packages
-- WHERE from_address_id = (
-- 	SELECT id
-- 	FROM addresses
-- 	WHERE address='109 Tileston Street'
-- );
--output: 9523
SELECT "timestamp", "name"
FROM scans
INNER JOIN drivers
ON scans.driver_id=drivers.id
WHERE package_id = (
	SELECT "id"
	FROM packages
	WHERE from_address_id = (
		SELECT id
		FROM addresses
		WHERE address='109 Tileston Street'
	)
);