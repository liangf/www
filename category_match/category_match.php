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


	$brand_arr = array("hp","epson","brother","canon","lexmark","samsung","dell","kodak","okidata","xerox","kyocera","pitney bowes","sharp","ibm","ricoh","apple",
						"compaq","apollo");
	$form_arr = array("", "cas", "ci", "ti");
	
//$ib=0;
for ($ib=0; $ib<count($brand_arr); $ib++) {	

	for ($i=1; $i<=3; $i++) {
		
		$query = "SELECT Q2, ID FROM july_survey2 WHERE FormID = '" . $i . "' AND PrinterModID = 0";

		$result = mysql_query($query);
		$count = 0;
		$total_count = 0;
		while ($row = mysql_fetch_array($result))
		{	
			$id = 0;
			$value = $row[0];
			$row_id = $row[1];
			$value = trim($value);
			$brand = $brand_arr[$ib];
			if (preg_match("/$brand/i", $value, $matches)) {
				$total_count++;
				$value = str_ireplace($brand,"",$value);	
				$value = trim($value);
				$value = str_ireplace("  "," ",$value);
				//echo $row_id . " " . $value . "<br>";
				$value2 = str_ireplace(" ","",$value);

				$query_match = "SELECT ID, Value FROM category_" . $form_arr[$i] . " WHERE Value LIKE '%$brand%' AND Value LIKE '%$value%'";
				$query_match2 = "SELECT ID, Value FROM category_" . $form_arr[$i] . " WHERE Value LIKE '%$brand%' AND Value LIKE '%$value2%'";
				//echo $query_match . "<br>";
				
				preg_match_all('!\d+!', $value, $matches);	
				$value3 = $matches[0][0];
				$query_match3 = "SELECT ID, Value FROM category_" . $form_arr[$i] . " WHERE Value LIKE '%$brand%' AND Value LIKE '%$value3%'";
				//echo $row[0] . "==>" . $value3 . "<br>";
				
				if ($value != "" && $value3 !="") {
					$checkresult = mysql_query($query_match);
					$num_r = mysql_num_rows($checkresult);
					if ($num_r > 1) {
						while ($answer = mysql_fetch_array($checkresult)) {
							if ($answer['ID'] != "") {
								//echo "find " . $row_id . " : " . $row[0] . " => " . $answer['Value'] . "<br>";								
							}
						}						
					} 
					else if ($num_r == 1) {
							//$count++;
							$checkresult = mysql_query($query_match);
							$answer = mysql_fetch_array($checkresult);
							$id = $answer['ID'];
							//echo $row_id . " : " . $row[0] . " =========================== MATCH." . "<br>";
					}
					else {
						$checkresult2 = mysql_query($query_match2);
						$num_r2 = mysql_num_rows($checkresult2);
						
						$checkresult3 = mysql_query($query_match3);
						$num_r3 = mysql_num_rows($checkresult3);
										
						if ($num_r2 > 1) {
							while ($answer = mysql_fetch_array($checkresult2)) {
								if ($answer['ID'] != "") {
									//echo "find " . $row_id . " : " . $row[0] . " => " . $answer['Value'] . "<br>";								
								}
							}						
						} 
						else if ($num_r2 == 1) {
								//$count++;
								$checkresult2 = mysql_query($query_match2);
								$answer = mysql_fetch_array($checkresult2);
								$id = $answer['ID'];
								//echo $row_id . " : " . $row[0] . " =========================== MATCH." . "<br>";
						}						
						else {	
							if ($num_r3 > 1) {
								while ($answer = mysql_fetch_array($checkresult3)) {
									if ($answer['ID'] != "") {
										//echo "find " . $row_id . " : " . $row[0] . " => " . $answer['Value'] . "<br>";								
									}
								}						
							} 
							else if ($num_r3 == 1) {
								//$count++;
								$checkresult3 = mysql_query($query_match3);
								$answer = mysql_fetch_array($checkresult3);
								$id = $answer['ID'];
								//echo $row_id . " : " . $row[0] . " =========================== MATCH." . "<br>";
							}
							else { 
								//echo $row_id . " : " . $row[0] . " --------------------------NO MATCH." . "<br>";
							}
						}						
					}
				}
				else { 
					//echo $row_id . " : " . $row[0] . " --------------------------NO MATCH." . "<br>";
				}
			}
			if ($id > 0) {
				$query_update = "UPDATE july_survey2 SET PrinterModID = '" . $id . "' WHERE ID = '" . $row_id . "' AND FormID = $i";
				$updateresult = mysql_query($query_update);
				$count++;
			}			
			
		}
		echo "<br>" . $form_arr[$i] . " --------------key: '" .$brand_arr[$ib]."'". " -------------- " . $count ."/".$total_count . "<br>";
	}
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