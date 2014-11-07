DECLARE @num int

SET @num = '#{OrderId}'

  

UPDATE 
Orders 
SET OrderNotes='Test' 
WHERE OrderID=@num;

--SELECT 
-- o.OrderID, 
-- o.CustomerID, 
-- o.OrderNotes  
--FROM  
--  Orders o  
--WHERE o.OrderID=@num;
