Attribute VB_Name = "Module1"
Public Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)

Sub main()

  Rem #########################################
  Rem
  Rem    Using NI-VISA library visa32.dll
  Rem
  Rem    Set sample count 5 configuration and
  Rem    read the trigger
  Rem
  Rem #########################################
  
  Dim stat  As ViStatus
  Dim dfltRM As ViSession
  Dim sesn As ViSession
  Dim fList As ViFindList
  Dim desc As String * VI_FIND_BUFLEN
  Dim nList As Long
  Dim ret As Long
  Dim readin As String * 128
  Dim i As Integer      ' Array index
  
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
  
  Rem send command -- 50 ohm reference resistance
  stat = viWrite(sesn, "CALC:DBM:REF 50", 15, ret)
  If (stat < VI_SUCCESS) Then
    MsgBox "System command error.", vbExclamation, "Multimeter device test"
    stat = viClose(fList)
    Exit Sub
  End If
  Rem send command -- Set k2100 to 1 amp ac range
  stat = viWrite(sesn, "CONF:VOLT:AC 1,0.001", 20, ret)
  If (stat < VI_SUCCESS) Then
    MsgBox "System command error.", vbExclamation, "Multimeter device test"
    stat = viClose(fList)
    Exit Sub
  End If
  Rem send command -- Select 200 Hz (fast) ac filter
  stat = viWrite(sesn, "DET:BAND 200", 12, ret)
  If (stat < VI_SUCCESS) Then
    MsgBox "System command error.", vbExclamation, "Multimeter device test"
    stat = viClose(fList)
    Exit Sub
  End If
  Rem send command -- k2100 will accept 5 triggers
  stat = viWrite(sesn, "SAMP:COUN 5", 11, ret)
  If (stat < VI_SUCCESS) Then
    MsgBox "System command error.", vbExclamation, "Multimeter device test"
    stat = viClose(fList)
    Exit Sub
  End If
  Rem send command -- Trigger source is IMMediate
  stat = viWrite(sesn, "TRIG:SOUR IMM", 13, ret)
  If (stat < VI_SUCCESS) Then
    MsgBox "System command error.", vbExclamation, "Multimeter device test"
    stat = viClose(fList)
    Exit Sub
  End If
  Rem send command -- Select dBm function
  stat = viWrite(sesn, "CALC:FUNC DBM", 13, ret)
  If (stat < VI_SUCCESS) Then
    MsgBox "System command error.", vbExclamation, "Multimeter device test"
    stat = viClose(fList)
    Exit Sub
  End If
  
  Rem send command -- Enable math
  stat = viWrite(sesn, "CALC:STAT ON", 12, ret)
  If (stat < VI_SUCCESS) Then
    MsgBox "System command error.", vbExclamation, "Multimeter device test"
    stat = viClose(fList)
    Exit Sub
  End If
  
  Rem send command -- Take readings
  stat = viWrite(sesn, "READ?" & vbLf, 6, ret)
  If (stat < VI_SUCCESS) Then
    MsgBox "System command error.", vbExclamation, "Multimeter device test"
    stat = viClose(fList)
    Exit Sub
  End If

  Sleep (3000)  ' wait for math processing
    
  Rem fetch the measure data
  stat = viRead(sesn, readin, 128, ret)
  If (stat < VI_SUCCESS) Then
    MsgBox "Read in data error.", vbExclamation, "Multimeter device test"
    stat = viClose(fList)
    Exit Sub
  End If
   
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

  Rem print out the 5 times samples reading
  For i = 0 To (5 - 1)
    Debug.Print "Rdgs = "; Mid(readin, i * 16 + 1, 15)
  Next

  MsgBox "End of Job."

End Sub
