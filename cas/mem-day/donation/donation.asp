<%@LANGUAGE="VBSCRIPT.Encode"%>
<%

Option Explicit
'Response.Buffer = True
%>
<!-- #include file="includes/configuration.asp" -->
<!-- #include file="includes/vbscript_extensions.asp" -->
<!-- #include file="includes/volusion_api_call.asp" -->



<%
Dim VolusionAPICallObject
Dim FSO
Dim SQL
Dim Document
Dim ProductNode
Dim PrNode

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
	FSO.BuildPath(Server.MapPath(CONFIGURATION_INSTALL_PATH), CONFIGURATION_SQL_FILE) _
)
'Make custom API call
Call VolusionAPICallObject.DoCustomAPICall( _
	SQL, _
	VolusionAPICallObject.ReadFile( _
		FSO.BuildPath(Server.MapPath(CONFIGURATION_INSTALL_PATH), CONFIGURATION_XSD_FILE) _
	) _
)
		 
Set Document = VolusionAPICallObject.ResponseXML
Set ProductNode = Document.documentElement.selectNodes("Products")
'Response.Write("total records: " & ProductNode.length & "<br>")



	
Dim all_totalpayment
Dim old_orderid
Dim new_orderid
new_orderid = 0	
all_totalpayment = 0
Dim count
count = 0
For Each PrNode In ProductNode
	old_orderid = new_orderid
	new_orderid = Field(PrNode, "orderid")
	If old_orderid<>new_orderid Then
		all_totalpayment = all_totalpayment + Field(PrNode, "totalpayment")
		count = count + 1
	End If
Next

'Response.Write( count & "<br>" )  
Response.Write( Int(all_totalpayment*0.05) )   
 

	

%>


