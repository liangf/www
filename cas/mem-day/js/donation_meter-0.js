/*****************************************/
/*Description: extract total num of order*/
/* and calculate the height and position */
/* Author: Yiyang   01.22.2014           */
/*****************************************/




jQuery(document).ready(function() {
var count = 0;
var BAR_HEIGHT = 488;
var BAR_TOTAL = 10000;
var message_block = document.getElementById('donation-message');
var donation_bar = document.getElementById('meter-bar');
var message_div = document.getElementById('donation-total');


update_donation_bar();
window.setInterval(function(){update_donation_bar()},10000);



function update_donation_bar() {
	var height;

		jQuery.post("//www.compandsave.com/v/dc/yy/liangf/mem-day/donation/donation.asp", function(data) {
			//data = -20;
			//data = 0;
			//data = 10000;
			data = 5000;
			//data = 15000;
			message_block.innerHTML = data;
			height = Math.round((data/BAR_TOTAL)*BAR_HEIGHT);
                        if (height < 450) {
			donation_bar.style.height = height + 'px';
			donation_bar.style.top = Math.round(BAR_HEIGHT - height + 3) + 'px';
                        message_div.style.top = Math.round(BAR_HEIGHT - height + 3) + 'px';
                        }
                        else {
			donation_bar.style.height = BAR_HEIGHT + 'px';
			donation_bar.style.top =  '3px';
                        message_div.style.top =  '3px';
                        }
donation_bar.style.visibility = "visible";
message_div.style.visibility = "visible";
	});
}


});