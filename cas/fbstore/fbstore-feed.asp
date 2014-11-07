<%@LANGUAGE="VBSCRIPT.Encode"%>
<%

Option Explicit
'Response.Buffer = True
%>
<!-- #include file="includes/configuration.inc-fbstore.asp" -->
<!-- #include file="includes/vbscript_extensions.inc.asp" -->
<!-- #include file="includes/volusion_api_call.inc.asp" -->
<!-- #include file="includes/fbstore.inc.asp" -->


<%


Dim Collector 'As ProductsCollector

Dim HTML 'As String

Dim OrderObj 'As String

Dim Extensions

Dim thefso, f 
Dim Tab
Dim ProductItem
Dim test
Dim tmpArray
Dim brand
Dim br
Dim product_type
Dim tax 
Dim payment_accepted
Dim online_only 
Dim weight 
Dim availability  
Dim condition
Dim m_n
Dim L
Dim i
Dim mpn
Dim expirtation_date
Dim Base

Dim amazon_category
Dim	upc
Dim	recommended_browse_node
Dim	manufacturer 
Dim shipping_cost
Dim model_number
Dim bullet_point(4)
Dim keywords(4)


'Add type headers
Response.ContentType = "text/html"
Response.Charset="windows-1252"

Sub NoResults
	Response.Write("No order was found with the information you provided. Please go back and try again.")
	Response.End()
End Sub



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


If OrderObj is Nothing Then
	Response.Write("Nothing there")
Else 
	Tab = chr(9)
End If
'Response.Write(Server.MapPath(CONFIGURATION_DESTINATION_PATH))
'write the txt file
 
Set thefso = Server.CreateObject("Scripting.FileSystemObject") 
Set f = thefso.CreateTextFile(Server.MapPath(CONFIGURATION_NEW_DATAFEED_PATH), True, False) 
	

    
'f.Writeline ("productID" & "," & "title" & "," & "productURL" & "," & "imageURL" & "," & "price")
'f.Writeline ("productID" & Tab & "title" & Tab & "productURL" & Tab & "imageURL" & Tab & "price")	
'f.Writeline ("productID" & "@" & "title" & "@" & "productURL" & "@" & "imageURL" & "@" & "price")
f.Writeline ("productID" & "@" & "shortTitle" & "longTitle" & "@" & "productURL" & "@" & "imageURL" & "@" & "price")		

For Each ProductItem In OrderObj.Products 

	
	'Response.write(ProductItem.image_link & "<br>")
	ProductItem.image_link= Replace(ProductItem.image_link, "Config_FullStoreURL", Config_FullStoreURL)
	ProductItem.link= Replace(ProductItem.link, "Config_FullStoreURL", Config_FullStoreURL)
	
	

	Dim haveImage
	haveImage = 0	
	Dim image_link
	image_link = ProductItem.image_link

	dim http: set http = CreateObject("MSXML2.XMLHTTP")
	http.open "GET", image_link, false
	http.send
	If http.status = 200 Then
		'Response.write(image_link & " -- is UP" & "<br>")
		image_link = ProductItem.image_link
		haveImage = 1
	Else 
		'Response.write(image_link & " -- is DOWN" & "<br>")
		image_link = "http://www.compandsave.com/v/vspfiles/templates/10/images/nophoto.gif"
	End If

	
If haveImage>0 Then
	'f.Writeline (ProductItem.id & "," & ProductItem.title & "," & ProductItem.link & "," & ProductItem.image_link & "," & ProductItem.price)
	'f.Writeline (ProductItem.id & Tab & ProductItem.description & Tab & ProductItem.link & Tab & ProductItem.image_link & Tab & ProductItem.price)
	f.Writeline (ProductItem.id & "@" & ProductItem.title & "@" & ProductItem.description & "@" & ProductItem.link & "@" & ProductItem.image_link & "@" & ProductItem.price)
End If
  
  Next   
   
 
  f.close 

  set f = nothing 
  set thefso = nothing 


	'Reset some objects
	Set Collector = Nothing

	

%>


