<% @Language = VBScript %>
<% 
'declare variables
Dim strWedgeData
Dim tmp
Dim user, tk, datestr, ship_type
Dim timestr
Dim PostUser, PostData
Dim ServerXmlHttp, ServerXmlHttp1, Http
Dim FlagResponse, TextResponse, text 

'retrieve wedgedata information
strWedgeData = Trim(Request.QueryString("wedgedata"))
tmp=Split(strWedgeData, ",")
user= tmp(0)
tk= tmp(2)
datestr= year(Now()) & "-" & right("0" & month(Now()),2) & "-" & right("0" & day(Now()),2)
timestr= right("0" & hour(Now()),2) & ":" & right("0" & minute(Now()),2) & ":" & right("0" & second(Now()),2)


if Len(tk)=22 Then
tk= Right(tk, 15)
ship_type= "FEDEX_ground"
elseif Len(tk)=34 Then
	if Left(tk,1)="1" Then
		ship_type= "FEDEX_express"
	elseif Left(tk,1)="9" Then
		ship_type= "FEDEX_ground"
	end if
tk= Right(tk, 12)
elseif Len(tk)=31 Then
tk= Right(tk, 22)
ship_type= "USPS_domestic"
elseif Len(tk)=32 and Left(tk,1)="3" Then
tk= Right(tk, 16)
tk= Left(tk, 12)
ship_type= "FEDEX_express"
elseif Len(tk)=13 Then
ship_type= "USPS_international"
elseif Len(tk)=15 Then
ship_type= "ONTRAC_ground"
else
ship_type= "OTHERS"
End if


'save to external db

If Len(tk)>10 Then
Set ServerXmlHttp1 = Server.CreateObject("MSXML2.ServerXMLHTTP")
ServerXmlHttp1.open "GET", "http://lf.compandsave.com/barcode/checktn.php?tracking=" & tk
ServerXmlHttp1.setTimeouts 600000, 600000, 600000, 600000 
ServerXmlHttp1.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
ServerXmlHttp1.setRequestHeader "User-Agent", "compandsavetest" 

ServerXmlHttp1.send  
If ServerXmlHttp1.status = 200 Then
	FlagResponse = ServerXmlHttp1.responseText
	If FlagResponse="Y" Then
		Set ServerXmlHttp = Server.CreateObject("MSXML2.ServerXMLHTTP")
		ServerXmlHttp.open "GET", "http://lf.compandsave.com/barcode/finduser.php?scanner=" & user
		ServerXmlHttp.setTimeouts 600000, 600000, 600000, 600000 
		ServerXmlHttp.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
		ServerXmlHttp.setRequestHeader "User-Agent", "compandsavetest" 
		ServerXmlHttp.send  
		If ServerXmlHttp.status = 200 Then
			TextResponse = ServerXmlHttp.responseText
			PostData = "tkn=" & tk & "&userid=" & TextResponse & "&ts=" & timestr & "&ds=" & datestr & "&shiptype=" & ship_type
			Set Http = Server.CreateObject("MSXML2.ServerXMLHTTP")
			Http.open "POST", "http://lf.compandsave.com/barcode/Insertdb.php"  
			Http.setTimeouts 600000, 600000, 600000, 600000 
			Http.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
			Http.setRequestHeader "Content-Length", Len(PostData)
			Http.setRequestHeader "User-Agent", "compandsavetest" 

			Http.send PostData
			text =Http.responseText
			If Http.status <> 200 Then
				response.write("HTTP error")
				%>
				<HTML><BODY><H1>Error Data:</H1> 
				<div style="font-size:20px;">
				<span style="color:blue;"> user: <%= TextResponse%></span><br>
				tracking number: <%= tk%><br>
				date & time: <%= timestr%>
				</div>
				</BODY></HTML>
			<%
			Else
			%>
			<HTML><BODY><H1>Here is your New Data:</H1> 
			<div style="font-size:20px;">
			<span style="color:blue;"> user: <%= TextResponse%></span><br>
			tracking number: <%= tk%><br>
			date & time: <%= timestr%>
			</div>
			<script src="//ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
			<script type="text/javascript">
			window.opener=window;
			setTimeout("window.close();",5000);
			</script>
			</BODY></HTML>
			<%
			End If
			Set Http = Nothing
		Else
		response.write("HTTP error")
		End If
		Set ServerXmlHttp = Nothing
	Else
		response.write("this tracking number " & tk & " is packed!")
		%>
		<HTML><BODY><script src="//ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
			<script type="text/javascript">
			window.opener=window;
			setTimeout("window.close();",5000);
			</script>
			</BODY></HTML>
		<%
	End if
Else
  response.write("HTTP error")
End If
Set ServerXmlHttp1 = Nothing
End if


%>

