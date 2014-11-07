/*******************************************************/
/* */
/* Description: Click on images and show coupon code */
/* value of id ti-ed-chickenBtn, ti-ed-rabbitBtn, and ti-ed-coupon */
/* Author: Sam Chao */
/* Version: 0.0.1 */
/*******************************************************/

$(document).ready(function() {


    //$('#ci-ed-eggImage').mouseenter(function(){
    	//document.getElementById('computer').style.background="url('//www.comboink.com/v/newsletter/promotion-Mar2014/images/computer-h.png') no-repeat 0px 0px"
   // });
     //   $('#ci-ed-eggImage').mouseout(function(){
    	//document.getElementById('computer').style.background="url('//www.comboink.com/v/newsletter/promotion-Mar2014/images/computer.png') no-repeat 0px 0px"
   // });

	
    $('#ti-ed-rabbitBtn').click(function(){  
		document.getElementById('ti-ed-preCode').style.display="none";   	
    	document.getElementById('ti-ed-coupon').style.display="inline";   
	 });	
    
	$('#ti-ed-chickenBtn').click(function() {
		document.getElementById('ti-ed-preCode').style.display="none";  
		document.getElementById('ti-ed-coupon').style.display="inline";
    });

});