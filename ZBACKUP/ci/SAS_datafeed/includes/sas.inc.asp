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
	Public SKU
	Public Name
	Public URL
	Public Price
	Public RetailPrice
	Public Photos_Cloned_From
	Public Full_Image
    Public Thumbnail_Image
	Public Description
	Public Search_Terms
	Public ReservedForFutureUse
    Public base
	
	Private Sub Class_Initialize()
	SKU= Null
	Name= Null
	URL = Null
	Price = Null 
	RetailPrice = Null
	Photos_Cloned_From = Null
	Full_Image = Null
	Thumbnail_Image = Null
	Description = Null
	Search_Terms = Null  
	ReservedForFutureUse = Null
	base= Null
 
	End Sub
	
	Private Sub Class_Terminate()
		
	End Sub
	
	
	Public Function reflect()
		Set reflect = Server.CreateObject("Scripting.Dictionary")
		With reflect			
			.Add "SKU", SKU
			.Add "Name", Name
			.Add "URL", URL
			.Add "Price", Price
			.Add "RetailPrice", RetailPrice
			.Add "Photos_Cloned_From", Photos_Cloned_From
			.Add "Full_Image", Full_Image
			.Add "Thumbnail_Image", Thumbnail_Image
			.Add "Description", Description
			.Add "Search_Terms", Search_Terms
			.Add "ReservedForFutureUse", ReservedForFutureUse
	        .Add "base", base
			
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
			tmpProduct.SKU = Field(PrNode, "SKU")
			tmpProduct.Name = Field(PrNode, "Name")
			tmpProduct.URL = Field(PrNode, "URL") 
			tmpProduct.Price = Field(PrNode, "Price")
			tmpProduct.RetailPrice = Field(PrNode, "RetailPrice")
			tmpProduct.Photos_Cloned_From = Field(PrNode, "Photos_Cloned_From")
			tmpProduct.Full_Image = Field(PrNode, "Full_Image")
			tmpProduct.Thumbnail_Image = Field(PrNode, "Thumbnail_Image")
			tmpProduct.Description = Field(PrNode, "Description")
			tmpProduct.Search_Terms = Field(PrNode, "Search_Terms")
			tmpProduct.ReservedForFutureUse = Field(PrNode, "ReservedForFutureUse")
			tmpProduct.base = Field(PrNode, "base")
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