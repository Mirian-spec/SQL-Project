-- 1. Print details of shipments (sales) where amounts are > 2,000 and boxes are <100?

select * from sales
where Amount > 2000 and Boxes < 100;

-- 2. How many shipments (sales) each of the sales persons had in the month of January 2022?

select p.Salesperson, count(*) as 'Shipment count'
from sales as s
join people as p on p.SPID= s.SPID
where s.SaleDate between '2022-1-1' and '2022-1-31'
group by p.Salesperson;

-- 3. Which product sells more boxes? Milk Bars or Eclairs?

select pr.product, sum(boxes) as 'Total Box sale'
from sales as s
join products as pr on pr.PID=s.PID
where pr.product in ('Milk Bars', 'Eclairs')
group by pr.product;

-- 4. Which product sold more boxes in the first 7 days of February 2022? Milk Bars or Eclairs?

select pr.product, sum(boxes) as 'Total Box sale'
from sales as s
join products as pr on pr.PID=s.PID
where pr.product in ('Milk Bars', 'Eclairs')
and s.SaleDate between '2022-2-1' and '2022-2-7'
group by pr.product;

-- 5. Which shipments had under 100 customers & under 100 boxes? Did any of them occur on Wednesday?

select * from sales 
where Customers < 100 and Boxes < 100;


select *,
		case	 when weekday(SaleDate) = 2 then 'Wednesday Shipment'
			else '' 
		end as 'W shipment'
from sales
where Customers < 100 and Boxes < 100;

-- 6. What are the names of salespersons who had at least one shipment (sale) in the first 7 days of January 2022?

select distinct p.Salesperson
from sales as s
join people as p on p.SPID=s.SPID
where s.SaleDate between '2022-1-1' and '2022-1-7';

-- 7. Which salespersons did not make any shipments in the first 7 days of January 2022?

select p.salesperson
from people p
where p.spid not in
(select distinct s.spid from sales s where s.SaleDate between ‘2022-1-1’ and ‘2022-1-7’);

-- 8. How many times we shipped more than 1,000 boxes in each month?

select year(SaleDate) 'Year', month(SaleDate) 'Month', count(*) as 'No of times more than 1k boxes was shipped'
from sales
where Boxes > 1000
group by year(SaleDate), month(SaleDate)
order by year(SaleDate), month(SaleDate);

-- 9. Did we ship at least one box of ‘After Nines’ to ‘New Zealand’ on all the months?


set @product_name = 'After Nines';
set @country_name = 'New Zealand';

select year(saledate) 'Year', month(saledate) 'Month',
if(sum(boxes)>1, 'Yes','No') 'Status'
from sales s
join products pr on pr.PID = s.PID
join geo g on g.GeoID=s.GeoID
where pr.Product = @product_name and g.Geo = @country_name
group by year(saledate), month(saledate)
order by year(saledate), month(saledate);

 -- 10. India or Australia? Who buys more chocolate boxes on a monthly basis?

select year(saledate) 'Year', month(saledate) 'Month',
sum(CASE WHEN g.geo='India' = 1 THEN boxes ELSE 0 END) 'India Boxes',
sum(CASE WHEN g.geo='Australia' = 1 THEN boxes ELSE 0 END) 'Australia Boxes'
from sales s
join geo g on g.GeoID=s.GeoID
group by year(saledate), month(saledate)
order by year(saledate), month(saledate);


