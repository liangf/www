DECLARE @productcode varchar(50)
DECLARE @diff int
DECLARE @Today varchar(25), @smonth varchar(25)

SET @productcode = '#{productcode}'
SET @diff= '#{diff}'
SET @Today = GETDATE()
SET @smonth = DATEADD(month, @diff, @Today)

Select Sum(Os.Quantity) as qty,
COUNT(Os.ProductCode) as orders
FROM Orders Od INNER JOIN OrderDetails Os ON Od.OrderID = Os.OrderID
WHERE Od.Shipped= 'Y'
And (Month(Od.OrderDate)= Month(@smonth))
And (Year(Od.OrderDate)= Year(@smonth)) 
And (Os.ProductCode= @productcode)
GROUP BY Os.ProductCode

