create database PNTL_20_DB
go
use PNTL_20_DB
go
create table Contact_1
(
	id int not null,
	[name] varchar(30)
)
go
exec sp_help 'Contact_1'
go
--Insert data
select * from Contact_1
go
insert into Contact_1(id,name) values(1,'Rafat')
go
insert into Contact_1 values(2,'kamal hasan')
go
insert into Contact_1 values
(3,'salam hossain'),
(4,'jalam hossain'),
(5,'salam hossain')
go
create table products
(
	id uniqueidentifier not null,
	[name] varchar(30)
)
go
insert into products(id,name) values(newid(),'Mouse')
go
select * from products
go
insert into products(id,name) values(newid(),'Keyboard')
go
--work03
create table books
(
	id int not null,
	name varchar(30) not null,
	author varchar(40) null,
	price money null
)
go
select * from books
go
insert into books values(1,'sql','john sharp', 1200.00)
go
insert into books(id,name,price) values(2,'C#',400.00)
go
--alter
alter table books
alter column name varchar(50) not null
go
update books set author='NA' where id=2
go
alter table books
alter column author varchar(40) not null
go
alter table books
add publishYear int null
go
alter table books
add edition varchar(30) not null default 'NA'
go
--drop
alter table books
drop constraint DF__books__edition__38996AB5
go
alter table books
drop column edition
go
alter table books
add discount int not null default 10
go
--Computed column
create table product
(
	id int identity primary key,
	name varchar(30) not null,
	regularPrice money not null,
	discount decimal(4,2) not null,
	currentPrice as regularPrice*(1-discount)
)
go
select * from product
go
insert into product(name, regularPrice,discount) values('p1',500.00,0.10)
go
create table trainee
(
	id char(7) not null,
	name varchar(30) not null,
	course varchar(20) not null constraint df_course default 'NA',
	batchNo int default 20
)
go
insert into trainee values('1111222','masud alam','C#',20)
go
insert into trainee(id,name) values('1232334','alam')
go
select * from trainee
go
--check constraint
create table product2
(
	id char(5) primary key constraint chk_id check(id like 'p-[0-9][0-9][0-9]'),
	name varchar(30) not null,
	price money not null constraint chk_price check(price>0)
)
go
select * from product2
go
insert into product2 values('p-234','mouse',100)
go
create table machine_log
(
	[machine-code] char(3) not null,
	[acquire-date] date not null,
	[release-date] date not null, constraint chk_acquireRelease check([release-date]>[acquire-date])
)
go
insert into machine_log values('g11','2023-05-12','2023-05-17')
insert into machine_log values('g12','2023/05/12','2023/05/18')
go
select * from machine_log
go
create table attendance
(
	traineeId char(7) not null,
	[date] date not null,
	intime time not null,
	outtime time,
	constraint pk_att primary key(traineeId,[date])
)
go
create table users
(
	useraId int not null identity primary key,
	username varchar(50) not null constraint unk_username unique,
	email varchar(30) not null constraint unk_email unique
)
go
select * from users
go
insert into users values('azman','azman@gmail.com')