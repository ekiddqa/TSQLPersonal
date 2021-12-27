/*
!! SELECT p.37
 -- Most basic query for retrieving data, returns all rows for all columns
   SELECT <column1>, <column2>, ..., <columnm> FROM <schema>.<table>; (m element of natural numbers)
 ! Automated SELECT from Object Explorer p.38 :
     1. In the Object Explorer, expand Databases.
     2. Expand the AdventureWorks2012 database.
     3. Expand Tables.
     4. Right-click the HumanResources.Employee table.
     5. Choose Script Table as > Select To > New Query Editor Window.

 ! AS (alias) p.40
  -- Display a column header in results to be displayed under a different string. Literals and columns can be in the same query together.
    SELECT <column> AS '[alias]'
	?? Optional, not including a comma after each column results in column1 being aliased as column2 in 'SELECT * column1 column2'


 ! TOP p.110
  -- Allows selection and interaction of the TOP x most rows, where x can be a hard set number or percentage.
   SELECT TOP(<number>) [PERCENT] [WITH TIES] <col1>,<col2>
   FROM <table1> [ORDER BY <col1>]
    
   DELETE TOP(<number>) [PERCENT] [FROM] <table1>
    
   UPDATE TOP(<number>) [PERCENT] <table1> SET <col1> = <value>
    
   INSERT TOP(<number>) [PERCENT] [INTO] <table1> (<col1>,<col2>)
   SELECT <col3>,<col4> FROM <table2>
    
   INSERT [INTO] <table1> (<col1>,<col2>)  
   SELECT TOP(<numbers>) [PERCENT] <col3>,<col4>
   FROM <table2>
   ORDER BY <col1>  - ORDER BY clause is optional
   ?? ORDER BY not valid with DELETE or UPDATE.
   ?? WITH TIES only valid with select.
 
 ! ROWNUMBER p.122
  -- Returns a sequential numeric value along with the results of a query. OVER clause, which the function uses to determine the numbering behavior.
     Option of starting the numbers over whenever the values of a specified column change, called partitioning, with the PARTITION BY clause.
    SELECT <col1>,<col2>,
    ROW_NUMBER() OVER([PARTITION BY <col1>,<col2>]
    ORDER BY <col1>,<col2>) AS <RNalias>
    FROM <table1>
   
    WITH <cteName> AS (
    SELECT <col1>,<col2>,
    ROW_NUMBER() OVER([PARTITION BY <col1>,<col2>]
    ORDER BY <col1>,<col2>) AS <RNalias>
    FROM <table1>)
    SELECT <col1>,<col2>,<RNalias>
    FROM <table1>
    WHERE <criteria including RNalias> 
	?? Must include the ORDER BY option, which determines the order in which the function applies the numbers.
	?? Can’t include it in the WHERE clause
	   e.g
	    --1
         SELECT CustomerID, FirstName + ' ' + LastName AS Name,
         ROW_NUMBER() OVER (ORDER BY LastName, FirstName) AS Row
         FROM Sales.Customer AS c INNER JOIN Person.Person AS p
         ON c.PersonID = p.BusinessEntityID;
        
		--2
         WITH customers AS (
         SELECT CustomerID, FirstName + ' ' + LastName AS Name,
         ROW_NUMBER() OVER (ORDER BY LastName, FirstName) AS Row
         FROM Sales.Customer AS c INNER JOIN Person.Person AS p
         ON c.PersonID = p.BusinessEntityID
         )
         SELECT CustomerID, Name, Row
         FROM customers
         WHERE Row > 50
         ORDER BY Row;

        --3
         SELECT CustomerID, FirstName + ' ' + LastName AS Name, c.TerritoryID,
         ROW_NUMBER() OVER (PARTITION BY c.TerritoryID
         ORDER BY LastName, FirstName) AS Row
         FROM Sales.Customer AS c INNER JOIN Person.Person AS p
         ON c.PersonID = p.BusinessEntityID; 

		    ! RANK and DENSE_RANK p. 123
			 --Similar to above.
			 --Assigns same number to dupe rows and skips unused numbers.
			  SELECT <col1>, RANK() OVER([PARTITION BY <col2>,<col3>] ORDER BY <col1>,<col2>) FROM <table1> 

			  -- Doesn't skip numbers.
			  SELECT <col1>, RANK() OVER([PARTITION BY <col2>,<col3>] ORDER BY <col1>,<col2>) FROM <table1> 

			   e.g.
			    SELECT CustomerID,COUNT(*) AS CountOfSales,
                RANK() OVER(ORDER BY COUNT(*) DESC) AS Ranking,
                ROW_NUMBER() OVER(ORDER BY COUNT(*) DESC) AS Row,
                DENSE_RANK() OVER(ORDER BY COUNT(*) DESC) AS DenseRanking
                FROM Sales.SalesOrderHeader
                GROUP BY CustomerID
                ORDER BY COUNT(*) DESC; 

 ! NTITLE p.124
  -- Assigns weighting (as 1 of n buckets) to groups of rows.
   SELECT <col1>, NTILE(<buckets>) OVER([PARTITION BY <col1>,<col1>]
   ORDER BY <col1>,<col2>) AS <alias>
   FROM <table1>
    e.g.
	 SELECT SalesPersonID,SUM(TotalDue) AS TotalSales,
     NTILE(10) OVER(ORDER BY SUM(TotalDue)) * 10000/COUNT(*) OVER() AS Bonus
     FROM Sales.SalesOrderHeader
     WHERE SalesPersonID IS NOT NULL
     AND OrderDate BETWEEN '1/1/2005' AND '12/31/2005'
     GROUP BY SalesPersonID
     ORDER BY TotalSales; 

!! JOINS p.131
 -- Combining data from multiple table. Most commonly inner joins but there exists left, right, outer, cross, and natural.
 ! INNER JOIN
  -- Only includes and combines rows which matching values/meet the criteria of the join.
   SELECT <select list>
   FROM <table1>
   [INNER] JOIN <table2> ON <table1>.<col1> = <table2>.<col2>
   ?? Use aliases for tables in FROM clause as columns will need to be full specified.
   ?? There is no check for logically sound rows, use stop (ALT + BREAK) if needing to stop a current query.

   ! On multiple columns p.135
    SELECT <SELECT list>
    FROM <table1>
    [INNER] JOIN <table2> ON <table1>.<col1> = <table2><col2>
    AND <table1>.<col3> = <table2>.<col4>
	 e.g.
	  -- The Sales.SalesSpecialOfferProduct table has a composite primary key composed of SpecialOfferID plus ProductID, thus to identify a row 
	  in this table, you must use both columns.
	   SELECT sod.SalesOrderID, sod.SalesOrderDetailID,
       so.ProductID, so.SpecialOfferID, so.ModifiedDate
       FROM Sales.SalesOrderDetail AS sod
       INNER JOIN Sales.SpecialOfferProduct AS so
       ON so.ProductID = sod.ProductID AND
       so.SpecialOfferID = sod.SpecialOfferID
       WHERE sod.SalesOrderID IN (51116,51112); 

   ! 3 or more tables p.137
    -- Continuation the FROM clause. Often found in many to many relationships.
	 SELECT <SELECT list> FROM <table1>
     [INNER] JOIN <table2> ON <table1>.<col1> = <table2>.<col2>
     [INNER] JOIN <table3> ON <table2>.<col2> = <table3>.<col3> 

 ! OUTER JOIN p.139
  -- Joins that display rows where there isn't a match in the other table.
  ! LEFT OUTER JOIN P.140
   -- Returns all row from the LHS of the equation, even if there isn't a match.
    SELECT <SELECT list>
    FROM <table1>
    LEFT [OUTER] JOIN <table2> ON <table1>.<col1> = <table2>.<col2> 
  
  ! RIGHT OUTER JOIN P.141
   -- Returns all row from the RHS of the equation, even if there isn't a match.
    SELECT <SELECT list>
    FROM <table1>
    LEFT [OUTER] JOIN <table2> ON <table1>.<col1> = <table2>.<col2> 

  ! OUTER JOIN p.142
   -- Returns all rows, even if there isn't a match in the join from either side.
    SELECT <SELECT list>
    FROM <table1>
    LEFT [OUTER] JOIN <table2> ON <table1>.<col1> = <table2>.<col2>
    WHERE <col2> IS NULL

  ! Adding a Table to the Right Side of a Left Join p.
   -- Joining two left outer joins together so that information from both tables can be retained.
    e.g. Wanting to display all the customers and their orders even if an order has not been placed, along
    with the ProductID from those orders that were placed.
    SELECT <SELECT list>
    FROM <table1> LEFT [OUTER]JOIN <table2> ON <table1>.<col1> = <table2>.<col2>
    LEFT [OUTER] JOIN <table3> ON <table2>.<col3> = <table3>.<col4> 

  ! FULL OUTER JOIN p.147
   -- Returns all rows from both tables
    SELECT <column list>
    FROM <table1>
    FULL [OUTER] JOIN <table2> ON <table1>.<col1> = <table2>.<col2>

  ! CROSS JOIN p.149
   -- Returns every row from one table matched to every row of the other table.
    SELECT <SELECT list> FROM <table1> CROSS JOIN <table2>

  ! SELF JOIN p.150
   -- Joining a table onto itself. At least one of the ntable names must be aliased; it is not an option because you can’t have two tables with the same name 
   SELECT <a.col1>, <b.col1>
   FROM <table1> AS a
   LEFT [OUTER] JOIN <table1> AS b ON a.<col1> = b.<col2>
!! WHERE p.42
 -- Filters results
   SELECT <column1>,<column2>
   FROM <schema>.<table>
   WHERE <column> = <value>;
   ?? Using functions in the WHERE clause generally causes processing inefficiencies as it cannot use indexes.
	
	List of Operations p.43:
	> (greater than)
    < (less than)
    = (equals)
   <= (less than or equal to)
   >= (greater than or equal to)
   != (not equal to)
   <> (not equal to)
   !< (not less than)
   !> (not greater than) 

 ! BETWEEN p.45
  -- Limits results between two values, inclusive both ends. Usable with strings and numerics.
    SELECT <column1>,<column2>
    FROM <schema>.<table>
    WHERE <column> BETWEEN <value1> AND <value2>; where value1 <= value 2

 ! NOT p.(reference after subsections of WHERE)
  -- Logical opperator, selects inverse.
  Goes before TEXT operators except AND/OR.

  ??Date filtering - using a WHERE filter on a date where said value is a datetime will default the time part to 00:00:00

  ! LIKE
   -- Pattern Matching
    % - Can be replaced by n (element N) characters
    _ - Replacable by a single character only

    ! Restricting Characters
	 [a-z] - restricts possible replacments between values a and z
	 [a,b,c,..,z] - restricts possible replacements to distrect values a, b, c, ..., z
	 [^a] - Restricts possible replaces to NOT include a

	 ! Combining
	WHERE LastName LIKE 'Ber[r,g]%';
	 - 4th character must be r or g, then any number of any value afterwards.

	WHERE LastName LIKE 'Ber[^r]%';
	 - 4th character must NOT be r then any number of any values afterwards.

	WHERE LastName LIKE 'Be%n_'; 
	- Any number of characters after 'Be', then a n with a single character of any value.
	
 ! AND and OR (predictates) p.57
    <condition1> AND <condition2>
    <condition1> OR <condition2>

  ?? <condition1> OR <condition2> AND <condition3> = <condition1> OR (<condition2> AND <condition3>)

  ! IN p.61
   -- OR statement for multiplvalues in the same column.
    WHERE <column> (NOT ) IN (value1, value2, ..., valueN);

  ! NULL p.63
  Has no value without being "nothing" - does not = or != any defined value (UNKOWN). Has its own operators.

  IS (NOT )NULL

  ! CONTAINS p.66
   -- Usuable in binary data columns.
   WHERE CONTAINS(<indexed column>,<searchterm>);
    ! NEAR
	! FREETEXT p.68
	 - Full-text search with less precise results.
  
  ! ORDER BY (Sorting) p.69
   -- Sorts results by order of column1 then column 2 etc.
    ORDER BY <column1>[<sort direction>],<column2> [<sort direction>]

  ! OFFSET x ROWS (omitting truthy rows) p.70
    ORDER BY <column>
    OFFSET x ROWS; x is a natural number, 0 < x  
  
  ! FETCH (limit) p.71
   -- Like TOP or LIMIT - only shows the first x results.
    ORDER BY <column>
	FETCH x ROWS;

    List of Arguements (between FETCH and x):
	 NEXT - Selects from the next row directly after cusor, default, starts at first row of result set if first fetch against cusor
	 PRIOR - Selcts from previous row directly before cusor. If first fetch against cusor returns nothing.
	 FIRST/LAST - Returns first/last row of cusor and moves fetch there



!! Viewing Indexes p.73
    1. Expand Databases.
    2. Navigate to desired table and expand it's folder
    4. Expand Indexes
    5. Double click to view properties of an index

	- Execution plan shortcut: CTRL + L - displays the weight of the processing power between queries.

 ! Concatination p. 79
  -- Used to combine value(s) and/or strings.
	<column|string> + <column|string>
	 ?? Concat with NULLS returns NULL, see replacing NULL on p.83

 ! CONCAT p. 81
  -- A cleaner version of above, can use variables and table rows.
    SELECT CONCAT(<column/string1>, <column/string2>, ..., <column/stringN>), N element of natural numbers
   
 ! ISNULL and COALESCE (replacing NULL) p.83
  -- Value to check and the replacement for NULL values (Not prefered)
    ISNULL(<value>,<replacement>)
  -- Takes any no. of parameters and returns the next non-null val. Prefered.
  -- Can be used when checking one or more values for NULL. Also when a replacement for NULL is required.
    COALESCE(<value1>,<value2>,...,<valueN>) (N element of Natural Numbers)
	 e.g.
	  SELECT BusinessEntityID, FirstName + COALESCE(' ' + MiddleName,'') +
      ' ' + LastName AS "Full Name"
      FROM Person.Person; 

	   Result : FirstName + (checks if MiddleName is NULL, if true then concats '', else concats ' ' + MiddleName) + ' ' + LastName 
	    => FirstName MiddleName LastName (if MiddleName IS NOT NULL) | FirstName LastName (if MiddleName IS NULL)

 ! CAST and CONVERT (concatenating other data types to strings) p.84
  -- Non string data types cannot natively be concatinated. Can be used to format dates (p.104)

    CAST(<value> AS <new data type>)
    CONVERT(<new data type>,<value>,[<style>(for dates)]) 
	  e.g.
	   SELECT CAST(BusinessEntityID AS NVARCHAR) + ': ' + LastName + ', ' + FirstName AS ID_Name
       FROM Person.Person;
	    
	   Result: 285: Abbas, Syed

     SELECT CONVERT(NVARCHAR(10),BusinessEntityID) + ': ' + LastName + ', ' + FirstName AS ID_Name
     FROM Person.Person;

	  Result: Same as above

     SELECT BusinessEntityID, BusinessEntityID + 1 AS "Adds 1", CAST(BusinessEntityID AS NVARCHAR(10)) + '1'AS "Appends 1"
     FROM Person.Person;
	  
	  Result: 12345, 12346, 123451

	! Mathematical operators can be used like the above functions

 ! RTRIM and LTRIM (removing white space from strings) p. 90
	RTRIM(<string>)
    LTRIM(<string>) 

	e.g.
      CREATE TABLE #trimExample (COL1 VARCHAR(10));
      GO
      INSERT INTO #trimExample (COL1)
      VALUES ('a '),('b '),(' c'),(' d ');
      SELECT COL1, '*' + RTRIM(COL1) + '*' AS "RTRIM",
      '*' + LTRIM(COL1) + '*' AS "LTRIM"
      FROM #trimExample;

	   Result: 'a ', 'a', 'a '
	           'b ', 'b', 'b '
			   ' c', ' c', 'c'
			   ' d ', ' d', 'd '

 ! LEFT and RIGHT p.90
  -- Retrieving the x left/rightmost characters
    LEFT(<string>,<number of characters)
    RIGHT(<string>,<number of characters) 
 
 ! LEN and DATALENGTH p.91
  -- Returns the length/bytes of a string respectively
    LEN(<string>)
    DATALENGTH(<string>)

 ! CHARINDEX p.92
  -- Finds first instance of string x in string y.
    CHARINDEX(<search string>,<target string>[,<start location>]) 

 ! SUBSTRING p.93
  -- Returns a substring of another string with a start and end position
    SUBSTRING(<string>,<start location>,<length>) 

 ! CHOOSE p.94
  -- Returns val_x where index = x.
    CHOOSE ( index, val_1, val_2 [, val_n ] )
    ?? Mixing numerals and string results in a datatype precedence error and numerals should be converted as a result.

 ! REVERSE p.95
  -- Returns string in reversed order.
    REVERSE(<string>)

 ! UPPER and LOWER p.95
  -- Returns strings entirely upper/lower case.
   UPPER(<string>)
   LOWER(<string>)

 ! REPLACE p.96
  -- Replaces occurences of substring x in string y with string z (not distinct)
    REPLACE(<string value>,<string to replace>,<replacement>)

  
  ----------------------
 
 Date Part    Abbreviation
  Year         yy, yyyy
  Quarter      qq, q
  Month        mm, m
  Dayofyear    dy, y
  Day          dd, d
  Week         wk, ww
  Weekday      Dw
  Hour         Hh
  Minute       mi, n
  Second       ss, s
  Millisecond  Ms
  Microsecond  Mcs
  Nanosecond  Ns
  -----------------------

 ! GETDATE and SYSDATETIME p.99
  -- Retrieves system's time, GET 3 d.p., SYS 7 d.p.
    GETDATE()
    SYSDATETIME()
    
 ! DATEADD p.100
  -- Adds a number of time units to a date
    DATEADD(<date part>,<number>,<date>) 
	?? Accepts negative values. Substraction equiv doesn't exist
	?? When adding/substracing a month to the last dif the next/previous month has less days it will change the day to the last day of the resulting month.
	
 ! DATEDIFF p.101
  -- Finds the different between two dates in a given unit as an int.
	DATEDIFF(<datepart>,<early date>,<later date>)
	?? Only compares datepart unit and not subunits. If the result is a non-unit then rounded up to nearest int.

 ! DATENAME and DATEPART p.101
  -- Returns specific part of a date.
	DATENAME(<datepart>,<date>) (Returns a name if possible)
    DATEPART(<datepart>,<date>) (Numeric - int)

! DAY, MONTH, and YEAR p.103
 -- Less flexiable versions
  DAY(<date>) 
  MONTH(<date>)
  YEAR(<date>) 

 ! FORMAT p.105
  -- Simpliest way of reformating a date.
	FORMAT ( value, format [, culture ] ) 
	?? Casing for date parts are case sensitive

 ! DATEFROMPARTS p.108
  -- Takes integers to form a date.
	DATEFROMPARTS(<year>, <month>, <day>)

 ! TIMEFROMPARTS 
  -- Takes integers to form a time.
	TIMEFROMPARTS(<hour>,<minute>,<second>,<microsecond>,<nanosecond>)

 ! DATETIME2FROMPARTS 
  -- Combines the above 2 functions.
    DATETIME2FROMPARTS(<year>, <month>, <day>,<hour>,<minute>,<second>,<microsecond>,<nanosecond>)
    ?? Inputing "impossible" numbers causes an error.

 ! ABS (Absolute) p.108
  
 ! POWER(<number>,<power>)

 ! SQUARE 

 ! SQRT

 ! ROUND p.109
    ROUND(<number>,<length>[,<function>]) 
     e.g.
       ROUND(1234.1294,2) AS "2 places on the right"
	 
	    Result: 1234.1300

       ROUND(1234.1294,-2) AS "2 places on the left"

  	    Result: 1200.00

       ROUND(1234.1294,2,1) AS "Truncate 2"

 	    Result: 1234.12

       ROUND(1234.1294,-2,1) AS "Truncate -2"
	  
	    Result: 1200.00
  
  ! RAND([seed])

  ! CASE p.111
   -- Similar to Switch cases in Java.
    CASE <test expression>
    WHEN <comparison expression1> THEN <return value1>
    WHEN <comparison expression2> THEN <return value2>
    [ELSE <value3>] END

      ! Searched Case p.112
	   -- Advanced CASE. You can use column names instead of hard coded values in the THEN clause.
	    CASE WHEN <test expression1> THEN <value1>
        WHEN <test expression2> THEN <value2>
        [ELSE <value3>] END 
	    ?? Returned values must be of comparitable data types and presidence applies

   ! IIF p.114
    --Takes a bool statment and returns one of two values.
	 IIF ( boolean_expression, true_value, false_value ) 

*/