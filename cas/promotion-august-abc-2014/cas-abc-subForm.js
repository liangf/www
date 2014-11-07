if (window.location.protocol == "https:") {
	var href = window.location.href;
	href = href.replace('https:', 'http:');
	window.location = href;	
}

function validateEmail(email) { 
    var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}

//document.getElementsByClassName("cas_sur_alert")[0].innerHTML = "";
function subForm(formID) {

var firstname = document.getElementById('cas_abc_firstname').value;
var lastname = document.getElementById('cas_abc_lastname').value;
var address = document.getElementById('cas_abc_address').value;
var city = document.getElementById('cas_abc_city').value;
var zip = document.getElementById('cas_abc_zip').value;
var state = document.getElementById('cas_abc_state').value;
var email = document.getElementById('cas_abc_email').value;

firstname = jQuery.trim( firstname );
lastname = jQuery.trim( lastname );
address = jQuery.trim( address );
city = jQuery.trim( city );
zip = jQuery.trim( zip );
state = jQuery.trim( state );
email = jQuery.trim( email );



if ( firstname=="" || firstname=="First Name" || /[<>()\[\]{}\\\/_|!@#$%^&*+=?:;~`"0-9]/.test(firstname)==true) {
	if ( /[<>()\[\]{}\\\/_|!@#$%^&*+=?:;~`"0-9]/.test(firstname)==true ) 
		document.getElementById('cas_abc_alert').innerHTML = "Please input a valid first name," + " it may contain <>()\[\]{}\\\/_|!@#$%^&*+=?:;~`\" or numbers 0-9."
	else document.getElementById('cas_abc_alert').innerHTML = "Please input a valid first name."	
	return false;
} else  document.getElementById('cas_abc_alert').innerHTML = "";	

if (lastname=="" || lastname=="Last Name" || /[<>()\[\]{}\\\/_|!@#$%^&*+=?:;~`"0-9]/.test(lastname)==true) {
	if (/[<>()\[\]{}\\\/_|!@#$%^&*+=?:;~`"0-9]/.test(lastname)==true)
		document.getElementById('cas_abc_alert').innerHTML = "Please input a valid last name," + " it may contain <>()\[\]{}\\\/_|!@#$%^&*+=?:;~`\" or numbers 0-9."
	else document.getElementById('cas_abc_alert').innerHTML = "Please input a valid last name."
	return false;
} else document.getElementById('cas_abc_alert').innerHTML = "";

if (address=="" || address=="Address" || /[<>()\[\]{}\\\/_|!@$%^&*+=?:;~`"]/.test(address)==true) {
	if (/[<>()\[\]{}\\\/_|!@$%^&*+=?:;~`"]/.test(address)==true)
		document.getElementById('cas_abc_alert').innerHTML = "Please input a valid address," + " it may contain <>()[]{}\/_|!@$%^&*+=?:;~`\"."	
	else document.getElementById('cas_abc_alert').innerHTML = "Please input a valid address."
	return false;
} else document.getElementById('cas_abc_alert').innerHTML = "";

if (city=="" || city=="City" || /[<>()\[\]{}\\\/_|!@#$%^&*+\-=?:;~`"0-9]/.test(city)==true) {
	if (/[<>()\[\]{}\\\/_|!@#$%^&*+\-=?:;~`"0-9]/.test(city)==true)
		document.getElementById('cas_abc_alert').innerHTML = "Please input a valid city," + " it may contain <>()[]{}\/_|!@#$%^&*+\-=?:;~`\" or numbers 0-9."
	else document.getElementById('cas_abc_alert').innerHTML = "Please input a valid city."
	return false;
} else document.getElementById('cas_abc_alert').innerHTML = "";

if (zip=="" || zip=="Zip Code" || /(^\d{5}$)|(^\d{5}-\d{4}$)/.test(zip)==false) {
	document.getElementById('cas_abc_alert').innerHTML = "Please input a valid zip code."	
	return false;
} else document.getElementById('cas_abc_alert').innerHTML = "";

if (state=="" || state=="State" || /[<>()\[\]{}\\\/_|!@#$%^&*+\-=?,:;'~`"0-9]/.test(state) == true) {
	if (/[<>()\[\]{}\\\/_|!@#$%^&*+\-=?,:;'~`"0-9]/.test(state) == true)
		document.getElementById('cas_abc_alert').innerHTML = "Please input a valid state," + " it may contain <>()[]{}\/_|!@#$%^&*+\-=?,:;'~`\" or numbers 0-9."
	else document.getElementById('cas_abc_alert').innerHTML = "Please input a valid state."
	return false;
} else document.getElementById('cas_abc_alert').innerHTML = "";

if (email=="" || email=="Email" || validateEmail(email)==false) {
	document.getElementById('cas_abc_alert').innerHTML = "Please input a valid email."
	return false;
} else document.getElementById('cas_abc_alert').innerHTML = "";




var post_url = "http://www.casinkadmin.com/liang/cas/promotion-august-abc-2014/storeForm.php";

jQuery.browser={};(function(){jQuery.browser.msie=false;
jQuery.browser.version=0;if(navigator.userAgent.match(/MSIE ([0-9]+)\./)){
jQuery.browser.msie=true;jQuery.browser.version=RegExp.$1;}})();

if (jQuery.browser.msie && window.XDomainRequest) {
            // Use Microsoft XDR
            var xdr = new XDomainRequest();

			firstname = encodeURIComponent(firstname);
			lastname = encodeURIComponent(lastname);
			address = encodeURIComponent(address);
			city = encodeURIComponent(city);
			zip = encodeURIComponent(zip);
			state = encodeURIComponent(state);
			email = encodeURIComponent(email);			
			
			post_url += "?ufirstname="+firstname+"&ulastname="+lastname+"&uaddress="+address+"&ucity="+city+"&uzip="+zip+"&ustate="+state+"&uemail="+email+"+&fid="+formID;
            xdr.open("GET", post_url);
			xdr.send();
            xdr.onload = function() {
                // XDomainRequest doesn't provide responseXml, so if you need it:
                var dom = new ActiveXObject("Microsoft.XMLDOM");
                dom.async = false;
				document.getElementById('cas_abc_alert').innerHTML = "Thanks for your participation!";			
				document.getElementById('cas_abc_firstname').value = "";
				document.getElementById('cas_abc_lastname').value = "";
				document.getElementById('cas_abc_address').value = "";
				document.getElementById('cas_abc_city').value = "";
				document.getElementById('cas_abc_zip').value = "";
				document.getElementById('cas_abc_state').value = "";
				document.getElementById('cas_abc_email').value= "";
            };
} 
else {
	jQuery.get(post_url,
			{ufirstname:firstname, ulastname:lastname, uaddress:address, ucity:city, uzip:zip, ustate:state, uemail:email, fid:formID}, 
			function(data){ 
				document.getElementById('cas_abc_alert').innerHTML = "Thanks for your participation!";	
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


