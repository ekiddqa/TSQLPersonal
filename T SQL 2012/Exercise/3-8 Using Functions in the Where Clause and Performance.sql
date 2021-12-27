/*
1. Type in and execute the following code. View the execution plans once query
execution completes, and explain whether one query performs better than the
other and why.
USE AdventureWorks2012;
GO
--1
SELECT Name
FROM Production.Product
WHERE Name LIKE 'B%';
--2
SELECT Name
FROM Production.Product
WHERE CHARINDEX('B',Name) = 1;

Query 1 is less resource intensive out of the two, in 7:13 ratio. This is due to the face that the former utilises the index on Names, unlike its
counterpart.

2. Type in and execute the following code. View the execution plans once query
execution completes, and explain whether one query performs better than the
other and why.
USE AdventureWorks2012;
GO
--1
SELECT LastName
FROM Person.Person
WHERE LastName LIKE '%i%';
--2
SELECT LastName
FROM Person.Person
WHERE CHARINDEX('i',LastName) > 0;

Both weight equally in terms of relative resource usage. Both use the Naming index.
*/