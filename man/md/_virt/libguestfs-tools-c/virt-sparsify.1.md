# virt-sparsify(1)

libguestfs-1.40.2, 2019-02-07

.if n .ad l
.nh

<a name="name"></a>

# Name

virt-sparsify - Make a virtual machine disk sparse

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" .Vb 1  virt-sparsify [--options] indisk outdisk   virt-sparsify [--options] --in-place disk .Ve
```

<a name="warning"></a>

# Warning

.IX Header "WARNING"
Using \f(CW`virt-sparsify\*(C'
on live virtual machines, or concurrently with other
disk editing tools, can be dangerous, potentially causing disk
corruption.  The virtual machine must be shut down before you use this
command, and disk images must not be edited concurrently.

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
Virt-sparsify is a tool which can make a virtual machine disk (or any
disk image) sparse a.k.a. thin-provisioned.  This means that free
space within the disk image can be converted back to free space on the
host.

Virt-sparsify can locate and sparsify free space in most filesystems
(eg. ext2/3/4, btrfs, \s-1NTFS,\s0 etc.), and also in \s-1LVM\s0 physical volumes.

Virt-sparsify can also convert between some disk formats, for example
converting a raw disk image to a thin-provisioned qcow2 image.

Virt-sparsify can operate on any disk image, not just ones from
virtual machines.  However if a virtual machine has multiple disks
and uses volume management, then virt-sparsify will work but not be
very effective (http://bugzilla.redhat.com/887826).

<a name="s-1important-note-about-sparse-output-imagess0"></a>

### \s-1IMPORTANT NOTE ABOUT SPARSE OUTPUT IMAGES\s0

.IX Subsection "IMPORTANT NOTE ABOUT SPARSE OUTPUT IMAGES"
If the input is raw, then the default output is raw sparse.  You
must check the output size using a tool that understands sparseness
such as \f(CW`du -sh\*(C'.  It can make a huge difference:

.Vb 4
 $ ls -lh test1.img
 -rw-rw-r--. 1 rjones rjones 100M Aug  8 08:08 test1.img
 $ du -sh test1.img
 3.6M   test1.img
.Ve

(Compare the apparent size **100M** vs the actual size **3.6M**)

<a name="s-1important-limitationss0"></a>

### \s-1IMPORTANT LIMITATIONS\s0

.IX Subsection "IMPORTANT LIMITATIONS"

* ·  
  The virtual machine _must be shut down_ before using this tool.
* ·  
  Virt-sparsify may require up to 2x the virtual size of the source disk
  image (1 temporary copy + 1 destination image).  This is in the worst
  case and usually much less space is required.
  .Sp
  If you are using the _--in-place_ option, then large amounts of
  temporary space are **not** required.
* ·  
  Virt-sparsify cannot resize disk images.  To do that, use
  **virt-resize**\|(1).
* ·  
  Virt-sparsify cannot handle encrypted disks.  Libguestfs supports
  encrypted disks, but encrypted disks themselves cannot be sparsified.
* ·  
  Virt-sparsify cannot yet sparsify the space between partitions.  Note
  that this space is often used for critical items like bootloaders so
  it's not really unused.
* ·  
  In copy mode, qcow2 internal snapshots are not copied over to the
  destination image.

You may also want to read the manual pages for the associated tools
**virt-filesystems**\|(1) and **virt-df**\|(1) before starting.

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
Typical usage is:

.Vb 1
 virt-sparsify indisk outdisk
.Ve

which copies \f(CW`indisk\*(C' to \f(CW\*(C\`outdisk\*(C', making the output sparse.
\f(CW`outdisk\*(C' is created, or overwritten if it already exists.  The
format of the input disk is detected (eg. qcow2) and the same format
is used for the output disk.

To convert between formats, use the _--convert_ option:

.Vb 1
 virt-sparsify disk.raw --convert qcow2 disk.qcow2
.Ve

Virt-sparsify tries to zero and sparsify free space on every
filesystem it can find within the source disk image.  You can get it
to ignore (don't zero free space on) certain filesystems by doing:

.Vb 1
 virt-sparsify --ignore /dev/sda1 indisk outdisk
.Ve

See **virt-filesystems**\|(1) to get a list of filesystems within a disk
image.

Since virt-sparsify ≥ 1.26, you can now sparsify a disk image
in place by doing:

.Vb 1
 virt-sparsify --in-place disk.img
.Ve

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **--help**  
  .IX Item "--help"
  Display help.
* **--check-tmpdir** **ignore**  
  .IX Item "--check-tmpdir ignore"
* **--check-tmpdir** **continue**  
  .IX Item "--check-tmpdir continue"
* **--check-tmpdir** **warn**  
  .IX Item "--check-tmpdir warn"
* **--check-tmpdir** **fail**  
  .IX Item "--check-tmpdir fail"
  Check if \s-1TMPDIR\*(R"\s0 or _--tmp_ directory has enough space to complete
  the operation.  This is just an estimate.
  .Sp
  If the check indicates a problem, then you can either:
    * ·  
      **ignore** it,
    * ·  
      print a warning and **continue**,
    * ·  
      **warn** and wait for the user to press the Return key
      (this is the default), or:
    * ·  
      **fail** and exit.
      .Sp
      You cannot use this option and _--in-place_ together.
* **--colors**  
  .IX Item "--colors"
* **--colours**  
  .IX Item "--colours"
  Use \s-1ANSI\s0 colour sequences to colourize messages.  This is the default
  when the output is a tty.  If the output of the program is redirected
  to a file, \s-1ANSI\s0 colour sequences are disabled unless you use this
  option.
* **--compress**  
  .IX Item "--compress"
  Compress the output file.  This _only_ works if the output format is
  \f(CW`qcow2\*(C'.
  .Sp
  You cannot use this option and _--in-place_ together.
* **--convert** raw  
  .IX Item "--convert raw"
* **--convert** qcow2  
  .IX Item "--convert qcow2"
* **--convert** [other formats]  
  .IX Item "--convert [other formats]"
  Use \f(CW`output-format\*(C' as the format for the destination image.  If this
  is not specified, then the input format is used.
  .Sp
  Supported and known-working output formats are: \f(CW`raw\*(C', \f(CW\*(C\`qcow2\*(C', \f(CW\*(C\`vdi\*(C'.
  .Sp
  You can also use any format supported by the **qemu-img**\|(1) program,
  eg. \f(CW`vmdk\*(C', but support for other formats is reliant on qemu.
  .Sp
  Specifying the _--convert_ option is usually a good idea, because
  then virt-sparsify doesn't need to try to guess the input format.
  .Sp
  For fine-tuning the output format, see: _--compress_, _-o_.
  .Sp
  You cannot use this option and _--in-place_ together.
* **--echo-keys**  
  .IX Item "--echo-keys"
  When prompting for keys and passphrases, virt-sparsify normally turns
  echoing off so you cannot see what you are typing.  If you are not
  worried about Tempest attacks and there is no one else in the room
  you can specify this flag to see what you are typing.
* **--format** raw  
  .IX Item "--format raw"
* **--format** qcow2  
  .IX Item "--format qcow2"
  Specify the format of the input disk image.  If this flag is not
  given then it is auto-detected from the image itself.
  .Sp
  If working with untrusted raw-format guest disk images, you should
  ensure the format is always specified.
* **--ignore** filesystem  
  .IX Item "--ignore filesystem"
* **--ignore** volgroup  
  .IX Item "--ignore volgroup"
  Ignore the named filesystem.
  .Sp
  When not using _--in-place_: Free space on the filesystem will not be
  zeroed, but existing blocks of zeroes will still be sparsified.
  .Sp
  When using _--in-place_, the filesystem is ignored completely.
  .Sp
  In the second form, this ignores the named volume group.  Use the
  volume group name without the _/dev/_ prefix, eg. _--ignore vg\_foo_
  .Sp
  You can give this option multiple times.
* **--in-place**  
  .IX Item "--in-place"
  Do in-place sparsification instead of copying sparsification.
  See IN-PLACE \s-1SPARSIFICATION\*(R"\s0 below.
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
* **--machine-readable**  
  .IX Item "--machine-readable"
* **--machine-readable**=format  
  .IX Item "--machine-readable=format"
  This option is used to make the output more machine friendly
  when being parsed by other programs.  See
  \s-1MACHINE READABLE OUTPUT\*(R"\s0 below.
* **-o** option[,option,...]  
  .IX Item "-o option[,option,...]"
  Pass _-o_ option(s) to the **qemu-img**\|(1) command to fine-tune the
  output format.  Options available depend on the output format (see
  _--convert_) and the installed version of the qemu-img program.
  .Sp
  You should use _-o_ at most once.  To pass multiple options, separate
  them with commas, eg:
  .Sp
  .Vb 2
   virt-sparsify --convert qcow2 \e
     -o cluster_size=512,preallocation=metadata ...
  .Ve
  .Sp
  You cannot use this option and _--in-place_ together.
* **-q**  
  .IX Item "-q"
* **--quiet**  
  .IX Item "--quiet"
  This disables progress bars and other unnecessary output.
* **--tmp** block_device  
  .IX Item "--tmp block_device"
* **--tmp** dir  
  .IX Item "--tmp dir"
  In copying mode only, use the named device or directory as the
  location of the temporary overlay (see also \s-1TMPDIR\*(R"\s0 below).
  .Sp
  If the parameter given is a block device, then the block device is
  written to directly.
  **Note this erases the existing contents of the block device**.
  .Sp
  If the parameter is a directory, then this is the same as setting the
  \s-1TMPDIR\*(R"\s0 environment variable.
  .Sp
  You cannot use this option and _--in-place_ together.
* **--tmp** prebuilt:file  
  .IX Item "--tmp prebuilt:file"
  In copying mode only, the specialized option _--tmp prebuilt:file_
  (where \f(CW`prebuilt:\*(C' is a literal string) causes virt-sparsify to use
  the qcow2 \f(CW`file\*(C' as temporary space.
    * ·  
      The file **must** be freshly formatted as qcow2, with indisk as the
      backing file.
    * ·  
      If you rerun virt-sparsify, you **must** recreate the file before
      each run.
    * ·  
      Virt-sparsify does not delete the file.
      .Sp
      This option is used by oVirt which requires a specially formatted
      temporary file.
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
* **--zero** partition  
  .IX Item "--zero partition"
* **--zero** logvol  
  .IX Item "--zero logvol"
  Zero the contents of the named partition or logical volume in the
  guest.  All data on the device is lost, but sparsification is
  excellent!  You can give this option multiple times.

<a name="in-place-sparsification"></a>

# In-Place Sparsification

.IX Header "IN-PLACE SPARSIFICATION"
Since virt-sparsify ≥ 1.26, the tool is able to do in-place
sparsification (instead of copying from an input disk to an output
disk).  This is more efficient.  It is not able to recover quite as
much space as copying sparsification.

To use this mode, specify a disk image which will be modified in
place:

.Vb 1
 virt-sparsify --in-place disk.img
.Ve

Some options are not compatible with this mode: _--convert_,
_--compress_ and _-o_ because they require wholesale disk format
changes; _--check-tmpdir_ because large amounts of temporary space
are not required.

In-place sparsification works using discard (a.k.a trim or unmap)
support.

<a name="machine-readable-output"></a>

# Machine Readable Output

.IX Header "MACHINE READABLE OUTPUT"
The _--machine-readable_ option can be used to make the output more
machine friendly, which is useful when calling virt-sparsify from
other programs, GUIs etc.

There are two ways to use this option.

Firstly use the option on its own to query the capabilities of the
virt-sparsify binary.  Typical output looks like this:

.Vb 4
 $ virt-sparsify --machine-readable
 virt-sparsify
 ntfs
 btrfs
.Ve

A list of features is printed, one per line, and the program exits
with status 0.

Secondly use the option in conjunction with other options to make the
regular program output more machine friendly.

At the moment this means:

* 1.  
  Progress bar messages can be parsed from stdout by looking for this
  regular expression:
  .Sp
  .Vb 1
   ^[0-9]+/[0-9]+$
  .Ve
* 2.  
  The calling program should treat messages sent to stdout (except for
  progress bar messages) as status messages.  They can be logged and/or
  displayed to the user.
* 3.  
  The calling program should treat messages sent to stderr as error
  messages.  In addition, virt-sparsify exits with a non-zero status
  code if there was a fatal error.

All versions of virt-sparsify have supported the _--machine-readable_
option.

It is possible to specify a format string for controlling the output;
see \s-1ADVANCED MACHINE READABLE OUTPUT\*(R"\s0 in **guestfs**\|(3).

<a name="windows-8"></a>

# Windows 8

.IX Header "WINDOWS 8"
Windows 8 fast startup\*(R" can prevent virt-sparsify from working.
See \s-1WINDOWS HIBERNATION AND WINDOWS 8 FAST STARTUP\*(R"\s0 in **guestfs**\|(3).

<a name="environment-variables"></a>

# Environment Variables

.IX Header "ENVIRONMENT VARIABLES"

* \s-1TMPDIR\s0  
  .IX Item "TMPDIR"
  Location of the temporary directory used for the potentially large
  temporary overlay file.
  .Sp
  In virt-sparsify ≥ 1.28, you can override this environment
  variable using the _--tmp_ option.
  .Sp
  You should ensure there is enough free space in the worst case for a
  full copy of the source disk (_virtual_ size), or else set \f(CW$TMPDIR
  to point to another directory that has enough space.
  .Sp
  This defaults to _/tmp_.
  .Sp
  Note that if \f(CW$TMPDIR is a tmpfs (eg. if _/tmp_ is on tmpfs, or if
  you use \f(CW`TMPDIR=/dev/shm\*(C'), tmpfs defaults to a maximum size of
  _half_ of physical \s-1RAM.\s0  If virt-sparsify exceeds this, it will hang.
  The solution is either to use a real disk, or to increase the maximum
  size of the tmpfs mountpoint, eg:
  .Sp
  .Vb 1
   mount -o remount,size=10G /tmp
  .Ve
  .Sp
  If you are using the _--in-place_ option, then large amounts of
  temporary space are **not** required.

For other environment variables, see \s-1ENVIRONMENT VARIABLES\*(R"\s0 in **guestfs**\|(3).

<a name="exit-status"></a>

# Exit Status

.IX Header "EXIT STATUS"
This program returns 0 if the operation completed without errors.
(This doesn't necessarily mean that space could be freed up.)

A non-zero exit code indicates an error.

If the exit code is \f(CW3 and the _--in-place_ option was used, that
indicates that discard support is not available in libguestfs, so
copying mode must be used instead.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**virt-df**\|(1),
**virt-filesystems**\|(1),
**virt-resize**\|(1),
**virt-rescue**\|(1),
**guestfs**\|(3),
**guestfish**\|(1),
**truncate**\|(1),
**fallocate**\|(1),
**qemu-img**\|(1),
http://libguestfs.org/.

<a name="author"></a>

# Author

.IX Header "AUTHOR"
Richard W.M. Jones http://people.redhat.com/~rjones/

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright (C) 2011-2019 Red Hat Inc.

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
