window.fbAsyncInit = function () {
	FB.init({
				appId:	'706774942705898',
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
		} 
		else if (response.status === 'not_authorized') {
		} 
		else {
		}
	});
 
	FB.getLoginStatus(function(response) {
		if (response.status === 'connected') {
			var uid = response.authResponse.userID;
			var accessToken = response.authResponse.accessToken;
			//alert("response connected.");
		} 
		else if (response.status === 'not_authorized') {
		} 
		else {
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
				name: 'Facebook Dialogs',
				link: 'http://developers.facebook.com/docs/reference/dialogs/',
				picture: 'http://fbrell.com/f8.jpg',
				caption: 'Reference Documentation',
				description: 'Dialogs provide a simple, consistent interface for applications to interface with users.',
				message: 'Facebook Dialogs are easy!'
			},function(response) {
				if (response && response.post_id) {
					FB.api('/me', function(response) {
						//console.log('Good to see you, ' + response.name + '.');
						//console.log('Good to see you, ' + response.email + '.');
						jQuery.post("http://www.casinkadmin.com/yy/liangf/compandsave/lfstoreShare.php",
							{uname: response.name, uemail: response.email, uID: uid}, 
							function(data){ 
								//window.location = "egg-1-thanks.html";
								window.location.assign("http://www.compandsave.com/v/newsletter/promotion-april-2014/egg-1-thanks.html");
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
}