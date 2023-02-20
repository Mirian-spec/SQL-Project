/* 
BREWERIES DATA ANALYSIS
PROBLEM STATEMENT:
From the international breweries data recorded for a duration of three years, you are
directed to do the following analyses to aid better decision making in order to maximize
profit and reduce loss to the lowest minimum.

Session A
PROFIT ANALYSIS
1. Within the space of the last three years, what was the profit worth of the breweries,
inclusive of the anglophone and the francophone territories?
2. Compare the total profit between these two territories in order for the territory manager,
Mr. Stone made a strategic decision that will aid profit maximization in 2020.
3. Country that generated the highest profit in 2019
4. Help him find the year with the highest profit.
5. Which month in the three years was the least profit generated?
6. What was the minimum profit in the month of December 2018?
7. Which particular brand generated the highest profit in Senegal?

Session B
BRAND ANALYSIS
1. Within the last two years, the brand manager wants to know the top three brands
consumed in the francophone countries
2. Find out the top two choice of consumer brands in Ghana
3. Find out the details of beers consumed in the past three years in the most oil reached
country in West Africa.
4. Favorites malt brand in Anglophone region between 2018 and 2019
5. Which brands sold the highest in 2019 in Nigeria?
6. Favorites brand in South_South region in Nigeria
7. Bear consumption in Nigeria
8. Level of consumption of Budweiser in the regions in Nigeria
9. Level of consumption of Budweiser in the regions in Nigeria in 2019 (Decision on Promo)

Session C
COUNTRIES ANALYSIS
1. Country with the highest consumption of beer.
2. Highest sales personnel of Budweiser in Senegal
3. Country with the highest profit of the fourth quarter in 201
*/

/*SECTION A Solutions
SELECT * FROM brewery_all;
/*1. Within the space of the last three years, what was the profit worth of the
breweries,inclusive of the anglophone and the francophone territories?*/
SELECT sum(profit) as total_profits, countries
FROM brewery_all
GROUP BY countries;

SELECT DISTINCT years FROM brewery_all;
/*Compare the total profit between these two territories in order for the territory manager,
Mr. Stone made a strategic decision that will aid profit maximization in 2020.*/
Alter table brewery_all 
Add territories varchar;
Update brewery_all
Set territories ='Anglophone'
Where countries in ('Nigeria', 'Ghana');
Update brewery_all 
Set territories ='Francophone'
Where countries in ('Benin', 'Senegal', 'Togo');

SELECT territories, SUM(PROFIT) as total_profits 
FROM brewery_all
GROUP BY territories; 

/*3. Country that generated the highest profit in 2019 */ 
SELECT countries, sum(PROFIT) as total_profits
FROM brewery_all 
WHERE years = '2019'
GROUP BY countries
ORDER BY total_profits DESC 
limit 1;

/*4. Help him find the year with the highest profit.*/
SELECT years, sum(profit) as total_profits
from brewery_all
GROUP BY years
ORDER BY total_profits DESC;

/*5.Which month in the three years was the least profit generated? */
SELECT profit, months, years
FROM brewery_all 
ORDER BY profit
limit 1;

/*6. What was the minimum profit in the month of December 2018?*/
SELECT profit, months, years
FROM brewery_all 
WHERE years='2018'AND months='December'	
ORDER BY profit
limit 5;

/*7. Which particular brand generated the highest profit in Senegal?*/
SELECT brands, SUM(profit) as total_profits
FROM brewery_all 
WHERE countries='Senegal'
GROUP BY brands
ORDER BY total_profits DESC;

/*SECTION B Solutions
1. Within the last two years, the brand manager wants to know the top three brands
consumed in the francophone countries*/ 
/*Top 3 by profit*/
SELECT brands, sum(profit) as total_profits,YEARS, territories
FROM brewery_all
WHERE YEARS in (2018,2019) AND territories ='Francophone'
GROUP BY BRANDS, YEARS,territories
ORDER BY total_profits DESC
LIMIT 3;
/*Top 3 by quantity*/
SELECT brands, max(QUANTITY) as total_quantity,YEARS, territories
FROM brewery_all
WHERE YEARS in (2018,2019) AND territories ='Francophone'
GROUP BY BRANDS, YEARS,territories
ORDER BY total_quantity DESC
LIMIT 3;

SELECT DISTINCT quantity FROM brewery_all;

/*2. Find out the top two choice of consumer brands in Ghana*/
SELECT brands, max(QUANTITY) as total_quantity, countries
from brewery_all
where countries='Ghana'
group by brands, countries
order BY total_quantity DESC
LIMIT 2;

/*3 Find out the details of beers consumed in the past three years in the most oil reached
country in West Africa.*/

select * 
from brewery_all
where countries ='Nigeria' and BRANDS in ('eagle lager','hero','trophy','castle lite','budweiser');

SELECT DISTINCT region FROM brewery_all;
/*4.Favorites malt brand in Anglophone region between 2018 and 2019*/
select brands,  max(QUANTITY) as total_quantity, territories, years 
from brewery_all
where territories ='Anglophone' and BRANDS not in ('eagle lager','hero','trophy','castle lite','budweiser') and years in(2018,2019)
GROUP BY brands,territories, years
ORDER BY total_quantity desc
limit 2;

/*5.. Which brands sold the highest in 2019 in Nigeria? */
SELECT BRANDS, max(QUANTITY) as total_quantity, years, countries
FROM brewery_all
WHERE countries='Nigeria'and years='2019'
GROUP BY brands,years, countries
ORDER BY total_quantity desc;

/*6.Favorites brand in South_South region in Nigeria*/
SELECT BRANDS, max(QUANTITY) as total_quantity, region, countries
FROM brewery_all
WHERE countries='Nigeria'and region='southsouth'
GROUP BY brands,region, countries
ORDER BY total_quantity desc
limit 1

/*7.Bear consumption in Nigeria*/
Select max(QUANTITY) as total_quantity,countries,brands 
from brewery_all
where countries ='Nigeria' and BRANDS in ('eagle lager','hero','trophy','castle lite','budweiser')
GROUP BY brands,countries
ORDER BY total_quantity;

/*8.Level of consumption of Budweiser in the regions in Nigeria*/
select max(QUANTITY) as total_quantity,countries,brands, region 
from brewery_all
where countries ='Nigeria' and BRANDS in ('budweiser')
GROUP BY brands,countries,region
ORDER BY total_quantity;

/*9. Level of consumption of Budweiser in the regions in Nigeria in 2019*/
select max(QUANTITY) as total_quantity,countries,brands, region, years
from brewery_all
where countries ='Nigeria' and BRANDS in ('budweiser') and years='2019'
GROUP BY brands,countries,region, years
ORDER BY total_quantity;

/*SECTION C Solutions
1. Country with the highest consumption of beer*/
select DISTINCT(countries), brands,max(QUANTITY) as total_quantity 
from brewery_all
where BRANDS in ('eagle lager','hero','trophy','castle lite','budweiser')
GROUP BY countries,brands
ORDER BY total_quantity DESC
limit 1;

/*2. Highest sales personnel of Budweiser in Senegal*/
select sales_rep,brands,countries, max(QUANTITY) as total_quantity 
from brewery_all
where brands='budweiser' and countries='Senegal'
GROUP BY brands,countries,sales_rep
ORDER BY total_quantity DESC;

/*3. Country with the highest profit of the fourth quarter in 2019*/
select sum(profit) as total_profits,months,years,countries
from brewery_all
where years ='2019' and months in ('October','November','December')
GROUP BY months,years,countries
ORDER BY total_profits DESC;