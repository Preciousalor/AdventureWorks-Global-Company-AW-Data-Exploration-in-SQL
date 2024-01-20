

SELECT TOP (10) PERCENT
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
