(function($) {
    $(function() {
        /*
        Carousel initialization
        */
        $('.jcarousel')
            .jcarousel({
                // Options go here
				//animation: 'fast'
				wrap: 'circular'
            });


$('.jcarousel-control-prev').click(function() {
    $('.jcarousel').jcarousel('scroll', '-=1');
});
			
$('.jcarousel-control-next').click(function() {
    $('.jcarousel').jcarousel('scroll', '+=1');
});



    });
})(jQuery);