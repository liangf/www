
SELECT 
 count(o.OrderID) AS total   
FROM  
  Orders o   
WHERE o.OrderStatus <> 'Cancelled' AND o.OrderStatus <> 'Returned' AND (o.OrderDate > '2/1/2014') AND (o.OrderDate < '3/1/2014');


--SELECT 
-- o.OrderID, 
-- o.CustomerID, 
-- o.OrderNot
--FROM  
--  Orders o  
--WHERE o.OrderID=@num;
