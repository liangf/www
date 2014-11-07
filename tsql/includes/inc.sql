
 
 

SELECT
p.ProductCode AS id 
, IsNull(pe.SalePrice,pe.ProductPrice) AS price

FROM Products p
INNER JOIN Products_Descriptions pd ON p.ProductID = pd.ProductID
INNER JOIN Products_Extended pe ON pd.ProductID = pe.ProductID


WHERE (p.IsChildOfProductCode is NULL OR p.IsChildOfProductCode = '')
AND (p.HideProduct is NULL OR p.HideProduct <> 'Y' OR p.ProductCode like 'SPEC%')
AND (pe.ProductPrice > 0)
AND (p.StockStatus > 0)
AND (pe.Yahoo_Medium = '444')

ORDER BY p.ProductCode