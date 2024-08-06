VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   3195
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   ScaleHeight     =   3195
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command1 
      Caption         =   "Command1"
      Height          =   735
      Left            =   1200
      TabIndex        =   0
      Top             =   1320
      Width           =   1455
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()

  Dim aa As Object
  Dim i, j As Integer
  Dim ret As String
  Dim rr
  
  ' assign aa to DMM object
  Set aa = CreateObject("ins003.IOUTils")
  
  aa.Refresh
  
  ' Check the DMM device count
  If aa.Count > 0 Then
    Debug.Print " DMM.count = "; aa.Count
    For j = 0 To aa.Count - 1
      ' assigned the connect object and set the timeout property
      aa.Index = j
      aa.TimeOut = 3000
      ' get the DMM address property
      Debug.Print " Dmm.address = "; aa.Address
      ' get the DMM id
      aa.Output = "*idn?"
      Debug.Print " DMM.input (*idn?) = "; aa.Input
      ' set the DMM configure
      aa.Output = "CONF:VOLT:DC"
      ' get the reading 10 times
      For i = 1 To 10
        aa.Output = "read?"
        Debug.Print i; "  "; aa.Input
      Next i
      ' using query statement
      rr = aa.Query("read?", ret)
      Debug.Print " DMM.query = "; ret
    Next j
  Else
    Debug.Print " DMM device not found."
  End If
  aa.Close
  
  MsgBox "End of test"

End Sub
