--1
SELECT ProductID, Name
FROM Production.Product
WHERE Name LIKE '[C,c]hain%';

--2
SELECT ProductID, Name
FROM Production.Product
WHERE Name LIKE '%[P,p]aint%';

--Case Sensitive
/*SELECT ProductID, Name
FROM Production.Product
WHERE Name LIKE '%paint%';
*/

--3
SELECT ProductID, Name
FROM Production.Product
WHERE Name NOT LIKE '%[^P,p]aint%';

--4
SELECT BusinessEntityID, FirstName, MiddleName, LastName
FROM Person.Person
WHERE MiddleName Like '%[B,b,E,e]%';

--5
--'Ja%es' is at least  4 characters long while 'Ja_es' must be 5 characters long.