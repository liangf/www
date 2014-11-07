SELECT 
  count(o.OrderID) AS total
FROM  
  Orders o   
inner join OrderDetails od on o.OrderID=od.OrderID
where o.OrderStatus <> 'Cancelled' AND o.OrderStatus <> 'Returned' AND (o.OrderDate > '4/1/2014') AND (o.OrderDate < '5/1/2014') AND od.ProductCode = 'DSC-445';


--SELECT 
-- o.OrderID, 
-- o.CustomerID, 
-- o.OrderNot
--FROM  
--  Orders o  
--WHERE o.OrderID=@num;
