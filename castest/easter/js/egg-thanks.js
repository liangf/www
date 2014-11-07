function easter_getCookie(cname) {
	var name = cname + "=";
	var ca = document.cookie.split(';');
	for(var i=0; i<ca.length; i++) {
		var c = ca[i].trim();
		if (c.indexOf(name)==0) return c.substring(name.length,c.length);
	}
	return "";
}



$(document).ready(function(){
	//$('#easter_link_lp').attr('href', "http://www.compandsave.com/v/newsletter/promotion-april-2014/promotion-april-2014.asp?test=easter-egg");
	//$('#easter_link_lp').attr('href', "http://www.compandsavetest.com/v/dc/J/promotion-april-2014-4-11/promotion-april-2014.asp?test=easter-egg");
	$('#easter_link_lp').attr('href', "http://www.compandsavetest.com/v/dc/liang/cas/easter/html/4-12/promotion-april-2014.asp?test=easter-egg");
	
	var user = easter_getCookie("easter_landingpage");
	//if (user=="lp2") $('#easter_link_lp').attr('href', "http://www.compandsave.com/v/newsletter/promotion-april-2014/promotion-april-2014-2.asp?test=easter-egg#easter-rules");
	//if (user=="lp2") $('#easter_link_lp').attr('href', "http://www.compandsavetest.com/v/dc/J/promotion-april-2014-4-11/promotion-april-2014-2.asp?test=easter-egg#easter-rules");
	if (user=="lp2") $('#easter_link_lp').attr('href', "http://www.compandsavetest.com/v/dc/liang/cas/easter/html/4-12/promotion-april-2014-2.asp?test=easter-egg");
});