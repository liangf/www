 <%@LANGUAGE="VBSCRIPT.Encode"%>
  <%Dim a, m
    Dim fs, thefso,f 
	Dim tmpA,LA, i
    a=Server.MapPath("ARecords2.txt")
    set fs=Server.CreateObject("Scripting.FileSystemObject")
      If  fs.FileExists(a)  Then
      Set thefso = Server.CreateObject("Scripting.FileSystemObject") 
      Set f = thefso.OpenTextFile(a, 1, True) 
      m = f.ReadAll 
      f.close 
	  response.write(m)
      set f = nothing 
      set thefso = nothing
      End if
   
   
   %>