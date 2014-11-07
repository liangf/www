<?php 
$username = "DBCOMPANDSAVE";
$password = "CAS123cas!";
$hostname = "DBCOMPANDSAVE.db.11475010.hostedresource.com"; 
$databasename = "DBCOMPANDSAVE";

$dbhandle = mysql_connect($hostname, $username, $password);
  if($dbname) die("Unable to connect to MySQL");

mysql_select_db($databasename) or die("can't find dbname");

$check = 2;
if ($check == "1") {


$query = "SELECT Q2, ID FROM july_survey2 WHERE FormID = 1 AND PrinterModID = 0";

$result = mysql_query($query);
$count = 0;
while ($row = mysql_fetch_array($result))
{	
	$id = 0;
	$value = $row[0];
	$row_id = $row[1];
	if ($value != "") {
		$query_match = "SELECT ID FROM category_cas WHERE Value = '" . $value . "'";
		$checkresult = mysql_query($query_match);
		while ($answer = mysql_fetch_array($checkresult)) {
			if ($answer['ID'] != "") {
				$id = $answer['ID'];
				//echo "find " . $id . "<br>";
				
			}

		}
		//echo "search: " . $row_id . "<br>";
	}

	if ($id > 0) {
		$query_update = "UPDATE july_survey2 SET PrinterModID = '" . $id . "' WHERE ID = '" . $row_id . "' AND FormID = '1'";
		$updateresult = mysql_query($query_update);
		$count++;
	}


}
echo "total CAS: " . $count . "<br>";


//CI 

$query = "SELECT Q2, ID FROM july_survey2 WHERE FormID = 2 AND PrinterModID = 0";

$result = mysql_query($query);
$count = 0;
while ($row = mysql_fetch_array($result))
{	
	$id = 0;
	$value = $row[0];
	$row_id = $row[1];
	if ($value != "") {
		$query_match = "SELECT ID FROM category_ci WHERE Value = '" . $value . "'";
		$checkresult = mysql_query($query_match);
		while ($answer = mysql_fetch_array($checkresult)) {
			if ($answer['ID'] != "") {
				$id = $answer['ID'];
				//echo "find " . $id . "<br>";
				
			}

		}
		//echo "search: " . $row_id . "<br>";
	}

	if ($id > 0) {
		$query_update = "UPDATE july_survey2 SET PrinterModID = '" . $id . "' WHERE ID = '" . $row_id . "' AND FormID = '2'";
		$updateresult = mysql_query($query_update);
		$count++;
	}


}
echo "total CI: " . $count . "<br>";





//TI 

$query = "SELECT Q2, ID FROM july_survey2 WHERE FormID = 3 AND PrinterModID = 0";

$result = mysql_query($query);
$count = 0;
while ($row = mysql_fetch_array($result))
{	
	$id = 0;
	$value = $row[0];
	$row_id = $row[1];
	if ($value != "") {
		$query_match = "SELECT ID FROM category_ti WHERE Value = '" . $value . "'";
		$checkresult = mysql_query($query_match);
		while ($answer = mysql_fetch_array($checkresult)) {
			if ($answer['ID'] != "") {
				$id = $answer['ID'];
				//echo "find " . $id . "<br>";
				
			}

		}
		//echo "search: " . $row_id . "<br>";
	}

	if ($id > 0) {
		$query_update = "UPDATE july_survey2 SET PrinterModID = '" . $id . "' WHERE ID = '" . $row_id . "' AND FormID = '3'";
		$updateresult = mysql_query($query_update);
		$count++;
	}


}
echo "total TI: " . $count . "<br>";
}


else if ($check == 2) {

	$form_arr = array("", "cas", "ci", "ti");
	for ($i=1; $i<4; $i++) {
		$query = "SELECT Q2, ID FROM july_survey2 WHERE FormID = '" . $i . "' AND PrinterModID = 0";

		$result = mysql_query($query);
		$count = 0;
		while ($row = mysql_fetch_array($result))
		{	
			$id = 0;
			$value = $row[0];
			$row_id = $row[1];
			if (preg_match("/HP/i", $value, $matches)) {
		

				$value = str_ireplace("  "," ",$value);
		        $value = str_ireplace("-","",$value);
				$value = str_ireplace("HP","",$value);
		//echo "_" . $value . "_<br>";

				$query_match = "SELECT ID, Value FROM category_" . $form_arr[$i] . " WHERE Value LIKE '%HP%' AND Value LIKE '% " . $value . " %'";
		//echo $query_match . "<br>";
				//echo $query_match;
				if ($value != "") {
					$checkresult = mysql_query($query_match);
					while ($answer = mysql_fetch_array($checkresult)) {
						if ($answer['ID'] != "") {
				
							echo "find " . $row_id . " : " . $row[0] . " => " . $answer['Value'] . "<br>";
							$count++;
							
				
						}

					}
				}
		//echo "search: " . $row_id . "<br>";
			}
    
	//if ($id > 0) {
	//	$query_update = "UPDATE july_survey2 SET PrinterModID = '" . $id . "' WHERE ID = '" . $row_id . "' AND FormID = '1'";
	//	$updateresult = mysql_query($query_update);
	//	$count++;
	//}
	


		}
		echo "<br>total " . $form_arr[$i] . ": " . $count . "<br>";
	}
}


mysql_close($dbhandle);


/*

$shipment = \EasyPost\Shipment::retrieve(array('id' =>$shipid));


$refundinfo = $shipment->refund();

//$shipment = \EasyPost\Shipment::retrieve(array('id' =>$shipid));

//print_r($refundinfo->refund_status . "<br>");


if ($refundinfo->refund_status!="submitted") echo "N&" . $refundinfo->status . "&" . $orderid;
else {
  //search in DB
$dbhandle = mysql_connect($hostname, $username, $password);
  if($dbname) die("Unable to connect to MySQL");
$query = "UPDATE Orders_Tracking SET Flag_1 = '" . $refundinfo->updated_at . " id: " . $refundinfo->id . "' WHERE ShipID = '" . $shipid . "';";
mysql_select_db($databasename) or die("can't find dbname");
$result = mysql_query($query);
mysql_close($dbhandle);

echo "Y&" . $refundinfo->refund_status . "&" . $orderid;

} */

?>