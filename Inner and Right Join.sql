

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


### multiple tables, Right join


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

### Multiple Tables Left join

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


### Joining columns under Bridge in

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

--WHERE fs.SalesOrderNumber = N'SO51178'


GROUP BY dsr.SalesReasonReasonType


### subselect in a view

SELECT
    InvoiceNumber,
    InvoiceLineNumber,
    OrderDate,
    SalesAmount,
    ProductName,
    ProductSubCategory


FROM vwOrdersALL

WHERE OrderDate = (SELECT MAX(OrderDate) FROM vwOrdersALL)
