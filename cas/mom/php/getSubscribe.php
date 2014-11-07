<?php

$username = "DBCOMPANDSAVE";
$password = "CAS123cas!";
$hostname = "DBCOMPANDSAVE.db.11475010.hostedresource.com"; 
$databasename = "DBCOMPANDSAVE";	
$conn = mysql_connect($hostname, $username, $password) or die("DB Connnection Error !".mysql_error());
mysql_select_db($databasename, $conn);


$file = fopen("../data/msm-subscribe.csv","w");

$email = "someone@example.com";

//$sql = "SELECT email, firstname, lastname FROM msm_form group by email";
$sql = "SELECT email, firstname, lastname, address, city, state, zip, time FROM msm_form group by email order by time";
$result = mysql_query($sql);
while ($array = mysql_fetch_array($result)) {
	$data = array("0", "1", "2", "3", "4", "5", "6", "7");
	$array["email"] = trim($array["email"], ' ');
	$array["email"] = str_replace(' ', '', $array["email"]);
	if(filter_var($array["email"], FILTER_VALIDATE_EMAIL)) {
		$data[0] = $array["firstname"];
		$data[1] = $array["lastname"];
		$data[2] = $array["email"];
		$data[3] = $array["address"];
		$data[4] = $array["city"];
		$data[5] = $array["state"];
		$data[6] = $array["zip"];
		$data[7] = $array["time"];
		//echo $data[0] . " ";
		//echo $data[1] . " ";
		//echo $data[2] . "<br>";
		fputcsv($file, $data);
	}
	else {
		echo $array[0] . " ";
		echo $array[1] . " ";
		echo $array[2] . "<br>";	
	}
}



mysql_close($conn);



?>