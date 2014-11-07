<%@LANGUAGE="VBSCRIPT.Encode"%>

<!-- #include file="includes/configuration.inc.asp" -->
<!-- #include file="includes/vbscript_extensions.inc.asp" -->
<!-- #include file="includes/volusion_api_call.inc.asp" -->
<!-- #include file="includes/subscriber.inc.asp" -->
<%
Dim Collector 'As ProductsCollector
Dim result 'As String
Dim thefso, f 


'Missing the cache, lets create it
Set Collector = New OrderTrackingCollector
Collector.DomainName = CONFIGURATION_DOMAIN_NAME
Collector.UserName = CONFIGURATION_USER_NAME
Collector.Password = CONFIGURATION_PASSWORD
Collector.UseSSL = CONFIGURATION_USE_SSL
Collector.InstallPath = Server.MapPath(CONFIGURATION_INSTALL_PATH)
Collector.DestinationPath = Server.MapPath(CONFIGURATION_DESTINATION_PATH)
 
result = Collector.RetrievePt()
 



	Set Collector = Nothing
	

%>


