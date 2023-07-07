use Northwind
go
select p.ProductID, p.ProductName, p.UnitPrice, c.CategoryName from Products p
inner join Categories c on p.CategoryID = c.CategoryID 
order by c.CategoryName
go
select sum(p.UnitPrice) 'Total Price', c.CategoryName from Products p 
inner join Categories c on p.CategoryID=c.CategoryID
group by c.CategoryName
order by c.CategoryName
go
select sum(p.UnitPrice) 'Total Price', c.CategoryName from Products p 
inner join Categories c on p.CategoryID=c.CategoryID
group by c.CategoryName
having sum(p.UnitPrice)>300
order by c.CategoryName
go
create view vCategoryWisePrice
as
select sum(p.UnitPrice) 'Total Price', c.CategoryName from Products p 
inner join Categories c on p.CategoryID=c.CategoryID
group by c.CategoryName
having sum(p.UnitPrice)>300
go