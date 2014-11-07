<%@LANGUAGE="VBSCRIPT.Encode"%>
<%
Option Explicit
'Response.Buffer = True
%>
<!-- #include virtual="/v/vspfiles/templates/comboink/header_static.html" -->

<!-- CSS -->
<!--general-->
<link rel="stylesheet" href="http://www.comboink.com/v/newsletter/promotion-Apr2014/css/ci-easterDay-2014.css"></link>
<link href='http://fonts.googleapis.com/css?family=Henny+Penny' rel='stylesheet' type='text/css'>
<!--end CSS-->

<!--JS-->
<script src=" //ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript" src=" //ajax.googleapis.com/ajax/libs/jqueryui/1.9.2/jquery-ui.min.js"></script>
<script src="http://www.casinkadmin.com/yy/liangf/comboink/js/jquery.js" type="text/javascript"></script>
<script src="http://www.casinkadmin.com/yy/liangf/comboink/js/randomMotion.js" type="text/javascript"></script>
<script src="http://www.casinkadmin.com/yy/liangf/comboink/js/stop-watch.js" type="text/javascript"></script>
<script src="http://www.casinkadmin.com/yy/liangf/comboink/js/couponCode.js" type="text/javascript"></script>
<!--end JS-->


<!--Promotion Section-->
<div class="ci-ed-contentArea">
	<div class="ci-ed-tagLine">
		<h1>Catch the Easter Egg</h1>
		<h3>Click on the egg to get 15% OFF coupon code!</h3>		
	</div>
	<div class="ci-ed-inkImage"></div>
	<div id="ci-ed-stopWatch" class="ci-ed-stopWatch">
		<span>
			<form name="clockform">
				<input name="clock" value="00:00:00.00" class="ci-ed-clock" />
				<input name="starter" onclick="findTIME()" type="button" value="Start" id="ci-ed-start" class="ci-ed-start" style="display:block" />
				<input name="clearer" onclick="clearALL()" type="button" value="Play Again" id="ci-ed-again" class="ci-ed-again" style="display:none;"/>
				<input name="clearer" onclick="clearALL()" type="button" value="Reset" id="ci-ed-reset" class="ci-ed-reset" style="display:none" />
			</form>
		</span>	
	</div>
	<div id="ci-ed-playMode" class="ci-ed-playMode" style="display:none;">
	Click <strong>"Reset"</strong> if you want to change the play mode!
	</div>  
	<div id="ci-ed-option" class="ci-ed-option" style="display:block;">
		<div id="ci-ed-hardBn" class="ci-ed-hardBn">Hard</div>
		<div id="ci-ed-normalBn" class="ci-ed-normalBn">Normal</div>
		<div id="ci-ed-easyBn" class="ci-ed-easyBn">Easy</div>
	</div>
	<div id="ci-ed-container">
<!--Search Bar-->	
	<div id="ci-ed-reward" class="ci-ed-reward" style="display:none;">
		<h2>Congratulation! You caught the Egg.</h2><p>Use the 15% Off coupon code <span class="ci-ed-highlight">EGG15</span> at checkout! Exp. 4/30.</p>
		<div class="ci-ed-keyword_search">

			<form name="form2" method="get" id="search_v5_2" action="//search.comboink.com/search" OnSubmit="return submitSearch2();" target="_blank">
				<table cellpadding="1" cellspacing="0" border="0">
					<tr>
						<td class="ci-ed-search_input_style">
						<input type="text" name="keywords" autocomplete="off" value="Type your cartridge or printer model..." id="search_v5_2" onFocus="if(this.value=='Type your cartridge or printer model...')this.value='';" onBlur="if(this.value=='')this.value='Type your cartridge or printer model...';" onkeypress="return handleEnter2(this,event)" class="eight">
						</td>
						<td>
						<input name="imageField" type="submit" value="Shop Ink" onclick="javascript:submitSearch2()" class="ci-ed-search_submit">
						</td>
					</tr>
				</table>
			</form>
			<!-- document.getElementById('search_input') ? document.getElementById('search_input').value=QueryString('Search') : null; -->
			<script type="text/javascript">
				document.getElementById('search_input') ? document.getElementById('search_input').value = "Find your cartridge or printer model" : null;
			</script>
		</div>
		<div class="ci-ed-top10">
		<form action="" method="post" enctype="multipart/form-data">
			<table cellspacing="0" border="0">
				<tr height="50">
					<td colspan="2" valign="bottom" align="center">
						<table width="701" id="ci-ed-rankName" class="ci-ed-rankName" style="display:block">
							<tr height="15">
								<td width="310" valign="bottom">
									<div id="ci-ed-rank" class="ci-ed-rank">Your rank is:</div> <div id="ci-ed-vrank">9999</div>
								</td>
								<td valign="bottom">
									<span>Your name: </span>
									<input name="full_name" value="enter your name here..." onfocus="if(this.value==this.defaultValue)this.value='';" onblur="if(this.value=='')this.value=this.defaultValue;" id="ci-ed-name" class="ci-ed-name">
									<input id="ci-ed-nameBtn" class="ci-ed-nameBtn" value="Submit" type="button">
								</td>
							</tr>
						</table>
						<div id="ci-ed-thanks" class="ci-ed-thanks" style="display:none;">Thank You for Your Participation!</div>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center" class="ci-ed-highlight">		Top 10 Scores
					</td>
					<td></td>
				</tr>
				<tr>
					<td>
						<table class="ci-ed-rankTable" cellspacing="0" >
							<tr>
								<td width="50" align="center">Rank</td>
								<td width="195" align="center" class="ci-ed-boldFont">Name</td>
								<td width="100" align="center" class="ci-ed-boldFont">Time</td>
							</tr>
							<tr>
								<td align="center">1</td>
								<td align="center"><div id="ci-ed-nameRank1"></div></td>
								<td align="center"><div id="ci-ed-timeRank1"></div></td>
							</tr>
							<tr>
								<td align="center">2</td>
								<td align="center"><div id="ci-ed-nameRank2"></div></td>
								<td align="center"><div id="ci-ed-timeRank2"></div></td>
							</tr>
							<tr>
								<td align="center">3</td>
								<td align="center"><div id="ci-ed-nameRank3"></div></td>
								<td align="center"><div id="ci-ed-timeRank3"></div></td>
							</tr>
							<tr>
								<td align="center">4</td>
								<td align="center"><div id="ci-ed-nameRank4"></div></td>
								<td align="center"><div id="ci-ed-timeRank4"></div></td>
							</tr>
							<tr>
								<td align="center">5</td>
								<td align="center"><div id="ci-ed-nameRank5"></div></td>
								<td align="center"><div id="ci-ed-timeRank5"></div></td>
							</tr>
						</table>
					</td>
					<td>
						<table class="ci-ed-rankTable" cellspacing="0" >
							<tr>
								<td width="50" align="center">Rank</td>
								<td width="195" align="center" class="ci-ed-boldFont">Name</td>
								<td width="100" align="center" class="ci-ed-boldFont">Time</td>
							</tr>
							<tr>
								<td align="center">6</td>
								<td align="center"><div id="ci-ed-nameRank6"></div></td>
								<td align="center"><div id="ci-ed-timeRank6"></div></td>
							</tr>
							<tr>
								<td align="center">7</td>
								<td align="center"><div id="ci-ed-nameRank7"></div></td>
								<td align="center"><div id="ci-ed-timeRank7"></div></td>
							</tr>
							<tr>
								<td align="center">8</td>
								<td align="center"><div id="ci-ed-nameRank8"></div></td>
								<td align="center"><div id="ci-ed-timeRank8"></div></td>
							</tr>
							<tr>
								<td align="center">9</td>
								<td align="center"><div id="ci-ed-nameRank9"></div></td>
								<td align="center"><div id="ci-ed-timeRank9"></div></td>
							</tr>
							<tr>
								<td align="center">10</td>
								<td align="center"><div id="ci-ed-nameRank10"></div></td>
								<td align="center"><div id="ci-ed-timeRank10"></div></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
	</form>
	</div>	
	
		<div id="ci-ed-eggClick" class="ci-ed-eggClick" style="display:none;"><input name="starter" onclick="" value="" type="button" id="ci-ed-stop" class="ci-ed-stop"></div>
	</div>
</div>
	
	
<!-- #include virtual="/v/vspfiles/templates/comboink/footer_static.html" -->