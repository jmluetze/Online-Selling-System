CREATE VIEW customerDetailsView AS
SELECT c_ID, c_Name, c_Email, c_Address, c_Balance, COUNT (DISTINCT
cardNumber) AS Credit_Cards, COUNT(orderID) AS Orders FROM Customers NATURAL JOIN PlacesOrder
GROUP BY c_ID, c_Name, c_Email, c_Address, c_Balance 
ORDER BY c_ID;