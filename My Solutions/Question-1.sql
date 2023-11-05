/*1. Data Integrity Checking & Cleanup

Alphabetically list all of the country codes in the continent_map table that appear more than once. Display any values where country_code is null as country_code = "FOO" and make this row appear first in the list, even though it should alphabetically sort to the middle. Provide the results of this query as your answer.

For all countries that have multiple rows in the continent_map table, delete all multiple records leaving only the 1 record per country. The record that you keep should be the first one when sorted by the continent_code alphabetically ascending. Provide the query/ies and explanation of step(s) that you follow to delete these records.
*/


/*Question 1.1*/

USE Braintree;


UPDATE continent_map 
SET 
    country_code = NULL		/*Identified empty strings converted to null for null handling expressions for all tasks going forward */
WHERE
    country_code = '';

SELECT 
    COALESCE(country_code, 'FOO') AS c_code			/* FOO will be at first row since the column is null, even though Alphabetically sorted*/       
FROM
    continent_map
GROUP BY country_code
HAVING COUNT(*) > 1
ORDER BY country_code;

/*Result Set*/

country_code:
FOO
ARM
AZE
CYP
GEO
KAZ
RUS
TUR
UMI

/*Question 1.2*/

CREATE TEMPORARY TABLE t1 AS
SELECT
    ROW_NUMBER() OVER (                                  /*Creating a temp table for ranking*/
        ORDER BY
            country_code,
            continent_code ASC
    ) AS rnk,
    country_code,
    continent_code
FROM
    continent_map;

	
CREATE TEMPORARY TABLE t2 AS
SELECT
    MIN(rnk) AS ID                /*Created another temp table for removing duplicates and keeping only first record using (min and group by) */
FROM
    t1
GROUP BY
    country_code;
	

DELETE FROM t1 WHERE rnk NOT IN(SELECT ID FROM t2) ;   /*Deleting duplicates and keeping first record */


DELETE FROM continent_map;                 		/*Reset continent_map table*/


INSERT INTO continent_map
  SELECT country_code, continent_code FROM t1;   /*Refill continent_map from temp_table*/
 

 DROP TABLE t1;
 DROP TABLE t2;                                  /*dropping temporary tables*/


SELECT * FROM continent_map;             		/*Data After deleting duplicates */

/*Result Set*/

country_code    continent_code
null			AS
ABW	    		NA
AFG	    		AS
AGO	    		AF
AIA	    		NA
ALA	    		EU
ALB	    		EU
AND	    		EU
ANT	    		NA
................................ and so on