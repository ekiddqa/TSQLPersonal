/*
1. Write a query that displays the first 10 characters of the AddressLine1 column in
the Person.Address table.
2. Write a query that displays characters 10 to 15 of the AddressLine1 column in the
Person.Address table.
3. Write a query displaying the first and last names from the Person.Person table all
in uppercase.
4. The ProductNumber in the Production.Product table contains a hyphen (-). Write a
query that uses the SUBSTRING function and the CHARINDEX function to display the
characters in the product number following the hyphen. Note: there is also a
second hyphen in many of the rows; ignore the second hyphen for this question.
Hint: Try writing this statement in two steps, the first using the CHARINDEX function
and the second adding the SUBSTRING function. 
*/

--1
SELECT LEFT(AddressLine1, 10) FROM Person.Address;
--2
SELECT SUBSTRING(AddressLine1,10,15) FROM Person.Address;

--3
SELECT UPPER(FirstName), UPPER(LastName) FROM Person.Person;

--4
SELECT ProductNumber FROM Production.Product;
SELECT SUBSTRING(ProductNumber,CHARINDEX('-',ProductNumber) + 1,50) FROM Production.Product;