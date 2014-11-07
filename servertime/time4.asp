<%@LANGUAGE="VBSCRIPT.Encode"%>
<%

Option Explicit
'Response.Buffer = True
%>



<%
Dim mdy
Dim hms
Dim nowTime
Dim nowTime2
Dim toTime
Dim toTime2
Dim diff_days
Dim diff_days2
Dim diff_days3
Dim isWeekend
Dim isrun
Dim FridayTime
isWeekend = 0
isrun = 0

mdy = Date
hms = Time

nowTime = mdy
nowTime2 = mdy & " " & hms
'nowTime = "6/21/2014"
toTime = "6/30/2014"
diff_days = DateDiff("d", nowTime, toTime)
isWeekend = Weekday(nowTime, 2)
'Response.Write(diff_minutes & "<br>")


toTime2 = "6/23/2014"
FridayTime = "6/20/2014 9:00:00 PM"
diff_days2 = DateDiff("d", nowTime, toTime2)
diff_days3 = DateDiff("d", FridayTime, nowTime)

If diff_days>=0 Then
If (isWeekend=6 or isWeekend=7) Then
	'It's this weekend
	If diff_days2>=0 Then
		isrun = 3
	'It's not weekend
	Else
		isrun= 2
	End If
Else
	'It's not weekend, but it's Friday 9 pm - 11:59 pm
	If nowTime2>FridayTime And isWeekend=5 Then
		isrun = 1
	Else
		isrun = 0
	End If
End If
End If



Response.Write(isrun)
%>


