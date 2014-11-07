<?php
//header('Access-Control-Allow-Origin: http://www.casinkadmin.com/');
//header('Access-Control-Allow-Origin: http://casinkadmin.com/');
//header('Access-Control-Allow-Methods: POST, GET, OPTIONS');


//require_once 'database.php';
require_once './facebook-php-sdk/src/facebook.php';

$app_id		= "1421391041453021";
$app_secret	= "e9c78269d1f6439e7f177abecc5f4d02";
$facebook = new Facebook(array(
    'appId' => $app_id,
    'secret' => $app_secret,
));
$user = $facebook->getUser();
/*		
$username = "DBCOMPANDSAVE";
$password = "CAS123cas!";
$hostname = "DBCOMPANDSAVE.db.11475010.hostedresource.com"; 
$databasename = "DBCOMPANDSAVE";	
$db = new Mysql($hostname, $username, $password, $databasename);
$db->connect();
*/

$username = "DBCOMPANDSAVE";
$password = "CAS123cas!";
$hostname = "DBCOMPANDSAVE.db.11475010.hostedresource.com"; 
$databasename = "DBCOMPANDSAVE";	
$conn = mysql_connect($hostname, $username, $password) or die("DB Connnection Error !".mysql_error());
mysql_select_db($databasename, $conn);

//$user_name = "liangf";
//$user_email = "mailfangliang@gmail.com";
//$sql = "INSERT INTO easter_fb (id, name, email, time) VALUES(0, '$user_name', '$user_email', now())";
//mysql_query($sql);
	  
if( $_POST["shared"] ) {
	echo $_POST["shared"];
	//echo "you shared.";
}

if($user)
{
    if ($user && $_POST["shared"]) {
        try {
            // Proceed knowing you have a logged in user who's authenticated.
            $user_profile = $facebook->api('/me');
			$user_name = $user_profile['name'];
			$user_email = $user_profile['email'];
			$sql = "INSERT INTO easter_fb (id, name, email, time) VALUES(0, '$user_name', '$user_email', now())";
			mysql_query($sql);
            //var_dump($user_profile); //You can now save this data
        } catch (FacebookApiException $e) {
            echo '<pre>'.htmlspecialchars(print_r($e, true)).'</pre>';
            $user = null;
        }
    }
}

mysql_close($conn);
?>