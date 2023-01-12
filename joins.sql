-- join in SQL

select * from sales;

select * from people;

select s.SaleDate, s.Amount, p.Salesperson, s.SPID, p.SPID
from sales as s
join people p on p.SPID = s.SPID;

select * from products;

select s.SaleDate, s.Amount, pr.Product
from sales s
left join products pr on pr.PID=s.PID;

select s.SaleDate, s.Amount, p.Salesperson, p.Team, pr.Product
from sales s
join people p on p.SPID=s.SPID
join products pr on pr.PID=s.PID;

select s.SaleDate, s.Amount, p.Salesperson, p.Team, pr.Product
from sales s
join people p on p.SPID=s.SPID
join products pr on pr.PID=s.PID
where s.Amount < 500
and p.Team = 'Delish';

select s.SaleDate, s.Amount, p.Salesperson, p.Team, pr.Product
from sales s
join people p on p.SPID=s.SPID
join products pr on pr.PID=s.PID
where s.Amount < 500
and p.Team = '';

select s.SaleDate, s.Amount, p.Salesperson, p.Team, pr.Product, g.Geo
from sales s
join people p on p.SPID=s.SPID
join products pr on pr.PID=s.PID
join geo g on g.GeoID=s.GeoID
where s.Amount < 500
and p.Team = ''
and g.Geo in ('Indian', 'New Zealand')
order by SaleDate;

select * from geo;

