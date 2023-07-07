USE PNTL_20DB
GO
EXEC sp_help 'Trainees'
GO
INSERT INTO Trainees(name, email,contact) VALUES('kamal','ka@gmail.com','01912312312')
GO
select * from Trainees
go
USE master
go
--create database with file details
create database sqlstore
on
(
	name='sqlStoreData_1',
	filename='D:\C# from BITM\Class_001_01\Class_001\sqlStoreData_1.mdf',
	size=2mb,
	maxsize=50mb,
	filegrowth=10%
)
log on
(
	name='sqlStoreLog_1',
	filename='D:\C# from BITM\Class_001_01\Class_001\sqlStoreLog_1.ldf',
	size=2mb,
	maxsize=50mb,
	filegrowth=1mb
)
go
exec sp_helpdb 'sqlstore'
go
