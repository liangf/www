<!-- Show couponcode on the product page -- MSM !-->
<script type="text/javascript">
/*******************************************************/
/* Mother's day saving Money*/
/* Description: Show couponcode on the product page */
/* Author: liangf */
/* Version: 4/28 */
/*******************************************************/

var fileref=document.createElement("link");
fileref.setAttribute("rel", "stylesheet");
fileref.setAttribute("type", "text/css");
fileref.setAttribute("href", "//www.compandsave.com/v/newsletter/promotion-may2014/css/2014-cas-dollar-coupondiv.css");
document.getElementById("content_area").appendChild(fileref);

var coupon_flag = getUrlVars()["couponcode"];

if(typeof global_Current_ProductCode != "undefined") {
    if (typeof coupon_flag != "undefined" && coupon_flag != "") {
        //alert(test_flag);
        document.getElementById('couponDiv').style.display='block';
        document.getElementById('onedollar_code').innerHTML=coupon_flag;
    }
}

</script>
<!-- End Show couponcode on the product page -- MSM !-->




<!-- Show Amazon coupon on the product page !-->
<!--
<link href="//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css" rel='stylesheet' type='text/css'>
<div id="cas_cms_couponDivAmazon">
</div>
-->
<script type="text/javascript">
/*******************************************************/
/* Mother's day saving Money*/
/* Description: Show couponcode on the product page */
/* Author: liangf */
/* Version: 5/1 */
/*******************************************************/
/*
var fileref=document.createElement("link");
fileref.setAttribute("rel", "stylesheet");
fileref.setAttribute("type", "text/css");
fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
document.getElementById("content_area").appendChild(fileref);

var couponDiv = document.createElement("div");
var couponDivId = "cas_cms_couponDivAmazon";

couponDiv.id = couponDivId;
document.getElementById("content_area").appendChild(couponDiv);

document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for<img src='+'"//www.compandsave.com/v/mp/images/amazon-logo.png"'+'/>shoppers:</p>'+'<p>5% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon">ABC564B</strong></p>';	
document.getElementById('cas_cms_codeAmazon').innerHTML="AMA123";
*/
</script>
<!-- End Show Amazon coupon on the product page !-->



<!-- Show coupon on the product page !-->
<script type="text/javascript">
/*******************************************************/
/* Mother's day saving Money*/
/* Description: Show couponcode on the product page */
/* Author: liangf */
/* Version: 5/1 */
/*******************************************************/
var fileref=document.createElement("link");
fileref.setAttribute("rel", "stylesheet");
fileref.setAttribute("type", "text/css");
var couponDiv = document.createElement("div");
var coupon_flag = getUrlVars()["couponcode"];
var utm_flag = getUrlVars()["utm_source"];

if(typeof global_Current_ProductCode != "undefined") {
    if (typeof coupon_flag != "undefined" && coupon_flag != "") {
        fileref.setAttribute("href", "//www.compandsave.com/v/newsletter/promotion-may2014/css/2014-cas-dollar-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        document.getElementById('couponDiv').style.display='block';
        document.getElementById('onedollar_code').innerHTML=coupon_flag;
    }
    if (utm_flag == "amazon") {
        fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for<img src='+'"//www.compandsave.com/v/mp/images/amazon-logo.png"'+'/>shoppers:</p>'+'<p>5% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="5AMA";        
    }
}
</script>
<!-- End Show coupon on the product page !-->


<!-- Show coupon on the product page !-->
<script type="text/javascript">
/*******************************************************/
/* Description: Show couponcode on the product page */
/* Author: liangf */
/* Version: 5/8 */
/*******************************************************/
var fileref=document.createElement("link");
fileref.setAttribute("rel", "stylesheet");
fileref.setAttribute("type", "text/css");
var couponDiv = document.createElement("div");
var coupon_flag = getUrlVars()["couponcode"];
var utm_flag = getUrlVars()["utm_source"];

if(typeof global_Current_ProductCode != "undefined") {
    if (typeof coupon_flag != "undefined" && coupon_flag != "") {
        fileref.setAttribute("href", "//www.compandsave.com/v/newsletter/promotion-may2014/css/2014-cas-dollar-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        document.getElementById('couponDiv').style.display='block';
        document.getElementById('onedollar_code').innerHTML=coupon_flag;
    }
    if (utm_flag == "amazon") {
        fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for<img src='+'"//www.compandsave.com/v/mp/images/amazon-logo.png"'+'/>shoppers:</p>'+'<p>5% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="5AMA";        
    }
    if (utm_flag == "shoppingcom") {
        fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for<img src='+'"//img.shoppingshadow.com/jfe/bb/logos/default_192x44_sdc_us.png"'+'/>customers:</p>'+'<p>10% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="SCOM10";        
    }
}
</script>
<!-- End Show coupon on the product page !-->


<!-- Show coupon on the product page !-->
<script type="text/javascript">
/*******************************************************/
/* Description: Show couponcode on the product page */
/* Author: liangf */
/* Version: 5/12 */
/*******************************************************/
var fileref=document.createElement("link");
fileref.setAttribute("rel", "stylesheet");
fileref.setAttribute("type", "text/css");
var couponDiv = document.createElement("div");
var coupon_flag = getUrlVars()["couponcode"];
var utm_flag = getUrlVars()["utm_source"];

if(typeof global_Current_ProductCode != "undefined") {
    if (typeof coupon_flag != "undefined" && coupon_flag != "") {
        fileref.setAttribute("href", "//www.compandsave.com/v/newsletter/promotion-may2014/css/2014-cas-dollar-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        document.getElementById('couponDiv').style.display='block';
        document.getElementById('onedollar_code').innerHTML=coupon_flag;
    }
    if (utm_flag == "amazon") {
        fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for<img src='+'"//www.compandsave.com/v/mp/images/amazon-logo.png"'+'/>shoppers:</p>'+'<p>10% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="10AMA";        
    }
    if (utm_flag == "shoppingcom") {
        fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for<img src='+'"//img.shoppingshadow.com/jfe/bb/logos/default_192x44_sdc_us.png"'+'/>customers:</p>'+'<p>10% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="SCOM10";        
    }
}
</script>
<!-- End Show coupon on the product page !-->


<!-- Show coupon on the product page !-->
<script type="text/javascript">
/*******************************************************/
/* Description: Show couponcode on the product page */
/* Author: liangf */
/* Version: 5/8 */
/*******************************************************/
var fileref=document.createElement("link");
fileref.setAttribute("rel", "stylesheet");
fileref.setAttribute("type", "text/css");
var couponDiv = document.createElement("div");
var coupon_flag = getUrlVars()["couponcode"];
var utm_flag = getUrlVars()["utm_source"];

if(typeof global_Current_ProductCode != "undefined") {
    if (typeof coupon_flag != "undefined" && coupon_flag != "") {
        fileref.setAttribute("href", "//www.compandsave.com/v/newsletter/promotion-may2014/css/2014-cas-dollar-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        document.getElementById('couponDiv').style.display='block';
        document.getElementById('onedollar_code').innerHTML=coupon_flag;
    }
    if (utm_flag == "amazon") {
        fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for<img src='+'"//www.compandsave.com/v/mp/images/amazon-logo.png"'+'/>shoppers:</p>'+'<p>10% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="10AMA";        
    }
    if (utm_flag == "shoppingcom") {
        fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for<img src='+'"//img.shoppingshadow.com/jfe/bb/logos/default_192x44_sdc_us.png"'+'/>customers:</p>'+'<p>10% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="SCOM10";        
    }
    if (utm_flag == "nextag") {
        fileref.setAttribute("href", "//www.casinkadmin.com/liang/coupon/css/2014-cas-nextag-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for&nbsp<img src='+'"//www.casinkadmin.com/liang/coupon/LogoNexTag.png"'+'/>customers:</p>'+'<p>10% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="10NEX";        
    }
}
</script>
<!-- End Show coupon on the product page !-->


<!-- Show coupon on the product page !-->
<script type="text/javascript">
/*******************************************************/
/* Description: Show couponcode on the product page */
/* Author: liangf */
/* Version: 5/8 */
/*******************************************************/
var fileref=document.createElement("link");
fileref.setAttribute("rel", "stylesheet");
fileref.setAttribute("type", "text/css");
var couponDiv = document.createElement("div");
var coupon_flag = getUrlVars()["couponcode"];
var utm_flag = getUrlVars()["utm_source"];
var campaign_flag = getUrlVars()["utm_campaign"];

if(typeof global_Current_ProductCode != "undefined") {
    if (typeof coupon_flag != "undefined" && coupon_flag != "") {
        fileref.setAttribute("href", "//www.compandsave.com/v/newsletter/promotion-may2014/css/2014-cas-dollar-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        document.getElementById('couponDiv').style.display='block';
        document.getElementById('onedollar_code').innerHTML=coupon_flag;
    }
    if (utm_flag == "amazon") {
        fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for<img src='+'"//www.compandsave.com/v/mp/images/amazon-logo.png"'+'/>shoppers:</p>'+'<p>10% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="10AMA";        
    }
    if (utm_flag == "shoppingcom") {
        fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for<img src='+'"//img.shoppingshadow.com/jfe/bb/logos/default_192x44_sdc_us.png"'+'/>customers:</p>'+'<p>10% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="SCOM10";        
    }
    if (utm_flag == "nextag") {
        fileref.setAttribute("href", "//www.casinkadmin.com/liang/coupon/css/2014-cas-nextag-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for&nbsp<img src='+'"//www.casinkadmin.com/liang/coupon/LogoNexTag.png"'+'/>customers:</p>'+'<p>10% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="10NEX";        
    }
    if (campaign_flag == "suggestions") {
        fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for<br>returning customers:</p>'+'<p>10% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="RETEN";           
    }
    if (utm_flag == "shopzilla") {
        fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for<img src='+'"//www.wpchats.com/wp-content/uploads/2010/07/WP-Robot-Shopzilla-Plugin.jpg"'+'/>shoppers:</p>'+'<p>5% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="5SHOP";        
    }
}
</script>
<!-- End Show coupon on the product page !-->


<!-- Show coupon on the product page !-->
<script type="text/javascript">
/*******************************************************/
/* Description: Show couponcode on the product page */
/* Author: liangf */
/* Version: 5/8 */
/*******************************************************/
var fileref=document.createElement("link");
fileref.setAttribute("rel", "stylesheet");
fileref.setAttribute("type", "text/css");
var couponDiv = document.createElement("div");
var coupon_flag = getUrlVars()["couponcode"];
var utm_flag = getUrlVars()["utm_source"];
var campaign_flag = getUrlVars()["utm_campaign"];

if(typeof global_Current_ProductCode != "undefined") {
    if (typeof coupon_flag != "undefined" && coupon_flag != "") {
        fileref.setAttribute("href", "//www.compandsave.com/v/newsletter/promotion-may2014/css/2014-cas-dollar-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        document.getElementById('couponDiv').style.display='block';
        document.getElementById('onedollar_code').innerHTML=coupon_flag;
    }
    if (utm_flag == "amazon") {
        fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for<img src='+'"//www.compandsave.com/v/mp/images/amazon-logo.png"'+'/>shoppers:</p>'+'<p>10% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="10AMA";        
    }
    if (utm_flag == "shoppingcom") {
        fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for<img src='+'"//www.compandsave.com/v/dc/yy/liangf/coupon/shopping-logo.png"'+'/>customers:</p>'+'<p>10% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="SCOM10";        
    }
    if (utm_flag == "nextag") {
        fileref.setAttribute("href", "//www.compandsave.com/v/dc/yy/liangf/coupon/css/2014-cas-nextag-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for&nbsp<img src='+'"//www.compandsave.com/v/dc/yy/liangf/coupon/nextag-logo.png"'+'/>customers:</p>'+'<p>10% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="10NEX";        
    }
    if (campaign_flag == "suggestions") {
        fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for<br>returning customers:</p>'+'<p>10% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="RETEN";           
    }
    if (utm_flag == "shopzilla") {
        fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for<img src='+'"//www.compandsave.com/v/dc/yy/liangf/coupon/shopzilla-logo.jpg"'+'/>shoppers:</p>'+'<p>5% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="5SHOP";        
    }
    if (utm_flag == "test") {
        fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>20% OFF<br>Only Today!</p>'+'<p>Coupon Code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="OFF20";        
    }
}
</script>
<!-- End Show coupon on the product page !-->


<!-- Show coupon on the product page !-->
<script type="text/javascript">
/*******************************************************/
/* Description: Show couponcode on the product page */
/* Author: liangf */
/* Version: 5/8 */
/*******************************************************/
var fileref=document.createElement("link");
fileref.setAttribute("rel", "stylesheet");
fileref.setAttribute("type", "text/css");
var couponDiv = document.createElement("div");
var coupon_flag = getUrlVars()["couponcode"];
var utm_flag = getUrlVars()["utm_source"];
var campaign_flag = getUrlVars()["utm_campaign"];

if(typeof global_Current_ProductCode != "undefined") {
    if (typeof coupon_flag != "undefined" && coupon_flag != "") {
        fileref.setAttribute("href", "//www.compandsave.com/v/newsletter/promotion-may2014/css/2014-cas-dollar-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        document.getElementById('couponDiv').style.display='block';
        document.getElementById('onedollar_code').innerHTML=coupon_flag;
    }
    if (utm_flag == "amazon") {
        fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for<img src='+'"//www.compandsave.com/v/mp/images/amazon-logo.png"'+'/>shoppers:</p>'+'<p>10% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="10AMA";        
    }
    if (utm_flag == "shoppingcom") {
        fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for<img src='+'"//www.compandsave.com/v/dc/yy/liangf/coupon/shopping-logo.png"'+'/>customers:</p>'+'<p>10% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="SCOM10";        
    }
    if (utm_flag == "nextag") {
        fileref.setAttribute("href", "//www.compandsave.com/v/dc/yy/liangf/coupon/css/2014-cas-nextag-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for&nbsp<img src='+'"//www.compandsave.com/v/dc/yy/liangf/coupon/nextag-logo.png"'+'/>customers:</p>'+'<p>10% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="10NEX";        
    }
    if (campaign_flag == "suggestions") {
        fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for<br>returning customers:</p>'+'<p>10% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="RETEN";           
    }
    if (utm_flag == "shopzilla") {
        fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for<img src='+'"//www.compandsave.com/v/dc/yy/liangf/coupon/shopzilla-logo.jpg"'+'/>shoppers:</p>'+'<p>5% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="5SHOP";        
    }

        jQuery.post("//www.compandsave.com/v/dc/yy/liangf/servertime/time2.asp", function(data) {
            if (data > 0) {
                fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
                document.getElementById("content_area").appendChild(fileref);
                couponDiv.id = "cas_cms_couponDivAmazon";
                document.getElementById("content_area").appendChild(couponDiv);
                document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>20% OFF<br>Only Today!</p>'+'<p>Coupon Code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
                document.getElementById('cas_cms_codeAmazon').innerHTML="OFF20";        
            }
        });     

}
</script>
<!-- End Show coupon on the product page !-->


<!-- Show coupon on the product page --tomatoin !-->
<script type="text/javascript">
/*******************************************************/
/* Description: Show couponcode on the product page */
/* Author: liangf */
/* Version: 5/14 */
/*******************************************************/
function getUrlVars() {
    var vars = {};
    var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {
        vars[key] = value;
    });
    return vars;
}

var fileref=document.createElement("link");
fileref.setAttribute("rel", "stylesheet");
fileref.setAttribute("type", "text/css");
var couponDiv = document.createElement("div");
var coupon_flag = getUrlVars()["couponcode"];
var utm_flag = getUrlVars()["utm_source"];
var campaign_flag = getUrlVars()["utm_campaign"];


if(typeof global_Current_ProductCode != "undefined") {
    if (campaign_flag == "suggestions") {
        fileref.setAttribute("href", "//www.compandsave.com/v/dc/yy/liangf/coupon/css/2014-ti-return-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for<br>returning customers:</p>'+'<p>10% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="TOMTEN";        
    }

jQuery.post("//www.tomatoink.com/v/dc/yy/liangf/servertime/time2.asp", function(data) {
if (data > 0) {
        fileref.setAttribute("href", "//www.compandsave.com/v/dc/yy/liangf/coupon/css/2014-ti-return-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>20% OFF<br>Only Today!</p>'+'<p>Coupon Code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="OFF20"; 
   }

});       
   }
</script>
<!-- End Show coupon on the product page --tomatoink !-->


<!-- Show coupon on the product page --comboink !-->
<script type="text/javascript">
/*******************************************************/
/* Description: Show couponcode on the product page */
/* Author: liangf */
/* Version: 5/13 */
/*******************************************************/
function getUrlVars() {
    var vars = {};
    var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {
        vars[key] = value;
    });
    return vars;
}


var fileref=document.createElement("link");
fileref.setAttribute("rel", "stylesheet");
fileref.setAttribute("type", "text/css");
var couponDiv = document.createElement("div");
var coupon_flag = getUrlVars()["couponcode"];
var utm_flag = getUrlVars()["utm_source"];
var campaign_flag = getUrlVars()["utm_campaign"];


if (typeof global_Current_ProductCode != "undefined") {
    if (utm_flag == "amazon") {
        fileref.setAttribute("href", "//www.compandsave.com/v/dc/yy/liangf/coupon/css/2014-ci-amazon-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for<img src='+'"//www.compandsave.com/v/mp/images/amazon-logo.png"'+'/>shoppers:</p>'+'<p>10% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="10AZON";        
    }
    if (campaign_flag == "suggestions") {
        fileref.setAttribute("href", "//www.compandsave.com/v/dc/yy/liangf/coupon/css/2014-ci-return-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for<br>returning customers:</p>'+'<p>10% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="RETEN";        
    }
    jQuery.post("//www.comboink.com/v/dc/yy/liangf/servertime/time2.asp", function(data) {
  if (data > 0) {
        fileref.setAttribute("href", "//www.compandsave.com/v/dc/yy/liangf/coupon/css/2014-ci-return-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>20% OFF<br>Only Today!</p>'+'<p>Coupon Code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="OFF20";    
    }
});
}
</script>
<!-- End Show coupon on the product page --comboink !-->



<!-- Show coupon on the product page !-->
<script type="text/javascript">
/*******************************************************/
/* Description: Show couponcode on the product page */
/* Author: liangf */
/* Version: 5/8 */
/*******************************************************/
var fileref=document.createElement("link");
fileref.setAttribute("rel", "stylesheet");
fileref.setAttribute("type", "text/css");
var couponDiv = document.createElement("div");
var coupon_flag = getUrlVars()["couponcode"];
var utm_flag = getUrlVars()["utm_source"];
var campaign_flag = getUrlVars()["utm_campaign"];

if(typeof global_Current_ProductCode != "undefined") {


    jQuery.post("//www.compandsave.com/v/dc/yy/liangf/servertime/time3.asp", function(data) {
        if (data > 0) {
            fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
            document.getElementById("content_area").appendChild(fileref);
            couponDiv.id = "cas_cms_couponDivAmazon";
            document.getElementById("content_area").appendChild(couponDiv);
            document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>10% OFF<br>Only Today!</p>'+'<p>Coupon Code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
            document.getElementById('cas_cms_codeAmazon').innerHTML="AX10";        
        }
    }); 


    if (utm_flag == "amazon") {
        fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for<img src='+'"//www.compandsave.com/v/mp/images/amazon-logo.png"'+'/>shoppers:</p>'+'<p>10% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="10AMA";        
    }
    if (utm_flag == "shoppingcom") {
        fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for<img src='+'"//www.compandsave.com/v/dc/yy/liangf/coupon/shopping-logo.png"'+'/>customers:</p>'+'<p>10% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="SCOM10";        
    }
    if (utm_flag == "nextag") {
        fileref.setAttribute("href", "//www.compandsave.com/v/dc/yy/liangf/coupon/css/2014-cas-nextag-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for&nbsp<img src='+'"//www.compandsave.com/v/dc/yy/liangf/coupon/nextag-logo.png"'+'/>customers:</p>'+'<p>10% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="10NEX";        
    }
    if (campaign_flag == "suggestions") {
        fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for<br>returning customers:</p>'+'<p>10% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="RETEN";           
    }
    if (utm_flag == "shopzilla") {
        fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for<img src='+'"//www.compandsave.com/v/dc/yy/liangf/coupon/shopzilla-logo.jpg"'+'/>shoppers:</p>'+'<p>5% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="5SHOP";        
    }
  
}
</script>
<!-- End Show coupon on the product page !-->


<!-- Show coupon on the product page !-->
<script type="text/javascript">
/*******************************************************/
/* Description: Show couponcode on the product page */
/* Author: liangf */
/* Version: 5/8 */
/*******************************************************/
var fileref=document.createElement("link");
fileref.setAttribute("rel", "stylesheet");
fileref.setAttribute("type", "text/css");
var couponDiv = document.createElement("div");
var coupon_flag = getUrlVars()["couponcode"];
var utm_flag = getUrlVars()["utm_source"];
var campaign_flag = getUrlVars()["utm_campaign"];

function show_amazon() {
        fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for<img src='+'"//www.compandsave.com/v/mp/images/amazon-logo.png"'+'/>shoppers:</p>'+'<p>10% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="10AMA"; 
}
function show_shoppingcom() {
        fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for<img src='+'"//www.compandsave.com/v/dc/yy/liangf/coupon/shopping-logo.png"'+'/>customers:</p>'+'<p>10% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="SCOM10";    
}
function show_nextag() {
        fileref.setAttribute("href", "//www.compandsave.com/v/dc/yy/liangf/coupon/css/2014-cas-nextag-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for&nbsp<img src='+'"//www.compandsave.com/v/dc/yy/liangf/coupon/nextag-logo.png"'+'/>customers:</p>'+'<p>10% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="10NEX";  
}
function show_suggestions() {
        fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for<br>returning customers:</p>'+'<p>10% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="RETEN";   
}
function show_shopzilla() {
        fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for<img src='+'"//www.compandsave.com/v/dc/yy/liangf/coupon/shopzilla-logo.jpg"'+'/>shoppers:</p>'+'<p>5% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="5SHOP";   
}
function show_saturday_sunday() {
            fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
            document.getElementById("content_area").appendChild(fileref);
            couponDiv.id = "cas_cms_couponDivAmazon";
            document.getElementById("content_area").appendChild(couponDiv);
            document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>10% OFF<br>Only Today!</p>'+'<p>Coupon Code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
            document.getElementById('cas_cms_codeAmazon').innerHTML="AX10";        
}


if(typeof global_Current_ProductCode != "undefined") {
     //jQuery.post("//www.compandsave.com/v/dc/yy/liangf/servertime/time3.asp", function(data) {
    jQuery.post("//www.compandsavetest.com/v/dc/liang/servertime/time3.asp", function(data) {
        if (data > 0) show_saturday_sunday();
        if (utm_flag == "amazon") show_amazon();
        if (utm_flag == "shoppingcom") show_shoppingcom();
        if (utm_flag == "nextag") show_nextag();
        if (campaign_flag == "suggestions") show_suggestions();
        if (utm_flag == "shopzilla") show_shopzilla();
    });     
}
</script>
<!-- End Show coupon on the product page !-->



<!-- Show coupon on the product page !-->
<script type="text/javascript">
/*******************************************************/
/* Description: Show couponcode on the product page */
/* Author: liangf */
/* Version: 5/8 */
/*******************************************************/
var fileref=document.createElement("link");
fileref.setAttribute("rel", "stylesheet");
fileref.setAttribute("type", "text/css");
var couponDiv = document.createElement("div");
var coupon_flag = getUrlVars()["couponcode"];
var utm_flag = getUrlVars()["utm_source"];
var campaign_flag = getUrlVars()["utm_campaign"];

if(typeof global_Current_ProductCode != "undefined") {

    if (utm_flag == "amazon") {
        fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for<img src='+'"//www.compandsave.com/v/mp/images/amazon-logo.png"'+'/>shoppers:</p>'+'<p>10% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="10AMA";        
    }
    if (utm_flag == "shoppingcom") {
        fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for<img src='+'"//www.compandsave.com/v/dc/yy/liangf/coupon/shopping-logo.png"'+'/>customers:</p>'+'<p>10% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="SCOM10";        
    }
    if (utm_flag == "nextag") {
        fileref.setAttribute("href", "//www.compandsave.com/v/dc/yy/liangf/coupon/css/2014-cas-nextag-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for<br><img src='+'"//www.compandsave.com/v/dc/yy/liangf/coupon/nextag-logo.png"'+'/>customers:</p>'+'<p>10% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="10NEX";        
    }
    if (campaign_flag == "suggestions") {
        fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for<br>returning customers:</p>'+'<p>10% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="RETEN";           
    }
    if (utm_flag == "shopzilla") {
        fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for<img src='+'"//www.compandsave.com/v/dc/yy/liangf/coupon/shopzilla-logo.jpg"'+'/>shoppers:</p>'+'<p>10% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="10SHOP";        
    }
    if (utm_flag == "pricegrabber") {
        fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for<img src='+'"//www.compandsave.com/v/dc/yy/liangf/coupon/pricegrabber-logo.gif"'+'/>shoppers:</p>'+'<p>10% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="PGRABBER";        
    }
    if (getCookie("coupon")=="ADV10") {
        fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>10% OFF<br>Exclusive offer!</p>'+'<p>Coupon Code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="ADV10"; 
    }
    jQuery.post("//www.compandsave.com/v/dc/yy/liangf/servertime/time3.asp", function(data) {
		var amazon_id = document.getElementById("cas_cms_couponDivAmazon");
        if (data > 0 && amazon_id == null) {
            fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
            document.getElementById("content_area").appendChild(fileref);
            couponDiv.id = "cas_cms_couponDivAmazon";
            document.getElementById("content_area").appendChild(couponDiv);
            document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>10% OFF<br>Only Today!</p>'+'<p>Coupon Code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
            document.getElementById('cas_cms_codeAmazon').innerHTML="AX10";        
        }
    });   
}
</script>
<!-- End Show coupon on the product page !-->


