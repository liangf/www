<?php

$username = "DBCOMPANDSAVE";
$password = "CAS123cas!";
$hostname = "DBCOMPANDSAVE.db.11475010.hostedresource.com"; 
$databasename = "DBCOMPANDSAVE";	
$conn = mysql_connect($hostname, $username, $password) or die("DB Connnection Error !".mysql_error());
mysql_select_db($databasename, $conn);


$filename = array("", "Survey_Response_CAS.csv", "Survey_Response_CI.csv", "Survey_Response_TI.csv");
$table_arr = array("", "cas", "ci", "ti");




for ($i=1; $i<=3; $i++) {
$file = fopen($filename[$i], "w");



$sql = "SELECT Q1, Product, PrinterName, PrinterModID,  Email FROM july_survey2 Where FormID=$i";
$result = mysql_query($sql);
$data = array("ProductCode", "PrinterName", "PrinterID", "Email");
fputcsv($file, $data);
$count = 0;
while ($array = mysql_fetch_array($result)) {
	
		$data[0] = trim($array["Product"]);
		$data[1] = trim($array["PrinterName"]);
		$data[2] = trim($array["PrinterModID"]);
		$data[3] = trim($array["Email"]);
		
		$q1 = $array["Q1"];
		if ( $q1 !="yes" ) $data[0] = "";

		if ( $data[0] == "" && $data[1] == "") continue;
		
		if ( $data[2] == 0 ) $data[2] = 9999;
		
		fputcsv($file, $data);
		$count++;
}
echo "$table_arr[$i] write: " .$count  ."<br>";
}

mysql_close($conn);



?>