/*5. Find the sum of gpd_per_capita by year and the count of countries for each year that have non-null gdp_per_capita where (i) the year is before 2012 and (ii) the country has a null gdp_per_capita in 2012. Your result should have the columns:

year
country_count
total*/

SELECT 
    d.year, 
    COUNT(DISTINCT c.country_name) AS country_count, 
    CONCAT('$',ROUND(SUM(d.gdp_per_capita), 2)) AS total
FROM 
    continent_map a
    JOIN continents b ON a.continent_code = b.continent_code
    JOIN countries c ON a.country_code = c.country_code
    JOIN per_capita d ON c.country_code = d.country_code
WHERE 
    d.year < 2012
    AND 
	(c.country_code IN 
        (SELECT 
            t1.country_code
        FROM 
            countries t1
        LEFT JOIN 
            (SELECT * FROM per_capita WHERE year = 2012) t2 ON (t1.country_code = t2.country_code)
        WHERE 
            t2.country_code IS NULL									/*identifies countries with null gdp_per_capita in 2012.*/
		)     							
    )
GROUP BY 
    d.year;


/*Result Set*/

year    country_count   		total
2004	14	 			$435360.53
2005	14	 			$453525.73
2006	13	 			$491425.81
2007	13	 			$580931.61
2008	10	 			$574016.21
2009	8	 			$399526.16
2010	4	 			$179750.83
2011	4	 			$199152.68
