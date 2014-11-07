
 
 

SELECT
'Config_FullStoreURLProductDetails.asp?ProductCode=' + p.ProductCode + '&utm_source=adroll&utm_medium=CPC&utm_campaign=liquidads'  AS link
, pe.ProductNameShort AS title
, p.ProductName AS description
, 'Config_FullStoreURLv/vspfiles/photos/original/' + IsNull(p.Photos_Cloned_From,p.ProductCode) + '.jpg' AS image_link  
, IsNull(pe.SalePrice,pe.ProductPrice) AS price
, p.ProductCode AS id 
, 'US::Ground:' AS Shipping  
, p.StockStatus As quantity
, IsNull(pe.Yahoo_Category, pe.Book_ISBN) AS model_number
, pe.UPC_Code As gtin
 
, 'Electronics > Print, Copy, Scan & Fax Accessories > Printer Accessories > Printer Consumables >' As google_product_category
, pe.UPC_code As upc
, pe.ProductWeight as weight
, pd.ProductDescriptionShort As productdescriptionshort 
, pd.ProductDescription As productdescription

FROM Products p
INNER JOIN Products_Descriptions pd ON p.ProductID = pd.ProductID
INNER JOIN Products_Extended pe ON pd.ProductID = pe.ProductID


WHERE (p.IsChildOfProductCode is NULL OR p.IsChildOfProductCode = '')
AND (p.HideProduct is NULL OR p.HideProduct <> 'Y' OR p.ProductCode like 'SPEC%')
AND (pe.ProductPrice > 0)
AND (p.StockStatus > 0)
AND (pe.Yahoo_Medium = '444')

ORDER BY p.ProductCode