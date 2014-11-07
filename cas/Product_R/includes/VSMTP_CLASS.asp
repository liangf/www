<%
Class vsmtp
	Public VsmtpKey
	Public EmailSubject
	Public EmailFrom
	Public EmailTo
	Public TextBody
	Public HTMLBody
	Private Attachment
	Private AttachmentFolder
	Public Sub AddAttachment(ByRef FilePath)
		If AttachmentFolder = "" Then
			AttachmentFolder = Server.MapPath("/v")
		End If
		If StrComp(Left(FilePath,Len(AttachmentFolder)),AttachmentFolder,vbTextCompare) = 0 Then
			FilePath = Replace(Mid(FilePath,Len(AttachmentFolder)-1),"\","/")
		End If
		If StrComp(Left(FilePath,3),"/v/",vbTextCompare) <> 0 Or InStr(FilePath,",") > 0 Then
			Err.Raise 512, "vsmtp.AddAttachment", "Invalid Attachment Path"
		End If
		If IsEmpty(Attachment) Then
			Attachment = FilePath
		Else
			Attachment = Attachment & "," & FilePath
		End If
	End Sub
	Public Sub Send()
		Dim HTTPRequest
		Set HTTPRequest = CreateObject("WinHTTP.WinHTTPRequest.5.1")
		HTTPRequest.Open "POST", "http://" & Request.ServerVariables("LOCAL_ADDR") & "/vsmtp.asp", False
		HTTPRequest.SetRequestHeader "Content-Type", "application/x-www-form-urlencoded"
		HTTPRequest.SetRequestHeader "Host", Request.ServerVariables("SERVER_NAME")
		HTTPRequest.Send _
			"VsmtpKey=" & Server.URLEncode(VsmtpKey) &_
			"&Subject=" & Server.URLEncode(EmailSubject) &_
			"&FromEmailAddress=" & Server.URLEncode(EmailFrom) &_
			"&ToEmailAddress=" & Server.URLEncode(EmailTo) &_
			"&Body_HTML=" & Server.URLEncode(HTMLBody) &_
			"&Body_TextOnly=" & Server.URLEncode(TextBody) &_
			"&Attachment_CSV=" & Server.URLEncode(Attachment)
		If HTTPRequest.ResponseText <> "True" Then
			Set HTTPRequest = Nothing
			Err.Raise 8, "vsmtp.Send", "Unable to send email. Check logs for details."
		End If
		Set HTTPRequest = Nothing
	End Sub
End Class
%>
