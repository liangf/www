if (window.location.protocol == "https:") {
	var href = window.location.href;
	href = href.replace('https:', 'http:');
	window.location = href;
}

function getUrlVars() {
    var vars = {};
    var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {
        vars[key] = value;
    });
    return vars;
}

          window.onload = function() {
              Recaptcha.focus_response_field();
          }


          var RecaptchaOptions = {
            
              tabindex: 1,
              theme: 'custom',
              custom_theme_widget: 'recaptcha_widget'
          };


function validateEmail(email) { 
    var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}


function subForm(formID) {
formID = 1;
	var name = document.getElementById('cas_fbr_name').value
	var date = document.getElementById('cas_fbr_date').value
	var email = document.getElementById('cas_fbr_email').value
	
	if ( name=="" || name=="Facebook name") {
		document.getElementById('cas_fbr_alert').innerHTML = "Please input a valid Facebook name."
		return false;
	} 
	
	if ( date=="" || date=="MM/DD/YYYY") {
		document.getElementById('cas_fbr_alert').innerHTML = "Please input a valid Date."	
		return false;
	} 
	
	if (email=="" || email=="CompAndSave account email" || validateEmail(email)==false) {
		document.getElementById('cas_fbr_alert').innerHTML = "Please input a valid email."
		return false;
	}
	
	date = date.split("/");
	date = date[2] + "-" + date[0] + "-" + date[1];	
	
	jQuery.get("http://www.877ink.com/liang/cas/fbreview/storeForm.php",
				{recaptcha_challenge_field:Recaptcha.get_challenge(),recaptcha_response_field:Recaptcha.get_response(),uname:name, udate:date, uemail:email, fid:formID}, 
				function(data){ 
					//alert(data);
					//if (data=="yes") {
					if (data.indexOf("yes") > -1) {
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

jQuery(document).ready(function() {
	$('#cas_fbr_date').datepicker();		
});