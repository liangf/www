<%@LANGUAGE="VBSCRIPT.Encode"%>
<%

Option Explicit
'Response.Buffer = True
%>



<%
Dim mdy
Dim hms
Dim nowTime
Dim runTime
Dim isrun
isrun = 0
runTime = "5/23/2014 0:00:30 AM"
mdy = Date
hms = Time
nowTime = mdy & " " & hms
If (nowTime>runTime) Then
	isrun = 1	
End If
isrun = 0
Response.Write(isrun)
%>


