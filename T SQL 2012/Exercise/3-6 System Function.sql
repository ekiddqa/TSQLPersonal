/*
1. Write a query using the HumanResources.Employee table to display the
BusinessEntityID column. Also include a CASE statement that displays “Even”
when the BusinessEntityID value is an even number or “Odd” when it is odd. Hint:
Use the modulo operator.
2. Write a query using the Sales.SalesOrderDetail table to display a value (“Under
10” or “10–19” or “20–29” or “30–39” or “40 and over” ) based on the OrderQty
value by using the CASE function. Include the SalesOrderID and OrderQty columns
in the results.
3. Using the Person.Person table, build the full names using the Title, FirstName,
MiddleName, LastName, and Suffix columns. Check the table definition to see which columns allow NULL values and use the COALESCE function on the
appropriate columns.
4. Look up the SERVERPROPERTY function in Books Online. Write a statement that
displays the edition, instance name, and machine name using this function. 
*/

--1
SELECT [BusinessEntityID], CASE WHEN [BusinessEntityID] % 2 = 1 THEN 'ODD' ELSE 'EVEN' END FROM HumanResources.Employee;

--2
SELECT SalesOrderID, OrderQty, 
CASE WHEN OrderQty < 10 THEN 'Under 10' 
WHEN OrderQty BETWEEN 10 AND 19 THEN '10-19' 
WHEN OrderQty BETWEEN 20 AND 29 THEN '20-29'
WHEN OrderQty BETWEEN 30 AND 39 THEN '30-39'
ELSE '40 and Over' END
FROM Sales.SalesOrderDetail;

--3
SELECT CONCAT(COALESCE(Title + ' ', ''), FirstName, ' ', COALESCE(MiddleName, ''), LastName, COALESCE(' ' + Suffix, ''))  FROM Person.Person;

--4
SELECT SERVERPROPERTY ( 'Edition'), SERVERPROPERTY('InstanceName'), SERVERPROPERTY('MachineName');  