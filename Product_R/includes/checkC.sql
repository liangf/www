DECLARE @cc varchar(50)
SET @cc = '#{cc}'

Select CouponCode as cc
From Discounts
Where CouponCode= @cc