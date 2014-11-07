/*****************************************************************************/
/*                                                                           */
/* Description: JS for Easter LP                                             */
/* Expand tips section                                                       */
/* Re: http://jsfiddle.net/gDvyR/121/                                        */
/* http://css-plus.com/2010/11/create-a-scrolling-anchor-link-with-jquery/   */
/* Author: CompAndSave.com                                                   */
/* Version: 0.0.1                                                            */
/*****************************************************************************/

$( document ).ready(function() {
	var tipmoreText = "Hide tips";
    var	tiplessText = "See tips",
    	moreButton = $("div.readmorebtnTips");

	moreButton.click(function () {
    	var $this = $(this);
    	//$this.text($this.text() == tipmoreText ? tiplessText : tipmoreText).nextAll(".more").slideToggle("fast");
    	$this.html("<div class='cas_eeh_searchbar'><a class='btn cas_cms_pinkBtn' id='cas_eeh_tipText'>" + ($this.text() == tipmoreText ? tiplessText : tipmoreText) + "</a></div>").nextAll(".more").slideToggle("fast");
	
	    var tiplessTextPosition = jQuery('#easter-roll-achor').offset().top;
	
	// When #scroll is clicked
	if ($this.text() == "Hide tips") {jQuery('html, body').animate({scrollTop:tiplessTextPosition}, 'slow');}

	});

});