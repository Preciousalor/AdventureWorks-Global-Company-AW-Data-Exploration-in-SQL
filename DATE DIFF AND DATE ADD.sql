### Aggregating in SQL
### Counting rows with COUNT() aggregation

SELECT

COUNT(*) AS TotalCustomer,

AVG(YearlyIncome) AS AverageIncome

FROM DimCustomer

### Manipulating Values Date Functions
SELECT

GETDATE() AS DateTimeStamp,
DueDate,
ShipDate,
DATEDIFF(DAY,ShipDate,DueDate) AS DaysBetweenSipDateandDuedate,
DATEDIFF(HOUR,ShipDate,DueDate) AS HoursBetweenSipDateandDuedate,
DATEADD(DAY,10,DueDate) AS DueDatePlus10Days

FROM FactInternetSales

---

SELECT * FROM DimCustomer

SELECT COUNT(*) AS TotalCustomers FROM DimCustomer

SELECT COUNT(Middlename) AS MiddleNameCount FROM DimCUstomer


--NameMonth
SELECT
MONTH('20201011') AS MonthNumerical,
MONTH('2020-10-11') AS MonthNumerical 

SELECT DATENAME(MONTH,2020/10/11) AS DateName

### EXplaining SERVERPROPERTY
SELECT CONVERT (varchar(256), SERVERPROPERTY('collation'))

### CASE INSENSITIVE
SELECT *

FROM DimProduct

WHERE Color = 'silver'

SELECT *

FROM DimProduct

WHERE Color = 'Silver'

--ACCENT INSENSITIVE 


SELECT FrenchDescription

FROM DimProduct

WHERE FrenchDescription='Acier Chrome.'


### CONCAT;LENGTH;LOWER;UPPER;REPLACE;LEFT:RIGHT

SELECT

EnglishProductName AS ProductName,
EnglishDescription AS EnglishProductDescription,
CONCAT(EnglishProductName,'-',EnglishDescription) AS ProductNameAndDescription,
LEN(EnglishDescription) AS DescriptionLength,
UPPER(EnglishProductName) AS UpperProductName,
LOWER(EnglishProductName) As LowerProductName,
REPLACE(EnglishProductName,'Front','Ultra Durable Front') AS EnglishProductNameReplaced,
LEFT(ProductAlternateKey,2) AS ProductShort,
Right(ProductAlternateKey, LEN(ProductAlternateKey)-3) AS ProductAlternatekey
FROM DIMProduct
WHERE ProductKey = 555



### Working with =,<>,IS,IS NOT, >,< : to determine in advance the type of data in a column, simply look at the enclosed bracket in the name of the file. This will ensure that you write codes that works.

SELECT *


FROM DIMProduct
--WHERE CLASS <> 'H'
WHERE CLASS IS NOT NULL


## Another example

SELECT *


FROM DIMProduct
WHERE CLASS <> 'H' OR CLASS IS NULL


### Manupulating values, logical operators, adding parenthesis to explicitly tell it the order it should carry out a logical qeuery.

SELECT 

EnglishProductName,
EnglishDescription,
Color,
[Status],
Class

FROM DIMProduct
WHERE (CLASS <> 'H' OR CLASS IS NULL) AND [Status] IS NOT NULL


### IN & BETWEEN

SELECT 

EnglishProductName,
EnglishDescription,
Color,
[Status],
Class,
SafetyStockLevel

FROM DIMProduct
WHERE (SafetyStockLevel BETWEEN  500 AND 1000) AND [Status] IS NOT NULL --BEtWEEN IS INCLUSIVE OF BOTH ENDS
--WHERE (SafetyStockLevel >= 500 AND SafetyStockLevel<= 1000 ) AND [Status] IS NOT NULL
--WHERE COLOR IN ('Black','White','Yellow','Silver')

### LIKE -- used to Identify partial matches using Wildcards

SELECT 

Firstname,
Emailaddress

FROM DimCustomer

WHERE FirstName LIKE '_R%'

### Manupulating values, Conditional COLUMNS and also Formatting of codes
### Case statement

SELECT 
    Firstname,
    IIF(MiddleName IS NULL,'UNKN',MiddleName) AS MiddleName,
    ISNULL(MiddleName,'UNKN') AS MiddleName2,
    COALESCE(MiddleName,'UNKN') AS MiddleName3,
    LastName,
    YearlyIncome,
    Emailaddress,
    IIF(YearlyIncome >50000,'Above Average', 'Below Averge') AS IncomeCategory,
    CASE
        WHEN NumberChildrenAtHome = 0 THEN 'o'
        WHEN NumberChildrenAtHome = 1 THEN '1'
        WHEN NumberChildrenAtHome BETWEEN 2 AND 4 THEN '2-4'
        WHEN NumberChildrenAtHome >= 5 THEN '5+'
        ELSE 'UNKN'
    END AS NumberChildrenCategory,
    NumberChildrenAtHome AS ActualChildren


FROM DimCustomer
WHERE IIF(YearlyIncome >50000,'Above Average', 'Below Averge') = 'Above Average'


### Using CAST PlUS How to comment out more than one row.

/*SELECT Simple example of the CAST function

    SalesAmount,
    CAST(SalesAmount As INT) AS SalesAmountCast,
    OrderDate,
    CAST(OrderDate As Date) AS OrderDateCast

FROM FactInternetSales
*/


SELECT

EnglishproductName,
ReorderPoint,
SafetyStockLevel,
CAST(ReorderPoint AS decimal(8,4)) / CAST(SafetyStockLevel AS DECIMAL(8,4)) AS PercentOfTotalSafetyStock




FROM DimProduct
WHERE [Status] = 'Current'


### Adding Capital N before National or nvarcher for SQL Best Practice

SELECT 

EnglishProductName,
EnglishDescription,
Color,
[Status],
Class,
SafetyStockLevel

FROM DIMProduct
--WHERE (SafetyStockLevel BETWEEN  500 AND 1000) AND [Status] IS NOT NULL --BEtWEEN IS INCLUSIVE OF BOTH ENDS
--WHERE (SafetyStockLevel >= 500 AND SafetyStockLevel<= 1000 ) AND [Status] IS NOT NULL

WHERE COLOR IN (N'Black',N'White',N'Yellow',N'Silver')

--LIKE -- used to Identify partial matches using Wildcards
    

### Queries for analysis

SELECT 

    SalesOrdernumber As InvoiceNumber,
    SalesOrderlineNumber AS InvoiceLineNumber,
    SalesAmount AS SalesAmount,
    TaxAmt AS TaxAmt

FROM FactInternetSales


WHERE DATENAME(Month,OrderDate) = N'December' AND SalesTerritoryKey = 1 


### Query 2


SELECT
    CONCAT(FirstName, ' ', LastName) AS Full_name,
    EmailAddress AS Email,

CASE
    WHEN NumberCarsOwned IN (2,3) THEN '2-3'
    WHEN NumberCarsOwned >= 4 THEN '4+'
    ELSE 'UNKN'
END AS NumberCarsOwned


FROM DimCUstomer

WHERE Houseownerflag = 1 AND NumberCarsOwned > 1
