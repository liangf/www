<%@LANGUAGE="VBSCRIPT.Encode"%>
<!-- #include file="includes/configuration.inc.asp" -->
<!-- #include file="includes/vbscript_extensions.inc.asp" -->
<!-- #include file="includes/volusion_api_call.inc.asp" -->

<%  
Dim couponcode
Dim Collector 'As ProductsCollector
Dim OrderObj 'As String

couponcode=request.querystring("cc")
Set Collector = New OrderTrackingCollector
Collector.DomainName = CONFIGURATION_DOMAIN_NAME
Collector.UserName = CONFIGURATION_USER_NAME
Collector.Password = CONFIGURATION_PASSWORD
Collector.UseSSL = CONFIGURATION_USE_SSL
Collector.InstallPath = Server.MapPath(CONFIGURATION_INSTALL_PATH)
Collector.DestinationPath = Server.MapPath(CONFIGURATION_DESTINATION_PATH)
 
Set OrderObj = Collector.RetrievePt(couponcode)
  If OrderObj is Nothing Then
  Response.write("N")
  Else 
  Response.write("Y")
  End if
  set Collector=nothing
  

  Class ProductList
	Public Products 'As Product()

	Private PrCount
	Private Sub Class_Initialize()
		Products = Array()
		PrCount = 0
	End Sub
	
	Private Sub Class_Terminate()
		Set Products = Nothing
	End Sub
	
	Public Sub addProduct(Product)
		Redim Preserve Products(PrCount)
		Set Products(PrCount) = Product
		PrCount = PrCount + 1
	End Sub
	
	Public Function reflect()
		Set reflect = Server.CreateObject("Scripting.Dictionary")
		With reflect			
			.Add "Products", Products
		End With
	End Function	
End Class

	
Class Product
	Public cc
	Private Sub Class_Initialize()
	cc= Null
	End Sub
	
	Private Sub Class_Terminate()		
	End Sub

	Public Function reflect()
		Set reflect = Server.CreateObject("Scripting.Dictionary")
		With reflect			
			.Add "cc", cc
			
		End With
	End Function	
    End Class


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
	
	Public Function RetrievePt(ByVal ccan) 'As ParentCategory
		Dim SQL 'As String
		Dim Document 'As MSXML.Document
		Dim tmpProduct 'As Product
		Dim PrNode
		Dim ProductList
		Dim ProductNode
        Dim cc
		cc=ccan

		'Set default return value
		Set RetrievePt = Nothing
		Set ProductList = Server.CreateObject("Scripting.Dictionary")
	    
		
		'Setup SQL using template
		SQL = VolusionAPICallObject.ReadFile( _
			FSO.BuildPath(mInstallPath, CONFIGURATION_CC_SQL_FILE) _
		)
		
		cc = mVBExt.OptimizedReplaceAll(cc,"'","")
		SQL = mVBExt.OptimizedReplaceAll(SQL, "#{cc}", cc)
		
		'Make custom API call
		Call VolusionAPICallObject.DoCustomAPICall( _
			SQL, _
			VolusionAPICallObject.ReadFile( _
			FSO.BuildPath(mInstallPath, CONFIGURATION_CC_XSD_FILE) _
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
 
		If ProductNode.length < 1 Then
			Set ProductNode = Nothing 	
			Exit Function
		End If
		Set ProductList = new ProductList
		For Each PrNode In ProductNode
			Set tmpProduct = New Product
			tmpProduct.cc = Field(PrNode,"cc")
		
			ProductList.addProduct(tmpProduct)
			
			Set tmpProduct = Nothing
		Next
		
		Set ProductNode = Nothing
		Set RetrievePt = ProductList

		Set ProductNode = Nothing
		Set PrNode = Nothing
	End Function
   
	Private Function Field(ByVal Document, ByVal Pattern)
		Dim Node 
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
  End Class
  %>