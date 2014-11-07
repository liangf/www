<%@LANGUAGE="VBSCRIPT.Encode"%>
<%
'*--------------------------------------------------------------------------*
'* 
'* Copyright (C) 2011 Brand Labs LLC
'* 
'* 
'*--------------------------------------------------------------------------*

Option Explicit
'Response.Buffer = True
%>
<!-- #include file="includes/vbscript_extensions.inc.asp" -->
<!-- #include file="includes/configuration.inc.asp" -->
<!-- #include file="includes/volusion_api_call.inc.asp" -->




<%



Class ExtractOrder

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
	

Public Function CountOrder() 'As ParentCategory
		Dim SQL 'As String
		Dim Document 'As MSXML.Document
		Dim Node	
		Dim CustomerNode
 


		Dim totalcount 
		totalcount = 0 

		Set CountOrder = Nothing
		Server.ScriptTimeout= 2999


        SQL = VolusionAPICallObject.ReadFile( _
			FSO.BuildPath(mInstallPath, CONFIGURATION_SEL_SQL_FILE) _
		)


		'Make custom API call
		Call VolusionAPICallObject.DoCustomAPICall( _
			SQL, _
			VolusionAPICallObject.ReadFile( _
				FSO.BuildPath(mInstallPath, CONFIGURATION_XSD_FILE) _
			) _
		)

        Set Document = VolusionAPICallObject.ResponseXML
		Set CustomerNode = Document.documentElement.selectNodes("Products")
				
               'Set emaillist = new EmailList	
			for each Node in CustomerNode
				totalcount = Field(Node, "total")
			Next
        
         


       

        
		
		CountOrder = totalcount 
		'response.write("count: " & totalcount)
		
	End Function



	


	Private Function Field(ByVal Document, ByVal Pattern)
		Dim Node 'As ?
		
		'Default return value
		Field = Null
		
		If Document Is Nothing Then
		    Filed=" "
			Exit Function
		End If
		
		'Retrieve node
		Set Node = Document.selectSingleNode(Pattern)
		If Node Is Nothing Then
		    Field=" "
			Exit Function
		End If
		'Return value
		Field = Node.text
		Set Node = Nothing
	End Function



End Class


%>




<%
Dim Collector 'As ProductsCollector
'Dim Tab
'Dim HTML 'As String
'Dim thefso, fem
'Dim EmailInfoObj 'As productinfo
'Dim EmailInfoNode
'Dim Extensions
Dim result

'Dim num


Sub NoResults
	Response.Write("I can't find anything through this, here is no Results Call")
	Response.End()
End Sub




result=""

'Mainly part: connect with SQL database and retrieve information
Set Collector = New ExtractOrder
Collector.DomainName = CONFIGURATION_DOMAIN_NAME
Collector.UserName = CONFIGURATION_USER_NAME
Collector.Password = CONFIGURATION_PASSWORD
Collector.UseSSL = CONFIGURATION_USE_SSL
Collector.InstallPath = Server.MapPath(CONFIGURATION_INSTALL_PATH)
Collector.DestinationPath = Server.MapPath(CONFIGURATION_DESTINATION_PATH)

result = Collector.CountOrder()
Response.write(result)


Set Collector = Nothing


%>

