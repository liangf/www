if (window.location.protocol == "https:") {
	var href = window.location.href;
	href = href.replace('https:', 'http:');
	window.location = href;	
}

function validateEmail(email) { 
    var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}


function subForm(formID) {
var q1 = "";
var product_name = "";
var q2 = "";
var q3 = "";
var q4 = "";
var q5 = "";

q1 =  jQuery('input[name="product-type"]:checked').val();
if (typeof q1 == "undefined") q1 = "";
//if (q1=="no") product_name = document.getElementById('product_code_input').value;
q2 = document.getElementById('printer_model_input').value;
q3 = document.getElementById('purchase_date').value;
q4 = jQuery("#select_freq_options :selected").text();
q5 = jQuery('input[name="email-freq"]:checked').val();
if (typeof q5 == "undefined") q5 = "";

//alert(q4);
if (document.getElementById('product_code_input')) product_name = document.getElementById('product_code_input').value;
var product_code_radio = document.getElementById('product_code_radio');

//document.getElementsByClassName("ci_sur_alert")[0].innerHTML = "";
if (product_code_radio != null) {
	if (q1=="") {
		document.getElementById('ci_sur_alert').innerHTML = "Please answer question 1.";
		return false;
	} else document.getElementById('ci_sur_alert').innerHTML = "";
	if (q2==""||q2=="Printer Model") {
		document.getElementById('ci_sur_alert').innerHTML = "Please answer question 2.";
		return false;
	} else document.getElementById('ci_sur_alert').innerHTML = "";
	if (q3==""||q3=="MM/DD/YYYY") {
		document.getElementById('ci_sur_alert').innerHTML = "Please answer question 3.";
		return false;
	} else document.getElementById('ci_sur_alert').innerHTML = "";
	if (q4==""||q4=="Please select") {
		document.getElementById('ci_sur_alert').innerHTML = "Please answer question 4.";
		return false;
	} else document.getElementById('ci_sur_alert').innerHTML = "";
	if (q5=="") {
		document.getElementById('ci_sur_alert').innerHTML = "Please answer question 5.";
		return false;
	} else document.getElementById('ci_sur_alert').innerHTML = "";
}
else {
	if (q2==""||q2=="Printer Model") {
		document.getElementById('ci_sur_alert').innerHTML = "Please answer question 1.";
		return false;
	} else document.getElementById('ci_sur_alert').innerHTML = "";
	if (q3==""||q3=="MM/DD/YYYY") {
		document.getElementById('ci_sur_alert').innerHTML = "Please answer question 2.";
		return false;
	} else document.getElementById('ci_sur_alert').innerHTML = "";
	if (q4==""||q4=="Please select") {
		document.getElementById('ci_sur_alert').innerHTML = "Please answer question 3.";
		return false;
	} else document.getElementById('ci_sur_alert').innerHTML = "";
	if (q5=="") {
		document.getElementById('ci_sur_alert').innerHTML = "Please answer question 4.";
		return false;
	} else document.getElementById('ci_sur_alert').innerHTML = "";
}


var firstname = document.getElementById('ci_sur_firstname').value
var lastname = document.getElementById('ci_sur_lastname').value
var address = document.getElementById('ci_sur_address').value
var city = document.getElementById('ci_sur_city').value
var zip = document.getElementById('ci_sur_zip').value
var state = document.getElementById('ci_sur_state').value
var country = document.getElementById('ci_sur_country').value
var email = document.getElementById('ci_sur_email').value
//firstname = firstname.trim();
//lastname = lastname.trim();
//address = address.trim();
//city = city.trim();
//zip = zip.trim();
//state = state.trim();
//email = email.trim();
firstname = jQuery.trim( firstname );
lastname = jQuery.trim( lastname );
address = jQuery.trim( address );
city = jQuery.trim( city );
zip = jQuery.trim( zip );
state = jQuery.trim( state );
country = jQuery.trim( country );
email = jQuery.trim( email );

q3 = q3.split("/");
q3 = q3[2] + "-" + q3[0] + "-" + q3[1];
//console.log("###########Q3: " + q3);

/*
if ( firstname=="" || firstname=="First Name" || /[<>()\[\]{}\\\/_|!@#$%^&*+=?:;~`"0-9]/.test(firstname)==true) {
	if ( /[<>()\[\]{}\\\/_|!@#$%^&*+=?:;~`"0-9]/.test(firstname)==true ) 
		document.getElementById('ci_sur_alert').innerHTML = "Please input a valid first name," + " it may contain <>()\[\]{}\\\/_|!@#$%^&*+=?:;~`\" or numbers 0-9."
	else document.getElementById('ci_sur_alert').innerHTML = "Please input a valid first name."	
	return false;
} else  document.getElementById('ci_sur_alert').innerHTML = "";	

if (lastname=="" || lastname=="Last Name" || /[<>()\[\]{}\\\/_|!@#$%^&*+=?:;~`"0-9]/.test(lastname)==true) {
	if (/[<>()\[\]{}\\\/_|!@#$%^&*+=?:;~`"0-9]/.test(lastname)==true)
		document.getElementById('ci_sur_alert').innerHTML = "Please input a valid last name," + " it may contain <>()\[\]{}\\\/_|!@#$%^&*+=?:;~`\" or numbers 0-9."
	else document.getElementById('ci_sur_alert').innerHTML = "Please input a valid last name."
	return false;
} else document.getElementById('ci_sur_alert').innerHTML = "";

if (address=="" || address=="Address" || /[<>()\[\]{}\\\/_|!@$%^&*+=?:;~`"]/.test(address)==true) {
	if (/[<>()\[\]{}\\\/_|!@$%^&*+=?:;~`"]/.test(address)==true)
		document.getElementById('ci_sur_alert').innerHTML = "Please input a valid address," + " it may contain <>()[]{}\/_|!@$%^&*+=?:;~`\"."	
	else document.getElementById('ci_sur_alert').innerHTML = "Please input a valid address."
	return false;
} else document.getElementById('ci_sur_alert').innerHTML = "";

if (city=="" || city=="City" || /[<>()\[\]{}\\\/_|!@#$%^&*+\-=?:;~`"0-9]/.test(city)==true) {
	if (/[<>()\[\]{}\\\/_|!@#$%^&*+\-=?:;~`"0-9]/.test(city)==true)
		document.getElementById('ci_sur_alert').innerHTML = "Please input a valid city," + " it may contain <>()[]{}\/_|!@#$%^&*+\-=?:;~`\" or numbers 0-9."
	else document.getElementById('ci_sur_alert').innerHTML = "Please input a valid city."
	return false;
} else document.getElementById('ci_sur_alert').innerHTML = "";

if (zip=="" || zip=="Zip Code" || /(^\d{5}$)|(^\d{5}-\d{4}$)/.test(zip)==false) {
	document.getElementById('ci_sur_alert').innerHTML = "Please input a valid zip code."	
	return false;
} else document.getElementById('ci_sur_alert').innerHTML = "";

if (state=="" || state=="State" || /[<>()\[\]{}\\\/_|!@#$%^&*+\-=?,:;'~`"0-9]/.test(state) == true) {
	if (/[<>()\[\]{}\\\/_|!@#$%^&*+\-=?,:;'~`"0-9]/.test(state) == true)
		document.getElementById('ci_sur_alert').innerHTML = "Please input a valid state," + " it may contain <>()[]{}\/_|!@#$%^&*+\-=?,:;'~`\" or numbers 0-9."
	else document.getElementById('ci_sur_alert').innerHTML = "Please input a valid state."
	return false;
} else document.getElementById('ci_sur_alert').innerHTML = "";

if (email=="" || email=="Email" || validateEmail(email)==false) {
	document.getElementById('ci_sur_alert').innerHTML = "Please input a valid email."
	return false;
} else document.getElementById('ci_sur_alert').innerHTML = "";

if (zip!="" &&/(^\d{5}$)|(^\d{5}-\d{4}$)/.test(zip)==false) {
	document.getElementById('ci_sur_alert').innerHTML = "Please input a valid zip code."	
	return false;
} else document.getElementById('ci_sur_alert').innerHTML = "";

if (email=="" || email=="Email") {
	document.getElementById('ci_sur_alert').innerHTML = "Please input a valid email."
	return false;
} else document.getElementById('ci_sur_alert').innerHTML = "";
*/
if(!jQuery("#agree_check").is(':checked')) {
	document.getElementById('ci_sur_alert').innerHTML = "Please click the checkbox.";
	return false;
} else document.getElementById('ci_sur_alert').innerHTML = "";


var post_url = "http://www.casinkadmin.com/liang/ci/promotion-july-survey-2014/storeForm.php";

jQuery.browser={};(function(){jQuery.browser.msie=false;
jQuery.browser.version=0;if(navigator.userAgent.match(/MSIE ([0-9]+)\./)){
jQuery.browser.msie=true;jQuery.browser.version=RegExp.$1;}})();

if (jQuery.browser.msie && window.XDomainRequest) {
            // Use Microsoft XDR
            var xdr = new XDomainRequest();
			q1 = encodeURIComponent(q1);
			product_name = encodeURIComponent(product_name);
			q2 = encodeURIComponent(q2);
			q3 = encodeURIComponent(q3);
			q4 = encodeURIComponent(q4);
			q5 = encodeURIComponent(q5);
			firstname = encodeURIComponent(firstname);
			lastname = encodeURIComponent(lastname);
			address = encodeURIComponent(address);
			city = encodeURIComponent(city);
			zip = encodeURIComponent(zip);
			state = encodeURIComponent(state);
			country = encodeURIComponent(country);
			email = encodeURIComponent(email);
			
			post_url += "?uq1="+q1+"&uproduct="+product_name+"&uq2="+q2+"&uq3="+q3+"&uq4="+q4+"&uq5="+q5+"&ufirstname="+firstname+"&ulastname="+lastname+"&uaddress="+address+"&ucity="+city+"&uzip="+zip+"&ustate="+state+"&ucountry="+country+"&uemail="+email+"+&fid="+formID;
            xdr.open("GET", post_url);
			xdr.send();
            xdr.onload = function() {
                // XDomainRequest doesn't provide responseXml, so if you need it:
                var dom = new ActiveXObject("Microsoft.XMLDOM");
                dom.async = false;
				document.getElementById('ci_sur_alert').innerHTML = "You have successfully submitted the survey.";
				document.getElementById( 'success_message' ).style.display = 'block';	
				document.getElementById( 'ci_sur_surveySection' ).style.display = 'none';
				jQuery('html,body').animate({
					scrollTop: 0},
					'slow');					
				document.getElementById('ci_sur_firstname').value = "";
				document.getElementById('ci_sur_lastname').value = "";
				document.getElementById('ci_sur_address').value = "";
				document.getElementById('ci_sur_city').value = "";
				document.getElementById('ci_sur_zip').value = "";
				document.getElementById('ci_sur_state').value = "";
				document.getElementById('ci_sur_country').value = "";
				document.getElementById('ci_sur_email').value= "";
            };
} 
else {
	jQuery.get(post_url,
			{uq1:q1, uproduct:product_name, uq2:q2, uq3:q3, uq4:q4, uq5:q5, ufirstname:firstname, ulastname:lastname, uaddress:address, ucity:city, uzip:zip, ustate:state, ucountry:country, uemail:email, fid:formID}, 
			function(data){ 
				document.getElementById('ci_sur_alert').innerHTML = "You have successfully submitted the survey.";	
				document.getElementById( 'success_message' ).style.display = 'block';
				document.getElementById( 'ci_sur_surveySection' ).style.display = 'none';
				jQuery('html,body').animate({
					scrollTop: 0},
					'slow');				
				document.getElementById('ci_sur_firstname').value = "";
				document.getElementById('ci_sur_lastname').value = "";
				document.getElementById('ci_sur_address').value = "";
				document.getElementById('ci_sur_city').value = "";
				document.getElementById('ci_sur_zip').value = "";
				document.getElementById('ci_sur_state').value = "";
				document.getElementById('ci_sur_country').value = "";				
				document.getElementById('ci_sur_email').value= "";
			}
	);

}

}

jQuery(document).ready(function(){
	document.getElementById('ci_sur_alert0').innerHTML = "";
});

