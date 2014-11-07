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
	Public link

	Public title
	Public description
	Public image_link
	Public price
	Public id
	Public Shipping
	public quantity
	Public model_number
	Public gtin
	 
    Public google_product_category
 
	public upc
	public weight
	
	

	Private Sub Class_Initialize()
	link= Null

	title = Null
	description = Null 
	image_link = Null
	price = Null
	id = Null  
	Shipping = Null
	quantity = Null
  	model_number = Null
	gtin = Null
	 
    google_product_category = Null
    
	upc = Null
	weight = Null
 
	End Sub
	
	Private Sub Class_Terminate()
		
	End Sub
	
	
	Public Function reflect()
		Set reflect = Server.CreateObject("Scripting.Dictionary")
		With reflect			
			.Add "link", link
		
			.Add "title", title
			.Add "description", description
			.Add "image_link", image_link
			.Add "price" ,price
			.Add "id", id
			.Add "Shipping", Shipping
			.Add "quantity", quantity
			.Add "model_number", model_number
			.Add "gtin", gtin
			 
            .Add "google_product_category", google_product_category
			 
			.Add "upc", upc
			.Add "weight", weight
			
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
	
   

	Public Function RetrievePt() 'As ParentCategory
		Dim SQL 'As String
		Dim Document 'As MSXML.Document
		Dim tmpProduct 'As Product
		Dim PrNode
		Dim Node
		Dim newIndex
		Dim SQLFile
		Dim ProductList
		Dim ProductNode


		'Set default return value
		Set RetrievePt = Nothing
		
		
		Set ProductList = Server.CreateObject("Scripting.Dictionary")
		
		 
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
		
		 
		If ProductNode.length < 1 Then
			Set ProductNode = Nothing 	
			Response.Write("going Exit soon<br>")
			Exit Function
		 
		End If
		    Response.Write("total records: " & ProductNode.length)
		Set ProductList = new ProductList
		For Each PrNode In ProductNode
			Set tmpProduct = New Product
			tmpProduct.link = Field(PrNode, "link")
		
			tmpProduct.title = Field(PrNode, "title") 
			tmpProduct.description = Field(PrNode, "description")
			tmpProduct.image_link = Field(PrNode, "image_link")
			tmpProduct.price = Field(PrNode, "price")
			tmpProduct.id = Field(PrNode, "id")
			tmpProduct.Shipping = Field(PrNode, "Shipping")
			tmpProduct.quantity = Field(PrNode, "quantity")
			tmpProduct.model_number = Field(PrNode, "model_number")
			tmpProduct.gtin = Field(PrNode, "gtin")
			'Response.write(tmpProduct.gtin & " ")
			tmpProduct.google_product_category = Field(PrNode, "google_product_category")
	        
			tmpProduct.upc = Field(PrNode, "upc")
			tmpProduct.weight = Field(PrNode, "weight")
			'Response.write(Field(PrNode, "METATAG_Title") & "<br>")
			'Response.write(Field(PrNode, "ProductWeight") & "<br>")
			
			ProductList.addProduct(tmpProduct)
			
			Set tmpProduct = Nothing
		Next
		
		Set ProductNode = Nothing
		Set RetrievePt = ProductList

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