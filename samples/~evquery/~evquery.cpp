// devquery.cpp : Defines the entry point for the console application.
//
//  Call the NI-VISA library visa32.dll
//
//

#include "stdafx.h"
#include "visa.h"

//standard include for a Microsoft Visual C++ project
#include "stdio.h"
#include "windows.h"

void main(int argc, char* argv[])
{
	// TODO: Add your control notification handler code here
	
	HINSTANCE hUSBTMCLIB;             // for USBTMC HANDLE
    unsigned long m_defaultRM_usbtmc, m_instr_usbtmc;
	unsigned long m_findList_usbtmc;
	unsigned long m_nCount;
	ViStatus  status;
	int       m_Timeout = 7000;
	char      *pStrout;               // Write out data buffer 
	BYTE      pStrin[64];             // Read in data buffer
	int       len;
	ULONG     nWritten;
	ULONG  	  nRead = 0;
	char      buffer[256];
	char      instrDescriptor[256];

	// Load the NI-VISA library for USBTMC device
	hUSBTMCLIB = LoadLibrary ("visa32.dll"); 

	if (!hUSBTMCLIB)  
	{
		MessageBox(NULL, "NIVISA for USBTMC library not found.", "Multimeter device test", MB_OK); 
		return;
	}

	// Link the libraries
	signed long (__stdcall  *PviOpenDefaultRM_usb)	(unsigned long *vi);
	signed long (__stdcall  *PviFindRsrc_usb)		(unsigned long sesn, char *expr, unsigned long *vi,
												     unsigned long *retCnt, char far desc[]);
	signed long (__stdcall  *PviOpen_usb)			(unsigned long sesn, char *name, unsigned long mode,
							                         unsigned long timeout, unsigned long *vi);
	signed long (__stdcall  *PviClose_usb)			(unsigned long vi);
	signed long (__stdcall  *PviWrite_usb)			(unsigned long vi, unsigned char *name, unsigned long len,
													  unsigned long *retval);
	signed long (__stdcall  *PviRead_usb)			(unsigned long vi, unsigned char *name, unsigned long len,
												      unsigned long *retval);
	signed long (__stdcall  *PviSetAttribute_usb)	(unsigned long vi, unsigned long viAttr, unsigned long attrstat);


	PviOpenDefaultRM_usb  = (signed long (__stdcall*)(unsigned long*))GetProcAddress(hUSBTMCLIB, (LPCSTR)"viOpenDefaultRM");
	PviFindRsrc_usb       = (signed long (__stdcall*)(unsigned long, char*, unsigned long*,
								unsigned long*, char[]))GetProcAddress(hUSBTMCLIB, (LPCSTR)"viFindRsrc");
	PviClose_usb          = (signed long (__stdcall*)(unsigned long))GetProcAddress(hUSBTMCLIB, (LPCSTR)"viClose");
	PviOpen_usb		      = (signed long (__stdcall*)(unsigned long, char*, unsigned long,
                                unsigned long, unsigned long*))GetProcAddress(hUSBTMCLIB, (LPCSTR)"viOpen");
    PviWrite_usb	      = (signed long (__stdcall*)(unsigned long, unsigned char*, unsigned long,
                                unsigned long*))GetProcAddress(hUSBTMCLIB, (LPCSTR)"viWrite");
    PviRead_usb			  = (signed long (__stdcall*)(unsigned long, unsigned char*, unsigned long,
                                unsigned long*))GetProcAddress(hUSBTMCLIB, (LPCSTR)"viRead");
    PviSetAttribute_usb	  = (signed long (__stdcall*)(unsigned long, unsigned long, unsigned long))GetProcAddress(hUSBTMCLIB, (LPCSTR)"viSetAttribute");

    if (PviOpenDefaultRM_usb == NULL ||
	    PviFindRsrc_usb		 == NULL ||
	    PviClose_usb		 == NULL ||
	    PviOpen_usb			 == NULL ||
	    PviWrite_usb		 == NULL ||
	    PviRead_usb			 == NULL ||
	    PviSetAttribute_usb	 == NULL
		)  
	{
		FreeLibrary (hUSBTMCLIB);
		hUSBTMCLIB = NULL;
		MessageBox(NULL, "NIVISA for USBTMC library not ready.", "Multimeter device test", MB_OK); 
		return;
	}

	printf("\n ###### Start C++ Example program. ######\n");
	printf(" We check the Multimeter on USB port and\n");
	printf(" identify the first connected DMM device.\n\n");

	// Open Device -- Resource Manager
	status = PviOpenDefaultRM_usb(&m_defaultRM_usbtmc);
	if (status < 0L) 
	{
		PviClose_usb(m_defaultRM_usbtmc);
		hUSBTMCLIB = NULL;
		m_defaultRM_usbtmc = 0;
		MessageBox(NULL, "USBTMC resource not found.", "Multimeter device test", MB_OK); 
		return;
	}
	else
	{
		status = PviFindRsrc_usb (m_defaultRM_usbtmc, "USB[0-9]*::0x164E::0x0DAD::?*INSTR", &m_findList_usbtmc, &m_nCount, instrDescriptor);
		if (status < 0L) 
		{
			status = PviFindRsrc_usb (m_defaultRM_usbtmc, "USB[0-9]*::5710::3501::?*INSTR", &m_findList_usbtmc, &m_nCount, instrDescriptor);
			if (status < 0L) 
			{
				PviClose_usb(m_defaultRM_usbtmc);
				hUSBTMCLIB = NULL;
				m_defaultRM_usbtmc = 0;
			}
			else
			{
				PviOpen_usb(m_defaultRM_usbtmc, instrDescriptor, 0, 0, &m_instr_usbtmc);
				status = PviSetAttribute_usb(m_instr_usbtmc, VI_ATTR_TMO_VALUE, m_Timeout);
			}
		}
		else
		{
			PviOpen_usb(m_defaultRM_usbtmc, instrDescriptor, 0, 0, &m_instr_usbtmc);
			status = PviSetAttribute_usb(m_instr_usbtmc, VI_ATTR_TMO_VALUE, m_Timeout);
		}
	}

	if (!hUSBTMCLIB)
	{
		printf("Multimeter device connect failed.\n");
		return;
	}

	len = 64;
	pStrout = new char[len];
	ZeroMemory(pStrout, len);
	strcpy(pStrout, "*idn?");
	status = PviWrite_usb(m_instr_usbtmc, (unsigned char *)pStrout, 6, &nWritten);
	Sleep(30);
	if (status != VI_SUCCESS)
	{
		MessageBox(NULL, "Write to device error.", "Multimeter device test", MB_OK);
		PviClose_usb(m_defaultRM_usbtmc);
		hUSBTMCLIB = NULL;
		m_defaultRM_usbtmc = 0;
		return;
	}
	else
	{
		printf(" output : *IDN?\n");
	}
	Sleep(1000);
	// Read data from device
	len = 64;
	if (hUSBTMCLIB)
	{
		status = PviRead_usb(m_instr_usbtmc, pStrin, len, &nRead);
		if (nRead > 0)
		{
			for (len=0; len < (long) nRead; len++)
			{
				buffer[len] = pStrin[len];
			}
		}
		buffer[nRead] = '\0';
		printf(" input : %s\n\n",buffer);
	}

	// Set sample count to 1
	strcpy(pStrout, "SAMP:COUN 1");
	status = PviWrite_usb(m_instr_usbtmc, (unsigned char *)pStrout, 12, &nWritten);
	Sleep(30);

	// Set configure Voltage AC, range 0.1A
	strcpy(pStrout, "CONF:VOLT:AC 0.1,0.01");
	status = PviWrite_usb(m_instr_usbtmc, (unsigned char *)pStrout, 22, &nWritten);
	Sleep(3000);

	// Set configure frequency, range Auto
	strcpy(pStrout, "CONF:FREQ");
	status = PviWrite_usb(m_instr_usbtmc, (unsigned char *)pStrout, 10, &nWritten);
	Sleep(3000);

	// Set configure Current DC, range 0.1A
	strcpy(pStrout, "CONF:CURR:DC 1,0.01");
	status = PviWrite_usb(m_instr_usbtmc, (unsigned char *)pStrout, 20, &nWritten);
	Sleep(3000);

	// Set Voltage DC measure
	strcpy(pStrout, "CONF:VOLT:DC 0.1,0.1");
	status = PviWrite_usb(m_instr_usbtmc, (unsigned char *)pStrout, 21, &nWritten);
	Sleep(1000);

	// Send read command
	strcpy(pStrout, "READ?");
	status = PviWrite_usb(m_instr_usbtmc, (unsigned char *)pStrout, 6, &nWritten);
	Sleep(30);
	printf(" output : READ?\n");

	status = PviRead_usb(m_instr_usbtmc, pStrin, 64, &nRead);
	if (nRead > 0)
	{
		for (len=0; len < (long) nRead; len++)
		{
			buffer[len] = pStrin[len];
		}
	}
	buffer[nRead] = '\0';
	printf(" input : %s\n\n", buffer);

	// Set device to local mode
	strcpy(pStrout, "system:local");
	status = PviWrite_usb(m_instr_usbtmc, (unsigned char *)pStrout, 13, &nWritten);
	free(pStrout);

	// Close device
	if (!hUSBTMCLIB)
		return;
	m_nCount = 0;
	m_defaultRM_usbtmc = 0;
    FreeLibrary (hUSBTMCLIB);
	hUSBTMCLIB = NULL;

	return;
}
