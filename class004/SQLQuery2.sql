/*
	Store Procedure:
		A store procedure is a set of SQL statements
		stored as an object and which is created as a unit

		syntax:
			CREATE PROCEDURE procedureName param1, param2, ...
			AS
			SQL Statement
			----
			---
			GO
*/
CREATE TABLE products
(
	productId INT IDENTITY PRIMARY KEY,
	productName VARCHAR(40) NOT NULL,
	category VARCHAR(40) NOT NULL,
	unitPrice MONEY NULL,
	available BIT DEFAULT 0
)
GO
INSERT INTO products VALUES
('HDD 500GB','Storage Device',5700.00,1),
('HDD 640GB','Storage Device',6300.00,0),
('SSD 120GB','Portable Storage',2500.00,1),
('A4 Tech Mouse','Accesories',570.00,0)
GO
SELECT * FROM products
GO
--sp: 1
CREATE PROCEDURE spProductAll
AS
SELECT * FROM products
GO
--Test
EXEC spProductAll
GO
--Input Parameter
DECLARE @age INT
SET @age=50
SELECT @age
GO

CREATE PROC spProductofCategory @category VARCHAR(40)
AS
SELECT * FROM products WHERE category=@category
GO

--test
USE [PNTL_20_DB]
GO
EXEC spProductofCategory 'Accesories'
GO
--procedure with input parameter
CREATE PROC spProductInsert @productName VARCHAR(40),
							@category VARCHAR(40),
							@price MONEY,
							@available BIT
AS
INSERT INTO products(productName, category, unitPrice, available)
VALUES(@productName,@category,@price,@available)
GO
--test
EXEC spProductInsert 'iPhone', 'Smart Phone', 125000.00,1
GO
SELECT * FROM products
GO
--Returining Value from a procedure
CREATE PROC spProductInsertWithReturn @productName VARCHAR(40),
									  @category VARCHAR(40),
							          @price MONEY,
							          @available BIT
AS
DECLARE @productId INT
INSERT INTO products(productName, category, unitPrice, available)
VALUES(@productName,@category,@price,@available)
SELECT @productId= IDENT_CURRENT('products')
RETURN @productId
GO
--test
DECLARE @idNo INT
EXEC @idNo=spProductInsertWithReturn 'Pendrive', 'Accessories', 1250.00,1
PRINT 'New Product Inserted with Id no: '+STR(@idNo)
GO
--Using Default Value of parameter
CREATE PROC spProductInsertWithDefaultValues @productName VARCHAR(40),
											 @category VARCHAR(40)='Misc Parts',
											 @price MONEY=NULL,
											 @available BIT=0
AS
INSERT INTO products(productName, category, unitPrice, available)
VALUES(@productName,@category,@price,@available)
GO
--test
EXEC spProductInsertWithDefaultValues @productName='Laptop Cooler'
GO
EXEC spProductAll
GO
--OUTPUT Parameter
CREATE PROC spProductInsertWithOutParam @productName VARCHAR(40),
										@category VARCHAR(40),
										@price MONEY,
										@available BIT,
										@id INT OUTPUT
AS
INSERT INTO products(productName, category, unitPrice, available)
VALUES(@productName,@category,@price,@available)
SELECT @id=IDENT_CURRENT('products')
GO
--test
DECLARE @productId INT
EXEC spProductInsertWithOutParam 'DDR3 4GB RAM','Memory Module', 2000.00,1,@productId OUTPUT
SELECT @productId 'New Id'
GO
--Applying Procedural Intigrity
CREATE PROC spProductInsertWithCheckPrice @productName VARCHAR(40),
										  @category VARCHAR(40),
										  @price MONEY,
										  @available BIT
AS
IF @price>0
   INSERT INTO products(productName, category, unitPrice, available)
   VALUES(@productName,@category,@price,@available)
ELSE
BEGIN
   RAISERROR('Price can not be 0 or negetive', 10,1)
   RETURN
END
GO
--test
EXEC spProductInsertWithCheckPrice 'Bluetooth Adapter','Accessories',10,1
GO