/*******************************************************/
/* */
/* Description: Click on images and show coupon code */
/* value of id ci-ed-eggClick and ci-ed-stopWatch */
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
   
	$('#ci-ed-hardBn').click(function(){
		document.getElementById('ci-ed-hardBn').style.background="#999";
		document.getElementById('ci-ed-normalBn').style.background="#000";
		document.getElementById('ci-ed-easyBn').style.background="#000";
	});
	
	$('#ci-ed-normalBn').click(function(){
		document.getElementById('ci-ed-hardBn').style.background="#000";
		document.getElementById('ci-ed-normalBn').style.background="#999";
		document.getElementById('ci-ed-easyBn').style.background="#000";
	});
	
	$('#ci-ed-easyBn').click(function(){
		document.getElementById('ci-ed-hardBn').style.background="#000";
		document.getElementById('ci-ed-normalBn').style.background="#000";
		document.getElementById('ci-ed-easyBn').style.background="#999";
	});	
	
    $('#ci-ed-start').click(function(){    	
    	document.getElementById('ci-ed-eggClick').style.display="block";
		document.getElementById('ci-ed-start').style.display="none";
		document.getElementById('ci-ed-reset').style.display="block";
		document.getElementById('ci-ed-again').style.display="none";
		document.getElementById('ci-ed-reward').style.display="none";
		document.getElementById('ci-ed-playMode').style.display="block";
		document.getElementById('ci-ed-option').style.display="none";
	 });

	$('#ci-ed-reset').click(function(){    	
    	document.getElementById('ci-ed-eggClick').style.display="none";
		document.getElementById('ci-ed-start').style.display="block";
		document.getElementById('ci-ed-reset').style.display="none";
		document.getElementById('ci-ed-again').style.display="none";
		document.getElementById('ci-ed-reward').style.display="none";
		document.getElementById('ci-ed-playMode').style.display="none";
		document.getElementById('ci-ed-option').style.display="block";		
	 });
/*    	
    $('#ci-ed-eggClick').click(function(){    	  
		document.getElementById('ci-ed-eggClick').style.display="none";
		document.getElementById('ci-ed-start').style.display="none";
		document.getElementById('ci-ed-reset').style.display="none";
		document.getElementById('ci-ed-again').style.display="block";
		document.getElementById('ci-ed-reward').style.display="block";
		document.getElementById('ci-ed-playMode').style.display="none";
		document.getElementById('ci-ed-option').style.display="block";
		document.getElementById('ci-ed-rankName').style.display="block";
		document.getElementById('ci-ed-thanks').style.display="none";	
	 });	
*/    
	$('#ci-ed-again').click(function() {
		document.getElementById('ci-ed-eggClick').style.display="none";
		document.getElementById('ci-ed-start').style.display="block";
		document.getElementById('ci-ed-reset').style.display="none";
		document.getElementById('ci-ed-again').style.display="none";
		document.getElementById('ci-ed-reward').style.display="none";
		document.getElementById('ci-ed-playMode').style.display="none";
		document.getElementById('ci-ed-option').style.display="block";	
		document.getElementById('ci-ed-rankName').style.display="block";
		document.getElementById('ci-ed-thanks').style.display="none";
    });
/*
	$('#ci-ed-nameBtn').click(function(){
		//$('#ci-ed-rankName').innerHtml = "test test";
		document.getElementById('ci-ed-rankName').style.display="none";
		document.getElementById('ci-ed-thanks').style.display="block";
		
	});
*/
});