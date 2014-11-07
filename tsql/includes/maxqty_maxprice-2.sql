select 
ttt2.EmailAddress as emailaddress
, ttt2.ProductCode as productcode
, ttt1.maxQuantity as maxquantity
, ttt1.maxProductPrice as maxproductprice
from (
  select tt2.EmailAddress, tt2.Quantity as maxQuantity, max(tt2.ProductPrice) as maxProductPrice from (
    select tt.EmailAddress, max(tt.Quantity) as maxQuantity  from (
      select t.EmailAddress, t.OrderID, t.OrderDate, od.OrderDetailID, od.ProductCode, od.Quantity, od.ProductPrice from (
        select t1.EmailAddress, t1.OrderID, t1.OrderDate from (
          select Customers.EmailAddress, Orders.OrderID, Orders.OrderDate
          from Customers 
          inner join Orders on Customers.CustomerID=Orders.CustomerID
        ) t1 inner join (
          SELECT Customers.EmailAddress, max(Orders.OrderDate) LatestTime
          from Customers 
          INNER JOIN Orders ON Customers.CustomerID=Orders.CustomerID
          group by Customers.EmailAddress
        ) t2 on t1.EmailAddress=t2.EmailAddress and t1.OrderDate=t2.LatestTime
      ) t inner join OrderDetails od ON t.OrderID = od.OrderID
    ) tt group by tt.EmailAddress
  ) tt1 inner join ( 
      select t.EmailAddress, od.ProductCode, od.Quantity, od.ProductPrice from (
        select t1.EmailAddress, t1.OrderID, t1.OrderDate from (
          select Customers.EmailAddress, Orders.OrderID, Orders.OrderDate
          from Customers 
          inner join Orders on Customers.CustomerID=Orders.CustomerID
        ) t1 inner join (
          SELECT Customers.EmailAddress, max(Orders.OrderDate) LatestTime
          from Customers 
          INNER JOIN Orders ON Customers.CustomerID=Orders.CustomerID
          group by Customers.EmailAddress
        ) t2 on t1.EmailAddress=t2.EmailAddress and t1.OrderDate=t2.LatestTime
      ) t inner join OrderDetails od ON t.OrderID = od.OrderID
  ) tt2 on tt2.EmailAddress=tt1.EmailAddress and tt2.Quantity=tt1.maxQuantity
  group by tt2.EmailAddress, tt2.Quantity
) ttt1 inner join (
      select t.EmailAddress, t.OrderID, t.OrderDate, od.OrderDetailID, od.ProductCode, od.Quantity, od.ProductPrice from (
        select t1.EmailAddress, t1.OrderID, t1.OrderDate from (
          select Customers.EmailAddress, Orders.OrderID, Orders.OrderDate
          from Customers 
          inner join Orders on Customers.CustomerID=Orders.CustomerID
        ) t1 inner join (
          SELECT Customers.EmailAddress, max(Orders.OrderDate) LatestTime
          from Customers 
          INNER JOIN Orders ON Customers.CustomerID=Orders.CustomerID
          group by Customers.EmailAddress
        ) t2 on t1.EmailAddress=t2.EmailAddress and t1.OrderDate=t2.LatestTime
      ) t inner join OrderDetails od ON t.OrderID = od.OrderID
) ttt2 on ttt2.EmailAddress=ttt1.EmailAddress and ttt2.Quantity=ttt1.maxQuantity and ttt2.ProductPrice=ttt1.maxProductPrice