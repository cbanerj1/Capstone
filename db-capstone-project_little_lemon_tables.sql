PREPARE GetOrderDetail FROM
'SELECT OrderID, Quantity, BillAmount AS Cost FROM Orders
WHERE CustomerID = ?';