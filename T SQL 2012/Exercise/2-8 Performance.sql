--1
SELECT LastName
FROM Person.Person
WHERE LastName = 'Smith';
--2
SELECT LastName
FROM Person.Person
WHERE LastName LIKE 'Sm%';
--3
SELECT LastName
FROM Person.Person
WHERE LastName LIKE '%mith';
--4
SELECT ModifiedDate
FROM Person.Person
WHERE ModifiedDate BETWEEN '2005-01-01' and '2005-01-31';

--1
/* Due to indexing working from left to right the search process for queries 1 and 2 are essentially the same.

--2
Query 2 runs better as the indexing organises rows from left to right characters, this means that the index is fully ultilised and the entire index doesn't need
to be searched, where as the wildcard is on the right whilst for the other query it must still search the entire index.

--3
Query 3 performs much better than 4, this is due to the fact LastName is indexed whilst ModifiedDate is not. Even though the former must still look through an
entire index the latter must examine the entire table, which is as least efficient as it goes.
*/