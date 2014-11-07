
 
 

SELECT
'Config_FullStoreURLProductDetails.asp?ProductCode=' + p.ProductCode + '&click=20&utm_source=froogleink&utm_medium=cas'  AS link
, pe.ProductNameShort AS title
, p.ProductName AS description
, 'Config_FullStoreURLv/vspfiles/photos/original/' + IsNull(p.Photos_Cloned_From,p.ProductCode) + '.jpg' AS image_link  
, pe.ProductPrice AS productprice
, pe.ListPrice  AS listprice 
, p.ProductCode AS id 
, 'US::Ground:' AS Shipping  
, p.StockStatus As quantity
, IsNull(pe.Yahoo_Category, pe.Book_ISBN) AS model_number
, pe.UPC_Code As gtin
 
, 'Electronics > Print, Copy, Scan & Fax Accessories > Printer Accessories > Printer Consumables >' As google_product_category
, pe.ProductWeight As weight
 
FROM Products p
INNER JOIN Products_Descriptions pd ON p.ProductID = pd.ProductID
INNER JOIN Products_Extended pe ON pd.ProductID = pe.ProductID


WHERE (p.IsChildOfProductCode is NULL OR p.IsChildOfProductCode = '')
AND (p.HideProduct is NULL OR p.HideProduct <> 'Y' OR p.ProductCode like 'SPEC%')
AND (pe.ProductPrice > 0)
AND (p.StockStatus > 0)
AND (pe.Yahoo_Medium = '444')

ORDER BY p.ProductCode