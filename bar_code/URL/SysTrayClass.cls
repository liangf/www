VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 1  'vbDataSource
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "SysTrayClass"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'general declarations, types, and constants for working with the system tray
Private Declare Function Shell_NotifyIcon Lib "shell32" Alias "Shell_NotifyIconA" (ByVal dwMessage As Long, pnid As NOTIFYICONDATA) As Boolean

Private Const NIM_ADD = &H0
Private Const NIM_MODIFY = &H1
Private Const NIM_DELETE = &H2
Private Const WM_MOUSEMOVE = &H200
Private Const NIF_MESSAGE = &H1
Private Const NIF_ICON = &H2
Private Const NIF_TIP = &H4

Private Type RECT
        Left As Long
        Top As Long
        Right As Long
        Bottom As Long
End Type

Private Type NOTIFYICONDATA
    cbSize As Long
    mhWnd As Long
    uId As Long
    uFlags As Long
    ucallbackMessage As Long
    hIcon As Long
    szTip As String * 64
    tzRect As RECT
End Type

Dim TheForm As NOTIFYICONDATA
Public Function AddToTray(lPic As PictureBox, lToolTipText As String)
TheForm.cbSize = Len(TheForm)
    'set out handle and picture
    ' to that of form1.picture1
    TheForm.mhWnd = lPic.hwnd
    TheForm.hIcon = lPic.Picture
    
    TheForm.uId = 1&
    
    TheForm.uFlags = NIF_ICON Or NIF_TIP Or NIF_MESSAGE
    
    TheForm.ucallbackMessage = WM_MOUSEMOVE
    
    'set our tooltip text
    TheForm.szTip = lToolTipText & Chr$(0)
    
    'add the icon to the system tray
    Shell_NotifyIcon NIM_ADD, TheForm
End Function
Public Function ModifyTrayIcon(lPic As PictureBox, lToolTipText As String)
TheForm.cbSize = Len(TheForm)
    
    TheForm.mhWnd = lPic.hwnd
    TheForm.hIcon = lPic.Picture
    
    TheForm.uId = 1&
    
    TheForm.uFlags = NIF_ICON Or NIF_TIP Or NIF_MESSAGE
    
    TheForm.ucallbackMessage = WM_MOUSEMOVE
    
    TheForm.szTip = lToolTipText & Chr$(0)
    'modify the icon with a new picture
    'and/or tooltiptext as the case
    'may be
    Shell_NotifyIcon NIM_MODIFY, TheForm
End Function
Public Function RemoveFromTray()
    'remove the icon from the tray
    Shell_NotifyIcon NIM_DELETE, TheForm
End Function
