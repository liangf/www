<?php
#showUser.php
#require_once 'config.php';
//require_once '../test/facebook-php-sdk/src/facebook.php';
require_once '../test/facebook-php-sdk/src/facebook.php';
$app_id		= "539611232825431";
$app_secret	= "d39d574c4498af7c34a0be7383ed1379";
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

$user = $facebook->getUser();

if($user)
{
    if ($user) {
        try {
            // Proceed knowing you have a logged in user who's authenticated.
            $user_profile = $facebook->api('/me');
            var_dump($user_profile); //You can now save this data
        } catch (FacebookApiException $e) {
            echo '<pre>'.htmlspecialchars(print_r($e, true)).'</pre>';
            $user = null;
        }
    }
}

?>