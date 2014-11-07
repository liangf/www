/*****************************************************************/
/*                                                               */
/* Description: Search bar function                              */
/* form 5 js                                                     */
/* Author: Yiyang Hao added by Megan Prior-Pfeifer               */
/* Version: 0.0.1                                                */
/*****************************************************************/


    function handleEnter5(inField, e) {  //if you want to add more than one search bar, change this to the corresponding num
        var charCode;
        if(e && e.which){
           charCode = e.which;
        }else if(window.event){
           e = window.event;
           charCode = e.keyCode;
        }

        if(charCode == 13) {
           submitSearch5();      //need to change as the form function name if you add more
           return false;
        }
    }
     
    function submitSearch5() {  //need to change as the form function name if you add more
        if (document.getElementById("search_v5_5").value != "") {   //need to change as the id in form input if you add more
            var searchUrl = "http://search.comboink.com/search?keywords=";    //please change the domain name according to your working domain
            window.location = searchUrl + escape(document.getElementById("search_v5_5").value);  //need to change as the id in form input if you add more
        }
        return false;
    }