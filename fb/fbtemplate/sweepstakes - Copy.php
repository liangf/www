<?php
$username = "DBCOMPANDSAVE";
$password = "CAS123cas!";
$hostname = "DBCOMPANDSAVE.db.11475010.hostedresource.com"; 
$databasename = "DBCOMPANDSAVE";	
$conn = mysql_connect($hostname, $username, $password) or die("DB Connnection Error !".mysql_error());
mysql_select_db($databasename, $conn);
?>

<?php
$is_submitted = false;

session_save_path('/var/www/html/production_domains/secure_compandsave_com/lf/fbtemplate/session');
ini_set('session.gc_probability', 1);



require_once './facebook-php-sdk/src/facebook.php';
$app_id		= "685245741523569";
$app_secret	= "3686b58ac527bf7dc48ad7edf4680c56";





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
            //var_dump($user_profile); //You can now save this data
			//echo $user_profile["email"] . "<br>";
			$email = $user_profile["email"];
			$sql = "SELECT * FROM fb_sweepstakes where Email='$email'";
			$result = mysql_query($sql);
			$num_r = mysql_num_rows($result);
			if ($num_r > 0) $is_submitted = true;
        } catch (FacebookApiException $e) {
			
            //echo '<pre>'.htmlspecialchars(print_r($e, true)).'</pre>';
            $user = null;
        }
    }
}


?>


<!DOCTYPE html>
<html xmlns:fb="http://ogp.me/ns/fb#" lang="en">
<head>
<script>
window.fbAsyncInit = function() {
      //FB.init({"appId": "624452304314106", "status": true, "cookie": true, "xfbml": true});
	FB.init({
				appId:	'685245741523569',
				cookie: true,
				xfbml: 	true,
				oauth: 	true
			});	  
      //FB.Canvas.setAutoGrow();
      //FB.Canvas.scrollTo(0,0); 
		FB.Canvas.setSize({height:600});
		setTimeout("FB.Canvas.setAutoGrow()",500);
		
	FB.getLoginStatus(function(response) {
		if (response.status === 'connected') {
			//var uid = response.authResponse.userID;
			//var accessToken = response.authResponse.accessToken;
			//console.log(response);
				FB.api('/me', function(response) {
				//console.log(response);
				//console.log(response.email);
			});
		} 
		else if (response.status === 'not_authorized') {
			//alert("response not authorized");
		} 
		else {
			//alert("response not connected");
		}
	});

};
(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/all.js";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));
</script>
  <link href="facebook-sweepstakes.css" rel='stylesheet' type='text/css'/>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
</head>

<body class="cas_fb-sweepstakes">
  <div class="cas_fb-title-image"><img alt="Original" src="./original.jpg"></img></div>
  <div id="cas_fb-title-banner">CompAndSave's July Giveaway</div>
<?php 
$email = (isset($_GET['email']) ? $_GET['email'] : null);

			$sql = "SELECT * FROM fb_sweepstakes where Email='$email'";
			//echo $sql . "<br>";
			$result = mysql_query($sql);
			$num_r = mysql_num_rows($result);
			if ($num_r > 0) $is_submitted = true;
			
if ($is_submitted) {
	echo '<div class="cas_fb_thanks"><h1>You have submitted the form.</h1></div>';
	
}
else if( $email ) {

	echo '<div class="cas_fb_thanks"><h1>Thanks for your participation.</h1></div>';
	
	$firstname = $_GET["firstname"];
	$lastname = $_GET["lastname"];
	$address = $_GET["address"];
	$city = $_GET["city"];
	$zip = $_GET["zip"];
	$state = $_GET["state"];
	$email = $_GET["email"];
	
	
	//echo $user_eggID;
	$sql = "INSERT INTO fb_sweepstakes (ID, FirstName, LastName, Email, Street, City, State, Zipcode, Time, FormID) VALUES(0, '$firstname', '$lastname', '$email', '$address', '$city', '$state', '$zip', now(), 0)";
	mysql_query($sql);			

} 
else { 
?>
  <div class="cas_fb-half">
    <div class="cas_fb-inner">
      <div id="cas_fb-autofill"><button onClick="auto_fill()">Autofill with Facebook</button></div>
	  <br>
	  <fb:like-box colorscheme="light" data-page-id="36245452776" header="false" height="62" href="https://www.facebook.com/compandsave.ink" show_border="false" show_faces="false" stream="false" width="413"></fb:like-box>
	  
	  <form onsubmit="return subForm()" method="get" action="https://secure.compandsave.com/lf/fbtemplate/sweepstakes.php">
	  <b>First Name</b><br>
	  <input type="text" id="cas_fb_firstname" name="firstname" value="" size="50"><br>
	  <b>Last Name</b><br>
	  <input type="text" id="cas_fb_lastname" name="lastname" value="" size="50"><br>
	  <b>Email</b><br>
	  <input type="text" id="cas_fb_email" name="email" value="" size="50"><br>	
	  <b>Street Address</b><br>
	  <input type="text" id="cas_fb_address" name="address" value="" size="50"><br>	  
	  <b>City</b><br>
	  <input type="text" id="cas_fb_city" name="city" value="" size="50"><br>	  
	  <b>Zip Code</b><br>
	  <input type="text" id="cas_fb_zip" name="zip" value="" size="50"><br>	  	  
	  <b>State</b><br>
	  <input type="text" id="cas_fb_state" name="state" value="" size="50"><br> 
<label><input id="birthday_check" type="checkbox" value="agree">I affirm that I am older than 16</label><br>
<label><input id="policy_check" type="checkbox" value="agree">By providing your email address, CompAndSave.com may email you company updates and announcements. You can unsubscribe at any time. I have read and agree to the <a href="http://www.compandsave.com/Contest-and-Giveaway-Rules_a/286.htm" target="_blank">Official Rules</a> and <a href="http://www.compandsave.com/terms_privacy.asp" target="_blank">Privacy Policy</a></label><br>
<!--<label><input id="share_check" type="checkbox" value="agree">Share on Your Wall</label><br>-->	  
	  <div id="cas_fb_submit"><button >Enter to Win</button></div>  
	  <p>This promotion is in no way sponsored, endorsed or administered by, or associated with, Facebook. You understand that you are providing your information to CompAndSave and not to Facebook.</p>
	  <p id="cas_fb_alert" style="color:red"></p>
	  </form>
    </div>
  </div>
  
  <div class="cas_fb-half">
    <div class="cas_fb-inner">
      <div id="prize-description">
        <div class="sweeps-title">Prize Description:</div>
        <p>Enter for a chance to win a FREE 3-Burner BBQ Gas grill and tool set. THREE WINNERS will be randomly chosen and each winner will receive a BBQ grill along with a Premium BBQ Tool Set, just in time for the 4th July celebration.</p>
<p>Barbecuing has become one of our nation&rsquo;s favorite past time and nothing screams Independence Day like enjoying freshly cooked BBQ during a fireworks display. This full-size backyard 3-burner gas grill is perfect for any summer occasion. If you subscribe now, maybe you can be one of the winners!<br /><br />* By providing your email address, CompAndSave.com may email you company updates and announcements. You can unsubscribe at any time.</p>
      </div>
      <div id="sweeps-dates">
        <div id="start-date">
          <span class="sweeps-title ">Sweepstakes starts</span>July 1, 2014 08:00
        </div>
        <div id="end-date">
          <span class="sweeps-title">Giveaway ends</span>July 31, 2014 23:59
        </div>
      </div>
      <div id="rules-and-pp">
        <span id="rules"><a href="http://www.compandsave.com/Contest-and-Giveaway-Rules_a/286.htm" class="engagements_rules_link" target="_blank">Official Rules</a></span><span id="pp"><a href="http://www.compandsave.com/terms_privacy.asp" class="engagements_privacy_policy_link" target="_blank">Privacy Policy</a></span>
      </div>
    </div>
  </div>


<?php
}
mysql_close($conn);
?>

</body>


<script>
function myFunction()
{
alert("The form will be submitted");
return false;
}

function auto_fill()
{

	FB.login(function (response){
		if (response.authResponse){
			var uid = response.authResponse.userID;
			var accessToken = response.authResponse.accessToken;
			FB.api('/me', function(response) {
				console.log(response);
				//console.log(response.location.name);
				var city_state = "";
				if (response.location) city_state = response.location.name;
				city_state = city_state.split(",");
				document.getElementById("cas_fb_firstname").value = response.first_name;
				document.getElementById("cas_fb_lastname").value = response.last_name;
				document.getElementById("cas_fb_email").value = response.email;
				document.getElementById("cas_fb_city").value = jQuery.trim( city_state[0] );
				document.getElementById("cas_fb_state").value = jQuery.trim( city_state[1] );
			});	
		}
		else { }
	},{scope:'email,public_profile,user_location'}	
	);
} 



function validateEmail(email) { 
    var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}

function subForm() {


	var firstname = document.getElementById('cas_fb_firstname').value
	var lastname = document.getElementById('cas_fb_lastname').value
	var address = document.getElementById('cas_fb_address').value
	var city = document.getElementById('cas_fb_city').value
	var zip = document.getElementById('cas_fb_zip').value
	var state = document.getElementById('cas_fb_state').value
	var email = document.getElementById('cas_fb_email').value

	firstname = jQuery.trim( firstname );
	lastname = jQuery.trim( lastname );
	address = jQuery.trim( address );
	city = jQuery.trim( city );
	zip = jQuery.trim( zip );
	state = jQuery.trim( state );
	email = jQuery.trim( email );



if ( firstname=="" || firstname=="First Name" || /[<>()\[\]{}\\\/_|!@#$%^&*+=?:;~`"0-9]/.test(firstname)==true) {
	if ( /[<>()\[\]{}\\\/_|!@#$%^&*+=?:;~`"0-9]/.test(firstname)==true ) 
		document.getElementById('cas_fb_alert').innerHTML = "Please input a valid first name," + " it may contain <>()\[\]{}\\\/_|!@#$%^&*+=?:;~`\" or numbers 0-9."
	else document.getElementById('cas_fb_alert').innerHTML = "Please input a valid first name."	
	return false;
} else  document.getElementById('cas_fb_alert').innerHTML = "";	

if (lastname=="" || lastname=="Last Name" || /[<>()\[\]{}\\\/_|!@#$%^&*+=?:;~`"0-9]/.test(lastname)==true) {
	if (/[<>()\[\]{}\\\/_|!@#$%^&*+=?:;~`"0-9]/.test(lastname)==true)
		document.getElementById('cas_fb_alert').innerHTML = "Please input a valid last name," + " it may contain <>()\[\]{}\\\/_|!@#$%^&*+=?:;~`\" or numbers 0-9."
	else document.getElementById('cas_fb_alert').innerHTML = "Please input a valid last name."
	return false;
} else document.getElementById('cas_fb_alert').innerHTML = "";

if (email=="" || email=="Email" || validateEmail(email)==false) {
	document.getElementById('cas_fb_alert').innerHTML = "Please input a valid email."
	return false;
} else document.getElementById('cas_fb_alert').innerHTML = "";

if (address=="" || address=="Address" || /[<>()\[\]{}\\\/_|!@$%^&*+=?:;~`"]/.test(address)==true) {
	if (/[<>()\[\]{}\\\/_|!@$%^&*+=?:;~`"]/.test(address)==true)
		document.getElementById('cas_fb_alert').innerHTML = "Please input a valid address," + " it may contain <>()[]{}\/_|!@$%^&*+=?:;~`\"."	
	else document.getElementById('cas_fb_alert').innerHTML = "Please input a valid address."
	return false;
} else document.getElementById('cas_fb_alert').innerHTML = "";

if (city=="" || city=="City" || /[<>()\[\]{}\\\/_|!@#$%^&*+\-=?:;~`"0-9]/.test(city)==true) {
	if (/[<>()\[\]{}\\\/_|!@#$%^&*+\-=?:;~`"0-9]/.test(city)==true)
		document.getElementById('cas_fb_alert').innerHTML = "Please input a valid city," + " it may contain <>()[]{}\/_|!@#$%^&*+\-=?:;~`\" or numbers 0-9."
	else document.getElementById('cas_fb_alert').innerHTML = "Please input a valid city."
	return false;
} else document.getElementById('cas_fb_alert').innerHTML = "";

if (zip=="" || zip=="Zip Code" || /(^\d{5}$)|(^\d{5}-\d{4}$)/.test(zip)==false) {
	document.getElementById('cas_fb_alert').innerHTML = "Please input a valid zip code."	
	return false;
} else document.getElementById('cas_fb_alert').innerHTML = "";

if (state=="" || state=="State" || /[<>()\[\]{}\\\/_|!@#$%^&*+\-=?,:;'~`"0-9]/.test(state) == true) {
	if (/[<>()\[\]{}\\\/_|!@#$%^&*+\-=?,:;'~`"0-9]/.test(state) == true)
		document.getElementById('cas_fb_alert').innerHTML = "Please input a valid state," + " it may contain <>()[]{}\/_|!@#$%^&*+\-=?,:;'~`\" or numbers 0-9."
	else document.getElementById('cas_fb_alert').innerHTML = "Please input a valid state."
	return false;
} else document.getElementById('cas_fb_alert').innerHTML = "";



if(!$("#birthday_check").is(':checked')) {
	document.getElementById('cas_fb_alert').innerHTML = "Please click the checkbox.";
	return false;
} else document.getElementById('cas_fb_alert').innerHTML = "";

if(!$("#policy_check").is(':checked')) {
	document.getElementById('cas_fb_alert').innerHTML = "Please click the checkbox.";
	return false;
} else document.getElementById('cas_fb_alert').innerHTML = "";


/*
	FB.login(function (response){
		if (response.authResponse){
			var uid = response.authResponse.userID;
			var accessToken = response.authResponse.accessToken;
			FB.ui(
			{
				method: 'feed',
				name: 'I found an Easter Egg at CompAndSave.com!',
				link: 'http://www.compandsave.com/v/newsletter/promotion-april-2014/promotion-april-2014.asp',
				picture: 'http://www.compandsave.com/v/newsletter/promotion-april-2014/images/egg1-facebook.jpg',
				description: 'Join the hunt at CompAndSave.com and uncover great savings on ink this Easter!',
				message: 'CompAndSave Easter Campaign!'
			},function(response) {
				if (response && response.post_id) {
					window.location.assign("http://www.compandsavetest.com/v/dc/liang/cas/easter/html/4-12/egg-1-thanks.html");
				} 
				else {
					return false;
				}
			}
			);				
		}
		else { }
	},{scope:'email,public_profile,user_location'}	
	);
*/
}


jQuery(document).ready(function(){

});

</script>
</html>