<%
'*--------------------------------------------------------------------------*
'* 
'* Copyright (C) 2011 Brand Labs LLC
'* 
''*--------------------------------------------------------------------------*

%>
<%

Class OrderTrackingCollector

	Private mVBExt 'As VBScriptExtensions
	
	Private mVolusionAPICallObject 'As VolusionAPICall
	Private mFSO 'As Scripting.FileSystemObject
	
	Private mInstallPath 'As String
	
	Private Sub Class_Initialize()
		Set mVBExt = New VBScriptExtensions
		Set mVolusionAPICallObject = Nothing
		Set mFSO = Nothing
	End Sub
	
	Private Sub Class_Terminate()
		Set mFSO = Nothing
		Set mVolusionAPICallObject = Nothing
		Set mVBExt = Nothing
	End Sub
	
	Private Property Get VolusionAPICallObject() 'As VolusionAPICall
		If mVolusionAPICallObject Is Nothing Then
			Set mVolusionAPICallObject = New VolusionAPICall
		End If
		Set VolusionAPICallObject = mVolusionAPICallObject
	End Property
	
	Private Property Get FSO() 'As Scripting.FileSystemObject
		If mFSO Is Nothing Then
			Set mFSO = Server.CreateObject("Scripting.FileSystemObject")
		End If
		Set FSO = mFSO
	End Property
	
	Public Property Let InstallPath(ByVal vInstallPath)
		mInstallPath = vInstallPath
	End Property
	
	Public Property Let DestinationPath(ByVal vDestinationPath)
		VolusionAPICallObject.DestinationPath = vDestinationPath
	End Property
		
	Public Property Let DomainName(ByVal vDomainName)
		VolusionAPICallObject.DomainName = vDomainName
	End Property
	
	Public Property Let UserName(ByVal vUserName)
		VolusionAPICallObject.UserName = vUserName
	End Property
	
	Public Property Let Password(ByVal vPassword)
		VolusionAPICallObject.Password = vPassword
	End Property
	
	Public Property Let UseSSL(ByVal vUseSSL)
		VolusionAPICallObject.UseSSL = vUseSSL
	End Property
	
   

	Public Function RetrievePt() 'As ParentCategory
		Dim SQL 'As String
		Dim Document 'As MSXML.Document
		Dim tmpProduct 'As Product
		Dim PrNode
		Dim Node
		Dim newIndex
		Dim SQLFile
		Dim ProductNode

		Dim CustomerID
		Dim FirstName
		Dim LastName
		Dim EmailAddress
		Dim Subscriber 
		Dim thefso
		Dim f 
		Dim line_text


		'Set default return value
		Set RetrievePt = Nothing
		
		Set thefso = Server.CreateObject("Scripting.FileSystemObject") 
		Set f = thefso.CreateTextFile(Server.MapPath(CONFIGURATION_DATAFEED_PATH), True, False) 
		
		f.Writeline("CustomerID,FirstName,LastName,EmailAddress") 

		 
		'Setup SQL using template
		SQL = VolusionAPICallObject.ReadFile( _
			FSO.BuildPath(mInstallPath, CONFIGURATION_SQL_FILE) _
		)
		 
		'Make custom API call
		Call VolusionAPICallObject.DoCustomAPICall( _
			SQL, _
			VolusionAPICallObject.ReadFile( _
			FSO.BuildPath(mInstallPath, CONFIGURATION_XSD_FILE) _
			) _
		)
		 
		'Parse results
		If Not VolusionAPICallObject.ResponseIsValid Then
			Exit Function
		End If

		'Get the node list
		Set Document = VolusionAPICallObject.ResponseXML
		Set ProductNode = Document.documentElement.selectNodes("Products")
		'Set Document = Nothing		
		Response.write("Total: " & ProductNode.length & "<br>")
		 
		'Set ProductList = new ProductList
		For Each PrNode In ProductNode
			
			CustomerID   = Field(PrNode, "CustomerID")
			FirstName    = Field(PrNode, "FirstName")
			LastName     = Field(PrNode, "LastName") 
			EmailAddress = Field(PrNode, "EmailAddress")

			FirstName = replace(FirstName, ",", " ")
			LastName  = replace(LastName, ",", " ")
			
			line_text = CustomerID + "," + FirstName + "," + LastName  + "," + EmailAddress
			f.Writeline(line_text)

			Response.write(CustomerID & " " & FirstName & " " & LastName & " " & EmailAddress & " " & Subscriber & "<br>")
		Next
		
		f.close 

		set f = nothing 
		set thefso = nothing 
		
		Set ProductNode = Nothing
		Set PrNode = Nothing
		RetrievePt = ""
	End Function
	
	Private Function Field(ByVal Document, ByVal Pattern)
		Dim Node 'As ?
		
		'Default return value
		Field = Null
		
		If Document Is Nothing Then
			Field=""
			Exit Function
		End If
		
		'Retrieve node
		Set Node = Document.selectSingleNode(Pattern)
		If Node Is Nothing Then
			Field=""
			Exit Function
		End If
		'Return value
		Field = Node.text
		Set Node = Nothing
	End Function




End Class


%>