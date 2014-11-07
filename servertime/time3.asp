<%@LANGUAGE="VBSCRIPT.Encode"%>
<%

Option Explicit
'Response.Buffer = True
%>



<%
Dim mdy
Dim hms
Dim nowTime
Dim toTime
Dim diff_days
Dim isWeekend
Dim isrun
isWeekend = 0
isrun = 0

mdy = Date
hms = Time

nowTime = mdy
'nowTime = "7/1/2014"
toTime = "6/30/2014"
diff_days = DateDiff("d", nowTime, toTime)
isWeekend = Weekday(nowTime, 2)
'Response.Write(diff_minutes & "<br>")

If diff_days>=0 Then
	If (isWeekend=6 or isWeekend=7) Then
		isrun = 1	
	End If
End If
Response.Write(isrun)
%>


