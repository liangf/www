<?php

	//header('Access-Control-Allow-Origin: http://www.tomatoink.com/');
	//header('Access-Control-Allow-Origin: http://www.casinkadmin.com');
	//header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
	require_once 'database.php';


		
	$username = "DBCOMPANDSAVE";
	$password = "CAS123cas!";
	$hostname = "DBCOMPANDSAVE.db.11475010.hostedresource.com"; 
	$databasename = "DBCOMPANDSAVE";
	
	$db = new Mysql($hostname, $username, $password, $databasename);
	$db->connect();

	if( $_POST["rabbit"] ) {
	    $sql = "SELECT rab_count FROM easter_rabchicken WHERE id=0";
		$result = $db->query($sql);
		$array = $db->myArray($result);
		echo $array[0];
		
		//$name = $_POST["rabbit"];
		//echo $name;
   
		$sql2 = "UPDATE easter_rabchicken SET rab_count=rab_count+1 WHERE id=0";
		$db->query($sql2);   
	}

	if( $_POST["chicken"] ) {
	    $sql = "SELECT chi_count FROM easter_rabchicken WHERE id=0";
		$result = $db->query($sql);
		$array = $db->myArray($result);
		echo $array[0];
		
		//$name = $_POST["chicken"];
		//echo $name;
		
		$sql = "UPDATE easter_rabchicken SET chi_count=chi_count+1 WHERE id=0";
		$db->query($sql);   
	}

	$db->dbClose();

	
	//echo "hello, this is test!";

?>