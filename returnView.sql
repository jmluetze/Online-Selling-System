CREATE VIEW returnView AS
SELECT OrderID, orderPrice, RefundDate FROM Returns NATURAL JOIN Orders;