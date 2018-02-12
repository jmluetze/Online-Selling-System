CREATE VIEW shippingView AS
SELECT OrderID, orderDate, Company, ArrivalDate FROM Orders NATURAL JOIN shippingInfo;