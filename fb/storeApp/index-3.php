<?php
//$file = fopen("CompandSave_Feed_fbstore.csv","r") or die('Cannot open file');
$username = "DBCOMPANDSAVE";
$password = "CAS123cas!";
$hostname = "DBCOMPANDSAVE.db.11475010.hostedresource.com"; 
$databasename = "DBCOMPANDSAVE";	
$conn = mysql_connect($hostname, $username, $password) or die("DB Connnection Error !".mysql_error());
mysql_select_db($databasename, $conn);

//fclose($file);

?>

<!DOCTYPE html>
<html xmlns:fb="http://ogp.me/ns/fb#" lang="en">
<head>
<script>
  window.fbAsyncInit = function() {
    FB.init({"appId": "624452304314106", "status": true, "cookie": true, "xfbml": true});
    FB.Canvas.setAutoGrow();
    FB.Canvas.scrollTo(0,0); 
  };
  (function (d) {
    var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
    if (d.getElementById(id)) { return; }
    js = d.createElement('script'); js.id = id; js.async = true;
    js.src = "//connect.facebook.net/en_US/all.js";
    ref.parentNode.insertBefore(js, ref);
  } (document));
</script>
<style>
body{
  margin:0;
  padding:0;
}
div.item
{
  padding: 5px;
  border: 1px solid #DDD;
  width: 180px;
  height: 190px;
  float: left;
  text-align: center;
}
div.item img
{
  display: inline;
  margin: 0px;
  padding: 0px;
  border: 1px solid #ffffff;
  width: 150px;
  height: 150px;
}
div.item a:hover img {border: 1px solid #ffffff;}
div.desc
{
  float: left;
  text-align: left;
  font-weight: normal;
  width: 140px;
  margin: 0px;
  padding: 0px;
  color: #595a59;
  font-size: 15px;
}
.price
{
  color: #595a59;
  font-size: 15px;
}
#pagecontent
{
clear:both;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
</head>
<body>

<h1>Welcome to CompAndSave.com Store.</h1>

<div>
<form action="">
<input type="text" id="input-search" name="inputsearch" value="I am looking for" size="30" onfocus="if(this.value=='I am looking for')this.value='';" onblur="if(this.value=='')this.value='I am looking for';">
<button>Search</button>
</form>
</div>
<h1></h1>

<?php

$current_page = 1;
$current_page = (isset($_GET['pageID']) ? $_GET['pageID'] : 1);
echo $current_page . "<br>";


$sql = "SELECT productid, title, producturl, imageurl, price from fbstore";
$result = mysql_query($sql);
$array = mysql_fetch_array($result);
echo $array[0] . "<br>";	

?>
<div id="itemcontent">
<div class="item" style="margin:0px 14px 14px 0px">
 <a target="_blank" href="//www.compandsave.com/ProductDetails.asp?ProductCode=DRUM-Brother-DR110CL"><img src="//www.compandsave.com/v/vspfiles/photos/original/DRUM-Brother-DR110CL.jpg"></a>
 <div class="desc">Brother DR110CL Laser Cartridge</div>
 <span class="price" >99.99</span>
</div>
<div class="item" style="margin:0px 14px 14px 0px">
 <a target="_blank" href="//www.compandsave.com/ProductDetails.asp?ProductCode=DRUM-Brother-DR110CL"><img src="//www.compandsave.com/v/vspfiles/photos/original/DRUM-Brother-DR110CL.jpg"></a>
 <div class="desc">Brother DR110CL Laser Cartridge</div>
 <span class="price" >99.99</span>
</div>
<div class="item" style="margin:0px 14px 14px 0px">
 <a target="_blank" href="//www.compandsave.com/ProductDetails.asp?ProductCode=DRUM-Brother-DR110CL"><img src="//www.compandsave.com/v/vspfiles/photos/original/DRUM-Brother-DR110CL.jpg"></a>
 <div class="desc">Brother DR110CL Laser Cartridge</div>
 <span class="price" >99.99</span>
</div>
<div class="item" style="margin:0px 0px 14px 0px">
 <a target="_blank" href="//www.compandsave.com/ProductDetails.asp?ProductCode=DRUM-Brother-DR110CL"><img src="//www.compandsave.com/v/vspfiles/photos/original/DRUM-Brother-DR110CL.jpg"></a>
 <div class="desc">Brother DR110CL Laser Cartridge</div>
 <span class="price" >99.99</span>
</div>
<div class="item" style="margin:0px 14px 14px 0px">
 <a target="_blank" href="//www.compandsave.com/ProductDetails.asp?ProductCode=DRUM-Brother-DR110CL"><img src="//www.compandsave.com/v/vspfiles/photos/original/DRUM-Brother-DR110CL.jpg"></a>
 <div class="desc">Brother DR110CL Laser Cartridge</div>
 <span class="price" >99.99</span>
</div>
<div class="item" style="margin:0px 14px 14px 0px">
 <a target="_blank" href="//www.compandsave.com/ProductDetails.asp?ProductCode=DRUM-Brother-DR110CL"><img src="//www.compandsave.com/v/vspfiles/photos/original/DRUM-Brother-DR110CL.jpg"></a>
 <div class="desc">Brother DR110CL Laser Cartridge</div>
 <span class="price" >99.99</span>
</div>
<div class="item" style="margin:0px 14px 14px 0px">
 <a target="_blank" href="//www.compandsave.com/ProductDetails.asp?ProductCode=DRUM-Brother-DR110CL"><img src="//www.compandsave.com/v/vspfiles/photos/original/DRUM-Brother-DR110CL.jpg"></a>
 <div class="desc">Brother DR110CL Laser Cartridge</div>
 <span class="price" >99.99</span>
</div>
<div class="item" style="margin:0px 0px 14px 0px">
 <a target="_blank" href="//www.compandsave.com/ProductDetails.asp?ProductCode=DRUM-Brother-DR110CL"><img src="//www.compandsave.com/v/vspfiles/photos/original/DRUM-Brother-DR110CL.jpg"></a>
 <div class="desc">Brother DR110CL Laser Cartridge</div>
 <span class="price" >99.99</span>
</div>
</div>

<div id="pagecontent">
<form method="get" action="https://secure.compandsave.com/lf/fbstore/index.php">
	<button id="firstpage" name="pageID" value="1"><<</button>
	<button id="prepage" name="pageID" value="0"><</button>
	<button id="nextpage" name="pageID" value="2">></button>
	<button id="lastpage" name="pageID" value="1">>></button>
<form>
</div>
</body>
<script>
$(document).ready(function(){
	var pre_page = 1;
	var next_page = 1;
	var page = 1;
	
	//page = '<?=$_GET['pageID']?>';
	page = '<?=isset($_GET['pageID']) ? $_GET['pageID'] : 1?>';
	
	page = parseInt(page);
	pre_page = page - 1;
	next_page = page + 1;

	$('#prepage').click(function(){
		//alert("previous");
		document.getElementById('prepage').value = page - 1;
	}); 
	$('#nextpage').click(function(){
		//alert("nextpage");
		document.getElementById('nextpage').value = page + 1;
	}); 

});
</script>
</html>
