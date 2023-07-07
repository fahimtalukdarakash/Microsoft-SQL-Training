use Northwind
go
select * from vCategoryWisePrice
go
use PNTL_20_DB
go
create table trainees
(
	traineeId char(7) primary key,
	traineeName varchar(30) not null,
	trp char(4)
)
go
insert into trainees values('1116157','rafat','pntl')
insert into trainees values('1116159','rahim','ussl')
insert into trainees values('1116158','jamal','bitl')
insert into trainees values('1116147','jobbar','bazl')
insert into trainees values('1116137','salam','cssl')
go
select * from trainees
go
create view vTrainees
as 
select * from trainees
go
insert into vTrainees(traineeId,traineeName,trp) values('1000000','test','abcl')
go
exec sp_helptext 'vTrainees'
go
create table products2
(
	productId int identity primary key,
	productName varchar(40) not null,
	category varchar(40) not null,
	unitPrice money null,
	available bit default 0
)
go
insert into products2 values
('hdd 500gb','storage device',5700.00,1),
('hdd 640gb','storage device',6300.00,0),
('ssd 120gb','portable storage',2500.00,1),
('a4 tech mouse','accesories',520.00,0)
go
select * from products2
go
--procedure
create procedure spProductAll
as
select * from products2
go
--test
exec spProductAll
go
--procedure with input parameter
declare @age int
set @age=50
select @age
go
create procedure spProductsofCategory @category varchar(40)
as 
select * from products2 where category=@category
go
exec spProductsofCategory 'accesories'
go
create procedure spProductInsert @productName varchar(40),
								 @category varchar(40),
								 @price money,
								 @available bit
as
insert into products2(productName, category, unitPrice, available)
values(@productName, @category, @price,@available)
go
--test
exec spProductInsert 'Iphone','smart phone',125000.00,1
go
select * from products2
go
--returning value from a procedure
create procedure spProductInsertWithReturn @productName varchar(40),
										   @category varchar(40),
										   @price money,
										   @available bit
as
declare @productId int
insert into products2(productName, category, unitPrice, available)
values(@productName, @category, @price,@available)
select @productId=IDENT_CURRENT('products2')
return @productId
go

declare @idNo int
exec @idNo=spProductInsertWithReturn 'pendrive','accesories',1800.00,1
print 'new product inserted with Id no: '+str(@idNo)
go
--
create procedure spProductInsertWithDefaultaValues @productName varchar(40),
												   @category varchar(40)='Misc Parts',
												   @price money=null,
												   @available bit=0
as
insert into products2(productName, category, unitPrice, available)
values(@productName, @category, @price,@available)
go
exec spProductInsertWithDefaultaValues @productName='Laptop Cooler'
go
exec spProductAll
go
exec spProductInsertWithDefaultaValues 'Laptop Cooler2'
go
--output parameter
create procedure spProductInsertWithOutParam @productName varchar(40),
											 @category varchar(40),
											 @price money,
											 @available bit,
											 @id int output
as
insert into products2(productName, category, unitPrice, available)
values(@productName, @category, @price,@available)
select @id=IDENT_CURRENT('products2')
go
declare @productId int
exec spProductInsertWithOutParam 'ddr3 4gb ram','memory',2000.00,1,@productId output
select @productId 'new id'
go
--Applying procedural integrity
create procedure spProductInsertWithCheckPrice @productName varchar(40),
											   @category varchar(40),
											   @price money,
											   @available bit
as
if @price>0
	insert into products2(productName, category, unitPrice, available)
	values(@productName, @category, @price,@available) 
else
begin
	raiserror('Price cannot be 0 or -ve',10,1)
	return
end
go
--test
exec spProductInsertWithCheckPrice 'bluetooth adapter','accesories',100,1
go