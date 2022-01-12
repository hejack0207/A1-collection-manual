# virt-rescue(1)

libguestfs-1.40.2, 2019-02-07

.if n .ad l
.nh

<a name="name"></a>

# Name

virt-rescue - Run a rescue shell on a virtual machine

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" .Vb 1  virt-rescue [--options] -d domname   virt-rescue [--options] -a disk.img [-a disk.img ...] [-i] .Ve 
 Old style: 
 .Vb 1  virt-rescue [--options] domname   virt-rescue [--options] disk.img [disk.img ...] .Ve
```

<a name="warning"></a>

# Warning

.IX Header "WARNING"
Using \f(CW`virt-rescue\*(C' in write mode
on live virtual machines, or concurrently with other
disk editing tools, can be dangerous, potentially causing disk
corruption.  The virtual machine must be shut down before you use this
command, and disk images must not be edited concurrently.

Use the _--ro_ (read-only) option to use \f(CW`virt-rescue\*(C' safely if the disk
image or virtual machine might be live.  You may see strange or
inconsistent results if running concurrently with other changes, but
with this option you won't risk disk corruption.

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
virt-rescue is like a Rescue \s-1CD,\s0 but for virtual machines, and without
the need for a \s-1CD.\s0  virt-rescue gives you a rescue shell and some
simple recovery tools which you can use to examine or rescue a virtual
machine or disk image.

You can run virt-rescue on any virtual machine known to libvirt, or
directly on disk image(s):

.Vb 1
 virt-rescue -d GuestName -i

 virt-rescue --ro -a /path/to/disk.img -i

 virt-rescue -a /dev/sdc
.Ve

For live VMs you _must_ use the _--ro_ option.

When you run virt-rescue on a virtual machine or disk image, you are
placed in an interactive bash shell where you can use many ordinary
Linux commands.  What you see in _/_ (_/bin_, _/lib_ etc) is the
rescue appliance.  You must mount the virtual machine’s filesystems.
There is an empty directory called _/sysroot_ where you can mount
filesystems.

To automatically mount the virtual machine’s filesystems under
_/sysroot_ use the _-i_ option.  This uses libguestfs inspection to
find the filesystems and mount them in the right place.  You can also
mount filesystems individually using the _-m_ option.

Another way is to list the logical volumes (with **lvs**\|(8)) and
partitions (with **parted**\|(8)) and mount them by hand:

.Vb 7
 &gt;&lt;rescue&gt; lvs
 LV      VG        Attr   LSize   Origin Snap%  Move Log Copy%  Convert
 lv_root vg_f15x32 -wi-a-   8.83G
 lv_swap vg_f15x32 -wi-a- 992.00M
 &gt;&lt;rescue&gt; mount /dev/vg_f15x32/lv_root /sysroot
 &gt;&lt;rescue&gt; mount /dev/vda1 /sysroot/boot
 &gt;&lt;rescue&gt; ls /sysroot
.Ve

Another command to list available filesystems is
**virt-filesystems**\|(1).

To run commands in a Linux guest (for example, grub), you should
chroot into the /sysroot directory first:

.Vb 1
 &gt;&lt;rescue&gt; chroot /sysroot
.Ve

<a name="s-1notess0"></a>

### \s-1NOTES\s0

.IX Subsection "NOTES"
Virt-rescue can be used on _any_ disk image file or device, not just
a virtual machine.  For example you can use it on a blank file if you
want to partition that file (although we would recommend using
**guestfish**\|(1) instead as it is more suitable for this purpose).  You
can even use virt-rescue on things like \s-1USB\s0 drives, \s-1SD\s0 cards and hard
disks.

You can get virt-rescue to give you scratch disk(s) to play with.
This is useful for testing out Linux utilities (see _--scratch_).

Virt-rescue does not require root.  You only need to run it as root if
you need root to open the disk image.

This tool is just designed for quick interactive hacking on a virtual
machine.  For more structured access to a virtual machine disk image,
you should use **guestfs**\|(3).  To get a structured shell that you can
use to make scripted changes to guests, use **guestfish**\|(1).

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **--help**  
  .IX Item "--help"
  Display brief help.
* **-a** \s-1FILE\s0  
  .IX Item "-a FILE"
* **--add** \s-1FILE\s0  
  .IX Item "--add FILE"
  Add \f(CW`FILE\*(C' which should be a disk image from a virtual machine.  If
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
* **--append** \s-1KERNELOPTS\s0  
  .IX Item "--append KERNELOPTS"
  Pass additional options to the rescue kernel.
* **-c** \s-1URI\s0  
  .IX Item "-c URI"
* **--connect** \s-1URI\s0  
  .IX Item "--connect URI"
  If using libvirt, connect to the given _\s-1URI\s0_.  If omitted, then we
  connect to the default libvirt hypervisor.
  .Sp
  If you specify guest block devices directly (_-a_), then libvirt is
  not used at all.
* **-d** guest  
  .IX Item "-d guest"
* **--domain** guest  
  .IX Item "--domain guest"
  Add all the disks from the named libvirt guest.  Domain UUIDs can be
  used instead of names.
* **-e none**  
  .IX Item "-e none"
  Disable the escape key.
* **-e** \s-1KEY\s0  
  .IX Item "-e KEY"
  Set the escape key to the given key sequence.  The default is \f(CW`^]\*(C'.
  To specify the escape key you can use:
      .ie n .IP """^x""" 4
      .el .IP "\f(CW^x" 4
      .IX Item "^x"
      Control key + \f(CW`x\*(C' key.
      .ie n .IP """none""" 4
      .el .IP "\f(CWnone" 4
      .IX Item "none"
      _-e none_ means there is no escape key, escapes are disabled.
      .Sp
      See \s-1ESCAPE KEY\*(R"\s0 below for further information.
* **--format=raw|qcow2|..**  
  .IX Item "--format=raw|qcow2|.."
* **--format**  
  .IX Item "--format"
  The default for the _-a_ option is to auto-detect the format of the
  disk image.  Using this forces the disk format for _-a_ options which
  follow on the command line.  Using _--format_ with no argument
  switches back to auto-detection for subsequent _-a_ options.
  .Sp
  For example:
  .Sp
  .Vb 1
   virt-rescue --format=raw -a disk.img
  .Ve
  .Sp
  forces raw format (no auto-detection) for _disk.img_.
  .Sp
  .Vb 1
   virt-rescue --format=raw -a disk.img --format -a another.img
  .Ve
  .Sp
  forces raw format (no auto-detection) for _disk.img_ and reverts to
  auto-detection for _another.img_.
  .Sp
  If you have untrusted raw-format guest disk images, you should use
  this option to specify the disk format.  This avoids a possible
  security problem with malicious guests (\s-1CVE-2010-3851\s0).
* **-i**  
  .IX Item "-i"
* **--inspector**  
  .IX Item "--inspector"
  Using **virt-inspector**\|(1) code, inspect the disks looking for
  an operating system and mount filesystems as they would be
  mounted on the real virtual machine.
  .Sp
  The filesystems are mounted on _/sysroot_ in the rescue environment.
* **--memsize** \s-1MB\s0  
  .IX Item "--memsize MB"
  Change the amount of memory allocated to the rescue system.  The
  default is set by libguestfs and is small but adequate for running
  system tools.  The occasional program might need more memory.  The
  parameter is specified in megabytes.
* **-m** dev[:mountpoint[:options[:fstype]]]  
  .IX Item "-m dev[:mountpoint[:options[:fstype]]]"
* **--mount** dev[:mountpoint[:options[:fstype]]]  
  .IX Item "--mount dev[:mountpoint[:options[:fstype]]]"
  Mount the named partition or logical volume on the given mountpoint
  **in the guest** (this has nothing to do with mountpoints in the host).
  .Sp
  If the mountpoint is omitted, it defaults to _/_.  You have to mount
  something on _/_.
  .Sp
  The filesystems are mounted under _/sysroot_ in the rescue environment.
  .Sp
  The third (and rarely used) part of the mount parameter is the list of
  mount options used to mount the underlying filesystem.  If this is not
  given, then the mount options are either the empty string or \f(CW`ro\*(C'
  (the latter if the _--ro_ flag is used).  By specifying the mount
  options, you override this default choice.  Probably the only time you
  would use this is to enable ACLs and/or extended attributes if the
  filesystem can support them:
  .Sp
  .Vb 1
   -m /dev/sda1:/:acl,user_xattr
  .Ve
  .Sp
  The fourth part of the parameter is the filesystem driver to use, such
  as \f(CW`ext3\*(C' or \f(CW\*(C\`ntfs\*(C'. This is rarely needed, but can be useful if
  multiple drivers are valid for a filesystem (eg: \f(CW`ext2\*(C' and \f(CW\*(C\`ext3\*(C'),
  or if libguestfs misidentifies a filesystem.
* **--network**  
  .IX Item "--network"
  Enable \s-1QEMU\s0 user networking in the guest.  See \s-1NETWORK\*(R"\s0.
* **-r**  
  .IX Item "-r"
* **--ro**  
  .IX Item "--ro"
  Open the image read-only.
  .Sp
  The option must always be used if the disk image or virtual machine
  might be running, and is generally recommended in cases where you
  don't need write access to the disk.
  .Sp
  See also \s-1OPENING DISKS FOR READ AND WRITE\*(R"\s0 in **guestfish**\|(1).
* **--scratch**  
  .IX Item "--scratch"
* **--scratch=N**  
  .IX Item "--scratch=N"
  The _--scratch_ option adds a large scratch disk to the rescue
  appliance.  _--scratch=N_ adds \f(CW`N\*(C' scratch disks.  The scratch
  disk(s) are deleted automatically when virt-rescue exits.
  .Sp
  You can also mix _-a_, _-d_ and _--scratch_ options.  The scratch
  disk(s) are added to the appliance in the order they appear on the
  command line.
* **--selinux**  
  .IX Item "--selinux"
  This option is provided for backwards compatibility and does nothing.
* **--smp** N  
  .IX Item "--smp N"
  Enable N ≥ 2 virtual CPUs in the rescue appliance.
* **--suggest**  
  .IX Item "--suggest"
  This option was used in older versions of virt-rescue to suggest what
  commands you could use to mount filesystems under _/sysroot_.  For
  the current version of virt-rescue, it is easier to use the _-i_
  option instead.
  .Sp
  This option implies _--ro_ and is safe to use even if the guest is up
  or if another virt-rescue is running.
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
* **-w**  
  .IX Item "-w"
* **--rw**  
  .IX Item "--rw"
  This changes the _-a_, _-d_ and _-m_ options so that disks are
  added and mounts are done read-write.
  .Sp
  See \s-1OPENING DISKS FOR READ AND WRITE\*(R"\s0 in **guestfish**\|(1).
* **-x**  
  .IX Item "-x"
  Enable tracing of libguestfs \s-1API\s0 calls.

<a name="old-style-command-line-arguments"></a>

# Old-Style Command Line Arguments

.IX Header "OLD-STYLE COMMAND LINE ARGUMENTS"
Previous versions of virt-rescue allowed you to write either:

.Vb 1
 virt-rescue disk.img [disk.img ...]
.Ve

or

.Vb 1
 virt-rescue guestname
.Ve

whereas in this version you should use _-a_ or _-d_ respectively
to avoid the confusing case where a disk image might have the same
name as a guest.

For compatibility the old style is still supported.

<a name="network"></a>

# Network

.IX Header "NETWORK"
Adding the _--network_ option enables \s-1QEMU\s0 user networking
in the rescue appliance.  There are some differences between
user networking and ordinary networking:

* ping does not work  
  .IX Item "ping does not work"
  Because the \s-1ICMP ECHO_REQUEST\s0 protocol generally requires root in
  order to send the ping packets, and because virt-rescue must be able
  to run as non-root, \s-1QEMU\s0 user networking is not able to emulate the
  **ping**\|(8) command.  The ping command will appear to resolve addresses
  but will not be able to send or receive any packets.  This does not
  mean that the network is not working.
* cannot receive connections  
  .IX Item "cannot receive connections"
  \s-1QEMU\s0 user networking cannot receive incoming connections.
* making \s-1TCP\s0 connections  
  .IX Item "making TCP connections"
  The virt-rescue appliance needs to be small and so does not include
  many network tools.  In particular there is no **telnet**\|(1) command.
  You can make \s-1TCP\s0 connections from the shell using the magical
  _/dev/tcp/&lt;hostname&gt;/&lt;port&gt;_ syntax:
  .Sp
  .Vb 3
   exec 3&lt;&gt;/dev/tcp/redhat.com/80
   echo "GET /" &gt;&3
   cat &lt;&3
  .Ve
  .Sp
  See **bash**\|(1) for more details.

<a name="escape-key"></a>

# Escape Key

.IX Header "ESCAPE KEY"
Virt-rescue supports various keyboard escape sequences which are
entered by pressing \f(CW`^]\*(C' (Control key + \f(CW\*(C\`]\*(C' key).

You can change the escape key using the _-e_ option on the command
line (see above), and you can disable escapes completely using
_-e none_.  The rest of this section assumes the default escape key.

The following escapes can be used:
.ie n .IP """^] ?""" 4
.el .IP "\f(CW^] ?" 4
.IX Item "^] ?"
.ie n .IP """^] h""" 4
.el .IP "\f(CW^] h" 4
.IX Item "^] h"
Prints a brief help text about escape sequences.
.ie n .IP """^] i""" 4
.el .IP "\f(CW^] i" 4
.IX Item "^] i"
Prints brief libguestfs inspection information for the guest.  This
only works if you used _-i_ on the virt-rescue command line.
.ie n .IP """^] q""" 4
.el .IP "\f(CW^] q" 4
.IX Item "^] q"
.ie n .IP """^] x""" 4
.el .IP "\f(CW^] x" 4
.IX Item "^] x"
Quits virt-rescue immediately.
.ie n .IP """^] s""" 4
.el .IP "\f(CW^] s" 4
.IX Item "^] s"
Synchronize the filesystems (sync).
.ie n .IP """^] u""" 4
.el .IP "\f(CW^] u" 4
.IX Item "^] u"
Unmounts all the filesystems, except for the root (appliance)
filesystems.
.ie n .IP """^] z""" 4
.el .IP "\f(CW^] z" 4
.IX Item "^] z"
Suspend virt-rescue (like pressing \f(CW`^Z\*(C' except that it affects
virt-rescue rather than the program inside the rescue shell).
.ie n .IP """^] ^]""" 4
.el .IP "\f(CW^] ^]" 4
.IX Item "^] ^]"
Sends the literal character \f(CW`^]\*(C' (\s-1ASCII\s0 0x1d) through to the rescue
shell.

<a name="capturing-core-dumps"></a>

# Capturing Core Dumps

.IX Header "CAPTURING CORE DUMPS"
If you are testing a tool inside virt-rescue and the tool (**not**
virt-rescue) segfaults, it can be tricky to capture the core dump
outside virt-rescue for later analysis.  This section describes one
way to do this.

* 1.  
  Create a scratch disk for core dumps:
  .Sp
  .Vb 3
   truncate -s 4G /tmp/corefiles
   virt-format --partition=mbr --filesystem=ext2 -a /tmp/corefiles
   virt-filesystems -a /tmp/corefiles --all --long -h
  .Ve
* 2.  
  When starting virt-rescue, attach the core files disk last:
  .Sp
  .Vb 1
   virt-rescue --rw [-a ...] -a /tmp/corefiles
  .Ve
  .Sp
  **\s-1NB.\s0** If you use the _--ro_ option, then virt-rescue will silently
  not write any core files to _/tmp/corefiles_.
* 3.  
  Inside virt-rescue, mount the core files disk.  Note replace
  _/dev/sdb1_ with the last disk index.  For example if the core files
  disk is the last of four disks, you would use _/dev/sdd1_.
  .Sp
  .Vb 2
   &gt;&lt;rescue&gt; mkdir /tmp/mnt
   &gt;&lt;rescue&gt; mount /dev/sdb1 /tmp/mnt
  .Ve
* 4.  
  Enable core dumps in the rescue kernel:
  .Sp
  .Vb 3
   &gt;&lt;rescue&gt; echo /tmp/mnt/core.%p\*(Aq &gt; /proc/sys/kernel/core_pattern
   &gt;&lt;rescue&gt; ulimit -Hc unlimited
   &gt;&lt;rescue&gt; ulimit -Sc unlimited
  .Ve
* 5.  
  Run the tool that caused the core dump.  The core dump will be written
  to _/tmp/mnt/core.\s-1PID\s0_.
  .Sp
  .Vb 4
   &gt;&lt;rescue&gt; ls -l /tmp/mnt
   total 1628
   -rw------- 1 root root 1941504 Dec  7 13:13 core.130
   drwx------ 2 root root   16384 Dec  7 13:00 lost+found
  .Ve
* 6.  
  Before exiting virt-rescue, unmount (or at least sync) the disks:
  .Sp
  .Vb 2
   &gt;&lt;rescue&gt; umount /tmp/mnt
   &gt;&lt;rescue&gt; exit
  .Ve
* 7.  
  Outside virt-rescue, the core dump(s) can be removed from the disk
  using **guestfish**\|(1).  For example:
  .Sp
  .Vb 3
   guestfish --ro -a /tmp/corefiles -m /dev/sda1
   &gt;&lt;fs&gt; ll /
   &gt;&lt;fs&gt; download /core.NNN /tmp/core.NNN
  .Ve

<a name="environment-variables"></a>

# Environment Variables

.IX Header "ENVIRONMENT VARIABLES"
Several environment variables affect virt-rescue.  See
\s-1ENVIRONMENT VARIABLES\*(R"\s0 in **guestfs**\|(3) for the complete list.

<a name="files"></a>

# Files

.IX Header "FILES"
.ie n .IP "$XDG_CONFIG_HOME/libguestfs/libguestfs-tools.conf" 4
.el .IP "\f(CW$XDG\_CONFIG\_HOME/libguestfs/libguestfs-tools.conf" 4
.IX Item "$XDG_CONFIG_HOME/libguestfs/libguestfs-tools.conf"
.ie n .IP "$HOME/.libguestfs-tools.rc" 4
.el .IP "\f(CW$HOME/.libguestfs-tools.rc" 4
.IX Item "$HOME/.libguestfs-tools.rc"
.ie n .IP "$XDG_CONFIG_DIRS/libguestfs/libguestfs-tools.conf" 4
.el .IP "\f(CW$XDG\_CONFIG\_DIRS/libguestfs/libguestfs-tools.conf" 4
.IX Item "$XDG_CONFIG_DIRS/libguestfs/libguestfs-tools.conf"

* /etc/libguestfs-tools.conf  
  .IX Item "/etc/libguestfs-tools.conf"
  This configuration file controls the default read-only or read-write
  mode (_--ro_ or _--rw_).
  .Sp
  See **libguestfs-tools.conf**\|(5).

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**guestfs**\|(3),
**guestfish**\|(1),
**virt-cat**\|(1),
**virt-edit**\|(1),
**virt-filesystems**\|(1),
**libguestfs-tools.conf**\|(5),
http://libguestfs.org/.

<a name="author"></a>

# Author

.IX Header "AUTHOR"
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
