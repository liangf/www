<%@LANGUAGE="VBSCRIPT.Encode"%>
<%

Option Explicit
'Response.Buffer = True
%>
<!-- #include file="includes/configuration.inc.asp" -->
<!-- #include file="includes/cache.inc.asp" -->
<!-- #include file="includes/vbscript_extensions.inc.asp" -->
<!-- #include file="includes/volusion_api_call.inc.asp" -->
<!-- #include file="includes/Googlefeed.inc.asp" -->

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
Dim model_number
Dim expirtation_date
Dim Base



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
	
	f.Writeline ("link" & Tab & "title" & Tab & "description" & Tab & "image_link" & Tab & "price" & Tab & "id" & Tab & "payment_accepted" & Tab & "product_type" & Tab & "shipping" & Tab & "tax" & Tab & "model_number" & Tab & "quantity" & Tab & "mpn" & Tab & "gtin" & Tab & "weight" & Tab & "condition"& Tab & "expiration_date" & Tab & "brand" & Tab & "availability" & Tab & "google_product_category" & Tab & "online_only")
    
	
	
	For Each ProductItem In OrderObj.Products 
	condition= Null
	tax="US::0:" 
    payment_accepted="GoogleCheckout,Visa,MasterCard,AmericanExpress,Discover"
    online_only="n"
    weight="1 pound"
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
	   model_number= tmpArray(3)
	   case 4
	   model_number= tmpArray(3)& "-" & tmpArray(4) 
	   case else
	   model_number= tmpArray(3)
	        For i=4 To L
	        model_number= model_number & "-" & tmpArray(i)
	        Next
	   End Select
	ElseIf br = "USB" OR br="PH" Then model_number= tmpArray(1)
	   For i=2 To L
	   model_number=model_number & "-" & tmpArray(i)
	   Next
	ElseIf br="SOY" Then model_number=ProductItem.id
	Else
     Select Case L
	   Case 1
	   model_number= Null
	   Case 2
	   model_number= tmpArray(2)
	   case 3
	   model_number= tmpArray(2)& "-" & tmpArray(3) 
	   case else
	   model_number= tmpArray(2)
	        For i=3 To L
	        model_number= model_number & "-" & tmpArray(i)
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
	   ProductItem.Shipping= ProductItem.Shipping & "0"
	Else ProductItem.Shipping= ProductItem.Shipping & "3.99"
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
	
	If ProductItem.mpn= "1" Then
	ProductItem.mpn= model_number
	
	End If
	
	 ProductItem.image_link= Replace(ProductItem.image_link, "Config_FullStoreURL", Config_FullStoreURL)
	 ProductItem.link= Replace(ProductItem.link, "Config_FullStoreURL", Config_FullStoreURL)
	
	
     f.Writeline (ProductItem.link & Tab & ProductItem.title & Tab & ProductItem.description & Tab & ProductItem.image_link & Tab & ProductItem.price & Tab & ProductItem.id & Tab & payment_accepted & Tab & product_type & Tab & ProductItem.Shipping & Tab & tax & Tab & model_number & Tab & ProductItem.quantity & Tab & ProductItem.mpn & Tab & ProductItem.gtin & Tab & weight & Tab & condition & Tab & expirtation_date & Tab & brand & Tab & availability & Tab & ProductItem.google_product_category & Tab & online_only)
	
	
  Next   
   
 
  f.close 

  set f = nothing 
  set thefso = nothing 


	'Reset some objects
	Set Collector = Nothing
	

%>


