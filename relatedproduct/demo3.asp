<%@LANGUAGE="VBSCRIPT.Encode"%>
<%
Option Explicit
'Response.Buffer = True
%>
<!DOCTYPE html>
  <head>
  <link href="//www.compandsave.com/v/mp/css/cas-article.css" rel='stylesheet' type='text/css'/>
  <link href="//www.compandsave.com/v/mp/facebook-shop/css/facebook-shop.css" rel='stylesheet' type='text/css'/>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
  
        <link rel="stylesheet" type="text/css" href="jcarousel.skeleton.css">
        <script type="text/javascript" src="//sorgalla.com/jcarousel/dist/jquery.jcarousel.min.js"></script>
        <script type="text/javascript" src="jcarousel.skeleton.js"></script>  
  </head>
  <body >

<div class="jcarousel-wrapper">
	<div class="jcarousel">
	<ul>
<%
Dim i
For i=0 To 4
	'Response.Write("test test")
	Response.Write("<li>")
	Response.Write("<div class='cas_fb-inner'>")
	Response.Write("<a target='_blank' href='//www.compandsave.com/ProductDetails.asp?ProductCode=DRUM-Brother-DR110CL'>")
	Response.Write("<h2>Replacement for Hewlett Packard C6656AN / C6656A (HP 56 Black) Ink Cartridge</h2>")
	Response.Write("<div class='cas_fb-imgContain'>")
	Response.Write("<img src='//www.compandsave.com/v/vspfiles/photos/original/DRUM-Brother-DR110CL.jpg'>")
	Response.Write("</div>")
	Response.Write("</a>")
	Response.Write("<p><span class='cas_fb-price'>$11.99</span><a target='_blank' href='//www.compandsave.com/shoppingcart.asp?ProductCode=DRUM-Brother-DR110CL'><input type='submit' value='Add to cart'></input></a></p>")
	Response.Write("</div>")
	Response.Write("</li>")
Next

%>	
<!--
		<li>
        <div class="cas_fb-inner" id="">
          <a target="_blank" href="//www.compandsave.com/ProductDetails.asp?ProductCode=DRUM-Brother-DR110CL">
            <h2>Replacement for Hewlett Packard C6656AN / C6656A (HP 56 Black) Ink Cartridge</h2>
            <div class="cas_fb-imgContain">
              <img src="//www.compandsave.com/v/vspfiles/photos/original/DRUM-Brother-DR110CL.jpg">
            </div>
          </a>
          <p><span class="cas_fb-price">$11.99</span><a target="_blank" href="//www.compandsave.com/shoppingcart.asp?ProductCode=DRUM-Brother-DR110CL"><input type="submit" value="Add to cart"></input></a></p>
        </div>
		</li>
-->

	
		
	</ul>
	</div>
    <!-- Prev/next controls -->
    <a href="#" class="jcarousel-control-prev">&lsaquo; Prev</a>
    <a href="#" class="jcarousel-control-next">Next &rsaquo;</a>	
</div>
  </body>
</html>
	