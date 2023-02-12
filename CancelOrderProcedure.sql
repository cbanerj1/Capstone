CREATE DEFINER=`Little_Lemon_user`@`%` PROCEDURE `	CancelOrder`(inputid INT)
BEGIN
DELETE FROM Orders WHERE OrderID = inputid;
END