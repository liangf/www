<%@LANGUAGE="VBSCRIPT.Encode"%>
<%
Option Explicit
'Response.Buffer = True
%>
<!-- #include file="includes/vbscript_extensions.inc.asp" -->
<!-- #include file="includes/configuration.inc.asp" -->
<!-- #include file="includes/volusion_api_call.inc.asp" -->

<%

Class OrderTrackingCollector

	Private mVBExt 'As VBScriptExtensions
	
	Private mVolusionAPICallObject 'As VolusionAPICall
	Private mFSO 'As Scripting.FileSystemObject
	
	Private mInstallPath 'As String
	
	Private Sub Class_Initialize()
		Set mVBExt = New VBScriptExtensions
		Set mVolusionAPICallObject = Nothing
		Set mFSO = Nothing
	End Sub
	
	Private Sub Class_Terminate()
		Set mFSO = Nothing
		Set mVolusionAPICallObject = Nothing
		Set mVBExt = Nothing
	End Sub
	
	Private Property Get VolusionAPICallObject() 'As VolusionAPICall
		If mVolusionAPICallObject Is Nothing Then
			Set mVolusionAPICallObject = New VolusionAPICall
		End If
		Set VolusionAPICallObject = mVolusionAPICallObject
	End Property
	
	Private Property Get FSO() 'As Scripting.FileSystemObject
		If mFSO Is Nothing Then
			Set mFSO = Server.CreateObject("Scripting.FileSystemObject")
		End If
		Set FSO = mFSO
	End Property
	
	Public Property Let InstallPath(ByVal vInstallPath)
		mInstallPath = vInstallPath
	End Property
	
	Public Property Let DestinationPath(ByVal vDestinationPath)
		VolusionAPICallObject.DestinationPath = vDestinationPath
	End Property
		
	Public Property Let DomainName(ByVal vDomainName)
		VolusionAPICallObject.DomainName = vDomainName
	End Property
	
	Public Property Let UserName(ByVal vUserName)
		VolusionAPICallObject.UserName = vUserName
	End Property
	
	Public Property Let Password(ByVal vPassword)
		VolusionAPICallObject.Password = vPassword
	End Property
	
	Public Property Let UseSSL(ByVal vUseSSL)
		VolusionAPICallObject.UseSSL = vUseSSL
	End Property
Public Function ExtractPrinterList() 'As ParentCategory
		Dim SQL 'As String
		Dim Document 'As MSXML.Document
		Dim Node	
		Dim CustomerNode
		Dim categoryname
		Dim result 


		Set ExtractPrinterList = Nothing
		Server.ScriptTimeout= 2999
		
		'Setup SQL using template
		'SQL = "SELECT CategoryName FROM Categories WHERE CategoryOrder = '110' AND Hidden <> 'Y' AND ParentID <> 174"
		SQL = "SELECT METATAG_Title FROM Categories WHERE CategoryOrder = '110' AND Hidden <> 'Y' AND ParentID <> 174"
		'Make custom API call
		Call VolusionAPICallObject.DoCustomAPICall( _
			SQL, _
			VolusionAPICallObject.ReadFile( _
				FSO.BuildPath(mInstallPath, CONFIGURATION_XSD_FILE) _
			) _
		) 
	Set Document = VolusionAPICallObject.ResponseXML
		Set CustomerNode = Document.documentElement.selectNodes("Products")
		Set Document = Nothing	
		result = ""	
		For each Node in CustomerNode
			'OrderID = Field(Node, "OrderID")
			'FirstName = Field(Node, "FirstName")
			'LastName = Field(Node, "LastName")
			'Address = Field(Node, "ShipAddress1") & " " & Field(Node, "ShipAddress2") 
			'City = Field(Node, "ShipCity") 
			'State = Field(Node, "ShipState")
			'PostCode = Field(Node, "ShipPostalCode")
			'Country = Field(Node, "ShipCountry")
			categoryname = Field(Node, "METATAG_Title")
			result = result & categoryname & ","
	    Next 

		ExtractPrinterList = result
		
	End Function	
	
Public Function ExtractProduct(ByVal ProductCode) 'As ParentCategory
		Dim SQL 'As String
		Dim Document 'As MSXML.Document
		Dim Node	
		Dim CustomerNode 
		Dim ProductName
		Dim Related 
		Dim ProductPrice
		Dim RetailPrice 



		Set ExtractProduct = Nothing
		Server.ScriptTimeout= 2999
		if ProductCode <> "" then 
			'Setup SQL using template
			SQL = "SELECT p.ProductName, pe.Accessories, pe.ProductPrice, pe.ListPrice FROM Products p INNER JOIN Products_Extended pe On pe.ProductID = p.ProductID WHERE p.ProductCode ='" & ProductCode & "';" 
			'Make custom API call
			Call VolusionAPICallObject.DoCustomAPICall( _
				SQL, _
				VolusionAPICallObject.ReadFile( _
				FSO.BuildPath(mInstallPath, CONFIGURATION_XSD_FILE) _
				) _
			) 
			Set Document = VolusionAPICallObject.ResponseXML
			Set CustomerNode = Document.documentElement.selectNodes("Products")
			Set Document = Nothing		
			For each Node in CustomerNode
				ProductName = Field(Node, "ProductName")
				RetailPrice = Field(Node, "ListPrice")
				ProductPrice = Field(Node, "ProductPrice") 
				Related = Field(Node, "Accessories")
	    	Next 
	    	if ProductName <> "" then 
			ExtractProduct = ProductName & "@@@" & ProductPrice & "@@@" & RetailPrice & "@@@" & Related
			else
			ExtractProduct = "@@@"
			end if 
		else 
			ExtractProduct = "@@@"
		end if 
		
	End Function

	Public Function ExtractPrinter(ByVal printerid) 'As ParentCategory
		Dim SQL 'As String
		Dim Document 'As MSXML.Document
		Dim Node	
		Dim CustomerNode 
		Dim SQL_Text 
		Dim CategoryName

		Dim ProductName 
		Dim ProductPrice
		Dim ListPrice 
		Dim ProductCode 
		Dim RelatedProducts

		Set ExtractPrinter = Nothing
		Server.ScriptTimeout= 2999

		
		
		'extract sql text: ProductDescription Like '%%'
		SQL = "SELECT CategoryName, Custom_Where_Clause FROM Categories WHERE CategoryID = '" & printerid & "';"

		'Make custom API call
		Call VolusionAPICallObject.DoCustomAPICall( _
			SQL, _
			VolusionAPICallObject.ReadFile( _
				FSO.BuildPath(mInstallPath, CONFIGURATION_XSD_FILE) _
			) _
		) 
		Set Document = VolusionAPICallObject.ResponseXML
		Set CustomerNode = Document.documentElement.selectNodes("Products")
		'Set Document = Nothing		
		CategoryName = "printer model"
		For each Node in CustomerNode
			SQL_Text = Field(Node, "Custom_Where_Clause") 
			CategoryName = Field(Node, "CategoryName")
	    Next 
	    Response.write("<script type='text/javascript'>var printername='" & CategoryName & "';</script>")
	    'extract all related products'
	    SQL = "SELECT p.ProductCode, p.ProductName, pe.ProductPrice, pe.ListPrice FROM Products p INNER JOIN Products_Extended pe On pe.ProductID = p.ProductID INNER JOIN Products_Descriptions pd On pd.ProductID = p.ProductID WHERE pd." & SQL_Text & "Order By pe.ProductPrice DESC"
		Call VolusionAPICallObject.DoCustomAPICall( _
			SQL, _
			VolusionAPICallObject.ReadFile( _
				FSO.BuildPath(mInstallPath, CONFIGURATION_XSD_FILE) _
			) _
		) 
		Set Document = VolusionAPICallObject.ResponseXML
		Set CustomerNode = Document.documentElement.selectNodes("Products")
		Set Document = Nothing		
		ProductCode = "" 
		For each Node in CustomerNode 

			if ProductCode = "" then 
			ProductCode = Field(Node, "ProductCode")
			ProductName = Field(Node, "ProductName")
			ListPrice = Field(Node, "ListPrice")
			ProductPrice = Field(Node, "ProductPrice")
			end if 
			RelatedProducts = RelatedProducts & Field(Node, "ProductCode") & ","
			'Response.write(ProductCode)
	    Next 
	    if ProductCode <> "" then 
		ExtractPrinter = ProductCode & "@@@" & ProductName & "@@@" & ProductPrice & "@@@" & ListPrice & "@@@" & RelatedProducts
		else 
		ExtractPrinter = "@@@"
		end if 
		
	End Function

	Private Function Field(ByVal Document, ByVal Pattern)
		Dim Node 'As ?
		
		'Default return value
		Field = Null
		
		'Retrieve node
		Set Node = Document.selectSingleNode(Pattern)
		If Node Is Nothing Then
		    Field=" "
			Exit Function
		End If
		'Return value
		Field = Node.text
		Set Node = Nothing
	End Function


End Class


%>



<%
Dim Collector 'As ProductsCollector
Dim result
Dim product
Dim product_info
Dim ProductName
Dim ProductPrice
Dim ListPrice
Dim RelatedProducts
Dim product_temp

Dim printer 
Dim firstname
Dim product_info2

Dim related_arr 
Dim single_node
Dim single_info

Dim brand_arr
Dim brandname 

Dim couponcode
Dim count 
count = 0
'Add type headers
'Response.ContentType = "text/html"
'Response.Charset="windows-1252"


If Not Request.QueryString("product")= Null Or Not Request.QueryString("product") = "" Then
product_temp = Request.QueryString("product")
Else
product_temp = ""
End If

'If Not Request.QueryString("coupon")= Null Or Not Request.QueryString("coupon") = "" Then
'couponcode = Request.QueryString("coupon")
'Else
couponcode = "FIVE10"
'End If

Set Collector = New OrderTrackingCollector
Collector.DomainName = CONFIGURATION_DOMAIN_NAME
Collector.UserName = CONFIGURATION_USER_NAME
Collector.Password = CONFIGURATION_PASSWORD
Collector.UseSSL = CONFIGURATION_USE_SSL
Collector.InstallPath = Server.MapPath(CONFIGURATION_INSTALL_PATH)
Collector.DestinationPath = Server.MapPath(CONFIGURATION_DESTINATION_PATH)



if product_temp <> "" then 


result = Collector.ExtractProduct(product_temp)
'redim product_info()
product_info2 = Split(result, "@@@")

if Ubound(product_info2) > 2 then 
product = product_temp
ProductName  = product_info2(0)
ProductPrice = round(product_info2(1)*0.75,2)
ListPrice    = round(product_info2(2),2)
	if RelatedProducts = "" then 
		RelatedProducts = product_info2(3)
	end if  
end if 

end if 

if ProductName <> "" then 
brand_arr = Split(product, "-")

if Ubound(brand_arr) > 0 then 
brandname = brand_arr(1)
end if 


%>




<!-- #include virtual="v/vspfiles/templates/10/header_static.html" -->
<!--
For development:
	.cas_pur_coupon - replace contents with unique code
	.cas_pur_productImg - replace with product images
	.cas_pur_price - replace with product prices (after 25% discount)
	.cas_pur_productName - replace with product names
	.cas_pur_retail - replace with retail prices
	.cas_pur_printerModel - replace with printer model, default text is ok as is
	.cas_pur_printerBrand - replace with printer brand, default is empty

	Add ID's and classes as necessary, please don't alter class names.
 -->



<!-- CSS -->

<link href='/v/mp/css/cas-article.css' rel='stylesheet' type='text/css'>
<link href='css/2014-july-survey-purchase-cas.css' rel='stylesheet' type='text/css'>
<link href='/v/mp/css/icomoon.css' rel='stylesheet' type='text/css'>

<!-- JS -->
<script type="text/javascript" src="/v/mp/js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="js/jquery.jcarousel.min.js"></script>
<script type="text/javascript" src="js/jcarousel.skeleton.js"></script>

<!-- Set Cookie !-->
<script type="text/javascript">document.cookie ="couponcode=<%=couponcode%>; expires=Sun, 31 August 2014 23:59:59 UTC; path=/";</script>

<div class='cas_cms_articleContent_area cas_pur_container'>
	<div class='cas_cms_row'>
		<div class='cas_cms_twelve'>
			<h1>Re-order now to save $5 on any order of $10 or more!<br><span class='cas_pur_coupon'><%=couponcode%></span></h1>
			<h3>Use at checkout to save an extra $5</h3>
		</div>
	</div>
	<div class='cas_cms_row cas_pur_topProduct'>
		<div class='cas_cms_four firstCol'>
			<a target='_blank' href='//www.compandsave.com/ProductDetails.asp?ProductCode=<% Response.write(product) %>'>
				<img src='//www.compandsave.com/v/vspfiles/photos/<% Response.write(product) %>-2.jpg' onerror="this.src='/www.compandsave.com/v/vspfiles/templates/10/images/nophoto.gif';" class='cas_pur_productImg' alt='This product works with your printer model.'>
			</a>
		</div>
		<div class='cas_cms_eight lastCol'>
			<a target='_blank' href='//www.compandsave.com/ProductDetails.asp?ProductCode=<% Response.write(product) %>'>
				<h2 class='cas_pur_productName'><% Response.write(ProductName) %></h2>
			</a>
			<div class='cas_cms_row'>
				<div class='cas_cms_seven firstCol'>
					<h2 class='cas_pur_dollar'>Our price: <sup>$</sup><span class='cas_pur_price'><% Response.write(ProductPrice) %></span></h2>
					<p>Retail price: <sup>$</sup><span class='cas_pur_retail'><% Response.write(ListPrice) %></span></p>
					<p><label><span>Qty: </span><input type='text' value='1' maxlength='3' class='cas_pur_qty' id='cas_qty_0'></input></label>
					<input type="hidden" id='cas_productcode_0' value='<% Response.write(product) %>'>
					<input class='btn' type='button' onclick='addtocart(0)' value='Add To Cart'></input></p>
				</div>
				<div class='cas_cms_five lastCol'>
					<ul class='cas_pur_checklist'>
						<li><span class='icon-checkmark cas_pur_check'></span><span class='cas_pur_check'>Use code <span class='cas_pur_coupon'><%=couponcode%></span> to get $5 off</span></li>
						<li><span class='icon-checkmark cas_pur_check'></span><span class='cas_pur_check'>One year money back guarantee</span></li>
						<li><span class='icon-checkmark cas_pur_check'></span><span class='cas_pur_check'>Ships in 24 hours!</span></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<div class='cas_cms_row'>
		<div class='cas_cms_twelve jcarousel-wrapper'>
			<div class='jcarousel'>
				<ul>
					<% 

				    if RelatedProducts <> "" then 
					related_arr = split(RelatedProducts, ",")

						For each single_node in related_arr
							if single_node <> "" and LCase(single_node) <> LCase(product) then 
								result = Collector.ExtractProduct(single_node)
								single_info = Split(result, "@@@")
								if Ubound(single_info) > 1 then 
								ProductName  = single_info(0)
								ProductPrice = round(single_info(1)*0.75,2)
					    		ListPrice    = round(single_info(2),2)
					    		count = count + 1 
					    		end if 




					 %>

					<li>
				        <a target='_blank' href='//www.compandsave.com/ProductDetails.asp?ProductCode=<%Response.write(single_node)%>'><h3 class='cas_pur_productName'><% Response.write(ProductName) %></h3>
				        <img src='//www.compandsave.com/v/vspfiles/photos/<%Response.write(single_node)%>-2.jpg' onerror="this.src='/www.compandsave.com/v/vspfiles/templates/10/images/nophoto.gif';" class='cas_pur_productImg'></a>
				        <p class='cas_pur_dollar'>Our price: <sup>$</sup><span class='cas_pur_price'><% Response.write(ProductPrice) %></span></p>
						<p>Retail price: <sup>$</sup><span class='cas_pur_retail'><% Response.write(ListPrice) %></span></p>
				        <label><span>Qty: </span><input type='text' id='cas_qty_<%=count%>' value='1' maxlength='3' class='cas_pur_qty'></input></label>
				        <input type="hidden" id="cas_productcode_<%=count%>" value='<%=single_node%>'>
				        <input type='button' onclick='addtocart(<%=count%>)' value='Add to cart'></input>
					</li>

					<% 	end if 
 						next 
 					    end if  %>

				</ul>
			</div>
			<% if count > 3 then %>
			<div class='jcarousel-controls'>
				<a href='#' class='jcarousel-control-prev'><span class='icon-arrow-left3'></span></a>
	    		<a href='#' class='jcarousel-control-next'><span class='icon-arrow-right3'></span></a>
	    	</div>
	    	<% end if %>
	    	<% if count > 0 then %>
	    	<h2>The products above are compatible with your <strong><span class='cas_pur_printerBrand'><%=brandname%></span> <span class='cas_pur_printerModel'>printer model</span></strong>.</h2>
	    	<% end if %>
		</div>
	</div>
	<div class='cas_cms_row'>
		<div class='cas_cms_twelve cas_pur_disclaim'>
			<div class='cas_cms_divider'></div>
			<p>CompAndSave.com is proud to offer wallet friendly prices on high quality ink cartridges for your <span class='cas_pur_printerModel'>printer model</span>. We specialize in providing ink cartridges for any <span class='cas_pur_printerBrand'><%=brandname%></span> printer. Our ink cartridges are diligently re-engineered at our manufacturing facility to ensure the same print quality as brand name cartridges. Our high print quality and low prices are backed with a <strong>1 year money back guarantee</strong>, as well as our <strong>99% customer satisfaction rate</strong>!</p>
			<p>Using compatible or remanufactured printer cartridges will never void your printer warranty.  Feel free to contact us at <a href="mailto:customercare@compandsave.com">customercare@compandsave.com</a> if you have any further questions or if you need help finding your replacement cartridges from the compatible <span class='cas_pur_printerModel'>printer model</span> ink cartridges above. Hurry and take advantage of our great prices now!</p>
			<p><strong>Disclaimer:</strong> This offer cannot be combined with any other offer or coupon code and cannot be applied to past purchases. Coupon must be applied at checkout to receive your discount. Other restrictions may apply. Each coupon code may only be used once. Coupon expires 8/31/2014 11:59 PM <span title='Pacific Standard Time' class='cas_pur_help'>PST</span>.</p>
		</div>
	</div>
</div>

<script type='text/javascript'>
function addtocart(id) {
	var qty_id = "cas_qty_" + id;
	var code_id = "cas_productcode_" + id;
	var qty = document.getElementById(qty_id).value;
	var code = document.getElementById(code_id).value;
	window.location = "//www.compandsave.com/shoppingcart.asp?ProductCode=" + code + "&QTY." + code + "=" + qty;

}
if (typeof printername != "undefined") {
jQuery('.cas_pur_printerModel').html(printername);
}



</script>



<!-- #include virtual="/v/vspfiles/templates/10/footer_static.html" -->
<%else %>

<!-- #include virtual="v/vspfiles/templates/10/header_static.html" -->
<!-- CSS -->

<link href='/v/mp/css/cas-article.css' rel='stylesheet' type='text/css'>
<!--<link href='css/2014-july-survey-respond-cas.css' rel='stylesheet' type='text/css'>-->
<link href='/v/mp/css/icomoon.css' rel='stylesheet' type='text/css'>

<div class='cas_cms_articleContent_area cas_pur_container'>
	<div class='cas_cms_row'>
		<div class='cas_cms_two firstCol'></div>
		<div class='cas_cms_eight'>
			<h1>Oops! We are missing some info from you...</h1>
			<p class='cas_cms_alignLeft'>There seems to be an issue processing your request for your $5 off coupon. Please send us an email and we will help you resolve the problem. Please include your name, email address, and any other details you think we may need to know.</p>
			<p class='cas_cms_centerTxt'><a class='btn' href='mailto:mehmeta%40compandsave.com?subject=Help%20with%20my%2025%25%20off%20coupon&body=Name%3A%0AEmail%20address%3A'>Email us</a></p>
		</div>
		<div class='cas_cms_two lastCol'></div>
	</div>
</div>
<!-- #include virtual="/v/vspfiles/templates/10/footer_static.html" -->
<%end if %>