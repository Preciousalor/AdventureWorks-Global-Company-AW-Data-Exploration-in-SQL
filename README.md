# AdventureWorks-AW-Data-Exploration
In this project, we extract, transform, and load the customer base data of AW for a more effective social media marketing

### Selecting all Current product descriptions

```sql
SELECT

dp.EnglishProductName AS ProdutName,
dp.Color AS ProductColor,
dp.Size AS ProductSize,
SUM(fs.SalesAmount) AS SalesAmount



FROM FactInternetSales AS fs 
    INNER JOIN DimProduct AS dp 
    ON fs.ProductKey = dp.ProductKey 

WHERE dp.Status = N'Current'




    GROUP BY EnglishProductName, Color, Size

    ORDER BY SalesAmount DESC
```


### Selecting top 5 products from United States

```sql
SELECT TOP (5) 

    dpsc.EnglishproductSubcategoryName AS Subcategory,
    SUM(fs.SalesAmount) AS SalesAmount

FROM FactInternetSales AS fs 
    JOIN DimProduct AS dp 
    ON fs.ProductKey=dp.ProductKey
    JOIN DimProductSubcategory AS dpsc 
    ON dp.ProductSubcategorykey=dpsc.ProductSubcategoryKey
    JOIN DimCurrency AS dcy 
    ON fs.CurrencyKey=dcy.CurrencyKey
    JOIN DimSalesTerritory AS dst 
    ON fs.SalesTerritoryKey=dst.SalesTerritoryKey

WHERE dst.SalesTerritoryCountry=N'United States'
AND dcy.CurrencyName=N'US Dollar'

GROUP BY dpsc.EnglishproductSubcategoryName

ORDER BY SalesAmount DESC
```


### Selecting product descriptions from Europe

```sql
SELECT

    CONCAT(de.FirstName,' ', de.LastName) AS EmployeeName,
    de.Title AS EmployeeTitle,
    dcy.CurrencyName AS Currency,
    SUM(fs.SalesAmount) AS TotalSalesAmount


FROM FactResellerSales AS fs
    JOIN DimEmployee AS de
    ON fs.EmployeeKey=de.EmployeeKey
    JOIN DimSalesTerritory AS dst 
    ON fs.SalesTerritoryKey=dst.SalesTerritoryKey
    JOIN DimCurrency AS dcy 
    ON fs.CurrencyKey=dcy.CurrencyKey

WHERE dst.SalesTerritoryGroup=N'Europe'
AND de.[Status]=N'Current'

GROUP BY de.FirstName,de.LastName,de.Title,dcy.CurrencyName
```


### Test for the number of total current products

```sql
SELECT 

    EnglishProductName 
FROM Dimproduct

WHERE [status] = N'current'
*/
```




### multiple tables, Right join

```sql
SELECT

dp.EnglishProductName AS ProdutName,
dp.Color AS ProductColor,
ISNULL(dp.Size,'UNKN') AS ProductSize,
ISNULL(SUM(fs.SalesAmount),0) AS SalesAmount


FROM FactInternetSales AS fs 
    RIGHT JOIN DimProduct AS dp 
    ON fs.ProductKey = dp.ProductKey 

WHERE dp.Status = N'Current'


GROUP BY dp.EnglishProductName, dp.Color, dp.Size

ORDER BY SalesAmount DESC
```


### Multiple Tables Left join

```sql

SELECT

dp.EnglishProductName AS ProdutName,
dp.Color AS ProductColor,
ISNULL(dp.Size,'UNKN') AS ProductSize,
ISNULL(SUM(fs.SalesAmount),0) AS SalesAmount


/*FROM FactInternetSales AS fs 
    RIGHT JOIN DimProduct AS dp 
    ON fs.ProductKey = dp.ProductKey 
*/

FROM DimProduct AS dp 
LEFT JOIN FactInternetSales AS fs 
ON dp.ProductKey = fs.ProductKey

WHERE dp.Status = N'Current'


GROUP BY dp.EnglishProductName, dp.Color, dp.Size

ORDER BY SalesAmount DESC
```

### Joining columns 

```Sql
SELECT 

--fs.SalesOrderNumber AS InvoiceNumber,
--fs.SalesOrderLineNumber AS InvoiceLineNumber,
dsr.SalesReasonReasonType AS SalesReason,
SUM(fs.SalesAmount) AS SalesAmount



FROM FactInternetSales AS fs 
    INNER JOIN FactInternetSalesReason AS fsr 
    ON fs.SalesOrderNumber = fsr.SalesOrderNumber AND fs.SalesOrderLineNumber = fsr.SalesOrderLineNumber
    INNER JOIN DimSalesReason AS dsr 
    ON fsr.SalesReasonKey = dsr.SalesReasonKey

WHERE fs.SalesOrderNumber = N'SO51178'


GROUP BY dsr.SalesReasonReasonType
```

### Rounding up numbers


```Sql
SELECT TOP (10) PERCENT
SalesOrderNumber AS InvioceNumber,
OrderDate,
SUM(SalesAmount) AS InvoiceSubtotal ,
ROUND(SUM(SalesAmount),1) AS InvoiceSubtotalRounded ,

SUM(TaxAmt) AS TaxAmt,
FLOOR(SUM(TaxAmt)) AS TaxAmtFloor,

SUM(OrderQuantity) AS TotalQuantity,

SUM(SalesAmount) + SUM(TaxAmt) AS InvoiceTotal
FROM FactInternetSales

WHERE salesTerritoryKey = 6

Group By SalesOrderNumber, OrderDate
HAVING SUM(SalesAmount) > 1000

ORDER BY InvoiceSubtotal DESC
```

### Creating a view

```Sql
Create view #ProductDescriptionEurope as
SELECT

    CONCAT(de.FirstName,' ', de.LastName) AS EmployeeName,
    de.Title AS EmployeeTitle,
    dcy.CurrencyName AS Currency,
    SUM(fs.SalesAmount) AS TotalSalesAmount


FROM FactResellerSales AS fs
    JOIN DimEmployee AS de
    ON fs.EmployeeKey=de.EmployeeKey
    JOIN DimSalesTerritory AS dst 
    ON fs.SalesTerritoryKey=dst.SalesTerritoryKey
    JOIN DimCurrency AS dcy 
    ON fs.CurrencyKey=dcy.CurrencyKey

WHERE dst.SalesTerritoryGroup=N'Europe'
AND de.[Status]=N'Current'

GROUP BY de.FirstName,de.LastName,de.Title,dcy.CurrencyName
```


### subselect in a view

```Sql
SELECT
    InvoiceNumber,
    InvoiceLineNumber,
    OrderDate,
    SalesAmount,
    ProductName,
    ProductSubCategory


FROM vwOrdersALL

WHERE OrderDate = (SELECT MAX(OrderDate) FROM vwOrdersALL)
```

