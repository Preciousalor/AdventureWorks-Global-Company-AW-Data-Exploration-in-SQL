--Working with multiple tables on SQL

SELECT TOP(100)

CONCAT(dc.firstname,' ',dc.lastname) AS CustomerName,
dc.EmailAddress As EmailAddress,
SUM(fs.SalesAmount) AS AmountSpent

FROM FactInternetSales AS fs 
    INNER JOIN DimCustomer AS dc 
    ON fs.CustomerKey = dc.CustomerKey
GROUP BY dc.FirstName, dc.LastName, dc.EmailAddress

ORDER BY AmountSpent DESC

-- A recap of the order of operation in SQL just because it can get really confusing.

FROM & JOIN - WHERE - GROUP BY - HAVING - SELECT & TOP - ORDER BY



SELECT TOP(100)

CONCAT(dc.firstname,' ',dc.lastname) AS CustomerName,
dc.EmailAddress As EmailAddress,
SUM(fs.SalesAmount) AS AmountSpent,
dcy.CurrencyName AS Currency

FROM FactInternetSales AS fs 
    INNER JOIN DimCustomer AS dc 
    ON fs.CustomerKey = dc.CustomerKey
    INNER JOIN DimCurrency AS dcy 
    ON fs.CurrencyKey = dcy.CurrencyKey


GROUP BY dc.FirstName, dc.LastName, dc.EmailAddress, dcy.CurrencyName

HAVING dcy.CurrencyName = N'US Dollar'

ORDER BY AmountSpent DESC









SELECT TOP(100)

CONCAT(dc.firstname,' ',dc.lastname) AS CustomerName,
dc.EmailAddress As EmailAddress,
SUM(fs.SalesAmount) AS AmountSpent
--dcy.CurrencyName AS Currency

FROM FactInternetSales AS fs 
    INNER JOIN DimCustomer AS dc 
    ON fs.CustomerKey = dc.CustomerKey
    INNER JOIN DimCurrency AS dcy 
    ON fs.CurrencyKey = dcy.CurrencyKey

    WHERE dcy.CurrencyName = N'US Dollar'


GROUP BY dc.FirstName, dc.LastName, dc.EmailAddress--, dcy.CurrencyName

--HAVING dcy.CurrencyName = N'US Dollar'

ORDER BY AmountSpent DESC