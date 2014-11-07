
<%
Dim datestr, timestr
datestr= year(Now()) & "-" & right("0" & month(Now()),2) & "-" & right("0" & day(Now()),2)
timestr= right("0" & hour(Now()),2) & ":" & right("0" & minute(Now()),2) & ":" & right("0" & second(Now()),2)
response.write(datestr & "<br>" & timestr)

%>
