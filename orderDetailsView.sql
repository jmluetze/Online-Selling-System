CREATE VIEW orderDetailsView AS
SELECT OrderID, orderDate, productID, productName, SUM(productCount) AS
productCount, productPrice
FROM OrderContains NATURAL JOIN Orders NATURAL JOIN Products 
GROUP BY OrderID, orderDate, productID, productName, productPrice 
ORDER BY OrderID;