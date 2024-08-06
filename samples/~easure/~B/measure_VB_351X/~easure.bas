Attribute VB_Name = "Module1"
Sub Main()

  Dim stat  As ViStatus
  Dim dfltRM As ViSession
  Dim sesn As ViSession
  Dim fList As ViFindList
  Dim desc As String * VI_FIND_BUFLEN
  Dim nList As Long
  Dim ret As Long
  Dim readin As String * 64

  stat = viOpenDefaultRM(dfltRM)
  If (stat < VI_SUCCESS) Then
    'Rem Error initializing VISA ... exiting
    MsgBox "USBTMC resource not found.", vbExclamation, "Multimeter device test"
    Exit Sub
  End If

  Rem Find all Multimeter USBTMC instruments in the system
  stat = viFindRsrc(dfltRM, "USB[0-9]*::0x164E::0x0DB[6-7]::?*INSTR", fList, nList, desc)
  If (stat < VI_SUCCESS) Then
    'Rem Error finding resources ... exiting
    MsgBox "Multimeter device not found.", vbExclamation, "Multimeter device test"
    viClose (dfltRM)
    Exit Sub
  End If
  
  Rem Open a session to each and determine if it matches
  stat = viOpen(dfltRM, desc, VI_NULL, VI_NULL, sesn)
  If (stat < VI_SUCCESS) Then
      MsgBox "Open device failed.", vbExclamation, "Multimeter device test"
      stat = viClose(fList)
      Exit Sub
  End If
  Rem send reset command '*RST' -- reset 2100
  stat = viWrite(sesn, "*RST", 4, ret)
  If (stat < VI_SUCCESS) Then
    MsgBox "System command error. (*RST)", vbExclamation, "Multimeter device test"
    stat = viClose(fList)
    Exit Sub
  End If
  Rem send Clear command '*CLS'-- Clear 2100 status register
  stat = viWrite(sesn, "*CLS", 4, ret)
  If (stat < VI_SUCCESS) Then
    MsgBox "System command error. (*CLS)", vbExclamation, "Multimeter device test"
    stat = viClose(fList)
    Exit Sub
  End If

  Rem send measure command -- Set to 0.1 volt dc range
  stat = viWrite(sesn, "meas:volt:DC? 0.1,0.01", 22, ret)
  If (stat < VI_SUCCESS) Then
    MsgBox "System command error. (meas:volt:dc? ...)", vbExclamation, "Multimeter device test"
    stat = viClose(fList)
    Exit Sub
  End If

  Rem fetch the measure data
  stat = viRead(sesn, readin, 64, ret)
  If (stat < VI_SUCCESS) Then
    MsgBox "Read in data error.", vbExclamation, "Multimeter device test"
    stat = viClose(fList)
    Exit Sub
  End If

  Debug.Print "Rdg = "; readin

  Rem set to local mode
  stat = viWrite(sesn, "system:local", 12, ret)
  If (stat < VI_SUCCESS) Then
    MsgBox "System command error. (system:local)", vbExclamation, "Multimeter device test"
    stat = viClose(fList)
    Exit Sub
  End If

  stat = viClose(sesn)
  stat = viClose(fList)
  stat = viClose(dfltRM)

  MsgBox "End of Job."
  
End Sub
