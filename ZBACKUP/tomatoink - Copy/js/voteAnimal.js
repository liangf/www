/*******************************************************/
http://www.tomatoink.com/v/dc/yy/liangf/tomatoink
/*******************************************************/

$(document).ready(function() {
	var count_rab = 0;
	var count_chi = 0;
    $('#ti-ed-rabbitBtn').click(function(){  
		jQuery.post("http://www.tomatoink.com/v/dc/yy/liangf/tomatoink/add_rabchicken.php", 
		//jQuery.post("http://www.casinkadmin.com/yy/liangf/tomatoink/add_rabchicken.php",
					{rabbit: "clickrabbit"}, 
					function(data){
						count_rab = data;
						alert(count_rab);
					});
		document.getElementById('ti-ed-rabbitBtn').style.display="none";  
		//alert("you click rabbit");
	 });


    $('#ti-ed-chickenBtn').click(function(){  
		jQuery.post("http://www.tomatoink.com/v/dc/yy/liangf/tomatoink/add_rabchicken.php", 
		//jQuery.post("http://www.casinkadmin.com/yy/liangf/tomatoink/add_rabchicken.php", 
					{chicken: "clickchicken"},
					function(data){
						count_chi = data;
					});
		document.getElementById('ti-ed-chickenBtn').style.display="none";  
		//alert("you click chicken");
	 });	
	 //var dd = count_rab;
	 //alert(count_rab);
document.getElementById('ti-ed-rabbitBar').style.width = 10 + "%";
document.getElementById('ti-ed-chickenBar').style.width = 90 + "%";

});