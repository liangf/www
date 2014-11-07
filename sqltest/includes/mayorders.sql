SELECT 
  o.OrderID as orderid
, o.Total_Payment_Received as totalpayment
,  o.OrderDate as orderdate
,  od.OrderDetailID as orderdetailid
,  od.ProductCode as productcode
,  od.ProductName as productname
  
FROM  
Orders o   
inner join OrderDetails od on o.OrderID=od.OrderID
where o.OrderStatus <> 'Cancelled' AND o.OrderStatus <> 'Returned' AND (o.OrderDate > '5/1/2014') AND (o.OrderDate < '6/1/2014') AND (od.ProductCode = 'DSC-499' or od.ProductCode = 'DSC-500')
order by o.OrderID;


--SELECT 
-- o.OrderID, 
-- o.CustomerID, 
-- o.OrderNot
--FROM  
--  Orders o  
--WHERE o.OrderID=@num;
