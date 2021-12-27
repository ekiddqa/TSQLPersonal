--1
SELECT [BusinessEntityID], [LoginID], JobTitle
FROM HumanResources.Employee
WHERE JobTitle = 'Research and Development Engineer';

--2
SELECT FirstName, MiddleName, LastName, [BusinessEntityID]
FROM Person.Person
WHERE MiddleName = 'J';

--3
USE [AdventureWorks2012_CS]
GO

SELECT [ProductID]
      ,[StartDate]
      ,[EndDate]
      ,[ModifiedDate]
  FROM [Production].[ProductCostHistory]
  WHERE ModifiedDate = '2005-06-17';

GO

--4
SELECT [BusinessEntityID], [LoginID], JobTitle
FROM HumanResources.Employee
WHERE JobTitle != 'Research and Development Engineer';

--5
SELECT [BusinessEntityID]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
      ,[ModifiedDate]
  FROM [Person].[Person]
  WHERE ModifiedDate > '2005-12-29 23:59:59';

GO

--6
SELECT [BusinessEntityID]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
      ,[ModifiedDate]
  FROM [Person].[Person]
  WHERE ModifiedDate NOT BETWEEN '2005-12-29 00:00:00' AND '2005-12-29 23:59:59';

  --7
  SELECT [BusinessEntityID]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
      ,[ModifiedDate]
  FROM [Person].[Person]
  WHERE DATEPART(yy, ModifiedDate) = '2000';

  --8
   SELECT [BusinessEntityID]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
      ,[ModifiedDate]
  FROM [Person].[Person]
  WHERE ModifiedDate NOT BETWEEN '2005-12-01' AND '2005-12-31';

  --9
  -- WHERE clause filters out results, making them more relivent.