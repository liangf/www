/*******************************************************/
/* */
/* Description: Click on images and show coupon code */
/* value of id ci-ed-eggClick and ci-ed-coupon */
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

	
    $('#ci-ed-eggClick').click(function(){    	
    	document.getElementById('ci-ed-coupon').style.visibility="visible";   
		document.getElementById('ci-ed-eggClick').style.display="none";
		document.getElementById('ci-ed-reset').style.visibility="visible";
	 });	
    
	$('#ci-ed-reset').click(function() {
		document.getElementById('ci-ed-eggClick').style.display="block";
		document.getElementById('ci-ed-coupon').style.visibility="hidden";
		document.getElementById('ci-ed-reset').style.visibility="hidden";
    });

	$('#ci-ed-hardBn').click(function(){    	
		//animateDiv(hard);
		//alert("hard!!!!");
	 });
	 
});