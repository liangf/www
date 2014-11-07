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
if (typeof coupon_flag == "undefined") coupon_flag ="";
if (typeof utm_flag == "undefined") utm_flag ="";
if (typeof campaign_flag == "undefined") campaign_flag ="";

if(typeof global_Current_ProductCode != "undefined") {

    if (utm_flag == "amazon") {
        fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for<br><img src='+'"//www.compandsave.com/v/mp/images/amazon-logo.png"'+'/>shoppers:</p>'+'<p>10% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="10AMA";        
    }
    if (utm_flag == "shoppingcom") {
        fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for<br><img src='+'"//www.compandsave.com/v/dc/yy/liangf/coupon/shopping-logo.png"'+'/>customers:</p>'+'<p>10% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
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
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for<br><img src='+'"//www.compandsave.com/v/dc/yy/liangf/coupon/shopzilla-logo.jpg"'+'/>shoppers:</p>'+'<p>10% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="10SHOP";        
    }
    if (utm_flag == "pricegrabber") {
        fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>Special offer for<br><img src='+'"//www.compandsave.com/v/dc/yy/liangf/coupon/pricegrabber-logo.gif"'+'/>shoppers:</p>'+'<p>10% OFF with coupon code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="PGRABBER";        
    }
    if (getCookie("coupon")=="ADV10" && utm_flag=="" && campaign_flag=="") {
        fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
        document.getElementById("content_area").appendChild(fileref);
        couponDiv.id = "cas_cms_couponDivAmazon";
        document.getElementById("content_area").appendChild(couponDiv);
        document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>10% OFF<br>Exclusive offer!</p>'+'<p>Coupon Code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
        document.getElementById('cas_cms_codeAmazon').innerHTML="ADV10"; 
    }
    jQuery.post("//www.compandsave.com/v/dc/yy/liangf/servertime/time3.asp", function(data) {
		console.log("data:" + data);
        var amazon_id = document.getElementById("cas_cms_couponDivAmazon");
        if (data==1 && amazon_id == null) {
            fileref.setAttribute("href", "//www.compandsave.com/v/mp/css/2014-cas-amazon-coupondiv.css");
            document.getElementById("content_area").appendChild(fileref);
            couponDiv.id = "cas_cms_couponDivAmazon";
            document.getElementById("content_area").appendChild(couponDiv);
            document.getElementById("cas_cms_couponDivAmazon").innerHTML = '<p>10% OFF<br>Only Today!</p>'+'<p>Coupon Code:</p>'+'<p><strong id="cas_cms_codeAmazon"></strong></p>';	
            document.getElementById('cas_cms_codeAmazon').innerHTML="AX10";   
        }
    });   
}
