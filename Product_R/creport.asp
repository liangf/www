 <%@LANGUAGE="VBSCRIPT.Encode"%>
 <!-- #include file="includes/configuration.inc.asp" -->
<!-- #include file="includes/vbscript_extensions.inc.asp" -->
<!-- #include file="includes/volusion_api_call.inc.asp" -->
<!-- #include file="includes/cr.inc.asp" -->
 <%
 Dim sm,em
 Dim coupons, coupon, pcode
 dim tmpA, j
 Dim arr(), qty(200)
 Dim smv, emv,smy,smm,emy,emm
 Dim Collector
 Dim OrderObj, OrderObj2 
 Dim ProductItem, ProductItem2, cid 
 
  'test data
  'coupons="<li>THANKS<img src='delete.png' style='cursor:pointer;' onclick='move2(this.parentNode);'></li><li>xmas2013<img src='delete.png' style='cursor:pointer;' onclick='move2(this.parentNode);'></li><li>thanks7<img src='delete.png' style='cursor:pointer;' onclick='move2(this.parentNode);'></li>"
  'sm="2013/10/01"
  'em="2013/12/09"
  coupons=request.form("cc")
  sm=request.form("start")
  em=request.form("end")
  'deal with products
   tmpA=stripTags(coupons)
   tmpA=Split(tmpA, "$")
   j=0
   For i = 0 To Ubound(tmpA)
    If tmpA(i) <> " " and tmpA(i) <> "" Then
    ReDim Preserve arr(j)
	arr(j) = tmpA(i)
	j=j+1
    End If
   Next 
   'deal with months

   Response.Write(sm & " to " & em & chr(10) & ",No. of uses" & chr(10))
   For j=0 to Ubound(arr)
    coupon=arr(j)
    Set Collector = New OrderTrackingCollector
        Collector.DomainName = CONFIGURATION_DOMAIN_NAME
        Collector.UserName = CONFIGURATION_USER_NAME
        Collector.Password = CONFIGURATION_PASSWORD
        Collector.UseSSL = CONFIGURATION_USE_SSL
        Collector.InstallPath = Server.MapPath(CONFIGURATION_INSTALL_PATH)
        Collector.DestinationPath = Server.MapPath(CONFIGURATION_DESTINATION_PATH)
	  Set OrderObj = Collector.RetrievePCode(coupon)
	     For Each ProductItem In OrderObj.Products
	     cid=ProductItem.id
	     Next
		 pcode="DSC-" & cid
	  Set OrderObj2 = Collector.RetrieveQty(pcode, sm, em)
	     if OrderObj2 is nothing then
		 response.write(arr(j) & ",0" & chr(10))
		 else
	     For Each ProductItem2 In OrderObj2.Products
	     response.write(arr(j) & "," & ProductItem2.qty & chr(10))
	     Next
		 End if
	Next	 
      set Collector =nothing
  
  
  Function stripTags(HTMLstring)
  Dim RegularExpressionObject
  Dim j
  Set RegularExpressionObject = New RegExp
  With RegularExpressionObject
   .Pattern = "<[^>]+>"
   .IgnoreCase = True
   .Global = True
 End With
 stripTags = RegularExpressionObject.Replace(HTMLstring, "$")
 Set RegularExpressionObject = nothing
 End Function    
	   
	   %>