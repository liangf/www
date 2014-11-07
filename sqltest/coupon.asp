<%@LANGUAGE="VBSCRIPT.Encode"%>
<%

Option Explicit
'Response.Buffer = True
%>
<!-- #include file="includes/configuration.inc-amazon.asp" -->
<!-- #include file="includes/vbscript_extensions.inc.asp" -->
<!-- #include file="includes/volusion_api_call.inc.asp" -->



<%



Dim thefso, f 
Dim Tab
Tab = chr(9)

Dim VolusionAPICallObject
Dim mVBExt
Dim FSO
Dim SQL
Dim Document
Dim ProductNode
Dim PrNode
Dim cc

'Add type headers
Response.ContentType = "text/html"
Response.Charset="windows-1252"

Sub NoResults
	Response.Write("No order was found with the information you provided. Please go back and try again.")
	Response.End()
End Sub

Function Field(ByVal Document, ByVal Pattern)
	Dim Node 'As ?
		
	'Default return value
	Field = Null
		
	If Document Is Nothing Then
		Exit Function
	End If
		
	'Retrieve node
	Set Node = Document.selectSingleNode(Pattern)
	If Node Is Nothing Then
		Exit Function
	End If
	'Return value
	Field = Node.text
	Set Node = Nothing
End Function



Set VolusionAPICallObject = New VolusionAPICall
VolusionAPICallObject.DomainName = CONFIGURATION_DOMAIN_NAME
VolusionAPICallObject.UserName = CONFIGURATION_USER_NAME
VolusionAPICallObject.Password = CONFIGURATION_PASSWORD
VolusionAPICallObject.UseSSL = CONFIGURATION_USE_SSL
VolusionAPICallObject.DestinationPath = Server.MapPath(CONFIGURATION_DESTINATION_PATH)
 
  
Set FSO = Server.CreateObject("Scripting.FileSystemObject")
SQL = VolusionAPICallObject.ReadFile( _
	FSO.BuildPath(Server.MapPath(CONFIGURATION_INSTALL_PATH), CONFIGURATION_CC_SQL_FILE) _
)
Set mVBExt = New VBScriptExtensions
'cc = "10AMA"
cc = "MDAY10"
'cc = "SCOM10"
cc = mVBExt.OptimizedReplaceAll(cc,"'","")
SQL = mVBExt.OptimizedReplaceAll(SQL, "#{cc}", cc)
'Make custom API call
Call VolusionAPICallObject.DoCustomAPICall( _
	SQL, _
	VolusionAPICallObject.ReadFile( _
		FSO.BuildPath(Server.MapPath(CONFIGURATION_INSTALL_PATH), CONFIGURATION_XSD_FILE) _
	) _
)
		 
Set Document = VolusionAPICallObject.ResponseXML
Set ProductNode = Document.documentElement.selectNodes("Products")
Response.Write("total records: " & ProductNode.length & "<br>")

For Each PrNode In ProductNode
	Response.Write("total orders: " & Field(PrNode, "cc") & "<br>")
Next
 


	

%>


