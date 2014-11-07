window.fbAsyncInit = function () {
	FB.init({
				appId:	'552845631499488',
				cookie: true,
				xfbml: 	true,
				oauth: 	true
			});
			
	FB.Event.subscribe('edge.create', function(href, widget) {
		// Do something, e.g. track the click on the "Like" button here
		alert('You just liked '+href);
		//window.location = "showUser.php";
	});
	
	FB.Event.subscribe('auth.authResponseChange', function(response) {
		// Here we specify what we do with the response anytime this event occurs. 
		if (response.status === 'connected') {
			//alert("you are connected.");
		} 
		else if (response.status === 'not_authorized') {
			//alert("you are not authorized.");
		} 
		else {
			//alert("you are not connected.");
		}
	});
 
	FB.getLoginStatus(function(response) {
		if (response.status === 'connected') {
			var uid = response.authResponse.userID;
			var accessToken = response.authResponse.accessToken;
			//alert("response connected");
		} 
		else if (response.status === 'not_authorized') {
			//alert("response not authorized");
		} 
		else {
			//alert("response not connected");
		}
	});

};
(function () {
	var e = document.createElement('script');
    e.async = true;
    e.src = document.location.protocol +
            '//connect.facebook.net/en_US/all.js';
    document.getElementById('fb-root').appendChild(e);
}());
	


function share_prompt()
{
	FB.login(function (response){
		if (response.authResponse){
			var uid = response.authResponse.userID;
			var accessToken = response.authResponse.accessToken;
			FB.ui(
			{
				method: 'feed',
				name: 'I found an Easter Egg at CompAndSave.com!',
				link: 'http://www.compandsave.com/v/newsletter/promotion-april-2014/promotion-april-2014.asp',
				picture: 'http://www.compandsave.com/v/newsletter/promotion-april-2014/images/egg4-facebook.jpg',
				description: 'Join the hunt at CompAndSave.com and uncover great savings on ink this Easter!',
				message: 'CompAndSave Easter Campaign!'
			},function(response) {
				if (response && response.post_id) {
					_gaq.push(['_trackEvent', 'Easter', 'Lexmark', 'FBshare']);
					FB.api('/me', function(response) {
						//jQuery.post("http://www.casinkadmin.com/yy/liangf/compandsave/storeShare.php",
						jQuery.post("http://www.casinkadmin.com/liang/castest/easter/php/storeShare.php",
						//jQuery.post("http://www.866ink.com/liang/storeShare.php",
							{uname: response.name, uemail: response.email, uID: uid, ulink: response.link, ueggID: 4}, 
							function(data){ 
								//window.location.assign("http://www.compandsave.com/v/newsletter/promotion-april-2014/egg-1-thanks.html");
								//window.location.assign("http://www.compandsavetest.com/v/dc/J/promotion-april-2014/egg-thanks.html");
								//window.location.assign("http://www.compandsave.com/v/newsletter/promotion-april-2014/egg-4-thanks.html");
								window.location.assign("http://www.compandsavetest.com/v/dc/liang/cas/easter/html/4-12/egg-4-thanks.html");
							}
						);
					});
				} 
				else {
					//alert('Post was not published.');
				}
			}
			);
		}
		else { }
	},{scope:'email'}	
	);
} 

function validateForm() {
	var x=document.forms["MailingList"]["emailaddress"].value;
	if (x==null || x=="") {
		//alert("Email must be filled out");
		document.getElementById("error").innerHTML="Email must be filled out";
		return false;
	}
	var x=document.forms["MailingList"]["emailaddress"].value;
	var atpos=x.indexOf("@");
	var dotpos=x.lastIndexOf(".");
	if (atpos<1 || dotpos<atpos+2 || dotpos+2>=x.length) {
		//alert("Not a valid e-mail address");
		document.getElementById("error").innerHTML="Not a valid e-mail";
		return false;
	}
	_gaq.push(['_trackEvent', 'Easter', 'Lexmark', 'Newsletter']);
}

function myFunction() {
  //alert("you click.");
}

function easter_getCookie(cname) {
	var name = cname + "=";
	var ca = document.cookie.split(';');
	for(var i=0; i<ca.length; i++) {
		var c = ca[i].trim();
		if (c.indexOf(name)==0) return c.substring(name.length,c.length);
	}
	return "";
}



$(document).ready(function(){
	//$('#easter_link_lp').attr('href', "http://www.compandsave.com/v/newsletter/promotion-april-2014/promotion-april-2014.asp?test=easter-egg");
	//$('#easter_link_lp').attr('href', "http://www.compandsavetest.com/v/dc/J/promotion-april-2014-4-11/promotion-april-2014.asp?test=easter-egg");
	$('#easter_link_lp').attr('href', "http://www.compandsavetest.com/v/dc/liang/cas/easter/html/4-12/promotion-april-2014.asp?test=easter-egg");
	
	var user = easter_getCookie("easter_landingpage");
	//if (user=="lp2") $('#easter_link_lp').attr('href', "http://www.compandsave.com/v/newsletter/promotion-april-2014/promotion-april-2014-2.asp?test=easter-egg#easter-rules");
	//if (user=="lp2") $('#easter_link_lp').attr('href', "http://www.compandsavetest.com/v/dc/J/promotion-april-2014-4-11/promotion-april-2014-2.asp?test=easter-egg#easter-rules");
	if (user=="lp2") $('#easter_link_lp').attr('href', "http://www.compandsavetest.com/v/dc/liang/cas/easter/html/4-12/promotion-april-2014-2.asp?test=easter-egg");
});