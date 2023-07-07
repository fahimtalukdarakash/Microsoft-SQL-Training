use PNTL_20_DB
go
--scalar function
create table homeSales
(
	[date] datetime default getdate(),
	itemSold varchar(30) not null,
	unitPrice money not null,
	quantity int not null,
	discountPercent float default .05
)
go
insert into homeSales values
('2020-12-12','rice pack', 450.00,3,.05),
('2020-12-01','dal pack', 120.00,3,.05),
('2020-12-05','wash power', 45.00,10,.10),
('2020-12-11','noodles', 360.00,3,.05),
('2020-12-10','baking soda', 450.00,3,.05),
('2020-12-13','tea bags', 320.00,3,.03),
('2020-12-19','v.oil', 150.00,3,.10)
go
select * from homeSales
go
create function fnCalCDiscount(@unitPrice money, @quantitySold int, @discountPercent float)
returns money
as
begin
	declare @discountEarned money
	set @discountEarned = @unitPrice * @quantitySold * @discountPercent
	return @discountEarned
end
go

--test
select dbo.fnCalCDiscount(5000,30,.10) 'discount'
go
create function fnCalCTotal(@year int, @month int)
returns money
as
begin
	declare @totalSales money
	select @totalSales = unitPrice * quantity * (1-discountPercent) 
	from homeSales where year([date])=@year and month([date])=@month
	return @totalSales
end
go
select dbo.fnCalCTotal(2020,12) 'Sales Dec 2020'
go
create function fnSalesSummaryOfMonth(@year int, @month int)
returns table
as
return
(
	select 
	sum(unitPrice*quantity) 'total sales',
	sum(unitPrice*quantity*discountPercent) 'total discount',
	sum(unitPrice*quantity*(1-discountPercent)) 'net amount'
	from homeSales
	where year([date])=@year and month([date])=@month
)
go
--test
select * from fnSalesSummaryOfMonth(2020,12)
go
--multi staement table valued function
create function fnSalesDetails(@year int, @month int)
returns @salesDetails table
(
	itemSold varchar(30),
	totalSales money,
	discount money,
	netAmount money
)
as 
begin
	insert into @salesDetails
	select itemSold,
	sum(unitPrice*quantity),
	sum(unitPrice*quantity*discountPercent),
	sum(unitPrice*quantity*(1-discountPercent))
	from homeSales
	where year([date])=@year and month([date])=@month
	group by itemSold
	return
end
go
--test
select * from fnSalesDetails(2020,12)
go