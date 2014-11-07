<?php
$username = "DBCOMPANDSAVE";
$password = "CAS123cas!";
$hostname = "DBCOMPANDSAVE.db.11475010.hostedresource.com"; 
$databasename = "DBCOMPANDSAVE";	
$conn = mysql_connect($hostname, $username, $password) or die("DB Connnection Error !".mysql_error());
mysql_select_db($databasename, $conn);
?>
<!DOCTYPE html>
<html xmlns:fb="http://ogp.me/ns/fb#" lang="en">
  <head>
  <script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
 
  ga('create', 'UA-253302-7', 'facebook.com');
  ga('send', 'pageview');  
  
  
    window.fbAsyncInit = function() {
      FB.init({"appId": "622987527797454", "status": true, "cookie": true, "xfbml": true});
      //FB.Canvas.setAutoGrow();
      //FB.Canvas.scrollTo(0,0); 
		FB.Canvas.setSize({height:600});
		setTimeout("FB.Canvas.setAutoGrow()",500);
    };
	
(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/all.js";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));

  </script>
  <link href="//www.compandsave.com/v/mp/css/cas-article.css" rel='stylesheet' type='text/css'/>
  <link href="facebook-shop.css" rel='stylesheet' type='text/css'/>
  </style>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
  </head>
  <body class="cas_cms_articleContent_area cas_fb-shop">
    <div class="cas_cms_row cas_fb-header">
      <div class="cas_cms_ten firstCol"><img src="//www.compandsave.com/v/mp/facebook-shop/images/fb-header.png"><h1>Shop Ink &amp; Toner</h1></div>
      <div class="cas_cms_two lastCol">
       <p>
		<a href="//www.compandsave.com/v/dc/yy/chat_page/compandsave_chat.html" onclick="javascript:void window.open('//www.compandsave.com/v/dc/yy/chat_page/compandsave_chat.html','CompandSave Chat Page','width=637,height=660,toolbar=0,menubar=0,location=0,status=0,scrollbars=0,resizable=0,left=0,top=0');return false;"><span class="icon-bubbles"></span> Live Chat</a><br>
		<a href="mailto:customerservice@compandsave.com?Subject=Help%20with%20the%20Facebook%20shop" target="_top"><span class="icon-envelope"></span> Email Us</a>
	   </p>
      </div>
    </div>
    <div class="cas_cms_row cas_fb-search">
      <div class="cas_cms_twelve cas_fb-searchContain">
        <form id="nxt-ac-form" name="form5" method="get" action="" onsubmit="return submitSearch5();">
          <input id="search_v5_5" type="text" onkeypress="return handleEnter5(this,event)" onblur="blur_fun(this)" onfocus="focus_fun(this)" value="Type your ink or toner model..." autocomplete="off" name="keywords"></input>
          <input type="submit" border="0" name="imageField" id="btn-search" value="Find Ink" onclick="submitSearch5();"></input>
        </form>
      </div>
    </div>
    <div class="cas_cms_row">
<?php


//$total= mysql_num_rows(mysql_query("SELECT * from fbstore"));
//$total_pages = ceil($total/12);
//$current_page = 1;
$current_page = (isset($_GET['pageID']) ? $_GET['pageID'] : 1);
//$current_page = 169;
$startID = ($current_page-1)*12;

$keywords = (isset($_GET['keywords']) ? $_GET['keywords'] : null);
$keywords2 = preg_replace('/\s+/', '', $keywords);;

	
if ($keywords != null) {
	//echo $keywords . "<br>";
	$sql = "SELECT productid, shorttitle, producturl, imageurl, price from cas_fbstore where longtitle2 like '%$keywords2%'";
}
else {
	//$sql = "SELECT productid, title, producturl, imageurl, price from fbstore limit $startID, 12";
	$sql = "SELECT productid, shorttitle, producturl, imageurl, price from cas_fbstore";
}
$total = mysql_num_rows(mysql_query($sql));
$total_pages = ceil($total/12);
$sql = $sql . " limit $startID, 12";
//echo $sql . "<br>";
$count_items = mysql_num_rows(mysql_query($sql));
if ($keywords != null) {
	//echo $count_items . "<br>";
	echo "<b>Results " . ($startID+1) . " - " . ($startID+$count_items) . " of " . $total . " for: " . $keywords . "<br>";
}
else {
	echo "<b>Results " . ($startID+1) . " - " . ($startID+$count_items) . " of " . $total . "<br>";
}

$result = mysql_query($sql);
//$count = 1;
while($array = mysql_fetch_array($result)) {	
	echo '<div class="cas_fb-quarter">';
	echo '<div class="cas_fb-inner">';
	echo '<a target="_blank" href="//' . substr($array[2], 7) . '">';
	echo '<h2>' . $array[1] . '</h2>';
	echo '<div class="cas_fb-imgContain">'; 
	echo '<img src="//' . substr($array[3], 7) . '">';
	echo '</div>';
	echo '</a>';
	echo '<p><span class="cas_fb-price">$' .$array[4]. '</span>';
	echo '<a target="_blank" href="//' . substr($array[2], 7) . '">' . '<input type="submit" value="Shop now"></input></a></p>';
	echo '</div>';
	echo '</div>';
	//$count++;
	//if ($count>12) break;
}


?>	
<!--
      <div class="cas_fb-quarter">
        <div class="cas_fb-inner" id="">
          <a target="_blank" href="//www.compandsave.com/ProductDetails.asp?ProductCode=DRUM-Brother-DR110CL">
            <h2>Replacement for Hewlett Packard C6656AN / C6656A (HP 56 Black) Ink Cartridge</h2>
            <div class="cas_fb-imgContain">
              <img src="//www.compandsave.com/v/vspfiles/photos/original/DRUM-Brother-DR110CL.jpg">
            </div>
          </a>
          <p><span class="cas_fb-price">$11.99</span><a target="_blank" href="//www.compandsave.com/ProductDetails.asp?ProductCode=DRUM-Brother-DR110CL"><input type="submit" value="Shop now"></input></a></p>
        </div>
      </div>
-->

      <div class="cas_cms_row">
        <div class="cas_cms_twelve cas_fb-nav">
          <form method="get" action="">
            <p>
              <button id="firstpage" name="pageID" value="1"></button>
              <button id="prepage" name="pageID" value="0"></button>
              <span id="cas_fb-currentPage">1</span>
              <button id="nextpage" name="pageID" value="2"></button>
              <button id="lastpage" name="pageID" value="1"></button>
            </p>
          <form>
        </div>
      </div>
      <div class="cas_cms_row">
        <div class="cas_cms_twelve cas_fb-footer"></div>
      </div>
    </div>
  </body>

<script>
    function handleEnter5(inField, e) {  //if you want to add more than one search bar, change this to the corresponding num
		return true;
    }
	
    function submitSearch5() {  //need to change as the form function name if you add more
        if (document.getElementById("search_v5_5").value != "") {   //need to change as the id in form input if you add more
            //var searchUrl = "http://search.compandsave.com/search?keywords=";    //please change the domain name according to your working domain
			var searchUrl = "https://secure.compandsave.com/lf/cas_store/index.php?keywords=";
            window.location = searchUrl + escape(document.getElementById("search_v5_5").value);  //need to change as the id in form input if you add more
        }
        return false;
    }

	function blur_fun(x) {
		if(x.value=='') {
			x.value='Type your ink or toner model...';
			x.style.color="#CCC";
		}
	}
	function focus_fun(x) {
		if(x.value=='Type your ink or toner model...') {
			x.value='';
			x.style.color="#CC1";
		}
	}

	
$(document).ready(function(){
	var currentURL = "";
	var first_page = 1;
	var pre_page = 1;
	var next_page = 1;
	var last_page = 1;
	var page = 1;
	//var total_pages = 1;
	var keywords;

	currentURL = "https://secure.compandsave.com/lf/cas_store/index.php";
	keywords = '<?=isset($_GET['keywords']) ? $_GET['keywords'] : null?>';
	
	//if (keywords=='') alert("keywords is null");
	//else alert(keywords);
	last_page = "<?php echo $total_pages; ?>";
	last_page = parseInt(last_page);
	
	page = '<?=isset($_GET['pageID']) ? $_GET['pageID'] : 1?>';
	page = parseInt(page);
	
	pre_page = page - 1;
	next_page = page + 1;
	
	document.getElementById('cas_fb-currentPage').innerHTML = page;
	//document.getElementById('lastpage').value = total_pages;
	
	if (page <= 1) {
		//document.getElementById('prepage').style.display="none";
		//document.getElementById('firstpage').style.display="none";
		document.getElementById('prepage').setAttribute("disabled","disabled");;
		document.getElementById('firstpage').setAttribute("disabled","disabled");;		
	}
	if (page >= last_page) {
		//document.getElementById('nextpage').style.display="none";
		//document.getElementById('lastpage').style.display="none";
		document.getElementById('nextpage').setAttribute("disabled","disabled");;
		document.getElementById('lastpage').setAttribute("disabled","disabled");;
	}
	$('#prepage').click(function(){
		//alert("previous");
		//document.getElementById('prepage').value = page - 1;
		if (keywords != '') {
			currentURL = currentURL + "?keywords=" + keywords;
			currentURL += "&pageID=" + pre_page;
		}
		else {
			currentURL += "?pageID=" + pre_page;
		}
		window.location = currentURL;
		return false;
	}); 
	$('#nextpage').click(function(){
		//alert("nextpage");
		//document.getElementById('nextpage').value = page + 1;
		if (keywords != '') {
			currentURL = currentURL + "?keywords=" + keywords;
			currentURL += "&pageID=" + next_page;
		}
		else {
			currentURL += "?pageID=" + next_page;
		}
		window.location = currentURL;
		return false;
	}); 
	$('#firstpage').click(function(){
		//alert("previous");
		//document.getElementById('prepage').value = page - 1;
		if (keywords != '') {
			currentURL = currentURL + "?keywords=" + keywords;
			currentURL += "&pageID=" + first_page;
		}
		else {
			currentURL += "?pageID=" + first_page;
		}
		window.location = currentURL;
		return false;
	}); 
	$('#lastpage').click(function(){
		if (keywords != '') {
			currentURL = currentURL + "?keywords=" + keywords;
			currentURL += "&pageID=" + last_page;
		}
		else {
			currentURL += "?pageID=" + last_page;
		}
		window.location = currentURL;
		return false;
	}); 
	$('#search_v5_5').click(function(){
		//alert("click the search bar.");
		//document.getElementById("search_v5_5").style.color = "#CC1";
		if ( document.getElementById("search_v5_5").value=="Type your ink or toner model..." ) {
			//document.getElementById("search_v5_5").style.color = "#CCC";
		}
	});
});
</script>
</html>