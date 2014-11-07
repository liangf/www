DECLARE @cp varchar(50)
SET @cp = '#{cp}'

Select ProductCode as cp
From Products
Where ProductCode= @cp
