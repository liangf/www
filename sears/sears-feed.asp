<%@LANGUAGE="VBSCRIPT.Encode"%>
<%

Option Explicit
'Response.Buffer = True
%>
<!-- #include file="includes/configuration.inc-sears.asp" -->
<!-- #include file="includes/vbscript_extensions.inc.asp" -->
<!-- #include file="includes/volusion_api_call.inc.asp" -->
<!-- #include file="includes/searsfeed.inc.asp" -->


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

Dim	upc
Dim	recommended_browse_node
Dim	manufacturer 
Dim shipping_cost
Dim model_number
Dim coupon_code
Dim coupon_code_description
Dim category


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
Else 
	Tab = chr(9)
End If
'Response.Write(Server.MapPath(CONFIGURATION_DESTINATION_PATH))
'write the txt file
 
Set thefso = Server.CreateObject("Scripting.FileSystemObject") 
Set f = thefso.CreateTextFile(Server.MapPath(CONFIGURATION_NEW_DATAFEED_PATH), True, False) 
	
	'f.Writeline ("Category" & Tab & "Title" & Tab & "Link" & Tab & "SKU" & Tab & "Price" & Tab & "Image" & Tab & "UPC" & Tab & "Brand" & Tab & "Recommended Browse Node" & Tab & "Description" & Tab & "Manufacturer" & Tab & "Mfr part number" & Tab & "Shipping Cost" & Tab & "Model Number" & Tab & "Shipping Weight")
	
    
	f.Writeline ("Item ID" & Tab & "Item Class ID" & Tab & "Item Class Display Path" & Tab & "Action Flag" & Tab & "Active" & Tab & "FBS Item" & Tab & "Variation Group ID" & Tab & "Title" & Tab & "Short Description" & Tab & "Long Description" & Tab & "Seller Categories" & Tab & "Packing Slip Description" & Tab & "UPC" & Tab & "Manufacturer Model #" & Tab & "Cost" & Tab & "Standard Price" & Tab & "Sale Price" & Tab & "Sale Start Date" & Tab & "Sale End Date" & Tab & "Promotional Text" & Tab & "Brand Name" & Tab & "Shipping Length" & Tab & "Shipping Width" & Tab & "Shipping Height" & Tab & "Shipping Weight" & Tab & "Shipping Restrictions" & Tab & "Shipping Cost: Ground" & Tab & "Product Image URL")
	

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
	
	If ProductItem.price >= 50 Then
		shipping_cost = "0.00"
	Else shipping_cost = "3.99"
	End If
	
	If br = "USB" Then
	   'ProductItem.google_product_category= "Electronics > Electronics Accessories > Cables > Data Transfer Cables > USB Cables"
	   'product_type= ProductItem.google_product_category
	   product_type = "USB Cables"
	ElseIf br = "PH" Then
	   'ProductItem.google_product_category= "Office Supplies > General Supplies > Paper Products > Printer & Copier Paper > Photo Printer Paper"
	   'product_type= ProductItem.google_product_category
	   product_type = "Photo Printer Paper"
	ElseIf br="RIBBON" Then
	   'ProductItem.google_product_category=ProductItem.google_product_category & " Printer Ribbons"
	   'product_type=Base & " Printer Ribbons"
	   product_type = "Printer Ribbons"
	ElseIf br="DRUM" Then
	   'ProductItem.google_product_category=ProductItem.google_product_category & " Toner & Inkjet Cartridges > Printer Drum Kits"
	   'product_type=Base & " Toner & Inkjet Cartridges > Printer Drum Kits"
	   product_type = "Printer Drum Kits"
	Else
		'ProductItem.google_product_category= ProductItem.google_product_category & " Toner & Inkjet Cartridges"
		'product_type=Base & " Toner & Inkjet Cartridges"
		product_type = "Toner & Inkjet Cartridges"
	End If
	
	'Response.write(ProductItem.image_link & "<br>")
	 ProductItem.image_link= Replace(ProductItem.image_link, "Config_FullStoreURL", Config_FullStoreURL)
	 ProductItem.link= Replace(ProductItem.link, "Config_FullStoreURL", Config_FullStoreURL)
	
	
     'f.Writeline (ProductItem.link & Tab & ProductItem.title & Tab & ProductItem.description & Tab & ProductItem.image_link & Tab & ProductItem.price & Tab & ProductItem.id & Tab & payment_accepted & Tab & product_type & Tab & ProductItem.Shipping & Tab & tax & Tab & ProductItem.model_number & Tab & ProductItem.quantity & Tab & mpn & Tab & ProductItem.gtin & Tab & weight & Tab & condition & Tab & expirtation_date & Tab & brand & Tab & availability & Tab & ProductItem.google_product_category & Tab & online_only)
	

	upc = ProductItem.upc
	weight = ProductItem.weight
	recommended_browse_node = "Recommended Browse Node"
	manufacturer = "CompAndSave.com"
	category = "Computers > Computer Accessories > Printer Accessories"
	
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


	
	'f.Writeline (ProductItem.id & Tab & ProductItem.title & Tab & ProductItem.link & Tab & image_link & Tab & ProductItem.price & Tab & availability & Tab & condition & Tab & mpn & Tab & upc & Tab & shipping_cost & Tab & "" & Tab & coupon_code & Tab & coupon_code_description & Tab & brand & Tab & ProductItem.description & Tab & "" & Tab & category & Tab & "" & Tab & weight & Tab & "pounds")
	
	f.Writeline (ProductItem.id & Tab & "" & Tab & "" & Tab & "" & Tab & "Y" & Tab & "" & Tab & "" & Tab & ProductItem.title & Tab & ProductItem.description & Tab & "" & Tab & "" & Tab & "" & Tab & upc & Tab & model_number & Tab & "" & Tab & ProductItem.price & Tab & "" & Tab & "" & Tab & "" & Tab & "" & Tab & brand & Tab & "" & Tab & "" & Tab & "" & Tab & weight & Tab & "" & Tab & shipping_cost & Tab & image_link)
  
  Next   
   
 
  f.close 

  set f = nothing 
  set thefso = nothing 


	'Reset some objects
	Set Collector = Nothing

	

%>


