<%@LANGUAGE="VBSCRIPT.Encode"%>
<%

Option Explicit
'Response.Buffer = True
%>
<!-- #include file="includes/configuration.inc.asp" -->
<!-- #include file="includes/vbscript_extensions.inc.asp" -->
<!-- #include file="includes/volusion_api_call.inc.asp" -->
<!-- #include file="includes/sas.inc.asp" -->
<%
Dim Collector 'As ProductsCollector
Dim OrderObj 'As String
Dim thefso, f 
Dim fs
Dim ProductItem
Dim tmpArray
Dim brand, color, compatibleprinter
Dim br
Dim Arr
Dim L
Dim model_number
Dim a,b,c,a2,b2,c2


'Add type headers
Response.ContentType = "text/html"
Response.Charset="windows-1252"

Function stripTags(HTMLstring)
    Dim RegularExpressionObject
	Dim j
    Set RegularExpressionObject = New RegExp
    With RegularExpressionObject
   .Pattern = "<[^>]+>"
   .IgnoreCase = True
   .Global = True
   End With
  HTMLstring = Replace(HTMLstring, CHR(13), " ")
  HTMLstring = Replace(HTMLstring, CHR(10), " ")
  stripTags = RegularExpressionObject.Replace(HTMLstring, " ")
  stripTags= Replace(stripTags, "&nbsp;", "") 
  
  For j = 1 To Len(stripTags)
  stripTags=Replace(stripTags,"  "," ")   
  Next
 Set RegularExpressionObject = nothing
 End Function 
 
Function stripA(HTMLstring)
    Dim ObjectEx
	Dim j
    Set ObjectEx = New RegExp
    With ObjectEx
   .Pattern = "<a href=(.*)>(.*)</a>"
   .IgnoreCase = True
   .Global = True
   End With
  HTMLstring = Replace(HTMLstring, CHR(13), " ")
  HTMLstring = Replace(HTMLstring, CHR(10), " ")
  stripA = ObjectEx.Replace(HTMLstring, " ")
 Set ObjectEx = nothing
 End Function 

'Missing the cache, lets create it
Set Collector = New OrderTrackingCollector
Collector.DomainName = CONFIGURATION_DOMAIN_NAME
Collector.UserName = CONFIGURATION_USER_NAME
Collector.Password = CONFIGURATION_PASSWORD
Collector.UseSSL = CONFIGURATION_USE_SSL
Collector.InstallPath = Server.MapPath(CONFIGURATION_INSTALL_PATH)
Collector.DestinationPath = Server.MapPath(CONFIGURATION_DESTINATION_PATH)
 
Set OrderObj = Collector.RetrievePt()
 

'Response.Write(Server.MapPath(CONFIGURATION_DESTINATION_PATH))
'write the txt file

'Set thefso = Server.CreateObject("Scripting.FileSystemObject") 
'Set f = thefso.CreateTextFile(Server.MapPath(CONFIGURATION_NEW_DATAFEED_PATH), True, False) 
	
	'f.Writeline ("sku,name,url,price,retailprice,full image,thumbnail image,commission,category,subcategory,description,search terms,status,merchantid,custom1,custom2,custom3,custom4,custom5,manufacturer,partnumber,merchantcategory,merchantsubcategory,shortdescription,isbn,upc,crosssell,merchantgroup,merchantsubgroup,compatiblewith,compareto,quantitydiscount,bestseller,addtocarturl,reviewsrssurl,option1,option2,option3,option4,option5,reservedforfutureuse,reservedforfutureuse,reservedforfutureuse,reservedforfutureuse,reservedforfutureuse,reservedforfutureuse,reservedforfutureuse,reservedforfutureuse,reservedforfutureuse,reservedforfutureuse")
    
	For Each ProductItem In OrderObj.Products 
	ProductItem.Description=stripTags(ProductItem.Description) 
	color=stripTags(ProductItem.base)
	tmpArray = Split(ProductItem.SKU,"-")
	brand= tmpArray(1)
	br= tmpArray(0)
	
	If br = "USB" OR br="PH" OR br="RFKT" Then
	color=""
	compatibleprinter=""
	Else 
	color=Replace(color,"Color", "$")
	color=Replace(color,"Contents", "$")
	Arr= Split(color, "$")
	color= Arr(1)
	color = Trim(color)
	'find compatible printers
	compatibleprinter=stripA(ProductItem.base)
	
    End If
	
	
    If br = "USB" OR br="SIGN" OR br="PH" OR br="SOY" OR br="RFKT" Then
	       brand = "Generic"
	ElseIf brand = "Kyocera" Then
	       brand = "Kyocera-Mita"
	ElseIf brand = "Konica"  Then
		   brand = "Konica-Minolta"
    End If
	ProductItem.URL= Replace(ProductItem.URL, "Config_FullStoreURL", Config_FullStoreURL)
	ProductItem.Full_Image= Replace(ProductItem.Full_Image, "Config_FullStoreURL", Config_FullStoreURL)
	ProductItem.Thumbnail_Image= Replace(ProductItem.Thumbnail_Image, "Config_FullStoreURL", Config_FullStoreURL) 
	
	 'check image existance
	 If ProductItem.Photos_Cloned_From <> "" Then
	 a= ProductItem.Photos_Cloned_From & "-1.jpg"
	 Else a= ProductItem.SKU & "-1.jpg"
	 End If
	 
	 If ProductItem.Photos_Cloned_From <> "" Then
	 a2= ProductItem.Photos_Cloned_From & "-2.jpg"
	 Else a2= ProductItem.SKU & "-2.jpg"
	 End If
	 
	 b= Server.MapPath(a)
	 c= left(b,instr(b,"root")+3)
     a= c & Config_ProductPhotosFolder & a
	 b2= Server.MapPath(a2)
	 c2= left(b2,instr(b2,"root")+3)
     a2= c2 & Config_ProductPhotosFolder & a2
	 set fs=Server.CreateObject("Scripting.FileSystemObject")
	 if fs.FileExists(a) then
	 ProductItem.Thumbnail_Image= Replace(ProductItem.Thumbnail_Image, "Config_FullStoreURL", Config_FullStoreURL)
	 else
	 ProductItem.Thumbnail_Image=""
     end if
	 if fs.FileExists(a2) then
	 ProductItem.Full_Image= Replace(ProductItem.Full_Image, "Config_FullStoreURL", Config_FullStoreURL)
	 else
	 ProductItem.Full_Image=""
     end if
	 set fs=nothing
	'f.Writeline
     Response.write (ProductItem.SKU & "," & ProductItem.Name & "," & ProductItem.URL & "," & ProductItem.Price & "," & brand & "," & ProductItem.RetailPrice & "," & ProductItem.Full_Image & "," & ProductItem.Thumbnail_Image & "," & ProductItem.Description & "," & ProductItem.Search_Terms & "," & ProductItem.ReservedForFutureUse & "," & color & "," & compatibleprinter)
	
    
  Next   
  
 
 ' f.close 

  'set f = nothing 
  'set thefso = nothing 


	'Reset some objects
	Set Collector = Nothing
	

%>


