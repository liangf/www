<?php
$username = "DBCOMPANDSAVE";
$password = "CAS123cas!";
$hostname = "DBCOMPANDSAVE.db.11475010.hostedresource.com"; 
$databasename = "DBCOMPANDSAVE";	
$conn = mysql_connect($hostname, $username, $password) or die("DB Connnection Error !".mysql_error());
mysql_select_db($databasename, $conn);



// Update the new items
$sql = "SELECT max(ID) as maxID FROM july_survey2";
$result = mysql_query($sql);
$array = mysql_fetch_array($result);
$maxID = $array['maxID'];

$sql = "SELECT * FROM july_survey";
$result = mysql_query($sql);
while ($array = mysql_fetch_array($result)) {
	if ($array[0] > $maxID) {
		$sql_in = "insert into july_survey2 (ID, Q1, Product, Q2, Q3, Q4, Q5, FirstName, LastName, Email, Street, City, State, Zipcode, Country, FormID) 
SELECT ID, Q1, Product, Q2, Q3, Q4, Q5, FirstName, LastName, Email, Street, City, State, Zipcode, Country, FormID FROM july_survey where ID=$array[0]";
		if ( !mysql_query($sql_in) ) echo "'" .$array[0] ."'" ." insert no success. <br>";
		echo $sql_in . "<br>";
	}
}



// Delete the duplicate entries, according to email address.
$array_email = array();
$sql = "SELECT * FROM july_survey2";
$result = mysql_query($sql);
while ($array = mysql_fetch_array($result)) {
	$email = trim($array['Email']);
	$ID = $array['ID'];
	//echo $ID. ", ". $email . "<br>";
	if ($array_email[$email] == 123) {
		$sql_d = "delete from july_survey2 where ID='$ID'";
		if( !mysql_query($sql_d) ) echo "'" .$ID ."'" ." delete no success. <br>";
		echo $sql_d . "<br>";
	}
	else $array_email[$email] = 123;
}









?>

