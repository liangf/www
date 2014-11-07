/*******************************************************/
http://www.tomatoink.com/v/dc/yy/liangf/tomatoink
/*******************************************************/

$(document).ready(function() {
//document.getElementById('ti-ed-rabbitBar').style.width = 10 + "%";
//document.getElementById('ti-ed-chickenBar').style.width = 90 + "%";
	jQuery.post("http://www.casinkadmin.com/yy/liangf/tomatoink/add_rabchicken.php",
				{initial: "initial000"}, 
				function(data){
					var arr = data.split(",");
					var count_rab = Math.floor(arr[0]);
					var count_chi = Math.floor(arr[1]);
					var len_rab = 100*count_rab/(count_rab+count_chi);
					var len_chi = 100*count_chi/(count_rab+count_chi);
					console.log("------------initial--------");
					console.log(count_rab);
					console.log(count_chi);
					console.log(len_rab);
					console.log(len_chi);
					console.log("------------initial--------");
					//alert(len_rab);
					document.getElementById('ti-ed-rabbitBar').style.width = len_rab + "%";
					document.getElementById('ti-ed-chickenBar').style.width = len_chi + "%";

					//alert(data);
				});
				
    $('#ti-ed-rabbitBtn').click(function(){  
// this is added the tracking event to the easter	
_gaq.push(['_trackEvent', 'Easter', 'Vote', 'Rabbit']);	
		//jQuery.post("http://www.tomatoink.com/v/dc/yy/liangf/tomatoink/add_rabchicken.php", 
		jQuery.post("http://www.casinkadmin.com/yy/liangf/tomatoink/add_rabchicken.php",
					{rabbit: "clickrabbit"}, 
					function(data){
						var arr = data.split(",");
						var count_rab = Math.floor(arr[0])+1;
						var count_chi = Math.floor(arr[1]);
						var len_rab = 100*count_rab/(count_rab+count_chi);
						var len_chi = 100*count_chi/(count_rab+count_chi);
						console.log("------------rabbit--------");
						console.log(count_rab);
						console.log(count_chi);
						console.log(len_rab);
						console.log(len_chi);
						console.log("------------rabbit--------");
						//alert(len_rab);
						document.getElementById('ti-ed-rabbitBar').style.width = len_rab + "%";
						document.getElementById('ti-ed-chickenBar').style.width = len_chi + "%";
					});
		//document.getElementById('ti-ed-rabbitBtn').style.display="none";  
		//alert("you click rabbit");
	 });


    $('#ti-ed-chickenBtn').click(function(){  
	// this is addign the tracking event to the easter
	_gaq.push(['_trackEvent', 'Easter', 'Vote', 'Chicken']);
		//jQuery.post("http://www.tomatoink.com/v/dc/yy/liangf/tomatoink/add_rabchicken.php", 
		jQuery.post("http://www.casinkadmin.com/yy/liangf/tomatoink/add_rabchicken.php", 
					{chicken: "clickchicken"},
					function(data){
						var arr = data.split(",");
						var count_rab = Math.floor(arr[0]);
						var count_chi = Math.floor(arr[1])+1;
						var len_rab = 100*count_rab/(count_rab+count_chi);
						var len_chi = 100*count_chi/(count_rab+count_chi);
						//alert(len_rab);
						console.log("------------chicken--------");
						console.log(count_rab);
						console.log(count_chi);
						console.log(len_rab);
						console.log(len_chi);
						console.log("------------chicken--------");
						document.getElementById('ti-ed-rabbitBar').style.width = len_rab + "%";
						document.getElementById('ti-ed-chickenBar').style.width = len_chi + "%";
					});
		//document.getElementById('ti-ed-chickenBtn').style.display="none";  
		//alert("you click chicken");
	 });	
	 //var dd = count_rab;
	 //alert(count_rab);
//document.getElementById('ti-ed-rabbitBar').style.width = 10 + "%";
//document.getElementById('ti-ed-chickenBar').style.width = 90 + "%";

});