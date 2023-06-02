USE PNTL_20_DB
GO
/*
	Type of user define function's:
	=>Scalar function :return a single value
		
	=>Table-valued Function 
		a. Inline Table Valued Function: Contain a single statement
		b. Multi-Statement Table Valued Function: Contain a multiple statement

	Syntax(Scalar):
	CREATE FUNCTION function-name(param1, param2,....)
	RETURNS dataType
	AS
	BEGIN
		Sql Statement...

		RETURN
	END
	GO
*/
CREATE TABLE HomeSales
(
	[date] DATETIME DEFAULT GETDATE(),
	itemSold VARCHAR(30) NOT NULL,
	unitPrice Money NOT NULL,
	quantity INT NOT NULL,
	discountPercent FLOAT DEFAULT .05
)
GO
INSERT INTO HomeSales VALUES
('2020-12-12', 'Rice Pack', 450.00,3,.05),
('2020-12-01', 'Dal Pack', 120.00,3,.05),
('2020-12-05', 'Wash Power', 45.00,10,.10),
('2020-12-11', 'Noodles', 450.00,3,.05),
('2020-12-10', 'Baking Soda', 450.00,3,.05),
('2020-12-13', 'Tea Bags', 320.00,3,.03),
('2020-12-19', 'V. oil', 150.00,3,.10)
GO
SELECT * FROM HomeSales
GO
CREATE FUNCTION fnCalCDiscount(@unitPrice MONEY, @quantitySold INT, @discountPercent FLOAT)
RETURNS MONEY
AS
BEGIN
	DECLARE @discountEarned MONEY
	SET @discountEarned=@unitPrice*@quantitySold*@discountPercent
	RETURN @discountEarned
END
GO
--test
SELECT dbo.fnCalCDiscount(5000,30,.10) 'Discount'
GO
--Ex-2
CREATE FUNCTION fnCalCTotal2(@year INT, @month INT)
RETURNS MONEY
AS
BEGIN
	DECLARE @totalSales MONEY
	SELECT @totalSales= unitPrice*quantity*(1-discountPercent) 
	FROM HomeSales WHERE YEAR([date])=@year AND MONTH([date])=@month
	RETURN @totalSales
END
GO
--test
SELECT dbo.fnCalCTotal2(2020,12) 'Sales Dec 2020'
GO
--Inline Table-valued Function
CREATE FUNCTION fnSalesSummaryofMonth(@year INT, @month INT)
RETURNS TABLE 
AS
RETURN 
(
	SELECT 
	SUM(unitPrice*quantity) 'Total Sales',
	SUM(unitPrice*quantity*discountPercent) 'Total Discount',
	SUM(unitPrice*quantity*(1-discountPercent)) 'Net Amount'
	FROM HomeSales 
	WHERE YEAR([date])=@year AND MONTH([date])=@month
)
GO
--test
SELECT * FROM fnSalesSummaryofMonth(2020,12)
GO
--Multi-Statement Table Valued Function
CREATE FUNCTION fnSalesDetails(@year INT, @month INT)
RETURNS @salesDetails TABLE
(
	itemSold VARCHAR(30),
	totalSales MONEY,
	discount MONEY,
	netAmount MONEY
)
AS
BEGIN
	INSERT INTO @salesDetails
	SELECT itemSold,
	SUM(unitPrice*quantity),
	SUM(unitPrice*quantity*discountPercent),
	SUM(unitPrice*quantity*(1-discountPercent))
	FROM HomeSales 
	WHERE YEAR([date])=@year AND MONTH([date])=@month
	GROUP BY itemSold
	RETURN
END
GO
--test
SELECT * FROM fnSalesDetails(2020,12)
GO

