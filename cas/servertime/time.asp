<%@LANGUAGE="VBSCRIPT.Encode"%>
<%

Option Explicit
'Response.Buffer = True
%>



<%
Dim mdy
Dim hms
Dim totalTime
mdy = Date
hms = Time
totalTime = mdy & " " & hms
response.write(totalTime)	

%>


