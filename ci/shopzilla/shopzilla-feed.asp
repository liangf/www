<%@LANGUAGE="VBSCRIPT.Encode"%>
<%

Option Explicit
'Response.Buffer = True
%>
<!-- #include file="includes/configuration.inc-shopzilla.asp" -->
<!-- #include file="includes/vbscript_extensions.inc.asp" -->
<!-- #include file="includes/volusion_api_call.inc.asp" -->
<!-- #include file="includes/shopzillafeed.inc.asp" -->

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

Dim shopzilla_category
Dim manufacturer
Dim promo_text


'Add type headers
Response.ContentType = "text/html"
Response.Charset="windows-1252"

Sub NoResults
	Response.Write("No order was found with the information you provided. Please go back and try again.")
	Response.End()
End Sub

Function FormatSqlDate(SqlDate)
	Dim DateStr
	Dim tmpA
	Dim M
	Dim D
	Dim Y
	Dim smallD
	Dim smallM
	tmpA = Split(SqlDate,"/")
	If Ubound(tmpA) <> 2 Then
		Exit Function
	End If

	DateStr = ""
	M = tmpA(0)
	D = tmpA(1)
	Y = tmpA(2)
	 
	
	If M < 10 Then
	smallM = "0" & M
	Else
	smallM = M
	End If
	If D < 10 Then
	smallD = "0" & D
	Else
	smallD = D
	End If
	
	DateStr = Y & "-" & smallM & "-" & smallD
	FormatSqlDate = DateStr
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


  If OrderObj is Nothing Then
Response.Write("Nothing there")
'Response.Write(test)
Else
Tab = chr(9)
End If
'Response.Write(Server.MapPath(CONFIGURATION_DESTINATION_PATH))
'write the txt file
 
Set thefso = Server.CreateObject("Scripting.FileSystemObject") 
Set f = thefso.CreateTextFile(Server.MapPath(CONFIGURATION_NEW_DATAFEED_PATH), True, False) 

	f.Writeline ("Unique ID" & Tab & "Title" & Tab & "Description" & Tab & "Category" & Tab & "Product URL" & Tab & "Image URL" & Tab & "Condition" & Tab & "Availability" & Tab & "Current Price" & Tab & "Brand" & Tab & "MPN" & Tab & "Original Price" & Tab & "Ship Cost" & Tab & "Ship Weight" & Tab & "Promo Text")
    
	'f.Writeline ("Category" & Tab & "Manufacturer" & Tab & "Title" & Tab & "Description" & Tab & "Link" & Tab & "Image" & Tab & "SKU" & Tab & "Quantity on Hand" & Tab & "Condition" & Tab & "Ship. Weight" & Tab & "Ship. Cost" & Tab & "Bid" & Tab & "Promo Value" & Tab & "UPC" & Tab & "Price" & Tab & "Brand" & Tab & "MPN" & Tab & "Promo Text")
	
	'f.Writeline ("Category" & Tab & "Manufacturer" & Tab & "Title" & Tab & "Description" & Tab & "Link" & Tab & "Image" & Tab & "SKU" & Tab & "Quantity on Hand" & Tab & "Condition" & Tab & "Ship. Weight" & Tab & "Ship. Cost" & Tab & "Bid" & Tab & "Promo Value" & Tab & "UPC" & Tab & "Price")
	
	
	For Each ProductItem In OrderObj.Products 
	condition= Null
	tax="US::0:" 
    payment_accepted="GoogleCheckout,Visa,MasterCard,AmericanExpress,Discover"
    online_only="n"
    'weight="1 pound"
    availability ="In Stock"
	Base="Electronics > Print Copy Scan & Fax Accessories > Printer Accessories > Printer Consumables >"
	expirtation_date= DateAdd("d",30,Date)
	expirtation_date= FormatSqlDate(expirtation_date)
	
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
	
	If ProductItem.productprice >= 50 Then
	   ProductItem.Shipping= "0.00"
	Else ProductItem.Shipping= "3.99"
	End If
	
	If br = "USB" Then
	   ProductItem.google_product_category= "Electronics > Electronics Accessories > Cables > Data Transfer Cables > USB Cables"
	   product_type= ProductItem.google_product_category
	ElseIf br = "PH" Then
	   ProductItem.google_product_category= "Office Supplies > General Supplies > Paper Products > Printer & Copier Paper > Photo Printer Paper"
	   product_type= ProductItem.google_product_category
	ElseIf br="RIBBON" Then
	   ProductItem.google_product_category=ProductItem.google_product_category & " Printer Ribbons"
	   product_type=Base & " Printer Ribbons"
	ElseIf br="DRUM" Then
	   ProductItem.google_product_category=ProductItem.google_product_category & " Toner & Inkjet Cartridges > Printer Drum Kits"
	   product_type=Base & " Toner & Inkjet Cartridges > Printer Drum Kits"
	Else
	ProductItem.google_product_category= ProductItem.google_product_category & " Toner & Inkjet Cartridges"
	product_type=Base & " Toner & Inkjet Cartridges"
	End If
	
	
	ProductItem.image_link= Replace(ProductItem.image_link, "Config_FullStoreURL", Config_FullStoreURL)
	ProductItem.link= Replace(ProductItem.link, "Config_FullStoreURL", Config_FullStoreURL)
	
	Dim link
	link = ProductItem.link
	link = Mid(ProductItem.link, 1, InStr(ProductItem.link,"click")-1)
	link = link + "utm_source=shopzilla&utm_medium=shoppingengine&utm_campaign=shopzillashopping"
	
	tmpArray = Split(ProductItem.id,"-")
	br = tmpArray(0)
	'Response.write(br & "<br>")

	If br = "PH" Then
		shopzilla_category = "21217"
	ElseIf br = "USB" Then
		shopzilla_category = "9190"
	Else 
		shopzilla_category = "444"
	End If	
	
	
	
	Dim image_link
	image_link = ProductItem.image_link
	'Response.write(image_link & "<br>")
	dim http: set http = CreateObject("MSXML2.XMLHTTP")
	http.open "GET", image_link, false
	http.send
	If http.status = 200 Then
		'Response.write(image_link & " -- is UP" & "<br>")
		image_link = ProductItem.image_link
	Else 
		'Response.write(image_link & " -- is DOWN" & "<br>")
		image_link = "http://www.comboink.com/v/vspfiles/templates/comboink/images/nophoto.gif"
	End If

	
	Dim productprice
	productprice = ProductItem.productprice
	productprice = Mid(ProductItem.productprice, 1, InStr(ProductItem.productprice,".")+2)
	'Response.write(productprice & "<br>")


	weight = ProductItem.weight
	manufacturer = "ComboInk"
	promo_text = "Save an extra 10% now"
	
	f.Writeline (ProductItem.id & Tab & ProductItem.title & Tab & ProductItem.description & Tab & shopzilla_category & Tab & link & Tab & image_link & Tab & condition & Tab & availability & Tab & ProductItem.productprice & Tab & brand & Tab & mpn & Tab & ProductItem.listprice & Tab & ProductItem.Shipping & Tab & weight & Tab & promo_text)
	
	
	'f.Writeline (shopzilla_category & Tab & manufacturer & Tab & ProductItem.title & Tab & ProductItem.description & Tab & link & Tab & image_link & Tab & ProductItem.id & Tab & "" & Tab & condition & Tab & weight & Tab & ProductItem.Shipping & Tab & "" & Tab & "" & Tab & "" & Tab & ProductItem.productprice)
	
  Next   
   
 
  f.close 

  set f = nothing 
  set thefso = nothing 


	'Reset some objects
	Set Collector = Nothing
	

%>


