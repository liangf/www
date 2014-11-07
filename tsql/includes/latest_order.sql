      select 
	  t.EmailAddress as emailaddress
	  , t.OrderID as orderid
	  , t.OrderDate as orderdate
	  from (
        select t1.EmailAddress, t1.OrderID, t1.OrderDate from (
          select Customers.EmailAddress, Orders.OrderID, Orders.OrderDate
          from Customers 
          inner join Orders on Customers.CustomerID=Orders.CustomerID
        ) t1 inner join (
          select Customers.EmailAddress, max(Orders.OrderDate) LatestTime
          from Customers 
          inner join Orders on Customers.CustomerID=Orders.CustomerID
          group by Customers.EmailAddress
        ) t2 on t1.EmailAddress=t2.EmailAddress and t1.OrderDate=t2.LatestTime
      ) t inner join OrderDetails od on t.OrderID = od.OrderID