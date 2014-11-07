select tt1.CustomerID, tt1.OrderID, tt1.LatestTime, od.OrderDetailID, od.ProductCode, od.Quantity, od.ProductPrice from (
  select t2.CustomerID, t2.OrderID, t1.LatestTime from (
    select CustomerID, max(OrderDate) as LatestTime
    from Orders 
    group by CustomerID
  ) t1 inner join (
    select CustomerID, OrderID, OrderDate 
    from Orders 
  ) t2 on t1.CustomerID=t2.CustomerID and t1.LatestTime=t2.OrderDate
) tt1 inner join OrderDetails od on tt1.OrderID=od.OrderID