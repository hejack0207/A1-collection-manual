# virt-p2v-make-kiwi(1)

libguestfs-1.40.2, 2019-02-07

.if n .ad l
.nh

<a name="name"></a>

# Name

virt-p2v-make-kiwi - Build the virt-p2v kiwi configuration

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" .Vb 1  virt-p2v-make-kiwi [--inject-ssh-identity path] [-o kiwi-folder] .Ve
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
**virt-p2v**\|(1) converts a physical machine to run virtualized on \s-1KVM,\s0
managed by libvirt, OpenStack, oVirt, Red Hat Enterprise
Virtualisation (\s-1RHEV\s0), or one of the other targets supported by
**virt-v2v**\|(1).

Kiwi is a tool used mainly by \s-1SUSE\s0 Linux Enterprise and openSUSE to
build live CDs, make appliances and so on. It is driven by a few files
including an xml description of the machine.

virt-p2v-make-kiwi builds a folder containing all the pieces needed for
kiwi to build a bootable P2V live \s-1CD ISO, USB\s0 key, or \s-1PXE\s0 image.  This tool
only builds the kiwi configuration, but this manual page describes some of
the ways you can use the kiwi configuration.

<a name="building-the-kiwi-configuration"></a>

# Building the Kiwi Configuration

.IX Header "BUILDING THE KIWI CONFIGURATION"
Using virt-p2v-make-kiwi is very simple:

.Vb 1
 virt-p2v-make-kiwi
.Ve

will build a kiwi configuration based on the current machine’s distribution.

To control the name of the output folder, use the _-o_ parameter.

<a name="building-a-live-cd-iso"></a>

# Building a Live Cd / Iso

.IX Header "BUILDING A LIVE CD / ISO"
Once you have the kiwi configuration folder, you can use **kiwi**\|(1) to make a
live \s-1CD:\s0

.Vb 1
 sudo kiwi --build p2v.kiwi -d build --type iso
.Ve

Before running this, you may have to tweak the \f(CW`config.xml\*(C' file
to change the locale and keyboard mapping to the one you need.

If running on a \s-1SUSE\s0 Linux Entreprise Server, add the path to your packages repositories
using the \f(CW`--ignore-repos\*(C' and \f(CW\*(C\`--add-repo\*(C' kiwi parameters.

The generated \s-1ISO\s0 image will be placed in the \f(CW`build\*(C' folder.

<a name="building-a-bootable-usb-key"></a>

# Building a Bootable Usb Key

.IX Header "BUILDING A BOOTABLE USB KEY"
Use the **dd**\|(1) program to write the \s-1ISO\s0 created above to a \s-1USB\s0 key:

.Vb 1
 sudo dd if=path/to/p2v.iso of=/dev/sdX
.Ve

<a name="building-a-pxe-boot-image"></a>

# Building a Pxe Boot Image

.IX Header "BUILDING A PXE BOOT IMAGE"
To create a \s-1PXE\s0 boot image, run kiwi in such a way:

.Vb 1
 sudo kiwi --build $PWD/p2v.kiwi -d build --add-profile netboot --type pxe
.Ve

For more details on how to use the generated image, report to the kiwi documentation
on \s-1PXE\s0 images: https://doc.opensuse.org/projects/kiwi/doc/#chap.pxe

<a name="adding-an-ssh-identity"></a>

# Adding an Ssh Identity

.IX Header "ADDING AN SSH IDENTITY"
You can inject an \s-1SSH\s0 identity (private key) file to the kiwi config and
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

The private key should be added to the kiwi config and then
discarded:

.Vb 2
 virt-p2v-make-kiwi [...] --inject-ssh-identity id_rsa
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
* **-o** \s-1OUTPUT\s0  
  .IX Item "-o OUTPUT"
* **--output** \s-1OUTPUT\s0  
  .IX Item "--output OUTPUT"
  Write kiwi configuration to the \f(CW`OUTPUT\*(C' folder.  If not specified, the default is
  _p2v.kiwi_ in the current directory.
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
  The **virt-p2v**\|(1) binary which is copied into the kiwi configuration.
  .Sp
  The location of the binary can be changed by setting the
  \f(CW`VIRT\_P2V\_DATA\_DIR\*(C' environment variable.
* _\f(CI$datadir/virt-p2v/issue_  
  .IX Item "$datadir/virt-p2v/issue"
* _\f(CI$datadir/virt-p2v/launch-virt-p2v.in_  
  .IX Item "$datadir/virt-p2v/launch-virt-p2v.in"
* _\f(CI$datadir/virt-p2v/kiwi_  
  .IX Item "$datadir/virt-p2v/kiwi"
* _\f(CI$datadir/virt-p2v/p2v.service_  
  .IX Item "$datadir/virt-p2v/p2v.service"
  Various data files that are used to make the kiwi appliance.
  .Sp
  The location of these files can be changed by setting the
  \f(CW`VIRT\_P2V\_DATA\_DIR\*(C' environment variable.

<a name="environment-variables"></a>

# Environment Variables

.IX Header "ENVIRONMENT VARIABLES"
.ie n .IP """VIRT_P2V_DATA_DIR""" 4
.el .IP "\f(CWVIRT\_P2V\_DATA\_DIR" 4
.IX Item "VIRT_P2V_DATA_DIR"
The directory where virt-p2v-make-kiwi looks for data files and
the virt-p2v binary (see \s-1FILES\*(R"\s0 above).  If not set, a compiled-in
location is used.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**virt-p2v**\|(1),
**virt-p2v-make-disk**\|(1),
**virt-v2v**\|(1),
**kiwi**\|(1),
http://libguestfs.org/.

<a name="authors"></a>

# Authors

.IX Header "AUTHORS"
Cédric Bosdonnat

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright (C) 2016 \s-1SUSE\s0 Ltd.

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
