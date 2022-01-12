# guestmount(1)

libguestfs-1.40.2, 2019-02-07

.if n .ad l
.nh

<a name="name"></a>

# Name

guestmount - Mount a guest filesystem on the host using FUSE and libguestfs

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" .Vb 1  guestmount [--options] -a disk.img -m device [--ro] mountpoint   guestmount [--options] -a disk.img -i [--ro] mountpoint   guestmount [--options] -d Guest -i [--ro] mountpoint .Ve
```

<a name="warning"></a>

# Warning

.IX Header "WARNING"
Using \f(CW`guestmount\*(C' in write mode
on live virtual machines, or concurrently with other
disk editing tools, can be dangerous, potentially causing disk
corruption.  The virtual machine must be shut down before you use this
command, and disk images must not be edited concurrently.

Use the _--ro_ (read-only) option to use \f(CW`guestmount\*(C' safely if the disk
image or virtual machine might be live.  You may see strange or
inconsistent results if running concurrently with other changes, but
with this option you won't risk disk corruption.

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The guestmount program can be used to mount virtual machine
filesystems and other disk images on the host.  It uses libguestfs for
access to the guest filesystem, and \s-1FUSE\s0 (the filesystem in
userspace) to make it appear as a mountable device.

Along with other options, you have to give at least one device (_-a_
option) or libvirt domain (_-d_ option), and at least one mountpoint
(_-m_ option) or use the _-i_ inspection option or the _--live_
option.  How this works is better explained in the **guestfish**\|(1)
manual page, or by looking at the examples below.

\s-1FUSE\s0 lets you mount filesystems as non-root.  The mountpoint must be
owned by you.  The filesystem will not be visible to any other users
unless you make configuration changes, see \s-1NOTES\*(R"\s0 below.

To unmount the filesystem, use the **guestunmount**\|(1) command.

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
For a typical Windows guest which has its main filesystem on the
first partition:

.Vb 1
 guestmount -a windows.img -m /dev/sda1 --ro /mnt
.Ve

For a typical Linux guest which has a /boot filesystem on the first
partition, and the root filesystem on a logical volume:

.Vb 1
 guestmount -a linux.img -m /dev/VG/LV -m /dev/sda1:/boot --ro /mnt
.Ve

To get libguestfs to detect guest mountpoints for you:

.Vb 1
 guestmount -a guest.img -i --ro /mnt
.Ve

For a libvirt guest called Guest\*(R" you could do:

.Vb 1
 guestmount -d Guest -i --ro /mnt
.Ve

If you don’t know what filesystems are contained in a guest or
disk image, use **virt-filesystems**\|(1) first:

.Vb 1
 virt-filesystems -d MyGuest
.Ve

If you want to trace the libguestfs calls but without excessive
debugging information, we recommend:

.Vb 1
 guestmount [...] --trace /mnt
.Ve

If you want to debug the program, we recommend:

.Vb 1
 guestmount [...] --trace --verbose /mnt
.Ve

To unmount the filesystem after using it:

.Vb 1
 guestunmount /mnt
.Ve

<a name="notes"></a>

# Notes

.IX Header "NOTES"

<a name="other-users-cannot-see-the-filesystem-by-default"></a>

### Other users cannot see the filesystem by default

.IX Subsection "Other users cannot see the filesystem by default"
If you mount a filesystem as one user (eg. root), then other users
will not be able to see it by default.  The fix is to add the \s-1FUSE\s0
\f(CW`allow\_other\*(C' option when mounting:

.Vb 1
 sudo guestmount [...] -o allow_other /mnt
.Ve

**and** to enable this option in _/etc/fuse.conf_.

<a name="enabling-s-1fuses0"></a>

### Enabling \s-1FUSE\s0

.IX Subsection "Enabling FUSE"
On some distros, you may need to add yourself to a special group
(eg. \f(CW`fuse\*(C') before you can use any \s-1FUSE\s0 filesystem.  This is
necessary on Debian and derivatives.

On other distros, no special group is required.  It is not necessary
on Fedora or Red Hat Enterprise Linux.
.ie n .SS "fusermount error: ""Device or resource busy"""
.el .SS "fusermount error: \`\`Device or resource busy''"
.IX Subsection "fusermount error: Device or resource busy"
You can see this error when another process on the system jumps into
the mountpoint you have just created, holding it open and preventing
you from unmounting it.  The usual culprits are various \s-1GUI\s0 indexing\*(R"
programs.

The popular workaround for this problem is to retry the \f(CW`fusermount -u\*(C'
command a few times until it works (**guestunmount**\|(1) does this
for you).  Unfortunately this isn't a reliable fix if (for example)
the mounted filesystem is particularly large and the intruding program
particularly persistent.

A proper fix is to use a private mountpoint by creating a new mount
namespace using the Linux-specific **clone**\|(2)/**unshare**\|(2) flag
\f(CW`CLONE\_NEWNS\*(C'.  Unfortunately at the moment this requires root and we
would also probably need to add it as a feature to guestmount.

<a name="race-conditions-possible-when-shutting-down-the-connection"></a>

### Race conditions possible when shutting down the connection

.IX Subsection "Race conditions possible when shutting down the connection"
When **guestunmount**\|(1)/**fusermount**\|(1) exits, guestmount may still
be running and cleaning up the mountpoint.  The disk image will not be
fully finalized.

This means that scripts like the following have a nasty race
condition:

.Vb 4
 guestmount -a disk.img -i /mnt
 # copy things into /mnt
 guestunmount /mnt
 # immediately try to use disk.img\*(Aq ** UNSAFE **
.Ve

The solution is to use the _--pid-file_ option to write the
guestmount \s-1PID\s0 to a file, then after guestunmount spin waiting for
this \s-1PID\s0 to exit.

.Vb 1
 guestmount -a disk.img -i --pid-file guestmount.pid /mnt
 
 # ...
 # ...
 
 # Save the PID of guestmount *before* calling guestunmount.
 pid="$(cat guestmount.pid)"
 
 # Unmount the filesystem.
 guestunmount /mnt
 
 timeout=10
 
 count=$timeout
 while kill -0 "$pid" 2&gt;/dev/null && [ $count -gt 0 ]; do
     sleep 1
     ((count--))
 done
 if [ $count -eq 0 ]; then
     echo "$0: wait for guestmount to exit failed after $timeout seconds"
     exit 1
 fi
 
 # Now it is safe to use the disk image.
.Ve

Note that if you use the \f(CW`guestfs\_mount\_local\*(C' \s-1API\s0 directly (see
\s-1MOUNT LOCAL\*(R"\s0 in **guestfs**\|(3)) then it is much easier to write a safe,
race-free program.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **-a** \s-1IMAGE\s0  
  .IX Item "-a IMAGE"
* **--add** \s-1IMAGE\s0  
  .IX Item "--add IMAGE"
  Add a block device or virtual machine image.
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
  When used in conjunction with the _-d_ option, this specifies
  the libvirt \s-1URI\s0 to use.  The default is to use the default libvirt
  connection.
* **-d** LIBVIRT-DOMAIN  
  .IX Item "-d LIBVIRT-DOMAIN"
* **--domain** LIBVIRT-DOMAIN  
  .IX Item "--domain LIBVIRT-DOMAIN"
  Add disks from the named libvirt domain.  If the _--ro_ option is
  also used, then any libvirt domain can be used.  However in write
  mode, only libvirt domains which are shut down can be named here.
  .Sp
  Domain UUIDs can be used instead of names.
* **--dir-cache-timeout** N  
  .IX Item "--dir-cache-timeout N"
  Set the readdir cache timeout to _N_ seconds, the default being 60
  seconds.  The readdir cache [actually, there are several
  semi-independent caches] is populated after a **readdir**\|(2) call with the
  stat and extended attributes of the files in the directory, in
  anticipation that they will be requested soon after.
  .Sp
  There is also a different attribute cache implemented by \s-1FUSE\s0
  (see the \s-1FUSE\s0 option _-o attr\_timeout_), but the \s-1FUSE\s0 cache
  does not anticipate future requests, only cache existing ones.
* **--echo-keys**  
  .IX Item "--echo-keys"
  When prompting for keys and passphrases, guestfish normally turns
  echoing off so you cannot see what you are typing.  If you are not
  worried about Tempest attacks and there is no one else in the room
  you can specify this flag to see what you are typing.
* **--fd=**\s-1FD\s0  
  .IX Item "--fd=FD"
  Specify a pipe or eventfd file descriptor.  When the mountpoint is
  ready to be used, guestmount writes a single byte to this file
  descriptor.  This can be used in conjunction with _--no-fork_ in
  order to run guestmount captive under another process.
* **--format=raw|qcow2|..**  
  .IX Item "--format=raw|qcow2|.."
* **--format**  
  .IX Item "--format"
  The default for the _-a_ option is to auto-detect the format of the
  disk image.  Using this forces the disk format for _-a_ options which
  follow on the command line.  Using _--format_ with no argument
  switches back to auto-detection for subsequent _-a_ options.
  .Sp
  If you have untrusted raw-format guest disk images, you should use
  this option to specify the disk format.  This avoids a possible
  security problem with malicious guests (\s-1CVE-2010-3851\s0).  See also
  guestfs_add_drive_opts\*(R" in **guestfs**\|(3).
* **--fuse-help**  
  .IX Item "--fuse-help"
  Display help on special \s-1FUSE\s0 options (see _-o_ below).
* **--help**  
  .IX Item "--help"
  Display brief help and exit.
* **-i**  
  .IX Item "-i"
* **--inspector**  
  .IX Item "--inspector"
  Using **virt-inspector**\|(1) code, inspect the disks looking for
  an operating system and mount filesystems as they would be
  mounted on the real virtual machine.
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
* **--live**  
  .IX Item "--live"
  Connect to a live virtual machine.
  (Experimental, see \s-1ATTACHING TO RUNNING DAEMONS\*(R"\s0 in **guestfs**\|(3)).
* **-m** dev[:mountpoint[:options[:fstype]]  
  .IX Item "-m dev[:mountpoint[:options[:fstype]]"
* **--mount** dev[:mountpoint[:options[:fstype]]]  
  .IX Item "--mount dev[:mountpoint[:options[:fstype]]]"
  Mount the named partition or logical volume on the given mountpoint
  **in the guest** (this has nothing to do with mountpoints in the host).
  .Sp
  If the mountpoint is omitted, it defaults to _/_.  You have to mount
  something on _/_.
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
* **--no-fork**  
  .IX Item "--no-fork"
  Don’t daemonize (or fork into the background).
* **-n**  
  .IX Item "-n"
* **--no-sync**  
  .IX Item "--no-sync"
  By default, we attempt to sync the guest disk when the \s-1FUSE\s0 mountpoint
  is unmounted.  If you specify this option, then we don't attempt to
  sync the disk.  See the discussion of autosync in the **guestfs**\|(3)
  manpage.
* **-o** \s-1OPTION\s0  
  .IX Item "-o OPTION"
* **--option** \s-1OPTION\s0  
  .IX Item "--option OPTION"
  Pass extra options to \s-1FUSE.\s0
  .Sp
  To get a list of all the extra options supported by \s-1FUSE,\s0 use the
  command below.  Note that only the \s-1FUSE\s0 _-o_ options can be passed,
  and only some of them are a good idea.
  .Sp
  .Vb 1
   guestmount --fuse-help
  .Ve
  .Sp
  Some potentially useful \s-1FUSE\s0 options:
    * **-o** **allow\_other**  
      .IX Item "-o allow_other"
      Allow other users to see the filesystem.  This option has no effect
      unless you enable it globally in _/etc/fuse.conf_.
    * **-o** **attr\_timeout=N**  
      .IX Item "-o attr_timeout=N"
      Enable attribute caching by \s-1FUSE,\s0 and set the timeout to _N_ seconds.
    * **-o** **kernel\_cache**  
      .IX Item "-o kernel_cache"
      Allow the kernel to cache files (reduces the number of reads
      that have to go through the **guestfs**\|(3) \s-1API\s0).  This is generally
      a good idea if you can afford the extra memory usage.
    * **-o** **uid=N** **-o** **gid=N**  
      .IX Item "-o uid=N -o gid=N"
      Use these options to map all UIDs and GIDs inside the guest filesystem
      to the chosen values.
    * **-o** **use\_ino**  
      .IX Item "-o use_ino"
      Preserve inode numbers from the underlying filesystem.
      .Sp
      Without this option, \s-1FUSE\s0 makes up its own inode numbers.  The inode
      numbers you see in **stat**\|(2), \f(CW`ls -i\*(C' etc aren't the inode numbers
      of the underlying filesystem.
      .Sp
      **Note** this option is potentially dangerous if the underlying
      filesystem consists of multiple mountpoints, as you may see duplicate
      inode numbers appearing through \s-1FUSE.\s0  Use of this option can confuse
      some software.
* **--pid-file** \s-1FILENAME\s0  
  .IX Item "--pid-file FILENAME"
  Write the \s-1PID\s0 of the guestmount worker process to \f(CW`filename\*(C'.
* **-r**  
  .IX Item "-r"
* **--ro**  
  .IX Item "--ro"
  Add devices and mount everything read-only.  Also disallow writes and
  make the disk appear read-only to \s-1FUSE.\s0
  .Sp
  This is highly recommended if you are not going to edit the guest
  disk.  If the guest is running and this option is _not_ supplied,
  then there is a strong risk of disk corruption in the guest.  We try
  to prevent this from happening, but it is not always possible.
  .Sp
  See also \s-1OPENING DISKS FOR READ AND WRITE\*(R"\s0 in **guestfish**\|(1).
* **--selinux**  
  .IX Item "--selinux"
  This option is provided for backwards compatibility and does nothing.
* **-v**  
  .IX Item "-v"
* **--verbose**  
  .IX Item "--verbose"
  Enable verbose messages from underlying libguestfs.
* **-V**  
  .IX Item "-V"
* **--version**  
  .IX Item "--version"
  Display the program version and exit.
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
* **--trace**  
  .IX Item "--trace"
  Trace libguestfs calls and entry into each \s-1FUSE\s0 function.
  .Sp
  This also stops the daemon from forking into the background
  (see _--no-fork_).

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

<a name="exit-status"></a>

# Exit Status

.IX Header "EXIT STATUS"
This program returns 0 if successful, or non-zero if there was an
error.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**guestunmount**\|(1),
**fusermount**\|(1),
**guestfish**\|(1),
**virt-inspector**\|(1),
**virt-cat**\|(1),
**virt-edit**\|(1),
**virt-tar**\|(1),
**libguestfs-tools.conf**\|(5),
\s-1MOUNT LOCAL\*(R"\s0 in **guestfs**\|(3),
http://libguestfs.org/,
http://fuse.sf.net/.

<a name="authors"></a>

# Authors

.IX Header "AUTHORS"
Richard W.M. Jones (\f(CW`rjones at redhat dot com\*(C')

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
