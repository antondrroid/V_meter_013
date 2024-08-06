Attribute VB_Name = "Module1"
Sub main()

  ' Set sample count 5 configuration and
  ' read the trigger

  Dim M3500A As Object
  Dim Rdgs As String
  Dim i As Integer ' Array Index
  ' To assign an object reference using CreateObject
  Set M3500A = CreateObject("INS001.IOUtils")

  M3500A.Refresh
  If M3500A.Count = 0 Then
    MsgBox "Connect M3500A device failed.", 48, "Configure sample"
    Exit Sub
  End If
  M3500A.Index = 0
  M3500A.TimeOut = 10000              ' Assign timeout period

  With M3500A
    .Output = "*RST"                  ' Reset M3500A
    .Output = "*CLS"                  ' Clear M3500A status registers
    .Output = "CALC:DBM:REF 50"       ' 50 ohm reference resistance
    .Output = "CONF:VOLT:AC 1,0.001"  ' Set M3500A to 1 amp ac range
    .Output = "DET:BAND 200"          ' Select 200 Hz (fast) ac filter
    .Output = "SAMP:COUN 5"           ' M3500A will accept 5 triggers
    .Output = "TRIG:SOUR IMM"         ' Trigger source is IMMediate
    .Output = "CALC:FUNC DBM"         ' Select dBm function
    .Output = "CALC:STAT ON"          ' Enable math
    .Output = "READ?"                 ' Take readings
    Rdgs = .Input
  End With

  For i = 0 To (5 - 1)     ' print out the 5 times samples reading
    Debug.Print "Rdgs = "; Mid(Rdgs, i * 16 + 1, 15)
  Next

End Sub


