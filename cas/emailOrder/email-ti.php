<?php
$file = fopen("TI-email.csv","r");
//$file = fopen("test.csv","r");
$file2 = fopen("email-ti.csv","w");

$old_email = null;
$new_email = null;
$brand = null;
while(! feof($file)) {
	$old_email = $new_email;
	//print_r(fgetcsv($file));
	$data = fgetcsv($file);
	$new_email = $data[0];

	if ($new_email!=$old_email && substr($data[4], 0, 3)!="DSC") {
		//echo $new_email . ", " . $old_email . "<br>";
		$brand = explode("-", $data[4]);
		$data[4] = $brand[1];
		fputcsv($file2, $data);
	}

}

echo "Done." . "<br>";

fclose($file);

?>