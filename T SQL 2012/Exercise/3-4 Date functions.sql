/*
1. Write a query that calculates the number of days between the date an order was
placed and the date that it was shipped using the Sales.SalesOrderHeader table.
Include the SalesOrderID, OrderDate, and ShipDate columns.
2. Write a query that displays only the date, not the time, for the order date and ship
date in the Sales.SalesOrderHeader table.
3. Write a query that adds six months to each order date in the
Sales.SalesOrderHeader table. Include the SalesOrderID and OrderDate columns.
4. Write a query that displays the year of each order date and the numeric month of
each order date in separate columns in the results. Include the SalesOrderID and
OrderDate columns.
5. Change the query written in question 4 to display the month name instead. 
*/

--1
SELECT DATEDIFF(d, [OrderDate],[ShipDate]), SalesOrderID, OrderDate, ShipDate FROM Sales.SalesOrderHeader;

--2
SELECT FORMAT([OrderDate], 'yyyy-MM-dd'), FORMAT([ShipDate], 'yyy-MM-dd') FROM Sales.SalesOrderHeader;

--3
SELECT DATEADD(M,6,[OrderDate]), [SalesOrderID], OrderDate FROM Sales.SalesOrderHeader;

--4
SELECT DATEPART(YY,[OrderDate]), DATEPART(M, [OrderDate]), [SalesOrderID], OrderDate FROM Sales.SalesOrderHeader;

--5
SELECT DATEPART(YY,[OrderDate]), DATENAME(M, [OrderDate]), [SalesOrderID], OrderDate FROM Sales.SalesOrderHeader;