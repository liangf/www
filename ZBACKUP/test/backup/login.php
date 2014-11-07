<?php
#require_once 'config.php';
#require_once 'lib/facebook.php';
require_once 'facebook-php-sdk/src/facebook.php';
$app_id		= "1405371083065862";
$app_secret	= "68d6fea369c2c647b8ae7b1800ace4f1";
/*
$facebook = new Facebook(array(
    'appId' => FB_APP_ID,
    'secret' => FB_APP_SECRET,
));
*/

$facebook = new Facebook(array(
    'appId' => $app_id,
    'secret' => $app_secret,
));

?>
<!DOCTYPE html>
<html xmlns:fb="http://www.facebook.com/2008/fbml">
<body>

<div id="fb-root">foot-root</div>
<script>
    window.fbAsyncInit = function () {
        FB.init({
            appId:'<?php echo $facebook->getAppID() ?>',
            cookie:true,
            xfbml:true,
            oauth:true
        });
/*
        FB.Event.subscribe('auth.login', function (response) {
            window.location = "showUser.php"; //redirect to showUser.php on Login
        });
        FB.Event.subscribe('auth.logout', function (response) {
            window.location.reload();
        });
*/
  FB.Event.subscribe('auth.authResponseChange', function(response) {
    // Here we specify what we do with the response anytime this event occurs. 
    if (response.status === 'connected') {
      // The response object is returned with a status field that lets the app know the current
      // login status of the person. In this case, we're handling the situation where they 
      // have logged in to the app.
      //window.location = "showUser.php"; //redirect to showUser.php on Login
	  //window.location = "login.php";
	  alert("you are connected!");
    } else if (response.status === 'not_authorized') {
      // In this case, the person is logged into Facebook, but not into the app, so we call
      // FB.login() to prompt them to do so. 
      // In real-life usage, you wouldn't want to immediately prompt someone to login 
      // like this, for two reasons:
      // (1) JavaScript created popup windows are blocked by most browsers unless they 
      // result from direct interaction from people using the app (such as a mouse click)
      // (2) it is a bad experience to be continually prompted to login upon page load.
      FB.login();
    } else {
      // In this case, the person is not logged into Facebook, so we call the login() 
      // function to prompt them to do so. Note that at this stage there is no indication
      // of whether they are logged into the app. If they aren't then they'll see the Login
      // dialog right after they log in to Facebook. 
      // The same caveats as above apply to the FB.login() call here.
      FB.login();
    }
  });

   FB.Event.subscribe('edge.create', function(href, widget) {
	// Do something, e.g. track the click on the "Like" button here
	alert('You just liked '+href);
	});

function share_prompt()
{

    FB.ui(
       {
         method: 'feed',
         name: 'Facebook Dialogs',
         link: 'http://developers.facebook.com/docs/reference/dialogs/',
         picture: 'http://fbrell.com/f8.jpg',
         caption: 'Reference Documentation',
         description: 'Dialogs provide a simple, consistent interface for applications to interface with users.',
         message: 'Facebook Dialogs are easy!'
       },
       function(response) {
         if (response && response.post_id) {
           alert('Post was published.');
         } else {
           alert('Post was not published.');
         }
       }
     );
 }

    };
    (function () {
        var e = document.createElement('script');
        e.async = true;
        e.src = document.location.protocol +
            '//connect.facebook.net/en_US/all.js';
        document.getElementById('fb-root').appendChild(e);
    }());


</script>

<!--
<div class="fb-login-button" scope="email,user_checkins">login</div>
-->
<div class="fb-like" data-href="http://www.liangfang.us/test/test.html" data-layout="standard" data-action="like" data-show-faces="true" data-share="false"></div>

<div class="fb-share-button" data-href="http://www.liangfang.us/test/test.html" data-type="button_count"></div>

<input type="button" onclick="share_prompt()" value="Share" />

</body>
</html>