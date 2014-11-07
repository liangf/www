<?php
header('Access-Control-Allow-Origin: http://www.compandsave.com');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');

$username = "DBCOMPANDSAVE";
$password = "CAS123cas!";
$hostname = "DBCOMPANDSAVE.db.11475010.hostedresource.com"; 
$databasename = "DBCOMPANDSAVE";	
$conn = mysql_connect($hostname, $username, $password) or die("DB Connnection Error !".mysql_error());
mysql_select_db($databasename, $conn);



require_once('recaptchalib.php');
$privatekey = "6Le_y_USAAAAALZphGDl4gebk-IX_eyYD9xCAIaX";
$resp = recaptcha_check_answer ($privatekey,
                                $_SERVER["REMOTE_ADDR"],
                                $_POST["recaptcha_challenge_field"],
                                $_POST["recaptcha_response_field"]);

if (!$resp->is_valid) {
    // What happens when the CAPTCHA was entered incorrectly
    die ("The reCAPTCHA wasn't entered correctly. Go back and try it again." .
         "(reCAPTCHA said: " . $resp->error . ")");
} else {
    // Your code here to handle a successful verification
	echo "yes";
	
	$name = $_POST["uname"];
	$date = $_POST["udate"];
	$email = $_POST["uemail"];
	$formID = $_POST["fid"];	
	
	//echo $email;
	
	$sql = "INSERT INTO fbreview (id, name, reviewdate, email, time, formID) 
			VALUES(0, '$name', '$date', '$email', now(), $formID)";
	mysql_query($sql);	
	
}
  
  
mysql_close($conn);  
?>