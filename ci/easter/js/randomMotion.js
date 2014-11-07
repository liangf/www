/*******************************************************/
/* */
/* Description: Egg moving randomly in the file */
/* value of id ci-ed-eggClick */
/* Author: Sam Chao */
/* Version: 0.0.1 */
/*******************************************************/

var click_hard = 0;
var click_normal = 0;
var click_easy = 0;
var hard = 3;
var normal = 0.8;
var easy = 0.4;

$(document).ready(function() {
	animateDiv(easy);
	$('#ci-ed-hardBn').click(function(){   
		//alert("hard");
		click_hard = 1;
		click_normal = 0;
		click_easy = 0;
		//animateDiv(hard);
	 });	
    
	$('#ci-ed-normalBn').click(function(){    
		//alert("normal");
		click_hard = 0;
		click_normal = 1;
		click_easy = 0;
		//animateDiv(normal);
	 });	

	$('#ci-ed-easyBn').click(function(){    
		//alert("easy");
		click_hard = 0;
		click_normal = 0;
		click_easy = 1;
		//animateDiv(easy);
	 });	
});

function makeNewPosition($container) {

    // Get viewport dimensions (remove the dimension of the div)
    $container = ($container || $(window))
    var h = $container.height() - 50;
    var w = $container.width() - 50;
	//console.log(h);
	//console.log(w);

    var nh = Math.floor(Math.random() * h);
    var nw = Math.floor(Math.random() * w);
	//console.log(nh);
	//console.log(nw);

    return [nh, nw];

}

function animateDiv(speedMod) {
    var $target = $('.ci-ed-eggClick');
    var newq = makeNewPosition($target.parent());
    var oldq = $target.offset();
	//console.log(oldq);
    var speed = calcSpeed([oldq.top, oldq.left], newq, speedMod);
	
    $('.ci-ed-eggClick').animate({
        top: newq[0],
        left: newq[1]
    }, speed, function() {
		if (click_hard) animateDiv(hard);
		else if (click_easy) animateDiv(easy);
		else animateDiv(normal);
    });

};

function calcSpeed(prev, next, speedMod) {

    var x = Math.abs(prev[1] - next[1]);
    var y = Math.abs(prev[0] - next[0]);

    //var greatest = x > y ? x : y;
	var greatest = Math.sqrt(x*x+y*y);

    //var speedModifier = 0.1;
	speedModifier = speedMod;

    var speed = Math.ceil(greatest / speedModifier);

    return speed;

}