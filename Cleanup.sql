WITH 
cCTE AS (
	SELECT 
		CustomerID,
		CustomerEmail,
        CustomerCity
    FROM customers
),
oCTE AS (
	SELECT
		OrderID,
		Date,
        CustomerID,
        ProdNumber,
        Quantity
    FROM orders
),
pCTE AS (
	SELECT
		ProdNumber,
        ProdName,
        Category,
        Price
    FROM products
),
pcCTE AS (
	SELECT
		CategoryID,
		CategoryName
    FROM productcategory
)

SELECT o.Date,
		pc.CategoryName, 
        p.ProdName, 
        p.Price, 
        o.Quantity,    
        SUM(p.Price * o.Quantity) AS TotalSales,
        c.CustomerEmail,
        c.CustomerCity
        
FROM cCTE AS c
JOIN oCTE AS o ON c.CustomerID = o.CustomerID
JOIN pCTE AS p ON o.ProdNumber = p.ProdNumber
JOIN pcCTE AS pc ON p.Category = pc.CategoryID
GROUP BY 
	o.Date,
    c.CustomerID, 
    c.CustomerEmail, 
    c.CustomerCity,
    pc.CategoryName,
    p.ProdName,
    p.Price,
    o.Quantity
