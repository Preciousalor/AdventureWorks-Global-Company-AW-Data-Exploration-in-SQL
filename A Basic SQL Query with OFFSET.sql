--A basic query as part of SQL fundamental course, including OFFSET FETCH.


SELECT
SalesOrderNumber AS InvioceNumber,
OrderDate,
SUM(SalesAmount) AS InvoiceSubtotal ,
SUM(TaxAmt) AS TaxAmt,
SUM(OrderQuantity) AS TotalQuantity,

SUM(SalesAmount) + SUM(TaxAmt) AS InvoiceTotal
FROM FactInternetSales

WHERE salesTerritoryKey = 6

Group By SalesOrderNumber, OrderDate
HAVING SUM(SalesAmount) > 1000

ORDER BY InvoiceSubtotal DESC

OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY