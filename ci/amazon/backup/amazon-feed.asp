<%@LANGUAGE="VBSCRIPT.Encode"%>
<%

Option Explicit
'Response.Buffer = True
%>
<!-- #include file="includes/configuration.inc-amazon.asp" -->
<!-- #include file="includes/vbscript_extensions.inc.asp" -->
<!-- #include file="includes/volusion_api_call.inc.asp" -->
<!-- #include file="includes/Amazonfeed.inc.asp" -->


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
Dim bullet_point(5)
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
	

    
'f.Writeline ("Category" & Tab & "Title" & Tab & "Link" & Tab & "SKU" & Tab & "Price" & Tab & "Image" & Tab & "UPC" & Tab & "Brand" & Tab & "Recommended Browse Node" & Tab & "Description" & Tab & "Manufacturer" & Tab & "Mfr part number" & Tab & "Shipping Cost" & Tab & "Model Number" & Tab & "Shipping Weight" & Tab & "Bullet point1" & Tab & "Bullet point2" & Tab & "Bullet point3" & Tab & "Bullet point4" & Tab & "Keywords1" & Tab & "Keywords2" & Tab & "Keywords3" & Tab & "Keywords4")
f.Writeline ("Category" & Tab & "Title" & Tab & "Link" & Tab & "SKU" & Tab & "Price" & Tab & "Image" & Tab & "UPC" & Tab & "Brand" & Tab & "Recommended Browse Node" & Tab & "Description" & Tab & "Manufacturer" & Tab & "Mfr part number" & Tab & "Shipping Cost" & Tab & "Model Number" & Tab & "Shipping Weight" & Tab & "Bullet point1" & Tab & "Bullet point2" & Tab & "Bullet point3" & Tab & "Bullet point4" & Tab & "Bullet point5" & Tab & "Keywords1" & Tab & "Keywords2" & Tab & "Keywords3" & Tab & "Keywords4")	

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
	link = link + "utm_source=amazon&utm_medium=shoppingengine&utm_campaign=amazonshopping"
	
	
	tmpArray = Split(ProductItem.id,"-")
	br = tmpArray(0)
	'Response.write(br & "<br>")
	If br = "INK" OR br="WINK" OR br="ZINK" Then
		'amazon_category = "Printer Ink"
		amazon_category = "Electronics  > Computers & Accessories  > Cables & Accessories  > Printer Ink & Toner  > Inkjet Printer Ink"
		keywords(3) = "ink"
		keywords(4) = "ink cartridges"
	ElseIf br="TONER" OR br="WTONER" OR br="ZTONER" Then
		'amazon_category = "Printer Toner"
		amazon_category = "Electronics  > Computers & Accessories  > Cables & Accessories  > Printer Ink & Toner  > Laser Printer Toner"
		keywords(3) = "toner"
		keywords(4) = "toner cartridges"
	ElseIf br = "DRUM" Then
		'amazon_category = "Printer Drum Unit"
		amazon_category = "Electronics  > Computers & Accessories  > Cables & Accessories  > Printer Ink & Toner  > Laser Printer Toner"
		keywords(3) = "drum"
		keywords(4) = "laser drum"
	ElseIf br = "PH" Then
		amazon_category = "Office Products  > Office & School Supplies  > Paper  > Photo Paper"
	ElseIf br = "SPEC" Then
		If Instr(Lcase(ProductItem.title), "ink")>0 Then
			amazon_category = "Electronics  > Computers & Accessories  > Cables & Accessories  > Printer Ink & Toner  > Inkjet Printer Ink"
		ElseIf Instr(Lcase(ProductItem.title), "toner")>0 Then
			amazon_category = "Electronics  > Computers & Accessories  > Cables & Accessories  > Printer Ink & Toner  > Laser Printer Toner"
		Else 
			amazon_category = "Electronics  > Computers & Accessories  > Cables & Accessories  > Printer Ink & Toner  > Inkjet Printer Ink"
		End If
	Else 
		'amazon_category = "Printer Accessories"
		amazon_category = "Electronics  > Computers & Accessories  > Cables & Accessories  > Printer Accessories"
		keywords(3) = "printer accessories"
		keywords(4) = "printer supplies"
	End If
	'amazon_category = "Electronics/Accessories & Supplies/Office Electronics Accessories/Ink & Toner/Laser Printer Toner"
		
	
	tmpArray = Split(ProductItem.productdescriptionshort, "<li>")
	'Response.write(tmpArray(2) & "<br>")
	L= UBound(tmpArray)
	For i = 0 To L
		bullet_point(i+2) = tmpArray(i)
		If Len(bullet_point(i+2)) Then
			'tmp = Mid(tmp, 1, InStr(tmp,"</li>")-1)
			bullet_point(i+2) = Mid(bullet_point(i+2), 1, Len(bullet_point(i+2))-5)
			'Response.write(bullet_point(i) & ", ")
		End If
		'bullet_point(i) = tmp
	Next
	'Response.write("<br>")
	bullet_point(1) = "Satisfaction guaranteed with 1 year warranty"
	bullet_point(2) = " Order today to save an additional 10% w/ code '10AZON'"
	bullet_point(3) = "Free shipping all orders above $50"
	bullet_point(5) = bullet_point(4) & " " bullet_point(5)

	Dim des
	Dim new_old
	new_old = "New Compatible"
	des = Trim(ProductItem.description)
	
	tmpArray = Split(ProductItem.id,"-")
	'Response.write(tmpArray(UBound(tmpArray)) & "<br>")
	
	If Trim( tmpArray(UBound(tmpArray)) )="OEM" Then
		new_old = "New"
		'Response.write(ProductItem.id & "<br>")
	End If
	
	If Instr(ProductItem.id, "INK-Canon-CL-41")>0 or Instr(ProductItem.id, "INK-Canon-PG40")>0 or Instr(ProductItem.id, "INK-Lexmark-18C1960")>0 or Instr(ProductItem.id, "INK-Lexmark-18C1974")>0 Then
		new_old = "New"
		'Response.write(ProductItem.id & "<br>")
	End If
	
	If Instr(Lcase(des), "remanufactured")>0 Then
		new_old = "Remanufactured"
	End If
	
	
	
	
	tmpArray = Split(ProductItem.id,"-")
	br = tmpArray(0)
	If br = "INK" OR br="WINK" OR br="ZINK" Then
		bullet_point(4) = new_old & " ink cartridge"
	ElseIf br="TONER" OR br="WTONER" OR br="ZTONER" Then
		bullet_point(4) = new_old & " toner cartridge"
	ElseIf br = "DRUM" Then
		bullet_point(4) = new_old & " drum unit"
	ElseIf br = "RIBBON" Then
		bullet_point(4) = new_old & " ribbon"		
	ElseIf br = "PH" Then
		bullet_point(4) = "New photo paper"		
	ElseIf br = "SPEC" Then
		If Instr(Lcase(ProductItem.title), "ink")>0 Then
			bullet_point(4) = new_old & " ink cartridge"
		ElseIf Instr(Lcase(ProductItem.title), "toner")>0 Then
			bullet_point(4) = new_old & " toner cartridge"
		Else 
			bullet_point(4) = new_old & " ink cartridge"
		End If
	Else 
		bullet_point(4) = new_old & " printer accessories"
	End If	
	
	
	keywords(1) = brand
	keywords(2) = mpn
	
	
	f.Writeline (amazon_category & Tab & ProductItem.title & Tab & link & Tab & ProductItem.id & Tab & ProductItem.price & Tab & image_link & Tab & upc & Tab & "ComboInk" & Tab & recommended_browse_node & Tab & ProductItem.description & Tab & "ComboInk" & Tab & mpn & Tab & shipping_cost & Tab & model_number & Tab & weight & Tab & bullet_point(1) & Tab & bullet_point(2) & Tab & bullet_point(3) & Tab & bullet_point(4) & Tab & bullet_point(5) & Tab & keywords(1) & Tab & keywords(2) & Tab & keywords(3) & Tab & keywords(4))
  
  Next   
   
 
  f.close 

  set f = nothing 
  set thefso = nothing 


	'Reset some objects
	Set Collector = Nothing

	

%>


