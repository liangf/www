<%@LANGUAGE="VBSCRIPT.Encode"%>
<%

Option Explicit
'Response.Buffer = True
%>
<!-- #include file="includes/configuration.inc-pricegrabber.asp" -->
<!-- #include file="includes/vbscript_extensions.inc.asp" -->
<!-- #include file="includes/volusion_api_call.inc.asp" -->
<!-- #include file="includes/pricegrabber.inc.asp" -->

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


Dim product_name
Dim nexttag_category
Dim list_price
Dim coupon_code_discount
Dim coupon_url_discount
Dim cost_per_Click

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
'Response.Write(test)
Else
Tab = chr(9)
End If
'Response.Write(Server.MapPath(CONFIGURATION_DESTINATION_PATH))
'write the txt file

 
Response.Write("<br>")


Dim d
Set d=Server.CreateObject("Scripting.Dictionary")
d.Add "gr","Green"
Response.Write("The value of key gr is: " & d.Item("gr") & "<br>")


Dim newproducts(592)
Dim cleanproducts(592)
Dim rowi
Dim tmp

Dim objFileToRead
Set objFileToRead = CreateObject("Scripting.FileSystemObject").OpenTextFile(Server.MapPath(CONFIGURATION_NEW_PRODUCT_PATH))
Dim strLine
i = 1
do while not objFileToRead.AtEndOfStream
	strLine = objFileToRead.ReadLine()
	rowi = Mid(strLine, InStr(strLine, "=")+1)
	rowi = Trim(rowi)
	tmp = LCase(rowi)
	'Response.Write(rowi & "<br>")
	newproducts(i) = rowi
	If d.Exists(tmp)=False Then
		d.Add tmp, "true"
	Else 
		Response.Write(rowi & "<br>")
	End If
	i = i + 1
loop
objFileToRead.Close
Set objFileToRead = Nothing


Function isIn(item)
	Dim found
	found = 0
	For i = 1 To 592
		If LCase(item)=LCase(newproducts(i)) Then
			found = 1
			Exit For
		End If
	Next
	isIn = found
End Function

	
Set thefso = Server.CreateObject("Scripting.FileSystemObject") 
Set f = thefso.CreateTextFile(Server.MapPath(CONFIGURATION_NEW_DATAFEED_PATH), True, False) 

'f.Writeline ("Unique Product Identifier" & Tab & "Manufacturer" & Tab & "Product Name" & Tab & "Description" & Tab & "Price" & Tab & "Click-out URL" & Tab & "NexTag Product Cat." & Tab & "Image URL" & Tab & "Stock Status" & Tab & "Product Condition" & Tab & "Ground Shipping" & Tab & "Weight" & Tab & "Promo Type" & Tab & "Promo Text" & Tab & "List Price" & Tab & "Coupon Code Discount" & Tab & "Coupon URL Discount" & Tab & "Cost-per-Click")	

f.Writeline ("Retsku" & Tab & "Product Title" & Tab & "Detailed Description" & Tab & "Categorization" & Tab & "Product URL" & Tab & "Primary Image URL" & Tab & "Selling Price" & Tab & "Regular Price" & Tab & "Condition" & Tab & "Availability" & Tab & "Manufacturer Name" & Tab & "Manufacturer Part Number" & Tab & "UPC" & Tab & "Shipping Cost" & Tab & "Weight")	
	
	For Each ProductItem In OrderObj.Products 
	condition= Null
	tax="US::0:" 
    payment_accepted="GoogleCheckout,Visa,MasterCard,AmericanExpress,Discover"
    online_only="n"
    'weight="1 pound"
    'availability ="In Stock"
	availability ="Yes"
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
	
	If ProductItem.productprice >= 50 Then
	   ProductItem.Shipping= "0.00"
	Else ProductItem.Shipping= "3.99"
	End If
	

	If brand = "HP" Then
		If InStr(ProductItem.id, "564")>0 Then
			cost_per_Click = "2.00"
		ElseIf ProductItem.productprice >= 120 Then
			cost_per_Click = "1.58"
		Else cost_per_Click = "1.40"
		End If
	ElseIf ProductItem.productprice >= 120 Then
		cost_per_Click = "1.58"
	Else cost_per_Click = "1.10"
	End If
	
	'If ProductItem.productprice >= 120 Then
	'	cost_per_Click = "1.58"
	'End If
	
	 ProductItem.image_link= Replace(ProductItem.image_link, "Config_FullStoreURL", Config_FullStoreURL)
	 ProductItem.link= Replace(ProductItem.link, "Config_FullStoreURL", Config_FullStoreURL)
	
	
	weight = ProductItem.weight

	
		
	Dim image_link
	image_link = ProductItem.image_link

	dim http: set http = CreateObject("MSXML2.XMLHTTP")
	http.open "GET", image_link, false
	http.send
	If http.status = 200 Then
		'Response.write(image_link & " -- is UP" & "<br>")
		image_link = ProductItem.image_link
	Else 
		'Response.write(image_link & " -- is DOWN" & "<br>")
		image_link = "http://www.compandsave.com/v/vspfiles/templates/10/images/nophoto.gif"
	End If
	
	
	Dim link
	link = ProductItem.link
	link = Mid(ProductItem.link, 1, InStr(ProductItem.link,"click")-1)
	link = link + "utm_source=pricegrabber&utm_medium=shoppingengine&utm_campaign=pricegrabbershopping"

	Dim upc
	upc = Trim(ProductItem.gtin)
	Dim first_char
	If upc Then
		first_char = Mid(upc, 1, 1)
		If first_char>="0" And first_char<="9" Then
		Else
			upc = Mid(upc, 2, Len(upc))
		End If
	End If

	If upc Then
		first_char = Mid(upc, 1, 1)
		If first_char="0" Then
			upc = Mid(upc, 2, Len(upc))
			first_char = Mid(upc, 1, 1)
			If first_char="0" Then
				upc = Mid(upc, 2, Len(upc))
				first_char = Mid(upc, 1, 1)
				If first_char="0" Then
					upc = Mid(upc, 2, Len(upc))
				End If
			End If		
		End IF
	End If

	If Len(upc)<12 Then
		upc = "0" & upc
	End If
	If Len(upc)<12 Then
		upc = "0" & upc
	End If
	If Len(upc)<12 Then
		upc = "0" & upc
	End If
	If Len(upc)>12 Then
		'Response.write(upc & " ----->this is an exception upc" & "<br>")
	End If		
	

	
	'If isIn(ProductItem.id)>0 Then
	If d.Exists(LCase(Trim(ProductItem.id)))=True Then
		'Response.Write(ProductItem.id & "<br>")
		f.Writeline (ProductItem.id & Tab & ProductItem.title & Tab & ProductItem.description & Tab & "Computers > Printers & Scanners > Ink & Toner" & Tab & link & Tab & image_link & Tab & ProductItem.productprice & Tab & ProductItem.listprice & Tab & condition & Tab & availability & Tab & brand & Tab & mpn & Tab & upc & Tab & ProductItem.Shipping & Tab & weight)
	End If 
	
	'f.Writeline (ProductItem.id & Tab & brand & Tab & ProductItem.title & Tab & ProductItem.description & Tab & ProductItem.productprice & Tab & link & Tab & nexttag_category & Tab & image_link & Tab & availability & Tab & condition & Tab & ProductItem.Shipping & Tab & weight & Tab & promo_type & Tab & promo_text & Tab & ProductItem.listprice & Tab & coupon_code_discount & Tab & coupon_url_discount & Tab & cost_per_Click)
	
	Next   
   
 
f.close 

set f = nothing 
set thefso = nothing 


'Reset some objects
Set Collector = Nothing	
	
%>


