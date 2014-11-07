VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "WinWedge to URL"
   ClientHeight    =   1020
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4680
   Icon            =   "Form1.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   1020
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
   Begin VB.PictureBox Picture1 
      Height          =   375
      Left            =   0
      Picture         =   "Form1.frx":1272
      ScaleHeight     =   315
      ScaleWidth      =   315
      TabIndex        =   2
      Top             =   120
      Visible         =   0   'False
      Width           =   375
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Exit"
      Height          =   375
      Left            =   3120
      TabIndex        =   1
      Top             =   360
      Width           =   1215
   End
   Begin VB.TextBox Text1 
      Height          =   375
      Left            =   480
      TabIndex        =   0
      Top             =   360
      Width           =   2295
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'dimension our icon
Dim MyIcon As New SysTrayClass
Dim InTray As Boolean   'track when we are in tray

'Exit button
Private Sub Command1_Click()
    'Exit program
    Unload Me
End Sub

'Form load event
Private Sub Form_Load()
    Dim MyPort$, ExecPath
    
    'set up error trap
    On Error GoTo Error_Handler
    
    'Get the directory from where this code is executing.
'    ExecPath = IIf("/" = Mid(App.Path, Len(App.Path)), App.Path, App.Path & "\")
    ExecPath = App.Path
    If Right$(ExecPath, 1) <> "\" Then ExecPath = ExecPath & "\"

    
    'Get Com port from ini file
    MyPort$ = mfncGetFromIni("Startup", "ComPort", ExecPath & "Setup.ini")
    
    'Create DDE Link to WinWedge
    Text1.LinkTopic = "winwedge|" & MyPort$
    Text1.LinkItem = "field(1)"
    Text1.LinkMode = 1
    
Quit:
    Exit Sub
    
Error_Handler:
    If Err.Number = 282 Then 'WinWedge not activated
        MsgBox "WinWedge is not running and Activated, please Activate WinWedge and try again", vbExclamation
        Unload Me
    Else
        MsgBox Err.Number & " : " & Err.Description
        Resume Quit
    End If
End Sub

Private Sub Text1_Change()
    'When new data sent from WinWedge call Main sub routine
    If Text1.Text <> "" Then
        Module1.Main
    End If
End Sub

Private Sub Form_Resize()
    'hide our app in the task bar when we
    'minimize it
    If Me.WindowState = 1 Then
    MyIcon.AddToTray Me.Picture1, "Test"
    InTray = True
      'make sure we have a way to restore our form if there is
      'no icon in the tray this is a boolean variable
      'defined at the top of the code
      If InTray Then Me.Hide
    ElseIf Me.WindowState = 0 Then
        MyIcon.RemoveFromTray
    End If
End Sub
Private Sub Picture1_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
'this is where our icon picks up messages whilst in the system tray.
Static Rec As Boolean, Msg As Long
    Msg = x / Screen.TwipsPerPixelX
        Select Case Msg
            Case WM_LBUTTONDBLCLK:
                
            Case WM_LBUTTONDOWN:
                
            Case WM_LBUTTONUP:
                'show our app again
                Me.WindowState = 0
                Me.Show
            Case WM_RBUTTONDBLCLK:
                
            Case WM_RBUTTONDOWN:
                
            Case WM_RBUTTONUP:
                'MsgBox "Right Click"
                'use this event for a
                'popup menu
        End Select
End Sub

