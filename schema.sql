-- In this SQL file, write (and comment!) the schema of your database, including the CREATE TABLE, CREATE INDEX, CREATE VIEW, etc. statements that compose it

--Table representing the list of NOLS RM courses past, present, and upcoming
CREATE TABLE "courses" (
    "id" INT, --id of the course
    "course_code" VARCHAR(25), --unique identifier code for each course
    "course_name" VARCHAR(50), --name of the course
    "ration_periods" TINYINT NOT NULL, --number of ration periods on that course
    "issue_date" DATE, -- when the course is issuing (could be null if no issue?)
    "depart_date" DATE NOT NULL, --when a course is starting
    "return_date" DATE NOT NULL, --when a course is returning
    "course_quantity" SMALLINT NOT NULL, --amount of food (lb)
    PRIMARY KEY("id")
);

--Table listing the ration periods for the above courses
CREATE TABLE "rations" (
    "id" INT, --id of the ration period for the courses above
    "course_id" INT NOT NULL, --id of the course the ration period is on
    "food_id" INT NOT NULL, --food that is in the ration period
    "ration_period" VARCHAR(3) CHECK("ration_period" IN('SR', '1RR', '2RR', '3RR')) NOT NULL, --start, first reration, etc.
    "ration_period_quantity" SMALLINT NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("course_id") REFERENCES "courses"("id"),
    FOREIGN KEY("food_id") REFERENCES "food"("id")
);

--Table cataloguing the foods in the RM
CREATE TABLE "food" (
    "id" SMALLINT,   --id of the food
    "name" VARCHAR(50) NOT NULL,   --name of food
    "type" VARCHAR(50) CHECK("type" IN ('bulk', 'snack')) NOT NULL,    --type of food
    "gf" TINYINT DEFAULT 0 CHECK("p_df" IN (0,1)) NOT NULL, --0 = no gf, 1=gf (same for df)
    "df" TINYINT DEFAULT 0 CHECK("p_df" IN (0,1)) NOT NULL, --dairy free (above is gluten free)
    "weight" VARCHAR(10) CHECK("weight" IN (0.25, 0.5, 0.75, 1.0)) NOT NULL,  --an individual food weight in lb
    "in_rotation" TINYINT DEFAULT 1 CHECK("p_df" IN (0,1)) NOT NULL, --is it in rotation currently or not?
    PRIMARY KEY("id")
);

--VIEW to see all dietary foods in at NOLS RM
CREATE VIEW "dietary_food" AS (
    SELECT * FROM "food"
    WHERE "gf" = 1 OR "df" = 1;
);

--INDEX of food names in rotation
CREATE INDEX "food_index"
ON "food"("name");

--Triggers to represent a food being in rotation
--adding a food to current rotation
CREATE TRIGGER "added"
AFTER INSERT ON "food"
FOR EACH ROW
BEGIN
    INSERT INTO "food" ("name", "in_rotation")
    VALUES (NEW."name", 1);
END;
