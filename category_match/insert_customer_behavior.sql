insert into customer_behavior (EmailAddress, ProductCode, ProductName, ProductPrice, ListPrice) 
SELECT EmailAddress, ProductCode, ProductName, max(ProductPrice) as ProductPrice, ListPrice FROM customer_behavior_cas group by EmailAddress