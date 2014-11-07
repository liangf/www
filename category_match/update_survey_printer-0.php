<?php 
$username = "DBCOMPANDSAVE";
$password = "CAS123cas!";
$hostname = "DBCOMPANDSAVE.db.11475010.hostedresource.com"; 
$databasename = "DBCOMPANDSAVE";

$dbhandle = mysql_connect($hostname, $username, $password);
  if($dbname) die("Unable to connect to MySQL");

mysql_select_db($databasename) or die("can't find dbname");







	$form_arr = array("", "cas", "ci", "ti");
	
	
	for ($i=1; $i<=3; $i++) {
		$count = 0;
		$query = "SELECT PrinterModID, ID from july_survey2 where FormID=$i and PrinterName=''";
		$result = mysql_query($query);
		while ($row = mysql_fetch_array($result)) {	
			$printermodid = $row['PrinterModID'];
			$row_id = $row['ID'];
			
			$query_match = "SELECT Name FROM category_" . $form_arr[$i] . " WHERE ID='$printermodid'";
			$result_match = mysql_query($query_match);
			
			$num_r = mysql_num_rows($result_match);
			
			
			if ($num_r > 0) {
				
				$answer = mysql_fetch_array($result_match);
				$printername = $answer['Name'];
				$query_update = "UPDATE july_survey2 SET PrinterName = '$printername' WHERE ID = $row_id AND FormID = $i";
				if( !mysql_query($query_update) ) 
					echo $form_arr[$i] . ": " . $row_id . "=>" . $printermodid . "=>" . $printername . ", UPDATE NO SUCCESS.<br>";
				$count++;
			}			
			
		}
		echo "<br>" .$form_arr[$i] . "==============UPDATE===============" .$count . "<br>";
	}




mysql_close($dbhandle);



?>