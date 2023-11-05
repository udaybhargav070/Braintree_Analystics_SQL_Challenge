/*4a. What is the count of countries and sum of their related gdp_per_capita values for the year 2007 where the string 'an' (case insensitive) appears anywhere in the country name?

4b. Repeat question 4a, but this time make the query case sensitive.*/


/*4a*/

select count(*), round(sum(d.gdp_per_capita),2) as GDP_sum
from continent_map a join continents b
on a.continent_code=b.continent_code
join countries c
on a.country_code=c.country_code
join per_capita d
on c.country_code=d.country_code
where d.year=2007 AND LOWER(country_name) LIKE '%an%';    /*used LOWER to perform case insensitive*/


/*Result Set*/

count(*)  	GDP_sum
58		888339.86


/*4b*/

select count(*), round(sum(d.gdp_per_capita),2) as GDP_sum
from continent_map a join continents b
on a.continent_code=b.continent_code
join countries c
on a.country_code=c.country_code
join per_capita d
on c.country_code=d.country_code
where d.year=2007 AND country_name LIKE BINARY '%an%';         /*used BINARY to perform case insensitive*/


/*Result Set*/

count(*)  	GDP_sum
56		845004.25