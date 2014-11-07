*******************************************************************
*                          TALtech, Inc.                          *
*                     WinWedge2URL (v1.1) for                     *
*                     WinWedge 32 Standard/Pro                    *
*                                                                 *
*         Copyright (C) 2001 Taltech, Inc. All Rights Reserved.   *
*                                                                 *
*******************************************************************

NOTE: Before using this package please read this entire document! 

------------------------------------------
CONTENTS
------------------------------------------
- Introduction
- Requirements
- Installation
- Usage
- Technical Support
- License Agreement
- Updates (bug fixes, To do, etc.)

------------------------------------------
INTRODUCTION
------------------------------------------
This Program makes it possible to use TALtech's WinWedge Software to send data
from any compatible RS-232 Serial device to an ASP Page.

------------------------------------------
REQUIREMENTS
------------------------------------------

- PC running Windows 3x/9x/NT/2000/XP
- ASP compatible Webserver e.g, Personal WebServer 4.0 or IIS 4.0 or later
- An available RS-232 Serial Port
- WinWedge v1.2 or later from TALtech, Inc.
- Compatible RS-232 Serial device
- Microsoft Visual Basic 6.0 or later (to view, modify and recompile project files)
- Internet Explorer 4.0 or later (recommended) or other Web Browser

------------------------------------------
INSTALLATION
------------------------------------------
In this package the following files should be present:

- Readme.txt (this file)
- Form1.frm (VB Form)
- Form1.frx (VB6 file)
- Project1.vbp (VB6 Project file)
- Project1.vbw (VB6 file)
- Module1.bas (VB Module)
- SysTrayClass.cls (VB Class module)
- Wedge2URL.exe (Compiled application)
- Setup.ini (settings file)
- Multi_Field.asp (ASP file for parsing multiple data fields)
- Wedge2URL.asp (ASP file for single data fields)

The files will be automatically unzipped into the folder "C:\Wedge2URL".

N.B: Copy the ASP files onto your webserver.

------------------------------------------
USAGE
------------------------------------------

Summary
=======

1. Set up WinWedge. 
2. Change the Com port and URL information in the Setup.ini file. 
3. Launch WinWedge (Activated) 
4. Launch Wedge2URL.exe 
5. Transmit data from your serial Device 
6. Your Default Web browser should open displaying your data 

Set up WinWedge.
================
Simply configure the data record structure in WinWedge to parse and filter your data. 
In the example below we are assuming that there is a single field of data terminating 
in a carriage return.

Note: Because WinWedge always behaves as a DDE Server regardless of which mode you 
choose, you can use the example below in Keystrokes mode, DDE Mode or Log to disk mode 
(Pro version only). This means that not only can you update your ASP Page but at the 
same time you can record your data in Excel, or notepad, or a log file!

Modify the Setup.ini file.
==========================

The format described here is an implementation of the ".INI File Format", as defined 
in the Microsoft Windows for Workgroups Resource Kit. An INI file is a text file divided 
into sections, each containing zero or more keys. Each key contains zero or more values.

Example:

[SectionName]
keyname=value
;comment
keyname=value, value, value ;comment

Section names are enclosed in square brackets, and must begin at the beginning of a line. 
Section and key names are case-insensitive, and cannot contain spacing characters. The 
key name is followed by an equal sign ("="), optionally surrounded by spacing characters, 
which are ignored. If the same section appears more than once in the same file, or if the 
same key appears more than once in the same section, then the last occurrence prevails. 
Multiple values for a key are separated by a comma followed by at least one spacing 
character.

The Setup.ini file for Wedge2URL looks like:

[Startup]
URL=http://www.mysite.com/wedge2url.asp?wedgedata=
ComPort=Com1

The URL should include the full http path to your asp file, the asp filename followed 
by a question mark ("?"). If you have only one field you can specify a variable name 
like "Wedgedata" above to represent the value of that field. If your have defined more 
than 1 field in WinWedge, you can either hardcode the variable names in the Visual 
Basic program, or reconfigure WinWedge to send just a single field of data and parse it 
out in your ASP code. See the section on Dealing with Multiple Data Fields for more 
information.

Launch WinWedge
===============

Set Up WinWedge to work with your RS-232 Device as described in the WinWedge Manual's
"Quick Start Guide", Then Activate it in Test Mode, Normal Mode or Virtual Instrument 
Mode (Not available on all versions).

Launch Wedge2URL.exe
====================

Double click on the program file to launch it. WinWedge MUST be Activated First!
 
Transmit data from your serial Device
=====================================

How this happens will depend on the device you have connected - check in the documentation
for your device.

Your Default Web browser should open displaying your data
=========================================================

If WinWedge is properly configured and you specified accurate parameters in the Setup.ini
file, then when the data changes your Web Browser should open or be updated with the data
from your Serial device

------------------------------------------
TECHNICAL SUPPORT
------------------------------------------

- For help with WinWedge or Wedge2URL please contact TALtech, Inc.
  Website: http://www.taltech.com/TALtech_web/support/swkb.htm
  E-mail: support@taltech.com 
  TEL: (215) 763-5096.
  Fax: 215-763 9711
  Mailing Address: TAL Technologies, Inc.
		   2027 Wallace Street,
		   Philadelphia, PA 19130-3221, USA 

------------------------------------------
END USER LICENSE AGREEMENT
------------------------------------------
 
By installing and using Wedge2URL and associated files you are agreeing to 
the terms set forth in this license agreement.

Wedge2URL is FREEWARE and cannot be sold. This restriction does not apply to connect 
time charges, or flat rate connection/download fees for electronic bulletin 
board services.

The VB code in the Project files is not locked and you are free to add to and modify 
the code, any icons, menus, or displays associated with the software, and the 
associated files as you require.

You are granted the right to use and to make an unlimited number of copies of this 
software but it is to be redistributed only if the entire program and documentation 
remain unchanged in any way. All files included with Wedge2URL and all documentation 
must be redistributed together.

This software can not be bundled with any commercial package or accompanying books or 
magazines without express written permission from TALtech, Inc.

THE PROGRAM AND ACCOMPANYING MATERIALS ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, 
EITHER EXPRESS OR IMPLIED. THE AUTHORS OF WEDGE2URL DO NOT WARRANT THAT THE FUNCTIONS 
CONTAINED IN THE PROGRAM WILL MEET YOUR REQUIREMENTS OR THAT THE OPERATION WILL 
BE UNINTERRUPTED OR ERROR FREE. THE ENTIRE RISK AS TO THE USE, QUALITY, AND PERFORMANCE 
OF THE PROGRAM IS WITH YOU THE USER.

IN NO EVENT WILL THE AUTHORS OF WEDGE2URL BE LIABLE FOR ANY CONSEQUENTIAL, 
INCIDENTAL, SPECIAL OR INDIRECT DAMAGES, INCLUDING LOSS OF DATA, LOST  PROFITS, LOSS OF 
WORK, OR LOST SAVINGS ARISING FROM THE USE OF THE PROGRAM OR ANY OF ITS ACCOMPANYING 
MATERIALS, HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY.

BY INSTALLING AND USING WEDGE2URL AND ASSOCIATED FILES YOU ARE AGREEING TO 
THE TERMS OF THIS LICENSE AGREEMENT.

------------------------------------------
UPDATES
------------------------------------------

v1.1 - November 19 2001:
=========================

- Added Program Icon
- Added code to enable the program to minimize to the System tray.
- Added sample ASP code for single and multiple fields of data.
- Provided supporting documentation.

v1.0 - November 14 2001:
========================

- 1st beta version released.