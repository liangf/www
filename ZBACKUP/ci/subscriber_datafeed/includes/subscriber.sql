SELECT
CustomerID,  
FirstName,  
LastName, 
EmailAddress 

FROM Customers

WHERE 
LastModified > DATEADD(DAY,-1,getdate()) AND EmailSubscriber = 'Y' AND LOWER(EmailAddress) NOT LIKE '%click.com%' AND LOWER(EmailAddress) NOT LIKE '%spamcop.com%'
--LastModified > '02/17/2014' AND EmailSubscriber = 'Y'

ORDER BY CustomerID 
