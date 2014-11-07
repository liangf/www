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

Class ProductC
	Public id
	
	Private Sub Class_Initialize()
	id= Null
	End Sub
	
	Private Sub Class_Terminate()	
	End Sub
	
	
	Public Function reflect()
		Set reflect = Server.CreateObject("Scripting.Dictionary")
		With reflect			
			.Add "id", id
		End With
	End Function	
    End Class

Class Product
	Public qty
	
	Private Sub Class_Initialize()
	qty= Null
	End Sub
	
	Private Sub Class_Terminate()	
	End Sub
	
	
	Public Function reflect()
		Set reflect = Server.CreateObject("Scripting.Dictionary")
		With reflect			
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
	
   
    Public Function RetrievePCode(Byval cc)
		Dim SQLC 
		Dim DocumentC 'As MSXML.Document
		Dim tmpProductC 'As Product
		Dim PrNodeC
		Dim ProductListC
		Dim ProductNodeC
        Dim code
		code=cc

		'Set default return value
		Set RetrievePCode = Nothing
		Set ProductListC = Server.CreateObject("Scripting.Dictionary")
		'Setup SQL using template
		SQLC = VolusionAPICallObject.ReadFile( _
			FSO.BuildPath(mInstallPath, CONFIGURATION_C1_SQL_FILE) _
		)
		
		 code = mVBExt.OptimizedReplaceAll(code,"'","")
		 SQLC = mVBExt.OptimizedReplaceAll(SQLC, "#{code}", code)
		 
		'Make custom API call
		Call VolusionAPICallObject.DoCustomAPICall( _
			SQLC, _
			VolusionAPICallObject.ReadFile( _
			FSO.BuildPath(mInstallPath, CONFIGURATION_C_XSD_FILE) _
			) _
		)
		'Parse results
		If Not VolusionAPICallObject.ResponseIsValid Then
			Exit Function
		End If

		'Get the node list
		Set DocumentC = VolusionAPICallObject.ResponseXML
		Set ProductNodeC = DocumentC.documentElement.selectNodes("Products")
		'Set Document = Nothing		
 
		If ProductNodeC.length < 1 Then
			Set ProductNodeC = Nothing 	
			Exit Function
		End If
		Set ProductListC = new ProductList
		For Each PrNodeC In ProductNodeC
			Set tmpProductC = New ProductC
			tmpProductC.id = Field(PrNodeC, "id")
			ProductListC.addProduct(tmpProductC)
			
			Set tmpProductC = Nothing
		Next
		
		Set ProductNodeC = Nothing
		Set RetrievePCode = ProductListC

		Set ProductNodeC = Nothing
		Set PrNodeC = Nothing
	End Function
	
	
	    Public Function RetrieveQty(Byval pc, Byval smc, Byval emc)
		Dim SQL 
		Dim Document 'As MSXML.Document
		Dim tmpProduct 'As Product
		Dim PrNode
		Dim ProductList
		Dim ProductNode
        Dim productcode
		Dim sm, em
		productcode=pc
		sm=smc
		em=emc
		

		'Set default return value
		Set RetrieveQty = Nothing
		Set ProductList = Server.CreateObject("Scripting.Dictionary")
		'Setup SQL using template
		SQL = VolusionAPICallObject.ReadFile( _
			FSO.BuildPath(mInstallPath, CONFIGURATION_C2_SQL_FILE) _
		)
		
		 productcode = mVBExt.OptimizedReplaceAll(productcode,"'","")
		 sm = mVBExt.OptimizedReplaceAll(sm,"'","")
		 em = mVBExt.OptimizedReplaceAll(em,"'","")
		 SQL = mVBExt.OptimizedReplaceAll(SQL, "#{productcode}", productcode)
		 SQL = mVBExt.OptimizedReplaceAll(SQL, "#{sm}", sm)
		 SQL = mVBExt.OptimizedReplaceAll(SQL, "#{em}", em)
		
		'Make custom API call
		Call VolusionAPICallObject.DoCustomAPICall( _
			SQL, _
			VolusionAPICallObject.ReadFile( _
			FSO.BuildPath(mInstallPath, CONFIGURATION_C_XSD_FILE) _
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
			tmpProduct.qty = Field(PrNode, "qty")
			ProductList.addProduct(tmpProduct)
			
			Set tmpProduct = Nothing
		Next
		
		Set ProductNode = Nothing
		Set RetrieveQty = ProductList

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