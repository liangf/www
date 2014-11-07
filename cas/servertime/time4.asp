<%@LANGUAGE="VBSCRIPT.Encode"%>
<%

Option Explicit
'Response.Buffer = True
%>



<%
Dim mdy
Dim hms
Dim now_time
Dim to_time
Dim to_time2
Dim friday_time
Dim interval_seconds
Dim interval_seconds2
Dim interval_seconds3
Dim day_in_week
Dim flag_run

mdy = Date
hms = Time
now_time = mdy & " " & hms
'now_time = "7/1/2014 0:00:00 AM"
'now_time = "6/20/2014 2:00:00 AM"
'now_time = "6/30/2014 0:00:00 AM"
to_time  = "6/30/2014 11:59:59 PM"
to_time2 = "6/22/2014 11:59:59 PM"
friday_time = "6/20/2014 9:00:00 PM"
flag_run = 0

interval_seconds  = DateDiff("s", now_time, to_time)
interval_seconds2 = DateDiff("s", now_time, to_time2)
interval_seconds3 = DateDiff("s", friday_time, now_time)
day_in_week = Weekday(now_time, 2)

'Response.Write(now_time & "<br>")
'Response.Write(interval_seconds & "<br>")
'Response.Write(day_in_week & "<br>")



' The Campaign is in June
If interval_seconds>=0 Then
	If (day_in_week=6 Or day_in_week=7) Then
		' This weekend
		If interval_seconds2>=0 Then
			flag_run = 3
		' Not this weekend
		Else
			flag_run = 2
		End If
	Else
		'Not weekend, but 20/6/2014 Friday 9 pm - 11:59 pm
		If day_in_week=5 And interval_seconds3>=0 Then
			flag_run = 1
		Else 
			flag_run = 0
		End If
	End If
End If


Response.Write(flag_run)
%>


