function getUrlVars() {
    var vars = {};
    var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {
        vars[key] = value;
    });
    return vars;
}


Recaptcha.create("6Le_y_USAAAAAEgnyWCG0hg2lS3qo_yPtW-iBdF6", 'captchadiv', {                    
                tabindex: 1,
                theme: "white",
                callback: Recaptcha.focus_response_field
});


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
	var name = document.getElementById('cas_fbr_name').value
	var date = document.getElementById('cas_fbr_date').value
	var email = document.getElementById('cas_fbr_email').value
	
	if ( name=="" || name=="Facebook name") {
		document.getElementById('cas_fbr_alert').innerHTML = "Please input a valid Facebook name."
		return false;
	} 
	
	if ( date=="" || date=="Date review left") {
		document.getElementById('cas_fbr_alert').innerHTML = "Please input a valid Date."	
		return false;
	} 
	
	if (email=="" || email=="CompAndSave account email" || validateEmail(email)==false) {
		document.getElementById('cas_fbr_alert').innerHTML = "Please input a valid email."
		return false;
	}
	
	jQuery.post("http://www.877ink.com/liang/fbreview/storeForm.php",
				{recaptcha_challenge_field:Recaptcha.get_challenge(),recaptcha_response_field:Recaptcha.get_response(),uname:name, udate:date, uemail:email}, 
				function(data){ 
					//alert(data);
					if (data=="yes") {
						document.getElementById('cas_fbr_alert').innerHTML = "<h3><span class='cas_cms_small-font'>Thank you for reviewing on our facebook page.</span></h3>"	
						document.getElementById('cas_fbr_name').value = ""
						document.getElementById('cas_fbr_date').value = ""
						document.getElementById('cas_fbr_email').value = ""
					}
					else 
						document.getElementById('cas_fbr_alert').innerHTML = "<h3><span class='cas_cms_small-font'>The captcha is not correct.</span></h3>"	
				}
);	
}