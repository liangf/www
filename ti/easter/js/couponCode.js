/*******************************************************/
/* */
/* Description: Click on images and show coupon code */
/* value of id ti-ed-chickenBtn, ti-ed-rabbitBtn, and ti-ed-coupon */
/* Author: Sam Chao */
/* Version: 0.0.2 */
/*******************************************************/

$(document).ready(function() {


    //$('#ci-ed-eggImage').mouseenter(function(){
    	//document.getElementById('computer').style.background="url('//www.comboink.com/v/newsletter/promotion-Mar2014/images/computer-h.png') no-repeat 0px 0px"
   // });
     //   $('#ci-ed-eggImage').mouseout(function(){
    	//document.getElementById('computer').style.background="url('//www.comboink.com/v/newsletter/promotion-Mar2014/images/computer.png') no-repeat 0px 0px"
   // });

	
    $('#ti-ed-rabbitBtn').click(function(){
		document.getElementById('ti-ed-fight').style.background="transparent url(images/rabbitWin.jpg) 0 0 no-repeat";
		document.getElementById('ti-ed-voteBtn').style.display="none";
		document.getElementById('ti-ed-thankYou').style.display="block";
		document.getElementById('ti-ed-rabbitImg').style.visibility="hidden"; 
		document.getElementById('ti-ed-chickenImg').style.visibility="hidden"; 
		document.getElementById('ti-ed-preCode').style.display="none";   	
    	document.getElementById('ti-ed-coupon').style.display="inline";   
		document.getElementById('ti-ed-couponCode').style.background="#8dc63f"; 
		document.getElementById('ti-ed-highlight').style.color="#f00"; 
	 });	
    
	$('#ti-ed-chickenBtn').click(function() {
		document.getElementById('ti-ed-fight').style.background="transparent url(images/chickenWin.jpg) 0 0 no-repeat";
		document.getElementById('ti-ed-voteBtn').style.display="none";
		document.getElementById('ti-ed-thankYou').style.display="block";
		document.getElementById('ti-ed-rabbitImg').style.visibility="hidden"; 
		document.getElementById('ti-ed-chickenImg').style.visibility="hidden";
		document.getElementById('ti-ed-preCode').style.display="none";  
		document.getElementById('ti-ed-coupon').style.display="inline";
		document.getElementById('ti-ed-couponCode').style.background="#8dc63f"; 
		document.getElementById('ti-ed-highlight').style.color="#00f"; 
    });

});