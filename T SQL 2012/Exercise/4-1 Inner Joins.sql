/*
1. The HumanResources.Employee table does not contain the employee names. Join
that table to the Person.Person table on the BusinessEntityID column. Display the
job title, birth date, first name, and last name.
2. The customer names also appear in the Person.Person table. Join the
Sales.Customer table to the Person.Person table. The BusinessEntityID column in
the Person.Person table matches the PersonID column in the Sales.Customer
table. Display the CustomerID, StoreID, and TerritoryID columns along with the
name columns.
3. Extend the query written in question 2 to include the Sales.SalesOrderHeader
table. Display the SalesOrderID column along with the columns already specified.
The Sales.SalesOrderHeader table joins the Sales.Customer table on CustomerID.
4. Write a query that joins the Sales.SalesOrderHeader table to the Sales.SalesPerson
table. Join the BusinessEntityID column from the Sales.SalesPerson table to the
SalesPersonID column in the Sales.SalesOrderHeader table. Display the
SalesOrderID along with the SalesQuota and Bonus.
5. Add the name columns to the query written in step 4 by joining on the
Person.Person table. See whether you can figure out which columns will be used
to write the join.
6. The catalogue description for each product is stored in the
Production.ProductModel table. Display the columns that describe the product
such as the color and size, along with the catalogue description for each product.
7. Write a query that displays the names of the customers along with the product
names that they have purchased. Hint: Five tables will be required to write this
query!
*/

--1
SELECT JobTitle, BirthDate, FirstName, LastName FROM HumanResources.Employee AS hr JOIN Person.Person AS p ON hr.BusinessEntityID = p.BusinessEntityID; 

--2
SELECT CustomerID, StoreID, TerritoryID, LastName, MiddleName, FirstName FROM Sales.Customer AS c JOIN Person.Person p ON  c.PersonID = p.BusinessEntityID;

--3
SELECT c.CustomerID, StoreID, c.TerritoryID, LastName, MiddleName, FirstName FROM Sales.Customer AS c JOIN Person.Person p ON  c.PersonID = p.BusinessEntityID 
JOIN Sales.SalesOrderHeader soh ON soh.CustomerID = c.CustomerID;

--4
SELECT SalesOrderID, SalesQuota, Bonus FROM Sales.SalesOrderHeader soh JOIN Sales.SalesPerson sp on sp.BusinessEntityID = soh.SalesPersonID

--5
SELECT SalesOrderID, SalesQuota, Bonus FROM Sales.SalesOrderHeader soh JOIN Sales.SalesPerson sp on sp.BusinessEntityID = soh.SalesPersonID join Person.Person p ON p.BusinessEntityID = sp.BusinessEntityID;

--6
SELECT Color, Size, CatalogDescription FROM Production.ProductModel pm JOIN Production.Product p ON pm.ProductModelID = p.ProductID;

--7
SELECT FirstName, MiddleName LastName, pr.Name 
FROM Person.Person p 
JOIN Sales.Customer c on p.BusinessEntityID = c.PersonID 
JOIN Sales.SalesOrderHeader h on h.CustomerID = c.CustomerID 
join Sales.SalesOrderDetail d on d.SalesOrderID = h.SalesOrderID 
join Production.Product pr on pr.ProductID = d.ProductID;
