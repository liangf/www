/*******************************************************/
/* */
/* Description: Click on images and show coupon code */
/* value of id ci-ed-eggClick and ci-ed-stopWatch */
/* Author: Sam Chao */
/* Version: 0.0.2 */
/*******************************************************/
function showRank() {
	var ttime = document.clockform.clock.value;
	//var str123 = "abc#12#cdefg".split(/#12#/);
	//alert(str123[0]);
	//alert(ttime);
	jQuery.post("http://www.casinkadmin.com/yy/liangf/comboink/getRank.php",
		{utime: ttime}, 
		function(data){ 
			//alert(data);
			var arr = data.split("#r#");
			var rank = arr[0];
			var rank_list = arr[1];
			//alert(rank_list);
			var users = rank_list.split("#t#");
			//alert(users.length);
			document.getElementById('ci-ed-vrank').innerHTML = rank;
			for (var i=1; i<users.length; i++) {
				//alert(arr[i-1]);
				var arr2 = users[i-1].split("#n#");
				var name_rank = "ci-ed-nameRank" + i;
				var time_rank = "ci-ed-timeRank" + i;
				document.getElementById(name_rank).innerHTML = arr2[0];
				document.getElementById(time_rank).innerHTML = arr2[1];
			}					
		}
	);
}

function storeRank() {
		// store the user's score to db
		var ttime = document.clockform.clock.value;
		//alert(ttime);
		var nname = document.getElementById("ci-ed-name").value;
		if (nname=="" || nname=="enter your name here...") nname = "anonymous";
		jQuery.post("http://www.casinkadmin.com/yy/liangf/comboink/storeRank.php",
			{utime: ttime, uname: nname}, 
			function(data){ 
				//alert(data);
				var arr = data.split("^");
				for (var i=1; i<arr.length; i++) {
					//alert(arr[i-1]);
					var arr2 = arr[i-1].split(",");
					var name_rank = "ci-ed-nameRank" + i;
					var time_rank = "ci-ed-timeRank" + i;
					document.getElementById(name_rank).innerHTML = arr2[0];
					document.getElementById(time_rank).innerHTML = arr2[1];
				}
			}
		);
}

$(document).ready(function() {


    //$('#ci-ed-eggImage').mouseenter(function(){
    	//document.getElementById('computer').style.background="url('//www.comboink.com/v/newsletter/promotion-Mar2014/images/computer-h.png') no-repeat 0px 0px"
   // });
     //   $('#ci-ed-eggImage').mouseout(function(){
    	//document.getElementById('computer').style.background="url('//www.comboink.com/v/newsletter/promotion-Mar2014/images/computer.png') no-repeat 0px 0px"
   // });
   
	$('#ci-ed-hardBn').click(function(){
		document.getElementById('ci-ed-hardBn').style.background="#82040d";
		document.getElementById('ci-ed-normalBn').style.background="#c3020a";
		document.getElementById('ci-ed-easyBn').style.background="#c3020a";
	});
	
	$('#ci-ed-normalBn').click(function(){
		document.getElementById('ci-ed-hardBn').style.background="#c3020a";
		document.getElementById('ci-ed-normalBn').style.background="#82040d";
		document.getElementById('ci-ed-easyBn').style.background="#c3020a";
	});
	
	$('#ci-ed-easyBn').click(function(){
		document.getElementById('ci-ed-hardBn').style.background="#c3020a";
		document.getElementById('ci-ed-normalBn').style.background="#c3020a";
		document.getElementById('ci-ed-easyBn').style.background="#82040d";
	});	
	
    $('#ci-ed-start').click(function(){    	
    	document.getElementById('ci-ed-eggClick').style.display="block";
		document.getElementById('ci-ed-startBoard').style.display="none";
		document.getElementById('ci-ed-couponCode').style.display="none";
		document.getElementById('ci-ed-reset').style.display="block";
		document.getElementById('ci-ed-again').style.display="none";
		document.getElementById('ci-ed-reward').style.display="none";
		document.getElementById('ci-ed-playMode').style.display="block";
		document.getElementById('ci-ed-option').style.display="none";
		document.getElementById('ci-ed-top10').style.display="none";
	 });

	$('#ci-ed-reset').click(function(){    	
    	document.getElementById('ci-ed-eggClick').style.display="none";
		document.getElementById('ci-ed-startBoard').style.display="block";
		document.getElementById('ci-ed-couponCode').style.display="none";
		document.getElementById('ci-ed-reset').style.display="none";
		document.getElementById('ci-ed-again').style.display="none";
		document.getElementById('ci-ed-reward').style.display="block";
		document.getElementById('ci-ed-playMode').style.display="none";
		document.getElementById('ci-ed-option').style.display="block";	
		document.getElementById('ci-ed-top10').style.display="none";		
	 });
    	
    $('#ci-ed-eggClick').mousedown(function(){    	  
		document.getElementById('ci-ed-eggClick').style.display="none";
		document.getElementById('ci-ed-startBoard').style.display="none";
		document.getElementById('ci-ed-couponCode').style.display="block";
		document.getElementById('ci-ed-reset').style.display="none";
		document.getElementById('ci-ed-again').style.display="block";
		document.getElementById('ci-ed-reward').style.display="block";
		document.getElementById('ci-ed-playMode').style.display="none";
		document.getElementById('ci-ed-option').style.display="block";
		document.getElementById('ci-ed-top10').style.display="block";
		//document.getElementById('ci-ed-rankName').style.display="block";
		//document.getElementById('ci-ed-thanks').style.display="none";	
		
		// stop the time clock
		findTIME();
		// check user click which model -- easy, normal, hard
		if (click_hard) {
			document.getElementById('ci-ed-rankName').style.display="block";
			document.getElementById('ci-ed-thanks').style.display="none";
			showRank();
		}
		else {
			document.getElementById('ci-ed-rankName').style.display="none";
			document.getElementById('ci-ed-thanks').style.display="block";	
			document.getElementById('ci-ed-thanks').innerHTML = "Play on difficult mode to get on the best players list!"	
			showRank();
		}	
	 });	
   
	$('#ci-ed-again').click(function() {
		document.getElementById('ci-ed-eggClick').style.display="none";
		document.getElementById('ci-ed-startBoard').style.display="block";
		document.getElementById('ci-ed-couponCode').style.display="none";
		document.getElementById('ci-ed-reset').style.display="none";
		document.getElementById('ci-ed-again').style.display="none";
		document.getElementById('ci-ed-reward').style.display="block";
		document.getElementById('ci-ed-playMode').style.display="none";
		document.getElementById('ci-ed-option').style.display="block";	
		document.getElementById('ci-ed-rankName').style.display="block";
		document.getElementById('ci-ed-thanks').style.display="none";
		document.getElementById('ci-ed-top10').style.display="none";
    });

	$('#ci-ed-nameBtn').click(function(){
		document.getElementById('ci-ed-rankName').style.display="none";
		document.getElementById('ci-ed-thanks').style.display="block";
		document.getElementById('ci-ed-thanks').innerHTML = "Thank You for Your Participation!"	
		// store the rank in db
		storeRank();
	});

});