<%@LANGUAGE="VBSCRIPT.Encode"%>
<!-- #include file="includes/VSMTP_CLASS.asp" -->
<%
    Dim time
    Dim mailer
	time= request.queryString("canshu")
	Dim fs, thefso, f 
    Dim a
	Dim nmonth

    nmonth=dateadd("m",+1,now())
    nmonth= monthname(month(nmonth),true)
   'insert new products to txt file
    a=Server.MapPath("ARecords3.txt")
    set fs=Server.CreateObject("Scripting.FileSystemObject")
     If  fs.FileExists(a)  Then
      Set thefso = Server.CreateObject("Scripting.FileSystemObject") 
      Set f = thefso.OpenTextFile(a, 2, True) 
      f.Writeline(time)
      f.close 
    Else
      set fso = server.createobject("scripting.FileSystemObject")
      set f = fso.CreateTextFile(a, True, False)
      f.Writeline(time)
      f.close 
    End if
	  set f = nothing 
      set fso = nothing
	  
	  
	Set mailer = new vsmtp
	mailer.VsmtpKey = "00236ACD-3727-4128-8C18-36ACDB2902EB"
	mailer.EmailSubject = "new cron job setting" 
	mailer.EmailFrom = "service@compandsave.com"
	mailer.EmailTo = "andrew@compandsave.com"
	mailer.TextBody = "Please add this url: www.compandsave.com/v/dc/yy/Product_R/autoreport.asp to cron jobs, starting date is the first day of next Month, and repeat every month. It's set through Product Report Generation System. Thanks" & chr(10) & chr(10) & chr(10) & "Jing"
	mailer.Send()
    set mailer=nothing
	response.write("Your auto report is set successfully! Report will be sent to the recipients once per month starting from " & nmonth & " 1st.")
%>