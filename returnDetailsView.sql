CREATE VIEW returnDetailsView AS
SELECT orderID, RefundDate, productID, productName, SUM(productCount) AS
productCount, productPrice
FROM Returns NATURAL JOIN OrderContains NATURAL JOIN Products 
GROUP BY RefundDate, productID, productName, productPrice, OrderID 
ORDER BY OrderID;