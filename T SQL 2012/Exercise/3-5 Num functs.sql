/*
1. Write a query using the Sales.SalesOrderHeader table that displays the SubTotal
rounded to two decimal places. Include the SalesOrderID column in the results.
2. Modify the query from question 1 so that the SubTotal is rounded to the nearest
dollar but still displays two zeros to the right of the decimal place.
3. Write a query that calculates the square root of the SalesOrderID value from the
Sales.SalesOrderHeader table.
4. Write a statement that generates a random number between 1 and 10 each time it
is run. 
*/

--1
SELECT ROUND([SubTotal],2) FROM Sales.SalesOrderHeader;

--2
SELECT ROUND([SubTotal],0) FROM Sales.SalesOrderHeader;

--3
SELECT SQRT(SalesOrderID) FROM Sales.SalesOrderHeader;

--4
SELECT CAST((RAND()*10) AS int) + 1;