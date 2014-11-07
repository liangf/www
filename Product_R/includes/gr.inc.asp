<%
'*--------------------------------------------------------------------------*
'* 
'* Copyright (C) 2011 Brand Labs LLC
'* 
''*--------------------------------------------------------------------------*

%>
<%
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
	Public orders
	Public qty
	
	Private Sub Class_Initialize()
	orders= Null
	qty= Null
	End Sub
	
	Private Sub Class_Terminate()	
	End Sub
	
	
	Public Function reflect()
		Set reflect = Server.CreateObject("Scripting.Dictionary")
		With reflect			
			.Add "orders", orders
			.Add "qty", qty
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
	
   
    Public Function RetrieveMonth(Byval pc, Byval month, Byval year) 
		Dim SQL 
		Dim Document 'As MSXML.Document
		Dim tmpProduct 'As Product
		Dim PrNode
		Dim ProductList
		Dim ProductNode
        Dim productcode, mm, yy
		productcode=pc
		mm=month
		yy=year

		'Set default return value
		Set RetrieveMonth = Nothing
		Set ProductList = Server.CreateObject("Scripting.Dictionary")
		'Setup SQL using template
		SQL = VolusionAPICallObject.ReadFile( _
			FSO.BuildPath(mInstallPath, CONFIGURATION_P_SQL_FILE) _
		)
		
		 productcode = mVBExt.OptimizedReplaceAll(productcode,"'","")
		 mm = mVBExt.OptimizedReplaceAll(mm,"'","")
		 yy = mVBExt.OptimizedReplaceAll(yy,"'","")
		 SQL = mVBExt.OptimizedReplaceAll(SQL, "#{productcode}", productcode)
		 SQL = mVBExt.OptimizedReplaceAll(SQL, "#{mm}", mm)
		 SQL = mVBExt.OptimizedReplaceAll(SQL, "#{yy}", yy)
		 
		'Make custom API call
		Call VolusionAPICallObject.DoCustomAPICall( _
			SQL, _
			VolusionAPICallObject.ReadFile( _
			FSO.BuildPath(mInstallPath, CONFIGURATION_P_XSD_FILE) _
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
			tmpProduct.orders = Field(PrNode, "orders")
			tmpProduct.qty = Field(PrNode, "qty")
			
			ProductList.addProduct(tmpProduct)
			
			Set tmpProduct = Nothing
		Next
		
		Set ProductNode = Nothing
		Set RetrieveMonth = ProductList

		Set ProductNode = Nothing
		Set PrNode = Nothing
	End Function
	
	Private Function Field(ByVal Document, ByVal Pattern)
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

End Class


%>