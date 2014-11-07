<%@LANGUAGE="VBSCRIPT.Encode"%>
<%
Option Explicit
'Response.Buffer = True
%>

<%
Dim firstname
Dim lastname

If Not Request.QueryString("fname")= Null Or Not Request.QueryString("fname") = "" Then
firstname = Request.QueryString("fname")
Else
firstname = "awesome "
End If


If Not Request.QueryString("lname")= Null Or Not Request.QueryString("lname") = "" Then
lastname = Request.QueryString("lname")
Else
lastname = "person"
End If
%>

<!-- #include virtual="v/vspfiles/templates/10/header_static.html" -->

<!-- CSS -->
<!--general-->
<link rel="stylesheet" href="css/ti-five-dollars-off-2014.css"></link>
<link rel="stylesheet" href="//www.tomatoink.com/v/mp/css/ti-article.css"></link>
<link href="//www.tomatoink.com/v/mp/css/icomoon.css" rel="stylesheet" type="text/css">
<!--end CSS-->

<!--JS-->
<script src="//www.tomatoink.com/v/mp/js/jquery-1.9.1.js"></script>
<script language="javascript" src="//www.tomatoink.com/v/mp/js/smoothScroll.js"></script>
<script type="text/javascript" src="js/search_form.js"></script>
<script type="text/javascript">document.cookie ="couponcode=D5FB4; expires=Thu, 31 July 2014 23:59:59 UTC; path=/";</script>
<!--end JS-->

<div class="ti_cms_articleContent_area" id="ti_fdo_content">
	<div class="ti_cms_row" id="ti_fdo_tagline">
		<div class="ti_cms_twelve">
			<h1><span class="ti_fdo_highlight"><%=firstname%>&nbsp;<%=lastname%>,</span><br />here is how to activate your exclusive <span class="ti_fdo_promo">$5</span> credit:</h1>
			<!--<p>with coupon code <span class="ti_fdo_highlight">JULY15</span> at checkout</p>-->
		</div>
	</div>
	<div class="ti_cms_row" id="ti_fdo_steps">
		<div class="ti_cms_four firstCol">
			<span class="icon-print"></span>
			<h3>Type your printer or<br />cartridge model</h3>
		</div>
		<div class="ti_cms_four">
			<span class="icon-cart"></span>
			<h3>Add your item to your cart</h3>
		
		</div>
		<div class="ti_cms_four lastCol">
			<span class="icon-calendar2"></span>
			<h3>Use "<span class="ti_fdo_code">D5FB4</span>" at checkout to activate your $5 credit</h3>
			
		</div>
	</div>
	<div class="ti_cms_row">
		<div class="ti_cms_eleven ti_fdo_searchbarContainer">
			<form id="nxt-ac-form" onsubmit="return submitSearch2();" action="http://search.TomatoInk.com/search" method="get" name="form2">
				<input type="text" name="keywords" autocomplete="off" value="Type your ink or printer model..." id="search_v5_2" onfocus="if(this.value=='Type your ink or printer model...')this.value='';" onblur="if(this.value=='')this.value='Type your ink or printer model...';" onkeypress="return handleEnter2(this,event)" class="ti_fdo_input ti_cms_eight firstCol">
				<input type="submit" border="0" onclick="submitSearch2();" value="Find Ink" name="imageField" class="ti_fdo_searchSubmit ti_cms_four lastCol">
			</form>
		</div>
	</div>
	<div class="ti_cms_row">
		<div class="ti_cms_twelve" id="ti_fdo_coupon">
			<h2>$5 OFF coupon code:</h2>
			<h1 class="ti_fdo_code ti_fdo_coupon">D5FB4</h1>
			<img src="//www.tomatoink.com/v/newsletter/general-images/email/ti-product-shot.png" alt="FREE SHIPPING OVER $50" title="FREE SHIPPING OVER $50" width="40%" />
		</div>
	</div>

</div>
<div class="ti_cms_articleContent_area" id="ti_fdo_disclaimer">
	<div class="ti_cms_row">
		<div class="ti_cms_twelve" >
			<h3>Disclaimer</h3>
			<p>This offer is non-transferable. Coupon code can only be used one time per customer. A customer is defined as a user with a specific e-mail address or IP Address. Coupon codes cannot be combined with any other offer or promotions and cannot be applied to past purchases. TomatoInk.com reserves the right to cancel this promotion without any prior notice.  Offers only valid online at TomatoInk.com.  Offer expires 07/31/2014 11:59 PST. 

		</div>
	</div>
</div>	
	
<!-- #include virtual="/v/vspfiles/templates/10/footer_static.html" -->