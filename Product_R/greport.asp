 <%@LANGUAGE="VBSCRIPT.Encode"%>
 <!-- #include file="includes/configuration.inc.asp" -->
<!-- #include file="includes/vbscript_extensions.inc.asp" -->
<!-- #include file="includes/volusion_api_call.inc.asp" -->
<!-- #include file="includes/gr.inc.asp" -->
 <%
 Dim sm,em
 Dim newrecord
 dim tmpA, tmpB, tmpC, str()
 Dim arr(), brr(100),crr(100),ymd(100), diffor(20),diffqy(20), peror(20), perqy(20)
 Dim YOYor, YOYqy, YOYpor, YOYpqy, t1, t2, t3, t4
 Dim j, smv, emv,smy,smm,emy,emm
 Dim difm, pcode, count, label
 Dim Collector 
 Dim OrderObj 
 Dim ProductItem 
 Dim m, k, prpq, prostr(50), qtystr(50), sumbrr(20), sumcrr(20)
  newrecord=request.form("inputrecord")
  sm=request.form("start")
  em=request.form("end")
  'test data
  'newrecord="WINK-BROTHER-LC51-COMBO40 &INK-BROTHER-LC51BK &INK-BROTHER-LC51Y &SPEC-BROTHER-LC51-Combo10 &[HP88] $ZINK-HP-HP88-Combo8, QTY:8*ZINK-HP-HP88-Combo5, QTY:5*&[ZINK-HP] $*ZINK-HP-HP88-Combo8, QTY:8  *ZINK-HP-HP88-Combo5, QTY:5  *INK-BROTHER-LC51BK, QTY:5  *&"
  'sm="2012-11"
  'em="2013-5"
	  
   'deal with products
   tmpA=Split(newrecord, "&")
   j=0
   For i = 0 To Ubound(tmpA)
    If tmpA(i) <> " " and tmpA(i) <> "" Then
    ReDim Preserve arr(j)
	arr(j) = Trim(tmpA(i))
	j=j+1
    End If
   Next 
   'deal with months
   smv=Split(sm,"-")
   smy=cint(smv(0))
   smm=cint(smv(1))
   emv=Split(em,"-")
   emy=cint(emv(0))
   emm=cint(emv(1))
   If smy=emy Then
    difm=emm-smm
   Elseif smy<emy Then
	difm=emm+12-smm
   End if
   'outer loop products
For j=0 to Ubound(arr)
if InStr(arr(j),"$")=0 then
    pcode=arr(j)
	response.write(pcode & chr(10))
	count=0
	countday= 0
   'inner loop multiple months
    If smy=emy Then
	  For i=smm to emm
	   ymd(countday)=MonthName(i,True) & " " & smy
	   countday= countday+1
       Set Collector = New OrderTrackingCollector
        Collector.DomainName = CONFIGURATION_DOMAIN_NAME
        Collector.UserName = CONFIGURATION_USER_NAME
        Collector.Password = CONFIGURATION_PASSWORD
        Collector.UseSSL = CONFIGURATION_USE_SSL
        Collector.InstallPath = Server.MapPath(CONFIGURATION_INSTALL_PATH)
        Collector.DestinationPath = Server.MapPath(CONFIGURATION_DESTINATION_PATH)
	  Set OrderObj = Collector.RetrieveMonth(pcode,i,smy)
	     If OrderObj is nothing Then
		 brr(count)=0
	     crr(count)=0
	     count= count+1
		 Else
	     For Each ProductItem In OrderObj.Products
	     brr(count)=ProductItem.orders
	     crr(count)=ProductItem.qty
	     count= count+1
	     Next
		 End if
     Next	
    	 
    Elseif smy<emy Then
	 For i=smm to 12
	  ymd(countday)=MonthName(i,True) & " " & smy
	  countday= countday+1
	  Set Collector = New OrderTrackingCollector
        Collector.DomainName = CONFIGURATION_DOMAIN_NAME
        Collector.UserName = CONFIGURATION_USER_NAME
        Collector.Password = CONFIGURATION_PASSWORD
        Collector.UseSSL = CONFIGURATION_USE_SSL
        Collector.InstallPath = Server.MapPath(CONFIGURATION_INSTALL_PATH)
        Collector.DestinationPath = Server.MapPath(CONFIGURATION_DESTINATION_PATH)
      Set OrderObj = Collector.RetrieveMonth(pcode,i,smy)
	     If OrderObj is nothing Then
		 brr(count)=0
	     crr(count)=0
	     count= count+1
		 Else
		For Each ProductItem In OrderObj.Products
	     brr(count)=ProductItem.orders
	     crr(count)=ProductItem.qty
	     count= count+1
	   Next
       End if	   
	  Next
	 For i=1 to emm
	   ymd(countday)=MonthName(i,True) & " " & emy
	   countday= countday+1
	   Set Collector = New OrderTrackingCollector
        Collector.DomainName = CONFIGURATION_DOMAIN_NAME
        Collector.UserName = CONFIGURATION_USER_NAME
        Collector.Password = CONFIGURATION_PASSWORD
        Collector.UseSSL = CONFIGURATION_USE_SSL
        Collector.InstallPath = Server.MapPath(CONFIGURATION_INSTALL_PATH)
        Collector.DestinationPath = Server.MapPath(CONFIGURATION_DESTINATION_PATH)
      Set OrderObj = Collector.RetrieveMonth(pcode,i,emy)
	     If OrderObj is nothing Then
		 brr(count)=0
	     crr(count)=0
	     count= count+1
		 Else
		For Each ProductItem In OrderObj.Products
	    brr(count)=ProductItem.orders
	    crr(count)=ProductItem.qty
	    count= count+1
		Next 
		End if
	 Next
    End if
	diffor(0)= ""
	diffqy(0)= ""
	peror(0)=""
	perqy(0)=""
	For i=1 to difm
	diffor(i)=brr(i)-brr(i-1)
	diffqy(i)=crr(i)-crr(i-1)
	if(brr(i-1)<>0) then
	peror(i)=Round(CLng(brr(i)-brr(i-1))/CLng(brr(i-1))*CLng(100),2) & "%"
	else
	peror(i)="N/A"
	end if
	if(crr(i-1)<>0) then
	perqy(i)=Round(CLng(crr(i)-crr(i-1))/CLng(crr(i-1))*CLng(100),2) & "%"
	else
	perqy(i)="N/A"
	end if
	Next
	if difm=12 Then
	YOYor=brr(12)-brr(0)
	YOYqy=crr(12)-crr(0)
	if(brr(0)<>0) then
	YOYpor=Round(CLng(brr(12)-brr(0))/CLng(brr(0))*CLng(100),2) & "%"
	else
	YOYpor="N/A"
	end if
	if(crr(0)<>0) then
	YOYpqy=Round(CLng(crr(12)-crr(0))/CLng(crr(0))*CLng(100),2) & "%"
	else
	YOYpqy="N/A"
	end if
	t1="YOY Increase (no. of Orders)"
	t2="YOY Increase (no. of Qty)"
	t3="YOY % Increase (no. of Orders)"
	t4="YOY % Increase (no. of Qty)"
	Else
	YOYor=""
	YOYqy=""
	YOYpor=""
	YOYpqy=""
	t1=""
	t2=""
	t3=""
	t4=""
	End if
	For i=0 to difm
	response.write("," & ymd(i))
	Next
	response.write(chr(10) & "No. of Orders,")
	For i=0 to difm
	response.write( brr(i) & "," )
	Next
	response.write(chr(10) & "No. of Qty,")
	For i=0 to difm
	response.write(crr(i) & ",")
	Next
	response.write(chr(10) & "MOM Increase (no. of Orders),")
	For i=0 to difm
	response.write(diffor(i) & "," )
	Next
	response.write("," & t1 & "," & YOYor & chr(10) & "MOM Increase (no. of Qty),")
	For i=0 to difm
	response.write(diffqy(i) & ",")
	Next
	response.write("," & t2 & "," & YOYqy & chr(10) & "MOM % Increase (no. of Orders),")
	For i=0 to difm
	response.write(peror(i) & ",")
	Next
	response.write("," & t3 & "," & YOYpor & chr(10) & "MOM % Increase (no. of Qty),")
	For i=0 to difm
	response.write(perqy(i) & ",")
	Next
	response.write("," & t4 & "," & YOYpqy & chr(10) & chr(10))
'for label
 Else
    tmpB=Split(arr(j), "$")
	label=Trim(tmpB(0))
	tmpC=Split(tmpB(1), "*")
	m=0
    For i = 0 To Ubound(tmpC)
    If tmpC(i) <> " " and tmpC(i) <> "" Then
    ReDim Preserve str(m)
	str(m) = Trim(tmpC(i))
	prpq=Split(str(m),",")
	prostr(m)=prpq(0)
	qtystr(m)=Mid(prpq(1), InStr(prpq(1),":")+1)
	qtystr(m)=CInt(qtystr(m))
	m=m+1
    End If
    Next 
	response.write(label & chr(10))
	For i=0 to difm
	sumbrr(i)=0
	sumcrr(i)=0
	Next
	'middle loop multiple products// by k
    For k=0 to Ubound(str)
    count=0
	countday= 0
   'inner loop multiple months// by i
    If smy=emy Then
	   For i=smm to emm
	   ymd(countday)=MonthName(i,True) & " " & smy
	   countday= countday+1
       Set Collector = New OrderTrackingCollector
        Collector.DomainName = CONFIGURATION_DOMAIN_NAME
        Collector.UserName = CONFIGURATION_USER_NAME
        Collector.Password = CONFIGURATION_PASSWORD
        Collector.UseSSL = CONFIGURATION_USE_SSL
        Collector.InstallPath = Server.MapPath(CONFIGURATION_INSTALL_PATH)
        Collector.DestinationPath = Server.MapPath(CONFIGURATION_DESTINATION_PATH)
	  Set OrderObj = Collector.RetrieveMonth(prostr(k),i,smy)
	     If OrderObj is nothing Then
		 brr(count)=0
	     crr(count)=0
	     count= count+1
		 Else
	     For Each ProductItem In OrderObj.Products
	     brr(count)=ProductItem.orders
	     crr(count)=ProductItem.qty*qtystr(k)
	     count= count+1
	     Next
		 End if
     Next	
    	 
    Elseif smy<emy Then
	 For i=smm to 12
	  ymd(countday)=MonthName(i,True) & " " & smy
	  countday= countday+1
	  Set Collector = New OrderTrackingCollector
        Collector.DomainName = CONFIGURATION_DOMAIN_NAME
        Collector.UserName = CONFIGURATION_USER_NAME
        Collector.Password = CONFIGURATION_PASSWORD
        Collector.UseSSL = CONFIGURATION_USE_SSL
        Collector.InstallPath = Server.MapPath(CONFIGURATION_INSTALL_PATH)
        Collector.DestinationPath = Server.MapPath(CONFIGURATION_DESTINATION_PATH)
      Set OrderObj = Collector.RetrieveMonth(prostr(k),i,smy)
	     If OrderObj is nothing Then
		 brr(count)=0
	     crr(count)=0
	     count= count+1
		 Else
		For Each ProductItem In OrderObj.Products
	     brr(count)=ProductItem.orders
	     crr(count)=ProductItem.qty*qtystr(k)
	     count= count+1
	   Next
       End if	   
	  Next
	 For i=1 to emm
	   ymd(countday)=MonthName(i,True) & " " & emy
	   countday= countday+1
	   Set Collector = New OrderTrackingCollector
        Collector.DomainName = CONFIGURATION_DOMAIN_NAME
        Collector.UserName = CONFIGURATION_USER_NAME
        Collector.Password = CONFIGURATION_PASSWORD
        Collector.UseSSL = CONFIGURATION_USE_SSL
        Collector.InstallPath = Server.MapPath(CONFIGURATION_INSTALL_PATH)
        Collector.DestinationPath = Server.MapPath(CONFIGURATION_DESTINATION_PATH)
      Set OrderObj = Collector.RetrieveMonth(prostr(k),i,emy)
	     If OrderObj is nothing Then
		 brr(count)=0
	     crr(count)=0
	     count= count+1
		 Else
		For Each ProductItem In OrderObj.Products
	    brr(count)=ProductItem.orders
	    crr(count)=ProductItem.qty*qtystr(k)
	    count= count+1
		Next 
		End if
	 Next
    End if
	for i=0 to count-1
	sumbrr(i)=sumbrr(i)+ brr(i)
	sumcrr(i)=sumcrr(i)+ crr(i)
	Next
  Next 
  'end of loop k
    diffor(0)= ""
	diffqy(0)= ""
	peror(0)=""
	perqy(0)=""
	For i=1 to difm
	diffor(i)=sumbrr(i)-sumbrr(i-1)
	diffqy(i)=sumcrr(i)-sumcrr(i-1)
	if(brr(i-1)<>0) then
	peror(i)=Round(CLng(sumbrr(i)-sumbrr(i-1))/CLng(sumbrr(i-1))*CLng(100),2) & "%"
	else
	peror(i)="N/A"
	end if
	if(sumcrr(i-1)<>0) then
	perqy(i)=Round(CLng(sumcrr(i)-sumcrr(i-1))/CLng(sumcrr(i-1))*CLng(100),2) & "%"
	else
	perqy(i)="N/A"
	end if
	Next
	if difm=12 Then
	YOYor=sumbrr(12)-sumbrr(0)
	YOYqy=sumcrr(12)-sumcrr(0)
	if(sumbrr(0)<>0) then
	YOYpor=Round(CLng(sumbrr(12)-sumbrr(0))/CLng(sumbrr(0))*CLng(100),2) & "%"
	else
	YOYpor="N/A"
	end if
	if(sumcrr(0)<>0) then
	YOYpqy=Round(CLng(sumcrr(12)-sumcrr(0))/CLng(sumcrr(0))*CLng(100),2) & "%"
	else
	YOYpqy="N/A"
	end if
	t1="YOY Increase (no. of Orders)"
	t2="YOY Increase (no. of Qty)"
	t3="YOY % Increase (no. of Orders)"
	t4="YOY % Increase (no. of Qty)"
	Else
	YOYor=""
	YOYqy=""
	YOYpor=""
	YOYpqy=""
	t1=""
	t2=""
	t3=""
	t4=""
	End if
	For i=0 to difm
	response.write("," & ymd(i))
	Next
	response.write(chr(10) & "No. of Orders,")
	For i=0 to difm
	response.write(sumbrr(i) & "," )
	Next
	response.write(chr(10) & "No. of Qty,")
	For i=0 to difm
	response.write(sumcrr(i) & ",")
	Next
	response.write(chr(10) & "MOM Increase (no. of Orders),")
	For i=0 to difm
	response.write(diffor(i) & "," )
	Next
	response.write("," & t1 & "," & YOYor & chr(10) & "MOM Increase (no. of Qty),")
	For i=0 to difm
	response.write(diffqy(i) & ",")
	Next
	response.write("," & t2 & "," & YOYqy & chr(10) & "MOM % Increase (no. of Orders),")
	For i=0 to difm
	response.write(peror(i) & ",")
	Next
	response.write("," & t3 & "," & YOYpor & chr(10) & "MOM % Increase (no. of Qty),")
	For i=0 to difm
	response.write(perqy(i) & ",")
	Next
	response.write("," & t4 & "," & YOYpqy & chr(10) & chr(10))
End if
	'end of inner loop
  Next
  set Collector =nothing
   
   
   
       
      
   
   
   %>