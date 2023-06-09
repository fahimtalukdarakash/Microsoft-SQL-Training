/*
	Trigger:
	A trigger is a special kinds of stored procedure that responds to specific events.
	type of trigger:
	1. DDL Trigger
		CREATE, ALTER, DROP
	2. DML Trigger
		INSERT, UPDATE, DELETE
			DML Trigger two types:
				1. After trigger
				2. Instead of Trigger
	Syntax:
	FOR Trigger(always table):
	CREATE TRIGGER trigger-name
	ON table-name
	FOR/AFTER INSERT/UPDATE/DELETE/ei tintar shb gula
	AS
	BEGIN
	.......
	END
	GO
*/
USE PNTL_20_DB
GO
CREATE TABLE tblTest
(
	c1 INT,
	c2 VARCHAR(5)
)
GO
INSERT INTO tblTest VALUES
(1, 'V1'),
(2, 'V2')
GO
SELECT * FROM tblTest
GO
--ex_01:
CREATE TRIGGER trUpdateDelete
ON tblTest
FOR UPDATE,DELETE
AS
BEGIN
	PRINT 'Update or delete not possible!!!'
	ROLLBACK TRANSACTION
END
GO
--test
UPDATE tblTest SET c2='Az' WHERE c1=1
GO

CREATE TABLE product
(
	pId INT PRIMARY KEY,
	pNAME VARCHAR(30),
	price MONEY,
	stock INT DEFAULT 0
)
GO
CREATE TABLE stockIn
(
	id INT IDENTITY PRIMARY KEY,
	date DATETIME DEFAULT GETDATE(),
	pId INT REFERENCES product(pId),
	quantity INT
)
GO
SELECT * FROM product
GO
INSERT INTO product VALUES 
(1,'Mouse', 150, 0),
(2, 'Keyboard',250, 0),
(3, 'Monitor',8000,0)
GO
--Ex-02
CREATE TRIGGER trStockIn
ON stockIn
FOR INSERT 
AS
BEGIN
	DECLARE @i INT --for pId
	DECLARE @q INT --for quantity
	SELECT @i=pId,@q=quantity FROM inserted

	UPDATE product SET stock=stock+@q
	WHERE pId=@i
END
GO
--Test
SELECT * FROM product
SELECT * FROM stockIn
GO
INSERT INTO stockIn(pId,quantity) VALUES(1,20)
INSERT INTO stockIn(pId,quantity) VALUES(3,20)
GO

--Instead of Trigger
CREATE TABLE sales
(
	id INT PRIMARY KEY IDENTITY,
	product VARCHAR(30),
	price MONEY,
	quantity INT,
	amount AS price*quantity
)
GO
INSERT INTO sales VALUES
('Mouse',250,10)
GO
SELECT * FROM sales
GO
CREATE VIEW vSales
AS
SELECT id,product,price,quantity,amount FROM sales
GO
--EX:02
CREATE TRIGGER trSalesInsert
ON vSales
INSTEAD OF INSERT 
AS
BEGIN
	INSERT INTO sales(product,price,quantity)
	SELECT product,price,quantity FROM inserted
END
GO
SELECT * FROM vSales
GO
INSERT INTO vSales VALUES(9999,'Keyboard',1200,10,0)