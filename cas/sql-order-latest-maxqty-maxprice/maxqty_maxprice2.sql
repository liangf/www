select tb2.CustomerID, tb2.OrderID, tb2.LatestTime, tb2.OrderDetailID, tb2.ProductCode, tb1.maxQuantity, tb1.maxProductPrice from (
  select ttt2.CustomerID, ttt1.maxQuantity, max(ttt2.ProductPrice) as maxProductPrice from (
    select tt1.CustomerID,  max(od.Quantity) as maxQuantity from (
      select t2.CustomerID, t2.OrderID, t1.LatestTime from (
        select CustomerID, max(OrderDate) as LatestTime
        from Orders 
        group by CustomerID
      ) t1 inner join (
        select CustomerID, OrderID, OrderDate 
        from Orders 
      ) t2 on t1.CustomerID=t2.CustomerID and t1.LatestTime=t2.OrderDate
    ) tt1 inner join OrderDetails od on tt1.OrderID=od.OrderID
    group by tt1.CustomerID
  ) ttt1 inner join (
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
  ) ttt2 on ttt1.CustomerID=ttt2.CustomerID and ttt1.maxQuantity=ttt2.Quantity
  group by ttt2.CustomerID, ttt1.maxQuantity
) tb1 inner join (
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
) tb2 on tb1.CustomerID=tb2.CustomerID and tb1.maxQuantity=tb2.Quantity and tb1.maxProductPrice=tb2.ProductPrice