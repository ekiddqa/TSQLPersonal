EXEC tSQLt.NewTestClass 'NewStarter_Test'

GO
SET NOCOUNT ON
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[InsertKidd]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [InsertKidd]
GO

CREATE PROCEDURE [InsertKidd] (
    @MyName VARCHAR(20)
) AS

SET NOCOUNT ON    

DECLARE @Error int SELECT @Error = 0
DECLARE @Trancount int SELECT @Trancount = @@Trancount
DECLARE @IamReprocess BIT SELECT @IamReprocess = 0


    BEGIN
	    IF NOT EXISTS(SELECT Name FROM Test4Newbs2 WHERE Name = @MyName) BEGIN
	        INSERT INTO Test4Newbs2 ([Name])
			VALUES (@MyName)
			PRINT N'Inserted ' + @MyName + N' into Test4Newbs'
        END
	ELSE PRINT N'Insert failed, ' + @MyName + N' already exists'
	END;

DROP TABLE Test4Newbs2;

CREATE TABLE Test4Newbs2
(
id INT IDENTITY(1,1),
[Name] VARCHAR(20),
);

INSERT INTO Test4Newbs2 ([id], [Name])
Values(1,'John'),
(2,'Steve'),
(3,'Sam')

EXEC tSQLt.NewTestClass 'NewStarter_Test'

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[NewStarter_Test].[TEST Kidd]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [NewStarter_Test].[TEST Kidd]
GO

CREATE PROCEDURE [NewStarter_Test].[TEST Kidd]
@Name VARCHAR(20)
AS
DECLARE @Expected INT
DECLARE @Actual INT

CREATE TABLE #Expected(
    id INT,
	[Name] VARCHAR(20)
)

INSERT INTO #Expected VALUES (1,'John'),
(2,'Steve'),
(3,'Sam'), 
(4, 'Kidd')

EXEC [InsertKidd] 'Kidd';

CREATE TABLE #Actual(
    id INT,
	[Name] VARCHAR(20)
)

INSERT INTO #Actual (id, Name)	
SELECT *
FROM Test4Newbs2;

EXEC tSQLt.AssertEqualsTable @Expected = '#Expected'
                            ,@Actual   = '#Actual'
							,@FailMsg  = 'Expected table did not match actual'


exec tSQLt.Run [NewStarter_Test].[TEST Kidd];