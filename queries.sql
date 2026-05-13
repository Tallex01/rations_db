-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database

--Ex: want to know all food that is gluten free at NOLS RM
SELECT * FROM "food"
WHERE "gf" = 1;

--Ex: want to know all food items on a course with code WRW4-7/21
-- and what ration period they belong to
SELECT "course_id", "food_id",
"ration_period", "ration_period_quantity", "weight" FROM "rations"
JOIN "food" ON "food"."id" = "rations"."food_id"
WHERE "course_id" = (
    SELECT "id" FROM "courses"
    WHERE "course_code" = 'WRW4-7/21'
);

--Ex: inserting a new course into courses table
INSERT INTO "courses" ("id", "course_code", "course_name", "ration_periods",
    "issue_date", "depart_date", "return_date", "course_quantity")
VALUES
('42', 'ADW-7/16', '30 Day Wind River Hiking and Backpacking', 4,
'2025-07-16', '2025-07-16', '2025-08-16', '1000.0');

--Ex: updating a food item in the RM be gluten free
UPDATE "food"
SET "gf" = 1
WHERE "name" = 'GF Pasta (spirals)';

--Ex: deleting a course (type) that got cancelled (CYLE in this case)
DELETE FROM "courses"
WHERE "course_name" LIKE "CYLE%";

--Ex: taking a food out of current rotation
UPDATE "food"
SET "in_rotation" = 0
WHERE "name" = 'Raisin Bran';
