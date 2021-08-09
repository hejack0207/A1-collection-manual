# virt-win-reg(1)

libguestfs-1.44.1, 2021-03-31

.if n .ad l
.nh

<a name="name"></a>

# Name

virt-win-reg - Export and merge Windows Registry entries from a Windows guest

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" .Vb 1  virt-win-reg domname HKLM\ePath\eTo\eSubkey\*(Aq   virt-win-reg domname HKLM\ePath\eTo\eSubkey\*(Aq name   virt-win-reg domname HKLM\ePath\eTo\eSubkey\*(Aq @   virt-win-reg --merge domname [input.reg ...]   virt-win-reg [--options] disk.img ... # instead of domname .Ve
```

<a name="warning"></a>

# Warning

.IX Header "WARNING"
You must _not_ use \f(CW`virt-win-reg\*(C' with the _--merge_ option on live
virtual machines.  If you do this, you _will_ get irreversible disk
corruption in the \s-1VM.\s0  \f(CW`virt-win-reg\*(C' tries to stop you from doing
this, but doesn't catch all cases.

Modifying the Windows Registry is an inherently risky operation.  The format
is deliberately obscure and undocumented, and Registry changes
can leave the system unbootable.  Therefore when using the _--merge_
option, make sure you have a reliable backup first.

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
This program can export and merge Windows Registry entries from a
Windows guest.

The first parameter is the libvirt guest name or the raw disk image of
a Windows guest.

If _--merge_ is _not_ specified, then the chosen registry
key is displayed/exported (recursively).  For example:

.Vb 1
 $ virt-win-reg Windows7 HKEY_LOCAL_MACHINE\eSOFTWARE\eMicrosoft\*(Aq
.Ve

You can also display single values from within registry keys,
for example:

.Vb 3
 $ cvkey=HKLM\eSOFTWARE\eMicrosoft\eWindows NT\eCurrentVersion\*(Aq
 $ virt-win-reg Windows7 $cvkey ProductName
 Windows 7 Enterprise
.Ve

With _--merge_, you can merge a textual regedit file into
the Windows Registry:

.Vb 1
 $ virt-win-reg --merge Windows7 changes.reg
.Ve

<a name="s-1notes0"></a>

### \s-1NOTE\s0

.IX Subsection "NOTE"
This program is only meant for simple access to the registry.  If you
want to do complicated things with the registry, we suggest you
download the Registry hive files from the guest using **libguestfs**\|(3)
or **guestfish**\|(1) and access them locally, eg. using **hivex**\|(3),
**hivexsh**\|(1) or **hivexregedit**\|(1).

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **--help**  
  .IX Item "--help"
  Display brief help.
* **--version**  
  .IX Item "--version"
  Display version number and exit.
* **--debug**  
  .IX Item "--debug"
  Enable debugging messages.
* **-c \s-1URI\s0**  
  .IX Item "-c URI"
* **--connect \s-1URI\s0**  
  .IX Item "--connect URI"
  If using libvirt, connect to the given _\s-1URI\s0_.  If omitted, then we
  connect to the default libvirt hypervisor.
  .Sp
  If you specify guest block devices directly, then libvirt is not used
  at all.
* **--format** raw  
  .IX Item "--format raw"
  Specify the format of disk images given on the command line.  If this
  is omitted then the format is autodetected from the content of the
  disk image.
  .Sp
  If disk images are requested from libvirt, then this program asks
  libvirt for this information.  In this case, the value of the format
  parameter is ignored.
  .Sp
  If working with untrusted raw-format guest disk images, you should
  ensure the format is always specified.
* **--merge**  
  .IX Item "--merge"
  In merge mode, this merges a textual regedit file into the Windows
  Registry of the virtual machine.  If this flag is _not_ given then
  virt-win-reg displays or exports Registry entries instead.
  .Sp
  Note that _--merge_ is _unsafe_ to use on live virtual machines, and
  will result in disk corruption.  However exporting (without this flag)
  is always safe.
* **--encoding** UTF-16LE|ASCII  
  .IX Item "--encoding UTF-16LE|ASCII"
  When merging (only), you may need to specify the encoding for strings
  to be used in the hive file.  This is explained in detail in
  \s-1ENCODING STRINGS\*(R"\s0 in **Win::Hivex::Regedit**\|(3).
  .Sp
  The default is to use \s-1UTF-16LE,\s0 which should work with recent versions
  of Windows.
* **--unsafe-printable-strings**  
  .IX Item "--unsafe-printable-strings"
  When exporting (only), assume strings are \s-1UTF-16LE\s0 and print them as
  strings instead of hex sequences.  Remove the final zero codepoint
  from strings if present.
  .Sp
  This is unsafe and does not preserve the fidelity of strings in the
  original Registry for various reasons:
    * ·  
      Assumes the original encoding is \s-1UTF-16LE.\s0  \s-1ASCII\s0 strings and strings
      in other encodings will be corrupted by this transformation.
    * ·  
      Assumes that everything which has type 1 or 2 is really a string
      and that everything else is not a string, but the type field in
      real Registries is not reliable.
    * ·  
      Loses information about whether a zero codepoint followed the string
      in the Registry or not.
      .Sp
      This all happens because the Registry itself contains no information
      about how strings are encoded (see
      \s-1ENCODING STRINGS\*(R"\s0 in **Win::Hivex::Regedit**\|(3)).
      .Sp
      You should only use this option for quick hacking and debugging of the
      Registry contents, and _never_ use it if the output is going to be
      passed into another program or stored in another Registry.

<a name="supported-systems"></a>

# Supported Systems

.IX Header "SUPPORTED SYSTEMS"
The program currently supports Windows NT-derived guests starting with
Windows \s-1XP\s0 through to at least Windows 8.

The following Registry keys are supported:
.ie n .IP """HKEY_LOCAL_MACHINE\eSAM""" 4
.el .IP "\f(CWHKEY\_LOCAL\_MACHINE\eSAM" 4
.IX Item "HKEY_LOCAL_MACHINESAM"
.ie n .IP """HKEY_LOCAL_MACHINE\eSECURITY""" 4
.el .IP "\f(CWHKEY\_LOCAL\_MACHINE\eSECURITY" 4
.IX Item "HKEY_LOCAL_MACHINESECURITY"
.ie n .IP """HKEY_LOCAL_MACHINE\eSOFTWARE""" 4
.el .IP "\f(CWHKEY\_LOCAL\_MACHINE\eSOFTWARE" 4
.IX Item "HKEY_LOCAL_MACHINESOFTWARE"
.ie n .IP """HKEY_LOCAL_MACHINE\eSYSTEM""" 4
.el .IP "\f(CWHKEY\_LOCAL\_MACHINE\eSYSTEM" 4
.IX Item "HKEY_LOCAL_MACHINESYSTEM"
.ie n .IP """HKEY_USERS\e.DEFAULT""" 4
.el .IP "\f(CWHKEY\_USERS\e.DEFAULT" 4
.IX Item "HKEY_USERS.DEFAULT"
.ie n .IP """HKEY\_USERS\e_SID_""" 4
.el .IP "\f(CWHKEY\_USERS\e\f(CISID\f(CW" 4
.IX Item "HKEY_USERSSID"
where _\s-1SID\s0_ is a Windows User \s-1SID\s0 (eg. \f(CW`S-1-5-18\*(C').
.ie n .IP """HKEY\_USERS\e_username_""" 4
.el .IP "\f(CWHKEY\_USERS\e\f(CIusername\f(CW" 4
.IX Item "HKEY_USERSusername"
where _username_ is a local user name (this is a libguestfs extension).

You can use \f(CW`HKLM\*(C' as a shorthand for \f(CW\*(C\`HKEY\_LOCAL\_MACHINE\*(C', and
\f(CW`HKU\*(C' for \f(CW\*(C\`HKEY\_USERS\*(C'.

The literal keys \f(CW`HKEY\_USERS\e$SID\*(C' and \f(CW\*(C\`HKEY\_CURRENT\_USER\*(C' are not
supported (there is no current user\*(R").

<a name="s-1windows-8s0"></a>

### \s-1WINDOWS 8\s0

.IX Subsection "WINDOWS 8"
Windows 8 fast startup\*(R" can prevent virt-win-reg from being
able to edit the Registry.  See
\s-1WINDOWS HIBERNATION AND WINDOWS 8 FAST STARTUP\*(R"\s0 in **guestfs**\|(3).

<a name="encoding"></a>

# Encoding

.IX Header "ENCODING"
\f(CW`virt-win-reg\*(C' expects that regedit files have already been reencoded
in the local encoding.  Usually on Linux hosts, this means \s-1UTF-8\s0 with
Unix-style line endings.  Since Windows regedit files are often in
\s-1UTF-16LE\s0 with Windows-style line endings, you may need to reencode the
whole file before or after processing.

To reencode a file from Windows format to Linux (before processing it
with the _--merge_ option), you would do something like this:

.Vb 1
 iconv -f utf-16le -t utf-8 &lt; win.reg | dos2unix &gt; linux.reg
.Ve

To go in the opposite direction, after exporting and before sending
the file to a Windows user, do something like this:

.Vb 1
 unix2dos linux.reg | iconv -f utf-8 -t utf-16le &gt; win.reg
.Ve

For more information about encoding, see **Win::Hivex::Regedit**\|(3).

If you are unsure about the current encoding, use the **file**\|(1)
command.  Recent versions of Windows regedit.exe produce a \s-1UTF-16LE\s0
file with Windows-style (\s-1CRLF\s0) line endings, like this:

.Vb 3
 $ file software.reg
 software.reg: Little-endian UTF-16 Unicode text, with very long lines,
 with CRLF line terminators
.Ve

This file would need conversion before you could _--merge_ it.

<a name="currentcontrolset-etc"></a>

# Currentcontrolset Etc.

.IX Header "CurrentControlSet etc."
Registry keys like \f(CW`CurrentControlSet\*(C' don’t really exist in the
Windows Registry at the level of the hive file, and therefore you
cannot modify these.

\f(CW`CurrentControlSet\*(C' is usually an alias for \f(CW\*(C\`ControlSet001\*(C'.  In
some circumstances it might refer to another control set.  The way
to find out is to look at the \f(CW`HKLM\eSYSTEM\eSelect\*(C' key:

.Vb 6
 # virt-win-reg WindowsGuest HKLM\eSYSTEM\eSelect\*(Aq
 [HKEY_LOCAL_MACHINE\eSYSTEM\eSelect]
 "Current"=dword:00000001
 "Default"=dword:00000001
 "Failed"=dword:00000000
 "LastKnownGood"=dword:00000002
.Ve

Current\*(R" is the one which Windows will choose when it boots.

Similarly, other \f(CW`Current...\*(C' keys in the path may need to
be replaced.

<a name="deleting-registry-keys-and-values"></a>

# Deleting Registry Keys and Values

.IX Header "DELETING REGISTRY KEYS AND VALUES"
To delete a whole registry key, use the syntax:

.Vb 1
 [-HKEY_LOCAL_MACHINE\eFoo]
.Ve

To delete a single value within a key, use the syntax:

.Vb 2
 [HKEY_LOCAL_MACHINE\eFoo]
 "Value"=-
.Ve

<a name="windows-tips"></a>

# Windows Tips

.IX Header "WINDOWS TIPS"
Note that some of these tips modify the guest disk image.  The guest
_must_ be shut off, else you will get disk corruption.

<a name="s-1running-a-batch-script-when-a-user-logs-ins0"></a>

### \s-1RUNNING A BATCH SCRIPT WHEN A USER LOGS IN\s0

.IX Subsection "RUNNING A BATCH SCRIPT WHEN A USER LOGS IN"
Prepare a \s-1DOS\s0 batch script, VBScript or executable.  Upload this using
**guestfish**\|(1).  For this example the script is called \f(CW`test.bat\*(C'
and it is uploaded into \f(CW`C:\e\*(C':

.Vb 1
 guestfish -i -d WindowsGuest upload test.bat /test.bat
.Ve

Prepare a regedit file containing the registry change:

.Vb 4
 cat &gt; test.reg &lt;&lt;EOF\*(Aq
 [HKLM\eSoftware\eMicrosoft\eWindows\eCurrentVersion\eRunOnce]
 "Test"="c:\e\etest.bat"
 EOF
.Ve

In this example we use the key \f(CW`RunOnce\*(C' which means that the script
will run precisely once when the first user logs in.  If you want it
to run every time a user logs in, replace \f(CW`RunOnce\*(C' with \f(CW\*(C\`Run\*(C'.

Now update the registry:

.Vb 1
 virt-win-reg --merge WindowsGuest test.reg
.Ve

<a name="s-1installing-a-services0"></a>

### \s-1INSTALLING A SERVICE\s0

.IX Subsection "INSTALLING A SERVICE"
This section assumes you are familiar with Windows services, and you
either have a program which handles the Windows Service Control
Protocol directly or you want to run any program using a service
wrapper like SrvAny or the free RHSrvAny.

First upload the program and optionally the service wrapper.  In this
case the test program is called \f(CW`test.exe\*(C' and we are using the
RHSrvAny wrapper:

.Vb 4
 guestfish -i -d WindowsGuest &lt;&lt;EOF
   upload rhsrvany.exe /rhsrvany.exe
   upload test.exe /test.exe
 EOF
.Ve

Prepare a regedit file containing the registry changes.  In this
example, the first registry change is needed for the service itself or
the service wrapper (if used).  The second registry change is only
needed because I am using the RHSrvAny service wrapper.

.Vb 8
 cat &gt; service.reg &lt;&lt;EOF\*(Aq
 [HKLM\eSYSTEM\eControlSet001\eservices\eRHSrvAny]
 "Type"=dword:00000010
 "Start"=dword:00000002
 "ErrorControl"=dword:00000001
 "ImagePath"="c:\e\erhsrvany.exe"
 "DisplayName"="RHSrvAny"
 "ObjectName"="NetworkService"
 
 [HKLM\eSYSTEM\eControlSet001\eservices\eRHSrvAny\eParameters]
 "CommandLine"="c:\e\etest.exe"
 "PWD"="c:\e\eTemp"
 EOF
.Ve

Notes:

* ·  
  For use of \f(CW`ControlSet001\*(C' see the section above in this manual page.
  You may need to adjust this according to the control set that is in
  use by the guest.
* ·  
  \f(CW"ObjectName" controls the privileges that the service will have.
  An alternative is \f(CW"ObjectName"="LocalSystem" which would be the
  most privileged account.
* ·  
  For the meaning of the magic numbers, see this Microsoft \s-1KB\s0 article:
  http://support.microsoft.com/kb/103000.

Update the registry:

.Vb 1
 virt-win-reg --merge WindowsGuest service.reg
.Ve

<a name="shell-quoting"></a>

# Shell Quoting

.IX Header "SHELL QUOTING"
Be careful when passing parameters containing \f(CW`\e\*(C' (backslash) in the
shell.  Usually you will have to use 'single quotes' or double
backslashes (but not both) to protect them from the shell.

Paths and value names are case-insensitive.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**hivex**\|(3),
**hivexsh**\|(1),
**hivexregedit**\|(1),
**guestfs**\|(3),
**guestfish**\|(1),
**virt-cat**\|(1),
**virt-tail**\|(1),
**Sys::Guestfs**\|(3),
**Win::Hivex**\|(3),
**Win::Hivex::Regedit**\|(3),
**Sys::Virt**\|(3),
http://libguestfs.org/.

<a name="author"></a>

# Author

.IX Header "AUTHOR"
Richard W.M. Jones http://people.redhat.com/~rjones/

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright (C) 2010 Red Hat Inc.

<a name="license"></a>

# License

.IX Header "LICENSE"
This program is free software; you can redistribute it and/or modify it
under the terms of the \s-1GNU\s0 General Public License as published by the
Free Software Foundation; either version 2 of the License, or (at your
option) any later version.

This program is distributed in the hope that it will be useful, but
\s-1WITHOUT ANY WARRANTY\s0; without even the implied warranty of
\s-1MERCHANTABILITY\s0 or \s-1FITNESS FOR A PARTICULAR PURPOSE.\s0  See the \s-1GNU\s0
General Public License for more details.

You should have received a copy of the \s-1GNU\s0 General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, \s-1MA 02110-1301 USA.\s0

<a name="bugs"></a>

# Bugs

.IX Header "BUGS"
To get a list of bugs against libguestfs, use this link:
https://bugzilla.redhat.com/buglist.cgi?component=libguestfs&product=Virtualization+Tools

To report a new bug against libguestfs, use this link:
https://bugzilla.redhat.com/enter_bug.cgi?component=libguestfs&product=Virtualization+Tools

When reporting a bug, please supply:

* ·  
  The version of libguestfs.
* ·  
  Where you got libguestfs (eg. which Linux distro, compiled from source, etc)
* ·  
  Describe the bug accurately and give a way to reproduce it.
* ·  
  Run **libguestfs-test-tool**\|(1) and paste the **complete, unedited**
  output into the bug report.
