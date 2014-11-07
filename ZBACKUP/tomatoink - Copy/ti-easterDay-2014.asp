<%@LANGUAGE="VBSCRIPT.Encode"%>
<%
Option Explicit
'Response.Buffer = True
%>


<!-- #include virtual="v/vspfiles/templates/10/header_static.html" -->
		
<!-- CSS -->
<!--general-->
<!--
<link rel="stylesheet" href="css/ti-easterDay-2014.css"></link>
-->
<link rel="stylesheet" href="http://www.tomatoink.com/v/newsletter/promotion-Apr2014/css/ti-easterDay-2014.css"></link>
<link href='http://fonts.googleapis.com/css?family=Leckerli+One' rel='stylesheet' type='text/css'>
<!--end CSS-->

<!--JS-->
<!--
<script src="js/jquery.js" type="text/javascript"></script>
<script type="text/javascript" src=" js/couponCode.js"></script>
-->
<script src="http://www.tomatoink.com/v/newsletter/promotion-Apr2014/js/jquery.js" type="text/javascript"></script>
<script type="text/javascript" src="http://www.tomatoink.com/v/newsletter/promotion-Apr2014/js/couponCode.js"></script>
<!--

<script type="text/javascript" src="http://www.casinkadmin.com/yy/liangf/tomatoink/js/voteAnimal.js"></script>
-->
<script type="text/javascript" src="http://www.tomatoink.com/v/dc/yy/liangf/tomatoink/js/voteAnimal.js"></script>

<script>
if (jQuery.browser.msie && jQuery.browser.version === 10) {
  //document.getElementById('header_wrapper').style.height="133px !important;"
  $("html").addClass("ie10");
}
</script>


<script type="text/javascript" >  
$(document).ready(function() {
});
</script>  


<!--end JS-->


<!--Promotion Section-->

	<div class="promoSection twelve col">
		<div class="ti-ed-rabbitSign"></div>
		<h1>Vote Your Favourite Easter Animal!</h1>
		<div class="ti-ed-chickenSign"></div>	
		<div class="ti-ed-voteBar">
			<div id="ti-ed-rabbitBar" class="ti-ed-rabbitBar"></div>
			<div id="ti-ed-chickenBar" class="ti-ed-chickenBar"></div>
		</div>	
		<div class="ti-ed-text">
			<span class="ti-ed-rabbitText">Rabbit Win</span>
			<span class="ti-ed-chickenText">Chicken Win</span>
		</div>
		<div id="ti-ed-fight" class="ti-ed-fight">
			<div id="ti-ed-rabbitImg" class="ti-ed-rabbitImg" style="visibility:visible;"></div>
			<div id="ti-ed-chickenImg" class="ti-ed-chickenImg" style="visibility:visible;"></div>
		</div>
		<div class="ti-ed-voteBtn">	
			<div id="ti-ed-rabbitBtn" class="ti-ed-rabbitBtn">Vote Rabbit</div>
			<div id="ti-ed-chickenBtn" class="ti-ed-chickenBtn">Vote Chicken</div>
		</div>
		<div class="ti-ed-couponCode">
		<div id="ti-ed-preCode" class="ti-ed-preCode" style="display:block;">
			Vote <span class="ti-ed-highlight">Rabbit</span> or <span class="ti-ed-highlight">Chicken</span> to get your Coupon Code!
		</div>
		<div id="ti-ed-coupon" class="ti-ed-coupon" style="display:none;">
			Use coupon code <span class="ti-ed-highlight">EGG15</span> at checkout!
		</div>
	
<!--Search Bar-->	
	
		<div class="keyword_search">
			<form name="form2" method="get" id="search_v5_2" action="//search.tomatoink.com/search" OnSubmit="return submitSearch2();" target="_blank">
				<table cellpadding="1" cellspacing="0" border="0">
					<tr>
						<td class="search_input_style">
						<input type="text" name="keywords" autocomplete="off" value="Type your cartridge or printer model..." id="search_v5_2" onFocus="if(this.value=='Type your cartridge or printer model...')this.value='';" onBlur="if(this.value=='')this.value='Type your cartridge or printer model...';" onkeypress="return handleEnter2(this,event)" class="eight">
						</td>
						<td>
						<input name="imageField" type="submit" value="Search Your Ink" onclick="javascript:submitSearch2()" class="search_submit">
						</td>
					</tr>
				</table>
			</form>
			<!-- document.getElementById('search_input') ? document.getElementById('search_input').value=QueryString('Search') : null; -->
			<script type="text/javascript">
				document.getElementById('search_input') ? document.getElementById('search_input').value = "Find your cartridge or printer model" : null;
			</script>
		</div>	
		</div>
</div>	
			


     

<!-- #include virtual="/v/vspfiles/templates/10/footer_static.html" -->