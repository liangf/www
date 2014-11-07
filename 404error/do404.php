<?php
$file = fopen("crawldetails_5_14_2014.csv","r") or die('Cannot open file');

$xml_file = 'file.txt';
$handle = fopen($xml_file, 'w') or die('Cannot open file:  '.$xml_file);
$xml_data = '<?xml version="1.0" encoding="windows-1252"?>' . PHP_EOL;
fwrite($handle, $xml_data);
$xml_data = '<redirects>' . PHP_EOL;
fwrite($handle, $xml_data);
//echo $xml_data;
$count = 0;
while(! feof($file)) {
	$data = fgetcsv($file);
	if (trim($data[1])=="404" || trim($data[1])=="403") {
		echo $data[0] . " " . $data[1] . " " .$data[2] . "<br>";
		$count = $count + 1;
		$xml_data = '<r><s>';
		$xml_data .= trim($data[0]);
		$xml_data .= '</s><t>';
		$xml_data .= 'compandsave.com';
		$xml_data .= '</t></r>';
		$xml_data .= PHP_EOL;
		fwrite($handle, $xml_data);
	}
}
$xml_data = '</redirects>';
fwrite($handle, $xml_data);

echo "Done." . "<br>";
echo $count;


fclose($handle);

fclose($file);

?>