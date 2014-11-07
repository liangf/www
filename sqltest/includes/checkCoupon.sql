DECLARE @cc varchar(50)
SET @cc = '#{cc}'

Select CouponCode as cc
From Discounts
Where CouponCode= @cc

--SELECT 
-- o.OrderID, 
-- o.CustomerID, 
-- o.OrderNot
--FROM  
--  Orders o  
--WHERE o.OrderID=@num;
