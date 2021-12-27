/*1. Write a query that displays all the products along with the SalesOrderID even if an
order has never been placed for that product. Join to the Sales.SalesOrderDetail
table using the ProductID column.
2. Change the query written in step 1 so that only products that have not been
ordered show up in the query.
3. Write a query that returns all the rows from the Sales.SalesPerson table joined to
the Sales.SalesOrderHeader table along with the SalesOrderID column even if no
orders match. Include the SalesPersonID and SalesYTD columns in the results.
4. Change the query written in question 3 so that the salesperson’s name also
displays from the Person.Person table.
5. The Sales.SalesOrderHeader table contains foreign keys to the Sales.CurrencyRate
and Purchasing.ShipMethod tables. Write a query joining all three tables, and
make sure it contains all rows from Sales.SalesOrderHeader. Include the
CurrencyRateID, AverageRate, SalesOrderID, and ShipBase columns.
www.it-ebooks.info
CHAPTER 4  QUERYING MULTIPLE TABLES
153
6. Write a query that returns the BusinessEntityID column from the
Sales.SalesPerson table along with every ProductID from the
Production.Product table.
7. Starting with the query written in Listing 4-13, join the table a to the
Person.Person table to display the employee’s name. The EmployeeID column
joins the BusinessEntityID column. Note that you will need to recreate the
#Employee table. 
*/

--1
SELECT p.[ProductID]
      ,p.[Name], s.SalesOrderID
  FROM [Production].[Product] p left join Sales.SalesOrderDetail s on p.ProductID = s.ProductID;

GO

--2
SELECT p.[ProductID]
      ,p.[Name], s.SalesOrderID
  FROM [Production].[Product] p left join Sales.SalesOrderDetail s on p.ProductID = s.ProductID WHERE s.ProductID is NUll;

--3
SELECT soh.SalesPersonID, sp.SalesYTD, soh.SalesOrderID FROM Sales.SalesPerson sp left join Sales.SalesOrderHeader soh on sp.BusinessEntityID = soh.SalesPersonID;

--4
SELECT soh.SalesPersonID, CONCAT(p.FirstName, COALESCE(p.MiddleName,''), ' ', p.LastName) AS Name, sp.SalesYTD, soh.SalesOrderID FROM Sales.SalesPerson sp left join Sales.SalesOrderHeader soh on sp.BusinessEntityID = soh.SalesPersonID
left join Person.Person p on  sp.BusinessEntityID = p.BusinessEntityID ;

