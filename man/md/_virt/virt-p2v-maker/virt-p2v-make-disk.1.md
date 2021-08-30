# virt-p2v-make-disk(1)

libguestfs-1.40.2, 2019-02-07

.if n .ad l
.nh

<a name="name"></a>

# Name

virt-p2v-make-disk - Build the virt-p2v disk using virt-builder

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" .Vb 1  virt-p2v-make-disk -o /dev/sdX [os-version] .Ve
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
**virt-p2v**\|(1) converts a physical machine to run virtualized on \s-1KVM,\s0
managed by libvirt, OpenStack, oVirt, Red Hat Enterprise
Virtualisation (\s-1RHEV\s0), or one of the other targets supported by
**virt-v2v**\|(1).

virt-p2v-make-disk is a script which creates a bootable disk image or
\s-1USB\s0 key containing virt-p2v.  It uses **virt-builder**\|(1) to do this,
and is just a small shell script around virt-builder.

The required _-o_ parameter specifies where the output should go, for
example to a \s-1USB\s0 key (eg. \f(CW`-o /dev/sdX\*(C') or to a file.  If you pass a
device name, then **the existing contents of the device will be erased**.
.ie n .SS """os-version"" parameter"
.el .SS "\f(CWos-version parameter"
.IX Subsection "os-version parameter"
The optional \f(CW`os-version\*(C' parameter is the base Linux distro to use
for the operating system on the \s-1ISO.\s0  If you don't set this parameter,
the script tries to choose a suitable default for you.  Most users
should _not_ use the \f(CW`os-version\*(C' parameter.

The base \s-1OS\s0 selected for virt-p2v is not related in any way to the \s-1OS\s0
of the physical machine that you are trying to convert.

To list possible \f(CW`os-version\*(C' combinations, do:

.Vb 1
 virt-builder -l
.Ve

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
Write a virt-p2v bootable \s-1USB\s0 key on _/dev/sdX_ (any existing content
on _/dev/sdX_ is erased):

.Vb 1
 virt-p2v-make-disk -o /dev/sdX
.Ve

Write a virt-p2v bootable virtual disk image, and boot it under qemu:

.Vb 4
 virt-p2v-make-disk -o /var/tmp/p2v.img
 qemu-kvm -m 1024 -boot c \e
   -drive file=/var/tmp/p2v.img,if=virtio,index=0 \e
   -drive file=/var/tmp/guest.img,if=virtio,index=1
.Ve

where _/var/tmp/guest.img_ would be the disk image of some guest that
you want to convert (for testing only).

<a name="adding-extra-packages"></a>

# Adding Extra Packages

.IX Header "ADDING EXTRA PACKAGES"
You can install extra packages using the _--install_ option.  This
can be useful for making a more fully-featured virt-p2v disk with
extra tools for debugging and troubleshooting.  Give a list of
packages, separated by commas.  For example:

.Vb 1
 virt-p2v-make-disk -o /var/tmp/p2v.img --install tcpdump,traceroute
.Ve

<a name="adding-an-ssh-identity"></a>

# Adding an Ssh Identity

.IX Header "ADDING AN SSH IDENTITY"
You can inject an \s-1SSH\s0 identity (private key) file to the image using
the _--inject-ssh-identity_ option.

First create a key pair.  It must have an empty passphrase:

.Vb 1
 ssh-keygen -t rsa -N \*(Aq -f id_rsa
.Ve

This creates a private key (\f(CW`id\_rsa\*(C') and a public key
(\f(CW`id\_rsa.pub\*(C') pair.  The public key should be appended to the
\f(CW`authorized\_keys\*(C' file on the virt-v2v conversion server (usually to
\f(CW`/root/.ssh/authorized\_keys\*(C').

The private key should be injected into the disk image and then
discarded:

.Vb 2
 virt-p2v-make-disk [...] --inject-ssh-identity id_rsa
 rm id_rsa
.Ve

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

<a name="32-bit-virt-p2v"></a>

# 32 Bit Virt\-P2v

.IX Header "32 BIT VIRT-P2V"
For improved compatibility with older hardware, virt-p2v-make-disk has
an _--arch_ option.  The most useful setting (on x86-64 hosts) is
_--arch i686_, which builds a 32 bit virt-p2v environment that will
work on older hardware.  32 bit virt-p2v can convert 64 bit physical
machines and can interoperate with 64 bit virt-v2v and 64 bit
hypervisors.

This option requires that you have built _virt-p2v.$arch_ (ie.
usually _virt-p2v.i686_) by some means, and that you install it next
to the ordinary _virt-p2v_ binary (eg. in _\f(CI$libdir/virt-p2v/_ or
\f(CW$VIRT\_V2V\_DATA\_DIR).  This is outside the scope of this manual
page, but you can find some tips in
\s-1BUILDING\s0 i686 32 \s-1BIT VIRT-P2V\*(R"\s0 in **guestfs-building**\|(1).

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **--help**  
  .IX Item "--help"
  Display help.
* **--arch** \s-1ARCH\s0  
  .IX Item "--arch ARCH"
  Set the architecture of the virt-p2v \s-1ISO.\s0  See 32 \s-1BIT VIRT-P2V\*(R"\s0 above.
  .Sp
  If this option is not supplied, then the default is to use the same
  architecture as the host that is running virt-p2v-make-disk.
* **--inject-ssh-identity** id_rsa  
  .IX Item "--inject-ssh-identity id_rsa"
  Add an \s-1SSH\s0 identity (private key) file into the image.
  See \s-1ADDING AN SSH IDENTITY\*(R"\s0 above.
* **--install** pkg,pkg,...  
  .IX Item "--install pkg,pkg,..."
  Add extra packages to the image.
  See \s-1ADDING EXTRA PACKAGES\*(R"\s0 above.
* **--no-warn-if-partition**  
  .IX Item "--no-warn-if-partition"
  Normally you should not write to a partition on a \s-1USB\s0 drive (ie. don’t
  use \f(CW`-o /dev/sdX1\*(C', use \f(CW\*(C\`-o /dev/sdX\*(C' to make a bootable \s-1USB\s0
  drive).  If you do this, virt-builder prints a warning.  This option
  suppresses that warning.
* **-o** \s-1OUTPUT\s0  
  .IX Item "-o OUTPUT"
* **--output** \s-1OUTPUT\s0  
  .IX Item "--output OUTPUT"
  Write output to \f(CW`OUTPUT\*(C', which can be a local file or block device.
  **The existing contents of the device will be erased**.
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
  The **virt-p2v**\|(1) binary which is copied into the bootable disk
  image.
  .Sp
  The location of the binary can be changed by setting the
  \f(CW`VIRT\_P2V\_DATA\_DIR\*(C' environment variable.
* _\f(CI$datadir/virt-p2v/issue_  
  .IX Item "$datadir/virt-p2v/issue"
* _\f(CI$datadir/virt-p2v/launch-virt-p2v.in_  
  .IX Item "$datadir/virt-p2v/launch-virt-p2v.in"
* _\f(CI$datadir/virt-p2v/p2v.service_  
  .IX Item "$datadir/virt-p2v/p2v.service"
  Various data files that are copied into the bootable disk image.
  .Sp
  The location of these files can be changed by setting the
  \f(CW`VIRT\_P2V\_DATA\_DIR\*(C' environment variable.

<a name="environment-variables"></a>

# Environment Variables

.IX Header "ENVIRONMENT VARIABLES"
.ie n .IP """VIRT_P2V_DATA_DIR""" 4
.el .IP "\f(CWVIRT\_P2V\_DATA\_DIR" 4
.IX Item "VIRT_P2V_DATA_DIR"
The directory where virt-p2v-make-disk looks for data files (see
\s-1FILES\*(R"\s0 above).  If not set, a compiled-in location is used.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**virt-p2v**\|(1),
**virt-p2v-make-kickstart**\|(1),
**virt-p2v-make-kiwi**\|(1),
**virt-v2v**\|(1),
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
