--CREATE Object objectName
CREATE DATABASE PNTL_20DB
GO
USE PNTL_20DB
GO
CREATE TABLE Trainees
(
	id INT IDENTITY PRIMARY KEY,
	[name] VARCHAR(50) NOT NULL,
	email VARCHAR(30) NULL,
	contact VARCHAR(20) NOT NULL
)
GO
INSERT INTO Trainees([name],email,contact) VALUES('kamal','ka@gmail.com','0125466548')
GO
SELECT * FROM Trainees
GO
EXEC sp_helpdb 'PNTL_20DB'
GO

USE master
GO
--Create database with file details
CREATE DATABASE sqlStore
ON
(
	name='sqlStoreData_1',
	filename='E:\dot net course_fahim\M_01_SQL\class001\sqlStoreData_1.mdf',
	size=2mb,
	maxsize=50mb,
	filegrowth=10%
)
LOG ON
(
	name='sqlStoreLog_1',
	filename='E:\dot net course_fahim\M_01_SQL\class001\sqlStoreLog_1.ldf',
	size=2mb,
	maxsize=50mb,
	filegrowth=10%
)
GO
EXEC sp_helpdb 'sqlStore'
GO
/*
	DDL(data definition language)
		-CREATE, ALTER, DROP
	DML(data Manipulation Language)
		-INSERT, UPDATE, DELETE
*/