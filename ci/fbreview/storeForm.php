<?php
function send_email($name, $date, $email) {

//$to = "liangf@compandsave.com";
$to = "mehmeta@compandsave.com";
$subject = "FB review";


$message = "";
$message .= "ComboInk FB Review\n";

$message .=	str_pad("Facebook name", 50, " ") ."\t";
$message .=	str_pad("Date review left", 50, " ") ."\t";
$message .=	"ComboInk account email\n";
	
$message .= str_pad($name, 50, " ") . "\t";
$message .=str_pad($date, 50, " ") . "\t";
$message .= $email . "\n";

$message .= "\n\n";



// Always set content-type when sending HTML email
$headers = "MIME-Version: 1.0" . "\r\n";
//$headers .= "Content-type:text/html;charset=UTF-8" . "\r\n";


// More headers
$headers .= 'From: <fbreview@compandsave.com>' . "\r\n";
$headers .= 'Cc: liangf@compandsave.com' . "\r\n";

mail($to,$subject,$message,$headers);
}

?>

<?php
header('Access-Control-Allow-Origin: http://www.comboink.com');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');

$username = "DBCOMPANDSAVE";
$password = "CAS123cas!";
$hostname = "DBCOMPANDSAVE.db.11475010.hostedresource.com"; 
$databasename = "DBCOMPANDSAVE";	
$conn = mysql_connect($hostname, $username, $password) or die("DB Connnection Error !".mysql_error());
mysql_select_db($databasename, $conn);



require_once('recaptchalib.php');
$privatekey = "6LcBR_YSAAAAAJ0mnfZpGbIqXhebQ9SjYwHKxIyH";
$resp = recaptcha_check_answer ($privatekey,
                                $_SERVER["REMOTE_ADDR"],
                                $_GET["recaptcha_challenge_field"],
                                $_GET["recaptcha_response_field"]);

if (!$resp->is_valid) {
    // What happens when the CAPTCHA was entered incorrectly
    die ("The reCAPTCHA wasn't entered correctly. Go back and try it again." .
         "(reCAPTCHA said: " . $resp->error . ")");
} else {
    // Your code here to handle a successful verification
	echo "yes";
	
	$name = $_GET["uname"];
	$date = $_GET["udate"];
	$email = $_GET["uemail"];
	$formID = $_GET["fid"];	
	
	//echo $email;
	
	$sql = "INSERT INTO fbreview (id, name, reviewdate, email, time, formID) 
			VALUES(0, '$name', '$date', '$email', now(), $formID)";
	mysql_query($sql);	
	
	// send reminder email
	send_email($name, $date, $email);	
}
  
  
mysql_close($conn);  
?>