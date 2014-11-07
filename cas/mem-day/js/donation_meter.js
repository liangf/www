/*****************************************/
/*Description: extract total num of order*/
/* and calculate the height and position */
/* Author: Yiyang   01.22.2014           */
/* Modified: Sam Chao   01.22.2014           */
/*****************************************/




jQuery(document).ready(function() {
// Opera 8.0+ (UA detection to detect Blink/v8-powered Opera)
var isOpera = !!window.opera || navigator.userAgent.indexOf(' OPR/') >= 0;
// Firefox 1.0+
var isFirefox = typeof InstallTrigger !== 'undefined';   
// At least Safari 3+: "[object HTMLElementConstructor]"
var isSafari = Object.prototype.toString.call(window.HTMLElement).indexOf('Constructor') > 0;
// Chrome 1+
var isChrome = !!window.chrome && !isOpera;   
// At least IE6           
var isIE = /*@cc_on!@*/false || !!document.documentMode; 


var count = 0;
//var BAR_HEIGHT = 488;
var BAR_HEIGHT = 450;
var BAR_TOTAL = 5000;
var message_block = document.getElementById('donation-message');
var donation_bar = document.getElementById('meter-bar');
var message_div = document.getElementById('donation-total');
//var offset = 3;
var offset = 43;

update_donation_bar();
window.setInterval(function(){update_donation_bar()},5000);
update_donation_bar();

if (isSafari) offset = 10;
if (isChrome) offset = 10;
if (isIE) {
//alert("is IE");
offset = 26;
}


function update_donation_bar() {
	var height;

		jQuery.post("//www.compandsave.com/v/dc/yy/liangf/mem-day/donation/donation.asp", function(data) {
			//data = 1250;
			//data = 0;
			//data = 5000;
			//data = 5200;
			//data = 2500
			if (data>5000) data = 5000;
			message_block.innerHTML = data;
			height = Math.round((data/BAR_TOTAL)*BAR_HEIGHT);
			//alert(height);
			donation_bar.style.height = height + 'px';
			donation_bar.style.top = Math.round(BAR_HEIGHT - height + offset) + 'px';
            message_div.style.top = Math.round(BAR_HEIGHT - height + offset) + 'px';           

			donation_bar.style.visibility = "visible";
			message_div.style.visibility = "visible";
	});
}


});