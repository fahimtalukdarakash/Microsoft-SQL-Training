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
EXEC spProductofCategory 'Accesories'
GO