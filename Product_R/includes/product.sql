DECLARE @productcode varchar(50)
DECLARE @mm int
DECLARE @yy int

SET @productcode = '#{productcode}'
SET @mm = '#{mm}'
SET @yy = '#{yy}'

Select Sum(Os.Quantity) as qty,
COUNT(Os.ProductCode) as orders
FROM Orders Od INNER JOIN OrderDetails Os ON Od.OrderID = Os.OrderID
WHERE Od.Shipped= 'Y'
And (Month(Od.OrderDate)= @mm)
And (Year(Od.OrderDate)= @yy) 
And (Os.ProductCode= @productcode)
GROUP BY Os.ProductCode

