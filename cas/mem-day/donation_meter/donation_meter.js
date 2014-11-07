
/*****************************************/
/*Description: extract total num of order*/
/* and calculate the height and position */
/* Author: Yiyang   01.22.2014           */
/*****************************************/




jQuery(document).ready(function() {
var count = 0;
var BAR_HEIGHT = 700;
var BAR_TOTAL = 100000;
var message_block = document.getElementById('donation-message');
var donation_bar = document.getElementById('meter-bar');



update_donation_bar();
window.setInterval(function(){update_donation_bar()},10000);



function update_donation_bar() {
	var height;

		jQuery.post("//www.compandsave.com/v/dc/yy/donation_meter/countdonations.asp", function(data) {
			message_block.innerHTML = data;
			height = Math.round((data/BAR_TOTAL)*BAR_HEIGHT);
			donation_bar.style.height = height + 'px';
			donation_bar.style.top = Math.round(BAR_HEIGHT - height) + 'px';
	});
}


});


