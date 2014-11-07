/*
$(document).ready(function(){

var firstname = document.getElementById('cas_msm_firstname').value
var lastname = document.getElementById('cas_msm_lastname').value
var address = document.getElementById('cas_msm_address').value
var city = document.getElementById('cas_msm_city').value
var zip = document.getElementById('cas_msm_zip').value
var state = document.getElementById('cas_msm_state').value
var email = document.getElementById('cas_msm_email').value
var formID = 1
	$('#cas_msm_submitEntry').click(function(){
		var total = firstname+","+lastname+","+address+","+city+","+zip+","+state+","+email

		//alert(total)
		document.getElementById('cas_cms_small-font').innerHTML = "Thanks for your particaipation"	
		jQuery.post("http://www.casinkadmin.com/liang/cas/mom/php/storeForm.php",
					{ufirstname:firstname, ulastname:lastname, uaddress:address, ucity:city, uzip:zip, ustate:state, uemail:email, fid:formID}, 
					function(data){ 
						//document.getElementById('cas_msm_email').innerHTML = "Thanks for your participation"	
						alert(data)
					}
					);
	})

})
*/
function subForm(formID) {
var firstname = document.getElementById('cas_msm_firstname').value
var lastname = document.getElementById('cas_msm_lastname').value
var address = document.getElementById('cas_msm_address').value
var city = document.getElementById('cas_msm_city').value
var zip = document.getElementById('cas_msm_zip').value
var state = document.getElementById('cas_msm_state').value
var email = document.getElementById('cas_msm_email').value

if (email=="" || email=="Email") {
	document.getElementById('cas_cms_small-font').innerHTML = "Please input a valid email."	
}
else {

		jQuery.post("http://www.casinkadmin.com/liang/cas/mom/php/storeForm.php",
			{ufirstname:firstname, ulastname:lastname, uaddress:address, ucity:city, uzip:zip, ustate:state, uemail:email, fid:formID}, 
			function(data){ 
			document.getElementById('cas_msm_email').innerHTML = "Thanks for your participation"	
				//alert(data)
				document.getElementById('cas_cms_small-font').innerHTML = "Thanks for your particaipation!"	
				document.getElementById('cas_msm_firstname').value = ""
				document.getElementById('cas_msm_lastname').value = ""
				document.getElementById('cas_msm_address').value = ""
				document.getElementById('cas_msm_city').value = ""
				document.getElementById('cas_msm_zip').value = ""
				document.getElementById('cas_msm_state').value = ""
				document.getElementById('cas_msm_email').value= ""
			}
		);
}

}
