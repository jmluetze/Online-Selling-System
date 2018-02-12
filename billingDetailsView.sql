CREATE VIEW billingDetailsView AS
SELECT c_ID, orderID, cardNumber, orderPrice AS Price_OR_Refund, type FROM Orders NATURAL JOIN PlacesOrder
ORDER BY c_ID;