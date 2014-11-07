Attribute VB_Name = "Module1"

'**************************************
' Date: November 13th 2001
' Author: Rob Williams (rob@taltech.com)
' Purpose: To take data from WinWedge, append it to a URL and open a Browser with that URL
'**************************************

'Declare Windows APIs:

Declare Function ShellExecute Lib "shell32.dll" _
Alias "ShellExecuteA" _
(ByVal hwnd As Long, _
ByVal lpOperation As String, _
ByVal lpFile As String, _
ByVal lpParameters As String, _
ByVal lpDirectory As String, _
ByVal nShowCmd As Long) As Long



Declare Function WritePrivateProfileString Lib "kernel32" Alias _
"WritePrivateProfileStringA" (ByVal lpApplicationName As String, ByVal _
lpKeyName As Any, ByVal lpString As Any, ByVal lpFileName As String) As _
Long

Declare Function GetPrivateProfileString Lib "kernel32" _
Alias "GetPrivateProfileStringA" (ByVal lpApplicationName As String, ByVal _
lpKeyName As Any, ByVal lpDefault As String, ByVal lpReturnedString As _
String, ByVal nSize As Long, ByVal lpFileName As String) As Long

'general constants for mouse events
Public Const WM_LBUTTONDOWN = &H201
Public Const WM_LBUTTONUP = &H202
Public Const WM_LBUTTONDBLCLK = &H203
Public Const WM_RBUTTONDBLCLK = &H206
Public Const WM_RBUTTONDOWN = &H204
Public Const WM_RBUTTONUP = &H205
Public Const WM_MOUSEMOVE = &H200

Function mfncGetFromIni(strSectionHeader As String, strVariableName As _
    String, strFileName As String) As String
    '*** DESCRIPTION:Reads from an *.INI file strFileName (full path & file name)
    '*** RETURNS:The string stored in [strSectionHeader], line beginning strVariableName=
    '*** NOTE: Requires declaration of API call GetPrivateProfileString
    'Initialise variable
    Dim strReturn As String
    'Blank the return string
    strReturn = String(255, Chr(0))
    'Get requested information, trimming the
    '     returned string
    mfncGetFromIni = Left$(strReturn, _
    GetPrivateProfileString(strSectionHeader, ByVal strVariableName, "", _
    strReturn, Len(strReturn), strFileName))
End Function


Function mfncParseString(strIn As String, intOffset As Integer, _
    strDelimiter As String) As String
    '*** DESCRIPTION:Parses the passed string, returning the value indicated
    '***by the offset specified, eg: the string "Hello, World ","
    '***offset 2 = "World".
    '*** RETURNS:See description.
    '*** NOTE: The offset starts at 1 and the delimiter is the Character
    '***which separates the elements of the string.
    
    
    'Trap any bad calls
    If Len(strIn) = 0 Or intOffset = 0 Then
        mfncParseString = ""
        Exit Function
    End If
    
    'Declare local variables
    Dim intStartPos As Integer
    ReDim intDelimPos(10) As Integer
    Dim intStrLen As Integer
    Dim intNoOfDelims As Integer
    Dim intCount As Integer
    Dim strQuotationMarks As String
    Dim intInsideQuotationMarks As Integer
    strQuotationMarks = Chr(34) & Chr(147) & Chr(148)
    intInsideQuotationMarks = False

    For intCount = 1 To Len(strIn)
        'If character is a double-quote then toggle the In Quotation flag

        If InStr(strQuotationMarks, Mid$(strIn, intCount, 1)) <> 0 Then
            intInsideQuotationMarks = (Not intInsideQuotationMarks)
        End If
        If (Not intInsideQuotationMarks) And (Mid$(strIn, intCount, 1) = _
        strDelimiter) Then
        intNoOfDelims = intNoOfDelims + 1
        'If array filled then enlarge it, keeping existing contents

        If (intNoOfDelims Mod 10) = 0 Then
            ReDim Preserve intDelimPos(intNoOfDelims + 10)
        End If
        intDelimPos(intNoOfDelims) = intCount
    End If
Next intCount
'Handle request for value not present (over-run)

If intOffset > (intNoOfDelims + 1) Then
    mfncParseString = ""
    Exit Function
End If
'Handle boundaries of string

If intOffset = 1 Then
    intStartPos = 1
End If

'Requesting last value - handle null
If intOffset = (intNoOfDelims + 1) Then

    If Right$(strIn, 1) = strDelimiter Then
        intStartPos = -1
        intStrLen = -1
        mfncParseString = ""
        Exit Function
    Else
        intStrLen = Len(strIn) - intDelimPos(intOffset - 1)
    End If
End If

'Set start and length variables if not handled by boundary check above
If intStartPos = 0 Then
    intStartPos = intDelimPos(intOffset - 1) + 1
End If

If intStrLen = 0 Then
    intStrLen = intDelimPos(intOffset) - intStartPos
End If

'Set the return string
mfncParseString = Mid$(strIn, intStartPos, intStrLen)
End Function


Function mfncWriteIni(strSectionHeader As String, strVariableName As _
    String, strValue As String, strFileName As String) As Integer
    '*** DESCRIPTION:Writes to an *.INI file called strFileName (full path & file name)
    '*** RETURNS:Integer indicating failure (0) or success (other) To write
    '*** NOTE: Requires declaration of API call WritePrivateProfileString
    
    'Call the API
    mfncWriteIni = WritePrivateProfileString(strSectionHeader, _
    strVariableName, strValue, strFileName)
End Function


Sub Main()
    '*** DESCRIPTION: Launches Default Browser with Custom URL
    Dim ExecPath As String, strStart, nResult, MyURL$
    Dim x As Long
    Dim D As String
    'Get the directory from where this code is executing.
    '(To retrieve values from setup.ini file stored in same
    'directory)
    ExecPath = App.Path 'IIf("/" = Mid(App.Path, Len(App.Path)), App.Path, App.Path & "\")
    If Right$(ExecPath, 1) <> "\" Then ExecPath = ExecPath & "\"
    
    'Read URL in from setup.ini
    MyURL$ = mfncGetFromIni("Startup", "URL", ExecPath & "Setup.ini")

    'Append Wedge data to URL
    strStart = "Start.exe " & MyURL$ & Form1.Text1.Text
    ' (Start.exe is a program that is part of the Windows
    ' Operating system that allows you to run a program by its
    ' associated extension. MyURL$ is the main part of the URL
    ' Specified in setup.ini:
    ' e.g., "Http://www.website.com/myfile.asp?Wedgedata="
    ' Form1.Text1.Text is the data from WinWedge.
    ' By concatenating all of these elements together we can use
    ' them in a shell command to launch the browser and open the
    ' page.
    
    ' Launch the Browser with the URL - vbhide hides the dos window
    ' that appears when start.exe is run
    nResult = Shell(strStart, vbHide)
    'nResult = ShellExecute(0, "open", strStart, vbNullString, vbNullString, 0)

    D = Left$(Form1.Text1.Text, InStr(Form1.Text1.Text, ","))
    Form1.Text1.LinkExecute "[sendout('" & D & "SUCCESS        ' ,13)]"
    
End Sub
