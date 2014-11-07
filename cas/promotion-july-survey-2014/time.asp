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
'now_time = "7/15/2014 0:00:59 AM"
to_time  = "7/14/2014 11:59:59 PM"


flag_run = 0

interval_seconds  = DateDiff("s", to_time, now_time)




If interval_seconds>=0  Then
	flag_run = 1	
End If


flag_run = 1
Response.Write(flag_run)



%>


