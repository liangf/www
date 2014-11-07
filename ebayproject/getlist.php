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
	
	
	echo '<P><B>Downloading new active list...</B>' . "<br>";
	$file = fopen("./activeList.csv","w");
	$data = array("Title", "Custom label", "BuyItNowPrice", "ShippingServiceCost", "StartTime");
	fputcsv($file, $data);
	for ($i=1; $i<=$pageNums; $i++) {
		$actListXml = getPageByID($devID, $appID, $certID, $compatabilityLevel, $siteID, $userToken, $serverUrl, $i);
		$items = $actListXml->getElementsByTagName('Item');
		foreach ($items as $it) {			
			$data[0] = $it->getElementsByTagName('Title')->item(0)->nodeValue;
			$data[1] = $it->getElementsByTagName('SKU')->item(0)->nodeValue;
			$data[2] = $it->getElementsByTagName('BuyItNowPrice')->item(0)->nodeValue;
			$data[3] = $it->getElementsByTagName('ShippingServiceCost')->item(0)->nodeValue;
			$data[4] = $it->getElementsByTagName('StartTime')->item(0)->nodeValue;
			fputcsv($file, $data);
		}
	}
	echo '<P><B>Latest Active List Tree Downloaded.</B>';
	
	
	

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
