# virt-p2v-make-kickstart(1)

libguestfs-1.40.2, 2019-02-07

.if n .ad l
.nh

<a name="name"></a>

# Name

virt-p2v-make-kickstart - Build the virt-p2v kickstart

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" .Vb 1  virt-p2v-make-kickstart [-o p2v.ks] [--proxy=http://...] repo [repo...] .Ve
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
**virt-p2v**\|(1) converts a physical machine to run virtualized on \s-1KVM,\s0
managed by libvirt, OpenStack, oVirt, Red Hat Enterprise
Virtualisation (\s-1RHEV\s0), or one of the other targets supported by
**virt-v2v**\|(1).

Kickstart is a format used by Red Hat-derived distributions (such as
Fedora, Red Hat Enterprise Linux, CentOS, Scientific Linux, and
others) to describe how to make live CDs, install the distro, make
Spins\*(R" and so on.  It is driven by a kickstart file.

virt-p2v-make-kickstart builds a kickstart file which can be used to
build a bootable P2V \s-1ISO,\s0 live \s-1CD, USB\s0 key, or \s-1PXE\s0 image.  This tool
only builds the kickstart file, but this manual page describes some of
the ways you can use the kickstart file.

<a name="building-the-kickstart-file"></a>

# Building the Kickstart File

.IX Header "BUILDING THE KICKSTART FILE"
Using virt-p2v-make-kickstart is very simple:

.Vb 1
 virt-p2v-make-kickstart fedora
.Ve

will build a kickstart file for Fedora.  The kickstart file will be
called _p2v.ks_ and located in the current directory.

The parameters are a list of one or more repositories.  Some built-in
repositories are available: \f(CW`fedora\*(C', \f(CW\*(C\`rawhide\*(C', \f(CW\*(C\`koji\*(C' or
\f(CW`rhel-VERSION\*(C' (eg. \f(CW\*(C\`rhel-7.1\*(C').  You can also use a \s-1URL\s0 as a
parameter to point to a repository, for example:

.Vb 1
 virt-p2v-make-kickstart https://dl.fedoraproject.org/pub/fedora/linux/releases/21/Everything/x86_64/os/
.Ve

To control the name of the output file, use the _-o_ parameter.  To
tell kickstart to use a proxy server or web cache to download files,
use the _--proxy_ parameter.

<a name="building-a-live-cd-iso"></a>

# Building a Live Cd / Iso

.IX Header "BUILDING A LIVE CD / ISO"
Once you have the kickstart file, you can use **livecd-creator**\|(8)
to make a live \s-1CD:\s0

.Vb 1
 sudo livecd-creator p2v.ks
.Ve

Before running this note that you should probably run
\f(CW`livecd-creator\*(C' in a disposable virtual machine for these reasons:

* ·  
  You have to disable SELinux when running the tool.
* ·  
  This tool has to be run as root, and has some nasty failure modes.
* ·  
  You can only create the exact same Live \s-1CD\s0 distro as the host
  distro.  Cross-builds will fail in strange ways (eg. RHBZ#1092327).

<a name="building-a-fedora-spin-using-koji"></a>

# Building a Fedora Spin Using Koji

.IX Header "BUILDING A FEDORA SPIN USING KOJI"
This requires \f(CW`spin-livecd\*(C' permissions on Koji, which are not given
out usually, even to Fedora packagers.  However assuming you have been
given these permissions (or have your own Koji instance, I guess),
then you can do:

.Vb 1
 koji spin-livecd [--scratch] virt-p2v 1.XX.YY rawhide x86_64 p2v.ks
.Ve

* ·  
  Add the \f(CW`--scratch\*(C' option to do a scratch build (recommended for
  testing).
* ·  
  \f(CW`1.XX.YY\*(C' should match the libguestfs version
* ·  
  Instead of \f(CW`rawhide\*(C' you can use any Koji target.

<a name="building-a-bootable-usb-key"></a>

# Building a Bootable Usb Key

.IX Header "BUILDING A BOOTABLE USB KEY"
Use the **livecd-iso-to-disk**\|(8) program to convert the \s-1ISO\s0 created
above to a \s-1USB\s0 key:

.Vb 1
 sudo livecd-iso-to-disk livecd-p2v.iso /dev/sdX
.Ve

<a name="building-a-pxe-boot-image"></a>

# Building a Pxe Boot Image

.IX Header "BUILDING A PXE BOOT IMAGE"
Use the \f(CW`livecd-iso-to-pxeboot\*(C' program to convert the \s-1ISO\s0 created
above to a \s-1PXE\s0 boot image.

.Vb 1
 sudo livecd-iso-to-pxeboot livecd-p2v.iso
.Ve

This creates a \f(CW`tftpboot\*(C' subdirectory under the current directory
containing the files required to \s-1PXE\s0 boot virt-p2v:

.Vb 6
 $ ls -1R tftpboot/
 tftpboot/:
 initrd0.img
 pxelinux.0
 pxelinux.cfg/
 vmlinuz0
 
 tftpboot/pxelinux.cfg:
 default
.Ve

<a name="32-or-64-bit-virt-p2v"></a>

# 32 or 64 Bit Virt\-P2v?

.IX Header "32 OR 64 BIT VIRT-P2V?"
Virt-p2v can convert any 32 or 64 bit guest, regardless of whether
virt-p2v itself is built as a 32 or 64 bit binary.  The only
restriction is that 64 bit virt-p2v cannot run on 32 bit hardware.

Old virt-p2v 0.9 was always built as a 32 bit (i686) \s-1ISO.\s0  This meant
that the \s-1CD\s0 could be booted on any 32- or 64-bit i686 or x86-64
hardware, and could convert any guest.  The old virt-p2v \s-1ISO\s0 shipped
by Red Hat was based on Red Hat Enterprise Linux (\s-1RHEL\s0) 6.

Since \s-1RHEL 7\s0 dropped support for 32 bit machines, current virt-p2v on
\s-1RHEL\s0 can only be built for 64 bit.  It cannot run on old 32 bit only
hardware.

Fedora virt-p2v ISOs are generally built for 32 bit, so like the old
\s-1RHEL\s0 6-based virt-p2v 0.9 they can boot on any hardware.

<a name="testing-virt-p2v-using-qemu"></a>

# Testing Virt\-P2v Using Qemu

.IX Header "TESTING VIRT-P2V USING QEMU"

<a name="s-1testing-the-p2v-iso-using-qemus0"></a>

### \s-1TESTING THE P2V ISO USING QEMU\s0

.IX Subsection "TESTING THE P2V ISO USING QEMU"
You can use qemu to test-boot the P2V \s-1ISO:\s0

.Vb 1
 qemu-kvm -m 1024 -hda /tmp/guest.img -cdrom /tmp/livecd-p2v.iso -boot d
.Ve

Note that \f(CW`-hda\*(C' is the (virtual) system that you want to convert
(for test purposes).  It could be any guest type supported by
**virt-v2v**\|(1), including Windows or Red Hat Enterprise Linux.

<a name="s-1testing-pxe-support-using-qemus0"></a>

### \s-1TESTING PXE SUPPORT USING QEMU\s0

.IX Subsection "TESTING PXE SUPPORT USING QEMU"

* ·  
  Unpack the tftpboot directory into _/tmp_ (so it appears as
  _/tmp/tftpboot_).
* ·  
  Copy _pxelinux.0_ and _ldlinux.c32_ from syslinux (usually from
  _/usr/share/syslinux_) into _/tmp/tftpboot_.
* ·  
  Adjust the \f(CW`APPEND\*(C' line in _/tmp/tftpboot/pxelinux.cfg/default_ if
  required.  See \s-1KERNEL COMMAND LINE CONFIGURATION\*(R"\s0 in **virt-p2v**\|(1).
* ·  
  Run qemu like this so that it acts as a \s-1TFTP\s0 and \s-1BOOTP\s0 server,
  emulating a netboot:
  .Sp
  .Vb 6
   qemu-kvm \e
       -m 4096 -hda /tmp/guest.img \e
       -boot n \e
       -netdev user,id=unet,tftp=/tmp/tftpboot,bootfile=/pxelinux.0 \e
       -device virtio-net-pci,netdev=unet \e
       -serial stdio
  .Ve
  .Sp
  Note that this requires considerably more memory because the \s-1PXE\s0 image
  is loaded into memory.  Also that qemu’s \s-1TFTP\s0 server is very slow and
  the virt-p2v \s-1PXE\s0 image is very large, so it can appear to hang\*(R" after
  pxelinux starts up.

<a name="adding-extra-packages"></a>

# Adding Extra Packages

.IX Header "ADDING EXTRA PACKAGES"
You can install extra packages using the _--install_ option.  This
can be useful for making a more fully-featured virt-p2v disk with
extra tools for debugging and troubleshooting.  Give a list of
packages, separated by commas.  For example:

.Vb 1
 virt-p2v-make-kickstart [...] --install tcpdump,traceroute
.Ve

<a name="adding-an-ssh-identity"></a>

# Adding an Ssh Identity

.IX Header "ADDING AN SSH IDENTITY"
You can inject an \s-1SSH\s0 identity (private key) file to the kickstart and
hence into the \s-1ISO\s0 using the _--inject-ssh-identity_ option.  Note
that you _cannot_ inject a key once the \s-1ISO\s0 has been built.

First create a key pair.  It must have an empty passphrase:

.Vb 1
 ssh-keygen -t rsa -N \*(Aq -f id_rsa
.Ve

This creates a private key (\f(CW`id\_rsa\*(C') and a public key
(\f(CW`id\_rsa.pub\*(C') pair.  The public key should be appended to the
\f(CW`authorized\_keys\*(C' file on the virt-v2v conversion server (usually to
\f(CW`/root/.ssh/authorized\_keys\*(C').

The private key should be added to the kickstart file and then
discarded:

.Vb 2
 virt-p2v-make-kickstart [...] --inject-ssh-identity id_rsa
 rm id_rsa
.Ve

The \s-1ISO\s0 can then be built from the kickstart in the usual way (see
above), and it will contain the embedded \s-1SSH\s0 identity
(_/var/tmp/id\_rsa_).

When booting virt-p2v, specify the \s-1URL\s0 of the injected file like this:

.Vb 5
 │         User name: [root_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_] │
 │                                                        │
 │          Password: [    &lt;leave this field blank&gt;     ] │
 │                                                        │
 │  SSH Identity URL: [file:///var/tmp/id_rsa_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_] │
.Ve

or if using the kernel command line, add:

.Vb 1
 p2v.identity=file:///var/tmp/id_rsa
.Ve

For more information, see \s-1SSH IDENTITIES\*(R"\s0 in **virt-p2v**\|(1).

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **--help**  
  .IX Item "--help"
  Display help.
* **--inject-ssh-identity** id_rsa  
  .IX Item "--inject-ssh-identity id_rsa"
  Add an \s-1SSH\s0 identity (private key) file into the kickstart.
  See \s-1ADDING AN SSH IDENTITY\*(R"\s0 above.
* **--install** pkg,pkg,...  
  .IX Item "--install pkg,pkg,..."
  Add extra packages to the kickstart \f(CW%packages section.
  See \s-1ADDING EXTRA PACKAGES\*(R"\s0 above.
* **-o** \s-1OUTPUT\s0  
  .IX Item "-o OUTPUT"
* **--output** \s-1OUTPUT\s0  
  .IX Item "--output OUTPUT"
  Write kickstart to \f(CW`OUTPUT\*(C'.  If not specified, the default is
  _p2v.ks_ in the current directory.
* **--proxy** \s-1URL\s0  
  .IX Item "--proxy URL"
  Tell the kickstart to use a proxy server or web cache for downloads.
* **-v**  
  .IX Item "-v"
* **--verbose**  
  .IX Item "--verbose"
  Enable verbose output.  Use this if you need to debug problems with
  the script or if you are filing a bug.
* **-V**  
  .IX Item "-V"
* **--version**  
  .IX Item "--version"
  Display version number and exit.

<a name="files"></a>

# Files

.IX Header "FILES"

* _\f(CI$libdir/virt-p2v/virt-p2v.xz_  
  .IX Item "$libdir/virt-p2v/virt-p2v.xz"
  The **virt-p2v**\|(1) binary which is copied into the kickstart file.
  .Sp
  The location of the binary can be changed by setting the
  \f(CW`VIRT\_P2V\_DATA\_DIR\*(C' environment variable.
* _\f(CI$datadir/virt-p2v/issue_  
  .IX Item "$datadir/virt-p2v/issue"
* _\f(CI$datadir/virt-p2v/launch-virt-p2v.in_  
  .IX Item "$datadir/virt-p2v/launch-virt-p2v.in"
* _\f(CI$datadir/virt-p2v/p2v.ks.in_  
  .IX Item "$datadir/virt-p2v/p2v.ks.in"
* _\f(CI$datadir/virt-p2v/p2v.service_  
  .IX Item "$datadir/virt-p2v/p2v.service"
  Various data files that are used to make the kickstart.
  .Sp
  The location of these files can be changed by setting the
  \f(CW`VIRT\_P2V\_DATA\_DIR\*(C' environment variable.

<a name="environment-variables"></a>

# Environment Variables

.IX Header "ENVIRONMENT VARIABLES"
.ie n .IP """VIRT_P2V_DATA_DIR""" 4
.el .IP "\f(CWVIRT\_P2V\_DATA\_DIR" 4
.IX Item "VIRT_P2V_DATA_DIR"
The directory where virt-p2v-make-kickstart looks for data files and
the virt-p2v binary (see \s-1FILES\*(R"\s0 above).  If not set, a compiled-in
location is used.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**virt-p2v**\|(1),
**virt-p2v-make-disk**\|(1),
**virt-v2v**\|(1),
**livecd-creator**\|(8),
**livecd-iso-to-disk**\|(8),
http://libguestfs.org/.

<a name="authors"></a>

# Authors

.IX Header "AUTHORS"
Richard W.M. Jones http://people.redhat.com/~rjones/

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright (C) 2009-2019 Red Hat Inc.

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
