var STATES = 
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
]

function validateInput(txt) {
	var re = /^[^<>()\[\]{}\\\/_|!@#$%^&*+\-=?\.,:;'~`"0-9]*$/;
	return re.test(txt);
}

function validateEmail(email) { 
    var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}


function subForm(formID) {
var firstname = document.getElementById('cas_abc_firstname').value
var lastname = document.getElementById('cas_abc_lastname').value
var address = document.getElementById('cas_abc_address').value
var city = document.getElementById('cas_abc_city').value
var zip = document.getElementById('cas_abc_zip').value
var state = document.getElementById('cas_abc_state').value
var email = document.getElementById('cas_abc_email').value


//if (firstname=="" || firstname=="First Name" || checkSpecial(firstname, specialChars1)==true) {
//if (firstname=="" || firstname=="First Name" || /^[^<>()\[\]{}\\\/_|!@#$%^&*+\-=?,:;~`"0-9]*$/.test(firstname)==false) {
if (firstname=="" || firstname=="First Name" || /[<>()\[\]{}\\\/_|!@#$%^&*+\-=?,:;~`"0-9]/.test(firstname)==true) {
	document.getElementById('cas_abc_alert').innerHTML = "Please input a valid firstname."	
	return false;
} 

if (lastname=="" || lastname=="Last Name" || /^[^<>()\[\]{}\\\/_|!@#$%^&*+\-=?,:;~`"0-9]*$/.test(lastname)==false) {
	document.getElementById('cas_abc_alert').innerHTML = "Please input a valid lastname."
	return false;
}

if (address=="" || address=="Address" || /^[^<>()\[\]{}\\\/_|!@$%^&*+=?:;~`"]*$/.test(address)==false) {
	document.getElementById('cas_abc_alert').innerHTML = "Please input a valid address."	
	return false;
}

if (city=="" || city=="City" || /^[^<>()\[\]{}\\\/_|!@#$%^&*+\-=?:;~`"0-9]*$/.test(city)==false) {
	document.getElementById('cas_abc_alert').innerHTML = "Please input a valid city."	
	return false;
}

if (zip=="" || zip=="Zip Code" || /(^\d{5}$)|(^\d{5}-\d{4}$)/.test(zip)==false) {
	document.getElementById('cas_abc_alert').innerHTML = "Please input a valid zip code."	
	return false;
}

if (state=="" || state=="State" || /^[^<>()\[\]{}\\\/_|!@#$%^&*+\-=?,:;'~`"0-9]*$/.test(state) == false) {
	document.getElementById('cas_abc_alert').innerHTML = "Please input a valid state."	
	return false;
}

if (email=="" || email=="Email" || validateEmail(email)==false) {
	document.getElementById('cas_abc_alert').innerHTML = "Please input a valid email."
	return false;
}

{

		jQuery.post("http://www.casinkadmin.com/liang/cas/mom/php/storeABC.php",
			{ufirstname:firstname, ulastname:lastname, uaddress:address, ucity:city, uzip:zip, ustate:state, uemail:email, fid:formID}, 
			function(data){ 
			document.getElementById('cas_abc_email').innerHTML = "Thanks for your participation!"	
				//alert(data)
				document.getElementById('cas_abc_alert').innerHTML = "<h3><span class='cas_cms_small-font'>Thank you for participating in our Mother\'s Day Giveaway!</span></h3><p><span class='cas_cms_small-font'>If you are one of the lucky first 1000 entries, you will receive your Mother\'s Day gift within 2 to 6 weeks. Stay tuned for more great offers from CompAndSave.com!</span></p>"	
				document.getElementById('cas_abc_firstname').value = ""
				document.getElementById('cas_abc_lastname').value = ""
				document.getElementById('cas_abc_address').value = ""
				document.getElementById('cas_abc_city').value = ""
				document.getElementById('cas_abc_zip').value = ""
				document.getElementById('cas_abc_state').value = ""
				document.getElementById('cas_abc_email').value= ""
			}
		);
}

}