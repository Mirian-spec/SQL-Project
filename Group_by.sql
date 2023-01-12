-- Group by in SQL

select GeoID, sum(Amount), avg(Amount), sum(boxes)
from sales
group by GeoID;

select g.Geo, sum(Amount), avg(Amount), sum(boxes)
from sales s
join geo g on s.GeoID=g.GeoID
group by g.Geo;

select p.Team, pr.product, sum(Amount), sum(boxes)
from sales s
join people p on p.SPID=s.SPID
join products pr on pr.PID=s.PID
group by p.Team, pr.product;

select p.Team, pr.product, sum(Amount), sum(boxes)
from sales s
join people p on p.SPID=s.SPID
join products pr on pr.PID=s.PID
where p.Team <> ''
group by p.Team, pr.product
order by p.Team, pr.product;

select pr.Product, sum(s.Amount) as 'Total Amount' 
from sales s
join products pr on pr.PID=s.PID
group by pr.Product
order by `Total Amount` desc;

select pr.Product, sum(s.Amount) as 'Total Amount' 
from sales s
join products pr on pr.PID=s.PID
group by pr.Product
order by `Total Amount` desc
limit 10;

