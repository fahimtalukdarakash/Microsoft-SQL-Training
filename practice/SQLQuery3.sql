use PNTL_20_DB
go
create table departments
(
	departmentId int identity primary key,
	departmentName nvarchar(50) not null
)
go
create table employees
(
	employeeId int identity primary key,
	employeeName varchar(50) not null,
	phone varchar(20) not null,
	departmentId int not null references departments(departmentId)
)
go
insert into departments values('admin')
insert into departments values('hr')
insert into departments values('it')
insert into departments values('production')
go
select * from departments
go
insert into employees values('rafat','019238343294',1)
go
select * from employees
go
insert into employees values('rafiq','019238343294',2)
insert into employees values('jamal','019238343294',1)
insert into employees values('nadir','019238343294',2)
go
select e.employeeId, e.employeeName, e.phone, d.departmentName from employees e
inner join departments d on e.departmentId=d.departmentId

go
select e.*, d.* from employees e 
left join departments d on e.departmentId = d.departmentId
go
select e.*, d.* from employees e 
right join departments d on e.departmentId = d.departmentId
go
