/*  3. For the year 2012, create a 3 column, 1 row report showing the percent share of gdp_per_capita for the following regions:

(i) Asia, (ii) Europe, (iii) the Rest of the World. Your result should look something like

Asia	Europe	Rest of World
25.0%	25.0%	50.0%
*/

SELECT CONCAT(ROUND((
						(SELECT 
                            SUM(gdp_per_capita)
						FROM
                            continent_map a join continents b
							on a.continent_code=b.continent_code
							join countries c
							on a.country_code=c.country_code
							join per_capita d
							on c.country_code=d.country_code
						where d.year=2012 and b.continent_name='Asia')
                         / 
						(SELECT 
                            SUM(gdp_per_capita)
                        FROM
                            continent_map a join continents b
							on a.continent_code=b.continent_code
							join countries c
							on a.country_code=c.country_code
							join per_capita d
							on c.country_code=d.country_code
                        WHERE
                            d.year = 2012)) * 100,
                    1),
            '%') AS 'Asia',
    CONCAT(ROUND((
						(SELECT 
                            SUM(gdp_per_capita)
						FROM
                            continent_map a join continents b
							on a.continent_code=b.continent_code
							join countries c
							on a.country_code=c.country_code
							join per_capita d
							on c.country_code=d.country_code
						where d.year=2012 and b.continent_name='Europe')
                         / 
						(SELECT 
                            SUM(gdp_per_capita)
                        FROM
                            continent_map a join continents b
							on a.continent_code=b.continent_code
							join countries c
							on a.country_code=c.country_code
							join per_capita d
							on c.country_code=d.country_code
                        WHERE
                            d.year = 2012)) * 100,
                    1),
            '%') AS 'Europe',
    CONCAT(ROUND((
						(SELECT 
                            SUM(gdp_per_capita)
						FROM
                            continent_map a join continents b
							on a.continent_code=b.continent_code
							join countries c
							on a.country_code=c.country_code
							join per_capita d
							on c.country_code=d.country_code
						where d.year=2012 and b.continent_name<>'Asia' and b.continent_name<>'Europe')
                         / 
						(SELECT 
                            SUM(gdp_per_capita)
                        FROM
                            continent_map a join continents b
							on a.continent_code=b.continent_code
							join countries c
							on a.country_code=c.country_code
							join per_capita d
							on c.country_code=d.country_code
                        WHERE
                            d.year = 2012)) * 100,
                    1),
            '%') AS 'Rest of World'


/*Result Set*/

Asia  	Europe  Rest of World
28.3%	42.2%	29.4%