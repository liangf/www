<?php
header('Access-Control-Allow-Origin: http://www.tomatoink.com');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');


		
$username = "DBCOMPANDSAVE";
$password = "CAS123cas!";
$hostname = "DBCOMPANDSAVE.db.11475010.hostedresource.com"; 
$databasename = "DBCOMPANDSAVE";
	
$conn = mysql_connect($hostname, $username, $password) or die("DB Connnection Error !".mysql_error());
mysql_select_db($databasename, $conn);


	
if( $_POST["initial"] ) {
//echo "hahah, this is test.";

	$sql = "SELECT * FROM easter_rabchicken WHERE id=0";
	$result = mysql_query($sql);
	$array = mysql_fetch_array($result);

    // get the rabbit counts
	echo $array['rab_count'];
	echo ",";	
	// get the chicken counts
	echo $array['chi_count'];

}

/*
	if( $_POST["rabbit"] ) {
	    // get the rabbit counts
	    $sql = "SELECT rab_count FROM easter_rabchicken WHERE id=0";
		$result = $db->query($sql);
		$array = $db->myArray($result);
		echo $array[0];
		
		// seaperate by ","
		echo ",";
		
		// get the chicken counts
		$sql = "SELECT chi_count FROM easter_rabchicken WHERE id=0";
		$result = $db->query($sql);
		$array = $db->myArray($result);
		echo $array[0];
		
		//$name = $_POST["rabbit"];
		//echo $name;
   
		$sql2 = "UPDATE easter_rabchicken SET rab_count=rab_count+1 WHERE id=0";
		$db->query($sql2);   
	}

	if( $_POST["chicken"] ) {
	    // get the rabbit counts
	    $sql = "SELECT rab_count FROM easter_rabchicken WHERE id=0";
		$result = $db->query($sql);
		$array = $db->myArray($result);
		echo $array[0];
		
		// seaperate by ","
		echo ",";
		
		// get the chicken counts
		$sql = "SELECT chi_count FROM easter_rabchicken WHERE id=0";
		$result = $db->query($sql);
		$array = $db->myArray($result);
		echo $array[0];
		
		//$name = $_POST["chicken"];
		//echo $name;
		
		$sql = "UPDATE easter_rabchicken SET chi_count=chi_count+1 WHERE id=0";
		$db->query($sql);   
	}
*/

mysql_close($conn);

?>