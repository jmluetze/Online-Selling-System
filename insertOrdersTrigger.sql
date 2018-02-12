CREATE TRIGGER insertOrdersTrigger 
    BEFORE INSERT ON OrderContains 
    FOR EACH ROW
    EXECUTE PROCEDURE insertOrder();
CREATE FUNCTION insertOrder() 
    RETURNS trigger AS $BODY$
DECLARE 
n int; 
inTable int; 
BEGIN
    n:= (SELECT productPrice FROM Products WHERE productID = NEW.productID);
    n:= n*NEW.productCount;
    inTable := (SELECT count(orderID) FROM Orders Where orderID = NEW.orderID);
IF (inTable = 0) THEN
    INSERT INTO Orders (orderID, orderDate, orderPrice)
    VALUES(NEW.orderID, current_date, n); 
END IF;
IF (inTable = 1) THEN
    UPDATE Orders SET orderPrice = orderPrice + n WHERE orderID = NEW.orderID; 
END IF;
RETURN NEW; 
END;
$BODY$ LANGUAGE plpgsql;