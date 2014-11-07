<%@LANGUAGE="VBSCRIPT.Encode"%>
<%
Option Explicit
'Response.Buffer = True
%>
<!-- #include virtual="/v/vspfiles/templates/comboink/header_static.html" -->

<!-- CSS -->
<!--general-->
<link rel="stylesheet" href="css/ci-easterDay-2014.css"></link>
<!--end CSS-->

<!--JS-->
<script src=" //ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript" src=" //ajax.googleapis.com/ajax/libs/jqueryui/1.9.2/jquery-ui.min.js"></script>
<script src="js/randomMotion.js" type="text/javascript"></script>
<script src="js/jquery.js" type="text/javascript"></script>
<script src="js/couponCode.js" type="text/javascript"></script>
<!--end JS-->

<!--Promotion Section-->
	<div class="ci-ed-tagLine">Happy Easter Day<br>Click on the egg to get coupon code!</div>
	<div id="ci-ed-coupon" class="ci-ed-coupon" style="visibility:hidden;">
		<span>Use the coupon code <span style='font-size:24px;color:#8dc63f;font-weight:bold;'>FREE14</span> at checkout</span>
		<div id="ci-ed-reset" class="ci-ed-reset" style="visibility:hidden;">RESET</div>
	</div>
	<div>
		<div id="ci-ed-hardBn" class="ci-ed-hardBn">Hard</div>
		<div id="ci-ed-normalBn" class="ci-ed-normalBn">Normal</div>
		<div id="ci-ed-easyBn" class="ci-ed-easyBn">Easy</div>
	</div>
	<div id="ci-ed-container">
		<div id="ci-ed-eggClick" class="ci-ed-eggClick" style="display:block;"></div>
	</div>


	
<!--Search Bar-->	
	
	<!--<div class="keyword_search">
		<form name="form2" method="get" id="search_v5_2" action="//search.comboink.com/search" OnSubmit="return submitSearch2();" target="_blank">
			<table cellpadding="1" cellspacing="0" border="0">
				<tr>
					<td class="search_input_style">
					<input type="text" name="keywords" autocomplete="off" value="Type your cartridge or printer model..." id="search_v5_2" onFocus="if(this.value=='Type your cartridge or printer model...')this.value='';" onBlur="if(this.value=='')this.value='Type your cartridge or printer model...';" onkeypress="return handleEnter2(this,event)" class="eight">
					</td>
					<td>
					<input name="imageField" type="submit" value="Shop Ink" onclick="javascript:submitSearch2()" class="search_submit">
					</td>
				</tr>
			</table>
		</form>
		<!-- document.getElementById('search_input') ? document.getElementById('search_input').value=QueryString('Search') : null; -->
		<!--<script type="text/javascript">
			document.getElementById('search_input') ? document.getElementById('search_input').value = "Find your cartridge or printer model" : null;
		</script>
	</div>	
	
	
	<h4>exp 3/30</h4>-->	
</div>	
	
	
<!-- #include virtual="/v/vspfiles/templates/comboink/footer_static.html" -->