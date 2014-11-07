    function handleEnter2(inField, e) {  //if you want to add more than one search bar, change this to the corresponding num
        var charCode;
        if(e && e.which){
           charCode = e.which;
        }else if(window.event){
           e = window.event;
           charCode = e.keyCode;
        }

        if(charCode == 13) {
           submitSearch2();      //need to change as the form function name if you add more
           return false;
        }
    }
     
    function submitSearch2() {  //need to change as the form function name if you add more
        if (document.getElementById("search_v5_2").value != "") {   //need to change as the id in form input if you add more
            var searchUrl = "http://search.comboink.com/search?keywords=";    //please change the domain name according to your working domain
            window.location = searchUrl + escape(document.getElementById("search_v5_2").value);  //need to change as the id in form input if you add more
        }
        return false;
    }