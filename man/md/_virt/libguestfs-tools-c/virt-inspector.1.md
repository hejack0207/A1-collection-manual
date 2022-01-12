# virt-inspector(1)

libguestfs-1.40.2, 2019-02-07

.if n .ad l
.nh

<a name="name"></a>

# Name

virt-inspector - Display operating system version and other information about a virtual machine

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" .Vb 1  virt-inspector [--options] -d domname   virt-inspector [--options] -a disk.img [-a disk.img ...] .Ve 
 Old-style: 
 .Vb 1  virt-inspector domname   virt-inspector disk.img [disk.img ...] .Ve
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
**virt-inspector** examines a virtual machine or disk image and tries
to determine the version of the operating system and other information
about the virtual machine.

Virt-inspector produces \s-1XML\s0 output for feeding into other programs.

In the normal usage, use \f(CW`virt-inspector -d domname\*(C' where \f(CW\*(C\`domname\*(C' is
the libvirt domain (see: \f(CW`virsh list --all\*(C').

You can also run virt-inspector directly on disk images from a single
virtual machine.  Use \f(CW`virt-inspector -a disk.img\*(C'.  In rare cases a
domain has several block devices, in which case you should list
several _-a_ options one after another, with the first corresponding
to the guest’s _/dev/sda_, the second to the guest’s _/dev/sdb_ and
so on.

You can also run virt-inspector on install disks, live CDs, bootable
\s-1USB\s0 keys and similar.

Virt-inspector can only inspect and report upon one domain at a
time.  To inspect several virtual machines, you have to run
virt-inspector several times (for example, from a shell script
for-loop).

Because virt-inspector needs direct access to guest images, it won’t
normally work over remote libvirt connections.

All of the information available from virt-inspector is also available
through the core libguestfs inspection \s-1API\s0 (see
\s-1INSPECTION\*(R"\s0 in **guestfs**\|(3)).  The same information can also be fetched
using guestfish or via libguestfs bindings in many programming
languages (see \s-1GETTING INSPECTION DATA FROM THE LIBGUESTFS API\*(R"\s0).

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **--help**  
  .IX Item "--help"
  Display brief help.
* **-a** file  
  .IX Item "-a file"
* **--add** file  
  .IX Item "--add file"
  Add _file_ which should be a disk image from a virtual machine.  If
  the virtual machine has multiple block devices, you must supply all of
  them with separate _-a_ options.
  .Sp
  The format of the disk image is auto-detected.  To override this and
  force a particular format use the _--format=.._ option.
* **-a** \s-1URI\s0  
  .IX Item "-a URI"
* **--add** \s-1URI\s0  
  .IX Item "--add URI"
  Add a remote disk.  See \s-1ADDING REMOTE STORAGE\*(R"\s0 in **guestfish**\|(1).
* **-c** \s-1URI\s0  
  .IX Item "-c URI"
* **--connect** \s-1URI\s0  
  .IX Item "--connect URI"
  If using libvirt, connect to the given _\s-1URI\s0_.  If omitted,
  then we connect to the default libvirt hypervisor.
  .Sp
  Libvirt is only used if you specify a \f(CW`domname\*(C' on the
  command line.  If you specify guest block devices directly (_-a_),
  then libvirt is not used at all.
* **-d** guest  
  .IX Item "-d guest"
* **--domain** guest  
  .IX Item "--domain guest"
  Add all the disks from the named libvirt guest.  Domain UUIDs can be
  used instead of names.
* **--echo-keys**  
  .IX Item "--echo-keys"
  When prompting for keys and passphrases, virt-inspector normally turns
  echoing off so you cannot see what you are typing.  If you are not
  worried about Tempest attacks and there is no one else in the room you
  can specify this flag to see what you are typing.
* **--format=raw|qcow2|..**  
  .IX Item "--format=raw|qcow2|.."
* **--format**  
  .IX Item "--format"
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
* **--key** \s-1SELECTOR\s0  
  .IX Item "--key SELECTOR"
  Specify a key for \s-1LUKS,\s0 to automatically open a \s-1LUKS\s0 device when using
  the inspection.  \f(CW`SELECTOR\*(C' can be in one of the following formats:
      .ie n .IP "**--key** ""DEVICE"":key:KEY_STRING" 4
      .el .IP "**--key** \f(CWDEVICE:key:KEY_STRING" 4
      .IX Item "--key DEVICE:key:KEY_STRING"
      Use the specified \f(CW`KEY\_STRING\*(C' as passphrase.
      .ie n .IP "**--key** ""DEVICE"":file:FILENAME" 4
      .el .IP "**--key** \f(CWDEVICE:file:FILENAME" 4
      .IX Item "--key DEVICE:file:FILENAME"
      Read the passphrase from _\s-1FILENAME\s0_.
* **--keys-from-stdin**  
  .IX Item "--keys-from-stdin"
  Read key or passphrase parameters from stdin.  The default is
  to try to read passphrases from the user by opening _/dev/tty_.
* **--no-applications**  
  .IX Item "--no-applications"
  By default the output of virt-inspector includes the list of all the
  applications installed in the guest, if available.
  .Sp
  Specify this option to disable this part of the resulting \s-1XML.\s0
* **--no-icon**  
  .IX Item "--no-icon"
  By default the output of virt-inspector includes the icon of the
  guest, if available (see icon\*(R").
  .Sp
  Specify this option to disable this part of the resulting \s-1XML.\s0
* **-v**  
  .IX Item "-v"
* **--verbose**  
  .IX Item "--verbose"
  Enable verbose messages for debugging.
* **-V**  
  .IX Item "-V"
* **--version**  
  .IX Item "--version"
  Display version number and exit.
* **-x**  
  .IX Item "-x"
  Enable tracing of libguestfs \s-1API\s0 calls.
* **--xpath** query  
  .IX Item "--xpath query"
  Perform an XPath query on the \s-1XML\s0 on stdin, and print the result on
  stdout.  In this mode virt-inspector simply runs an XPath query; all
  other inspection functions are disabled.  See \s-1XPATH QUERIES\*(R"\s0 below
  for some examples.

<a name="old-style-command-line-arguments"></a>

# Old-Style Command Line Arguments

.IX Header "OLD-STYLE COMMAND LINE ARGUMENTS"
Previous versions of virt-inspector allowed you to write either:

.Vb 1
 virt-inspector disk.img [disk.img ...]
.Ve

or

.Vb 1
 virt-inspector guestname
.Ve

whereas in this version you should use _-a_ or _-d_ respectively
to avoid the confusing case where a disk image might have the same
name as a guest.

For compatibility the old style is still supported.

<a name="xml-format"></a>

# Xml Format

.IX Header "XML FORMAT"
The virt-inspector \s-1XML\s0 is described precisely in a \s-1RELAX NG\s0 schema
file _virt-inspector.rng_ which is supplied with libguestfs.  This
section is just an overview.

The top-level element is &lt;operatingsystems&gt;, and it contains
one or more &lt;operatingsystem&gt; elements.  You would only see
more than one &lt;operatingsystem&gt; element if the virtual machine
is multi-boot, which is vanishingly rare in real world VMs.

<a name="ltoperatingsystemgt"></a>

### &lt;operatingsystem&gt;

.IX Subsection "&lt;operatingsystem&gt;"
In the &lt;operatingsystem&gt; tag are various optional fields that
describe the operating system, its architecture, the descriptive
product name\*(R" string, the type of \s-1OS\s0 and so on, as in this example:

.Vb 11
 &lt;operatingsystems&gt;
   &lt;operatingsystem&gt;
     &lt;root&gt;/dev/sda2&lt;/root&gt;
     &lt;name&gt;windows&lt;/name&gt;
     &lt;arch&gt;i386&lt;/arch&gt;
     &lt;distro&gt;windows&lt;/distro&gt;
     &lt;product_name&gt;Windows 7 Enterprise&lt;/product_name&gt;
     &lt;product_variant&gt;Client&lt;/product_variant&gt;
     &lt;major_version&gt;6&lt;/major_version&gt;
     &lt;minor_version&gt;1&lt;/minor_version&gt;
     &lt;windows_systemroot&gt;/Windows&lt;/windows_systemroot&gt;
.Ve

In brief, &lt;name&gt; is the class of operating system (something
like \f(CW`linux\*(C' or \f(CW\*(C\`windows\*(C'), &lt;distro&gt; is the distribution
(eg. \f(CW`fedora\*(C' but many other distros are recognized) and
&lt;arch&gt; is the guest architecture.  The other fields are fairly
self-explanatory, but because these fields are taken directly from the
libguestfs inspection \s-1API\s0 you can find precise information from
\s-1INSPECTION\*(R"\s0 in **guestfs**\|(3).

The &lt;root&gt; element is the root filesystem device, but from the
point of view of libguestfs (block devices may have completely
different names inside the \s-1VM\s0 itself).

<a name="ltmountpointsgt"></a>

### &lt;mountpoints&gt;

.IX Subsection "&lt;mountpoints&gt;"
Un*x-like guests typically have multiple filesystems which are mounted
at various mountpoints, and these are described in the
&lt;mountpoints&gt; element which looks like this:

.Vb 7
 &lt;operatingsystems&gt;
   &lt;operatingsystem&gt;
     ...
     &lt;mountpoints&gt;
       &lt;mountpoint dev="/dev/vg_f13x64/lv_root"&gt;/&lt;/mountpoint&gt;
       &lt;mountpoint dev="/dev/sda1"&gt;/boot&lt;/mountpoint&gt;
     &lt;/mountpoints&gt;
.Ve

As with &lt;root&gt;, devices are from the point of view of
libguestfs, and may have completely different names inside the guest.
Only mountable filesystems appear in this list, not things like swap
devices.

<a name="ltfilesystemsgt"></a>

### &lt;filesystems&gt;

.IX Subsection "&lt;filesystems&gt;"
&lt;filesystems&gt; is like &lt;mountpoints&gt; but covers _all_
filesystems belonging to the guest, including swap and empty
partitions.  (In the rare case of a multi-boot guest, it covers
filesystems belonging to this \s-1OS\s0 or shared with this \s-1OS\s0 and other
OSes).

You might see something like this:

.Vb 9
 &lt;operatingsystems&gt;
   &lt;operatingsystem&gt;
     ...
     &lt;filesystems&gt;
       &lt;filesystem dev="/dev/vg_f13x64/lv_root"&gt;
         &lt;type&gt;ext4&lt;/type&gt;
         &lt;label&gt;Fedora-13-x86_64&lt;/label&gt;
         &lt;uuid&gt;e6a4db1e-15c2-477b-ac2a-699181c396aa&lt;/uuid&gt;
       &lt;/filesystem&gt;
.Ve

The optional elements within &lt;filesystem&gt; are the filesystem
type, the label, and the \s-1UUID.\s0

<a name="ltapplicationsgt"></a>

### &lt;applications&gt;

.IX Subsection "&lt;applications&gt;"
The related elements &lt;package_format&gt;,
&lt;package_management&gt; and &lt;applications&gt; describe
applications installed in the virtual machine.

&lt;package_format&gt;, if present, describes the packaging
system used.  Typical values would be \f(CW`rpm\*(C' and \f(CW\*(C\`deb\*(C'.

&lt;package_management&gt;, if present, describes the package
manager.  Typical values include \f(CW`yum\*(C', \f(CW\*(C\`up2date\*(C' and \f(CW\*(C\`apt\*(C'

&lt;applications&gt; lists the packages or applications
installed.

.Vb 9
 &lt;operatingsystems&gt;
   &lt;operatingsystem&gt;
     ...
     &lt;applications&gt;
       &lt;application&gt;
         &lt;name&gt;coreutils&lt;/name&gt;
         &lt;version&gt;8.5&lt;/version&gt;
         &lt;release&gt;1&lt;/release&gt;
       &lt;/application&gt;
.Ve

The version and release fields may not be available for some types
guests.  Other fields are possible, see
guestfs_inspect_list_applications\*(R" in **guestfs**\|(3).

<a name="ltdrive_mappingsgt"></a>

### &lt;drive_mappings&gt;

.IX Subsection "&lt;drive_mappings&gt;"
For operating systems like Windows which use drive letters,
virt-inspector is able to find out how drive letters map to
filesystems.

.Vb 7
 &lt;operatingsystems&gt;
   &lt;operatingsystem&gt;
     ...
     &lt;drive_mappings&gt;
       &lt;drive_mapping name="C"&gt;/dev/sda2&lt;/drive_mapping&gt;
       &lt;drive_mapping name="E"&gt;/dev/sdb1&lt;/drive_mapping&gt;
     &lt;/drive_mappings&gt;
.Ve

In the example above, drive C maps to the filesystem on the second
partition on the first disk, and drive E maps to the filesystem on the
first partition on the second disk.

Note that this only covers permanent local filesystem mappings, not
things like network shares.  Furthermore \s-1NTFS\s0 volume mount points may
not be listed here.

<a name="lticongt"></a>

### &lt;icon&gt;

.IX Subsection "&lt;icon&gt;"
Virt-inspector is sometimes able to extract an icon or logo for the
guest.  The icon is returned as base64-encoded \s-1PNG\s0 data.  Note that
the icon can be very large and high quality.

.Vb 7
 &lt;operatingsystems&gt;
   &lt;operatingsystem&gt;
     ...
     &lt;icon&gt;
       iVBORw0KGgoAAAANSUhEUgAAAGAAAABg[.......]
       [... many lines of base64 data ...]
     &lt;/icon&gt;
.Ve

To display the icon, you have to extract it and convert the base64
data back to a binary file.  Use an XPath query or simply an editor to
extract the data, then use the coreutils **base64**\|(1) program to do
the conversion back to a \s-1PNG\s0 file:

.Vb 1
 base64 -i -d &lt; icon.data &gt; icon.png
.Ve

<a name="xpath-queries"></a>

# Xpath Queries

.IX Header "XPATH QUERIES"
Virt-inspector includes built in support for running XPath queries.
The reason for including XPath support directly in virt-inspector is
simply that there are no good and widely available command line
programs that can do XPath queries.  The only good one is
**xmlstarlet**\|(1) and that is not available on Red Hat Enterprise
Linux.

To perform an XPath query, use the _--xpath_ option.  Note that in
this mode, virt-inspector simply reads \s-1XML\s0 from stdin and outputs the
query result on stdout.  All other inspection features are disabled in
this mode.

For example:

.Vb 5
 $ virt-inspector -d Guest | virt-inspector --xpath //filesystems\*(Aq
 &lt;filesystems&gt;
      &lt;filesystem dev="/dev/vg_f13x64/lv_root"&gt;
        &lt;type&gt;ext4&lt;/type&gt;
 [...]

 $ virt-inspector -d Guest | \e
     virt-inspector --xpath "string(//filesystem[@dev=/dev/sda1\*(Aq]/type)"
 ext4

 $ virt-inspector -d Guest | \e
     virt-inspector --xpath string(//icon)\*(Aq | base64 -i -d | display -
 [displays the guest icon, if there is one]
.Ve

<a name="getting-inspection-data-from-the-libguestfs-api"></a>

# Getting Inspection Data from the Libguestfs Api

.IX Header "GETTING INSPECTION DATA FROM THE LIBGUESTFS API"
In early versions of libguestfs, virt-inspector was a large Perl
script that contained many heuristics for inspecting guests.  This had
several problems: in order to do inspection from other tools (like
guestfish) we had to call out to this Perl script; and it privileged
Perl over other languages that libguestfs supports.

By libguestfs 1.8 we had rewritten the Perl code in C, and
incorporated it all into the core libguestfs \s-1API\s0 (**guestfs**\|(3)).  Now
virt-inspector is simply a thin C program over the core C \s-1API.\s0  All of
the inspection information is available from all programming languages
that libguestfs supports, and from guestfish.

For a description of the C inspection \s-1API,\s0 read
\s-1INSPECTION\*(R"\s0 in **guestfs**\|(3).

For example code using the C inspection \s-1API,\s0 look for _inspect-vm.c_
which ships with libguestfs.

_inspect-vm.c_ has also been translated into other languages.  For
example, _inspect\_vm.pl_ is the Perl translation, and there are other
translations for OCaml, Python, etc.  See
\s-1USING LIBGUESTFS WITH OTHER PROGRAMMING LANGUAGES\*(R"\s0 in **guestfs**\|(3) for a
list of man pages which contain this example code.

<a name="s-1getting-inspection-data-from-guestfishs0"></a>

### \s-1GETTING INSPECTION DATA FROM GUESTFISH\s0

.IX Subsection "GETTING INSPECTION DATA FROM GUESTFISH"
If you use the guestfish _-i_ option, then the main C inspection \s-1API\s0
guestfs_inspect_os\*(R" in **guestfs**\|(3) is called.  This is equivalent to the
guestfish command \f(CW`inspect-os\*(C'.  You can also call this guestfish
command by hand.

\f(CW`inspect-os\*(C' performs inspection on the current disk image, returning
the list of operating systems found.  Each \s-1OS\s0 is represented by its
root filesystem device.  In the majority of cases, this command prints
nothing (no OSes found), or a single root device, but beware that it
can print multiple lines if there are multiple OSes or if there is an
install \s-1CD\s0 attached to the guest.

.Vb 4
 $ guestfish --ro -a F15x32.img
 &gt;&lt;fs&gt; run
 &gt;&lt;fs&gt; inspect-os
 /dev/vg_f15x32/lv_root
.Ve

Using the root device, you can fetch further information about the
guest:

.Vb 8
 &gt;&lt;fs&gt; inspect-get-type /dev/vg_f15x32/lv_root
 linux
 &gt;&lt;fs&gt; inspect-get-distro /dev/vg_f15x32/lv_root
 fedora
 &gt;&lt;fs&gt; inspect-get-major-version /dev/vg_f15x32/lv_root
 15
 &gt;&lt;fs&gt; inspect-get-product-name /dev/vg_f15x32/lv_root
 Fedora release 15 (Lovelock)
.Ve

Limitations of guestfish make it hard to assign the root device to a
variable (since guestfish doesn't have variables), so if you want to
do this reproducibly you are better off writing a script using one of
the other languages that the libguestfs \s-1API\s0 supports.

To list applications, you have to first mount up the disks:

.Vb 5
 &gt;&lt;fs&gt; inspect-get-mountpoints /dev/vg_f15x32/lv_root
 /: /dev/vg_f15x32/lv_root
 /boot: /dev/vda1
 &gt;&lt;fs&gt; mount-ro /dev/vg_f15x32/lv_root /
 &gt;&lt;fs&gt; mount-ro /dev/vda1 /boot
.Ve

and then call the inspect-list-applications \s-1API:\s0

.Vb 10
 &gt;&lt;fs&gt; inspect-list-applications /dev/vg_f15x32/lv_root | head -28
 [0] = {
   app_name: ConsoleKit
   app_display_name:
   app_epoch: 0
   app_version: 0.4.5
   app_release: 1.fc15
   app_install_path:
   app_trans_path:
   app_publisher:
   app_url:
   app_source_package:
   app_summary:
   app_description:
 }
 [1] = {
   app_name: ConsoleKit-libs
   app_display_name:
   app_epoch: 0
   app_version: 0.4.5
   app_release: 1.fc15
   app_install_path:
   app_trans_path:
   app_publisher:
   app_url:
   app_source_package:
   app_summary:
   app_description:
 }
.Ve

To display an icon for the guest, note that filesystems must also be
mounted as above.  You can then do:

.Vb 1
 &gt;&lt;fs&gt; inspect-get-icon /dev/vg_f15x32/lv_root | display -
.Ve

<a name="old-versions-of-virt-inspector"></a>

# Old Versions of Virt-Inspector

.IX Header "OLD VERSIONS OF VIRT-INSPECTOR"
As described above, early versions of libguestfs shipped with a
different virt-inspector program written in Perl (the current version
is written in C).  The \s-1XML\s0 output of the Perl virt-inspector was
different and it could also output in other formats like text.

The old virt-inspector is no longer supported or shipped with
libguestfs.

To confuse matters further, in Red Hat Enterprise Linux 6 we ship two
versions of virt-inspector with different names:

.Vb 2
 virt-inspector     Old Perl version.
 virt-inspector2    New C version.
.Ve

<a name="exit-status"></a>

# Exit Status

.IX Header "EXIT STATUS"
This program returns 0 if successful, or non-zero if there was an
error.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**guestfs**\|(3),
**guestfish**\|(1),
http://www.w3.org/TR/xpath/,
**base64**\|(1),
**xmlstarlet**\|(1),
http://libguestfs.org/.

<a name="authors"></a>

# Authors

.IX Header "AUTHORS"

* ·  
  Richard W.M. Jones http://people.redhat.com/~rjones/
* ·  
  Matthew Booth [mbooth@redhat.com](mailto:mbooth@redhat.com)

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright (C) 2010-2012 Red Hat Inc.

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
