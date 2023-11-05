/* 2. List the countries ranked 10-12 in each continent by the percent of year-over-year growth descending from 2011 to 2012.

The percent of growth should be calculated as: ((2012 gdp - 2011 gdp) / 2011 gdp)

The list should include the columns:

rank
continent_name
country_code
country_name
growth_percent*/

With cte as
(SELECT a.country_code,
		b.continent_name,
		c.country_name,
		d.year,
		d.gdp_per_capita, 
		((gdp_per_capita - lag(gdp_per_capita) over (partition by country_code order by year)) / lag(gdp_per_capita) over (partition by country_code order by year)) * 100 AS growth_percent           /*Used Lag function to get previous year gdp and made (2012gdp - 2011gdp)/2011gdp*/
from continent_map a join continents b
on a.continent_code=b.continent_code
join countries c
on a.country_code=c.country_code
join per_capita d
on c.country_code=d.country_code
where d.year between 2011 and 2012),

ranked_data as
(select rank() over (partition by continent_name order by growth_percent desc) as Rnk ,
continent_name,
country_code,
country_name,
concat(round(growth_percent,2),'%') as growth_percent
from cte) 

select * from ranked_data where rnk between 10 and 12;


/*Result Set*/

Rnk continent_name  country_code  country_name   		growth_percent
10	Africa			RWA	          Rwanda	     		8.73%
11	Africa			GIN	          Guinea	     		8.32%
12	Africa			NGA	          Nigeria	     		8.09%
10	Asia			UZB	          Uzbekistan	 		11.12%
11	Asia			IRQ	          Iraq	         		10.06%
12	Asia			PHL	          Philippines	 		9.73%
10	Europe			MNE	          Montenegro	 		-2.93%
11	Europe			SWE	          Sweden	     		-3.02%
12	Europe			ISL	          Iceland	     		-3.84%
10	North America		GTM	          Guatemala	     		2.71%
11	North America		HND	          Honduras	     		2.71%
12	North America		ATG	          Antigua and Barbuda		2.52%
10	Oceania			FJI	          Fiji	                	3.29%
11	Oceania			TUV	          Tuvalu			1.27%
12	Oceania			KIR	          Kiribati			0.04%
10	South America		ARG	          Argentina			5.67%
11	South America		PRY	          Paraguay			-3.62%
12	South America		BRA	          Brazil			-9.83%