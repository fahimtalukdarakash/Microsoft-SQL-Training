use PNTL_20_DB
go
create table tblTest
(
	c1 int,
	c2 varchar(5),
)
go
insert into tblTest values
(1,'v1'),
(2,'v2')
go
select * from tblTest
go
create trigger trUpdateDelete
on tblTest
after update,delete
as
begin
	print ' update or delete not possible!!!'
	rollback transaction
end
go
--test
update tblTest set c2='Az' where c1=1
go
create table product3
(
	pId int primary key,
	pName varchar(30),
	price money,
	stock int default 0
)
go
create table stockIn
(
	id int identity primary key,
	date datetime default getdate(),
	pId int references product3(pId),
	qunatity int
)
go
select * from product3
go
insert into product3 values
(1,'Mouse',150,0),
(2,'keyboard',250,0),
(3,'monitor',8000,0)
go

create trigger trStockIn
on stockIn
for insert
as
begin
	declare @i int --for pId
	declare @q int --for quantity
	select @i=pId,@q=qunatity from inserted 
	update product3 set stock = stock+@q
	where pId=@i
end
go
insert into stockIn(pId,qunatity) values(1,10)
go
select * from stockIn
go
insert into stockIn(pId,qunatity) values(3,15)
go
create table sales
(
	id int identity primary key,
	date datetime default getdate(),
	pId int references product3(pId),
	qunatity int
)
go
create trigger trStockOut
on sales
for insert 
as
begin
	declare @i int --for pId
	declare @q int --for quantity
	select @i=pId, @q=qunatity from inserted
	update product3 set stock = stock-@q
	where pId = @i
end
go
insert into sales(pId,qunatity) values(1,3)
go
--instead of trigger
create table sales2
(
	id int primary key identity,
	product varchar(30),
	price money,
	quantity int,
	amount as price*quantity
)
go
insert into sales2 values('mouse',250,10)
go
select * from sales2
go
create view vSales
as 
select id,product,price,quantity,amount from sales2
go
create trigger trSalesInsert
on vSales
instead of insert
as
begin
	insert into sales2(product,price,quantity)
	select product,price,quantity from inserted
end
go
select * from vSales
go
insert into vSales values(9999,'keyboard',1200,10,0)
go