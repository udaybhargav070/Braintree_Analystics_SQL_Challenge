/*6. All in a single query, execute all of the steps below and provide the results as your final answer:

a. create a single list of all per_capita records for year 2009 that includes columns:

continent_name
country_code
country_name
gdp_per_capita

b. order this list by:

continent_name ascending
characters 2 through 4 (inclusive) of the country_name descending

c. create a running total of gdp_per_capita by continent_name

d. return only the first record from the ordered list for which each continent's running total of gdp_per_capita meets or exceeds $70,000.00 with the following columns:

continent_name
country_code
country_name
gdp_per_capita
running_total
*/

WITH ordered_list AS (
    SELECT
        continent_name,
        country_code,
        country_name,
        gdp_per_capita,
        ROW_NUMBER() OVER (PARTITION BY continent_name ORDER BY running_total ASC) AS rn,
        running_total
    FROM
        (
            SELECT
                cn.continent_name as continent_name,
                c.country_code as country_code,
                c.country_name as country_name,
                pc.gdp_per_capita as gdp_per_capita,
                SUM(pc.gdp_per_capita) OVER (PARTITION BY cm.continent_code ORDER BY cn.continent_name ASC, substring(c.country_name,2,3) DESC) AS running_total		/*order list by continent_name asc and used substring 2 through 4 of country_name desc*/
            FROM
                continent_map cm
                JOIN countries c ON cm.country_code = c.country_code
                JOIN per_capita pc ON c.country_code = pc.country_code
                JOIN continents cn ON cm.continent_code = cn.continent_code
            WHERE pc.year = 2009
        ) AS subquery
    WHERE
        running_total >= 70000					/*Displaying results >= $70,000.00 in year 2009*/
)
SELECT 
    continent_name,
    country_code,
    country_name,
    round(gdp_per_capita,2) as gdp_per_capita,
    round(running_total,2) as running_total
FROM
    ordered_list
 WHERE											/*Displaying all continents first record*/
	rn = 1;




/*Result Set*/

continent_name  	country_code 	country_name    gdp_per_capita  	running_total
Africa			LBY		Libya		10455.57		70227.16
Asia			KWT		Kuwait		37160.54		73591.81
Europe			CHE		Switzerland	65790.07		84673.58
North America		ABW		Aruba		24639.94		84504.67
Oceania			NZL		New Zealand	27474.33		84623.92
South America		ECU		Ecuador		4236.78			72315.82