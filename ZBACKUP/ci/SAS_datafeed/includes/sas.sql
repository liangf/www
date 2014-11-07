SELECT
p.ProductCode AS SKU
, p.ProductName AS Name
, 'Config_FullStoreURLProductDetails.asp?ProductCode=' + p.ProductCode + '&click=360&utm_source=sas&utm_medium=cas' AS URL
, pe.ProductPrice AS Price
, pe.ListPrice AS RetailPrice
, p.Photos_Cloned_From
, 'Config_FullStoreURLConfig_ProductPhotosFolder/' + IsNull(p.Photos_Cloned_From,p.ProductCode) + '-2.jpg' AS Full_Image
, 'Config_FullStoreURLConfig_ProductPhotosFolder/' + IsNull(p.Photos_Cloned_From,p.ProductCode) + '-1.jpg' AS Thumbnail_Image
, pe.METATAG_Title AS Description
, pe.ProductKeywords AS Search_Terms 
, pe.Affiliate_Commissionable_Value AS ReservedForFutureUse
, pd.ProductDescription As base

FROM Products p
INNER JOIN Products_Descriptions pd ON p.ProductID = pd.ProductID
INNER JOIN Products_Extended pe ON pd.ProductID = pe.ProductID

WHERE (p.IsChildOfProductCode is NULL OR p.IsChildOfProductCode = '')
AND (p.HideProduct is NULL OR p.HideProduct <> 'Y')
AND (pe.ProductPrice > 0 AND pe.ProductPrice IS NOT NULL)

ORDER BY p.ProductCode