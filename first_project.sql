---- First assignement ---- first part of the project 

--- query 1 : clean the milk table 
SELECT * FROM milk_production;
SELECT * FROM milk_production LIMIT 1;
PRAGMA table_info(milk_production); -- review the columns
-- re_name columns 
ALTER TABLE milk_production RENAME COLUMN c1 TO Year; 
ALTER TABLE milk_production RENAME COLUMN c2 TO Period;
ALTER TABLE milk_production RENAME COLUMN c3 TO geo_level;
ALTER TABLE milk_production RENAME COLUMN c4 TO sate_ANSI;
ALTER TABLE milk_production RENAME COLUMN c5 TO commodity_id;
ALTER TABLE milk_production RENAME COLUMN c6 TO domain;
ALTER TABLE milk_production RENAME COLUMN c7 TO value;
DELETE FROM milk_production
WHERE ROWID = 1;
ALTER TABLE milk_production ADD COLUMN value_numeric REAL;
UPDATE milk_production
SET value_numeric = CAST(REPLACE(REPLACE(value, ',', ''), '.', '') AS REAL);
select * from milk_production;
-- query 2 :  the total milk production for the year 2023
SELECT year, sum (value_numeric) as production_23
from milk_production
where year = 2023;
-- query 3 : clean the coffee table 
select * from coffee_production;
ALTER TABLE coffee_production RENAME COLUMN c1 TO Year;
ALTER TABLE coffee_production RENAME COLUMN c2 TO Period;
ALTER TABLE coffee_production RENAME COLUMN c3 TO geo_level;
ALTER TABLE coffee_production RENAME COLUMN c4 TO sate_ANSI;
ALTER TABLE coffee_production RENAME COLUMN c5 TO commodity_id;
ALTER TABLE coffee_production RENAME COLUMN c6 TO value;
SELECT * FROM coffee_production LIMIT 1; -- identify the row to be removed 
-- Delete the first row from the table where the original columns name  
DELETE FROM coffee_production
WHERE ROWID = 1; 
-- create bew column fro the correct values of the productions 
ALTER TABLE coffee_production ADD COLUMN value_numeric1 REAL; 
UPDATE coffee_production
-- replace the cooma by the dot in the value columns 
SET value_numeric1 = CAST(REPLACE(REPLACE(value, ',', ''), '.', '') AS REAL);
select * from coffee_production; 
 --- coffee production data for the year 2015
select year, sum (value_numeric1) as total_prod_2015
from coffee_production
where year=2015;
-- query 4 : clean the honey table 
ALTER TABLE honey_production RENAME COLUMN c1 TO Year;
ALTER TABLE honey_production RENAME COLUMN c2 TO geo_level;
ALTER TABLE honey_production RENAME COLUMN c3 TO sate_ANSI;
ALTER TABLE honey_production RENAME COLUMN c4 TO commodity_id;
ALTER TABLE honey_production RENAME COLUMN c5 TO value;
SELECT * FROM honey_production LIMIT 1; -- identify the row to be removed 
-- Delete the first row from the table where the original columns name  
DELETE FROM honey_production
WHERE ROWID = 1; 
-- create bew column fro the correct values of the productions 
ALTER TABLE honey_production ADD COLUMN value_numeric2 REAL; 
UPDATE honey_production
-- replace the cooma by the dot in the value columns 
SET value_numeric2 = CAST(REPLACE(REPLACE(value, ',', ''), '.', '') AS REAL);
select * from honey_production;  
 --- query 5 :  the average honey production for the year 2022
select year, AVG (value_numeric2) as avrg_prod_2022
from honey_production
where year=2022;
-- query 6 : clean the state_lookup table 
-- rename columns 
ALTER TABLE state_lookup RENAME COLUMN c1 TO state;
ALTER TABLE state_lookup RENAME COLUMN c2 TO state_ANSI;
 
-- remove the firts row 
DELETE FROM state_lookup
WHERE ROWID = 1;
-- query 7 : find the number of the Iowa state 
select state , state_ansi 
from state_lookup
where state='IOWA';
-- query 8 : clean up the yogurt rpoduction table
select * from yogurt_production;
-- re_name columns 
ALTER TABLE yogurt_production RENAME COLUMN c1 TO Year; 
ALTER TABLE yogurt_production RENAME COLUMN c2 TO Period;
ALTER TABLE yogurt_production RENAME COLUMN c3 TO geo_level;
ALTER TABLE yogurt_production RENAME COLUMN c4 TO sate_ANSI;
ALTER TABLE yogurt_production RENAME COLUMN c5 TO commodity_id;
ALTER TABLE yogurt_production RENAME COLUMN c6 TO domain;
ALTER TABLE yogurt_production RENAME COLUMN c7 TO value;
-- remove the first row that have the names of the acctual colomns name's 
DELETE FROM yogurt_production
WHERE ROWID = 1;
-- create bew column fro the correct values of the productions 
ALTER TABLE yogurt_production ADD COLUMN value_numeric3 REAL; 
UPDATE yogurt_production
-- replace the coma by the dot in the value columns 
SET value_numeric3 = CAST(REPLACE(REPLACE(value, ',', ''), '.', '') AS REAL); 
select * from yogurt_production; 
-- query 9 : Find the highest yogurt production value for the year 2022 
select year, value_numeric3 -- we can also use max ()
from yogurt_production
where year=2022
order by value_numeric3 DESC;
-- query 10 :  Find states where both honey and milk were produced in 2022
SELECT h.year, h.sate_ansi
FROM honey_production h 
INNER JOIN milk_production m ON h.Year = m.Year
WHERE h.year = 2022 and h.sate_ANSI=35 ; -- the state_ansi =35 do not producehoney and milk in 2022 
-- query 11: clean the cheese table 
-- re_name columns 
ALTER TABLE cheese_production RENAME COLUMN c1 TO Year; 
ALTER TABLE cheese_production RENAME COLUMN c2 TO Period;
ALTER TABLE cheese_production RENAME COLUMN c3 TO geo_level;
ALTER TABLE cheese_production RENAME COLUMN c4 TO sate_ANSI;
ALTER TABLE cheese_production RENAME COLUMN c5 TO commodity_id;
ALTER TABLE cheese_production RENAME COLUMN c6 TO domain;
ALTER TABLE cheese_production RENAME COLUMN c7 TO value; 
DELETE FROM cheese_production
WHERE ROWID = 1; -- delete the first row where i have the actual name of columns 
ALTER TABLE cheese_production ADD COLUMN value_numeric4 REAL;
UPDATE cheese_production
SET value_numeric4 = CAST(REPLACE(REPLACE(value, ',', ''), '.', '') AS REAL);
select * from cheese_production; -- check the cheese table!
-- query 12 : Find the total yogurt production for states that also produced cheese in 2022.
select * from yogurt_production;
select  y.year , sum (y.value_numeric3) as yogurt_total_prod_2022
from yogurt_production y 
inner JOIN cheese_production c on y.sate_ANSI=c.sate_ANSI and y.year=c.year
where y.year= 2022
GROUP BY y.year;
SELECT SUM(y.value_numeric3)
FROM yogurt_production y
WHERE y.Year = 2022 AND y.Sate_ANSI IN (
    SELECT DISTINCT c.Sate_ANSI FROM cheese_production c WHERE c.Year = 2022); -- thus query is imporved more 
----- second assignement ---- second part of the project 
--- query 1 : find the total milk production for 2023
select year, sum (value_numeric)
from milk_production
where year=2023;
-- query 2 : wish states had cheese production greater than 100 million in April 2023 ?
select *
from cheese_production
where year=2023 and period='APR' and value_numeric4 > 100000000;

-- query 3 : What is the total value of coffee production for 2011?
select year, sum (value_numeric1)
from coffee_production
where year=2011; 

-- query 4 : There's a meeting with the Honey Council next week. Find the average honey production for 2022 so you're prepared

SELECT year, AVG(value_numeric2) as avrg_production
from honey_production
where year= 2022 ;

-- query 5 : What is the State_ANSI code for Florida ?
select * from state_lookup where state ='FLORIDA'; 

-- query 6 : For a cross-commodity report, can you list all states with their cheese production values
            -- , even if they didn't produce any cheese in April of 2023  ? What is the total for NEW JERSEY?

SELECT s.state, s.state_ansi,c.period , sum (c.value_numeric4) as total_NJ_APR_2023
FROM state_lookup s
inner JOIN cheese_production c ON s.state_ansi = c.sate_ansi
WHERE c.year = 2023 AND s.state = 'NEW JERSEY' and c.period='APR'; 

-- query 7 :  Can you find the total yogurt production for states in the year 2022 which also have 
    -- cheese production data from 2023? This will help the Dairy Division in their planning.

SELECT SUM(y.value_numeric3) AS total_yogurt_production
FROM yogurt_production y
WHERE y.sate_ansi IN (
    SELECT c.sate_ansi
    FROM cheese_production c
    WHERE c.year = 2023
) and y.year=2022;

-- query 8 : List all states from state_lookup that are missing from milk_production in 2023. 
			-- How many states are there?

SELECT COUNT(*) AS missing_states
FROM state_lookup sl
WHERE sl.state_ansi NOT IN (
    SELECT m.sate_ansi
    FROM milk_production m
    WHERE m.year = 2023
);

-- query  9 : List all states with their cheese production values, including states that didn't produce any cheese in April 2023.
				--Did Delaware produce any cheese in April 2023?
select c.year, c.period, s.state , sum (c.value_numeric4) as total_stat_APR_2023
from cheese_production c inner join state_lookup  s on s.state_ANSI=c.sate_ansi 
where c.year = 2023 and c.period='APR'
group by s.state  
order by total_stat_APR_2023 desc; 

-- query 10 : Find the average coffee production for all years where the honey production exceeded 1 million.

select  ROUND (AVG(value_numeric1)) from coffee_production 
 where sate_ansi in (select sate_ansi from honey_production where value_numeric2 > 1000000 );

SELECT ROUND(AVG(cp.value_numeric1), 2) AS average_coffee_production
FROM coffee_production cp
INNER JOIN honey_production hp ON cp.sate_ansi = hp.sate_ansi
WHERE hp.value_numeric2 > 1000000;

