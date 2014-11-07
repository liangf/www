<%@LANGUAGE="VBSCRIPT.Encode"%>
<%

Option Explicit
'Response.Buffer = True
%>
<!-- #include file="includes/configuration.inc-adroll.asp" -->
<!-- #include file="includes/vbscript_extensions.inc.asp" -->
<!-- #include file="includes/volusion_api_call.inc.asp" -->
<!-- #include file="includes/adroll.inc.asp" -->


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
	

    
f.Writeline ("Product IDs" & Tab & "Titles" & Tab & "Image URLs" & Tab & "Landing page URLs" & Tab & "Prices" & Tab & "Descriptions" & Tab & "Product Categories" & Tab & "Taglines")
	

For Each ProductItem In OrderObj.Products 
	condition= Null
	tax="US::0:" 
    payment_accepted="GoogleCheckout,Visa,MasterCard,AmericanExpress,Discover"
    online_only="n"
    'weight="1 pound"
    availability ="In Stock"
	Base="Electronics > Print Copy Scan & Fax Accessories > Printer Accessories > Printer Consumables >"
	
	tmpArray = Split(ProductItem.id,"-")
	brand= tmpArray(1)
	br= tmpArray(0)
	L= UBound(tmpArray)
	 
    If brand="Kyocera" OR brand="Konica" Then
	   Select Case L
	   Case 3
	   mpn= tmpArray(3)
	   case 4
	   mpn= tmpArray(3)& "-" & tmpArray(4) 
	   case else
	   mpn= tmpArray(3)
	        For i=4 To L
	        mpn= mpn & "-" & tmpArray(i)
	        Next
	   End Select
	ElseIf br = "USB" OR br="PH" Then mpn= tmpArray(1)
	   For i=2 To L
	   mpn=mpn & "-" & tmpArray(i)
	   Next
	ElseIf br="SOY" Then mpn=ProductItem.id
	Else
     Select Case L
	   Case 1
	   mpn= Null
	   Case 2
	   mpn= tmpArray(2)
	   case 3
	   mpn= tmpArray(2)& "-" & tmpArray(3) 
	   case else
	   mpn= tmpArray(2)
	        For i=3 To L
	        mpn= mpn & "-" & tmpArray(i)
	        Next
	   End Select
	End If
	
	If brand="Epson" Then
	condition= "Refurbished"
	Else condition= "New"
	End If 
	
    If br = "USB" OR br="SIGN" OR br="PH" OR br="SOY" OR br="RFKT" Then
	       brand = "Generic"
	ElseIf brand = "Kyocera" Then
	       brand = "Kyocera-Mita"
     
	ElseIf brand = "Konica"  Then
		   brand = "Konica-Minolta"
    End If
	
	If ProductItem.price >= 50 Then
		shipping_cost = "0.00"
	Else shipping_cost = "3.99"
	End If
	

	
	'Response.write(ProductItem.image_link & "<br>")
	ProductItem.image_link= Replace(ProductItem.image_link, "Config_FullStoreURL", Config_FullStoreURL)
	ProductItem.link= Replace(ProductItem.link, "Config_FullStoreURL", Config_FullStoreURL)
	
	

	

	upc = ""
	weight = ProductItem.weight
	recommended_browse_node = "Recommended Browse Node"
	manufacturer = "CompAndSave.com"
	
	tmpArray = Split(ProductItem.id,"-")
	br = tmpArray(0)
	'Response.write(br & "<br>")
	If br = "INK" OR br="WINK" OR br="ZINK" Then
		recommended_browse_node = "172640"
	ElseIf br = "DRUM" OR br="TONER" OR br="WTONER" OR br="ZTONER" Then
		recommended_browse_node = "172641"
	ElseIf br = "PH" Then
		recommended_browse_node = "1069722"
	ElseIf br = "RIBBON" Then
		recommended_browse_node = "172639"
	Else 
		recommended_browse_node = "172636"
	End If
		
	model_number = ProductItem.model_number
	if Len(ProductItem.model_number)>40 Then
		tmpArray = Split(ProductItem.model_number, ",")
		L= UBound(tmpArray)
		model_number = tmpArray(0)
		For i = 1 To L
			test = model_number & ", " & tmpArray(i)
			if Len(test)>40 Then 
				Exit For
			Else 
				model_number = test
			End If
		Next
		'Response.write(model_number & ", " & Len(model_number) & "<br>")
	End If
		
	If br = "USB" Then
	   ProductItem.google_product_category= "Electronics > Electronics Accessories > Cables > Data Transfer Cables > USB Cables"
	ElseIf br = "PH" Then
	   ProductItem.google_product_category= "Office Supplies > General Supplies > Paper Products > Printer & Copier Paper > Photo Printer Paper"
	ElseIf br="RIBBON" Then
	   ProductItem.google_product_category=ProductItem.google_product_category & " Printer Ribbons"
	ElseIf br="DRUM" Then
	   ProductItem.google_product_category=ProductItem.google_product_category & " Toner & Inkjet Cartridges > Printer Drum Kits"
	Else
		ProductItem.google_product_category= ProductItem.google_product_category & " Toner & Inkjet Cartridges"
	End If

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

	

	
	Dim taglines
	taglines = "Order your ink & toner cartridges at Comboink.com & save up to 80% instantly! Enjoy Free Shipping on any order $50 or more"
	
If haveImage>0 Then	
	f.Writeline (ProductItem.id & Tab & ProductItem.title & Tab & image_link & Tab & ProductItem.link & Tab & ProductItem.price & Tab & ProductItem.title & Tab & ProductItem.google_product_category & Tab & taglines)
End If
  
  Next   
   
 
  f.close 

  set f = nothing 
  set thefso = nothing 


	'Reset some objects
	Set Collector = Nothing

	

%>


