# Design Document

By Alex Goodman

Video overview: <[URL HERE](https://youtu.be/WdYKXKSKK3s)>

## Scope

In this section you should answer the following questions:

* What is the purpose of your database?
-The purpose of this database is to catalogue all of the food, courses, and rations located at NOLS Rocky Mountain (RM) base.

* Which people, places, things, etc. are you including in the scope of your database?
-I am including all courses, past, present, and future that have departed with NOLS RM. This will include names of the courses, course codes, when a course is leaving and getting back, etc. I am also including how many ration periods a course will have, as well as the list of foods both past and present at NOLS RM.

* Which people, places, things, etc. are *outside* the scope of your database?
-Things that I would like to represent in this database, but am unable to at the moment include dietary categorization (is it a replacement food, supplemental food, etc.), spice foods, fruit and vegetable foods, cold foods, whether a student has a certain dietary restriction beyond those that we listed (e.g. is vegan, vegetarian, celiac, pescetarian, etc.), whether or not this dietary restriction is able to be accommodated for, a table for students and instructors, and a table for cook groups in each course. Ideally for the cook groups, I would be able to represent each student on the course, whether they have dietary accommodations, how much food the cook group gets, etc. whether this be split up into multiple extra tables, or whatnot.

## Functional Requirements

In this section you should answer the following questions:

* What should a user be able to do with your database?
-A user should be able to access information about past and present courses at NOLS RM, view the cook groups for each course, and view the types of food offered at NOLS RM. There is also the ability to update if a course is cancelled or not, and to reflect if a food item at NOLS RM is taken out of the current rotation of ration foods, or if a new food item is added into the current rotation. A user should also be able to see if a food contains a certain allergen or dietary restriction that may harm them or a student on a course, thus allowing for the people in charge of building rations to be able to make sure they do not receive certain foods, and instead receive ones without certain allergens in them.

* What's beyond the scope of what a user should be able to do with your database?
-A user shouldn't be able to access information about the individual students or instructors on this course, a feature that I would like to implement in a future version of this project. Another thing that is outside the scope but what I hope for users to do someday is to be able to see what food is in certain cookgroups and modify the food per cookgroup and/or student if "adds" (as per student/instructor request) are made.

## Representation

### Entities

In this section you should answer the following questions:

* Which entities will you choose to represent in your database?
-I am choosing to represent the entities: courses, rations, and foods.

* What attributes will those entities have?
-Courses will have their name, course code, the number of ration periods, the date of issue, the date of departure, the date of return, and the quantity of food (in pounds) given to that course. Rations will have the ration period identifier (start ration, first reration, etc.), the id of the course the ration period is on, the id of the food on the course, and the amount of food (in pounds) designated for that ration period. Foods will have the name of the food, the type (bulk food or snack food), whether the food is gluten-free, dairy-free, the weight measurement for that particular food (also in pounds), and whether or not that food is in the current rotation.

* Why did you choose the types you did?
-I chose the types I did because I think integers for the id's could be longer since we get a lot of courses here at NOLS, so we want to be able to store a lot of courses/entries in our tables. For the "indicator" variables, I chose TINYINTs because they are only represented by 1 number (0 or 1). Some variables (like quantity of food on a course) were assigned SMALLINTs because there seems to be an upper limit of around 1000 lbs of food on each course, so we should make sure not to have too large of an integer value represented. The text variables were represented with VARCHAR's with approximately estimated length, since using a TEXT variable by itself would take lots of storage.

* Why did you choose the constraints you did?
-I constrained the indicator variables to be 0 or 1 because those are the only possible options. I limited the type of foods represented in the foods table to just be bulk or snack foods, for simplicity's sake in the time of making this. Hopefully one day this will be updated to reflect all food types at NOLS RM. There were also constraints placed on food weights and ration periods because there are only a select few of either that are used, so it would fall under one of the options listed in each variable's respective constraints.

### Relationships

In this section you should include your entity relationship diagram and describe the relationships between the entities in your database.

![Entity Relationship Diagram](pic1.png)

-The relationships illustrated in the diagram are fairly straightforward. Courses at NOLS RM contain rations (ration periods - e.g. a stretch of time on each course that contains a given amount of food estimated to last that length of time for the students/instructors). Within each ration/ration period, there are food items that are given to each ration period.

## Optimizations

In this section you should answer the following questions:

* Which optimizations (e.g., indexes, views) did you create? Why?
-The optimizations I created included a view to see the dietary food listed at NOLS RM. This was created to have a convenient way of accessing dietary foods so that building rations were more straightforward instead of typing more commands, and since we have so many dietary accommodations usually, it helps us see what foods we can use as replacements or supplements. I also included a quick access index to see the list of all foods as a way to simply view a catalogue of all food at NOLS RM. I also created a trigger to update the "in_rotation" variable to reflect if a new food item has been added + in rotation.

## Limitations

In this section you should answer the following questions:

* What are the limitations of your design?
-The limitations of my design include not being able to encapsulate information about students and instructors, two of the primary components of the NOLS courses. Instead, I simply display information about the courses themselves, and the types of food on courses.

* What might your database not be able to represent very well?
-In my database, I am not able to represent students and instructors, as well as their respective food and dietary needs. Additionally, I am not able to represent the type of food on each course really well, as it simply displays all food types separately and their respective measurements.

