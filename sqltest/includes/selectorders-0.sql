
SELECT 
 count(o.OrderID) AS total   
FROM  
  Orders o   
WHERE o.OrderStatus <> 'Cancelled' AND o.OrderStatus <> 'Returned' AND (o.OrderDate > '4/1/2014') AND (o.OrderDate < '5/1/2014');


--SELECT 
-- o.OrderID, 
-- o.CustomerID, 
-- o.OrderNot
--FROM  
--  Orders o  
--WHERE o.OrderID=@num;
