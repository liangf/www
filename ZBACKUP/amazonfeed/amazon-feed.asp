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

Dim	upc
Dim	recommended_browse_node
Dim	manufacturer 
Dim shipping_cost
Dim model_number

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

Function PingSite( myWebsite )
' This function checks if a website is running by sending an HTTP request.
' If the website is up, the function returns True, otherwise it returns False.
' Argument: myWebsite [string] in "www.domain.tld" format, without the
' "http://" prefix.
'
' Written by Rob van der Woude
' http://www.robvanderwoude.com
    Dim intStatus, objHTTP

    Set objHTTP = CreateObject( "WinHttp.WinHttpRequest.5.1" )

    objHTTP.Open "GET", "http://" & myWebsite & "/", False
    objHTTP.SetRequestHeader "User-Agent", "Mozilla/4.0 (compatible; MyApp 1.0; Windows NT 5.1)"

    On Error Resume Next

    objHTTP.Send
    intStatus = objHTTP.Status

    On Error Goto 0

    If intStatus = 200 Then
        PingSite = True
    Else
       PingSite = False
    End If

    Set objHTTP = Nothing
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
	
	'f.Writeline ("link" & Tab & "title" & Tab & "description" & Tab & "image_link" & Tab & "price" & Tab & "id" & Tab & "payment_accepted" & Tab & "product_type" & Tab & "shipping" & Tab & "tax" & Tab & "model_number" & Tab & "quantity" & Tab & "mpn" & Tab & "gtin" & Tab & "weight" & Tab & "condition"& Tab & "expiration_date" & Tab & "brand" & Tab & "availability" & Tab & "google_product_category" & Tab & "online_only")
    
	f.Writeline ("Category" & Tab & "Title" & Tab & "Link" & Tab & "SKU" & Tab & "Price" & Tab & "Image" & Tab & "UPC" & Tab & "Brand" & Tab & "Recommended Browse Node" & Tab & "Description" & Tab & "Manufacturer" & Tab & "Mfr part number" & Tab & "Shipping Cost" & Tab & "Model Number" & Tab & "Shipping Weight")
	
	
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
	
	'Response.write(ProductItem.image_link & "<br>")
	 ProductItem.image_link= Replace(ProductItem.image_link, "Config_FullStoreURL", Config_FullStoreURL)
	 ProductItem.link= Replace(ProductItem.link, "Config_FullStoreURL", Config_FullStoreURL)
	
	
     'f.Writeline (ProductItem.link & Tab & ProductItem.title & Tab & ProductItem.description & Tab & ProductItem.image_link & Tab & ProductItem.price & Tab & ProductItem.id & Tab & payment_accepted & Tab & product_type & Tab & ProductItem.Shipping & Tab & tax & Tab & ProductItem.model_number & Tab & ProductItem.quantity & Tab & mpn & Tab & ProductItem.gtin & Tab & weight & Tab & condition & Tab & expirtation_date & Tab & brand & Tab & availability & Tab & ProductItem.google_product_category & Tab & online_only)
	

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
	image_link = "http://www.compandsave.com"

	If PingSite( image_link ) Then
		'image_link = ProductItem.image_link
		Response.write( "Web site " & image_link & " is up and running!" )
	Else
		'image_link = "http://www.compandsave.com/v/vspfiles/templates/10/images/nophoto.gif"
		Response.write("Web site " & image_link & " is down!!!")
	End If		

		
	
	f.Writeline (ProductItem.google_product_category & Tab & ProductItem.title & Tab & ProductItem.link & Tab & ProductItem.id & Tab & ProductItem.price & Tab & image_link & Tab & upc & Tab & brand & Tab & recommended_browse_node & Tab & ProductItem.description & Tab & manufacturer & Tab & mpn & Tab & shipping_cost & Tab & model_number & Tab & weight)
  Next   
   
 
  f.close 

  set f = nothing 
  set thefso = nothing 


	'Reset some objects
	Set Collector = Nothing

	

%>


