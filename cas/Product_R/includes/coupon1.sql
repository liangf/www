
DECLARE @code varchar(50)
SET @code = '#{code}'
Select D.DiscountAutoID as id
FROM Discounts D
WHERE D.CouponCode= @code
