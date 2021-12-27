USE AdventureWorks2012_CS
GO

--SELECT * FROM Person.Address;


--1
SELECT CONCAT(AddressLine1, ' (', City, ' ' , PostalCode , ')') FROM Person.Address;

--2
SELECT ProductID, COALESCE(Color, 'No color') Colour, Name FROM Production.Product;

--3
SELECT ProductID, COALESCE('Name: '+ Color, 'Name: No color') Colour, Name FROM Production.Product;

--4
SELECT CONCAT(CAST(ProductID AS varchar), ': ', Name) FROM Production.Product;

--5
--ISNULL examines whether a single term in a column is NULL, and if it is then returns the 2nd value provided.
--Meanwhile COALESCE checks from left to right in a list whether a term is NULL, then checks for the next non NULL term in the list and returns that.

/*Write a query using the Production.Product table displaying a description with the
“ProductID: Name” format. Hint: You will need to use a function to write this
query.
5. Explain the difference between the ISNULL and COALESCE functions
*/
