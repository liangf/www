  <%@LANGUAGE="VBSCRIPT.Encode"%>
  <%
 Dim fs, thefso, f 
 Dim a
 Dim newrecord
  newrecord=request.form("input")
 'insert new products to txt file
  a=Server.MapPath("ARecords2.txt")
  set fs=Server.CreateObject("Scripting.FileSystemObject")
     If  fs.FileExists(a)  Then
      Set thefso = Server.CreateObject("Scripting.FileSystemObject") 
      Set f = thefso.OpenTextFile(a, 2, True) 
      f.Writeline(newrecord)
      f.close 
    Else
      set fso = server.createobject("scripting.FileSystemObject")
      set f = fso.CreateTextFile(a, True, False)
      f.Writeline(newrecord)
      f.close 
    End if
	  set f = nothing 
      set fso = nothing
	 %>