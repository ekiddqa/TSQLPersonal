--1
SELECT BusinessEntityID, LastName, MiddleName, FirstName
FROM Person.Person
ORDER BY LastName, FirstName, MiddleName;

--2
SELECT BusinessEntityID, LastName, MiddleName, FirstName
FROM Person.Person
ORDER BY LastName, FirstName, MiddleName DESC;

--3
SELECT BusinessEntityID, LastName, MiddleName, FirstName
FROM Person.Person
ORDER BY LastName, FirstName, MiddleName
OFFSET 20 ROWS
FETCH NEXT 10 ROWS ONLY;