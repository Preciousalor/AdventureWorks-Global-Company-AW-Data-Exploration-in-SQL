---Exercise 4A


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


--Exercise 4B

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

ORDER BY EmployeeName,TotalSalesAmount DESC
