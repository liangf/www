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


for ($i=1; $i<=3; $i++) {
$file = fopen($filename[$i], "w");


$count = 0;
$array_email = array();
$sql = "SELECT * FROM july_survey2 where FormID=$i";
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
echo "july_survey2" ." => " ."$table_arr[$i]: " .$count . "<br>";




$array_email2 = array();
$sql2 = "SELECT * FROM customer_behavior_" . $table_arr[$i];
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
echo "customer_behavior_" .$table_arr[$i] ." AFTER SUBTRACTION: " .count($array_email2)  ."<br>";


$count = 0;
$count2 = 0;
$sql3 = "SELECT * FROM customer_behavior_" . $table_arr[$i];
$result = mysql_query($sql3);
$is_first_occur = array();
$data = array("EmailAddress", "ProductCode", "ProductName", "ProductPrice", "ListPrice");
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
			fputcsv($file, $data);
		}
		else {
			//echo $email ."<br>";
			$count2++;
		}
	}
}
echo "$table_arr[$i] write: " .$count . "/" . ($count+$count2) ."<br>";
echo "<br><br>";
}



/*
$sql = "SELECT * FROM customer_behavior";
$result = mysql_query($sql);
while ($array = mysql_fetch_array($result)) {
	$id = $array['ID'];
	$email = trim($array['EmailAddress']);
	$productcode = trim($array['ProductCode']);
	$productcode = mysql_real_escape_string($productcode);
	$productname = trim($array['ProductName']);
	$productname = mysql_real_escape_string($productname);	
	$productprice = trim($array['ProductPrice']);
	$listprice = trim($array['ListPrice']);
	
	$sql_u = "update customer_behavior set EmailAddress='$email',ProductCode='$productcode',ProductName='$productname',ProductPrice='$productprice',ListPrice='$listprice' where ID=$id";
	if (!mysql_query($sql_u)) {
		echo $sql_u . "<br>";
		//echo $id . " UPDATE NO SUCCESS." . "<br>";
	}
}



$filename = array("", "CAS_Customer_Behavior-1.csv", "CI_Customer_Behavior-1.csv", "TI_Customer_Behavior-1.csv");
$table_arr = array("", "cas", "ci", "ti");

$i=1;
$file = fopen($filename[$i], "w");



$count = 0;
$array_email = array();
$sql = "SELECT * FROM july_survey2 where FormID=$i";
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
echo "july_survey2" ." => " ."$table_arr[$i]: " .$count . "<br>";

$count = 0;
$count2 = 0;
$sql = "SELECT ID,EmailAddress,ProductCode,ProductName,max(ProductPrice) as ProductPrice,ListPrice FROM customer_behavior group by EmailAddress";
$result = mysql_query($sql);
$data = array("EmailAddress", "ProductCode", "ProductName", "ProductPrice", "ListPrice");
fputcsv($file, $data);
while ($array = mysql_fetch_array($result)) {
	$count++;
	//echo $array['EmailAddress'] . "<br>";
	$email = trim($array['EmailAddress']);
	$email2 = strtolower($email);
	if ($array_email[$email] > 0) {
		//echo $email . " found in july_survey2" . "<br>";
	}
	else {
		if ($array_email[$email2] > 0)
			echo $email . " found in july_survey2" . "<br>";
		$count2++;
		$data[0] = $array['EmailAddress'];
		$data[1] = $array['ProductCode'];
		$data[2] = $array['ProductName'];
		$data[3] = $array['ProductPrice'];
		$data[4] = $array['ListPrice'];
		fputcsv($file, $data);
	}
}
echo "cas write: " .$count2 . "/" . $count . "<br>";
*/

/*
$count = 0;
$sql4 = "SELECT EmailAddress, ProductCode, ProductName, max(ProductPrice) as ProductPrice, ListPrice FROM customer_behavior_cas group by EmailAddress";
$result = mysql_query($sql4);
$is_first_occur2 = array();
while ($array = mysql_fetch_array($result)) {
	$email = trim($array['EmailAddress']);
	

	if ($is_first_occur2[$email] == 123) {
		//echo $email . " is the 2nd occur.<br>";
	}
	else {
		$count++;
		$is_first_occur2[$email] = 123;
	}
}
echo $count . "<br>";


$count = 0;
$sql3 = "SELECT * FROM customer_behavior_cas";
$result = mysql_query($sql3);
$is_first_occur = array();
while ($array = mysql_fetch_array($result)) {
	$email = trim($array['EmailAddress']);
	

	if ($is_first_occur[$email] == 123) {
		//echo $email . " is the 2nd occur.<br>";
	}
	else {
		$is_first_occur[$email] = 123;
		//if ( $array_email2[$email] ) {
		if ( $is_first_occur2[$email] == 123) {
			//$count++;
		}
		else {
			$count++;
			echo $email ."<br>";
		}
	}
}
echo $count . "<br>";
*/







mysql_close($conn);
?>