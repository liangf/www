<%@LANGUAGE="VBSCRIPT.Encode"%>
<%

Option Explicit
'Response.Buffer = True
'Server.ScriptTimeout=600
%>
<!-- #include file="includes/configuration.inc-amazon.asp" -->
<!-- #include file="includes/vbscript_extensions.inc.asp" -->
<!-- #include file="includes/volusion_api_call.inc.asp" -->



<%


Dim Collector 'As ProductsCollector

Dim OrderObj 'As String


Dim thefso, f 
Dim Tab
Tab = chr(9)

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
Response.Write("total records: " & ProductNode.length & "<br>")



Set thefso = Server.CreateObject("Scripting.FileSystemObject") 
Set f = thefso.CreateTextFile(Server.MapPath(CONFIGURATION_NEW_DATAFEED_PATH), True, False) 
	
Dim all_totalpayment
Dim old_orderid
Dim new_orderid
new_orderid = 0	
all_totalpayment = 0
'f.Writeline ("orderid" & Tab & "totalpayment")
'f.Writeline ("orderid" & Tab & "totalpayment" & Tab & "orderdate" & Tab & "orderdetailid" & Tab & "productcode" & Tab & "productname")
For Each PrNode In ProductNode
	'f.Writeline (Field(PrNode, "orderid") & Tab & Field(PrNode, "totalpayment") )
	'f.Writeline (Field(PrNode, "orderid") & Tab & Field(PrNode, "totalpayment") & Tab & Field(PrNode, "orderdate") & Tab & Field(PrNode, "orderdetailid") & Tab & Field(PrNode, "productcode") & Tab & Field(PrNode, "productname") )
	Response.Write(Field(PrNode, "orderid") & "<br>")
Next
 
 
f.close 

set f = nothing 
set thefso = nothing 


'Reset some objects
Set Collector = Nothing

	

%>


