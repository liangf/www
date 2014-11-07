function validateInput(txt) {
	var re = /^[^<>()\[\]{}\\\/_|!@#$%^&*+\-=?\.,:;'~`"0-9]*$/;
	return re.test(txt);
}

function validateEmail(email) { 
    var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}

function getUrlVars() {
    var vars = {};
    var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {
        vars[key] = value;
    });
    return vars;
}

if (window.location.protocol == "https:") {
	var href = window.location.href;
	href = href.replace('https:', 'http:');
	window.location = href;	
}

function subForm(formID) {
var firstname = document.getElementById('cas_blog_firstname').value
var lastname = document.getElementById('cas_blog_lastname').value
var address = document.getElementById('cas_blog_address').value
var city = document.getElementById('cas_blog_city').value
var zip = document.getElementById('cas_blog_zip').value
var state = document.getElementById('cas_blog_state').value
var email = document.getElementById('cas_blog_email').value

formID = 0;
var utm_flag = getUrlVars()["utm_source"];

if (utm_flag=="bloggiveawaydirectory") formID = 1;
if (utm_flag=="msm") formID = 2;
if (utm_flag=="dealdetective") formID = 3;

if ( firstname=="" || firstname=="First Name" || /[<>()\[\]{}\\\/_|!@#$%^&*+=?:;~`"0-9]/.test(firstname)==true) {
	//document.getElementById('cas_blog_alert').innerHTML = "Please input a valid first name."	
	if ( /[<>()\[\]{}\\\/_|!@#$%^&*+=?:;~`"0-9]/.test(firstname)==true ) 
		document.getElementById('cas_blog_alert').innerHTML = "Please input a valid first name," + " it may contain <>()\[\]{}\\\/_|!@#$%^&*+=?:;~`\" or numbers 0-9."
	else document.getElementById('cas_blog_alert').innerHTML = "Please input a valid first name."	
	return false;
} 

if (lastname=="" || lastname=="Last Name" || /^[^<>()\[\]{}\\\/_|!@#$%^&*+=?:;~`"0-9]*$/.test(lastname)==false) {
	//document.getElementById('cas_blog_alert').innerHTML = "Please input a valid last name."
	if (/^[^<>()\[\]{}\\\/_|!@#$%^&*+=?:;~`"0-9]*$/.test(lastname)==false)
		document.getElementById('cas_blog_alert').innerHTML = "Please input a valid last name," + " it may contain <>()\[\]{}\\\/_|!@#$%^&*+=?:;~`\" or numbers 0-9."
	else document.getElementById('cas_blog_alert').innerHTML = "Please input a valid last name."
	return false;
}

if (address=="" || address=="Address" || /^[^<>()\[\]{}\\\/_|!@$%^&*+=?:;~`"]*$/.test(address)==false) {
	//document.getElementById('cas_blog_alert').innerHTML = "Please input a valid address."
	if (/^[^<>()\[\]{}\\\/_|!@$%^&*+=?:;~`"]*$/.test(address)==false)
		document.getElementById('cas_blog_alert').innerHTML = "Please input a valid address," + " it may contain <>()[]{}\/_|!@$%^&*+=?:;~`\"."	
	else document.getElementById('cas_blog_alert').innerHTML = "Please input a valid address."
	return false;
}

if (city=="" || city=="City" || /^[^<>()\[\]{}\\\/_|!@#$%^&*+\-=?:;~`"0-9]*$/.test(city)==false) {
	//document.getElementById('cas_blog_alert').innerHTML = "Please input a valid city."
	if (/^[^<>()\[\]{}\\\/_|!@#$%^&*+\-=?:;~`"0-9]*$/.test(city)==false)
		document.getElementById('cas_blog_alert').innerHTML = "Please input a valid city," + " it may contain <>()[]{}\/_|!@#$%^&*+\-=?:;~`\" or numbers 0-9."
	else document.getElementById('cas_blog_alert').innerHTML = "Please input a valid city."
	return false;
}

if (zip=="" || zip=="Zip Code" || /(^\d{5}$)|(^\d{5}-\d{4}$)/.test(zip)==false) {
	document.getElementById('cas_blog_alert').innerHTML = "Please input a valid zip code."	
	return false;
}

if (state=="" || state=="State" || /^[^<>()\[\]{}\\\/_|!@#$%^&*+\-=?,:;'~`"0-9]*$/.test(state) == false) {
	//document.getElementById('cas_blog_alert').innerHTML = "Please input a valid state."
	if (/^[^<>()\[\]{}\\\/_|!@#$%^&*+\-=?,:;'~`"0-9]*$/.test(state) == false)
		document.getElementById('cas_blog_alert').innerHTML = "Please input a valid state," + " it may contain <>()[]{}\/_|!@#$%^&*+\-=?,:;'~`\" or numbers 0-9."
	else document.getElementById('cas_blog_alert').innerHTML = "Please input a valid state."
	return false;
}

if (email=="" || email=="Email" || validateEmail(email)==false) {
	document.getElementById('cas_blog_alert').innerHTML = "Please input a valid email."
	return false;
}

var post_url = "http://www.casinkadmin.com/liang/cas/promotion-june-2014/storeForm.php";
if (window.location.protocol == "https:") post_url = "http://www.casinkadmin.com/liang/cas/promotion-june-2014/storeForm2.php";

jQuery.post(post_url,
			{ufirstname:firstname, ulastname:lastname, uaddress:address, ucity:city, uzip:zip, ustate:state, uemail:email, fid:formID}, 
			function(data){ 
			document.getElementById('cas_blog_alert').innerHTML = "Thanks for your participation!"	
				//alert(data)
				document.getElementById('cas_blog_alert').innerHTML = "<h3><span class='cas_cms_small-font'>Thank you for participating in our Father\'s Day Giveaway!</span></h3><p><span class='cas_cms_small-font'>If you are one of the lucky first 100 entries, you will receive your Father\'s Day gift within 2 to 6 weeks. Stay tuned for more great offers from CompAndSave.com!</span></p>"	
				document.getElementById('cas_blog_firstname').value = ""
				document.getElementById('cas_blog_lastname').value = ""
				document.getElementById('cas_blog_address').value = ""
				document.getElementById('cas_blog_city').value = ""
				document.getElementById('cas_blog_zip').value = ""
				document.getElementById('cas_blog_state').value = ""
				document.getElementById('cas_blog_email').value= ""
			}
);


}