CREATE DEFINER=`Little_Lemon_user`@`%` PROCEDURE `GetOrderDetail`()
BEGIN
PREPARE GetOrderDetail FROM
'SELECT OrderID, Quantity, BillAmount AS Cost FROM Orders
WHERE CustomerID = ?';
END