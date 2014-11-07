<%@LANGUAGE="VBSCRIPT.Encode"%>
<!-- #include file="includes/VSMTP_CLASS.asp" -->
<!-- #include file="includes/configuration.inc.asp" -->
<!-- #include file="includes/vbscript_extensions.inc.asp" -->
<!-- #include file="includes/volusion_api_call.inc.asp" -->
<!-- #include file="includes/auto.inc.asp" -->

<%
Dim a, b, c, productl, emails, timep
Dim fs, f, fs2, f2, fs3, f3, f4, thefso 
Dim Collector  
Dim tmpA, tmpB, i, j, arr(), brr()
Dim OrderObj  
Dim pcode
Dim ProductItem
Dim crr(50), drr(50), count
Dim olddate(20),sm(20), sy(20), newdate(20)
Dim YOYor, YOYqy, YOYpor, YOYpqy, t1, t2, t3, t4
Dim diffor(20), diffqy(20), peror(20), perqy(20) 
Dim newdatesum, crrsum, drrsum, perorsum, perqysum, difforsum, diffqysum
Dim a1, mail


a=Server.MapPath("ARecords1.txt")
Set fs = Server.CreateObject("Scripting.FileSystemObject") 
Set f = fs.OpenTextFile(a, 1, True) 
productl = f.ReadAll 
f.close 
set fs=nothing

Set fs2 = Server.CreateObject("Scripting.FileSystemObject") 
b=Server.MapPath("ARecords2.txt") 
Set f2 = fs2.OpenTextFile(b, 1, True) 
emails = f2.ReadAll 
f2.close 
set fs2=nothing

Set fs3 = Server.CreateObject("Scripting.FileSystemObject") 
c=Server.MapPath("ARecords3.txt") 
Set f3 = fs3.OpenTextFile(c, 1, True) 
'timep stores the time period
timep = f3.ReadAll 
f3.close 
set fs3 = nothing

   timep=Cint(timep)
   'arr() store the productcodes
   tmpA=stripTags(productl)
   tmpA=Split(tmpA, "$")
   j=0
   For i = 0 To UBound(tmpA)
   tmpA(i)=trim(tmpA(i))
    If tmpA(i)<>"" and tmpA(i)<> " " and tmpA(i)<> vbCrLf Then
    ReDim Preserve arr(j)
	arr(j) = trim(tmpA(i))
	j=j+1
    End If
   Next 
   
   'brr() store the email adds
   tmpB=stripTags(emails)  
   tmpB=Split(tmpB, "$")
   j=0
   For i = 0 To UBound(tmpB)
   If tmpB(i) <> "" and tmpB(i) <> " " and tmpB(i)<> vbCrLf Then
    ReDim Preserve brr(j)
	brr(j) = trim(tmpB(i))
	j=j+1
    End If
   Next 
   i=0
   j=0

  a1=Server.MapPath(CONFIGURATION_REPORT_PATH)
   Set thefso = Server.CreateObject("Scripting.FileSystemObject") 
   Set f4 = thefso.CreateTextFile(a1, True, False) 
    'get data from db
	For j=0 to Ubound(arr)
    pcode=arr(j)
	f4.Writeline(pcode)
	count=0
	'inner loop
	 For i=timep to -1
	  olddate(count)=dateadd("m",i,now())
      sy(count)=year(olddate(count))
      sm(count)= monthname(month(olddate(count)),true)
	  Set Collector = New OrderTrackingCollector
        Collector.DomainName = CONFIGURATION_DOMAIN_NAME
        Collector.UserName = CONFIGURATION_USER_NAME
        Collector.Password = CONFIGURATION_PASSWORD
        Collector.UseSSL = CONFIGURATION_USE_SSL
        Collector.InstallPath = Server.MapPath(CONFIGURATION_INSTALL_PATH)
        Collector.DestinationPath = Server.MapPath(CONFIGURATION_DESTINATION_PATH)
	    Set OrderObj = Collector.RetrieveMonth(pcode, i)
	     If OrderObj is nothing Then
		 crr(count)=0
	     drr(count)=0
		 Else
	     For Each ProductItem In OrderObj.Products
	     crr(count)=ProductItem.orders
	     drr(count)=ProductItem.qty
	     Next
		 End if
		 count= count+1
	Next
	count=count-1
	diffor(0)= ""
	diffqy(0)= ""
	peror(0)=""
	perqy(0)=""
	For i=1 to count
	diffor(i)=crr(i)-crr(i-1)
	diffqy(i)=drr(i)-drr(i-1)
	if(crr(i-1)<>0) then
	peror(i)=Round(CLng(crr(i)-crr(i-1))/CLng(crr(i-1))*CLng(100),2) & "%"
	else
	peror(i)="N/A"
	end if
	if(drr(i-1)<>0) then
	perqy(i)=Round(CLng(drr(i)-drr(i-1))/CLng(drr(i-1))*CLng(100),2) & "%"
	else
	perqy(i)="N/A"
	end if
	Next
	if count=12 Then
	YOYor=crr(12)-crr(0)
	YOYqy=drr(12)-drr(0)
	if(crr(0)<>0) then 
	YOYpor=Round(CLng(crr(12)-crr(0))/CLng(crr(0))*CLng(100),2) & "%"
	else
	YOYpor="N/A"
	end if
	if(drr(0)<>0) then
	YOYpqy=Round(CLng(drr(12)-drr(0))/CLng(drr(0))*CLng(100),2) & "%"
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
	newdatesum=""
	crrsum=""
	drrsum=""
	difforsum=""
	diffqysum=""
	perorsum=""
	perqysum=""
	For i=0 to count
	newdate(i)=sm(i) & " " & sy(i)
	newdatesum=newdatesum & newdate(i) & ","
	crrsum= crrsum & crr(i) & ","
	drrsum= drrsum & drr(i) & ","
	difforsum= difforsum & diffor(i) & ","
	diffqysum= diffqysum & diffqy(i) & ","
	perorsum= perorsum & peror(i) & ","
	perqysum= perqysum & perqy(i) & ","
	Next
	
	f4.Writeline("," & newdatesum)
	f4.Writeline("No. of Orders," & crrsum)
	f4.Writeline("No. of Qty," & drrsum)
	f4.Writeline("MOM Increase (no. of Orders)," & difforsum & "," & t1 & "," & YOYor)
	f4.Writeline("MOM Increase (no. of Qty)," & diffqysum & "," & t2 & "," & YOYqy)
	f4.Writeline("MOM % Increase (no. of Orders)," & perorsum & "," & t3 & "," & YOYpor)
	f4.Writeline("MOM % Increase (no. of Qty)," & perqysum & "," & t4 & "," & YOYpqy)
	f4.Writeline(" ")
	'end of inner loop
 Next
  f4.close 
  set f4 = nothing 
  set thefso = nothing 
  set Collector =nothing	 
	
  For i=0 to UBound(brr)
    mail=sendemail(brr(i))
    response.write("Email Send Successfully!<br>")
    mail=""
  Next
	
	
Function sendemail(ByVal emailAdd)
    Dim mailer
	Dim add
	Dim a2
	a2=Server.MapPath(CONFIGURATION_REPORT_PATH)
	add= emailAdd
	Set mailer = new vsmtp
	mailer.VsmtpKey = "00236ACD-3727-4128-8C18-36ACDB2902EB"
	mailer.EmailSubject = "auto-generated report(CAS)"
	mailer.EmailFrom = "Jing@compandsave.com"
	mailer.EmailTo = add
	mailer.TextBody = "Please check the attachment. It's the auto-sent report of the products you required through Product Report Generation System for CAS, thanks." & chr(10) & chr(10) & chr(10) & "Jing"
	mailer.AddAttachment(a2)
	mailer.Send()
    sendemail=""		
End Function 


  Function stripTags(HTMLstring)
  Dim RegularExpressionObject
  Dim k
  Set RegularExpressionObject = New RegExp
  With RegularExpressionObject
   .Pattern = "<[^>]+>"
   .IgnoreCase = True
   .Global = True
 End With
 stripTags = RegularExpressionObject.Replace(HTMLstring, "$")
 stripTags=Replace(stripTags,"\n","") 
  For k= 0 To Len(stripTags)
  stripTags=Replace(stripTags,"$$","$")   
  Next
 Set RegularExpressionObject = nothing
 End Function 
   
   
	
%>