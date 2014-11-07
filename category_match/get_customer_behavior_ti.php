<?php
$username = "DBCOMPANDSAVE";
$password = "CAS123cas!";
$hostname = "DBCOMPANDSAVE.db.11475010.hostedresource.com"; 
$databasename = "DBCOMPANDSAVE";	
$conn = mysql_connect($hostname, $username, $password) or die("DB Connnection Error !".mysql_error());
mysql_select_db($databasename, $conn);


class customer 
{
	public $EmailAddress;
	public $ProductCode;
	public $ProductName;
	public $ProductPrice;
	public $ListPrice;
}


$filename = array("", "CAS_Customer_Behavior.csv", "CI_Customer_Behavior.csv", "TI_Customer_Behavior.csv");
$table_arr = array("", "cas", "ci", "ti");



$file = fopen("Brand_Specific_TI.csv", "w");


$count = 0;
$array_email = array();
$sql = "SELECT * FROM july_survey2 where FormID=3";
$result = mysql_query($sql);
while ($array = mysql_fetch_array($result)) {
	$email = trim($array['Email']);
	$email = strtolower($email);
	
	if ($array_email[$email] == 123) {
		echo $email . " is duplicated.<br>";
	}
	else {
		$count++;
		$array_email[$email] = 123;
	}
}
echo "july_survey2" ." => " ."ti: " .$count . "<br>";




$array_email2 = array();
$sql2 = "SELECT * FROM customer_behavior_ti";
$result = mysql_query($sql2);
while ($array = mysql_fetch_array($result)) {
	$email = trim($array['EmailAddress']);
	$email = strtolower($email);
	$productcode = trim($array['ProductCode']);
	$productname = trim($array['ProductName']);
	$productprice = (float) trim($array['ProductPrice']);
	$listprice = (float) trim($array['ListPrice']);

	$mycustomer = new customer();
	$mycustomer->EmailAddress = trim($array['EmailAddress']);
	$mycustomer->ProductCode = $productcode;
	$mycustomer->ProductName = $productname;
	$mycustomer->ProductPrice = $productprice;
	$mycustomer->ListPrice = $listprice;

	
	if ($array_email[$email] > 0) {
		//echo $email . " found in july_survey2" . "<br>";
	}
	else {
		if ( !$array_email2[$email] ) {
			$array_email2[$email] = $mycustomer;
		} else {
			$old_productprice = $array_email2[$email]->ProductPrice;
			if ($productprice > $old_productprice) {
				//echo $old_productprice . " <-old--new-> " . $productprice . "<br>";
				$array_email2[$email] = $mycustomer;
			}
		}

	}
}
echo "customer_behavior_ti" ." AFTER SUBTRACTION: " .count($array_email2)  ."<br>";


$count = 0;
$count2 = 0;
$sql3 = "SELECT * FROM customer_behavior_ti";
$result = mysql_query($sql3);
$is_first_occur = array();
$data = array("EmailAddress", "ProductCode", "ProductName", "ProductPrice", "ListPrice", "Brand", "Genre");
fputcsv($file, $data);
while ($array = mysql_fetch_array($result)) {
	$email = trim($array['EmailAddress']);
	$email = strtolower($email);

	if ($is_first_occur[$email] == 123) {
		//echo $email . " is the 2nd occur.<br>";
	}
	else {
		$is_first_occur[$email] = 123;
		if ( $array_email2[$email] ) {
			$count++;
			$data[0] = $array_email2[$email]->EmailAddress;
			$data[1] = $array_email2[$email]->ProductCode;
			$data[2] = $array_email2[$email]->ProductName;
			$data[3] = $array_email2[$email]->ProductPrice;
			$data[4] = $array_email2[$email]->ListPrice;

			$productcode = $data[1];
			$tmp_arr = explode("-", $productcode);
			$brand = trim($tmp_arr[1]);
			if ( $brand == "Kyocera" ) $brand = "Kyocera-Mita";
			if ( $brand == "Konica" || $brand=="Minolta") $brand = "Konica-Minolta";
			
			$genre = trim($tmp_arr[0]);
			if ( $genre=="INK" || $genre=="WINK" || $genre=="ZINK") $genre = "INK";
			if ( $genre=="TONER" || $genre=="WTONER" || $genre=="ZTONER") $genre = "TONER";
			
			$data[5] = $brand;
			$data[6] = $genre;
			
			fputcsv($file, $data);				
		}
		else {
			//echo $email ."<br>";
			$count2++;
		}
	}
}
echo "ti write: " .$count . "/" . ($count+$count2) ."<br>";
echo "<br><br>";











mysql_close($conn);
?>