CREATE TRIGGER insertReturnTrigger
    AFTER INSERT ON PlacesOrder
    FOR EACH ROW
    EXECUTE PROCEDURE insertReturn();
CREATE FUNCTION insertReturn() 
    RETURNS trigger AS $BODY$
DECLARE
n int; 
updateBalance int; 
BEGIN
    updateBalance:= (SELECT orderPrice FROM Orders WHERE orderID = New.orderID); 
    IF (NEW.type = 'R' OR NEW.type = 'FR') THEN
        INSERT INTO Returns (orderID, RefundDate)
        VALUES(NEW.orderID, current_date + integer '5');
        UPDATE Customers SET c_Balance = c_Balance + updateBalance WHERE
            NEW.c_ID = c_ID; 
    END IF;
IF (NEW.type = 'O') THEN
    UPDATE Customers SET c_Balance = c_Balance - updateBalance WHERE
        NEW.c_ID = c_ID; 
END IF;
IF(NEW.type = 'FR' IS TRUE) THEN
    UPDATE ShippingInfo SET ArrivalDate = current_date + integer '3';
ELSE
    n:= (SELECT SUM(productCount) FROM orderContains WHERE New.orderID = orderID);
    IF(n > 10) THEN
        INSERT INTO ShippingInfo (orderID, Company, ArrivalDate)
            VALUES(NEW.orderID, 'UPS', current_date + integer '2');
    END IF;
    IF (n <= 10) THEN
        INSERT INTO ShippingInfo (orderID, Company, ArrivalDate) 
            VALUES(NEW.orderID, 'USPS', current_date + integer '4');
    END IF; 
END IF;
RETURN NEW; 
END;
$BODY$ LANGUAGE plpgsql;