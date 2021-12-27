--1
SELECT ProductID, Name, Color
FROM Production.Product
WHERE Color IS NULL;

--2
SELECT ProductID, Name, Color
FROM Production.Product
WHERE Color != 'blue' AND Color IS NULL;

--3
SELECT ProductID, Name, Style, Size, Color
FROM Production.Product
WHERE Style IS NOT NULL OR Size IS NOT NULL OR Color IS NOT NULL;