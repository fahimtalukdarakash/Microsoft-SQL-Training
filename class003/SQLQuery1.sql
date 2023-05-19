/*
	Relationship allow you to the connections between different database tables
*/
CREATE TABLE departments
(
	departmentId INT IDENTITY PRIMARY KEY,
	departmentName NVARCHAR(50) NOT NULL
)
GO
CREATE TABLE Employees
(
	employeeId INT IDENTITY PRIMARY KEY,
	employeeName VARCHAR(50) NOT NULL,
	phone VARCHAR(20) NOT NULL,
	departmentId INT NOT NULL REFERENCES departments(departmentId)
)
GO
INSERT INTO departments VALUES('Admin')
INSERT INTO departments VALUES('HR')
INSERT INTO departments VALUES('IT')
INSERT INTO departments VALUES('Production')
GO
SELECT * FROM departments
GO
INSERT INTO Employees VALUES('Rafat Khan','094304522345',1)
INSERT INTO Employees VALUES('Rafiq Khan','349523845348',2)
INSERT INTO Employees VALUES('Jamal khan','049568345303',1)
INSERT INTO Employees VALUES('Nadir Khan','238453495090',2)
GO
SELECT * FROM Employees
GO
/*
	
*/
SELECT * FROM Employees WHERE departmentId=1
GO
SELECT e.employeeId, e.employeeName, e.phone, d.departmentName FROM Employees e INNER JOIN departments d ON e.departmentId=d.departmentId
WHERE e.employeeId=1
GO
SELECT e.employeeId, e.employeeName, e.phone, d.departmentName FROM Employees e INNER JOIN departments d ON e.departmentId=d.departmentId
GO
SELECT e.employeeId, e.employeeName, e.phone, d.departmentName FROM Employees e LEFT JOIN departments d ON e.departmentId=d.departmentId
GO
SELECT e.employeeId, e.employeeName, e.phone, d.departmentName FROM Employees e RIGHT JOIN departments d ON e.departmentId=d.departmentId
GO
SELECT e.employeeId, e.employeeName, e.phone, d.departmentName FROM Employees e FULL OUTER JOIN departments d ON e.departmentId=d.departmentId
GO
SELECT e.employeeId, e.employeeName, e.phone, d.departmentName FROM Employees e CROSS JOIN departments d
GO

/*
	CREATE VIEW viewName
	AS 
	SELECT Statement
*/
CREATE TABLE trainees
(
	traineeId CHAR(7) PRIMARY KEY,
	traineeName VARCHAR(30) NOT NULL,
	tsp CHAR(4)
)
GO
INSERT INTO trainees VALUES('1116157','Rafat Khan', 'pntl')
INSERT INTO trainees VALUES('1116158','Rahim Khan', 'ussl')
INSERT INTO trainees VALUES('1116159','Jamal Khan', 'BITM')
INSERT INTO trainees VALUES('1116160','Jobbar Khan', 'BAZL')
INSERT INTO trainees VALUES('1116161','Salam Khan', 'CSSL')
GO
SELECT * FROM trainees
GO
--view
CREATE VIEW vTrainees
AS 
SELECT * FROM trainees
GO
INSERT INTO vTrainees(traineeId,traineeName,tsp) VALUES('110000','Test','ABCL')
GO
EXEC sp_helptext 'vTrainees'
GO
--with encryption
ALTER VIEW vTrainees
WITH ENCRYPTION
AS
SELECT traineeId,traineeName,tsp FROM trainees
GO
--with schema Binding
ALTER VIEW vTrainees
WITH ENCRYPTION,SCHEMABINDING
AS
SELECT traineeId,traineeName,tsp FROM dbo.trainees
GO
DROP TABLE trainees --schema binding korle drop korte parbo na
GO

