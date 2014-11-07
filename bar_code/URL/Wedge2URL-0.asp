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
ServerXmlHttp1.open "GET", "https://secure.compandsave.com/lf/barcode/checktn.php?tracking=" & tk
ServerXmlHttp1.setTimeouts 600000, 600000, 600000, 600000 
ServerXmlHttp1.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
ServerXmlHttp1.setRequestHeader "User-Agent", "compandsavetest" 

ServerXmlHttp1.send  
	If ServerXmlHttp1.status = 200 Then
		response.write("HTTP success")
	Else
		response.write("HTTP error")
	End If
Set ServerXmlHttp1 = Nothing
End if


%>

