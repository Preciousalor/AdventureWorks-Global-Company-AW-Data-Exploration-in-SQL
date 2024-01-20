

SELECT Customerkey as CustomerID, SUM(SalesAmount) as SalesAmount

FROM FactInternetSales

WHERE year(OrderDate) > 2010

GROUP BY CustomerKey

HAVING SUM(Salesamount) > 10000

ORDER BY SalesAmount Desc
