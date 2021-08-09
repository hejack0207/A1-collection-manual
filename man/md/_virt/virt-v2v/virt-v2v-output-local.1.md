# virt-v2v-output-local(1)

virt-v2v-1.44.0, 2021-04-30

.if n .ad l
.nh

<a name="name"></a>

# Name

virt-v2v-output-local - Using virt-v2v to convert guests to local files
or libvirt

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" .Vb 1  virt-v2v [-i* options] [-o libvirt] -os POOL   virt-v2v [-i* options] -o local -os DIRECTORY   virt-v2v [-i* options] -o qemu -os DIRECTORY [--qemu-boot]   virt-v2v [-i* options] -o json -os DIRECTORY                         [-oo json-disks-pattern=PATTERN]   virt-v2v [-i* options] -o null .Ve
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
This page documents how to use **virt-v2v**\|(1) to convert guests to
local files or to a locally running libvirt instance.  There are four
output modes you can select on the virt-v2v command line:
.ie n .IP "**-o libvirt -os** ""POOL""" 4
.el .IP "**-o libvirt -os** \f(CWPOOL" 4
.IX Item "-o libvirt -os POOL"
.ie n .IP "**-os** ""POOL""" 4
.el .IP "**-os** \f(CWPOOL" 4
.IX Item "-os POOL"
This converts the guest to a libvirt directory pool call \f(CW`POOL\*(C', and
instantiates the guest in libvirt (but does not start it running).
See \s-1OUTPUT TO LIBVIRT\*(R"\s0 below.
.Sp
_-o libvirt_ is the default if no _-o_ option is given, so you can
omit it.
.ie n .IP "**-o local -os** ""DIRECTORY""" 4
.el .IP "**-o local -os** \f(CWDIRECTORY" 4
.IX Item "-o local -os DIRECTORY"
This converts the guest to files in \f(CW`DIRECTORY\*(C'.  A libvirt \s-1XML\s0 file
is also created, but unlike _-o libvirt_ the guest is not
instantiated in libvirt, only files are created.
.Sp
The files will be called:
.Sp
.Vb 2
 NAME-sda, NAME-sdb, etc.      Guest disk(s).
 NAME.xml                      Libvirt XML.
.Ve
.Sp
where \f(CW`NAME\*(C' is the guest name.
.ie n .IP "**-o qemu -os** ""DIRECTORY""" 4
.el .IP "**-o qemu -os** \f(CWDIRECTORY" 4
.IX Item "-o qemu -os DIRECTORY"
.ie n .IP "**-o qemu -os** ""DIRECTORY"" **--qemu-boot**" 4
.el .IP "**-o qemu -os** \f(CWDIRECTORY **--qemu-boot**" 4
.IX Item "-o qemu -os DIRECTORY --qemu-boot"
This converts the guest to files in \f(CW`DIRECTORY\*(C'.  Unlike _-o local_
above, a shell script is created which contains the raw qemu command
you would need to boot the guest.  However the shell script is not
run, _unless_ you also add the _--qemu-boot_ option.
.ie n .IP "**-o json -os** ""DIRECTORY""" 4
.el .IP "**-o json -os** \f(CWDIRECTORY" 4
.IX Item "-o json -os DIRECTORY"
This converts the guest to files in \f(CW`DIRECTORY\*(C'.  The metadata
produced is a \s-1JSON\s0 file containing the majority of the data virt-v2v
gathers during the conversion.
See \s-1OUTPUT TO JSON\*(R"\s0 below.

* **-o null**  
  .IX Item "-o null"
  The guest is converted, but the final result is thrown away and no
  metadata is created.  This is mainly useful for testing.

<a name="output-to-libvirt"></a>

# Output to Libvirt

.IX Header "OUTPUT TO LIBVIRT"
The _-o libvirt_ option lets you upload the converted guest to
a libvirt-managed host.  There are several limitations:

* ·  
  You can only use a local libvirt connection [see below for how to
  workaround this].
* ·  
  The _-os pool_ option must specify a directory pool, not anything
  more exotic such as iSCSI [but see below].
* ·  
  You can only upload to a \s-1KVM\s0 hypervisor.

<a name="workaround-for-output-to-a-remote-libvirt-instance-andor-a-non-directory-storage-pool"></a>

### Workaround for output to a remote libvirt instance and/or a non-directory storage pool

.IX Subsection "Workaround for output to a remote libvirt instance and/or a non-directory storage pool"

* 1.  
  Use virt-v2v in _-o local_ mode to convert the guest disks and
  metadata into a local temporary directory:
  .Sp
  .Vb 1
   virt-v2v [...] -o local -os /var/tmp
  .Ve
  .Sp
  This creates two (or more) files in _/var/tmp_ called:
  .Sp
  .Vb 2
   /var/tmp/NAME.xml     # the libvirt XML (metadata)
   /var/tmp/NAME-sda     # the guest’s first disk
  .Ve
  .Sp
  (for \f(CW`NAME\*(C' substitute the guest’s name).
* 2.  
  Upload the converted disk(s) into the storage pool called \f(CW`POOL\*(C':
  .Sp
  .Vb 3
   size=$(stat -c%s /var/tmp/NAME-sda)
   virsh vol-create-as POOL NAME-sda $size --format raw
   virsh vol-upload --pool POOL NAME-sda /var/tmp/NAME-sda
  .Ve
* 3.  
  Edit _/var/tmp/NAME.xml_ to change _/var/tmp/NAME-sda_ to the pool
  name.  In other words, locate the following bit of \s-1XML:\s0
  .Sp
  .Vb 5
   &lt;disk type=file\*(Aq device=\*(Aqdisk\*(Aq&gt;
     &lt;driver name=qemu\*(Aq type=\*(Aqraw\*(Aq /&gt;
     &lt;source file=/var/tmp/NAME-sda\*(Aq /&gt;
     &lt;target dev=hda\*(Aq bus=\*(Aqide\*(Aq /&gt;
   &lt;/disk&gt;
  .Ve
  .Sp
  and change two things: The \f(CW`type=\*(Aqfile\*(Aq\*(C' attribute must be changed to
  \f(CW`type=\*(Aqvolume\*(Aq\*(C', and the \f(CW\*(C\`&lt;source&gt;\*(C' element must be changed
  to include \f(CW`pool\*(C' and \f(CW\*(C\`volume\*(C' attributes:
  .Sp
  .Vb 5
   &lt;disk type=volume\*(Aq device=\*(Aqdisk\*(Aq&gt;
     ...
     &lt;source pool=POOL\*(Aq volume=\*(AqNAME-sda\*(Aq /&gt;
     ...
   &lt;/disk&gt;
  .Ve
* 4.  
  Define the final guest in libvirt:
  .Sp
  .Vb 1
   virsh define /var/tmp/NAME.xml
  .Ve

<a name="output-to-json"></a>

# Output to Json

.IX Header "OUTPUT TO JSON"
The _-o json_ option produces the following files by default:

.Vb 2
 NAME.json                     JSON metadata.
 NAME-sda, NAME-sdb, etc.      Guest disk(s).
.Ve

where \f(CW`NAME\*(C' is the guest name.

It is possible to change the pattern of the disks using the
_-oo json-disks-pattern=..._ option: it allows parameters in form of
\f(CW`%{...}\*(C' variables, for example:

.Vb 1
 -oo json-disks-pattern=disk%{DiskNo}.img
.Ve

Recognized variables are:
.ie n .IP """%{DiskNo}""" 4
.el .IP "\f(CW%{DiskNo}" 4
.IX Item "%{DiskNo}"
The index of the disk, starting from 1.
.ie n .IP """%{DiskDeviceName}""" 4
.el .IP "\f(CW%{DiskDeviceName}" 4
.IX Item "%{DiskDeviceName}"
The destination device of the disk, e.g. \f(CW`sda\*(C', \f(CW\*(C\`sdb\*(C', etc.
.ie n .IP """%{GuestName}""" 4
.el .IP "\f(CW%{GuestName}" 4
.IX Item "%{GuestName}"
The name of the guest.

Using a pattern it is possible use subdirectories for the disks,
even with names depending on variables; for example:

.Vb 1
 -oo json-disks-pattern=%{GuestName}-%{DiskNo}/disk.img
.Ve

The default pattern is \f(CW`%{GuestName}-%{DiskDeviceName}\*(C'.

If the literal \f(CW`%{...}\*(C' text is needed, it is possible to avoid the
escape it with a leading \f(CW`%\*(C'; for example,
\f(CW`%%{GuestName}-%{DiskNo}.img\*(C' will create file names for the
disks like \f(CW`%%{GuestName}-1.img\*(C', \f(CW\*(C\`%%{GuestName}-2.img\*(C', etc.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**virt-v2v**\|(1).

<a name="author"></a>

# Author

.IX Header "AUTHOR"
Richard W.M. Jones

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright (C) 2009-2020 Red Hat Inc.

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
