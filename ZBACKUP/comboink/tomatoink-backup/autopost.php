<?php
header('Access-Control-Allow-Origin: http://www.compandsave.com');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');

//print_r($_SERVER);
//echo $_SERVER["PHP_AUTH_USER"];
//echo $_SERVER['HTTP_AUTHORIZATION'];


if($_SERVER['HTTP_USER_AGENT']=='compandsave') 
{
require_once("easypost-php-master/lib/easypost.php");

$mode = $_POST["mode"];


if ($mode == "test")
\EasyPost\EasyPost::setApiKey('ThiApS0dVpUZBCLg7lD0aw'); //test site key
else if ($mode == "live")
\EasyPost\EasyPost::setApiKey('cXB0P702cwDAgOdP00Se0Q'); //live site key

//extract the orders information
$order_text = $_POST["ship"];

//$order_array = explode("@@@", $order_text);

if (isset($order_text)&&$order_text!="")
{
 // $count = sizeof($order_array);
 // $count--;
 // $shipment = array($count);
 // $i=0;
//$date = date_create();
//$timestamp = date_timestamp_get($date);
 // $date = new DateTime();
 // $timestamp->getTimestamp();
//  foreach ($order_array as $order)
//  { 



        $order_detail = explode("*", $order_text);
        $shipment = new buyshiplabel(); 
        $product_weight = ceil($order_detail[10]*16+0.7);
        //$product_code_array = $order_detail[11]
        
        preg_match("/(?<=\-).*/", $order_detail[11], $matches);
        $product_code = $matches[0]; 
        //$shipment[$i]->say();

        //ExtractOrder = ExtractOrder + OrderID_array(smallorder) + "*" + CustomerID_array(smallorder) + "*" + OrderDate_array(smallorder) + "*" + shipfirstname_array(smallorder) + " " + shiplastname_array(smallorder) + "*" + shipaddress1_array(smallorder) + "*" + shipaddress2_array(smallorder) + "*" + shipcity_array(smallorder) + "*" + shipstate_array(smallorder) + "*" + shippostalcode_array(smallorder) + "*" + shipphone_array(smallorder) + "*" + productweight_array(smallorder) + "*" + ProductCode_array(smallorder) + "@@@"

          $shipment->buyshipment($order_detail[0], $order_detail[3], $order_detail[4], $order_detail[5], $order_detail[6], $order_detail[7], $order_detail[8], $order_detail[9], $product_weight, $order_detail[1], $order_detail[2], $product_code, $order_detail[12]);
          
        
        //$orderid, $customername, $customerstreet1, $customerstreet2, $customercity, $customerstate, $customerzip, $customerphone, $weight, $customerid, $orderdate, $productcode)
        //$i++;

    //echo $order . "Hello@@@";
 // }
} //end of isset



}

else 
    echo "N&wrong domain&&&&";

?>

<?php
class buyshiplabel {


//private $address;
//private $verified_address;
//private $from_address;
//private $parcel;
//private $shipment;
//private $trackingcode;
//private $shipid;
//private $label_url;
//private $orderrate;


public function buyshipment($orderid, $customername, $customerstreet1, $customerstreet2, $customercity, $customerstate, $customerzip, $customerphone, $weight, $customerid, $orderdate, $productcode, $timestamp) {
  $errorflag = false;

  $address = \EasyPost\Address::create(array(
  'name' => $customername,
  'street1' => $customerstreet1,
  'street2' => $customerstreet2,
  'city' => $customercity,
  'state' => $customerstate,
  'zip' => $customerzip,
  'phone' => $customerphone, 
  'country' => 'US'
));

try 
    {

    $verified_address = $address->verify();
    
    $from_address = \EasyPost\Address::create(
    array(
        "name"    => "Shipping Receiving",
        "company" => "CompAndSave",
        "street1" => "38929 Cherry ST",
        "street2" => " ",
        "city"    => "Newark",
        "state"   => "CA",
        "zip"     => "94560",
        "phone"   => "415-379-7678"
    )
);
$parcel = \EasyPost\Parcel::create(
    array(
        "predefined_package" => "Parcel",
        "weight" => $weight 
    )
);
$shipment = \EasyPost\Shipment::create(
    array(
        "to_address"   => $verified_address,
        "from_address" => $from_address,
        "parcel"       => $parcel,
        "carrier" => 'USPS', 
        "service" => 'First' 
    )
);




     }
    catch(Exception $e) {echo "N&" . $orderid . "&error with address&&" . $e; $errorflag=true;}

//echo $verified_address;
    echo $errorflag;

if ($errorflag!=true)
{

    try 
       {
        //echo ($shipment->rates[0]->_values["service"]);
        //$shipment->buy($shipment->rates[0]);
        $shipment->buy($shipment->lowest_rate(array('USPS'), array('First')));


//$shipment->label(array("file_format" => "zpl"));

$trackingcode = $shipment->tracking_code;
$shipid = $shipment->id;
$label_url = $shipment->postage_label->label_url;
//$label_zpl_url = $shipment->postage_label->label_zpl_url;
//$orderrate = $shipment->rates[0]->rate;
$orderrate = $shipment->selected_rate->rate; 
        //print_r($shipment);
        //echo $shipment;


        //echo "normallabel: " . $shipment->postage_label->label_url;
        //echo "<br>";
        //echo $shipment->postage_label->label_zpl_url;
    }
    catch(Exception $e) {echo "N&" . $orderid . "&error with shipment&&" . $e; $errorflag=true;}
}


//save in DB

if($errorflag!=true)
{
$username = "DBCOMPANDSAVE";
$password = "CAS123cas!";
$hostname = "DBCOMPANDSAVE.db.11475010.hostedresource.com"; 
$databasename = "DBCOMPANDSAVE";

$dbhandle = mysql_connect($hostname, $username, $password);
  if($dbname) die("Unable to connect to MySQL");

mysql_select_db($databasename) or die("can't find dbname");


date_default_timezone_set('America/Los_Angeles');
//$shipdate = date('m/d/Y h:i:s a', time());
$ship_date = date('Y/m/d h:i:s a', time());

//insert info in database
$query = "INSERT INTO Orders_Tracking (OrderID, Tracking_Code, Label_Url, ZPL_Url, weight, Street1, Street2, City, State, Zip, Phone, CustomerID, CustomerName, ShipID, OrderDate, ShipRate, Ship_Date, ProductCode, Flag_2) VALUES('$orderid', '$trackingcode', '$label_url', '$label_zpl_url', '$weight', '$customerstreet1', '$customerstreet2', '$customercity', '$customerstate', '$customerzip', '$customerphone', '$customerid', '$customername', '$shipid', '$orderdate', '$orderrate', '$ship_date', '$productcode', '$timestamp')";
$result = mysql_query($query);
mysql_close($dbhandle);
echo "Y&" . $orderid . "&" . $trackingcode . "&" . $label_url . "&" . $orderrate;
}






}

}


?>
