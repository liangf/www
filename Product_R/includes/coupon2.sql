DECLARE @productcode varchar(50)
DECLARE @sm varchar(10)
DECLARE @em varchar(10)


SET @productcode= '#{productcode}'
SET @sm = '#{sm}'
SET @em = '#{em}'


Select COUNT(Os.Productcode) as qty
FROM Orders Od INNER JOIN OrderDetails Os ON Od.OrderID = Os.OrderID
WHERE Os.Productcode= @productcode
And (Od.Shipped= 'Y')
And (Od.OrderDate BETWEEN @sm + ' 00:00:00' AND @em + ' 23:59:59')
Group By Os.Productcode