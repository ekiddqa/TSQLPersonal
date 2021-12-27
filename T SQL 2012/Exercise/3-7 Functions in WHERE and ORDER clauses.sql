/*
1. Write a query using the Sales.SalesOrderHeader table to display the orders placed
during 2001 by using a function. Include the SalesOrderID and OrderDate columns
in the results. 
2. Write a query using the Sales.SalesOrderHeader table listing the sales in order of
the month the order was placed and then the year the order was placed. Include
the SalesOrderID and OrderDate columns in the results.
3. 3. Write a query that displays the PersonType and the name columns from the
Person.Person table. Sort the results so that rows with a PersonType of IN, SP, or
SC sort by LastName. The other rows should sort by FirstName. Hint: Use the CASE
function. 
*/

--1
SELECT SalesOrderID, OrderDate FROM Sales.SalesOrderHeader
WHERE DATEPART(YYYY,OrderDate) = '2001';

--SELECT * FROM Sales.SalesOrderHeader ORDER BY OrderDate;

--2
SELECT SalesOrderID, OrderDate FROM Sales.SalesOrderHeader ORDER BY DATEPART(MM,OrderDate), DATEPART(YYYY, OrderDate);

--3
SELECT PersonType, FirstName, MiddleName, LastName FROM Person.Person ORDER BY
CASE WHEN PersonType IN ('IN', 'SP', 'SC') THEN LastName ELSE FirstName END;