<%@LANGUAGE="VBSCRIPT.Encode"%>
<%

Option Explicit
'Response.Buffer = True
%>



<%
Dim mdy
Dim hms
Dim now_time
Dim from_time
Dim to_time
Dim interval_seconds
Dim interval_seconds2
Dim day_in_week
Dim flag_run

mdy = Date
hms = Time
now_time = mdy & " " & hms
'now_time = "7/19/2014 2:00:00 AM"
to_time  = "7/31/2014 11:59:59 PM"
from_time = "7/1/2014 0:00:00 AM"
flag_run = 0

interval_seconds  = DateDiff("s", from_time, now_time)
interval_seconds2 = DateDiff("s", now_time, to_time)


'Response.Write(now_time & "<br>")
day_in_week = Weekday(now_time, 2)
'Response.Write(day_in_week & "<br>")

If (day_in_week=5) Then
	flag_run = 1	
End If


'flag_run = 1
Response.Write(flag_run)



%>


