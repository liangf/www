<?php
#showUser.php
#require_once 'config.php';
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