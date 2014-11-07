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
        FB.Event.subscribe('auth.login', function (response) {
            window.location = "showUser.php"; //redirect to showUser.php on Login
        });
        FB.Event.subscribe('auth.logout', function (response) {
            window.location.reload();
        });
    };
    (function () {
        var e = document.createElement('script');
        e.async = true;
        e.src = document.location.protocol +
            '//connect.facebook.net/en_US/all.js';
        document.getElementById('fb-root').appendChild(e);
    }());
</script>

<div class="fb-login-button" data-show-faces="false" data-width="200" data-max-rows="1">login</div>
	 
<div class="fb-share-button" data-href="http://www.liangfang.us/test/test.html" data-type="button_count"></div>

</body>
</html>