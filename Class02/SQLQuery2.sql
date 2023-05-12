CREATE DATABASE PNTL_20_DB
GO
USE PNTL_20_DB
GO
--WORK 01
CREATE TABLE Contact_1
(
	id INT NOT NULL,
	[name] VARCHAR(30),
)
GO
EXEC sp_help 'Contact_1'
GO
--Insert Data
SELECT * FROM Contact_1
GO
INSERT INTO Contact_1(id,name) VALUES(1, 'Fahim')
GO
INSERT INTO Contact_1 VALUES(2,'Kamal Hossain')
GO
INSERT INTO Contact_1 VALUES
(3,'Salam Hossain'),
(4, 'RAFIQ'),
(5, 'JAMAL')
GO

--WORK 02
CREATE TABLE products
(
	id UNIQUEIDENTIFIER NOT NULL,
	[name] VARCHAR(30)
)
GO
EXEC sp_help 'products'
GO
INSERT INTO products(id, name) VALUES(NEWID(),'MOUSE')
GO
SELECT*FROM products
GO
INSERT INTO products(id, name) VALUES(NEWID(),'KEYBOARD')
GO
SELECT LEN('9AAABE0E-34FD-4D7C-9743-5AF301C2341C')
GO

--WORK 03
CREATE TABLE books
(
	id INT NOT NULL,
	[name] VARCHAR(30) NOT NULL,
	author VARCHAR(40) NULL,
	price MONEY NULL
)
GO
SELECT * FROM books
GO
INSERT INTO books VALUES(1, 'SQL', 'JOHN SHARP', 1200.00)
GO
INSERT INTO books(id, name, price) VALUES(2,'C#',120.00)
GO
--ALTER
/*ALTER TABLE tableName
ALTER COLUMN ColumnName*/
ALTER TABLE books
ALTER COLUMN name VARCHAR(50) NOT NULL
GO
ALTER TABLE books
ALTER COLUMN author VARCHAR(40) NOT NULL
GO
UPDATE books SET author='NA' WHERE id=2
GO
ALTER TABLE books
ADD publishYear INT NULL
GO
ALTER TABLE books 
ADD edition VARCHAR(30) NOT NULL DEFAULT 'NA'
GO
--DROP
ALTER TABLE books
DROP Constraint DF__books__edition__38996AB5
GO
ALTER TABLE books
DROP COLUMN edition
GO
--Computed Column
CREATE TABLE product
(
	id INT IDENTITY PRIMARY KEY,
	[name] VARCHAR(30) NOT NULL,
	regularPrice MONEY NOT NULL,
	discount DECIMAL(4,2) NOT NULL,
	currentPrice AS regularPrice*(1-discount)
)
GO
SELECT*FROM product
GO
INSERT INTO product(name, regularPrice, discount) VALUES('P1', 500.00, 0.10)
GO
/*
	Constraint : 
	=>	PRIMARY KEY
	=>  UNIQUE KEY
	=>  FOREIGN KEY
	=>  CHECK CONSTRAINT
	=>  DEFAULT CONSTRAINT
*/
--DEFAULT CONSTRAINT
CREATE TABLE trainee
(
	id CHAR(7) NOT NULL,
	[name] VARCHAR(30) NOT NULL,
	course VARCHAR(20) NOT NULL CONSTRAINT DF_course DEFAULT 'NA',
	batchNo INT DEFAULT 20
)
GO
EXEC sp_help 'trainee'
GO
INSERT INTO trainee VALUES('1116157', 'MASUD ALAM', 'C#',20)
GO
INSERT INTO trainee(id,name) VALUES('1116158', 'MAjid')
GO
SELECT * FROM trainee
GO
--CHECK CONSTRAINT
CREATE TABLE Product2
(
	id CHAR(5) PRIMARY KEY CONSTRAINT chk_id CHECK(id LIKE 'P-[0-9][0-9][0-9]'),
	[name] VARCHAR(30) NOT NULL,
	price MONEY NOT NULL CONSTRAINT chk_price CHECK(price>0)
)
GO
SELECT * FROM Product2
GO
INSERT INTO Product2 VALUES('P-001','MOUSE',100)
GO
INSERT INTO Product2 VALUES('P-002','KEYBOARD',200)
GO
--WORK 005
CREATE TABLE machine_Log
(
	[machine-code] CHAR(3) NOT NULL,
	[acquire-date] DATE NOT NULL,
	[release-date] DATE NOT NULL, CONSTRAINT chk_acquireRelease CHECK([release-date]>[acquire-date])
)
GO
SELECT * FROM machine_Log
GO
INSERT INTO machine_Log VALUES('G11','2023-05-12','2023-05-17')
GO
INSERT INTO machine_Log VALUES('G11','2023/05/12','2023/05/18')
GO
--PRIMARY KEY CONSTRAINT
CREATE TABLE attendance
(
	traineeId CHAR(7) NOT NULL,
	[date] DATE NOT NULL,
	intime TIME NOT NULL,
	outtime TIME,
	CONSTRAINT pk_att PRIMARY KEY(traineeId, [date])
)
GO
--UNIQUE KEY CONSTRAINT
CREATE TABLE users
(
	userId INT NOT NULL IDENTITY PRIMARY KEY,
	username VARCHAR(50) NOT NULL CONSTRAINT unq_username UNIQUE,
	email VARCHAR(30) NOT NULL CONSTRAINT unq_email UNIQUE
)
GO
SELECT * FROM users
INSERT INTO users VALUES('AZMAN','AZMAN636@GMAIL.COM')
GO