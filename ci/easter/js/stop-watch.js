/********************************************************************************/
/*                                                                               */
/* Description: Stop watches with start, stop, and reset functions               */
/* The source code is gotten from "How To Make A Simple Stopwatch In Javascript" */
/* by Mohamed Shimran. http://www.ultimateprogrammingtutorials.info/             */
/* value of id ci-ed-syart, ci-ed-reset, and ci-ed-again                         */
/* Author: Sam Chao                                                              */
/* Version: 0.0.1                                                                */
/*********************************************************************************/
$(document).ready(function() {
    clearALL();
});


var base = 60;
var clocktimer,dateObj,dh,dm,ds,ms;
var readout='';
var m=1;
var tm=1;
var s=0;
var ts=0;
var ms=0;
var show=true;
var init=0;

function clearALL() {
	clearTimeout(clocktimer);
	m=1;tm=1;s=0;ts=0;ms=0;
	init=0;show=true;
	readout='00:00.00';
	document.clockform.clock.value=readout;
}

function startTIME() { 
	var cdateObj = new Date();
	var t = (cdateObj.getTime() - dateObj.getTime())-(s*1000);

	if (t>999) { s++; }

	if (s>=(m*base)) {
		ts=0;
		m++;
	} 
	else {
		ts=parseInt((ms/100)+s);
		if(ts>=base) { ts=ts-((m-1)*base); }
	}

	ms = Math.round(t/10);
	if (ms>99) {ms=0;}
	if (ms==0) {ms='00';}
	if (ms>0&&ms<=9) { ms = '0'+ms; }

	if (ts>0) { ds = ts; if (ts<10) { ds = '0'+ts; }} 
	else { ds = '00'; }
	dm=tm-1;
	if (dm>0) { if (dm<10) { dm = '0'+dm; }} 
	else { dm = '00'; }

	readout = dm + ':' + ds + '.' + ms;
	if (show==true) { document.clockform.clock.value = readout; }

	clocktimer = setTimeout("startTIME()",1);
}

function findTIME() {
	if(init==0){
		dateObj = new Date();
		startTIME();
		init=1;
}
	else {
		if(show==true) {show=false;} 
		else {show=true;}
	}
}

function findTIME1() {
	if(init==0){
		dateObj = new Date();
		startTIME();
		init=1;
}
	else {
		if(show==true) {show=false;} 
		else {show=true;}
	}
}