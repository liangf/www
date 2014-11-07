<!DOCTYPE html>
<html xmlns:fb="http://www.facebook.com/2008/fbml">
<body>

<div id="fb-root">foot-root</div>

<!--
div class="fb-login-button" scope="email,user_checkins">login</div>
<div class="fb-login-button" scope="email,user_checkins">login</div>
<div class="fb-share-button" data-href="http://www.liangfang.us/test/test.html" data-type="button_count"></div>
-->

<div class="fb-like" data-href="http://www.liangfang.us/test/test.html"></div>
<input type="button" onclick="share_prompt()" value="Share" />

<script>
window.fbAsyncInit = function () {
	FB.init({
				appId:	'539611232825431',
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
				//alert('Post was published.');
				//window.location = "showUser.php";
					//window.location.assign("http://www.casinkadmin.com/yy/liangf/compandsave/showUser.php");
					window.location.assign("http://www.liangfang.us/fb/showUser.php");
				} 
				else {
					//alert('Post was not published.');
				}
			}
			);
		}
		else { }
	},{scope:'publish_stream,email,user_birthday,user_hometown,user_location,user_interests,user_likes'}
	);
}
 
</script>

</body>

</html>