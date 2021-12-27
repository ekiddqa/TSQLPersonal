/*
1. Write a query using the Sales.SpecialOffer table. Display the difference between
the MinQty and MaxQty columns along with the SpecialOfferID and Description
columns.
2. Write a query using the Sales.SpecialOffer table. Multiply the MinQty column by
the DiscountPct column. Include the SpecialOfferID and Description columns in the
results.
3. Write a query using the Sales.SpecialOffer table that multiplies the MaxQty column
by the DiscountPct column. If the MaxQty value is NULL, replace it with the value
10. Include the SpecialOfferID and Description columns in the results.
4. Describe the difference between division and modulo. 
*/

--1
SELECT MinQty - MaxQty AS 'Difference', SpecialOfferID, Description FROM Sales.SpecialOffer;

--2
SELECT MinQty * DiscountPct, SpecialOfferID, Description FROM Sales.SpecialOffer;

--3
SELECT ISNULL(MaxQty, 10) * DiscountPct FROM Sales.SpecialOffer;

--4
--Division returns the integer part of a/b whilst modulo returns c st c satisfies a = kb + c (i.e the remainder), k is an integer.