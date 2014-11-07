<% @Language = VBScript %>
<% 
'declare variables
Dim strWedgeData, i
Dim StartPos, MyVar, DelimPos
Dim Myarray(3) 'Specify the number of fields you defined in WinWedge between the parenthesis

'retrieve wedgedata information
strWedgeData = Trim(Request.QueryString("WedgeData"))

'How to separate multiple comma delimited fields from the single strWedgeData variable:

'Add Terminating comma
MyVar = strWedgeData & ","

' starting position in the string - start at 1st byte
StartPos = 1 

' scan until we reach the end of the string
While StartPos < Len(MyVar) 

' find the next comma delimiter
DelimPos = InStr(StartPos, MyVar, ",") 

' pull out a data point between the starting position and the position of the delimiter
DataPoint = Mid(MyVar, StartPos, DelimPos - StartPos) 

' update the starting position (skip over the delimiter)
StartPos = DelimPos + 1 

' Field counter
fCount = fCount + 1

' save the current data point
Myarray(fCount) = DataPoint
 
' go get the next point
Wend 

%>

<HTML><BODY><H1>Here is your Wedge Data:</H1>

<%
Dim i

'Loop through each record in the array and display the data
For i = 1 to Ubound(Myarray)
Response.Write("Field " & i & " = " & Myarray(i) & "<br>")
next 'i

%>
</BODY></HTML>