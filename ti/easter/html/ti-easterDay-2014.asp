<%@LANGUAGE="VBSCRIPT.Encode"%>
<%
Option Explicit
'Response.Buffer = True
%>


<!-- #include virtual="v/vspfiles/templates/10/header_static.html" -->
		
<!-- CSS -->
<!--general-->
<link rel="stylesheet" href="css/ti-easterDay-2014.css"></link>
<link href='//fonts.googleapis.com/css?family=Irish+Grover' rel='stylesheet' type='text/css'>
<!--end CSS-->

<!--JS-->
<script src="js/jquery.js" type="text/javascript"></script>
<script type="text/javascript" src=" js/couponCode.js"></script>
<script type="text/javascript" src="//www.tomatoink.com/v/dc/yy/liangf/tomatoink/js/voteAnimal.js"></script>

<!--end JS-->

<!--[if lte IE 9]>
  <style type="text/css">
	#ti-ed-ie {display:block !important;font-size:20px;}
	#ti-ed-ie a {color:#aaa;}
	#ti-ed-normal {display:none !important;}
  </style>
<![endif]-->

<!--[if lte IE 8 ]> 
	<style type="text/css">
	#ti-ed-ie {display:block !important;font-size:20px;}
	#ti-ed-normal {display:none !important;}
  </style>
<![endif]-->

<!--Promotion Section-->

	<div class="promoSection twelve col">
		<div class="ti-ed-rabbitSign"></div>
		<h1>Vote for your favorite Easter animal!</h1>
		
<!--Contest Bar-->		
		
		<div class="ti-ed-chickenSign"></div>	
		<div class="ti-ed-voteBar">
			<div id="ti-ed-rabbitBar" class="ti-ed-rabbitBar"></div>
			<div id="ti-ed-chickenBar" class="ti-ed-chickenBar"></div>
		</div>	
		<!--<div class="ti-ed-text">
			<span class="ti-ed-rabbitText">Rabbit Win</span>
			<span class="ti-ed-chickenText">Chicken Win</span>
		</div>-->
		
<!--Fighting-->		
		
		<div id="ti-ed-fight" class="ti-ed-fight">
			<div id="ti-ed-rabbitImg" class="ti-ed-rabbitImg" style="visibility:visible;"></div>
			<div id="ti-ed-chickenImg" class="ti-ed-chickenImg" style="visibility:visible;"></div>
		</div>
		
<!--Buttons-->		
		
		<div id="ti-ed-thankYou" class="ti-ed-thankYou" style="display:none;">
			<div id="ti-ed-normal" class="ti-ed-normal" style="display:block;">
				Thanks for Your Participation!
			</div>
			<div id="ti-ed-ie" class="ti-ed-ie" style="display:none;">
				Your browser doesn't support our voting system. Want to <a href="//windows.microsoft.com/en-us/internet-explorer/download-ie" target="_blank">upgrade your browser first?</a>
			</div>
		</div>

		<div id="ti-ed-voteBtn" class="ti-ed-voteBtn" style="display:block;">	
			<div id="ti-ed-rabbitBtn" class="ti-ed-rabbitBtn">Vote Rabbit</div>
			<div id="ti-ed-chickenBtn" class="ti-ed-chickenBtn">Vote Chicken</div>
		</div>
		
<!--Coupon Codes-->		
		
		<div id="ti-ed-couponCode" class="ti-ed-couponCode">
			<div id="ti-ed-preCode" class="ti-ed-preCode" style="display:block;">
				Vote to get your <span class="ti-ed-highlight">15% off</span> coupon code!
			</div>
			<div id="ti-ed-coupon" class="ti-ed-coupon" style="display:none;">
				Use the 15% Off coupon code <span id="ti-ed-highlight" class="ti-ed-highlight">EGG15</span> at checkout! Exp. 4/30
			</div>
		
<!--Search Bar-->	
			<div class="ti-ed-inkImg"></div>
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