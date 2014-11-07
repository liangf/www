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
	
	
Public Function UpdateOrder(ByVal count, ByVal money) 'As ParentCategory
		Dim SQL 'As String
		Dim Document 'As MSXML.Document
		Dim Node	
		Dim CustomerNode
		'Dim EmailAddress
		'Dim customerid
		'Dim orderid
		Dim ordernote
		Dim commission

			Dim	CustomerID
			Dim	EmailAddress
			Dim	firstName
			Dim	lastName
			Dim	subscripter
			Dim	OrderID 
			Dim	ProductCode
			Dim	OrderDate
			Dim shipstate 
			Dim staterank
			Dim total 
			Dim sub_total
			Dim batchnumber 
			Dim country 
			sub_total=0 
		
		'Dim brandname

		Set UpdateOrder = Nothing
		Server.ScriptTimeout= 2999




		
		'Set default return value

		
		'Setup SQL using template
		'SQL = VolusionAPICallObject.ReadFile( _
		''	FSO.BuildPath(mInstallPath, CONFIGURATION_SQL_FILE) _
		'')
        
		
        'SQL = "INSERT INTO Customers (AccessKey, FirstName, LastName, EmailAddress, BillingAddress1, City, State, PostalCode, Country, EmailSubscriber) VALUES ('C', 'TestFirst', 'TestLast', 'andrew@compandsave', '2122 Medallion Dr', 'Union City', 'CA', '94587', 'USA', 'Y' )"
        'SQL = "SELECT c.CustomerID, c.EmailAddress, c.FirstName, c.LastName, c.EmailSubscriber, o.OrderID,  od.ProductCode, o.OrderDate FROM Customers c INNER JOIN Orders o ON o.CustomerID = c.CustomerID INNER JOIN OrderDetails od ON od.OrderID = o.OrderID WHERE c.CustomerID='213844';"


        'total cost during a certain period'
        'SQL = "SELECT o.OrderID, o.CustomerID, o.Total_Payment_Received FROM Orders o WHERE o.OrderDate between '1/13/2014' and '1/17/2014' AND o.OrderStatus='Shipped';"
        
        'Megan's project, extract states where purchased most
        'SQL = "SELECT o.ShipState, COUNT(o.ShipState) AS num, o.ShipCountry FROM Orders o WHERE o.OrderDate between '1/1/2013' and '1/1/2014' GROUP BY o.ShipState Order BY count(o.ShipState) DESC;"

        'Jackson check for 950 product'
       '' SQL = "SELECT count(o.OrderID) AS num FROM Orders o INNER JOIN OrderDetails od ON od.OrderID = o.OrderID WHERE od.CouponCode='GET950BK' AND o.OrderDate between '1/13/2014' and '1/15/2014'"
         
        'Megan's project,extract customers who purchased most
       'SQL = "SELECT TOP 20 c.CustomerID, SUM(o.Total_Payment_Received) AS Total FROM Customers c INNER JOIN Orders o ON o.CustomerID = c.CustomerID WHERE o.OrderStatus='Shipped' AND o.OrderDate between '1/1/2013' and '12/31/2013' GROUP BY c.CustomerID ORDER BY SUM(o.Total_Payment_Received) DESC" ''
        'second part of customers who purchased most
      '' SQL = "SELECT c.CustomerID, c.FirstName, c.LastName, c.EmailAddress FROM Customers c WHERE CustomerID ='185232' OR CustomerID ='124528' OR CustomerID ='71026' OR CustomerID ='179540' OR CustomerID ='118665' OR CustomerID ='185101' OR CustomerID ='182624' OR CustomerID ='196363' OR CustomerID ='190399' OR CustomerID ='135733' OR CustomerID ='177555' OR CustomerID ='166342' OR CustomerID ='92235' OR CustomerID ='142541' OR CustomerID ='103013' OR CustomerID ='53955' OR CustomerID ='169015' OR CustomerID ='139190' OR CustomerID ='220703' OR CustomerID ='193576'"
        'SQL = "Update Orders SET OrderStatus='shipped' WHERE OrderID='280148'"
        'SQL = "SELECT TOP 1000 t.TrackingNumber, t.Gateway, t.ShipDate, t.OrderID, t.Shipment_Cost, t.Package, t.Form FROM TrackingNumbers t ORDER BY t.ShipDate DESC;"


        'return report for first quarter'
        SQL = "SELECT o.OrderID, o.OrderDate, o.OrderStatus, o.PaymentAmount, o.Total_Payment_Received, o.PaymentAmount - o.Total_Payment_Received AS Sub, o.SalesTax1, o.TotalShippingCost, o.ShipFirstName, o.ShipLastName, o.ShipAddress1, o.ShipCity, o.ShipState, o.ShipPostalCode FROM Orders o WHERE o.Shipped = 'Y' AND o.OrderDate between '3/1/2014' and '4/1/2014' ORDER BY o.OrderDate"


      'SQL = "SELECT o.OrderID, o.OrderDate, o.PaymentAmount, o.Total_Payment_Received, o.PaymentAmount - o.Total_Payment_Received AS Sub, o.SalesTax1, o.TotalShippingCost, o.ShipFirstName, o.ShipLastName, o.ShipAddress1, o.ShipCity, o.ShipState, o.ShipPostalCode, o.OrderStatus FROM Orders o WHERE o.Shipped = 'Y' AND (o.OrderStatus = 'Returned' OR o.OrderStatus = 'Partially Returned' OR o.PaymentAmount > o.Total_Payment_Received) AND o.OrderDate between '1/1/2014' and '4/1/2014' ORDER BY o.OrderDate"






        'SQL = "SELECT c.CustomerID, c.EmailAddress, c.EmailSubscriber FROM Customers c WHERE c.EmailAddress='bbruzdewicz@ameritech.net'"
        'SQL = "SELECT BatchNumber FROM Orders WHERE OrderID='286960'"
        'SQL = "UPDATE Orders SET BatchNumber = '5313' WHERE OrderID = '286960'"
		'ordernote = mVBExt.OptimizedReplaceAll(ordernote,"'","")
		'num = mVBExt.OptimizedReplaceAll(num,"'","")
		'SQL = "Update Customers SET EmailSubscriber = 'N' WHERE EmailAddress='dankupfer@gmail.com';"
		'SQL = mVBExt.OptimizedReplaceAll(SQL, "#{OrderNote}", ordernote)
		'SQL = mVBExt.OptimizedReplaceAll(SQL, "#{OrderId}", num)


		'reorder test'
		'SQL = "SELECT o.OrderID FROM Orders o INNER JOIN Customers c ON c.CustomerID = o.CustomerID WHERE o.ShipAddress1 = 'W6435 S. Prairie Lane';"

		'Make custom API call
		Call VolusionAPICallObject.DoCustomAPICall( _
			SQL, _
			VolusionAPICallObject.ReadFile( _
				FSO.BuildPath(mInstallPath, CONFIGURATION_XSD_FILE) _
			) _
		)
Response.write("OrderID,OrderDate,OrderStatus,PaymentAmount,Total_Payment_Received,Sub,SalesTax1,TotalShippingCost,ShipFirstName,ShipLastName,ShipAddress1,ShipCity,ShipState,ShipPostalCode<br>")
Set Document = VolusionAPICallObject.ResponseXML
		Set CustomerNode = Document.documentElement.selectNodes("Products")
		Set Document = Nothing		
		For each Node in CustomerNode
				'CustomerID = Field(Node, "CustomerID")
				'batchnumber = Field(Node, "BatchNumber")
				EmailAddress = Field(Node, "ShipState")
				EmailAddress = Replace(EmailAddress, ",", " ")
				firstName = Field(Node, "ShipCity")
				firstName = Replace(firstName, ",", " ")
				'lastName = Field(Node, "LastName")
				'subscripter = Field(Node, "EmailSubscriber")
				'OrderID = Field(Node, "OrderID") 
				'Response.write(OrderID & "<br>")
				'ProductCode = Field(Node, "ProductCode")
				'total = Field(Node, "Total")
				shipstate = Field(Node, "ShipLastName")
				shipstate = Replace(shipstate, ",", " ")
				'staterank = Field(Node, "num") 
				country   = Field(Node, "ShipAddress1")
				country = Replace(country, ",", " ")


				Response.write(Field(Node, "OrderID") + "," + Field(Node, "OrderDate") + "," + Field(Node, "OrderStatus") + "," + Field(Node, "PaymentAmount") + "," + Field(Node, "Total_Payment_Received") + "," + Field(Node, "Sub") + "," + Field(Node, "SalesTax1") + "," + Field(Node, "TotalShippingCost") + "," + Field(Node, "ShipFirstName") + "," + shipstate + "," + country + "," + firstName + "," + EmailAddress + "," + Field(Node, "ShipPostalCode") +  "<br>")
				'Response.write(CustomerID + "," + total + "<br>")
				'Response.write(staterank + "<br>")
				'CustomerID = Field(Node, "TrackingNumber")
				'EmailAddress = Field(Node, "Gateway")
				'firstName = Field(Node, "ShipDate")
				'lastName = Field(Node, "OrderID")
				'subscripter = Field(Node, "Shipment_Cost")
				'OrderID = Field(Node, "OrderID") 
				'ProductCode = Field(Node, "Form")
				'OrderDate = Field(Node, "OrderDate") 
				'total = Field(Node, "Total_Payment_Received")
                'sub_total = sub_total + total 
                'Response.write(batchnumber)
                'Response.Write(CustomerID + " " + EmailAddress + " " + firstName + " " + lastName + " " + subscripter + " " + orderID + " " + ProductCode + "<br>")
				'Response.Write(CustomerID + " " + EmailAddress + " " + firstName + "  " + lastName +  "  " + subscripter + " " + OrderID +" "+ ProductCode + " "+ OrderDate + "<br>")
				'Response.write(staterank + " " + country + "<br>")
	    Next 
		
		UpdateOrder = sub_total
		'Set Node = Nothing
		'UpdateOrder = orderid + " " + customerid + " " + ordernote + "<br>"
		
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
Dim Tab
Dim HTML 'As String
Dim thefso, fem
Dim EmailInfoObj 'As productinfo
Dim EmailInfoNode
Dim Extensions
Dim result
Dim Subscripted
Dim num
Dim commission
'Add type headers
'Response.ContentType = "text/html"
'Response.Charset="windows-1252"

Sub NoResults
	Response.Write("I can't find anything through this, here is no Results Call")
	Response.End()
End Sub







If Not Request.Form("tracking")= Null Or Not Request.Form("tracking") = "" Then
num = Request.Form("tracking")
Else
num = ""
End If

If Not Request.Form("commission")= Null Or Not Request.Form("commission") = "" Then
commission = Request.Form("commission")
Else
commission = ""
End If
'num="268400"
'Mainly part: connect with SQL database and retrieve information
Set Collector = New OrderTrackingCollector
Collector.DomainName = CONFIGURATION_DOMAIN_NAME
Collector.UserName = CONFIGURATION_USER_NAME
Collector.Password = CONFIGURATION_PASSWORD
Collector.UseSSL = CONFIGURATION_USE_SSL
Collector.InstallPath = Server.MapPath(CONFIGURATION_INSTALL_PATH)
Collector.DestinationPath = Server.MapPath(CONFIGURATION_DESTINATION_PATH)



result = Collector.UpdateOrder(num, commission)
'Response.Write(Subscripted)
Response.Write(result)


	Set Collector = Nothing
	Set EmailInfoObj = Nothing

%>

