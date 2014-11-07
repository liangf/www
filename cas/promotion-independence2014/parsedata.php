<?php

$username = "DBCOMPANDSAVE";
$password = "CAS123cas!";
$hostname = "DBCOMPANDSAVE.db.11475010.hostedresource.com"; 
$databasename = "DBCOMPANDSAVE";	
$conn = mysql_connect($hostname, $username, $password) or die("DB Connnection Error !".mysql_error());
mysql_select_db($databasename, $conn);

$STATES = '
[
    {
        "name": "Alabama",
        "abbreviation": "AL"
    },
    {
        "name": "Alaska",
        "abbreviation": "AK"
    },
    {
        "name": "American Samoa",
        "abbreviation": "AS"
    },
    {
        "name": "Arizona",
        "abbreviation": "AZ"
    },
    {
        "name": "Arkansas",
        "abbreviation": "AR"
    },
    {
        "name": "California",
        "abbreviation": "CA"
    },
    {
        "name": "Colorado",
        "abbreviation": "CO"
    },
    {
        "name": "Connecticut",
        "abbreviation": "CT"
    },
    {
        "name": "Delaware",
        "abbreviation": "DE"
    },
    {
        "name": "District Of Columbia",
        "abbreviation": "DC"
    },
    {
        "name": "Federated States Of Micronesia",
        "abbreviation": "FM"
    },
    {
        "name": "Florida",
        "abbreviation": "FL"
    },
    {
        "name": "Georgia",
        "abbreviation": "GA"
    },
    {
        "name": "Guam",
        "abbreviation": "GU"
    },
    {
        "name": "Hawaii",
        "abbreviation": "HI"
    },
    {
        "name": "Idaho",
        "abbreviation": "ID"
    },
    {
        "name": "Illinois",
        "abbreviation": "IL"
    },
    {
        "name": "Indiana",
        "abbreviation": "IN"
    },
    {
        "name": "Iowa",
        "abbreviation": "IA"
    },
    {
        "name": "Kansas",
        "abbreviation": "KS"
    },
    {
        "name": "Kentucky",
        "abbreviation": "KY"
    },
    {
        "name": "Louisiana",
        "abbreviation": "LA"
    },
    {
        "name": "Maine",
        "abbreviation": "ME"
    },
    {
        "name": "Marshall Islands",
        "abbreviation": "MH"
    },
    {
        "name": "Maryland",
        "abbreviation": "MD"
    },
    {
        "name": "Massachusetts",
        "abbreviation": "MA"
    },
    {
        "name": "Michigan",
        "abbreviation": "MI"
    },
    {
        "name": "Minnesota",
        "abbreviation": "MN"
    },
    {
        "name": "Mississippi",
        "abbreviation": "MS"
    },
    {
        "name": "Missouri",
        "abbreviation": "MO"
    },
    {
        "name": "Montana",
        "abbreviation": "MT"
    },
    {
        "name": "Nebraska",
        "abbreviation": "NE"
    },
    {
        "name": "Nevada",
        "abbreviation": "NV"
    },
    {
        "name": "New Hampshire",
        "abbreviation": "NH"
    },
    {
        "name": "New Jersey",
        "abbreviation": "NJ"
    },
    {
        "name": "New Mexico",
        "abbreviation": "NM"
    },
    {
        "name": "New York",
        "abbreviation": "NY"
    },
    {
        "name": "North Carolina",
        "abbreviation": "NC"
    },
    {
        "name": "North Dakota",
        "abbreviation": "ND"
    },
    {
        "name": "Northern Mariana Islands",
        "abbreviation": "MP"
    },
    {
        "name": "Ohio",
        "abbreviation": "OH"
    },
    {
        "name": "Oklahoma",
        "abbreviation": "OK"
    },
    {
        "name": "Oregon",
        "abbreviation": "OR"
    },
    {
        "name": "Palau",
        "abbreviation": "PW"
    },
    {
        "name": "Pennsylvania",
        "abbreviation": "PA"
    },
    {
        "name": "Puerto Rico",
        "abbreviation": "PR"
    },
    {
        "name": "Rhode Island",
        "abbreviation": "RI"
    },
    {
        "name": "South Carolina",
        "abbreviation": "SC"
    },
    {
        "name": "South Dakota",
        "abbreviation": "SD"
    },
    {
        "name": "Tennessee",
        "abbreviation": "TN"
    },
    {
        "name": "Texas",
        "abbreviation": "TX"
    },
    {
        "name": "Utah",
        "abbreviation": "UT"
    },
    {
        "name": "Vermont",
        "abbreviation": "VT"
    },
    {
        "name": "Virgin Islands",
        "abbreviation": "VI"
    },
    {
        "name": "Virginia",
        "abbreviation": "VA"
    },
    {
        "name": "Washington",
        "abbreviation": "WA"
    },
    {
        "name": "West Virginia",
        "abbreviation": "WV"
    },
    {
        "name": "Wisconsin",
        "abbreviation": "WI"
    },
    {
        "name": "Wyoming",
        "abbreviation": "WY"
    }
]';



// show erro of the data
//$file = fopen("../data/abc-msm-clean2.csv","w");
function validState($state, $STATES) {

	$obj_states = json_decode($STATES);
	//echo count($obj_states);
	//echo $obj_states[0]->name;
	//echo $state;

	for ($i=0; $i<count($obj_states); $i++) {
		if (strtolower($obj_states[$i]->name)==strtolower($state) 
			|| strtolower($obj_states[$i]->abbreviation)==strtolower($state) ) return true;
		//echo $i. "<br>";
	}
	return false;

	//echo "valid state test!";
}

$sql = "SELECT * FROM independence_form";
$result = mysql_query($sql);
$data = array("id", "firstname", "lastname", "address", "city", "zip", "state", "email", "time", "formID");

while ($array = mysql_fetch_array($result)) {
$valid_firstname = false;
$valid_lastname = false;
$valid_address = false;
$valid_city = false;
$valid_zip = false;
$valid_state = false;
$valid_email = false;

	$data["id"] = trim($array[0]);
	$data["firstname"] = trim($array[1]);
	$data["lastname"] = trim($array[2]);
	$data["address"] = trim($array[3]);
	//$data["address"] = "Address";
	$data["city"] = trim($array[4]);
	$data["zip"] = trim($array[5]);
	$data["state"] = trim($array[6]); $data["state"] = rtrim($data["state"], ".");
	//$state2 = $data["state"];
	//$id2 = $array[0];
	//$sql2 = "UPDATE cms_abc SET state=$state2 WHERE id=$id2";
	//mysql_query($sql2);
	$data["email"] = str_replace(' ', '', trim($array["7"], ' '));	
	$data["time"] = trim($array[8]);
	$data["formID"] = trim($array[9]);
	//fputcsv($file, $data);
	if ( !preg_match('/[!@#$%^&*()+=\[\];,`\/{}|":<>?~\\\\]/', $data["firstname"])&&$data["firstname"]!=""&&$data["firstname"]!="First Name" ) $valid_firstname = true;
	if ( !preg_match('/[!@#$%^&*()+=\[\];,`\/{}|":<>?~\\\\]/', $data["lastname"])&&$data["lastname"]!=""&&$data["lastname"]!="Last Name" ) $valid_lastname = true;
	if ( !preg_match('/[!@$%^&*()+=\[\];`{}|":<>?~\\\\]/', $data["address"])&&$data["address"]!=""&&$data["address"]!="Address" ) $valid_address = true;
	if ( !preg_match('/[!@#$%^&*()+=\-\[\];`\/{}|":<>?~\\\\]/', $data["city"])&&$data["city"]!=""&&$data["city"]!="City" ) $valid_city = true;
	if ( preg_match('/(^\d{5}$)/', $data["zip"])&&$data["zip"]!=""&&$data["zip"]!="Zip Code" ) $valid_zip = true;
	if ( validState($data["state"], $STATES)&&$data["state"]!=""&&$data["state"]!="State" ) $valid_state = true;
	//if ( filter_var($data["email"], FILTER_VALIDATE_EMAIL) ) $valid_email = true;

	
	if (!$valid_firstname || !$valid_lastname || !$valid_address || !$valid_city
		|| !$valid_zip || !$valid_state) {
		echo $array[0] . " ";
		echo $data["firstname"] . " ";
		echo $data["lastname"] . " ";
		echo $data["address"] . " ";
		echo $data["city"] . " ";
		echo $data["zip"] . " ";
		echo $data["state"] . " ";
		echo $data["email"] . " ";
		//echo $array[8] . " ";
		//echo $array[9] . "<br>";	
		echo "<br>";
	}

}



mysql_close($conn);
?>