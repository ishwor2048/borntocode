DataCamp SQL:

-- JOINING DATA IN POSTGRESQL
-- Target is to join two or more database together in a single table
-- Innerjoin in SQL
Select p1.country, p1.continent,
	Prime_minister, president
FROM prime_ministers AS p1
INNER JOIN presidents AS p2
ON p1.country = p2.country;

-- Inner join
-- Throughout this course, you'll be working with the countriesdatabase containing information about the most populous world cities as well as country-level economic data, population data, and geographic data. This countries database also contains information on languages spoken in each country.
-- You can see the different tables in this database by clicking on the tabs on the bottom right below query.sql. Click through them to get a sense for the types of data that each table contains before you continue with the course! Take note of the fields that appear to be shared across the tables.
-- Recall from the video the basic syntax for an INNER JOIN, here including all columns in both tables:
SELECT *
FROM left_table
INNER JOIN right_table
ON left_table.id = right_table.id;

-- You'll start off with a SELECT statement and then build up to an inner join with the cities and countries tables. Let's get to it!
-- Begin by selecting all columns from the cities table.
SELECT *
from cities
Inner join the cities table on the left to the countriestable on the right, keeping all of the fields in both tables. You should join on the country_code field in cities and the code field in countries. Do not alias your tables here or in the next task though. Using cities and countries is fine for now.
SELECT cities.name AS city, countries.name AS country, region
FROM cities 
INNER JOIN countries 
ON cities.country_code = countries.code;

-- Inner join (2)
-- Instead of writing the full table name, you can use table aliasing as a shortcut. For tables you also use AS to add the alias immediately after the table name with a space. Check out the aliasing of citiesand countries below.
SELECT c1.name AS city, c2.name AS country
FROM cities AS c1
INNER JOIN countries AS c2
ON c1.country_code = c2.code;

-- Notice that to select a field in your query that appears in multiple tables, you'll need to identify which table/table alias you're referring to by using a . in your SELECT statement.
-- You'll now explore a way to get data from both the countries and economies tables to examine the inflation rate for both 2010 and 2015.
-- •	Join the tables countries (left) and economies (right). What field do you need to use in ON to match the two tables?
-- •	Alias countries AS c and economies AS e.
-- •	From this join, SELECT:
-- o	c.code, aliased as country_code.
-- o	name, year, and inflation_rate, not aliased.
select c.code as country_code, c.name, e.year, e.inflation_rate
from countries as c
inner join economies as e
on c.code = e.code;
Inner join (3)
-- The ability to combine multiple joins in a single query is a powerful feature of SQL, e.g:
SELECT *
FROM left_table
INNER JOIN right_table
ON left_table.id = right_table.id
INNER JOIN another_table
ON left_table.id = another_table.id;

-- As you can see here it becomes tedious to continually write long table names in joins. This is when it becomes useful to alias each table using the first letter of its name (e.g. countries AS c)! It is standard practice to alias in this way and, if you choose to alias tables or are asked to specifically for an exercise in this course, you should follow this protocol.
-- Now, for each country, you want to get the country name, its region, and the fertility rate and unemployment rate for both 2010 and 2015.
-- •	Inner join countries (left) and populations (right) on the code and country_code fields respectively.
-- •	Alias countries AS c and populations AS p.
-- •	Select code, name, and region from countries and also select year and fertility_rate from populations (5 fields in total).
select c.code, c.name, c.region, p.year, p.fertility_rate
from countries as c
inner join populations as p
on c.code = p.country_code;

-- •	Add an additional inner join with economies to your previous query by joining on code.
-- •	Include the unemployment_rate column that became available through joining with economies.
-- •	Note that year appears in both populations and economies, so you have to explicitly use e.year instead of year as you did before.
SELECT c.code, c.name, c.region, p.year, p.fertility_rate, e.unemployment_rate 
FROM countries AS c
INNER JOIN populations AS p
ON c.code = p.country_code
INNER JOIN economies as e
ON c.code = e.code;

-- •	Add an additional inner join with economies to your previous query by joining on code.
-- •	Include the unemployment_rate column that became available through joining with economies.
-- •	Note that year appears in both populations and economies, so you have to explicitly use e.year instead of year as you did before.
SELECT c.code, c.name, c.region, p.fertility_rate, e.year, e.unemployment_rate
FROM countries AS c
INNER JOIN populations AS p
ON c.code = p.country_code
INNER JOIN economies AS e
ON c.code = e.code;

-- •	Scroll down the query result and take a look at the results for Albania from your previous query. Does something seem off to you?
-- •	The trouble with doing your last join on c.code = e.codeand not also including year is that e.g. the 2010 value for fertility_rate is also paired with the 2015 value for unemployment_rate.
-- •	Fix your previous query: in your last ON clause, use AND to add an additional joining condition. In addition to joining on code in c and e, also join on year in e and p.
SELECT c.code, name, region, e.year, fertility_rate, unemployment_rate
FROM countries AS c
INNER JOIN populations AS p
ON c.code = p.country_code
INNER JOIN economies AS e
ON c.code = e.code
AND e.year = p.year;

-- INNER JOIN VIA ‘USING’ KEY WORD
Select left_table.id as L_id, left_table.val as L_val, right_table.val as R_val
From left_table
INNER JOIN right_table
Using (id);

-- While trying to fill up the President-Prime Minister Data using ‘USING’
-- How to fill up this Data?
Select p1.country, p1.continent, prime_minister, president
From__ AS p1
INNER JOIN __ AS p2
__( __ );

-- Answer is:
Select p1.country, p1.continent, prime_minister, president
From presidents as p1
INNER JOIN prime_minister as p2
Using (country);

-- Review inner join using on
-- Why does the following code result in an error?
SELECT c.name AS country, l.name AS language
FROM countries AS c
INNER JOIN languages AS l;

-- Inner join with using
-- When joining tables with a common field name, e.g.
SELECT *
FROM countries
INNER JOIN economies
ON countries.code = economies.code

-- You can use USING as a shortcut:
SELECT *
FROM countries
INNER JOIN economies
USING(code)

-- You'll now explore how this can be done with the countries and languages tables.
-- Inner join countries on the left and languages on the right with USING(code). Select the fields corresponding to:
-- •	country name AS country,
-- •	continent name,
-- •	language name AS language, and
-- •	whether or not the language is official.
-- Remember to alias your tables using the first letter of their names.
SELECT c.name AS country, continent, l.name AS language, l.official
FROM countries AS c
INNER JOIN languages AS l
using(code);

-- SELF – ish joins, just in CASE
-- JOIN A TABLE TO ITSELF
select p1.country as country1, p2.country as country2, p1.continent
from prime_ministers as p1
inner join prime_ministers as p2
on p1.continent = p2.continent
limit = 14;

-- FINISHING OFF THE SELF-JOIN PRIME_MINISTERS
Select p1.country as country1, p2.country as country2, p1.continent
From prime_ministers as p1
INNER JOIN prime_ministers as p2
ON p1.continent = p2.continent and p1.country <> p2.country
Limit 13;

-- CASE WHEN and THEN
-- Preparing indep_year_group in states
Select name, continent, indep_year
	Case when ___ < ___ then ‘before 1900’
		When indep_year <= 1930 then ‘___’
		Else ‘___’ END
		AS indep_year_group
From states
ORDER BY indep_year_group;

-- FILLED OUT INFORMATION:
Select name, continent, indep_year
	Case when indep_year < 1900 then ‘before 1900’
		When indep_year <= 1930 then ‘between 1900 and 1930’
		Else ‘after 1930’ END
		As indep_year_group
From states
ORDER BY indep_year_group;

------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Self-join
-- In this exercise, you'll use the populations table to perform a self-join to calculate the percentage increase in population from 2010 to 2015 for each country code!
-- Since you'll be joining the populations table to itself, you can alias populations as p1 and also populations as p2. This is good practice whenever you are aliasing and your tables have the same first letter. Note that you are required to alias the tables with self-joins.
-- •	Join populations with itself ON country_code.
-- •	Select the country_code from p1.
-- •	Select the size field from both p1 and p2. SQL won't allow same-named fields, so alias p1.size as size2010and p2.size as size2015.
SELECT p1.country_code, 
       p1.size AS size2010,
       p2.size AS size2015
FROM populations AS p1
INNER JOIN populations AS p2
ON  p1.country_code = p2.country_code;

-- Notice from the result that for each country_code you have four entries laying out all combinations of 2010 and 2015.
-- Extend the ON in your query to include only those records where the p1.year (2010) matches with p2.year - 5 (2015 - 5 = 2010).
-- This will omit the three entries per country_code that you aren't interested in.
SELECT p1.country_code,
       p1.size AS size2010,
       p2.size AS size2015
FROM populations AS p1
INNER JOIN populations AS p2
ON p1.country_code = p2.country_code
    AND p1.year = p2.year - 5;

-- As you just saw, you can also use SQL to calculate values like p2.year - 5 for you. With two fields like size2010 and size2015, you may want to determine the percentage increase from one field to the next:
-- With two numeric fields AA and BB, the percentage growth from AAto BB can be calculated as (B−A)/A∗100.0(B−A)/A∗100.0.
-- To SELECT add a new field aliased as growth_perc that calculates the percentage population growth from 2010 to 2015 for each country, using p2.size and p1.size.

SELECT p1.country_code, 
       p1.size AS size2010,
       p2.size AS size2015,
       ((p2.size - p1.size) / p1.size * 100.0) AS growth_perc
FROM populations AS p1
INNER JOIN populations AS p2
ON  p1.country_code = p2.country_code
AND p1.year = p2.year - 5;

-- Case when and then
-- Often it's useful to look at a numerical field not as raw data, but instead as being in different categories or groups.
-- You can use CASE with WHEN, THEN, ELSE, and END to define a new grouping field.
-- Using the countries table, create a new field AS geosize_groupthat groups the countries into three groups:
-- •	If surface_area is greater than 2 million, geosize_group is 'large'.
-- •	If surface_area is greater than 350 thousand but not larger than 2 million, geosize_group is 'medium'.
-- •	Otherwise, geosize_group is 'small'.
SELECT name, continent, code, surface_area,
        -- first case
    CASE WHEN surface_area > 2000000 THEN 'large'
        -- second case
        WHEN surface_area > 350000 THEN 'medium'
        -- else clause + end
        ELSE 'small' END
        AS geosize_group
FROM countries;

-- Inner challenge
-- The table you created with the added geosize_group field has been loaded for you here with the name countries_plus. Observe the use of (and the placement of) the INTO command to create this countries_plus table:
SELECT name, continent, code, surface_area,
    CASE WHEN surface_area > 2000000
            THEN 'large'
       WHEN surface_area > 350000
            THEN 'medium'
       ELSE 'small' END
       AS geosize_group
INTO countries_plus
FROM countries;

-- You will now explore the relationship between the size of a country in terms of surface area and in terms of population using grouping fields created with CASE.
-- By the end of this exercise, you'll be writing two queries back-to-back in a single script. You got this!
-- Using the populations table focused only for the year2015, create a new field AS popsize_group to organize population size into
-- •	'large' (> 50 million),
-- •	'medium' (> 1 million), and
-- •	'small' groups.
-- Select only the country code, population size, and this new popsize_group as fields.
SELECT country_code, size,
    CASE WHEN size > 50000000 THEN 'large'
        WHEN size > 1000000 THEN 'medium'
        ELSE 'small' END
        AS popsize_group
FROM populations AS p
WHERE year = 2015;

-- •	Use INTO to save the result of the previous query as pop_plus. You can see an example of this in the countries_plus code in the assignment text. Make sure to include a ; at the end of your WHERE clause!
-- •	Then, include another query below your first query to display all the records in pop_plus using SELECT * FROM pop_plus; so that you generate results and this will display pop_plus in query result.
SELECT country_code, size,
    CASE WHEN size > 50000000 THEN 'large'
        WHEN size > 1000000 THEN 'medium'
        ELSE 'small' END
        AS popsize_group
INTO pop_plus
FROM populations AS p
WHERE year = 2015;

SELECT *
FROM pop_plus;

-- •	Keep the first query intact that creates pop_plus using INTO.
-- •	Remove the SELECT * FROM pop_plus; code and instead write a second query to join countries_plus AS c on the left with pop_plus AS p on the right matching on the country code fields.
-- •	Select the name, continent, geosize_group, and popsize_group fields.
-- •	Sort the data based on geosize_group, in ascending order so that large appears on top.
SELECT country_code, size,
    CASE WHEN size > 50000000 THEN 'large'
        WHEN size > 1000000 THEN 'medium'
        ELSE 'small' END
        AS popsize_group
INTO pop_plus
FROM populations AS p
WHERE year = 2015;

SELECT c.name, c.continent, c.geosize_group, p.popsize_group
FROM countries_plus AS c
INNER JOIN pop_plus AS p
ON c.code = p.country_code
ORDER BY geosize_group;

-- LEFT AND RIGHT JOINS
-- The Syntax of a left join
SELECT p1.country, prime_minister, president
FROM prime_ministers as p1
LEFT JOIN presidents as p2
On p1.country = p2.country;

-- RIGHT JOIN
SELECT right_table.id as R_id,
	Left_table.val as L_val,
	Right_table.val as R_val
FROM left_table
RIGHT JOIN right_table
ON left_table.id = right_table.id;

-- Left Join
-- Now you'll explore the differences between performing an inner join and a left join using the cities and countries tables.
-- You'll begin by performing an inner join with the cities table on the left and the countries table on the right. Remember to alias the name of the city field as city and the name of the country field as country.
-- You will then change the query to a left join. Take note of how many records are in each query here!
-- Fill in the code shown to complete the inner join. Note how many records are in the result of the join in the query result tab.

-- get the city name (and alias it), the country code,
-- the country name (and alias it), the region,
-- and the city proper population
SELECT c1.name AS city, code, c2.name AS country,
       region, city_proper_pop
-- specify left table
FROM cities AS c1
-- specify right table and type of join
INNER JOIN countries AS c2
-- how should the tables be matched?
ON c1.country_code = c2.code
-- sort based on descending country code
ORDER BY code DESC;
-- Change the code to perform a LEFT JOIN instead of an INNER JOIN. After executing this query, note how many records the query result contains.
-- get the city name (and alias it), the country code,
-- the country name (and alias it), the region,
-- and the city proper population
SELECT c1.name AS city, code, c2.name AS country,
       region, city_proper_pop
-- specify left table
FROM cities AS c1
-- specify right table and type of join
LEFT JOIN countries AS c2
-- how should the tables be matched?
ON c1.country_code = c2.code
-- sort based on descending country code
ORDER BY code DESC;

-- Left join (2)
-- Next, you'll try out another example comparing an inner join to its corresponding left join. Before you begin though, take note of how many records are in both the countries and languages tables below.
-- You will begin with an inner join on the countries table on the left with the languages table on the right. Then you'll change the code to a left join in the next bullet.
-- Note the use of multi-line comments here using /* and */.
-- Perform an inner join. Alias the name of the country field as country and the name of the language field as language. Sort based on descending country name.
/*
select country name AS country, the country's local name,
the language name AS language, and
the percent of the language spoken in the country
*/
SELECT c.name AS country, local_name, l.name AS language, percent
-- countries on the left (alias as c)
FROM countries AS c
-- appropriate join with languages (as l) on the right
INNER JOIN languages AS l
-- give fields to match on
ON c.code = l.code
-- sort by descending country name
ORDER BY country DESC;
/*
select country name AS country, the country's local name,
the language name AS language, and
the percent of the language spoken in the country
*/
SELECT c.name AS country, local_name, l.name AS language, percent
-- countries on the left (alias as c)
FROM countries AS c
-- appropriate join with languages (as l) on the right
left JOIN languages AS l
-- give fields to match on
ON c.code = l.code
-- sort by descending country name
ORDER BY country DESC;

-- Left join (3)
-- You'll now revisit the use of the AVG() function introduced in our Intro to SQL for Data Science course. You will use it in combination with left join to determine the average gross domestic product (GDP) per capita by region in 2010.
-- •	Begin with a left join with the countries table on the left and the economies table on the right.
-- •	Focus only on records with 2010 as the year.
-- -- select name, region, and gdp_percapita
SELECT name, region, gdp_percapita
-- from countries (alias c) on the left
FROM countries AS c
-- left join with economies (alias e)
LEFT JOIN economies AS e
-- match on code fields
ON c.code = e.code
-- focus on 2010 entries
WHERE e.year = 2010;

-- Modify your code to calculate the average GDP per capita AS avg_gdp for each region in 2010. Select the region and avg_gdp fields.
-- Select region, average gdp_percapita (alias avg_gdp)
SELECT region, AVG(gdp_percapita) as avg_gdp
-- From countries (alias c) on the left
FROM countries AS c
-- Join with economies (alias e)
LEFT JOIN economies AS e
-- Match on code fields
ON c.code = e.code
-- Focus on 2010 
WHERE year = 2010
-- Group by region
GROUP BY region;

-- Arrange this data on average GDP per capita for each region in 2010 from highest to lowest average GDP per capita.
-- Select region, average gdp_percapita (alias avg_gdp)
SELECT region, AVG(gdp_percapita) as avg_gdp
-- From countries (alias c) on the left
FROM countries AS c
-- Join with economies (alias e)
LEFT JOIN economies AS e
-- Match on code fields
ON c.code = e.code
-- Focus on 2010 
WHERE year = 2010
-- Group by region
GROUP BY region
-- Order by avg_gdp, descending
ORDER BY avg_gdp DESC;

/*Right join
Right joins aren't as common as left joins. One reason why is that you can always write a right join as a left join.
The left join code is commented out here. Your task is to write a new query using rights joins that produces the same result as what the query using left joins produces. Keep this left joins code commented as you write your own query just below it using right joins to solve the problem.
Note the order of the joins matters in your conversion to using right joins!*/
SELECT cities.name AS city, urbanarea_pop, countries.name AS country,
       indep_year, languages.name AS language, percent
FROM languages
RIGHT JOIN countries
ON languages.code = countries.code
RIGHT JOIN cities
ON countries.code = cities.country_code
ORDER BY city, language;

-- FULL JOINS
Select left_table.id as L_id,
	Right_table.id as R_id,
	Left_table.val as L_val,
	Right_table.val as R_val
From left_table
FULL JOIN right_table
Using(id);

-- While working on Prime-Minister and President Data:
SELECT p1.country as pm_co, p2.country as pres_co,
	Prime_minister, president
FROM prime_ministers as p1
FULL JOIN presidents as p2
ON p1.country = p2.country;

-- Full join
-- In this exercise, you'll examine how your results differ when using a full join versus using a left join versus using an inner join with the countries and currencies tables.
-- You will focus on the North American region and also where the name of the country is missing. Dig in to see what we mean!
-- Begin with a full join with countries on the left and currencies on the right. The fields of interest have been SELECTed for you throughout this exercise.
-- Then complete a similar left join and conclude with an inner join.
-- Choose records in which region corresponds to North America or is NULL.

SELECT name AS country, code, region, basic_unit
FROM countries
FULL JOIN currencies
USING (code)
WHERE region = 'North America' OR region IS NULL
ORDER BY region;

-- Repeat the same query as above but use a LEFT JOIN instead of a FULL JOIN. Note what has changed compared to the FULL JOIN result!
SELECT name AS country, code, region, basic_unit
FROM countries
LEFT JOIN currencies
USING (code)
WHERE region = 'North America' OR region IS NULL
ORDER BY region;

-- Repeat the same query as above but use an INNER JOIN instead of a FULL JOIN. Note what has changed compared to the FULL JOIN and LEFT JOIN results!
SELECT name AS country, code, region, basic_unit
FROM countries
INNER JOIN currencies
USING (code)
WHERE region = 'North America' OR region IS NULL
ORDER BY region;

-------------------------------------------------------------------------------------
-- Full join (2)
-- You'll now investigate a similar exercise to the last one, but this time focused on using a table with more records on the left than the right. You'll work with the languages and countries tables.
-- Begin with a full join with languages on the left and countrieson the right. Appropriate fields have been selected for you again here.
-- •	Choose records in which countries.name starts with the capital letter 'V' or is NULL.
-- •	Arrange by countries.name in ascending order to more clearly see the results.
-- Repeat the same query as above but use a left join instead of a full join. Note what has changed compared to the full join result!
SELECT countries.name, code, languages.name AS language
FROM languages
LEFT JOIN countries
USING (code)
WHERE countries.name LIKE 'V%' OR countries.name IS NULL
ORDER BY countries.name;

-- #INNER JOIN
SELECT countries.name, code, languages.name AS language
FROM countries
INNER JOIN languages
USING (code)
WHERE countries.name LIKE 'V%' OR countries.name IS NULL
ORDER BY countries.name;

-- Full join (3)
-- You'll now explore using two consecutive full joins on the three tables you worked with in the previous two exercises.
-- •	Complete a full join with countries on the left and languageson the right.
-- •	Next, full join this result with currencies on the right.
-- •	Select the fields corresponding to the country name AS country, region, language name AS language, and basic and fractional units of currency.
-- •	Use LIKE to choose the Melanesia and Micronesia regions (Hint:'M%esia').
SELECT c1.name as country, region, l.name AS language,
basic_unit, frac_unit
FROM countries as c1
FULL JOIN languages AS l
USING (code)
FULL JOIN currencies AS c2
USING (code)
WHERE region LIKE 'M%esia';

-- CROSS JOIN
select prime_ministers, president
from prime_ministers as p1
cross join presidents as p2
where p1.continent IN (‘North America’, ‘Ocenia’);

-- A table of two cities
-- This exercise looks to explore languages potentially and most frequently spoken in the cities of Hyderabad, India and Hyderabad, Pakistan.
-- You will begin with a cross join with cities AS c on the left and languages AS l on the right. Then you will modify the query using an inner join in the next tab.
-- •	Create the cross join above and select only the city name AS city and language name AS language. (Recall that cross joins do not use ON or USING.)
-- •	Make use of LIKE and Hyder% to choose Hyderabad in both countries.
SELECT c.name AS city, l.name AS language
FROM cities AS c        
CROSS JOIN languages AS l
WHERE c.name LIKE 'Hyder%';

-- Use an inner join instead of a cross join. Think about what the difference will be in the results for this inner join result and the one for the cross join.
SELECT cities.name as city, languages.name as language
FROM cities        
INNER JOIN languages
ON cities.country_code = languages.code
WHERE cities.name LIKE 'Hyder%';

-- Outer challenge
-- Now that you're fully equipped to use outer joins, try a challenge problem to test your knowledge!
-- In terms of life expectancy for 2010, determine the names of the lowest five countries and their regions.
SELECT c.name AS country, region, p.life_expectancy AS life_exp
FROM countries AS c
LEFT JOIN populations AS p
ON c.code = p.country_code
WHERE p.year = 2010
ORDER BY p.life_expectancy
LIMIT 5;

-- STATE OF THE UNION

-- SET THEORY VENN DIAGRAMS

-- Union Diagrams = 
-- Example: 
-- diagram 1 = [1, 2, 3, 4]
-- diagram 2 = [1, 3, 5, 6, 7, 8]
-- Union Diagram = [1, 2, 3, 4, 5, 6, 7, 8]

-- Union All Diagrams =
-- Example:
-- diagram 1 = [1, 2, 3, 4]
-- diagram 2 = [1, 3, 5, 6, 7, 8]
-- Union Diagram = [1, 1, 2, 3, 3, 4, 5, 5, 6, 7, 8]
-- *****************************************************************************
-- Intersect Diagrams
-- Except Diagrams
-- ***************************************************
-- UNION
Select prime_ministers as leader, country
From prime_ministers
UNION
Select monarch, country
From monarchs
Order by country;
-- ****************************************************************************

-- Union
-- Near query result to the right, you will see two new tables with names economies2010 and economies2015.
-- •	Combine these two tables into one table containing all of the fields in economies2010. The economies table is also included for reference.
-- •	Sort this resulting single table by country code and then by year, both in ascending order.
-- -- pick specified columns from 2010 table
select *
-- 2010 table will be on top
from economies2010
-- which set theory clause?
UNION
-- pick specified columns from 2015 table
select *
-- 2015 table on the bottom
from economies2015
-- order accordingly
ORDER BY code, year;