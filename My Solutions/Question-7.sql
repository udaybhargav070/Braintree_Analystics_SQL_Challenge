/*7. Find the country with the highest average gdp_per_capita for each continent for all years. Now compare your list to the following data set. Please describe any and all mistakes that you can find with the data set below. Include any code that you use to help detect these mistakes.

rank	continent_name	country_code	country_name	avg_gdp_per_capita
1		Africa			SYC				Seychelles		$11,348.66
1		Asia			KWT				Kuwait			$43,192.49
1		Europe			MCO				Monaco			$152,936.10
1		North America	BMU				Bermuda			$83,788.48
1		Oceania			AUS				Australia		$47,070.39
1		South America	CHL				Chile			$10,781.71
*/

WITH ordered_list AS (
    SELECT
        continent_name,
        country_code,
        country_name,
        avg_gdp_per_capita,
        ROW_NUMBER() OVER (PARTITION BY continent_name order by avg_gdp_per_capita desc ) AS rn
    FROM											/*Partioned by continent_name sorted with high Avg_gdp*/
        (
            SELECT
                cn.continent_name as continent_name,
                c.country_code as country_code,
                c.country_name as country_name,
                avg(pc.gdp_per_capita) as avg_gdp_per_capita
            FROM
                continent_map cm
                JOIN countries c ON cm.country_code = c.country_code
                JOIN per_capita pc ON c.country_code = pc.country_code
                JOIN continents cn ON cm.continent_code = cn.continent_code
            group by 1,2,3
        ) AS subquery
)
SELECT rn,
    continent_name,
    country_code,
    country_name,
    concat('$',round(avg_gdp_per_capita,2)) as avg_gdp_per_capita
FROM
    ordered_list
WHERE
	rn = 1;							/*Displaying highest avg_gdp in all continents*/



/*Result Set*/  			/*There are minor changes in results compared to given expected data set in two continents(Africa & Asia)*/

rn  	continent_name  	country_code 	country_name		avg_gdp_per_capita
1	Africa			GNQ		Equatorial Guinea	$17955.72
1	Asia			QAT		Qatar			$70567.96
1	Europe			MCO		Monaco			$151421.89
1	North America		BMU		Bermuda			$84634.83
1	Oceania			AUS		Australia		$46147.45
1	South America		CHL		Chile			$10781.71