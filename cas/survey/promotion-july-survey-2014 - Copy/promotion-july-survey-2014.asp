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
Public Function ExtractPrinter() 'As ParentCategory
		Dim SQL 'As String
		Dim Document 'As MSXML.Document
		Dim Node	
		Dim CustomerNode
		Dim categoryname
		Dim result 


		Set ExtractPrinter = Nothing
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

		ExtractPrinter = result
		
	End Function	
	
Public Function ExtractOrder(ByVal email) 'As ParentCategory
		Dim SQL 'As String
		Dim Document 'As MSXML.Document
		Dim Node	
		Dim CustomerNode
		Dim OrderID 
		Dim FirstName
		Dim LastName
		Dim Address 
		Dim City
		Dim State
		Dim PostCode 
		Dim Country 
		Dim OrderDate 


		Set ExtractOrder = Nothing
		Server.ScriptTimeout= 2999
		Dim emailaddress
		emailaddress = email
		
		'Setup SQL using template
		SQL = "SELECT Top 1 c.FirstName, c.LastName, o.OrderID, o.ShipAddress1, o.ShipAddress2, o.ShipCity, o.ShipState, o.ShipPostalCode, o.ShipCountry, CONVERT(VARCHAR(10),o.OrderDate,101) as OrderDate FROM Customers c INNER JOIN Orders o ON o.CustomerID = c.CustomerID WHERE c.EmailAddress = '" & emailaddress & "' AND o.OrderStatus = 'Shipped' Order By o.OrderDate DESC"
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
			OrderID = Field(Node, "OrderID")
			FirstName = Field(Node, "FirstName")
			LastName = Field(Node, "LastName")
			Address = Field(Node, "ShipAddress1") & " " & Field(Node, "ShipAddress2") 
			City = Field(Node, "ShipCity") 
			State = Field(Node, "ShipState")
			PostCode = Field(Node, "ShipPostalCode")
			Country = Field(Node, "ShipCountry")
			OrderDate = Field(Node, "OrderDate")
	    Next 

		ExtractOrder = OrderID & "@@@" & FirstName & "@@@" & LastName & "@@@" & Address & "@@@" & City & "@@@" & State & "@@@" & PostCode & "@@@" & Country & "@@@" & OrderDate
		
	End Function

	Public Function ExtractProduct(ByVal orderid) 'As ParentCategory
		Dim SQL 'As String
		Dim Document 'As MSXML.Document
		Dim Node	
		Dim CustomerNode 
		Dim ProductCode
		Dim ProductName 

		Set ExtractProduct = Nothing
		Server.ScriptTimeout= 2999

		
		
		'Setup SQL using template
		SQL = "SELECT TOP 1 od.ProductCode, p.ProductName FROM OrderDetails od INNER JOIN Products p ON p.ProductCode = od.ProductCode WHERE od.ProductCode <> 'GFT' AND od.ProductPrice > 0 AND od.OrderID = '" & orderid & "' ORDER BY od.Quantity DESC, od.ProductPrice DESC"
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
			ProductCode = Field(Node, "ProductCode") 
	    Next 

		ExtractProduct = ProductCode & "@@@" & ProductName 
		
	End Function

	Private Function Field(ByVal Document, ByVal Pattern)
		Dim Node 'As ?
		
		'Default return value
		Field = Null
		
		If Document Is Nothing Then
		    Filed=" "
			Exit Function
		End If
		
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
Dim email
'Add type headers
'Response.ContentType = "text/html"
'Response.Charset="windows-1252"


If Not Request.QueryString("email")= Null Or Not Request.QueryString("email") = "" Then
email = Request.QueryString("email")
Else
email = ""
End If
Set Collector = New OrderTrackingCollector
Collector.DomainName = CONFIGURATION_DOMAIN_NAME
Collector.UserName = CONFIGURATION_USER_NAME
Collector.Password = CONFIGURATION_PASSWORD
Collector.UseSSL = CONFIGURATION_USE_SSL
Collector.InstallPath = Server.MapPath(CONFIGURATION_INSTALL_PATH)
Collector.DestinationPath = Server.MapPath(CONFIGURATION_DESTINATION_PATH)

Dim order_arr 
Dim product_arr 
Dim image_url
Dim product_text
image_url = "/v/newsletter/promotion-june-2014/images/ink-group.jpg" 
product_text = "Save 25% on your next ink purchase!"

'get printers 
Dim printers 
printers = Collector.ExtractPrinter()

'table default text'
Dim FirstName_text 
Dim LastName_text 
Dim Address_text 
Dim City_text 
Dim ZipCode_text 
Dim State_text 
Dim Email_text 
Dim ProductCode
Dim OrderDate_text
Dim Country_text 

FirstName_text = "First Name"
LastName_text = "Last Name" 
Address_text = "Address" 
City_text = "City" 
ZipCode_text = "Zip Code" 
State_text = "State" 
OrderDate_text = "MM/DD/YYYY"
Country_text = "Country"

if email <> "" then 
Email_text = email 
else 
Email_text = "Email"
end if 

ProductCode = ""

result = Collector.ExtractOrder(email)

if result <> "" then 
order_arr = split(result, "@@@")


	if UBound(order_arr) > 0 then 
		result = Collector.ExtractProduct(order_arr(0))

		'if order_arr(7) = "United States" then 
		if order_arr(1) <> "" then 
			FirstName_text = order_arr(1) 
			LastName_text = order_arr(2)
			Address_text = order_arr(3)
			City_text = order_arr(4) 
			State_text = order_arr(5) 
			ZipCode_text = order_arr(6)
			OrderDate_text = order_arr(8)
			Country_text = order_arr(7)

		end if 



		product_arr = split(result, "@@@")
		if product_arr(0) <> "" then 
			ProductCode = product_arr(0)
			image_url = "/v/vspfiles/photos/" & product_arr(0) & "-2.jpg"
			product_text = product_arr(1)
		end if 
	end if 

end if 

Set Collector = Nothing






%>














<!-- #include virtual="v/vspfiles/templates/10/header_static.html" -->

<!--JS-->
	
<!-- end js-->

<!-- CSS -->

<link href="/v/mp/css/cas-article.css" rel='stylesheet' type='text/css'>
<link href="/v/newsletter/promotion-july-survey-2014/css/2014-july-survey-cas.css" rel='stylesheet' type='text/css'>
<script language="javascript" src="//www.compandsave.com/v/dc/yy/liangf/promotion-july-survey-2014/subSurvey.js"></script>
<script type="text/javascript" src="js/search_form.js"></script>

<!-- Hide the whole page when there is no email !-->
<% if Email_text = "Email" then   %>
<div id='cas_survey_popout' class='cas_cms_articleContent_area'><h2 class='cas_cms_centerTxt'>You are not currently subscribed to CompAndSave.com's Newsletter List!<br>This promotion is exclusive to our customers &amp; current subscribers!</h2><h2 class='cas_cms_centerTxt'>Please sign up to our newsletter list<br>so you don't miss any future offers:</h2><p class='cas_cms_centerTxt'><a class='btn' href='http://www.compandsave.com/MailingList_subscribe.asp' target='_blank'>Sign up for offers</a> <a class='btn' href='http://www.compandsave.com'>Return home</a></p></div>
<div id='cas_survey_gray'></div>
<% else %>
<script type="text/javascript">document.cookie ="couponcode=JULY12; expires=Mon, 28 July 2014 23:59:59 UTC; path=/";</script>
<% end if %>
<div class="cas_cms_articleContent_area cas_sur_container">
	<!--begin survey section-->
	<div id="cas_sur_surveySection">
		<div class="cas_cms_row cas_sur_backdrop">
			<div class="cas_cms_twelve">
				<h1>Receive your FREE tote bag and 25% off<br>coupon code if you take our short survey:</h1>
			</div>
		</div>
		<div class="cas_cms_row">
			<div class="cas_cms_seven firstCol">
				<div class="cas_sur_survey">
					<form>
						<ol>
							<% IF ProductCode <> "" THEN %>
							<li id='product_code_radio'><strong>Is the product shown to the right the product that you usually order?</strong><br>
								<label>Yes <input type="radio" value="yes" name="product-type" /></label>
								<label>No <input type="radio" value="no" name="product-type" /></label>
							</li>
							<input type='hidden' value='<% Response.write(ProductCode)%>' id = "product_code_input">
							<% END IF %>
							
							<li><label><strong>Please type your printer model:</strong> <input id="printer_model_input" type="text" value="Printer Model" onfocus="if(this.value=='Printer Model')this.value='';" onblur="if(this.value=='')this.value='Printer Model';"></label><p>You will receive an exclusive 25% off coupon within 10 business days which you can use to buy products related to the printer model you type above. Please double check that you are typing the correct printer model.</p></li>
							<li><label><strong>Last time you purchased a printer cartridge:</strong> <input id='purchase_date' type="text" value="<% Response.write(OrderDate_text) %>" onfocus="if(this.value=='MM/DD/YYYY')this.value='';" onblur="if(this.value=='')this.value='MM/DD/YYYY';" /></label></li>
							<li><label><strong>How often do you order replacement printer cartridges?</strong> 
								<select id="select_freq_options">
									<option selected disabled>Please select</option>
									<option value="1">Every month or less</option>
									<option value="2">Every 45 days</option>
									<option value="3">Every 60 days</option>
									<option value="4">Every 90 days</option>
									<option value="5">Every 6 months</option>
									<option value="6">Every year or longer</option>
								</select>
							</label></li>
							<li><strong>Are you happy with frequency in which you receive emails from CompAndSave.com?</strong><br>
								<label>Yes <input id="email_freq_radio1" type="radio" value="yes" name="email-freq" /></label>
								<label>No <input id="email_freq_radio2" type="radio" value="no" name="email-freq" /></label>
								<div id='frequency_block'>
									<p class="email-freq-no">Actually, I don&rsquo;t want to receive emails more than:</p> 
									<label><input name="frequency" value="1" type="radio" checked/>Once a month</label>
	      							<label><input name="frequency" value="2" type="radio"/>Twice a month</label>
	      							<p id="unsuccess_text_frequency"></p>
	      							<p>E-mail Address: <input type="text" id="frequency_email" value="<% Response.write(Email_text) %>"/></p>
									<!--<a class="btn" href="http://www.compandsave.com/MailingList_unsubscribe.asp" target="_blank">Update my email frequency</a>!-->
									<p><input id="submitBtn" value="Update Frequency" type="button" class="btn"/></p>



								</div>
							</li>
						</ol>
						<p id="cas_sur_alert0" class="cas_sur_alert"></p>
					</form>
				</div>
			</div>
			<div class="cas_cms_five lastCol">
				<img id="product_image" src="<% Response.write(image_url) %>" alt="Shop ink and toner and save up to 80% every day!" class="cas_cms_width100"/>
				<h3 id="product_name" class="cas_sur_productName"><% Response.write(product_text) %></h3>
			</div>
		</div>
		<div class="cas_cms_row cas_sur_freebieRow">
			<div class="cas_cms_seven firstCol">
				<div id="cas_sur_form_block">
					<p>Enter your information below to receive your free tote bag from CompAndSave.com!<br><em class="cas_cms_small-font">(U.S. and Canada only)</em></p>
					<div class="cas_cms_row">
						<div class="cas_cms_six firstCol">
							<input id="cas_sur_firstname" type="text" value=" <% Response.write(FirstName_text) %>" onfocus="if(this.value==' First Name')this.value='';" onblur="if(this.value=='')this.value=' First Name';"/>
						</div>
						<div class="cas_cms_six lastCol">
							<input id="cas_sur_lastname" type="text" value=" <% Response.write(LastName_text) %>" onfocus="if(this.value==' Last Name')this.value='';" onblur="if(this.value=='')this.value=' Last Name';"/>
						</div>
					</div>
					<div class="cas_cms_row">
						<div class="cas_cms_twelve">
							<input id="cas_sur_address" type="text" value=" <% Response.write(Address_text) %>" onfocus="if(this.value==' Address')this.value='';" onblur="if(this.value=='')this.value=' Address';"/>
						</div>
					</div>
					<div class="cas_cms_row">
						<div class="cas_cms_eight firstCol">
							<input id="cas_sur_city" type="text" value=" <% Response.write(City_text) %>"  onfocus="if(this.value==' City')this.value='';" onblur="if(this.value=='')this.value=' City';"/>
						</div>
						<div class="cas_cms_four lastCol">
							<input id="cas_sur_state" type="text" value=" <% Response.write(State_text) %>" onfocus="if(this.value==' State')this.value='';" onblur="if(this.value=='')this.value=' State';"/>
						</div>
					</div>
					<div class="cas_cms_row">
						<div class="cas_cms_eight firstCol">
							<input id="cas_sur_zip" type="text" value=" <% Response.write(ZipCode_text) %>" onfocus="if(this.value==' Zip Code')this.value='';" onblur="if(this.value=='')this.value=' Zip Code';"/>
						</div>
						<div class="cas_cms_four lastCol">
							<input id="cas_sur_country" type="text" value=" <% Response.write(Country_text) %>" onfocus="if(this.value==' Country')this.value='';" onblur="if(this.value=='')this.value=' Country';"/>
						</div>
					</div>
					<div class="cas_cms_row">
						<div class="cas_cms_twelve">
							<input id="cas_sur_email" type="text" readonly="readonly" value=" <% Response.write(Email_text) %>" onfocus="if(this.value==' Email')this.value='';" onblur="if(this.value=='')this.value=' Email';"/>
						</div>
					</div>
					<label><input id="agree_check" type="checkbox" value="agree"> I confirm that the information provided is accurate, and I would like to recieve a 25% off coupon code associated with my printer model via email.</label>
					<div class="cas_cms_row">
						<input id="cas_sur_submitEntry" type="submit" value="Submit" class="cas_cms_twelve" onClick="subForm(1)"/>
					</div>
					<p id="cas_sur_alert"></p>
				</div>
			</div>
			<div class="cas_cms_five lastCol" id="cas_sur_freebie_block">
				<img class="cas_cms_center" src="images/free.jpg" alt="Free tote bag from CompAndSave.com">
			</div>
		</div>
	</div>
	<!--end survey section-->
	<div id='success_message' class="cas_cms_row">
		<div class="cas_cms_twelve">
			<h2>Thank you for your time. Your 25% off exclusive coupon code and reusable shopping bag will be sent next week. </h2>
			<h2>In the meantime, please enjoy this 12% off coupon code:<br><span class="cas_sur_coupon">JULY12</span></h2>
		</div>
		<div class="cas_cms_twelve cas_sur_searchBar">
			<div id="cas_sur_searchbarContainer">
				<form id="nxt-ac-form" onsubmit="return submitSearch5();" action="http://search.compandsave.com/search" method="get" name="form5">
					<input type="text" name="keywords" autocomplete="off" value="Type your printer or ink model..." id="search_v5_5" onfocus="if(this.value=='Type your printer or ink model...')this.value='';" onblur="if(this.value=='')this.value='Type your printer or ink model...';" onkeypress="return handleEnter5(this,event)">
					<input type="submit" border="0" onclick="submitSearch5();" value="Search" name="imageField">
				</form>
			</div>
		</div>
	</div>
	<div class="cas_cms_divider"></div>
	<div class="cas_cms_row">
		<div class="cas_cms_one first"></div>
		<div class="cas_cms_ten">
			<p><strong>Disclaimer:</strong> Only current CompAndSave.com customers and subscribers are eligible to receive this offer. Limit one tote bag per household. Multiple entries will not result in multiple bags being sent to the same household or multiple coupon codes being sent to the same email address. Tote bags will be sent within 7-10 business days at no cost to the user. Your 25% off coupon code will be emailed within 10 business days. For additional questions or comments, please contact <a href="mailto:customercare@compandsave.com">customercare@compandsave.com</a>. Click <a target="_blank" href="../../../terms_privacy.asp">here</a> for more information about our privacy policy. CompAndSave.com reserves the right to cancel this promotion without prior notice. Offer ends 7/14/2014 11:59 PST or while supplies last.</p>
		</div>
		<div class="cas_cms_one last"></div>
	</div>
</div>
<style type="text/css">
	#product_code_box {
		display:none;
	}

	#frequency_block {
		display: none;
	}

	#success_message {
		display: none;
	}
	
	#cas_sur_alert {
		color:red;
	}

</style>

<link rel="stylesheet" href="//code.jquery.com/ui/1.11.0/themes/smoothness/jquery-ui.css">

<script type="text/javascript">



//config printer model input
var printers_text = "<% Response.write(printers) %>";
var availableTags = printers_text.split(",");
console.log(availableTags.length);
//$("#printer_model_input").autocomplete({
//source: availableTags
//});

$("#printer_model_input").autocomplete({
    source: function(request, response) {
        var results = $.ui.autocomplete.filter(availableTags, request.term);

        response(results.slice(0, 10));
    }
});

$('input[name="product-type"]').change(function() {
	if ($('input[name="product-type"]:checked').val() == "no") {
		$('#product_image').attr('src', "/v/newsletter/promotion-june-2014/images/ink-group.jpg");
		$('#product_name').html("Save 25% on your next ink purchase!");
		
	}
	else if ($('input[name="product-type"]:checked').val() == "yes") {
		$('#product_image').attr('src', "<% Response.write(image_url) %>");
		$('#product_name').html("<% Response.write(product_text) %>");
	}
});

$('input[name="email-freq"]').change(function() {
	if ($('input[name="email-freq"]:checked').val() == "no") {
		$('#frequency_block').show();
	}
	else if ($('input[name="email-freq"]:checked').val() == "yes") {
		$('#frequency_block').hide();
	}
});
$('#purchase_date').datepicker();

</script>


<!-- Email Frequency Update !-->
<script type='text/javascript'>
	jQuery('#submitBtn').click(function() {
		var method = jQuery('input[name="frequency"]:checked').val();
		email = jQuery('#frequency_email').val();
		if (jQuery.browser.msie && window.XDomainRequest) {
            // Use Microsoft XDR

			var xdr = new XDomainRequest();
			post_url = "http://www.casinkadmin.com/yy/MailChimp/unsubscriber.php?method=" + method + "&email=" + email + "&reason=";
			xdr.open("GET", post_url);
			xdr.send();
			xdr.onload = function() {
				var data = xdr.responseText;
				console.log("IE databack: " + data);
				if (data == "noexist") {jQuery('#unsuccess_text_frequency').html("<p class='cas_sur_alert'>You are not in our email list.</p>");}
				else if (data == "update") {
					jQuery('#frequency_block').html("<p>You have successfully updated your email frequency</p>");
									
				}

			}

		}
		else {

			jQuery.get("http://www.casinkadmin.com/yy/MailChimp/unsubscriber.php", {method:method, email:email, reason: ""}, function(data) {
				if (data == "noexist") {jQuery('#unsuccess_text_frequency').html("<p class='cas_sur_alert'>You are not in our email list.</p>");}
				else if (data == "update") {
					jQuery('#frequency_block').html("<p>You have successfully updated your email frequency</p>");
									
				}
			});
		}
	});

</script>
<!-- Email Frequency Update !-->

<!-- #include virtual="/v/vspfiles/templates/10/footer_static.html" -->
