<?php 
/*  © 2008-2013 eBay Inc., All Rights Reserved */
/* Licensed under CDDL 1.0 -  http://opensource.org/licenses/cddl1.php */
set_time_limit(1500) //increase time-out to 25 mins as downloading and parsing the tree may take a while ?>

<?php require_once('./get-common/keys.php') ?>
<?php require_once('./get-common/eBaySession.php') ?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<HTML>
<HEAD>
<META http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<TITLE>GetCategories</TITLE>
</HEAD>
<BODY>
<?php
$username = "DBCOMPANDSAVE";
$password = "CAS123cas!";
$hostname = "DBCOMPANDSAVE.db.11475010.hostedresource.com"; 
$databasename = "DBCOMPANDSAVE";	
$conn = mysql_connect($hostname, $username, $password) or die("DB Connnection Error !".mysql_error());
mysql_select_db($databasename, $conn);
?>

<?php

// Empty the db
$sql = "delete FROM ebay_trading";
mysql_query($sql);

//SiteID must also be set in the Request's XML
//SiteID = 0  (US) - UK = 3, Canada = 2, Australia = 15, ....
//SiteID Indicates the eBay site to associate the call with
$siteID = 0;	
$actListXml = NULL;  //declared here for wider variable scope (avoid having to parse more than once)
	

	
$pageNums = getTotalNumberOfPages($devID, $appID, $certID, $compatabilityLevel, $siteID, $userToken, $serverUrl);
#$pageNums = 1;
$entryNums = getTotalNumberOfEntries($devID, $appID, $certID, $compatabilityLevel, $siteID, $userToken, $serverUrl);
echo "TotalNumberOfPages: " .$pageNums . "<br>";
echo "TotalNumberOfEntries: " .$entryNums . "<br>";
		
//$data = array("Title", "Custom label", "BuyItNowPrice", "ShippingServiceCost", "StartTime");
for ($i=1; $i<=$pageNums; $i++) {
	$actListXml = getPageByID($devID, $appID, $certID, $compatabilityLevel, $siteID, $userToken, $serverUrl, $i);
	$items = $actListXml->getElementsByTagName('Item');
	foreach ($items as $it) {			
		$customlab = $it->getElementsByTagName('SKU')->item(0)->nodeValue;
		$price = (float)$it->getElementsByTagName('BuyItNowPrice')->item(0)->nodeValue;
		//$shipprice = (float)$it->getElementsByTagName('ShippingServiceCost')->item(0)->nodeValue;
		$shipprice = 0.00;
		$sql = "insert into ebay_trading (id, customlabel, price, shippingcost, time) values(0, '$customlab', $price, $shipprice, now())";
		if( !mysql_query($sql) ) echo "'" .$customlab ."'" ." added no success. <br>";
	}
}
echo '<P><B>Ebay Active List updated.</B>';




function getPageByID($devID, $appID, $certID, $compatabilityLevel, $siteID, $userToken, $serverUrl, $pageID)
{
	//Build the request Xml string
	$requestXmlBody = '<?xml version="1.0" encoding="utf-8" ?>';
	$requestXmlBody .= '<GetMyeBaySellingRequest xmlns="urn:ebay:apis:eBLBaseComponents">';
	$requestXmlBody .= "<RequesterCredentials><eBayAuthToken>$userToken</eBayAuthToken></RequesterCredentials>";
	$requestXmlBody .= "<ActiveList><Pagination><EntriesPerPage>200</EntriesPerPage><PageNumber>$pageID</PageNumber></Pagination></ActiveList>";
	$requestXmlBody .= '</GetMyeBaySellingRequest>';
	
	//Create a new eBay session with all details pulled in from included keys.php
	$session = new eBaySession($userToken, $devID, $appID, $certID, $serverUrl, $compatabilityLevel, $siteID, 'GetMyeBaySelling');
	$responseXml = $session->sendHttpRequest($requestXmlBody);
	if(stristr($responseXml, 'HTTP 404') || $responseXml == '')
		die('<P>Error sending request');
		
	//Xml string is parsed and creates a DOM Document object
	$responseDoc = new DomDocument();
	$responseDoc->loadXML($responseXml);	

	return $responseDoc;
}


function getTotalNumberOfPages($devID, $appID, $certID, $compatabilityLevel, $siteID, $userToken, $serverUrl)
{
	//Build the request Xml string
	$requestXmlBody = '<?xml version="1.0" encoding="utf-8" ?>';
	$requestXmlBody .= '<GetMyeBaySellingRequest xmlns="urn:ebay:apis:eBLBaseComponents">';
	$requestXmlBody .= "<RequesterCredentials><eBayAuthToken>$userToken</eBayAuthToken></RequesterCredentials>";
	$requestXmlBody .= "<ActiveList><Pagination><EntriesPerPage>200</EntriesPerPage><PageNumber>1</PageNumber></Pagination></ActiveList>";
	$requestXmlBody .= '</GetMyeBaySellingRequest>';
	
	//Create a new eBay session with all details pulled in from included keys.php
	$session = new eBaySession($userToken, $devID, $appID, $certID, $serverUrl, $compatabilityLevel, $siteID, 'GetMyeBaySelling');
	$responseXml = $session->sendHttpRequest($requestXmlBody);
	if(stristr($responseXml, 'HTTP 404') || $responseXml == '')
		die('<P>Error sending request');
		
	//Xml string is parsed and creates a DOM Document object
	$responseDoc = new DomDocument();
	$responseDoc->loadXML($responseXml);	

	return $responseDoc->getElementsByTagName('TotalNumberOfPages')->item(0)->nodeValue;
}

function getTotalNumberOfEntries($devID, $appID, $certID, $compatabilityLevel, $siteID, $userToken, $serverUrl)
{
	//Build the request Xml string
	$requestXmlBody = '<?xml version="1.0" encoding="utf-8" ?>';
	$requestXmlBody .= '<GetMyeBaySellingRequest xmlns="urn:ebay:apis:eBLBaseComponents">';
	$requestXmlBody .= "<RequesterCredentials><eBayAuthToken>$userToken</eBayAuthToken></RequesterCredentials>";
	$requestXmlBody .= "<ActiveList><Pagination><EntriesPerPage>200</EntriesPerPage><PageNumber>1</PageNumber></Pagination></ActiveList>";
	$requestXmlBody .= '</GetMyeBaySellingRequest>';
	
	//Create a new eBay session with all details pulled in from included keys.php
	$session = new eBaySession($userToken, $devID, $appID, $certID, $serverUrl, $compatabilityLevel, $siteID, 'GetMyeBaySelling');
	$responseXml = $session->sendHttpRequest($requestXmlBody);
	if(stristr($responseXml, 'HTTP 404') || $responseXml == '')
		die('<P>Error sending request');
		
	//Xml string is parsed and creates a DOM Document object
	$responseDoc = new DomDocument();
	$responseDoc->loadXML($responseXml);	

	return $responseDoc->getElementsByTagName('TotalNumberOfEntries')->item(0)->nodeValue;
}

?>

</BODY>
</HTML>
