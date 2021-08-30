# guestfish(1)

libguestfs-1.40.2, 2019-02-07

.if n .ad l
.nh

<a name="name"></a>

# Name

guestfish - the guest filesystem shell

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" .Vb 1  guestfish [--options] [commands]   guestfish   guestfish [--ro|--rw] -a disk.img   guestfish [--ro|--rw] -a disk.img -m dev[:mountpoint]   guestfish -d libvirt-domain   guestfish [--ro|--rw] -a disk.img -i   guestfish -d libvirt-domain -i .Ve
```

<a name="warning"></a>

# Warning

.IX Header "WARNING"
Using \f(CW`guestfish\*(C' in write mode
on live virtual machines, or concurrently with other
disk editing tools, can be dangerous, potentially causing disk
corruption.  The virtual machine must be shut down before you use this
command, and disk images must not be edited concurrently.

Use the _--ro_ (read-only) option to use \f(CW`guestfish\*(C' safely if the disk
image or virtual machine might be live.  You may see strange or
inconsistent results if running concurrently with other changes, but
with this option you won't risk disk corruption.

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
Guestfish is a shell and command-line tool for examining and modifying
virtual machine filesystems.  It uses libguestfs and exposes all of
the functionality of the guestfs \s-1API,\s0 see **guestfs**\|(3).

Guestfish gives you structured access to the libguestfs \s-1API,\s0 from
shell scripts or the command line or interactively.  If you want to
rescue a broken virtual machine image, you should look at the
**virt-rescue**\|(1) command.

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"

<a name="as-an-interactive-shell"></a>

### As an interactive shell

.IX Subsection "As an interactive shell"
.Vb 1
 $ guestfish
 
 Welcome to guestfish, the guest filesystem shell for
 editing virtual machine filesystems.
 
 Type: help\*(Aq for a list of commands
       man\*(Aq to read the manual
       quit\*(Aq to quit the shell
 
 &gt;&lt;fs&gt; add-ro disk.img
 &gt;&lt;fs&gt; run
 &gt;&lt;fs&gt; list-filesystems
 /dev/sda1: ext4
 /dev/vg_guest/lv_root: ext4
 /dev/vg_guest/lv_swap: swap
 &gt;&lt;fs&gt; mount /dev/vg_guest/lv_root /
 &gt;&lt;fs&gt; cat /etc/fstab
 # /etc/fstab
 # Created by anaconda
 [...]
 &gt;&lt;fs&gt; exit
.Ve

<a name="from-shell-scripts"></a>

### From shell scripts

.IX Subsection "From shell scripts"
Create a new _/etc/motd_ file in a guest or disk image:

.Vb 6
 guestfish &lt;&lt;_EOF_
 add disk.img
 run
 mount /dev/vg_guest/lv_root /
 write /etc/motd "Welcome, new users"
 _EOF_
.Ve

List the \s-1LVM\s0 logical volumes in a disk image:

.Vb 4
 guestfish -a disk.img --ro &lt;&lt;_EOF_
 run
 lvs
 _EOF_
.Ve

List all the filesystems in a disk image:

.Vb 4
 guestfish -a disk.img --ro &lt;&lt;_EOF_
 run
 list-filesystems
 _EOF_
.Ve

<a name="on-one-command-line"></a>

### On one command line

.IX Subsection "On one command line"
Update _/etc/resolv.conf_ in a guest:

.Vb 3
 guestfish \e
   add disk.img : run : mount /dev/vg_guest/lv_root / : \e
   write /etc/resolv.conf "nameserver 1.2.3.4"
.Ve

Edit _/boot/grub/grub.conf_ interactively:

.Vb 4
 guestfish --rw --add disk.img \e
   --mount /dev/vg_guest/lv_root \e
   --mount /dev/sda1:/boot \e
   edit /boot/grub/grub.conf
.Ve

<a name="mount-disks-automatically"></a>

### Mount disks automatically

.IX Subsection "Mount disks automatically"
Use the _-i_ option to automatically mount the
disks from a virtual machine:

.Vb 1
 guestfish --ro -a disk.img -i cat /etc/group

 guestfish --ro -d libvirt-domain -i cat /etc/group
.Ve

Another way to edit _/boot/grub/grub.conf_ interactively is:

.Vb 1
 guestfish --rw -a disk.img -i edit /boot/grub/grub.conf
.Ve

<a name="as-a-script-interpreter"></a>

### As a script interpreter

.IX Subsection "As a script interpreter"
Create a 100MB disk containing an ext2-formatted partition:

.Vb 5
 #!/usr/bin/guestfish -f
 sparse test1.img 100M
 run
 part-disk /dev/sda mbr
 mkfs ext2 /dev/sda1
.Ve

<a name="start-with-a-prepared-disk"></a>

### Start with a prepared disk

.IX Subsection "Start with a prepared disk"
Create a 1G disk called _test1.img_ containing a single
ext2-formatted partition:

.Vb 1
 guestfish -N fs
.Ve

To list what is available do:

.Vb 1
 guestfish -N help | less
.Ve

<a name="remote-drives"></a>

### Remote drives

.IX Subsection "Remote drives"
Access a remote disk using ssh:

.Vb 1
 guestfish -a ssh://example.com/path/to/disk.img
.Ve

<a name="remote-control"></a>

### Remote control

.IX Subsection "Remote control"
.Vb 4
 eval "\\`guestfish --listen\\`"
 guestfish --remote add-ro disk.img
 guestfish --remote run
 guestfish --remote lvs
.Ve

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **--help**  
  .IX Item "--help"
  Displays general help on options.
* **-h**  
  .IX Item "-h"
* **--cmd-help**  
  .IX Item "--cmd-help"
  Lists all available guestfish commands.
* **-h** \s-1CMD\s0  
  .IX Item "-h CMD"
* **--cmd-help** \s-1CMD\s0  
  .IX Item "--cmd-help CMD"
  Displays detailed help on a single command \f(CW`cmd\*(C'.
* **-a** \s-1IMAGE\s0  
  .IX Item "-a IMAGE"
* **--add** \s-1IMAGE\s0  
  .IX Item "--add IMAGE"
  Add a block device or virtual machine image to the shell.
  .Sp
  The format of the disk image is auto-detected.  To override this and
  force a particular format use the _--format=.._ option.
  .Sp
  Using this flag is mostly equivalent to using the \f(CW`add\*(C' command,
  with \f(CW`readonly:true\*(C' if the _--ro_ flag was given, and
  with \f(CW`format:...\*(C' if the _--format=..._ flag was given.
* **-a** \s-1URI\s0  
  .IX Item "-a URI"
* **--add** \s-1URI\s0  
  .IX Item "--add URI"
  Add a remote disk.  See \s-1ADDING REMOTE STORAGE\*(R"\s0.
* **-c** \s-1URI\s0  
  .IX Item "-c URI"
* **--connect** \s-1URI\s0  
  .IX Item "--connect URI"
  When used in conjunction with the _-d_ option, this specifies
  the libvirt \s-1URI\s0 to use.  The default is to use the default libvirt
  connection.
* **--csh**  
  .IX Item "--csh"
  If using the _--listen_ option and a csh-like shell, use this option.
  See section \s-1REMOTE CONTROL AND CSH\*(R"\s0 below.
* **-d** LIBVIRT-DOMAIN  
  .IX Item "-d LIBVIRT-DOMAIN"
* **--domain** LIBVIRT-DOMAIN  
  .IX Item "--domain LIBVIRT-DOMAIN"
  Add disks from the named libvirt domain.  If the _--ro_ option is
  also used, then any libvirt domain can be used.  However in write
  mode, only libvirt domains which are shut down can be named here.
  .Sp
  Domain UUIDs can be used instead of names.
  .Sp
  Using this flag is mostly equivalent to using the \f(CW`add-domain\*(C' command,
  with \f(CW`readonly:true\*(C' if the _--ro_ flag was given, and
  with \f(CW`format:...\*(C' if the _--format=..._ flag was given.
* **--echo-keys**  
  .IX Item "--echo-keys"
  When prompting for keys and passphrases, guestfish normally turns
  echoing off so you cannot see what you are typing.  If you are not
  worried about Tempest attacks and there is no one else in the room
  you can specify this flag to see what you are typing.
* **-f** \s-1FILE\s0  
  .IX Item "-f FILE"
* **--file** \s-1FILE\s0  
  .IX Item "--file FILE"
  Read commands from \f(CW`FILE\*(C'.  To write pure guestfish
  scripts, use:
  .Sp
  .Vb 1
   #!/usr/bin/guestfish -f
  .Ve
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
   guestfish --format=raw -a disk.img
  .Ve
  .Sp
  forces raw format (no auto-detection) for _disk.img_.
  .Sp
  .Vb 1
   guestfish --format=raw -a disk.img --format -a another.img
  .Ve
  .Sp
  forces raw format (no auto-detection) for _disk.img_ and reverts to
  auto-detection for _another.img_.
  .Sp
  If you have untrusted raw-format guest disk images, you should use
  this option to specify the disk format.  This avoids a possible
  security problem with malicious guests (\s-1CVE-2010-3851\s0).  See also
  add\*(R".
* **-i**  
  .IX Item "-i"
* **--inspector**  
  .IX Item "--inspector"
  Using **virt-inspector**\|(1) code, inspect the disks looking for
  an operating system and mount filesystems as they would be
  mounted on the real virtual machine.
  .Sp
  Typical usage is either:
  .Sp
  .Vb 1
   guestfish -d myguest -i
  .Ve
  .Sp
  (for an inactive libvirt domain called _myguest_), or:
  .Sp
  .Vb 1
   guestfish --ro -d myguest -i
  .Ve
  .Sp
  (for active domains, readonly), or specify the block device directly:
  .Sp
  .Vb 1
   guestfish --rw -a /dev/Guests/MyGuest -i
  .Ve
  .Sp
  Note that the command line syntax changed slightly over older
  versions of guestfish.  You can still use the old syntax:
  .Sp
  .Vb 1
   guestfish [--ro] -i disk.img
  
   guestfish [--ro] -i libvirt-domain
  .Ve
  .Sp
  Using this flag is mostly equivalent to using the \f(CW`inspect-os\*(C'
  command and then using other commands to mount the filesystems that
  were found.
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
* **--listen**  
  .IX Item "--listen"
  Fork into the background and listen for remote commands.  See section
  \s-1REMOTE CONTROL GUESTFISH OVER A SOCKET\*(R"\s0 below.
* **--live**  
  .IX Item "--live"
  Connect to a live virtual machine.
  (Experimental, see \s-1ATTACHING TO RUNNING DAEMONS\*(R"\s0 in **guestfs**\|(3)).
* **-m** dev[:mountpoint[:options[:fstype]]]  
  .IX Item "-m dev[:mountpoint[:options[:fstype]]]"
* **--mount** dev[:mountpoint[:options[:fstype]]]  
  .IX Item "--mount dev[:mountpoint[:options[:fstype]]]"
  Mount the named partition or logical volume on the given mountpoint.
  .Sp
  If the mountpoint is omitted, it defaults to _/_.
  .Sp
  You have to mount something on _/_ before most commands will work.
  .Sp
  If any _-m_ or _--mount_ options are given, the guest is
  automatically launched.
  .Sp
  If you don’t know what filesystems a disk image contains, you can
  either run guestfish without this option, then list the partitions,
  filesystems and LVs available (see list-partitions\*(R",
  list-filesystems\*(R" and \*(L"lvs\*(R" commands), or you can use the
  **virt-filesystems**\|(1) program.
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
  Using this flag is equivalent to using the \f(CW`mount-options\*(C' command.
  .Sp
  The fourth part of the parameter is the filesystem driver to use, such
  as \f(CW`ext3\*(C' or \f(CW\*(C\`ntfs\*(C'. This is rarely needed, but can be useful if
  multiple drivers are valid for a filesystem (eg: \f(CW`ext2\*(C' and \f(CW\*(C\`ext3\*(C'),
  or if libguestfs misidentifies a filesystem.
* **--network**  
  .IX Item "--network"
  Enable \s-1QEMU\s0 user networking in the guest.
* **-N** [FILENAME=]TYPE  
  .IX Item "-N [FILENAME=]TYPE"
* **--new** [FILENAME=]TYPE  
  .IX Item "--new [FILENAME=]TYPE"
* **-N** **help**  
  .IX Item "-N help"
  Prepare a fresh disk image formatted as \f(CW`TYPE\*(C'.  This is an
  alternative to the _-a_ option: whereas _-a_ adds an existing disk,
  _-N_ creates a preformatted disk with a filesystem and adds it.
  See \s-1PREPARED DISK IMAGES\*(R"\s0 below.
* **-n**  
  .IX Item "-n"
* **--no-sync**  
  .IX Item "--no-sync"
  Disable autosync.  This is enabled by default.  See the discussion
  of autosync in the **guestfs**\|(3) manpage.
* **--no-dest-paths**  
  .IX Item "--no-dest-paths"
  Don’t tab-complete paths on the guest filesystem.  It is useful to be
  able to hit the tab key to complete paths on the guest filesystem, but
  this causes extra hidden\*(R" guestfs calls to be made, so this option is
  here to allow this feature to be disabled.
* **--pipe-error**  
  .IX Item "--pipe-error"
  If writes fail to pipe commands (see \s-1PIPES\*(R"\s0 below), then the
  command returns an error.
  .Sp
  The default (also for historical reasons) is to ignore such errors so
  that:
  .Sp
  .Vb 1
   &gt;&lt;fs&gt; command_with_lots_of_output | head
  .Ve
  .Sp
  doesn't give an error.
* **--progress-bars**  
  .IX Item "--progress-bars"
  Enable progress bars, even when guestfish is used non-interactively.
  .Sp
  Progress bars are enabled by default when guestfish is used as an
  interactive shell.
* **--no-progress-bars**  
  .IX Item "--no-progress-bars"
  Disable progress bars.
* **--remote**  
  .IX Item "--remote"
* **--remote=**\s-1PID\s0  
  .IX Item "--remote=PID"
  Send remote commands to \f(CW$GUESTFISH\_PID or \f(CW`pid\*(C'.  See section
  \s-1REMOTE CONTROL GUESTFISH OVER A SOCKET\*(R"\s0 below.
* **-r**  
  .IX Item "-r"
* **--ro**  
  .IX Item "--ro"
  This changes the _-a_, _-d_ and _-m_ options so that disks are
  added and mounts are done read-only.
  .Sp
  The option must always be used if the disk image or virtual machine
  might be running, and is generally recommended in cases where you
  don't need write access to the disk.
  .Sp
  Note that prepared disk images created with _-N_ are not affected by
  this option.  Also commands like \f(CW`add\*(C' are not affected - you have to
  specify the \f(CW`readonly:true\*(C' option explicitly if you need it.
  .Sp
  See also \s-1OPENING DISKS FOR READ AND WRITE\*(R"\s0 below.
* **--selinux**  
  .IX Item "--selinux"
  This option is provided for backwards compatibility and does nothing.
* **-v**  
  .IX Item "-v"
* **--verbose**  
  .IX Item "--verbose"
  Enable very verbose messages.  This is particularly useful if you find
  a bug.
* **-V**  
  .IX Item "-V"
* **--version**  
  .IX Item "--version"
  Display the guestfish / libguestfs version number and exit.
* **-w**  
  .IX Item "-w"
* **--rw**  
  .IX Item "--rw"
  This changes the _-a_, _-d_ and _-m_ options so that disks are
  added and mounts are done read-write.
  .Sp
  See \s-1OPENING DISKS FOR READ AND WRITE\*(R"\s0 below.
* **-x**  
  .IX Item "-x"
  Echo each command before executing it.

<a name="commands-on-command-line"></a>

# Commands on Command Line

.IX Header "COMMANDS ON COMMAND LINE"
Any additional (non-option) arguments are treated as commands to
execute.

Commands to execute should be separated by a colon (\f(CW`:\*(C'), where the
colon is a separate parameter.  Thus:

.Vb 1
 guestfish cmd [args...] : cmd [args...] : cmd [args...] ...
.Ve

If there are no additional arguments, then we enter a shell, either an
interactive shell with a prompt (if the input is a terminal) or a
non-interactive shell.

In either command line mode or non-interactive shell, the first
command that gives an error causes the whole shell to exit.  In
interactive mode (with a prompt) if a command fails, you can continue
to enter commands.

Note that arguments of the commands will be considered as guestfish
options if they start with a dash (\f(CW`-\*(C'): you can always separate the
guestfish options and the rest of the commands (with their arguments)
using a double dash (\f(CW`--\*(C').  For example:

.Vb 1
 guestfish -- disk_create overlay.qcow2 qcow2 -1 backingfile:image.img
.Ve

<a name="using-launch-or-run"></a>

# Using Launch (or Run)

.IX Header "USING launch (OR run)"
As with **guestfs**\|(3), you must first configure your guest by adding
disks, then launch it, then mount any disks you need, and finally
issue actions/commands.  So the general order of the day is:

* ·  
  add or -a/--add
* ·  
  launch (aka run)
* ·  
  mount or -m/--mount
* ·  
  any other commands

\f(CW`run\*(C' is a synonym for \f(CW\*(C\`launch\*(C'.  You must \f(CW\*(C\`launch\*(C' (or \f(CW\*(C\`run\*(C')
your guest before mounting or performing any other commands.

The only exception is that if any of the _-i_, _-m_, _--mount_,
_-N_ or _--new_ options were given then \f(CW`run\*(C' is done
automatically, simply because guestfish can't perform the action you
asked for without doing this.

<a name="opening-disks-for-read-and-write"></a>

# Opening Disks for Read and Write

.IX Header "OPENING DISKS FOR READ AND WRITE"
The guestfish, **guestmount**\|(1) and **virt-rescue**\|(1) options _--ro_
and _--rw_ affect whether the other command line options _-a_,
_-c_, _-d_, _-i_ and _-m_ open disk images read-only or for
writing.

In libguestfs ≤ 1.10, guestfish, guestmount and virt-rescue
defaulted to opening disk images supplied on the command line for
write.  To open a disk image read-only you have to do _-a image --ro_.

This matters: If you accidentally open a live \s-1VM\s0 disk image writable
then you will cause irreversible disk corruption.

In a future libguestfs we intend to change the default the other way.
Disk images will be opened read-only.  You will have to either specify
_guestfish --rw_, _guestmount --rw_, _virt-rescue --rw_, or change
the configuration file in order to get write access for disk images
specified by those other command line options.

This version of guestfish, guestmount and virt-rescue has a _--rw_
option which does nothing (it is already the default).  However it is
highly recommended that you use this option to indicate that you need
write access, and prepare your scripts for the day when this option
will be required for write access.

**Note:** This does _not_ affect commands like add\*(R" and \*(L"mount\*(R",
or any other libguestfs program apart from guestfish and guestmount.

<a name="quoting"></a>

# Quoting

.IX Header "QUOTING"
You can quote ordinary parameters using either single or double
quotes.  For example:

.Vb 1
 add "file with a space.img"

 rm /file name\*(Aq

 rm /"\*(Aq
.Ve

A few commands require a list of strings to be passed.  For these, use
a whitespace-separated list, enclosed in quotes.  Strings containing whitespace
to be passed through must be enclosed in single quotes.  A literal single quote
must be escaped with a backslash.

.Vb 3
 vgcreate VG "/dev/sda1 /dev/sdb1"
 command "/bin/echo foo      bar\*(Aq"
 command "/bin/echo \efoo\e\*(Aq"
.Ve

<a name="s-1escape-sequences-in-double-quoted-argumentss0"></a>

### \s-1ESCAPE SEQUENCES IN DOUBLE QUOTED ARGUMENTS\s0

.IX Subsection "ESCAPE SEQUENCES IN DOUBLE QUOTED ARGUMENTS"
In double-quoted arguments (only) use backslash to insert special
characters:
.ie n .IP """\ea""" 4
.el .IP "\f(CW\ea" 4
.IX Item "a"
Alert (bell) character.
.ie n .IP """\eb""" 4
.el .IP "\f(CW\eb" 4
.IX Item "b"
Backspace character.
.ie n .IP """\ef""" 4
.el .IP "\f(CW\ef" 4
.IX Item "f"
Form feed character.
.ie n .IP """\en""" 4
.el .IP "\f(CW\en" 4
.IX Item "n"
Newline character.
.ie n .IP """\er""" 4
.el .IP "\f(CW\er" 4
.IX Item "r"
Carriage return character.
.ie n .IP """\et""" 4
.el .IP "\f(CW\et" 4
.IX Item "t"
Horizontal tab character.
.ie n .IP """\ev""" 4
.el .IP "\f(CW\ev" 4
.IX Item "v"
Vertical tab character.
.ie n .IP """\e""""" 4
.el .IP "\f(CW\e""" 4
.IX Item """"
A literal double quote character.
.ie n .IP """\eooo""" 4
.el .IP "\f(CW\eooo" 4
.IX Item "ooo"
A character with octal value _ooo_.  There must be precisely 3 octal
digits (unlike C).
.ie n .IP """\exhh""" 4
.el .IP "\f(CW\exhh" 4
.IX Item "xhh"
A character with hex value _hh_.  There must be precisely 2 hex
digits.
.Sp
In the current implementation \f(CW`\e000\*(C' and \f(CW\*(C\`\ex00\*(C' cannot be used
in strings.
.ie n .IP """\e\e""" 4
.el .IP "\f(CW\e\e" 4
.IX Item ""
A literal backslash character.

<a name="optional-arguments"></a>

# Optional Arguments

.IX Header "OPTIONAL ARGUMENTS"
Some commands take optional arguments.  These arguments appear in this
documentation as \f(CW`[argname:..]\*(C'.  You can use them as in these
examples:

.Vb 1
 add filename

 add filename readonly:true

 add filename format:qcow2 readonly:false
.Ve

Each optional argument can appear at most once.  All optional
arguments must appear after the required ones.

<a name="numbers"></a>

# Numbers

.IX Header "NUMBERS"
This section applies to all commands which can take integers
as parameters.

<a name="s-1size-suffixs0"></a>

### \s-1SIZE SUFFIX\s0

.IX Subsection "SIZE SUFFIX"
When the command takes a parameter measured in bytes, you can use one
of the following suffixes to specify kilobytes, megabytes and larger
sizes:

* **k** or **K** or **KiB**  
  .IX Item "k or K or KiB"
  The size in kilobytes (multiplied by 1024).
* **\s-1KB\s0**  
  .IX Item "KB"
  The size in \s-1SI 1000\s0 byte units.
* **M** or **MiB**  
  .IX Item "M or MiB"
  The size in megabytes (multiplied by 1048576).
* **\s-1MB\s0**  
  .IX Item "MB"
  The size in \s-1SI 1000000\s0 byte units.
* **G** or **GiB**  
  .IX Item "G or GiB"
  The size in gigabytes (multiplied by 2**30).
* **\s-1GB\s0**  
  .IX Item "GB"
  The size in \s-1SI\s0 10**9 byte units.
* **T** or **TiB**  
  .IX Item "T or TiB"
  The size in terabytes (multiplied by 2**40).
* **\s-1TB\s0**  
  .IX Item "TB"
  The size in \s-1SI\s0 10**12 byte units.
* **P** or **PiB**  
  .IX Item "P or PiB"
  The size in petabytes (multiplied by 2**50).
* **\s-1PB\s0**  
  .IX Item "PB"
  The size in \s-1SI\s0 10**15 byte units.
* **E** or **EiB**  
  .IX Item "E or EiB"
  The size in exabytes (multiplied by 2**60).
* **\s-1EB\s0**  
  .IX Item "EB"
  The size in \s-1SI\s0 10**18 byte units.
* **Z** or **ZiB**  
  .IX Item "Z or ZiB"
  The size in zettabytes (multiplied by 2**70).
* **\s-1ZB\s0**  
  .IX Item "ZB"
  The size in \s-1SI\s0 10**21 byte units.
* **Y** or **YiB**  
  .IX Item "Y or YiB"
  The size in yottabytes (multiplied by 2**80).
* **\s-1YB\s0**  
  .IX Item "YB"
  The size in \s-1SI\s0 10**24 byte units.

For example:

.Vb 1
 truncate-size /file 1G
.Ve

would truncate the file to 1 gigabyte.

Be careful because a few commands take sizes in kilobytes or megabytes
(eg. the parameter to memsize\*(R" is specified in megabytes already).
Adding a suffix will probably not do what you expect.

<a name="s-1octal-and-hexadecimal-numberss0"></a>

### \s-1OCTAL AND HEXADECIMAL NUMBERS\s0

.IX Subsection "OCTAL AND HEXADECIMAL NUMBERS"
For specifying the radix (base) use the C convention: \f(CW0 to prefix
an octal number or \f(CW`0x\*(C' to prefix a hexadecimal number.  For example:

.Vb 3
 1234      decimal number 1234
 02322     octal number, equivalent to decimal 1234
 0x4d2     hexadecimal number, equivalent to decimal 1234
.Ve

When using the \f(CW`chmod\*(C' command, you almost always want to specify an
octal number for the mode, and you must prefix it with \f(CW0 (unlike
the Unix **chmod**\|(1) program):

.Vb 2
 chmod 0777 /public  # OK
 chmod 777 /public   # WRONG! This is mode 777 decimal = 01411 octal.
.Ve

Commands that return numbers usually print them in decimal, but
some commands print numbers in other radices (eg. \f(CW`umask\*(C' prints
the mode in octal, preceded by \f(CW0).

<a name="wildcards-and-globbing"></a>

# Wildcards and Globbing

.IX Header "WILDCARDS AND GLOBBING"
Neither guestfish nor the underlying guestfs \s-1API\s0 performs
wildcard expansion (globbing) by default.  So for example the
following will not do what you expect:

.Vb 1
 rm-rf /home/*
.Ve

Assuming you don’t have a directory called literally _/home/*_
then the above command will return an error.

To perform wildcard expansion, use the \f(CW`glob\*(C' command.

.Vb 1
 glob rm-rf /home/*
.Ve

runs \f(CW`rm-rf\*(C' on each path that matches (ie. potentially running
the command many times), equivalent to:

.Vb 3
 rm-rf /home/jim
 rm-rf /home/joe
 rm-rf /home/mary
.Ve

\f(CW`glob\*(C' only works on simple guest paths and not on device names.

If you have several parameters, each containing a wildcard, then glob
will perform a Cartesian product.

<a name="comments"></a>

# Comments

.IX Header "COMMENTS"
Any line which starts with a _#_ character is treated as a comment
and ignored.  The _#_ can optionally be preceded by whitespace,
but **not** by a command.  For example:

.Vb 3
 # this is a comment
         # this is a comment
 foo # NOT a comment
.Ve

Blank lines are also ignored.

<a name="running-commands-locally"></a>

# Running Commands Locally

.IX Header "RUNNING COMMANDS LOCALLY"
Any line which starts with a _!_ character is treated as a command
sent to the local shell (_/bin/sh_ or whatever **system**\|(3) uses).
For example:

.Vb 2
 !mkdir local
 tgz-out /remote local/remote-data.tar.gz
.Ve

will create a directory \f(CW`local\*(C' on the host, and then export
the contents of _/remote_ on the mounted filesystem to
_local/remote-data.tar.gz_.  (See \f(CW`tgz-out\*(C').

To change the local directory, use the \f(CW`lcd\*(C' command.  \f(CW\*(C\`!cd\*(C' will
have no effect, due to the way that subprocesses work in Unix.

<a name="s-1local-commands-with-inline-executions0"></a>

### \s-1LOCAL COMMANDS WITH INLINE EXECUTION\s0

.IX Subsection "LOCAL COMMANDS WITH INLINE EXECUTION"
If a line starts with _&lt;!_ then the shell command is executed (as
for _!_), but subsequently any output (stdout) of the shell command
is parsed and executed as guestfish commands.

Thus you can use shell script to construct arbitrary guestfish
commands which are then parsed by guestfish.

For example it is tedious to create a sequence of files
(eg. _/foo.1_ through _/foo.100_) using guestfish commands
alone.  However this is simple if we use a shell script to
create the guestfish commands for us:

.Vb 1
 &lt;! for n in \\`seq 1 100\\`; do echo write /foo.$n $n; done
.Ve

or with names like _/foo.001_:

.Vb 1
 &lt;! for n in \\`seq 1 100\\`; do printf "write /foo.%03d %d\en" $n $n; done
.Ve

When using guestfish interactively it can be helpful to just run the
shell script first (ie. remove the initial \f(CW`&lt;\*(C' character so it is
just an ordinary _!_ local command), see what guestfish commands it
would run, and when you are happy with those prepend the \f(CW`&lt;\*(C'
character to run the guestfish commands for real.

<a name="pipes"></a>

# Pipes

.IX Header "PIPES"
Use \f(CW`command &lt;space&gt; | command\*(C' to pipe the output of the
first command (a guestfish command) to the second command (any host
command).  For example:

.Vb 1
 cat /etc/passwd | awk -F: $3 == 0 { print }\*(Aq
.Ve

(where \f(CW`cat\*(C' is the guestfish cat command, but \f(CW\*(C\`awk\*(C' is the host awk
program).  The above command would list all accounts in the guest
filesystem which have \s-1UID 0,\s0 ie. root accounts including backdoors.
Other examples:

.Vb 3
 hexdump /bin/ls | head
 list-devices | tail -1
 tgz-out / - | tar ztf -
.Ve

The space before the pipe symbol is required, any space after the pipe
symbol is optional.  Everything after the pipe symbol is just passed
straight to the host shell, so it can contain redirections, globs and
anything else that makes sense on the host side.

To use a literal argument which begins with a pipe symbol, you have
to quote it, eg:

.Vb 1
 echo "|"
.Ve

<a name="home-directories"></a>

# Home Directories

.IX Header "HOME DIRECTORIES"
If a parameter starts with the character \f(CW`~\*(C' then the tilde may be
expanded as a home directory path (either \f(CW`~\*(C' for the current user's
home directory, or \f(CW`~user\*(C' for another user).

Note that home directory expansion happens for users known on the
host, not in the guest filesystem.

To use a literal argument which begins with a tilde, you have to quote
it, eg:

.Vb 1
 echo "~"
.Ve

<a name="encrypted-disks"></a>

# Encrypted Disks

.IX Header "ENCRYPTED DISKS"
Libguestfs has some support for Linux guests encrypted according to
the Linux Unified Key Setup (\s-1LUKS\s0) standard, which includes nearly all
whole disk encryption systems used by modern Linux guests.  Currently
only LVM-on-LUKS is supported.

Identify encrypted block devices and partitions using vfs-type\*(R":

.Vb 2
 &gt;&lt;fs&gt; vfs-type /dev/sda2
 crypto_LUKS
.Ve

Then open those devices using luks-open\*(R".  This creates a
device-mapper device called _/dev/mapper/luksdev_.

.Vb 2
 &gt;&lt;fs&gt; luks-open /dev/sda2 luksdev
 Enter key or passphrase ("key"): &lt;enter the passphrase&gt;
.Ve

Finally you have to tell \s-1LVM\s0 to scan for volume groups on
the newly created mapper device:

.Vb 2
 vgscan
 vg-activate-all true
.Ve

The logical volume(s) can now be mounted in the usual way.

Before closing a \s-1LUKS\s0 device you must unmount any logical volumes on
it and deactivate the volume groups by calling \f(CW`vg-activate false VG\*(C'
on each one.  Then you can close the mapper device:

.Vb 2
 vg-activate false /dev/VG
 luks-close /dev/mapper/luksdev
.Ve

<a name="windows-paths"></a>

# Windows Paths

.IX Header "WINDOWS PATHS"
If a path is prefixed with \f(CW`win:\*(C' then you can use Windows-style
drive letters and paths (with some limitations).  The following
commands are equivalent:

.Vb 1
 file /WINDOWS/system32/config/system.LOG

 file win:\ewindows\esystem32\econfig\esystem.log

 file WIN:C:\eWindows\eSYSTEM32\eCONFIG\eSYSTEM.LOG
.Ve

The parameter is rewritten behind the scenes\*(R" by looking up the
position where the drive is mounted, prepending that to the path,
changing all backslash characters to forward slash, then resolving the
result using case-sensitive-path\*(R".  For example if the E: drive
was mounted on _/e_ then the parameter might be rewritten like this:

.Vb 1
 win:e:\efoo\ebar =&gt; /e/FOO/bar
.Ve

This only works in argument positions that expect a path.

<a name="uploading-and-downloading-files"></a>

# Uploading and Downloading Files

.IX Header "UPLOADING AND DOWNLOADING FILES"
For commands such as \f(CW`upload\*(C', \f(CW\*(C\`download\*(C', \f(CW\*(C\`tar-in\*(C', \f(CW\*(C\`tar-out\*(C' and
others which upload from or download to a local file, you can use the
special filename \f(CW`-\*(C' to mean \*(L"from stdin\*(R" or \*(L"to stdout\*(R".  For example:

.Vb 1
 upload - /foo
.Ve

reads stdin and creates from that a file _/foo_ in the disk image,
and:

.Vb 1
 tar-out /etc - | tar tf -
.Ve

writes the tarball to stdout and then pipes that into the external
tar\*(R" command (see \*(L"\s-1PIPES\*(R"\s0).

When using \f(CW`-\*(C' to read from stdin, the input is read up to the end of
stdin.  You can also use a special heredoc\*(R"-like syntax to read up to
some arbitrary end marker:

.Vb 5
 upload -&lt;&lt;END /foo
 input line 1
 input line 2
 input line 3
 END
.Ve

Any string of characters can be used instead of \f(CW`END\*(C'.  The end
marker must appear on a line of its own, without any preceding or
following characters (not even spaces).

Note that the \f(CW`-&lt;&lt;\*(C' syntax only applies to parameters used to
upload local files (so-called FileIn\*(R" parameters in the generator).

<a name="exit-on-error-behaviour"></a>

# Exit on Error Behaviour

.IX Header "EXIT ON ERROR BEHAVIOUR"
By default, guestfish will ignore any errors when in interactive mode
(ie. taking commands from a human over a tty), and will exit on the
first error in non-interactive mode (scripts, commands given on the
command line).

If you prefix a command with a _-_ character, then that command will
not cause guestfish to exit, even if that (one) command returns an
error.

<a name="remote-control-guestfish-over-a-socket"></a>

# Remote Control Guestfish Over a Socket

.IX Header "REMOTE CONTROL GUESTFISH OVER A SOCKET"
Guestfish can be remote-controlled over a socket.  This is useful
particularly in shell scripts where you want to make several different
changes to a filesystem, but you don't want the overhead of starting
up a guestfish process each time.

Start a guestfish server process using:

.Vb 1
 eval "\\`guestfish --listen\\`"
.Ve

and then send it commands by doing:

.Vb 1
 guestfish --remote cmd [...]
.Ve

To cause the server to exit, send it the exit command:

.Vb 1
 guestfish --remote exit
.Ve

Note that the server will normally exit if there is an error in a
command.  You can change this in the usual way.  See section
\s-1EXIT ON ERROR BEHAVIOUR\*(R"\s0.

<a name="s-1controlling-multiple-guestfish-processess0"></a>

### \s-1CONTROLLING MULTIPLE GUESTFISH PROCESSES\s0

.IX Subsection "CONTROLLING MULTIPLE GUESTFISH PROCESSES"
The \f(CW`eval\*(C' statement sets the environment variable \f(CW$GUESTFISH\_PID,
which is how the _--remote_ option knows where to send the commands.
You can have several guestfish listener processes running using:

.Vb 7
 eval "\\`guestfish --listen\\`"
 pid1=$GUESTFISH_PID
 eval "\\`guestfish --listen\\`"
 pid2=$GUESTFISH_PID
 ...
 guestfish --remote=$pid1 cmd
 guestfish --remote=$pid2 cmd
.Ve

<a name="s-1remote-control-and-cshs0"></a>

### \s-1REMOTE CONTROL AND CSH\s0

.IX Subsection "REMOTE CONTROL AND CSH"
When using csh-like shells (csh, tcsh etc) you have to add the
_--csh_ option:

.Vb 1
 eval "\\`guestfish --listen --csh\\`"
.Ve

<a name="s-1remote-control-detailss0"></a>

### \s-1REMOTE CONTROL DETAILS\s0

.IX Subsection "REMOTE CONTROL DETAILS"
Remote control happens over a Unix domain socket called
_/tmp/.guestfish-$UID/socket-$PID_, where \f(CW$UID is the effective
user \s-1ID\s0 of the process, and \f(CW$PID is the process \s-1ID\s0 of the server.

Guestfish client and server versions must match exactly.

Older versions of guestfish were vulnerable to \s-1CVE-2013-4419\s0 (see
\s-1CVE-2013-4419\*(R"\s0 in **guestfs**\|(3)).  This is fixed in the current version.

<a name="s-1using-remote-control-robustly-from-shell-scriptss0"></a>

### \s-1USING REMOTE CONTROL ROBUSTLY FROM SHELL SCRIPTS\s0

.IX Subsection "USING REMOTE CONTROL ROBUSTLY FROM SHELL SCRIPTS"
From Bash, you can use the following code which creates a guestfish
instance, correctly quotes the command line, handles failure to start,
and cleans up guestfish when the script exits:

.Vb 1
 #!/bin/bash -
 
 set -e
 
 guestfish[0]="guestfish"
 guestfish[1]="--listen"
 guestfish[2]="--ro"
 guestfish[3]="-a"
 guestfish[4]="disk.img"
 
 GUESTFISH_PID=
 eval $("${guestfish[@]}")
 if [ -z "$GUESTFISH_PID" ]; then
     echo "error: guestfish didnt start up, see error messages above"
     exit 1
 fi
 
 cleanup_guestfish ()
 {
     guestfish --remote -- exit &gt;/dev/null 2&gt;&1 ||:
 }
 trap cleanup_guestfish EXIT ERR
 
 guestfish --remote -- run
 
 # ...
.Ve

<a name="s-1remote-control-does-not-work-withs0-fi-afp-s-1etc-optionss0"></a>

### \s-1REMOTE CONTROL DOES NOT WORK WITH\s0 \fI\-a\fP \s-1ETC. OPTIONS\s0

.IX Subsection "REMOTE CONTROL DOES NOT WORK WITH -a ETC. OPTIONS"
Options such as _-a_, _--add_, _-N_, _--new_ etc don’t interact
properly with remote support.  They are processed locally, and not
sent through to the remote guestfish.  In particular this won't do
what you expect:

.Vb 1
 guestfish --remote --add disk.img
.Ve

Don’t use these options.  Use the equivalent commands instead, eg:

.Vb 1
 guestfish --remote add-drive disk.img
.Ve

or:

.Vb 2
 guestfish --remote
 &gt;&lt;fs&gt; add disk.img
.Ve

<a name="s-1remote-control-run-command-hangings0"></a>

### \s-1REMOTE CONTROL RUN COMMAND HANGING\s0

.IX Subsection "REMOTE CONTROL RUN COMMAND HANGING"
Using the \f(CW`run\*(C' (or \f(CW\*(C\`launch\*(C') command remotely in a command
substitution context hangs, ie. don't do (note the backquotes):

.Vb 1
 a=\\`guestfish --remote run\\`
.Ve

Since the \f(CW`run\*(C' command produces no output on stdout, this is not
useful anyway.  For further information see
https://bugzilla.redhat.com/show_bug.cgi?id=592910.

<a name="prepared-disk-images"></a>

# Prepared Disk Images

.IX Header "PREPARED DISK IMAGES"
Use the _-N [filename=]type_ or _--new [filename=]type_ parameter to
select one of a set of preformatted disk images that guestfish can
make for you to save typing.  This is particularly useful for testing
purposes.  This option is used instead of the _-a_ option, and like
_-a_ can appear multiple times (and can be mixed with _-a_).

The new disk is called _test1.img_ for the first _-N_, _test2.img_
for the second and so on.  Existing files in the current directory are
_overwritten_.  You can use a different filename by specifying
\f(CW`filename=\*(C' before the type (see examples below).

The type briefly describes how the disk should be sized, partitioned,
how filesystem(s) should be created, and how content should be added.
Optionally the type can be followed by extra parameters, separated by
\f(CW`:\*(C' (colon) characters.  For example, _-N fs_ creates a default 1G,
sparsely-allocated disk, containing a single partition, with the
partition formatted as ext2.  _-N fs:ext4:2G_ is the same, but for an
ext4 filesystem on a 2GB disk instead.

Note that the prepared filesystem is not mounted.  You would usually
have to use the \f(CW`mount /dev/sda1 /\*(C' command or add the
_-m /dev/sda1_ option.

If any _-N_ or _--new_ options are given, the libguestfs appliance
is automatically launched.

<a name="s-1exampless0"></a>

### \s-1EXAMPLES\s0

.IX Subsection "EXAMPLES"
Create a 1G disk with an ext4-formatted partition, called
_test1.img_ in the current directory:

.Vb 1
 guestfish -N fs:ext4
.Ve

Create a 32MB disk with a VFAT-formatted partition, and mount it:

.Vb 1
 guestfish -N fs:vfat:32M -m /dev/sda1
.Ve

Create a blank 200MB disk:

.Vb 1
 guestfish -N disk:200M
.Ve

Create a blank 200MB disk called _blankdisk.img_ (instead of
_test1.img_):

.Vb 1
 guestfish -N blankdisk.img=disk:200M
.Ve

<a name="fb-n-diskfp-create-a-blank-disk"></a>

### \fB\-N disk\fP \- create a blank disk

.IX Subsection "-N disk - create a blank disk"
\f(CW`guestfish -N [\f(CIfilename\f(CW=]disk[:\f(CIsize\f(CW]\*(C'

Create a blank disk, size 1G (by default).

The default size can be changed by supplying an optional parameter.

The optional parameters are:

.Vb 2
 Name          Default value
 size          1G            the size of the disk image
.Ve

<a name="fb-n-partfp-create-a-partitioned-disk"></a>

### \fB\-N part\fP \- create a partitioned disk

.IX Subsection "-N part - create a partitioned disk"
\f(CW`guestfish -N [\f(CIfilename\f(CW=]part[:\f(CIsize\f(CW[:\f(CIpartition\f(CW]]\*(C'

Create a disk with a single partition.  By default the size of the disk
is 1G (the available space in the partition will be a tiny bit smaller)
and the partition table will be \s-1MBR\s0 (old DOS-style).

These defaults can be changed by supplying optional parameters.

The optional parameters are:

.Vb 3
 Name          Default value
 size          1G            the size of the disk image
 partition     mbr           partition table type
.Ve

<a name="fb-n-fsfp-create-a-filesystem"></a>

### \fB\-N fs\fP \- create a filesystem

.IX Subsection "-N fs - create a filesystem"
\f(CW`guestfish -N [\f(CIfilename\f(CW=]fs[:\f(CIfilesystem\f(CW[:\f(CIsize\f(CW[:\f(CIpartition\f(CW]]]\*(C'

Create a disk with a single partition, with the partition containing
an empty filesystem.  This defaults to creating a 1G disk (the available
space in the filesystem will be a tiny bit smaller) with an \s-1MBR\s0 (old
DOS-style) partition table and an ext2 filesystem.

These defaults can be changed by supplying optional parameters.

The optional parameters are:

.Vb 4
 Name          Default value
 filesystem    ext2          the type of filesystem to use
 size          1G            the size of the disk image
 partition     mbr           partition table type
.Ve

<a name="fb-n-lvfp-create-a-disk-with-logical-volume"></a>

### \fB\-N lv\fP \- create a disk with logical volume

.IX Subsection "-N lv - create a disk with logical volume"
\f(CW`guestfish -N [\f(CIfilename\f(CW=]lv[:\f(CIname\f(CW[:\f(CIsize\f(CW[:\f(CIpartition\f(CW]]]\*(C'

Create a disk with a single partition, set up the partition as an
\s-1LVM2\s0 physical volume, and place a volume group and logical volume
on there.  This defaults to creating a 1G disk with the \s-1VG\s0 and
\s-1LV\s0 called \f(CW`/dev/VG/LV\*(C'.  You can change the name of the \s-1VG\s0 and \s-1LV\s0
by supplying an alternate name as the first optional parameter.

Note this does not create a filesystem.  Use 'lvfs' to do that.

The optional parameters are:

.Vb 4
 Name          Default value
 name          /dev/VG/LV    the name of the VG and LV to use
 size          1G            the size of the disk image
 partition     mbr           partition table type
.Ve

<a name="fb-n-lvfsfp-create-a-disk-with-logical-volume-and-filesystem"></a>

### \fB\-N lvfs\fP \- create a disk with logical volume and filesystem

.IX Subsection "-N lvfs - create a disk with logical volume and filesystem"
\f(CW`guestfish -N [\f(CIfilename\f(CW=]lvfs[:\f(CIname\f(CW[:\f(CIfilesystem\f(CW[:\f(CIsize\f(CW[:\f(CIpartition\f(CW]]]]\*(C'

Create a disk with a single partition, set up the partition as an
\s-1LVM2\s0 physical volume, and place a volume group and logical volume
on there.  Then format the \s-1LV\s0 with a filesystem.  This defaults to
creating a 1G disk with the \s-1VG\s0 and \s-1LV\s0 called \f(CW`/dev/VG/LV\*(C', with an
ext2 filesystem.

The optional parameters are:

.Vb 5
 Name          Default value
 name          /dev/VG/LV    the name of the VG and LV to use
 filesystem    ext2          the type of filesystem to use
 size          1G            the size of the disk image
 partition     mbr           partition table type
.Ve

<a name="fb-n-bootrootfp-create-a-boot-and-root-filesystem"></a>

### \fB\-N bootroot\fP \- create a boot and root filesystem

.IX Subsection "-N bootroot - create a boot and root filesystem"
\f(CW`guestfish -N [\f(CIfilename\f(CW=]bootroot[:\f(CIbootfs\f(CW[:\f(CIrootfs\f(CW[:\f(CIsize\f(CW[:\f(CIbootsize\f(CW[:\f(CIpartition\f(CW]]]]]\*(C'

Create a disk with two partitions, for boot and root filesystem.
Format the two filesystems independently.  There are several optional
parameters which control the exact layout and filesystem types.

The optional parameters are:

.Vb 6
 Name          Default value
 bootfs        ext2          the type of filesystem to use for boot
 rootfs        ext2          the type of filesystem to use for root
 size          1G            the size of the disk image
 bootsize      128M          the size of the boot filesystem
 partition     mbr           partition table type
.Ve

<a name="fb-n-bootrootlvfp-create-a-boot-and-root-filesystem-using-s-1lvms0"></a>

### \fB\-N bootrootlv\fP \- create a boot and root filesystem using \s-1LVM\s0

.IX Subsection "-N bootrootlv - create a boot and root filesystem using LVM"
\f(CW`guestfish -N [\f(CIfilename\f(CW=]bootrootlv[:\f(CIname\f(CW[:\f(CIbootfs\f(CW[:\f(CIrootfs\f(CW[:\f(CIsize\f(CW[:\f(CIbootsize\f(CW[:\f(CIpartition\f(CW]]]]]]\*(C'

This is the same as \f(CW`bootroot\*(C' but the root filesystem (only) is
placed on a logical volume, named by default \f(CW`/dev/VG/LV\*(C'.  There are
several optional parameters which control the exact layout.

The optional parameters are:

.Vb 7
 Name          Default value
 name          /dev/VG/LV    the name of the VG and LV for root
 bootfs        ext2          the type of filesystem to use for boot
 rootfs        ext2          the type of filesystem to use for root
 size          1G            the size of the disk image
 bootsize      128M          the size of the boot filesystem
 partition     mbr           partition table type
.Ve

<a name="adding-remote-storage"></a>

# Adding Remote Storage

.IX Header "ADDING REMOTE STORAGE"
For API-level documentation on this topic, see
guestfs_add_drive_opts\*(R" in \f(BIguestfs\|(3) and
\s-1REMOTE STORAGE\*(R"\s0 in \f(BIguestfs_\|(3)_.

On the command line, you can use the _-a_ option to add network
block devices using a URI-style format, for example:

.Vb 1
 guestfish -a ssh://root@example.com/disk.img
.Ve

URIs _cannot_ be used with the add\*(R" command.  The equivalent
command using the \s-1API\s0 directly is:

.Vb 1
 &gt;&lt;fs&gt; add /disk.img protocol:ssh server:tcp:example.com username:root
.Ve

The possible _-a \s-1URI\s0_ formats are described below.

<a name="fb-a-diskimgfp"></a>

### \fB\-a disk.img\fP

.IX Subsection "-a disk.img"

<a name="fb-a-filepathtodiskimgfp"></a>

### \fB\-a file:///path/to/disk.img\fP

.IX Subsection "-a file:///path/to/disk.img"
Add the local disk image (or device) called _disk.img_.

<a name="fb-a-ftpuserexamplecomportdiskimgfp"></a>

### \fB\-a ftp://[user@]example.com[:port]/disk.img\fP

.IX Subsection "-a ftp://[user@]example.com[:port]/disk.img"

<a name="fb-a-ftpsuserexamplecomportdiskimgfp"></a>

### \fB\-a ftps://[user@]example.com[:port]/disk.img\fP

.IX Subsection "-a ftps://[user@]example.com[:port]/disk.img"

<a name="fb-a-httpuserexamplecomportdiskimgfp"></a>

### \fB\-a http://[user@]example.com[:port]/disk.img\fP

.IX Subsection "-a http://[user@]example.com[:port]/disk.img"

<a name="fb-a-httpsuserexamplecomportdiskimgfp"></a>

### \fB\-a https://[user@]example.com[:port]/disk.img\fP

.IX Subsection "-a https://[user@]example.com[:port]/disk.img"

<a name="fb-a-tftpuserexamplecomportdiskimgfp"></a>

### \fB\-a tftp://[user@]example.com[:port]/disk.img\fP

.IX Subsection "-a tftp://[user@]example.com[:port]/disk.img"
Add a disk located on a remote \s-1FTP, HTTP\s0 or \s-1TFTP\s0 server.

The equivalent \s-1API\s0 command would be:

.Vb 1
 &gt;&lt;fs&gt; add /disk.img protocol:(ftp|...) server:tcp:example.com
.Ve

<a name="fb-a-glusterexamplecomportvolnameimagefp"></a>

### \fB\-a gluster://example.com[:port]/volname/image\fP

.IX Subsection "-a gluster://example.com[:port]/volname/image"
Add a disk image located on GlusterFS storage.

The server is the one running \f(CW`glusterd\*(C', and may be \f(CW\*(C\`localhost\*(C'.

The equivalent \s-1API\s0 command would be:

.Vb 1
 &gt;&lt;fs&gt; add volname/image protocol:gluster server:tcp:example.com
.Ve

<a name="fb-a-iscsiexamplecomporttarget-iqn-namelunfp"></a>

### \fB\-a iscsi://example.com[:port]/target\-iqn\-name[/lun]\fP

.IX Subsection "-a iscsi://example.com[:port]/target-iqn-name[/lun]"
Add a disk located on an iSCSI server.

The equivalent \s-1API\s0 command would be:

.Vb 1
 &gt;&lt;fs&gt; add target-iqn-name/lun protocol:iscsi server:tcp:example.com
.Ve

<a name="fb-a-nbdexamplecomportfp"></a>

### \fB\-a nbd://example.com[:port]\fP

.IX Subsection "-a nbd://example.com[:port]"

<a name="fb-a-nbdexamplecomportexportnamefp"></a>

### \fB\-a nbd://example.com[:port]/exportname\fP

.IX Subsection "-a nbd://example.com[:port]/exportname"

<a name="fb-a-nbdsocketsocketfp"></a>

### \fB\-a nbd://?socket=/socket\fP

.IX Subsection "-a nbd://?socket=/socket"

<a name="fb-a-nbdexportnamesocketsocketfp"></a>

### \fB\-a nbd:///exportname?socket=/socket\fP

.IX Subsection "-a nbd:///exportname?socket=/socket"
Add a disk located on Network Block Device (nbd) storage.

The _/exportname_ part of the \s-1URI\s0 specifies an \s-1NBD\s0 export name, but
is usually left empty.

The optional _?socket_ parameter can be used to specify a Unix domain
socket that we talk to the \s-1NBD\s0 server over.  Note that you cannot mix
server name (ie. \s-1TCP/IP\s0) and socket path.

The equivalent \s-1API\s0 command would be (no export name):

.Vb 1
 &gt;&lt;fs&gt; add "" protocol:nbd server:[tcp:example.com|unix:/socket]
.Ve

<a name="fb-a-rbdpooldiskfp"></a>

### \fB\-a rbd:///pool/disk\fP

.IX Subsection "-a rbd:///pool/disk"

<a name="fb-a-rbdexamplecomportpooldiskfp"></a>

### \fB\-a rbd://example.com[:port]/pool/disk\fP

.IX Subsection "-a rbd://example.com[:port]/pool/disk"
Add a disk image located on a Ceph (RBD/librbd) storage volume.

Although libguestfs and Ceph supports multiple servers, only a single
server can be specified when using this \s-1URI\s0 syntax.

The equivalent \s-1API\s0 command would be:

.Vb 1
 &gt;&lt;fs&gt; add pool/disk protocol:rbd server:tcp:example.com:port
.Ve

<a name="fb-a-sheepdogexamplecomportvolumeimagefp"></a>

### \fB\-a sheepdog://[example.com[:port]]/volume/image\fP

.IX Subsection "-a sheepdog://[example.com[:port]]/volume/image"
Add a disk image located on a Sheepdog volume.

The server name is optional.  Although libguestfs and Sheepdog
supports multiple servers, only at most one server can be specified
when using this \s-1URI\s0 syntax.

The equivalent \s-1API\s0 command would be:

.Vb 1
 &gt;&lt;fs&gt; add volume protocol:sheepdog [server:tcp:example.com]
.Ve

<a name="fb-a-sshuserexamplecomportdiskimgfp"></a>

### \fB\-a ssh://[user@]example.com[:port]/disk.img\fP

.IX Subsection "-a ssh://[user@]example.com[:port]/disk.img"
Add a disk image located on a remote server, accessed using the Secure
Shell (ssh) \s-1SFTP\s0 protocol.  \s-1SFTP\s0 is supported out of the box by all
major \s-1SSH\s0 servers.

The equivalent \s-1API\s0 command would be:

.Vb 1
 &gt;&lt;fs&gt; add /disk protocol:ssh server:tcp:example.com [username:user]
.Ve

Note that the URIs follow the syntax of
\s-1RFC 3986\s0: in particular, there
are restrictions on the allowed characters for the various components
of the \s-1URI.\s0  Characters such as \f(CW`:\*(C', \f(CW\*(C\`@\*(C', and \f(CW\*(C\`/\*(C' **must** be
percent-encoded:

.Vb 1
 $ guestfish -a ssh://user:pass%40word@example.com/disk.img
.Ve

In this case, the password is \f(CW`pass@word\*(C'.

<a name="progress-bars"></a>

# Progress Bars

.IX Header "PROGRESS BARS"
Some (not all) long-running commands send progress notification
messages as they are running.  Guestfish turns these messages into
progress bars.

When a command that supports progress bars takes longer than two
seconds to run, and if progress bars are enabled, then you will see
one appearing below the command:

.Vb 2
 &gt;&lt;fs&gt; copy-size /large-file /another-file 2048M
 / 10% [#####-----------------------------------------] 00:30
.Ve

The spinner on the left hand side moves round once for every progress
notification received from the backend.  This is a (reasonably) golden
assurance that the command is doing something\*(R" even if the progress
bar is not moving, because the command is able to send the progress
notifications.  When the bar reaches 100% and the command finishes,
the spinner disappears.

Progress bars are enabled by default when guestfish is used
interactively.  You can enable them even for non-interactive modes
using _--progress-bars_, and you can disable them completely using
_--no-progress-bars_.

<a name="prompt"></a>

# Prompt

.IX Header "PROMPT"
You can change or add colours to the default prompt
(\f(CW`&gt;&lt;fs&gt;\*(C') by setting the \f(CW\*(C\`GUESTFISH\_PS1\*(C' environment
variable.  A second string (\f(CW`GUESTFISH\_OUTPUT\*(C') is printed after the
command has been entered and before the output, allowing you to
control the colour of the output.  A third string (\f(CW`GUESTFISH\_INIT\*(C')
is printed before the welcome message, allowing you to control the
colour of that message.  A fourth string (\f(CW`GUESTFISH\_RESTORE\*(C') is
printed before guestfish exits.

A simple prompt can be set by setting \f(CW`GUESTFISH\_PS1\*(C' to an alternate
string:

.Vb 5
 $ GUESTFISH_PS1=(type a command) \*(Aq
 $ export GUESTFISH_PS1
 $ guestfish
 [...]
 (type a command) ▂
.Ve

You can also use special escape sequences, as described in the table
below:

* \e\e  
  .IX Item ""
  A literal backslash character.
* \e[  
  .IX Item "["
* \e]  
  .IX Item "]"
  (These should only be used in \f(CW`GUESTFISH\_PS1\*(C'.)
  .Sp
  Place non-printing characters (eg. terminal control codes for colours)
  between \f(CW`\e[...\e]\*(C'.  What this does it to tell the **readline**\|(3)
  library that it should treat this subsequence as zero-width, so that
  command-line redisplay, editing etc works.
* \ea  
  .IX Item "a"
  A bell character.
* \ee  
  .IX Item "e"
  An \s-1ASCII ESC\s0 (escape) character.
* \en  
  .IX Item "n"
  A newline.
* \er  
  .IX Item "r"
  A carriage return.
* \eNNN  
  .IX Item "NNN"
  The \s-1ASCII\s0 character whose code is the octal value \s-1NNN.\s0
* \exNN  
  .IX Item "xNN"
  The \s-1ASCII\s0 character whose code is the hex value \s-1NN.\s0

<a name="s-1examples-of-promptss0"></a>

### \s-1EXAMPLES OF PROMPTS\s0

.IX Subsection "EXAMPLES OF PROMPTS"
Note that these examples require a terminal that supports \s-1ANSI\s0 escape codes.

* ·  
  
  .Sp
  .Vb 1
   GUESTFISH_PS1=\e[\ee[1;30m\e]&gt;&lt;fs&gt;\e[\ee[0;30m\e] \*(Aq
  .Ve
  .Sp
  A bold black version of the ordinary prompt.
* ·  
  
  .Sp
  .Vb 4
   GUESTFISH_PS1=\e[\ee[1;32m\e]&gt;&lt;fs&gt;\e[\ee[0;31m\e] \*(Aq
   GUESTFISH_OUTPUT=\ee[0m\*(Aq
   GUESTFISH_RESTORE="$GUESTFISH_OUTPUT"
   GUESTFISH_INIT=\ee[1;34m\*(Aq
  .Ve
  .Sp
  Blue welcome text, green prompt, red commands, black command
  output.

<a name="windows-8"></a>

# Windows 8

.IX Header "WINDOWS 8"
Windows 8 fast startup\*(R" can prevent guestfish from mounting \s-1NTFS\s0
partitions.  See
\s-1WINDOWS HIBERNATION AND WINDOWS 8 FAST STARTUP\*(R"\s0 in **guestfs**\|(3).

<a name="guestfish-commands"></a>

# Guestfish Commands

.IX Header "GUESTFISH COMMANDS"
The commands in this section are guestfish convenience commands, in
other words, they are not part of the **guestfs**\|(3) \s-1API.\s0

<a name="help"></a>

### help

.IX Subsection "help"
.Vb 3
 help
 help cmd
 help -l|--list
.Ve

Without any parameter, this provides general help.

With a \f(CW`cmd\*(C' parameter, this displays detailed help for that command.

With _-l_ or _--list_, this list all commands.

<a name="exit"></a>

### exit

.IX Subsection "exit"

<a name="quit"></a>

### quit

.IX Subsection "quit"
This exits guestfish.  You can also use \f(CW`^D\*(C' key.

<a name="alloc"></a>

### alloc

.IX Subsection "alloc"

<a name="allocate"></a>

### allocate

.IX Subsection "allocate"
.Vb 1
 alloc filename size
.Ve

This creates an empty (zeroed) file of the given size, and then adds
so it can be further examined.

For more advanced image creation, see disk-create\*(R".

Size can be specified using standard suffixes, eg. \f(CW`1M\*(C'.

To create a sparse file, use sparse\*(R" instead.  To create a
prepared disk image, see \s-1PREPARED DISK IMAGES\*(R"\s0.

<a name="copy-in"></a>

### copy-in

.IX Subsection "copy-in"
.Vb 1
 copy-in local [local ...] /remotedir
.Ve

\f(CW`copy-in\*(C' copies local files or directories recursively into the disk
image, placing them in the directory called _/remotedir_ (which must
exist).  This guestfish meta-command turns into a sequence of
tar-in\*(R" and other commands as necessary.

Multiple local files and directories can be specified, but the last
parameter must always be a remote directory.  Wildcards cannot be
used.

<a name="copy-out"></a>

### copy-out

.IX Subsection "copy-out"
.Vb 1
 copy-out remote [remote ...] localdir
.Ve

\f(CW`copy-out\*(C' copies remote files or directories recursively out of the
disk image, placing them on the host disk in a local directory called
\f(CW`localdir\*(C' (which must exist).  This guestfish meta-command turns
into a sequence of download\*(R", \*(L"tar-out\*(R" and other commands as
necessary.

Multiple remote files and directories can be specified, but the last
parameter must always be a local directory.  To download to the
current directory, use \f(CW`.\*(C' as in:

.Vb 1
 copy-out /home .
.Ve

Wildcards cannot be used in the ordinary command, but you can use
them with the help of glob\*(R" like this:

.Vb 1
 glob copy-out /home/* .
.Ve

<a name="delete-event"></a>

### delete-event

.IX Subsection "delete-event"
.Vb 1
 delete-event name
.Ve

Delete the event handler which was previously registered as \f(CW`name\*(C'.
If multiple event handlers were registered with the same name, they
are all deleted.

See also the guestfish commands \f(CW`event\*(C' and \f(CW\*(C\`list-events\*(C'.

<a name="display"></a>

### display

.IX Subsection "display"
.Vb 1
 display filename
.Ve

Use \f(CW`display\*(C' (a graphical display program) to display an image
file.  It downloads the file, and runs \f(CW`display\*(C' on it.

To use an alternative program, set the \f(CW`GUESTFISH\_DISPLAY\_IMAGE\*(C'
environment variable.  For example to use the \s-1GNOME\s0 display program:

.Vb 1
 export GUESTFISH_DISPLAY_IMAGE=eog
.Ve

See also **display**\|(1).

<a name="echo"></a>

### echo

.IX Subsection "echo"
.Vb 1
 echo [params ...]
.Ve

This echos the parameters to the terminal.

<a name="edit"></a>

### edit

.IX Subsection "edit"

<a name="vi"></a>

### vi

.IX Subsection "vi"

<a name="emacs"></a>

### emacs

.IX Subsection "emacs"
.Vb 1
 edit filename
.Ve

This is used to edit a file.  It downloads the file, edits it
locally using your editor, then uploads the result.

The editor is \f(CW$EDITOR.  However if you use the alternate
commands \f(CW`vi\*(C' or \f(CW\*(C\`emacs\*(C' you will get those corresponding
editors.

<a name="event"></a>

### event

.IX Subsection "event"
.Vb 1
 event name eventset "shell script ..."
.Ve

Register a shell script fragment which is executed when an
event is raised.  See guestfs_set_event_callback\*(R" in **guestfs**\|(3)
for a discussion of the event \s-1API\s0 in libguestfs.

The \f(CW`name\*(C' parameter is a name that you give to this event
handler.  It can be any string (even the empty string) and is
simply there so you can delete the handler using the guestfish
\f(CW`delete-event\*(C' command.

The \f(CW`eventset\*(C' parameter is a comma-separated list of one
or more events, for example \f(CW`close\*(C' or \f(CW\*(C\`close,trace\*(C'.  The
special value \f(CW`*\*(C' means all events.

The third and final parameter is the shell script fragment
(or any external command) that is executed when any of the
events in the eventset occurs.  It is executed using
\f(CW`$SHELL -c\*(C', or if \f(CW$SHELL is not set then _/bin/sh -c_.

The shell script fragment receives callback parameters as
arguments \f(CW$1, \f(CW$2 etc.  The actual event that was
called is available in the environment variable \f(CW$EVENT.

.Vb 4
 event "" close "echo closed"
 event messages appliance,library,trace "echo $@"
 event "" progress "echo progress: $3/$4"
 event "" * "echo $EVENT $@"
.Ve

See also the guestfish commands \f(CW`delete-event\*(C' and \f(CW\*(C\`list-events\*(C'.

<a name="glob"></a>

### glob

.IX Subsection "glob"
.Vb 1
 glob command args...
.Ve

Expand wildcards in any paths in the args list, and run \f(CW`command\*(C'
repeatedly on each matching path.

See \s-1WILDCARDS AND GLOBBING\*(R"\s0.

<a name="hexedit"></a>

### hexedit

.IX Subsection "hexedit"
.Vb 3
 hexedit &lt;filename|device&gt;
 hexedit &lt;filename|device&gt; &lt;max&gt;
 hexedit &lt;filename|device&gt; &lt;start&gt; &lt;max&gt;
.Ve

Use hexedit (a hex editor) to edit all or part of a binary file
or block device.

This command works by downloading potentially the whole file or
device, editing it locally, then uploading it.  If the file or
device is large, you have to specify which part you wish to edit
by using \f(CW`max\*(C' and/or \f(CW\*(C\`start\*(C' \f(CW\*(C\`max\*(C' parameters.
\f(CW`start\*(C' and \f(CW\*(C\`max\*(C' are specified in bytes, with the usual
modifiers allowed such as \f(CW`1M\*(C' (1 megabyte).

For example to edit the first few sectors of a disk you
might do:

.Vb 1
 hexedit /dev/sda 1M
.Ve

which would allow you to edit anywhere within the first megabyte
of the disk.

To edit the superblock of an ext2 filesystem on _/dev/sda1_, do:

.Vb 1
 hexedit /dev/sda1 0x400 0x400
.Ve

(assuming the superblock is in the standard location).

This command requires the external **hexedit**\|(1) program.  You
can specify another program to use by setting the \f(CW`HEXEDITOR\*(C'
environment variable.

See also hexdump\*(R".

<a name="lcd"></a>

### lcd

.IX Subsection "lcd"
.Vb 1
 lcd directory
.Ve

Change the local directory, ie. the current directory of guestfish
itself.

Note that \f(CW`!cd\*(C' won't do what you might expect.

<a name="list-events"></a>

### list-events

.IX Subsection "list-events"
.Vb 1
 list-events
.Ve

List the event handlers registered using the guestfish
\f(CW`event\*(C' command.

<a name="man"></a>

### man

.IX Subsection "man"

<a name="manual"></a>

### manual

.IX Subsection "manual"
.Vb 1
  man
.Ve

Opens the manual page for guestfish.

<a name="more"></a>

### more

.IX Subsection "more"

<a name="less"></a>

### less

.IX Subsection "less"
.Vb 1
 more filename

 less filename
.Ve

This is used to view a file.

The default viewer is \f(CW$PAGER.  However if you use the alternate
command \f(CW`less\*(C' you will get the \f(CW\*(C\`less\*(C' command specifically.

<a name="reopen"></a>

### reopen

.IX Subsection "reopen"
.Vb 1
  reopen
.Ve

Close and reopen the libguestfs handle.  It is not necessary to use
this normally, because the handle is closed properly when guestfish
exits.  However this is occasionally useful for testing.

<a name="setenv"></a>

### setenv

.IX Subsection "setenv"
.Vb 1
  setenv VAR value
.Ve

Set the environment variable \f(CW`VAR\*(C' to the string \f(CW\*(C\`value\*(C'.

To print the value of an environment variable use a shell command
such as:

.Vb 1
 !echo $VAR
.Ve

<a name="sparse"></a>

### sparse

.IX Subsection "sparse"
.Vb 1
 sparse filename size
.Ve

This creates an empty sparse file of the given size, and then adds
so it can be further examined.

In all respects it works the same as the alloc\*(R" command, except that
the image file is allocated sparsely, which means that disk blocks are
not assigned to the file until they are needed.  Sparse disk files
only use space when written to, but they are slower and there is a
danger you could run out of real disk space during a write operation.

For more advanced image creation, see disk-create\*(R".

Size can be specified using standard suffixes, eg. \f(CW`1M\*(C'.

See also the guestfish scratch\*(R" command.

<a name="supported"></a>

### supported

.IX Subsection "supported"
.Vb 1
 supported
.Ve

This command returns a list of the optional groups
known to the daemon, and indicates which ones are
supported by this build of the libguestfs appliance.

See also \s-1AVAILABILITY\*(R"\s0 in **guestfs**\|(3).

<a name="time"></a>

### time

.IX Subsection "time"
.Vb 1
 time command args...
.Ve

Run the command as usual, but print the elapsed time afterwards.  This
can be useful for benchmarking operations.

<a name="unsetenv"></a>

### unsetenv

.IX Subsection "unsetenv"
.Vb 1
  unsetenv VAR
.Ve

Remove \f(CW`VAR\*(C' from the environment.

<a name="commands"></a>

# Commands

.IX Header "COMMANDS"

<a name="acl-delete-def-file"></a>

### acl-delete-def-file

.IX Subsection "acl-delete-def-file"
.Vb 1
 acl-delete-def-file dir
.Ve

This function deletes the default \s-1POSIX\s0 Access Control List (\s-1ACL\s0)
attached to directory \f(CW`dir\*(C'.

This command depends on the feature \f(CW`acl\*(C'.   See also
feature-available\*(R".

<a name="acl-get-file"></a>

### acl-get-file

.IX Subsection "acl-get-file"
.Vb 1
 acl-get-file path acltype
.Ve

This function returns the \s-1POSIX\s0 Access Control List (\s-1ACL\s0) attached
to \f(CW`path\*(C'.  The \s-1ACL\s0 is returned in \*(L"long text form\*(R" (see **acl**\|(5)).

The \f(CW`acltype\*(C' parameter may be:
.ie n .IP """access""" 4
.el .IP "\f(CWaccess" 4
.IX Item "access"
Return the ordinary (access) \s-1ACL\s0 for any file, directory or
other filesystem object.
.ie n .IP """default""" 4
.el .IP "\f(CWdefault" 4
.IX Item "default"
Return the default \s-1ACL.\s0  Normally this only makes sense if
\f(CW`path\*(C' is a directory.

This command depends on the feature \f(CW`acl\*(C'.   See also
feature-available\*(R".

<a name="acl-set-file"></a>

### acl-set-file

.IX Subsection "acl-set-file"
.Vb 1
 acl-set-file path acltype acl
.Ve

This function sets the \s-1POSIX\s0 Access Control List (\s-1ACL\s0) attached
to \f(CW`path\*(C'.

The \f(CW`acltype\*(C' parameter may be:
.ie n .IP """access""" 4
.el .IP "\f(CWaccess" 4
.IX Item "access"
Set the ordinary (access) \s-1ACL\s0 for any file, directory or
other filesystem object.
.ie n .IP """default""" 4
.el .IP "\f(CWdefault" 4
.IX Item "default"
Set the default \s-1ACL.\s0  Normally this only makes sense if
\f(CW`path\*(C' is a directory.

The \f(CW`acl\*(C' parameter is the new \s-1ACL\s0 in either \*(L"long text form\*(R"
or short text form\*(R" (see **acl**\|(5)).  The new \s-1ACL\s0 completely
replaces any previous \s-1ACL\s0 on the file.  The \s-1ACL\s0 must contain the
full Unix permissions (eg. \f(CW`u::rwx,g::rx,o::rx\*(C').

If you are specifying individual users or groups, then the
mask field is also required (eg. \f(CW`m::rwx\*(C'), followed by the
\f(CW`u:\f(CIID\f(CW:...\*(C' and/or \f(CW\*(C\`g:\f(CIID\f(CW:...\*(C' field(s).  A full \s-1ACL\s0
string might therefore look like this:

.Vb 2
 u::rwx,g::rwx,o::rwx,m::rwx,u:500:rwx,g:500:rwx
 \e Unix permissions / \emask/ \e      ACL        /
.Ve

You should use numeric UIDs and GIDs.  To map usernames and
groupnames to the correct numeric \s-1ID\s0 in the context of the
guest, use the Augeas functions (see aug-init\*(R").

This command depends on the feature \f(CW`acl\*(C'.   See also
feature-available\*(R".

<a name="add-cdrom"></a>

### add-cdrom

.IX Subsection "add-cdrom"
.Vb 1
 add-cdrom filename
.Ve

This function adds a virtual CD-ROM disk image to the guest.

The image is added as read-only drive, so this function is equivalent
of add-drive-ro\*(R".

_This function is deprecated._
In new code, use the add-drive-ro\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="add-domain"></a>

### add-domain

.IX Subsection "add-domain"

<a name="domain"></a>

### domain

.IX Subsection "domain"
.Vb 1
 add-domain dom [libvirturi:..] [readonly:true|false] [iface:..] [live:true|false] [allowuuid:true|false] [readonlydisk:..] [cachemode:..] [discard:..] [copyonread:true|false]
.Ve

This function adds the disk(s) attached to the named libvirt
domain \f(CW`dom\*(C'.  It works by connecting to libvirt, requesting
the domain and domain \s-1XML\s0 from libvirt, parsing it for disks,
and calling add-drive-opts\*(R" on each one.

The number of disks added is returned.  This operation is atomic:
if an error is returned, then no disks are added.

This function does some minimal checks to make sure the libvirt
domain is not running (unless \f(CW`readonly\*(C' is true).  In a future
version we will try to acquire the libvirt lock on each disk.

Disks must be accessible locally.  This often means that adding disks
from a remote libvirt connection (see http://libvirt.org/remote.html)
will fail unless those disks are accessible via the same device path
locally too.

The optional \f(CW`libvirturi\*(C' parameter sets the libvirt \s-1URI\s0
(see http://libvirt.org/uri.html).  If this is not set then
we connect to the default libvirt \s-1URI\s0 (or one set through an
environment variable, see the libvirt documentation for full
details).

The optional \f(CW`live\*(C' flag controls whether this call will try
to connect to a running virtual machine \f(CW`guestfsd\*(C' process if
it sees a suitable &lt;channel&gt; element in the libvirt
\s-1XML\s0 definition.  The default (if the flag is omitted) is never
to try.  See \s-1ATTACHING TO RUNNING DAEMONS\*(R"\s0 in **guestfs**\|(3) for more
information.

If the \f(CW`allowuuid\*(C' flag is true (default is false) then a \s-1UUID\s0
_may_ be passed instead of the domain name.  The \f(CW`dom\*(C' string is
treated as a \s-1UUID\s0 first and looked up, and if that lookup fails
then we treat \f(CW`dom\*(C' as a name as usual.

The optional \f(CW`readonlydisk\*(C' parameter controls what we do for
disks which are marked &lt;readonly/&gt; in the libvirt \s-1XML.\s0
Possible values are:
.ie n .IP "readonlydisk = ""error""" 4
.el .IP "readonlydisk = \`\`error''" 4
.IX Item "readonlydisk = error"
If \f(CW`readonly\*(C' is false:
.Sp
The whole call is aborted with an error if any disk with
the &lt;readonly/&gt; flag is found.
.Sp
If \f(CW`readonly\*(C' is true:
.Sp
Disks with the &lt;readonly/&gt; flag are added read-only.
.ie n .IP "readonlydisk = ""read""" 4
.el .IP "readonlydisk = \`\`read''" 4
.IX Item "readonlydisk = read"
If \f(CW`readonly\*(C' is false:
.Sp
Disks with the &lt;readonly/&gt; flag are added read-only.
Other disks are added read/write.
.Sp
If \f(CW`readonly\*(C' is true:
.Sp
Disks with the &lt;readonly/&gt; flag are added read-only.
.ie n .IP "readonlydisk = ""write"" (default)" 4
.el .IP "readonlydisk = \`\`write'' (default)" 4
.IX Item "readonlydisk = write (default)"
If \f(CW`readonly\*(C' is false:
.Sp
Disks with the &lt;readonly/&gt; flag are added read/write.
.Sp
If \f(CW`readonly\*(C' is true:
.Sp
Disks with the &lt;readonly/&gt; flag are added read-only.
.ie n .IP "readonlydisk = ""ignore""" 4
.el .IP "readonlydisk = \`\`ignore''" 4
.IX Item "readonlydisk = ignore"
If \f(CW`readonly\*(C' is true or false:
.Sp
Disks with the &lt;readonly/&gt; flag are skipped.

The other optional parameters are passed directly through to
add-drive-opts\*(R".

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

<a name="add-drive"></a>

### add-drive

.IX Subsection "add-drive"

<a name="add"></a>

### add

.IX Subsection "add"

<a name="add-drive-opts"></a>

### add-drive-opts

.IX Subsection "add-drive-opts"
.Vb 1
 add-drive filename [readonly:true|false] [format:..] [iface:..] [name:..] [label:..] [protocol:..] [server:..] [username:..] [secret:..] [cachemode:..] [discard:..] [copyonread:true|false]
.Ve

This function adds a disk image called _filename_ to the handle.
_filename_ may be a regular host file or a host device.

When this function is called before launch\*(R" (the
usual case) then the first time you call this function,
the disk appears in the \s-1API\s0 as _/dev/sda_, the second time
as _/dev/sdb_, and so on.

In libguestfs ≥ 1.20 you can also call this function
after launch (with some restrictions).  This is called
hotplugging\*(R".  When hotplugging, you must specify a
\f(CW`label\*(C' so that the new disk gets a predictable name.
For more information see \s-1HOTPLUGGING\*(R"\s0 in **guestfs**\|(3).

You don't necessarily need to be root when using libguestfs.  However
you obviously do need sufficient permissions to access the filename
for whatever operations you want to perform (ie. read access if you
just want to read the image or write access if you want to modify the
image).

This call checks that _filename_ exists.

_filename_ may be the special string \f(CW"/dev/null".
See \s-1NULL DISKS\*(R"\s0 in **guestfs**\|(3).

The optional arguments are:
.ie n .IP """readonly""" 4
.el .IP "\f(CWreadonly" 4
.IX Item "readonly"
If true then the image is treated as read-only.  Writes are still
allowed, but they are stored in a temporary snapshot overlay which
is discarded at the end.  The disk that you add is not modified.
.ie n .IP """format""" 4
.el .IP "\f(CWformat" 4
.IX Item "format"
This forces the image format.  If you omit this (or use add-drive\*(R"
or add-drive-ro\*(R") then the format is automatically detected.
Possible formats include \f(CW`raw\*(C' and \f(CW\*(C\`qcow2\*(C'.
.Sp
Automatic detection of the format opens you up to a potential
security hole when dealing with untrusted raw-format images.
See \s-1CVE-2010-3851\s0 and RHBZ#642934.  Specifying the format closes
this security hole.
.ie n .IP """iface""" 4
.el .IP "\f(CWiface" 4
.IX Item "iface"
This rarely-used option lets you emulate the behaviour of the
deprecated add-drive-with-if\*(R" call (q.v.)
.ie n .IP """name""" 4
.el .IP "\f(CWname" 4
.IX Item "name"
The name the drive had in the original guest, e.g. _/dev/sdb_.
This is used as a hint to the guest inspection process if
it is available.
.ie n .IP """label""" 4
.el .IP "\f(CWlabel" 4
.IX Item "label"
Give the disk a label.  The label should be a unique, short
string using _only_ \s-1ASCII\s0 characters \f(CW`[a-zA-Z]\*(C'.
As well as its usual name in the \s-1API\s0 (such as _/dev/sda_),
the drive will also be named _/dev/disk/guestfs/label_.
.Sp
See \s-1DISK LABELS\*(R"\s0 in **guestfs**\|(3).
.ie n .IP """protocol""" 4
.el .IP "\f(CWprotocol" 4
.IX Item "protocol"
The optional protocol argument can be used to select an alternate
source protocol.
.Sp
See also: \s-1REMOTE STORAGE\*(R"\s0 in **guestfs**\|(3).
.ie n .IP """protocol = ""file""""" 4
.el .IP "\f(CWprotocol = \`\`file''" 4
.IX Item "protocol = ""file"""
_filename_ is interpreted as a local file or device.
This is the default if the optional protocol parameter
is omitted.
.ie n .IP """protocol = ""ftp""|""ftps""|""http""|""https""|""tftp""""" 4
.el .IP "\f(CWprotocol = \`\`ftp''|\`\`ftps''|\`\`http''|\`\`https''|\`\`tftp''" 4
.IX Item "protocol = ""ftp""|""ftps""|""http""|""https""|""tftp"""
Connect to a remote \s-1FTP, HTTP\s0 or \s-1TFTP\s0 server.
The \f(CW`server\*(C' parameter must also be supplied - see below.
.Sp
See also: \s-1FTP, HTTP AND TFTP\*(R"\s0 in **guestfs**\|(3)
.ie n .IP """protocol = ""gluster""""" 4
.el .IP "\f(CWprotocol = \`\`gluster''" 4
.IX Item "protocol = ""gluster"""
Connect to the GlusterFS server.
The \f(CW`server\*(C' parameter must also be supplied - see below.
.Sp
See also: \s-1GLUSTER\*(R"\s0 in **guestfs**\|(3)
.ie n .IP """protocol = ""iscsi""""" 4
.el .IP "\f(CWprotocol = \`\`iscsi''" 4
.IX Item "protocol = ""iscsi"""
Connect to the iSCSI server.
The \f(CW`server\*(C' parameter must also be supplied - see below.
The \f(CW`username\*(C' parameter may be supplied.  See below.
The \f(CW`secret\*(C' parameter may be supplied.  See below.
.Sp
See also: \s-1ISCSI\*(R"\s0 in **guestfs**\|(3).
.ie n .IP """protocol = ""nbd""""" 4
.el .IP "\f(CWprotocol = \`\`nbd''" 4
.IX Item "protocol = ""nbd"""
Connect to the Network Block Device server.
The \f(CW`server\*(C' parameter must also be supplied - see below.
.Sp
See also: \s-1NETWORK BLOCK DEVICE\*(R"\s0 in **guestfs**\|(3).
.ie n .IP """protocol = ""rbd""""" 4
.el .IP "\f(CWprotocol = \`\`rbd''" 4
.IX Item "protocol = ""rbd"""
Connect to the Ceph (librbd/RBD) server.
The \f(CW`server\*(C' parameter must also be supplied - see below.
The \f(CW`username\*(C' parameter may be supplied.  See below.
The \f(CW`secret\*(C' parameter may be supplied.  See below.
.Sp
See also: \s-1CEPH\*(R"\s0 in **guestfs**\|(3).
.ie n .IP """protocol = ""sheepdog""""" 4
.el .IP "\f(CWprotocol = \`\`sheepdog''" 4
.IX Item "protocol = ""sheepdog"""
Connect to the Sheepdog server.
The \f(CW`server\*(C' parameter may also be supplied - see below.
.Sp
See also: \s-1SHEEPDOG\*(R"\s0 in **guestfs**\|(3).
.ie n .IP """protocol = ""ssh""""" 4
.el .IP "\f(CWprotocol = \`\`ssh''" 4
.IX Item "protocol = ""ssh"""
Connect to the Secure Shell (ssh) server.
.Sp
The \f(CW`server\*(C' parameter must be supplied.
The \f(CW`username\*(C' parameter may be supplied.  See below.
.Sp
See also: \s-1SSH\*(R"\s0 in **guestfs**\|(3).
.ie n .IP """server""" 4
.el .IP "\f(CWserver" 4
.IX Item "server"
For protocols which require access to a remote server, this
is a list of server(s).
.Sp
.Vb 10
 Protocol       Number of servers required
 --------       --------------------------
 file           List must be empty or param not used at all
 ftp|ftps|http|https|tftp  Exactly one
 gluster        Exactly one
 iscsi          Exactly one
 nbd            Exactly one
 rbd            Zero or more
 sheepdog       Zero or more
 ssh            Exactly one
.Ve
.Sp
Each list element is a string specifying a server.  The string must be
in one of the following formats:
.Sp
.Vb 5
 hostname
 hostname:port
 tcp:hostname
 tcp:hostname:port
 unix:/path/to/socket
.Ve
.Sp
If the port number is omitted, then the standard port number
for the protocol is used (see _/etc/services_).
.ie n .IP """username""" 4
.el .IP "\f(CWusername" 4
.IX Item "username"
For the \f(CW`ftp\*(C', \f(CW\*(C\`ftps\*(C', \f(CW\*(C\`http\*(C', \f(CW\*(C\`https\*(C', \f(CW\*(C\`iscsi\*(C', \f(CW\*(C\`rbd\*(C', \f(CW\*(C\`ssh\*(C'
and \f(CW`tftp\*(C' protocols, this specifies the remote username.
.Sp
If not given, then the local username is used for \f(CW`ssh\*(C', and no authentication
is attempted for ceph.  But note this sometimes may give unexpected results, for
example if using the libvirt backend and if the libvirt backend is configured to
start the qemu appliance as a special user such as \f(CW`qemu.qemu\*(C'.  If in doubt,
specify the remote username you want.
.ie n .IP """secret""" 4
.el .IP "\f(CWsecret" 4
.IX Item "secret"
For the \f(CW`rbd\*(C' protocol only, this specifies the ‘secret’ to use when
connecting to the remote device.  It must be base64 encoded.
.Sp
If not given, then a secret matching the given username will be looked up in the
default keychain locations, or if no username is given, then no authentication
will be used.
.ie n .IP """cachemode""" 4
.el .IP "\f(CWcachemode" 4
.IX Item "cachemode"
Choose whether or not libguestfs will obey sync operations (safe but slow)
or not (unsafe but fast).  The possible values for this string are:
.ie n .IP """cachemode = ""writeback""""" 4
.el .IP "\f(CWcachemode = \`\`writeback''" 4
.IX Item "cachemode = ""writeback"""
This is the default.
.Sp
Write operations in the \s-1API\s0 do not return until a **write**\|(2)
call has completed in the host [but note this does not imply
that anything gets written to disk].
.Sp
Sync operations in the \s-1API,\s0 including implicit syncs caused by
filesystem journalling, will not return until an **fdatasync**\|(2)
call has completed in the host, indicating that data has been
committed to disk.
.ie n .IP """cachemode = ""unsafe""""" 4
.el .IP "\f(CWcachemode = \`\`unsafe''" 4
.IX Item "cachemode = ""unsafe"""
In this mode, there are no guarantees.  Libguestfs may cache
anything and ignore sync requests.  This is suitable only
for scratch or temporary disks.
.ie n .IP """discard""" 4
.el .IP "\f(CWdiscard" 4
.IX Item "discard"
Enable or disable discard (a.k.a. trim or unmap) support on this
drive.  If enabled, operations such as fstrim\*(R" will be able
to discard / make thin / punch holes in the underlying host file
or device.
.Sp
Possible discard settings are:
.ie n .IP """discard = ""disable""""" 4
.el .IP "\f(CWdiscard = \`\`disable''" 4
.IX Item "discard = ""disable"""
Disable discard support.  This is the default.
.ie n .IP """discard = ""enable""""" 4
.el .IP "\f(CWdiscard = \`\`enable''" 4
.IX Item "discard = ""enable"""
Enable discard support.  Fail if discard is not possible.
.ie n .IP """discard = ""besteffort""""" 4
.el .IP "\f(CWdiscard = \`\`besteffort''" 4
.IX Item "discard = ""besteffort"""
Enable discard support if possible, but don't fail if it is not
supported.
.Sp
Since not all backends and not all underlying systems support
discard, this is a good choice if you want to use discard if
possible, but don't mind if it doesn't work.
.ie n .IP """copyonread""" 4
.el .IP "\f(CWcopyonread" 4
.IX Item "copyonread"
The boolean parameter \f(CW`copyonread\*(C' enables copy-on-read support.
This only affects disk formats which have backing files, and causes
reads to be stored in the overlay layer, speeding up multiple reads
of the same area of disk.
.Sp
The default is false.

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

<a name="add-drive-ro"></a>

### add-drive-ro

.IX Subsection "add-drive-ro"

<a name="add-ro"></a>

### add-ro

.IX Subsection "add-ro"
.Vb 1
 add-drive-ro filename
.Ve

This function is the equivalent of calling add-drive-opts\*(R"
with the optional parameter \f(CW`GUESTFS\_ADD\_DRIVE\_OPTS\_READONLY\*(C' set to 1,
so the disk is added read-only, with the format being detected
automatically.

<a name="add-drive-ro-with-if"></a>

### add-drive-ro-with-if

.IX Subsection "add-drive-ro-with-if"
.Vb 1
 add-drive-ro-with-if filename iface
.Ve

This is the same as add-drive-ro\*(R" but it allows you
to specify the \s-1QEMU\s0 interface emulation to use at run time.

_This function is deprecated._
In new code, use the add-drive\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="add-drive-scratch"></a>

### add-drive-scratch

.IX Subsection "add-drive-scratch"

<a name="scratch"></a>

### scratch

.IX Subsection "scratch"
.Vb 1
 add-drive-scratch size [name:..] [label:..]
.Ve

This command adds a temporary scratch drive to the handle.  The
\f(CW`size\*(C' parameter is the virtual size (in bytes).  The scratch
drive is blank initially (all reads return zeroes until you start
writing to it).  The drive is deleted when the handle is closed.

The optional arguments \f(CW`name\*(C' and \f(CW\*(C\`label\*(C' are passed through to
add-drive\*(R".

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

<a name="add-drive-with-if"></a>

### add-drive-with-if

.IX Subsection "add-drive-with-if"
.Vb 1
 add-drive-with-if filename iface
.Ve

This is the same as add-drive\*(R" but it allows you
to specify the \s-1QEMU\s0 interface emulation to use at run time.

_This function is deprecated._
In new code, use the add-drive\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="aug-clear"></a>

### aug-clear

.IX Subsection "aug-clear"
.Vb 1
 aug-clear augpath
.Ve

Set the value associated with \f(CW`path\*(C' to \f(CW\*(C\`NULL\*(C'.  This
is the same as the **augtool**\|(1) \f(CW`clear\*(C' command.

<a name="aug-close"></a>

### aug-close

.IX Subsection "aug-close"
.Vb 1
 aug-close
.Ve

Close the current Augeas handle and free up any resources
used by it.  After calling this, you have to call
aug-init\*(R" again before you can use any other
Augeas functions.

<a name="aug-defnode"></a>

### aug-defnode

.IX Subsection "aug-defnode"
.Vb 1
 aug-defnode name expr val
.Ve

Defines a variable \f(CW`name\*(C' whose value is the result of
evaluating \f(CW`expr\*(C'.

If \f(CW`expr\*(C' evaluates to an empty nodeset, a node is created,
equivalent to calling aug-set\*(R" \f(CW\*(C\`expr\*(C', \f(CW\*(C\`value\*(C'.
\f(CW`name\*(C' will be the nodeset containing that single node.

On success this returns a pair containing the
number of nodes in the nodeset, and a boolean flag
if a node was created.

<a name="aug-defvar"></a>

### aug-defvar

.IX Subsection "aug-defvar"
.Vb 1
 aug-defvar name expr
.Ve

Defines an Augeas variable \f(CW`name\*(C' whose value is the result
of evaluating \f(CW`expr\*(C'.  If \f(CW\*(C\`expr\*(C' is \s-1NULL,\s0 then \f(CW\*(C\`name\*(C' is
undefined.

On success this returns the number of nodes in \f(CW`expr\*(C', or
\f(CW0 if \f(CW`expr\*(C' evaluates to something which is not a nodeset.

<a name="aug-get"></a>

### aug-get

.IX Subsection "aug-get"
.Vb 1
 aug-get augpath
.Ve

Look up the value associated with \f(CW`path\*(C'.  If \f(CW\*(C\`path\*(C'
matches exactly one node, the \f(CW`value\*(C' is returned.

<a name="aug-init"></a>

### aug-init

.IX Subsection "aug-init"
.Vb 1
 aug-init root flags
.Ve

Create a new Augeas handle for editing configuration files.
If there was any previous Augeas handle associated with this
guestfs session, then it is closed.

You must call this before using any other aug-*\*(R"
commands.

\f(CW`root\*(C' is the filesystem root.  \f(CW\*(C\`root\*(C' must not be \s-1NULL,\s0
use _/_ instead.

The flags are the same as the flags defined in
&lt;augeas.h&gt;, the logical _or_ of the following
integers:
.ie n .IP """AUG_SAVE_BACKUP"" = 1" 4
.el .IP "\f(CWAUG\_SAVE\_BACKUP = 1" 4
.IX Item "AUG_SAVE_BACKUP = 1"
Keep the original file with a \f(CW`.augsave\*(C' extension.
.ie n .IP """AUG_SAVE_NEWFILE"" = 2" 4
.el .IP "\f(CWAUG\_SAVE\_NEWFILE = 2" 4
.IX Item "AUG_SAVE_NEWFILE = 2"
Save changes into a file with extension \f(CW`.augnew\*(C', and
do not overwrite original.  Overrides \f(CW`AUG\_SAVE\_BACKUP\*(C'.
.ie n .IP """AUG_TYPE_CHECK"" = 4" 4
.el .IP "\f(CWAUG\_TYPE\_CHECK = 4" 4
.IX Item "AUG_TYPE_CHECK = 4"
Typecheck lenses.
.Sp
This option is only useful when debugging Augeas lenses.  Use
of this option may require additional memory for the libguestfs
appliance.  You may need to set the \f(CW`LIBGUESTFS\_MEMSIZE\*(C'
environment variable or call set-memsize\*(R".
.ie n .IP """AUG_NO_STDINC"" = 8" 4
.el .IP "\f(CWAUG\_NO\_STDINC = 8" 4
.IX Item "AUG_NO_STDINC = 8"
Do not use standard load path for modules.
.ie n .IP """AUG_SAVE_NOOP"" = 16" 4
.el .IP "\f(CWAUG\_SAVE\_NOOP = 16" 4
.IX Item "AUG_SAVE_NOOP = 16"
Make save a no-op, just record what would have been changed.
.ie n .IP """AUG_NO_LOAD"" = 32" 4
.el .IP "\f(CWAUG\_NO\_LOAD = 32" 4
.IX Item "AUG_NO_LOAD = 32"
Do not load the tree in aug-init\*(R".

To close the handle, you can call aug-close\*(R".

To find out more about Augeas, see http://augeas.net/.

<a name="aug-insert"></a>

### aug-insert

.IX Subsection "aug-insert"
.Vb 1
 aug-insert augpath label true|false
.Ve

Create a new sibling \f(CW`label\*(C' for \f(CW\*(C\`path\*(C', inserting it into
the tree before or after \f(CW`path\*(C' (depending on the boolean
flag \f(CW`before\*(C').

\f(CW`path\*(C' must match exactly one existing node in the tree, and
\f(CW`label\*(C' must be a label, ie. not contain _/_, \f(CW\*(C\`*\*(C' or end
with a bracketed index \f(CW`[N]\*(C'.

<a name="aug-label"></a>

### aug-label

.IX Subsection "aug-label"
.Vb 1
 aug-label augpath
.Ve

The label (name of the last element) of the Augeas path expression
\f(CW`augpath\*(C' is returned.  \f(CW\*(C\`augpath\*(C' must match exactly one node, else
this function returns an error.

<a name="aug-load"></a>

### aug-load

.IX Subsection "aug-load"
.Vb 1
 aug-load
.Ve

Load files into the tree.

See \f(CW`aug\_load\*(C' in the Augeas documentation for the full gory
details.

<a name="aug-ls"></a>

### aug-ls

.IX Subsection "aug-ls"
.Vb 1
 aug-ls augpath
.Ve

This is just a shortcut for listing aug-match\*(R"
\f(CW`path/*\*(C' and sorting the resulting nodes into alphabetical order.

<a name="aug-match"></a>

### aug-match

.IX Subsection "aug-match"
.Vb 1
 aug-match augpath
.Ve

Returns a list of paths which match the path expression \f(CW`path\*(C'.
The returned paths are sufficiently qualified so that they match
exactly one node in the current tree.

<a name="aug-mv"></a>

### aug-mv

.IX Subsection "aug-mv"
.Vb 1
 aug-mv src dest
.Ve

Move the node \f(CW`src\*(C' to \f(CW\*(C\`dest\*(C'.  \f(CW\*(C\`src\*(C' must match exactly
one node.  \f(CW`dest\*(C' is overwritten if it exists.

<a name="aug-rm"></a>

### aug-rm

.IX Subsection "aug-rm"
.Vb 1
 aug-rm augpath
.Ve

Remove \f(CW`path\*(C' and all of its children.

On success this returns the number of entries which were removed.

<a name="aug-save"></a>

### aug-save

.IX Subsection "aug-save"
.Vb 1
 aug-save
.Ve

This writes all pending changes to disk.

The flags which were passed to aug-init\*(R" affect exactly
how files are saved.

<a name="aug-set"></a>

### aug-set

.IX Subsection "aug-set"
.Vb 1
 aug-set augpath val
.Ve

Set the value associated with \f(CW`path\*(C' to \f(CW\*(C\`val\*(C'.

In the Augeas \s-1API,\s0 it is possible to clear a node by setting
the value to \s-1NULL.\s0  Due to an oversight in the libguestfs \s-1API\s0
you cannot do that with this call.  Instead you must use the
aug-clear\*(R" call.

<a name="aug-setm"></a>

### aug-setm

.IX Subsection "aug-setm"
.Vb 1
 aug-setm base sub val
.Ve

Change multiple Augeas nodes in a single operation.  \f(CW`base\*(C' is
an expression matching multiple nodes.  \f(CW`sub\*(C' is a path expression
relative to \f(CW`base\*(C'.  All nodes matching \f(CW\*(C\`base\*(C' are found, and then
for each node, \f(CW`sub\*(C' is changed to \f(CW\*(C\`val\*(C'.  \f(CW\*(C\`sub\*(C' may also be \f(CW\*(C\`NULL\*(C'
in which case the \f(CW`base\*(C' nodes are modified.

This returns the number of nodes modified.

<a name="aug-transform"></a>

### aug-transform

.IX Subsection "aug-transform"
.Vb 1
 aug-transform lens file [remove:true|false]
.Ve

Add an Augeas transformation for the specified \f(CW`lens\*(C' so it can
handle \f(CW`file\*(C'.

If \f(CW`remove\*(C' is true (\f(CW\*(C\`false\*(C' by default), then the transformation
is removed.

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

<a name="available"></a>

### available

.IX Subsection "available"
.Vb 1
 available groups ...\*(Aq
.Ve

This command is used to check the availability of some
groups of functionality in the appliance, which not all builds of
the libguestfs appliance will be able to provide.

The libguestfs groups, and the functions that those
groups correspond to, are listed in \s-1AVAILABILITY\*(R"\s0 in **guestfs**\|(3).
You can also fetch this list at runtime by calling
available-all-groups\*(R".

The argument \f(CW`groups\*(C' is a list of group names, eg:
\f(CW`["inotify", "augeas"]\*(C' would check for the availability of
the Linux inotify functions and Augeas (configuration file
editing) functions.

The command returns no error if _all_ requested groups are available.

It fails with an error if one or more of the requested
groups is unavailable in the appliance.

If an unknown group name is included in the
list of groups then an error is always returned.

_Notes:_

* ·  
  feature-available\*(R" is the same as this call, but
  with a slightly simpler to use \s-1API:\s0 that call returns a boolean
  true/false instead of throwing an error.
* ·  
  You must call launch\*(R" before calling this function.
  .Sp
  The reason is because we don't know what groups are
  supported by the appliance/daemon until it is running and can
  be queried.
* ·  
  If a group of functions is available, this does not necessarily
  mean that they will work.  You still have to check for errors
  when calling individual \s-1API\s0 functions even if they are
  available.
* ·  
  It is usually the job of distro packagers to build
  complete functionality into the libguestfs appliance.
  Upstream libguestfs, if built from source with all
  requirements satisfied, will support everything.
* ·  
  This call was added in version \f(CW1.0.80.  In previous
  versions of libguestfs all you could do would be to speculatively
  execute a command to find out if the daemon implemented it.
  See also version\*(R".

See also filesystem-available\*(R".

<a name="available-all-groups"></a>

### available-all-groups

.IX Subsection "available-all-groups"
.Vb 1
 available-all-groups
.Ve

This command returns a list of all optional groups that this
daemon knows about.  Note this returns both supported and unsupported
groups.  To find out which ones the daemon can actually support
you have to call available\*(R" / \*(L"feature-available\*(R"
on each member of the returned list.

See also available\*(R", \*(L"feature-available\*(R"
and \s-1AVAILABILITY\*(R"\s0 in **guestfs**\|(3).

<a name="base64-in"></a>

### base64\-in

.IX Subsection "base64-in"
.Vb 1
 base64-in (base64file|-) filename
.Ve

This command uploads base64-encoded data from \f(CW`base64file\*(C'
to _filename_.

Use \f(CW`-\*(C' instead of a filename to read/write from stdin/stdout.

<a name="base64-out"></a>

### base64\-out

.IX Subsection "base64-out"
.Vb 1
 base64-out filename (base64file|-)
.Ve

This command downloads the contents of _filename_, writing
it out to local file \f(CW`base64file\*(C' encoded as base64.

Use \f(CW`-\*(C' instead of a filename to read/write from stdin/stdout.

<a name="blkdiscard"></a>

### blkdiscard

.IX Subsection "blkdiscard"
.Vb 1
 blkdiscard device
.Ve

This discards all blocks on the block device \f(CW`device\*(C', giving
the free space back to the host.

This operation requires support in libguestfs, the host filesystem,
qemu and the host kernel.  If this support isn't present it may give
an error or even appear to run but do nothing.  You must also
set the \f(CW`discard\*(C' attribute on the underlying drive (see
add-drive-opts\*(R").

This command depends on the feature \f(CW`blkdiscard\*(C'.   See also
feature-available\*(R".

<a name="blkdiscardzeroes"></a>

### blkdiscardzeroes

.IX Subsection "blkdiscardzeroes"
.Vb 1
 blkdiscardzeroes device
.Ve

This call returns true if blocks on \f(CW`device\*(C' that have been
discarded by a call to blkdiscard\*(R" are returned as
blocks of zero bytes when read the next time.

If it returns false, then it may be that discarded blocks are
read as stale or random data.

This command depends on the feature \f(CW`blkdiscardzeroes\*(C'.   See also
feature-available\*(R".

<a name="blkid"></a>

### blkid

.IX Subsection "blkid"
.Vb 1
 blkid device
.Ve

This command returns block device attributes for \f(CW`device\*(C'. The following fields are
usually present in the returned hash. Other fields may also be present.
.ie n .IP """UUID""" 4
.el .IP "\f(CWUUID" 4
.IX Item "UUID"
The uuid of this device.
.ie n .IP """LABEL""" 4
.el .IP "\f(CWLABEL" 4
.IX Item "LABEL"
The label of this device.
.ie n .IP """VERSION""" 4
.el .IP "\f(CWVERSION" 4
.IX Item "VERSION"
The version of blkid command.
.ie n .IP """TYPE""" 4
.el .IP "\f(CWTYPE" 4
.IX Item "TYPE"
The filesystem type or \s-1RAID\s0 of this device.
.ie n .IP """USAGE""" 4
.el .IP "\f(CWUSAGE" 4
.IX Item "USAGE"
The usage of this device, for example \f(CW`filesystem\*(C' or \f(CW\*(C\`raid\*(C'.

<a name="blockdev-flushbufs"></a>

### blockdev-flushbufs

.IX Subsection "blockdev-flushbufs"
.Vb 1
 blockdev-flushbufs device
.Ve

This tells the kernel to flush internal buffers associated
with \f(CW`device\*(C'.

This uses the **blockdev**\|(8) command.

<a name="blockdev-getbsz"></a>

### blockdev-getbsz

.IX Subsection "blockdev-getbsz"
.Vb 1
 blockdev-getbsz device
.Ve

This returns the block size of a device.

Note: this is different from both _size in blocks_ and
_filesystem block size_.  Also this setting is not really
used by anything.  You should probably not use it for
anything.  Filesystems have their own idea about what
block size to choose.

This uses the **blockdev**\|(8) command.

<a name="blockdev-getro"></a>

### blockdev-getro

.IX Subsection "blockdev-getro"
.Vb 1
 blockdev-getro device
.Ve

Returns a boolean indicating if the block device is read-only
(true if read-only, false if not).

This uses the **blockdev**\|(8) command.

<a name="blockdev-getsize64"></a>

### blockdev\-getsize64

.IX Subsection "blockdev-getsize64"
.Vb 1
 blockdev-getsize64 device
.Ve

This returns the size of the device in bytes.

See also blockdev-getsz\*(R".

This uses the **blockdev**\|(8) command.

<a name="blockdev-getss"></a>

### blockdev-getss

.IX Subsection "blockdev-getss"
.Vb 1
 blockdev-getss device
.Ve

This returns the size of sectors on a block device.
Usually 512, but can be larger for modern devices.

(Note, this is not the size in sectors, use blockdev-getsz\*(R"
for that).

This uses the **blockdev**\|(8) command.

<a name="blockdev-getsz"></a>

### blockdev-getsz

.IX Subsection "blockdev-getsz"
.Vb 1
 blockdev-getsz device
.Ve

This returns the size of the device in units of 512-byte sectors
(even if the sectorsize isn't 512 bytes ... weird).

See also blockdev-getss\*(R" for the real sector size of
the device, and blockdev-getsize64\*(R" for the more
useful _size in bytes_.

This uses the **blockdev**\|(8) command.

<a name="blockdev-rereadpt"></a>

### blockdev-rereadpt

.IX Subsection "blockdev-rereadpt"
.Vb 1
 blockdev-rereadpt device
.Ve

Reread the partition table on \f(CW`device\*(C'.

This uses the **blockdev**\|(8) command.

<a name="blockdev-setbsz"></a>

### blockdev-setbsz

.IX Subsection "blockdev-setbsz"
.Vb 1
 blockdev-setbsz device blocksize
.Ve

This call does nothing and has never done anything
because of a bug in blockdev.  **Do not use it.**

If you need to set the filesystem block size, use the
\f(CW`blocksize\*(C' option of \*(L"mkfs\*(R".

_This function is deprecated._
There is no replacement.  Consult the \s-1API\s0 documentation in
**guestfs**\|(3) for further information.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="blockdev-setra"></a>

### blockdev-setra

.IX Subsection "blockdev-setra"
.Vb 1
 blockdev-setra device sectors
.Ve

Set readahead (in 512-byte sectors) for the device.

This uses the **blockdev**\|(8) command.

<a name="blockdev-setro"></a>

### blockdev-setro

.IX Subsection "blockdev-setro"
.Vb 1
 blockdev-setro device
.Ve

Sets the block device named \f(CW`device\*(C' to read-only.

This uses the **blockdev**\|(8) command.

<a name="blockdev-setrw"></a>

### blockdev-setrw

.IX Subsection "blockdev-setrw"
.Vb 1
 blockdev-setrw device
.Ve

Sets the block device named \f(CW`device\*(C' to read-write.

This uses the **blockdev**\|(8) command.

<a name="btrfs-balance-cancel"></a>

### btrfs-balance-cancel

.IX Subsection "btrfs-balance-cancel"
.Vb 1
 btrfs-balance-cancel path
.Ve

Cancel a running balance on a btrfs filesystem.

This command depends on the feature \f(CW`btrfs\*(C'.   See also
feature-available\*(R".

<a name="btrfs-balance-pause"></a>

### btrfs-balance-pause

.IX Subsection "btrfs-balance-pause"
.Vb 1
 btrfs-balance-pause path
.Ve

Pause a running balance on a btrfs filesystem.

This command depends on the feature \f(CW`btrfs\*(C'.   See also
feature-available\*(R".

<a name="btrfs-balance-resume"></a>

### btrfs-balance-resume

.IX Subsection "btrfs-balance-resume"
.Vb 1
 btrfs-balance-resume path
.Ve

Resume a paused balance on a btrfs filesystem.

This command depends on the feature \f(CW`btrfs\*(C'.   See also
feature-available\*(R".

<a name="btrfs-balance-status"></a>

### btrfs-balance-status

.IX Subsection "btrfs-balance-status"
.Vb 1
 btrfs-balance-status path
.Ve

Show the status of a running or paused balance on a btrfs filesystem.

This command depends on the feature \f(CW`btrfs\*(C'.   See also
feature-available\*(R".

<a name="btrfs-device-add"></a>

### btrfs-device-add

.IX Subsection "btrfs-device-add"
.Vb 1
 btrfs-device-add devices ...\*(Aq fs
.Ve

Add the list of device(s) in \f(CW`devices\*(C' to the btrfs filesystem
mounted at \f(CW`fs\*(C'.  If \f(CW\*(C\`devices\*(C' is an empty list, this does nothing.

This command depends on the feature \f(CW`btrfs\*(C'.   See also
feature-available\*(R".

<a name="btrfs-device-delete"></a>

### btrfs-device-delete

.IX Subsection "btrfs-device-delete"
.Vb 1
 btrfs-device-delete devices ...\*(Aq fs
.Ve

Remove the \f(CW`devices\*(C' from the btrfs filesystem mounted at \f(CW\*(C\`fs\*(C'.
If \f(CW`devices\*(C' is an empty list, this does nothing.

This command depends on the feature \f(CW`btrfs\*(C'.   See also
feature-available\*(R".

<a name="btrfs-filesystem-balance"></a>

### btrfs-filesystem-balance

.IX Subsection "btrfs-filesystem-balance"

<a name="btrfs-balance"></a>

### btrfs-balance

.IX Subsection "btrfs-balance"
.Vb 1
 btrfs-filesystem-balance fs
.Ve

Balance the chunks in the btrfs filesystem mounted at \f(CW`fs\*(C'
across the underlying devices.

This command depends on the feature \f(CW`btrfs\*(C'.   See also
feature-available\*(R".

<a name="btrfs-filesystem-defragment"></a>

### btrfs-filesystem-defragment

.IX Subsection "btrfs-filesystem-defragment"
.Vb 1
 btrfs-filesystem-defragment path [flush:true|false] [compress:..]
.Ve

Defragment a file or directory on a btrfs filesystem. compress is one of zlib or lzo.

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

This command depends on the feature \f(CW`btrfs\*(C'.   See also
feature-available\*(R".

<a name="btrfs-filesystem-resize"></a>

### btrfs-filesystem-resize

.IX Subsection "btrfs-filesystem-resize"
.Vb 1
 btrfs-filesystem-resize mountpoint [size:N]
.Ve

This command resizes a btrfs filesystem.

Note that unlike other resize calls, the filesystem has to be
mounted and the parameter is the mountpoint not the device
(this is a requirement of btrfs itself).

The optional parameters are:
.ie n .IP """size""" 4
.el .IP "\f(CWsize" 4
.IX Item "size"
The new size (in bytes) of the filesystem.  If omitted, the filesystem
is resized to the maximum size.

See also **btrfs**\|(8).

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

This command depends on the feature \f(CW`btrfs\*(C'.   See also
feature-available\*(R".

<a name="btrfs-filesystem-show"></a>

### btrfs-filesystem-show

.IX Subsection "btrfs-filesystem-show"
.Vb 1
 btrfs-filesystem-show device
.Ve

Show all the devices where the filesystems in \f(CW`device\*(C' is spanned over.

If not all the devices for the filesystems are present, then this function
fails and the \f(CW`errno\*(C' is set to \f(CW\*(C\`ENODEV\*(C'.

This command depends on the feature \f(CW`btrfs\*(C'.   See also
feature-available\*(R".

<a name="btrfs-filesystem-sync"></a>

### btrfs-filesystem-sync

.IX Subsection "btrfs-filesystem-sync"
.Vb 1
 btrfs-filesystem-sync fs
.Ve

Force sync on the btrfs filesystem mounted at \f(CW`fs\*(C'.

This command depends on the feature \f(CW`btrfs\*(C'.   See also
feature-available\*(R".

<a name="btrfs-fsck"></a>

### btrfs-fsck

.IX Subsection "btrfs-fsck"
.Vb 1
 btrfs-fsck device [superblock:N] [repair:true|false]
.Ve

Used to check a btrfs filesystem, \f(CW`device\*(C' is the device file where the
filesystem is stored.

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

This command depends on the feature \f(CW`btrfs\*(C'.   See also
feature-available\*(R".

<a name="btrfs-image"></a>

### btrfs-image

.IX Subsection "btrfs-image"
.Vb 1
 btrfs-image source ...\*(Aq image [compresslevel:N]
.Ve

This is used to create an image of a btrfs filesystem.
All data will be zeroed, but metadata and the like is preserved.

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

This command depends on the feature \f(CW`btrfs\*(C'.   See also
feature-available\*(R".

<a name="btrfs-qgroup-assign"></a>

### btrfs-qgroup-assign

.IX Subsection "btrfs-qgroup-assign"
.Vb 1
 btrfs-qgroup-assign src dst path
.Ve

Add qgroup \f(CW`src\*(C' to parent qgroup \f(CW\*(C\`dst\*(C'. This command can group
several qgroups into a parent qgroup to share common limit.

This command depends on the feature \f(CW`btrfs\*(C'.   See also
feature-available\*(R".

<a name="btrfs-qgroup-create"></a>

### btrfs-qgroup-create

.IX Subsection "btrfs-qgroup-create"
.Vb 1
 btrfs-qgroup-create qgroupid subvolume
.Ve

Create a quota group (qgroup) for subvolume at \f(CW`subvolume\*(C'.

This command depends on the feature \f(CW`btrfs\*(C'.   See also
feature-available\*(R".

<a name="btrfs-qgroup-destroy"></a>

### btrfs-qgroup-destroy

.IX Subsection "btrfs-qgroup-destroy"
.Vb 1
 btrfs-qgroup-destroy qgroupid subvolume
.Ve

Destroy a quota group.

This command depends on the feature \f(CW`btrfs\*(C'.   See also
feature-available\*(R".

<a name="btrfs-qgroup-limit"></a>

### btrfs-qgroup-limit

.IX Subsection "btrfs-qgroup-limit"
.Vb 1
 btrfs-qgroup-limit subvolume size
.Ve

Limit the size of the subvolume with path \f(CW`subvolume\*(C'.

This command depends on the feature \f(CW`btrfs\*(C'.   See also
feature-available\*(R".

<a name="btrfs-qgroup-remove"></a>

### btrfs-qgroup-remove

.IX Subsection "btrfs-qgroup-remove"
.Vb 1
 btrfs-qgroup-remove src dst path
.Ve

Remove qgroup \f(CW`src\*(C' from the parent qgroup \f(CW\*(C\`dst\*(C'.

This command depends on the feature \f(CW`btrfs\*(C'.   See also
feature-available\*(R".

<a name="btrfs-qgroup-show"></a>

### btrfs-qgroup-show

.IX Subsection "btrfs-qgroup-show"
.Vb 1
 btrfs-qgroup-show path
.Ve

Show all subvolume quota groups in a btrfs filesystem, including their
usages.

This command depends on the feature \f(CW`btrfs\*(C'.   See also
feature-available\*(R".

<a name="btrfs-quota-enable"></a>

### btrfs-quota-enable

.IX Subsection "btrfs-quota-enable"
.Vb 1
 btrfs-quota-enable fs true|false
.Ve

Enable or disable subvolume quota support for filesystem which contains \f(CW`path\*(C'.

This command depends on the feature \f(CW`btrfs\*(C'.   See also
feature-available\*(R".

<a name="btrfs-quota-rescan"></a>

### btrfs-quota-rescan

.IX Subsection "btrfs-quota-rescan"
.Vb 1
 btrfs-quota-rescan fs
.Ve

Trash all qgroup numbers and scan the metadata again with the current config.

This command depends on the feature \f(CW`btrfs\*(C'.   See also
feature-available\*(R".

<a name="btrfs-replace"></a>

### btrfs-replace

.IX Subsection "btrfs-replace"
.Vb 1
 btrfs-replace srcdev targetdev mntpoint
.Ve

Replace device of a btrfs filesystem. On a live filesystem, duplicate the data
to the target device which is currently stored on the source device.
After completion of the operation, the source device is wiped out and
removed from the filesystem.

The \f(CW`targetdev\*(C' needs to be same size or larger than the \f(CW\*(C\`srcdev\*(C'. Devices
which are currently mounted are never allowed to be used as the \f(CW`targetdev\*(C'.

This command depends on the feature \f(CW`btrfs\*(C'.   See also
feature-available\*(R".

<a name="btrfs-rescue-chunk-recover"></a>

### btrfs-rescue-chunk-recover

.IX Subsection "btrfs-rescue-chunk-recover"
.Vb 1
 btrfs-rescue-chunk-recover device
.Ve

Recover the chunk tree of btrfs filesystem by scanning the devices one by one.

This command depends on the feature \f(CW`btrfs\*(C'.   See also
feature-available\*(R".

<a name="btrfs-rescue-super-recover"></a>

### btrfs-rescue-super-recover

.IX Subsection "btrfs-rescue-super-recover"
.Vb 1
 btrfs-rescue-super-recover device
.Ve

Recover bad superblocks from good copies.

This command depends on the feature \f(CW`btrfs\*(C'.   See also
feature-available\*(R".

<a name="btrfs-scrub-cancel"></a>

### btrfs-scrub-cancel

.IX Subsection "btrfs-scrub-cancel"
.Vb 1
 btrfs-scrub-cancel path
.Ve

Cancel a running scrub on a btrfs filesystem.

This command depends on the feature \f(CW`btrfs\*(C'.   See also
feature-available\*(R".

<a name="btrfs-scrub-resume"></a>

### btrfs-scrub-resume

.IX Subsection "btrfs-scrub-resume"
.Vb 1
 btrfs-scrub-resume path
.Ve

Resume a previously canceled or interrupted scrub on a btrfs filesystem.

This command depends on the feature \f(CW`btrfs\*(C'.   See also
feature-available\*(R".

<a name="btrfs-scrub-start"></a>

### btrfs-scrub-start

.IX Subsection "btrfs-scrub-start"
.Vb 1
 btrfs-scrub-start path
.Ve

Reads all the data and metadata on the filesystem, and uses checksums
and the duplicate copies from \s-1RAID\s0 storage to identify and repair any
corrupt data.

This command depends on the feature \f(CW`btrfs\*(C'.   See also
feature-available\*(R".

<a name="btrfs-scrub-status"></a>

### btrfs-scrub-status

.IX Subsection "btrfs-scrub-status"
.Vb 1
 btrfs-scrub-status path
.Ve

Show status of running or finished scrub on a btrfs filesystem.

This command depends on the feature \f(CW`btrfs\*(C'.   See also
feature-available\*(R".

<a name="btrfs-set-seeding"></a>

### btrfs-set-seeding

.IX Subsection "btrfs-set-seeding"
.Vb 1
 btrfs-set-seeding device true|false
.Ve

Enable or disable the seeding feature of a device that contains
a btrfs filesystem.

This command depends on the feature \f(CW`btrfs\*(C'.   See also
feature-available\*(R".

<a name="btrfs-subvolume-create"></a>

### btrfs-subvolume-create

.IX Subsection "btrfs-subvolume-create"

<a name="btrfs-subvolume-create-opts"></a>

### btrfs-subvolume-create-opts

.IX Subsection "btrfs-subvolume-create-opts"
.Vb 1
 btrfs-subvolume-create dest [qgroupid:..]
.Ve

Create a btrfs subvolume.  The \f(CW`dest\*(C' argument is the destination
directory and the name of the subvolume, in the form _/path/to/dest/name_.
The optional parameter \f(CW`qgroupid\*(C' represents the qgroup which the newly
created subvolume will be added to.

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

This command depends on the feature \f(CW`btrfs\*(C'.   See also
feature-available\*(R".

<a name="btrfs-subvolume-delete"></a>

### btrfs-subvolume-delete

.IX Subsection "btrfs-subvolume-delete"
.Vb 1
 btrfs-subvolume-delete subvolume
.Ve

Delete the named btrfs subvolume or snapshot.

This command depends on the feature \f(CW`btrfs\*(C'.   See also
feature-available\*(R".

<a name="btrfs-subvolume-get-default"></a>

### btrfs-subvolume-get-default

.IX Subsection "btrfs-subvolume-get-default"
.Vb 1
 btrfs-subvolume-get-default fs
.Ve

Get the default subvolume or snapshot of a filesystem mounted at \f(CW`mountpoint\*(C'.

This command depends on the feature \f(CW`btrfs\*(C'.   See also
feature-available\*(R".

<a name="btrfs-subvolume-list"></a>

### btrfs-subvolume-list

.IX Subsection "btrfs-subvolume-list"
.Vb 1
 btrfs-subvolume-list fs
.Ve

List the btrfs snapshots and subvolumes of the btrfs filesystem
which is mounted at \f(CW`fs\*(C'.

This command depends on the feature \f(CW`btrfs\*(C'.   See also
feature-available\*(R".

<a name="btrfs-subvolume-set-default"></a>

### btrfs-subvolume-set-default

.IX Subsection "btrfs-subvolume-set-default"
.Vb 1
 btrfs-subvolume-set-default id fs
.Ve

Set the subvolume of the btrfs filesystem \f(CW`fs\*(C' which will
be mounted by default.  See btrfs-subvolume-list\*(R" to
get a list of subvolumes.

This command depends on the feature \f(CW`btrfs\*(C'.   See also
feature-available\*(R".

<a name="btrfs-subvolume-show"></a>

### btrfs-subvolume-show

.IX Subsection "btrfs-subvolume-show"
.Vb 1
 btrfs-subvolume-show subvolume
.Ve

Return detailed information of the subvolume.

This command depends on the feature \f(CW`btrfs\*(C'.   See also
feature-available\*(R".

<a name="btrfs-subvolume-snapshot"></a>

### btrfs-subvolume-snapshot

.IX Subsection "btrfs-subvolume-snapshot"

<a name="btrfs-subvolume-snapshot-opts"></a>

### btrfs-subvolume-snapshot-opts

.IX Subsection "btrfs-subvolume-snapshot-opts"
.Vb 1
 btrfs-subvolume-snapshot source dest [ro:true|false] [qgroupid:..]
.Ve

Create a snapshot of the btrfs subvolume \f(CW`source\*(C'.
The \f(CW`dest\*(C' argument is the destination directory and the name
of the snapshot, in the form _/path/to/dest/name_. By default
the newly created snapshot is writable, if the value of optional
parameter \f(CW`ro\*(C' is true, then a readonly snapshot is created. The
optional parameter \f(CW`qgroupid\*(C' represents the qgroup which the
newly created snapshot will be added to.

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

This command depends on the feature \f(CW`btrfs\*(C'.   See also
feature-available\*(R".

<a name="btrfstune-enable-extended-inode-refs"></a>

### btrfstune-enable-extended-inode-refs

.IX Subsection "btrfstune-enable-extended-inode-refs"
.Vb 1
 btrfstune-enable-extended-inode-refs device
.Ve

This will Enable extended inode refs.

This command depends on the feature \f(CW`btrfs\*(C'.   See also
feature-available\*(R".

<a name="btrfstune-enable-skinny-metadata-extent-refs"></a>

### btrfstune-enable-skinny-metadata-extent-refs

.IX Subsection "btrfstune-enable-skinny-metadata-extent-refs"
.Vb 1
 btrfstune-enable-skinny-metadata-extent-refs device
.Ve

This enable skinny metadata extent refs.

This command depends on the feature \f(CW`btrfs\*(C'.   See also
feature-available\*(R".

<a name="btrfstune-seeding"></a>

### btrfstune-seeding

.IX Subsection "btrfstune-seeding"
.Vb 1
 btrfstune-seeding device true|false
.Ve

Enable seeding of a btrfs device, this will force a fs readonly
so that you can use it to build other filesystems.

This command depends on the feature \f(CW`btrfs\*(C'.   See also
feature-available\*(R".

<a name="c-pointer"></a>

### c\-pointer

.IX Subsection "c-pointer"
.Vb 1
 c-pointer
.Ve

In non-C language bindings, this allows you to retrieve the underlying
C pointer to the handle (ie. h *\*(R").  The purpose of this is
to allow other libraries to interwork with libguestfs.

<a name="canonical-device-name"></a>

### canonical-device-name

.IX Subsection "canonical-device-name"
.Vb 1
 canonical-device-name device
.Ve

This utility function is useful when displaying device names to
the user.  It takes a number of irregular device names and
returns them in a consistent format:

* _/dev/hdX_  
  .IX Item "/dev/hdX"
* _/dev/vdX_  
  .IX Item "/dev/vdX"
  These are returned as _/dev/sdX_.  Note this works for device
  names and partition names.  This is approximately the reverse of
  the algorithm described in \s-1BLOCK DEVICE NAMING\*(R"\s0 in **guestfs**\|(3).
* _/dev/mapper/VG-LV_  
  .IX Item "/dev/mapper/VG-LV"
* _/dev/dm-N_  
  .IX Item "/dev/dm-N"
  Converted to _/dev/VG/LV_ form using lvm-canonical-lv-name\*(R".

Other strings are returned unmodified.

<a name="cap-get-file"></a>

### cap-get-file

.IX Subsection "cap-get-file"
.Vb 1
 cap-get-file path
.Ve

This function returns the Linux capabilities attached to \f(CW`path\*(C'.
The capabilities set is returned in text form (see **cap\_to\_text**\|(3)).

If no capabilities are attached to a file, an empty string is returned.

This command depends on the feature \f(CW`linuxcaps\*(C'.   See also
feature-available\*(R".

<a name="cap-set-file"></a>

### cap-set-file

.IX Subsection "cap-set-file"
.Vb 1
 cap-set-file path cap
.Ve

This function sets the Linux capabilities attached to \f(CW`path\*(C'.
The capabilities set \f(CW`cap\*(C' should be passed in text form
(see **cap\_from\_text**\|(3)).

This command depends on the feature \f(CW`linuxcaps\*(C'.   See also
feature-available\*(R".

<a name="case-sensitive-path"></a>

### case-sensitive-path

.IX Subsection "case-sensitive-path"
.Vb 1
 case-sensitive-path path
.Ve

This can be used to resolve case insensitive paths on
a filesystem which is case sensitive.  The use case is
to resolve paths which you have read from Windows configuration
files or the Windows Registry, to the true path.

The command handles a peculiarity of the Linux ntfs-3g
filesystem driver (and probably others), which is that although
the underlying filesystem is case-insensitive, the driver
exports the filesystem to Linux as case-sensitive.

One consequence of this is that special directories such
as _C:\ewindows_ may appear as _/WINDOWS_ or _/windows_
(or other things) depending on the precise details of how
they were created.  In Windows itself this would not be
a problem.

Bug or feature?  You decide:
http://www.tuxera.com/community/ntfs-3g-faq/#posixfilenames1

case-sensitive-path\*(R" attempts to resolve the true case of
each element in the path. It will return a resolved path if either the
full path or its parent directory exists. If the parent directory
exists but the full path does not, the case of the parent directory
will be correctly resolved, and the remainder appended unmodified. For
example, if the file \f(CW"/Windows/System32/netkvm.sys" exists:
.ie n .IP """case-sensitive-path"" (""/windows/system32/netkvm.sys"")" 4
.el .IP "\`\`case-sensitive-path'' (\`\`/windows/system32/netkvm.sys'')" 4
.IX Item "case-sensitive-path (/windows/system32/netkvm.sys)"
Windows/System32/netkvm.sys\*(R"
.ie n .IP """case-sensitive-path"" (""/windows/system32/NoSuchFile"")" 4
.el .IP "\`\`case-sensitive-path'' (\`\`/windows/system32/NoSuchFile'')" 4
.IX Item "case-sensitive-path (/windows/system32/NoSuchFile)"
Windows/System32/NoSuchFile\*(R"
.ie n .IP """case-sensitive-path"" (""/windows/system33/netkvm.sys"")" 4
.el .IP "\`\`case-sensitive-path'' (\`\`/windows/system33/netkvm.sys'')" 4
.IX Item "case-sensitive-path (/windows/system33/netkvm.sys)"
_\s-1ERROR\s0_

_Note_:
Because of the above behaviour, case-sensitive-path\*(R" cannot
be used to check for the existence of a file.

_Note_:
This function does not handle drive names, backslashes etc.

See also realpath\*(R".

<a name="cat"></a>

### cat

.IX Subsection "cat"
.Vb 1
 cat path
.Ve

Return the contents of the file named \f(CW`path\*(C'.

Because, in C, this function returns a \f(CW`char *\*(C', there is no
way to differentiate between a \f(CW`\e0\*(C' character in a file and
end of string.  To handle binary files, use the read-file\*(R"
or download\*(R" functions.

<a name="checksum"></a>

### checksum

.IX Subsection "checksum"
.Vb 1
 checksum csumtype path
.Ve

This call computes the \s-1MD5,\s0 SHAx or \s-1CRC\s0 checksum of the
file named \f(CW`path\*(C'.

The type of checksum to compute is given by the \f(CW`csumtype\*(C'
parameter which must have one of the following values:
.ie n .IP """crc""" 4
.el .IP "\f(CWcrc" 4
.IX Item "crc"
Compute the cyclic redundancy check (\s-1CRC\s0) specified by \s-1POSIX\s0
for the \f(CW`cksum\*(C' command.
.ie n .IP """md5""" 4
.el .IP "\f(CWmd5" 4
.IX Item "md5"
Compute the \s-1MD5\s0 hash (using the \f(CW`md5sum\*(C' program).
.ie n .IP """sha1""" 4
.el .IP "\f(CWsha1" 4
.IX Item "sha1"
Compute the \s-1SHA1\s0 hash (using the \f(CW`sha1sum\*(C' program).
.ie n .IP """sha224""" 4
.el .IP "\f(CWsha224" 4
.IX Item "sha224"
Compute the \s-1SHA224\s0 hash (using the \f(CW`sha224sum\*(C' program).
.ie n .IP """sha256""" 4
.el .IP "\f(CWsha256" 4
.IX Item "sha256"
Compute the \s-1SHA256\s0 hash (using the \f(CW`sha256sum\*(C' program).
.ie n .IP """sha384""" 4
.el .IP "\f(CWsha384" 4
.IX Item "sha384"
Compute the \s-1SHA384\s0 hash (using the \f(CW`sha384sum\*(C' program).
.ie n .IP """sha512""" 4
.el .IP "\f(CWsha512" 4
.IX Item "sha512"
Compute the \s-1SHA512\s0 hash (using the \f(CW`sha512sum\*(C' program).

The checksum is returned as a printable string.

To get the checksum for a device, use checksum-device\*(R".

To get the checksums for many files, use checksums-out\*(R".

<a name="checksum-device"></a>

### checksum-device

.IX Subsection "checksum-device"
.Vb 1
 checksum-device csumtype device
.Ve

This call computes the \s-1MD5,\s0 SHAx or \s-1CRC\s0 checksum of the
contents of the device named \f(CW`device\*(C'.  For the types of
checksums supported see the checksum\*(R" command.

<a name="checksums-out"></a>

### checksums-out

.IX Subsection "checksums-out"
.Vb 1
 checksums-out csumtype directory (sumsfile|-)
.Ve

This command computes the checksums of all regular files in
_directory_ and then emits a list of those checksums to
the local output file \f(CW`sumsfile\*(C'.

This can be used for verifying the integrity of a virtual
machine.  However to be properly secure you should pay
attention to the output of the checksum command (it uses
the ones from \s-1GNU\s0 coreutils).  In particular when the
filename is not printable, coreutils uses a special
backslash syntax.  For more information, see the \s-1GNU\s0
coreutils info file.

Use \f(CW`-\*(C' instead of a filename to read/write from stdin/stdout.

<a name="chmod"></a>

### chmod

.IX Subsection "chmod"
.Vb 1
 chmod mode path
.Ve

Change the mode (permissions) of \f(CW`path\*(C' to \f(CW\*(C\`mode\*(C'.  Only
numeric modes are supported.

_Note_: When using this command from guestfish, \f(CW`mode\*(C'
by default would be decimal, unless you prefix it with
\f(CW0 to get octal, ie. use \f(CW0700 not \f(CW700.

The mode actually set is affected by the umask.

<a name="chown"></a>

### chown

.IX Subsection "chown"
.Vb 1
 chown owner group path
.Ve

Change the file owner to \f(CW`owner\*(C' and group to \f(CW\*(C\`group\*(C'.

Only numeric uid and gid are supported.  If you want to use
names, you will need to locate and parse the password file
yourself (Augeas support makes this relatively easy).

<a name="clear-backend-setting"></a>

### clear-backend-setting

.IX Subsection "clear-backend-setting"
.Vb 1
 clear-backend-setting name
.Ve

If there is a backend setting string matching \f(CW"name" or
beginning with \f(CW"name=", then that string is removed
from the backend settings.

This call returns the number of strings which were removed
(which may be 0, 1 or greater than 1).

See \s-1BACKEND\*(R"\s0 in **guestfs**\|(3), \*(L"\s-1BACKEND SETTINGS\*(R"\s0 in **guestfs**\|(3).

<a name="command"></a>

### command

.IX Subsection "command"
.Vb 1
 command arguments ...\*(Aq
.Ve

This call runs a command from the guest filesystem.  The
filesystem must be mounted, and must contain a compatible
operating system (ie. something Linux, with the same
or compatible processor architecture).

The single parameter is an argv-style list of arguments.
The first element is the name of the program to run.
Subsequent elements are parameters.  The list must be
non-empty (ie. must contain a program name).  Note that
the command runs directly, and is _not_ invoked via
the shell (see sh\*(R").

The return value is anything printed to _stdout_ by
the command.

If the command returns a non-zero exit status, then
this function returns an error message.  The error message
string is the content of _stderr_ from the command.

The \f(CW$PATH environment variable will contain at least
_/usr/bin_ and _/bin_.  If you require a program from
another location, you should provide the full path in the
first parameter.

Shared libraries and data files required by the program
must be available on filesystems which are mounted in the
correct places.  It is the caller’s responsibility to ensure
all filesystems that are needed are mounted at the right
locations.

Because of the message protocol, there is a transfer limit
of somewhere between 2MB and 4MB.  See \s-1PROTOCOL LIMITS\*(R"\s0 in **guestfs**\|(3).

<a name="command-lines"></a>

### command-lines

.IX Subsection "command-lines"
.Vb 1
 command-lines arguments ...\*(Aq
.Ve

This is the same as command\*(R", but splits the
result into a list of lines.

See also: sh-lines\*(R"

Because of the message protocol, there is a transfer limit
of somewhere between 2MB and 4MB.  See \s-1PROTOCOL LIMITS\*(R"\s0 in **guestfs**\|(3).

<a name="compress-device-out"></a>

### compress-device-out

.IX Subsection "compress-device-out"
.Vb 1
 compress-device-out ctype device (zdevice|-) [level:N]
.Ve

This command compresses \f(CW`device\*(C' and writes it out to the local
file \f(CW`zdevice\*(C'.

The \f(CW`ctype\*(C' and optional \f(CW\*(C\`level\*(C' parameters have the same meaning
as in compress-out\*(R".

Use \f(CW`-\*(C' instead of a filename to read/write from stdin/stdout.

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

<a name="compress-out"></a>

### compress-out

.IX Subsection "compress-out"
.Vb 1
 compress-out ctype file (zfile|-) [level:N]
.Ve

This command compresses _file_ and writes it out to the local
file _zfile_.

The compression program used is controlled by the \f(CW`ctype\*(C' parameter.
Currently this includes: \f(CW`compress\*(C', \f(CW\*(C\`gzip\*(C', \f(CW\*(C\`bzip2\*(C', \f(CW\*(C\`xz\*(C' or \f(CW\*(C\`lzop\*(C'.
Some compression types may not be supported by particular builds of
libguestfs, in which case you will get an error containing the
substring not supported\*(R".

The optional \f(CW`level\*(C' parameter controls compression level.  The
meaning and default for this parameter depends on the compression
program being used.

Use \f(CW`-\*(C' instead of a filename to read/write from stdin/stdout.

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

<a name="config"></a>

### config

.IX Subsection "config"
.Vb 1
 config hvparam hvvalue
.Ve

This can be used to add arbitrary hypervisor parameters of the
form _-param value_.  Actually it’s not quite arbitrary - we
prevent you from setting some parameters which would interfere with
parameters that we use.

The first character of \f(CW`hvparam\*(C' string must be a \f(CW\*(C\`-\*(C' (dash).

\f(CW`hvvalue\*(C' can be \s-1NULL.\s0

<a name="copy-attributes"></a>

### copy-attributes

.IX Subsection "copy-attributes"
.Vb 1
 copy-attributes src dest [all:true|false] [mode:true|false] [xattributes:true|false] [ownership:true|false]
.Ve

Copy the attributes of a path (which can be a file or a directory)
to another path.

By default \f(CW`no\*(C' attribute is copied, so make sure to specify any
(or \f(CW`all\*(C' to copy everything).

The optional arguments specify which attributes can be copied:
.ie n .IP """mode""" 4
.el .IP "\f(CWmode" 4
.IX Item "mode"
Copy part of the file mode from \f(CW`source\*(C' to \f(CW\*(C\`destination\*(C'. Only the
\s-1UNIX\s0 permissions and the sticky/setuid/setgid bits can be copied.
.ie n .IP """xattributes""" 4
.el .IP "\f(CWxattributes" 4
.IX Item "xattributes"
Copy the Linux extended attributes (xattrs) from \f(CW`source\*(C' to \f(CW\*(C\`destination\*(C'.
This flag does nothing if the _linuxxattrs_ feature is not available
(see feature-available\*(R").
.ie n .IP """ownership""" 4
.el .IP "\f(CWownership" 4
.IX Item "ownership"
Copy the owner uid and the group gid of \f(CW`source\*(C' to \f(CW\*(C\`destination\*(C'.
.ie n .IP """all""" 4
.el .IP "\f(CWall" 4
.IX Item "all"
Copy **all** the attributes from \f(CW`source\*(C' to \f(CW\*(C\`destination\*(C'. Enabling it
enables all the other flags, if they are not specified already.

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

<a name="copy-device-to-device"></a>

### copy-device-to-device

.IX Subsection "copy-device-to-device"
.Vb 1
 copy-device-to-device src dest [srcoffset:N] [destoffset:N] [size:N] [sparse:true|false] [append:true|false]
.Ve

The four calls copy-device-to-device\*(R",
copy-device-to-file\*(R",
copy-file-to-device\*(R", and
copy-file-to-file\*(R"
let you copy from a source (device|file) to a destination
(device|file).

Partial copies can be made since you can specify optionally
the source offset, destination offset and size to copy.  These
values are all specified in bytes.  If not given, the offsets
both default to zero, and the size defaults to copying as much
as possible until we hit the end of the source.

The source and destination may be the same object.  However
overlapping regions may not be copied correctly.

If the destination is a file, it is created if required.  If
the destination file is not large enough, it is extended.

If the destination is a file and the \f(CW`append\*(C' flag is not set,
then the destination file is truncated.  If the \f(CW`append\*(C' flag is
set, then the copy appends to the destination file.  The \f(CW`append\*(C'
flag currently cannot be set for devices.

If the \f(CW`sparse\*(C' flag is true then the call avoids writing
blocks that contain only zeroes, which can help in some situations
where the backing disk is thin-provisioned.  Note that unless
the target is already zeroed, using this option will result
in incorrect copying.

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

<a name="copy-device-to-file"></a>

### copy-device-to-file

.IX Subsection "copy-device-to-file"
.Vb 1
 copy-device-to-file src dest [srcoffset:N] [destoffset:N] [size:N] [sparse:true|false] [append:true|false]
.Ve

See copy-device-to-device\*(R" for a general overview
of this call.

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

<a name="copy-file-to-device"></a>

### copy-file-to-device

.IX Subsection "copy-file-to-device"
.Vb 1
 copy-file-to-device src dest [srcoffset:N] [destoffset:N] [size:N] [sparse:true|false] [append:true|false]
.Ve

See copy-device-to-device\*(R" for a general overview
of this call.

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

<a name="copy-file-to-file"></a>

### copy-file-to-file

.IX Subsection "copy-file-to-file"
.Vb 1
 copy-file-to-file src dest [srcoffset:N] [destoffset:N] [size:N] [sparse:true|false] [append:true|false]
.Ve

See copy-device-to-device\*(R" for a general overview
of this call.

This is **not** the function you want for copying files.  This
is for copying blocks within existing files.  See cp\*(R",
cp-a\*(R" and \*(L"mv\*(R" for general file copying and
moving functions.

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

<a name="copy-size"></a>

### copy-size

.IX Subsection "copy-size"
.Vb 1
 copy-size src dest size
.Ve

This command copies exactly \f(CW`size\*(C' bytes from one source device
or file \f(CW`src\*(C' to another destination device or file \f(CW\*(C\`dest\*(C'.

Note this will fail if the source is too short or if the destination
is not large enough.

_This function is deprecated._
In new code, use the copy-device-to-device\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="cp"></a>

### cp

.IX Subsection "cp"
.Vb 1
 cp src dest
.Ve

This copies a file from \f(CW`src\*(C' to \f(CW\*(C\`dest\*(C' where \f(CW\*(C\`dest\*(C' is
either a destination filename or destination directory.

<a name="cp-a"></a>

### cp-a

.IX Subsection "cp-a"
.Vb 1
 cp-a src dest
.Ve

This copies a file or directory from \f(CW`src\*(C' to \f(CW\*(C\`dest\*(C'
recursively using the \f(CW`cp -a\*(C' command.

<a name="cp-r"></a>

### cp-r

.IX Subsection "cp-r"
.Vb 1
 cp-r src dest
.Ve

This copies a file or directory from \f(CW`src\*(C' to \f(CW\*(C\`dest\*(C'
recursively using the \f(CW`cp -rP\*(C' command.

Most users should use cp-a\*(R" instead.  This command
is useful when you don't want to preserve permissions, because
the target filesystem does not support it (primarily when
writing to \s-1DOS FAT\s0 filesystems).

<a name="cpio-out"></a>

### cpio-out

.IX Subsection "cpio-out"
.Vb 1
 cpio-out directory (cpiofile|-) [format:..]
.Ve

This command packs the contents of _directory_ and downloads
it to local file \f(CW`cpiofile\*(C'.

The optional \f(CW`format\*(C' parameter can be used to select the format.
Only the following formats are currently permitted:
.ie n .IP """newc""" 4
.el .IP "\f(CWnewc" 4
.IX Item "newc"
New (\s-1SVR4\s0) portable format.  This format happens to be compatible
with the cpio-like format used by the Linux kernel for initramfs.
.Sp
This is the default format.
.ie n .IP """crc""" 4
.el .IP "\f(CWcrc" 4
.IX Item "crc"
New (\s-1SVR4\s0) portable format with a checksum.

Use \f(CW`-\*(C' instead of a filename to read/write from stdin/stdout.

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

<a name="dd"></a>

### dd

.IX Subsection "dd"
.Vb 1
 dd src dest
.Ve

This command copies from one source device or file \f(CW`src\*(C'
to another destination device or file \f(CW`dest\*(C'.  Normally you
would use this to copy to or from a device or partition, for
example to duplicate a filesystem.

If the destination is a device, it must be as large or larger
than the source file or device, otherwise the copy will fail.
This command cannot do partial copies
(see copy-device-to-device\*(R").

_This function is deprecated._
In new code, use the copy-device-to-device\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="device-index"></a>

### device-index

.IX Subsection "device-index"
.Vb 1
 device-index device
.Ve

This function takes a device name (eg. /dev/sdb\*(R") and
returns the index of the device in the list of devices.

Index numbers start from 0.  The named device must exist,
for example as a string returned from list-devices\*(R".

See also list-devices\*(R", \*(L"part-to-dev\*(R".

<a name="df"></a>

### df

.IX Subsection "df"
.Vb 1
 df
.Ve

This command runs the \f(CW`df\*(C' command to report disk space used.

This command is mostly useful for interactive sessions.  It
is _not_ intended that you try to parse the output string.
Use statvfs\*(R" from programs.

<a name="df-h"></a>

### df-h

.IX Subsection "df-h"
.Vb 1
 df-h
.Ve

This command runs the \f(CW`df -h\*(C' command to report disk space used
in human-readable format.

This command is mostly useful for interactive sessions.  It
is _not_ intended that you try to parse the output string.
Use statvfs\*(R" from programs.

<a name="disk-create"></a>

### disk-create

.IX Subsection "disk-create"
.Vb 1
 disk-create filename format size [backingfile:..] [backingformat:..] [preallocation:..] [compat:..] [clustersize:N]
.Ve

Create a blank disk image called _filename_ (a host file)
with format \f(CW`format\*(C' (usually \f(CW\*(C\`raw\*(C' or \f(CW\*(C\`qcow2\*(C').
The size is \f(CW`size\*(C' bytes.

If used with the optional \f(CW`backingfile\*(C' parameter, then a snapshot
is created on top of the backing file.  In this case, \f(CW`size\*(C' must
be passed as \f(CW`-1\*(C'.  The size of the snapshot is the same as the
size of the backing file, which is discovered automatically.  You
are encouraged to also pass \f(CW`backingformat\*(C' to describe the format
of \f(CW`backingfile\*(C'.

If _filename_ refers to a block device, then the device is
formatted.  The \f(CW`size\*(C' is ignored since block devices have an
intrinsic size.

The other optional parameters are:
.ie n .IP """preallocation""" 4
.el .IP "\f(CWpreallocation" 4
.IX Item "preallocation"
If format is \f(CW`raw\*(C', then this can be either \f(CW\*(C\`off\*(C' (or \f(CW\*(C\`sparse\*(C')
or \f(CW`full\*(C' to create a sparse or fully allocated file respectively.
The default is \f(CW`off\*(C'.
.Sp
If format is \f(CW`qcow2\*(C', then this can be \f(CW\*(C\`off\*(C' (or \f(CW\*(C\`sparse\*(C'),
\f(CW`metadata\*(C' or \f(CW\*(C\`full\*(C'.  Preallocating metadata can be faster
when doing lots of writes, but uses more space.
The default is \f(CW`off\*(C'.
.ie n .IP """compat""" 4
.el .IP "\f(CWcompat" 4
.IX Item "compat"
\f(CW`qcow2\*(C' only:
Pass the string \f(CW1.1 to use the advanced qcow2 format supported
by qemu ≥ 1.1.
.ie n .IP """clustersize""" 4
.el .IP "\f(CWclustersize" 4
.IX Item "clustersize"
\f(CW`qcow2\*(C' only:
Change the qcow2 cluster size.  The default is 65536 (bytes) and
this setting may be any power of two between 512 and 2097152.

Note that this call does not add the new disk to the handle.  You
may need to call add-drive-opts\*(R" separately.

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

<a name="disk-format"></a>

### disk-format

.IX Subsection "disk-format"
.Vb 1
 disk-format filename
.Ve

Detect and return the format of the disk image called _filename_.
_filename_ can also be a host device, etc.  If the format of the
image could not be detected, then \f(CW"unknown" is returned.

Note that detecting the disk format can be insecure under some
circumstances.  See \s-1CVE-2010-3851\*(R"\s0 in **guestfs**\|(3).

See also: \s-1DISK IMAGE FORMATS\*(R"\s0 in **guestfs**\|(3)

<a name="disk-has-backing-file"></a>

### disk-has-backing-file

.IX Subsection "disk-has-backing-file"
.Vb 1
 disk-has-backing-file filename
.Ve

Detect and return whether the disk image _filename_ has a
backing file.

Note that detecting disk features can be insecure under some
circumstances.  See \s-1CVE-2010-3851\*(R"\s0 in **guestfs**\|(3).

<a name="disk-virtual-size"></a>

### disk-virtual-size

.IX Subsection "disk-virtual-size"
.Vb 1
 disk-virtual-size filename
.Ve

Detect and return the virtual size in bytes of the disk image
called _filename_.

Note that detecting disk features can be insecure under some
circumstances.  See \s-1CVE-2010-3851\*(R"\s0 in **guestfs**\|(3).

<a name="dmesg"></a>

### dmesg

.IX Subsection "dmesg"
.Vb 1
 dmesg
.Ve

This returns the kernel messages (\f(CW`dmesg\*(C' output) from
the guest kernel.  This is sometimes useful for extended
debugging of problems.

Another way to get the same information is to enable
verbose messages with set-verbose\*(R" or by setting
the environment variable \f(CW`LIBGUESTFS\_DEBUG=1\*(C' before
running the program.

<a name="download"></a>

### download

.IX Subsection "download"
.Vb 1
 download remotefilename (filename|-)
.Ve

Download file _remotefilename_ and save it as _filename_
on the local machine.

_filename_ can also be a named pipe.

See also upload\*(R", \*(L"cat\*(R".

Use \f(CW`-\*(C' instead of a filename to read/write from stdin/stdout.

<a name="download-blocks"></a>

### download-blocks

.IX Subsection "download-blocks"
.Vb 1
 download-blocks device start stop (filename|-) [unallocated:true|false]
.Ve

Download the data units from _start_ address
to _stop_ from the disk partition (eg. _/dev/sda1_)
and save them as _filename_ on the local machine.

The use of this \s-1API\s0 on sparse disk image formats such as \s-1QCOW,\s0
may result in large zero-filled files downloaded on the host.

The size of a data unit varies across filesystem implementations.
On \s-1NTFS\s0 filesystems data units are referred as clusters
while on ExtX ones they are referred as fragments.

If the optional \f(CW`unallocated\*(C' flag is true (default is false),
only the unallocated blocks will be extracted.
This is useful to detect hidden data or to retrieve deleted files
which data units have not been overwritten yet.

Use \f(CW`-\*(C' instead of a filename to read/write from stdin/stdout.

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

This command depends on the feature \f(CW`sleuthkit\*(C'.   See also
feature-available\*(R".

<a name="download-inode"></a>

### download-inode

.IX Subsection "download-inode"
.Vb 1
 download-inode device inode (filename|-)
.Ve

Download a file given its inode from the disk partition
(eg. _/dev/sda1_) and save it as _filename_ on the local machine.

It is not required to mount the disk to run this command.

The command is capable of downloading deleted or inaccessible files.

Use \f(CW`-\*(C' instead of a filename to read/write from stdin/stdout.

This command depends on the feature \f(CW`sleuthkit\*(C'.   See also
feature-available\*(R".

<a name="download-offset"></a>

### download-offset

.IX Subsection "download-offset"
.Vb 1
 download-offset remotefilename (filename|-) offset size
.Ve

Download file _remotefilename_ and save it as _filename_
on the local machine.

_remotefilename_ is read for \f(CW`size\*(C' bytes starting at \f(CW\*(C\`offset\*(C'
(this region must be within the file or device).

Note that there is no limit on the amount of data that
can be downloaded with this call, unlike with pread\*(R",
and this call always reads the full amount unless an
error occurs.

See also download\*(R", \*(L"pread\*(R".

Use \f(CW`-\*(C' instead of a filename to read/write from stdin/stdout.

<a name="drop-caches"></a>

### drop-caches

.IX Subsection "drop-caches"
.Vb 1
 drop-caches whattodrop
.Ve

This instructs the guest kernel to drop its page cache,
and/or dentries and inode caches.  The parameter \f(CW`whattodrop\*(C'
tells the kernel what precisely to drop, see
http://linux-mm.org/Drop_Caches

Setting \f(CW`whattodrop\*(C' to 3 should drop everything.

This automatically calls **sync**\|(2) before the operation,
so that the maximum guest memory is freed.

<a name="du"></a>

### du

.IX Subsection "du"
.Vb 1
 du path
.Ve

This command runs the \f(CW`du -s\*(C' command to estimate file space
usage for \f(CW`path\*(C'.

\f(CW`path\*(C' can be a file or a directory.  If \f(CW\*(C\`path\*(C' is a directory
then the estimate includes the contents of the directory and all
subdirectories (recursively).

The result is the estimated size in _kilobytes_
(ie. units of 1024 bytes).

<a name="e2fsck"></a>

### e2fsck

.IX Subsection "e2fsck"
.Vb 1
 e2fsck device [correct:true|false] [forceall:true|false]
.Ve

This runs the ext2/ext3 filesystem checker on \f(CW`device\*(C'.
It can take the following optional arguments:
.ie n .IP """correct""" 4
.el .IP "\f(CWcorrect" 4
.IX Item "correct"
Automatically repair the file system. This option will cause e2fsck
to automatically fix any filesystem problems that can be safely
fixed without human intervention.
.Sp
This option may not be specified at the same time as the \f(CW`forceall\*(C' option.
.ie n .IP """forceall""" 4
.el .IP "\f(CWforceall" 4
.IX Item "forceall"
Assume an answer of ‘yes’ to all questions; allows e2fsck to be used
non-interactively.
.Sp
This option may not be specified at the same time as the \f(CW`correct\*(C' option.

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

<a name="e2fsck-f"></a>

### e2fsck\-f

.IX Subsection "e2fsck-f"
.Vb 1
 e2fsck-f device
.Ve

This runs \f(CW`e2fsck -p -f device\*(C', ie. runs the ext2/ext3
filesystem checker on \f(CW`device\*(C', noninteractively (_-p_),
even if the filesystem appears to be clean (_-f_).

_This function is deprecated._
In new code, use the e2fsck\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="echo-daemon"></a>

### echo-daemon

.IX Subsection "echo-daemon"
.Vb 1
 echo-daemon words ...\*(Aq
.Ve

This command concatenates the list of \f(CW`words\*(C' passed with single spaces
between them and returns the resulting string.

You can use this command to test the connection through to the daemon.

See also ping-daemon\*(R".

<a name="egrep"></a>

### egrep

.IX Subsection "egrep"
.Vb 1
 egrep regex path
.Ve

This calls the external \f(CW`egrep\*(C' program and returns the
matching lines.

Because of the message protocol, there is a transfer limit
of somewhere between 2MB and 4MB.  See \s-1PROTOCOL LIMITS\*(R"\s0 in **guestfs**\|(3).

_This function is deprecated._
In new code, use the grep\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="egrepi"></a>

### egrepi

.IX Subsection "egrepi"
.Vb 1
 egrepi regex path
.Ve

This calls the external \f(CW`egrep -i\*(C' program and returns the
matching lines.

Because of the message protocol, there is a transfer limit
of somewhere between 2MB and 4MB.  See \s-1PROTOCOL LIMITS\*(R"\s0 in **guestfs**\|(3).

_This function is deprecated._
In new code, use the grep\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="equal"></a>

### equal

.IX Subsection "equal"
.Vb 1
 equal file1 file2
.Ve

This compares the two files _file1_ and _file2_ and returns
true if their content is exactly equal, or false otherwise.

The external **cmp**\|(1) program is used for the comparison.

<a name="exists"></a>

### exists

.IX Subsection "exists"
.Vb 1
 exists path
.Ve

This returns \f(CW`true\*(C' if and only if there is a file, directory
(or anything) with the given \f(CW`path\*(C' name.

See also is-file\*(R", \*(L"is-dir\*(R", \*(L"stat\*(R".

<a name="extlinux"></a>

### extlinux

.IX Subsection "extlinux"
.Vb 1
 extlinux directory
.Ve

Install the \s-1SYSLINUX\s0 bootloader on the device mounted at _directory_.
Unlike syslinux\*(R" which requires a \s-1FAT\s0 filesystem, this can
be used on an ext2/3/4 or btrfs filesystem.

The _directory_ parameter can be either a mountpoint, or a
directory within the mountpoint.

You also have to mark the partition as active\*(R"
(part-set-bootable\*(R") and a Master Boot Record must
be installed (eg. using pwrite-device\*(R") on the first
sector of the whole disk.
The \s-1SYSLINUX\s0 package comes with some suitable Master Boot Records.
See the **extlinux**\|(1) man page for further information.

Additional configuration can be supplied to \s-1SYSLINUX\s0 by
placing a file called _extlinux.conf_ on the filesystem
under _directory_.  For further information
about the contents of this file, see **extlinux**\|(1).

See also syslinux\*(R".

This command depends on the feature \f(CW`extlinux\*(C'.   See also
feature-available\*(R".

<a name="f2fs-expand"></a>

### f2fs\-expand

.IX Subsection "f2fs-expand"
.Vb 1
 f2fs-expand device
.Ve

This expands a f2fs filesystem to match the size of the underlying
device.

This command depends on the feature \f(CW`f2fs\*(C'.   See also
feature-available\*(R".

<a name="fallocate"></a>

### fallocate

.IX Subsection "fallocate"
.Vb 1
 fallocate path len
.Ve

This command preallocates a file (containing zero bytes) named
\f(CW`path\*(C' of size \f(CW\*(C\`len\*(C' bytes.  If the file exists already, it
is overwritten.

Do not confuse this with the guestfish-specific
\f(CW`alloc\*(C' command which allocates a file in the host and
attaches it as a device.

_This function is deprecated._
In new code, use the fallocate64\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="fallocate64"></a>

### fallocate64

.IX Subsection "fallocate64"
.Vb 1
 fallocate64 path len
.Ve

This command preallocates a file (containing zero bytes) named
\f(CW`path\*(C' of size \f(CW\*(C\`len\*(C' bytes.  If the file exists already, it
is overwritten.

Note that this call allocates disk blocks for the file.
To create a sparse file use truncate-size\*(R" instead.

The deprecated call fallocate\*(R" does the same,
but owing to an oversight it only allowed 30 bit lengths
to be specified, effectively limiting the maximum size
of files created through that call to 1GB.

Do not confuse this with the guestfish-specific
\f(CW`alloc\*(C' and \f(CW\*(C\`sparse\*(C' commands which create
a file in the host and attach it as a device.

<a name="feature-available"></a>

### feature-available

.IX Subsection "feature-available"
.Vb 1
 feature-available groups ...\*(Aq
.Ve

This is the same as available\*(R", but unlike that
call it returns a simple true/false boolean result, instead
of throwing an exception if a feature is not found.  For
other documentation see available\*(R".

<a name="fgrep"></a>

### fgrep

.IX Subsection "fgrep"
.Vb 1
 fgrep pattern path
.Ve

This calls the external \f(CW`fgrep\*(C' program and returns the
matching lines.

Because of the message protocol, there is a transfer limit
of somewhere between 2MB and 4MB.  See \s-1PROTOCOL LIMITS\*(R"\s0 in **guestfs**\|(3).

_This function is deprecated._
In new code, use the grep\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="fgrepi"></a>

### fgrepi

.IX Subsection "fgrepi"
.Vb 1
 fgrepi pattern path
.Ve

This calls the external \f(CW`fgrep -i\*(C' program and returns the
matching lines.

Because of the message protocol, there is a transfer limit
of somewhere between 2MB and 4MB.  See \s-1PROTOCOL LIMITS\*(R"\s0 in **guestfs**\|(3).

_This function is deprecated._
In new code, use the grep\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="file"></a>

### file

.IX Subsection "file"
.Vb 1
 file path
.Ve

This call uses the standard **file**\|(1) command to determine
the type or contents of the file.

This call will also transparently look inside various types
of compressed file.

The exact command which runs is \f(CW`file -zb path\*(C'.  Note in
particular that the filename is not prepended to the output
(the _-b_ option).

The output depends on the output of the underlying **file**\|(1)
command and it can change in future in ways beyond our control.
In other words, the output is not guaranteed by the \s-1ABI.\s0

See also: **file**\|(1), vfs-type\*(R", \*(L"lstat\*(R",
is-file\*(R", \*(L"is-blockdev\*(R" (etc), \*(L"is-zero\*(R".

<a name="file-architecture"></a>

### file-architecture

.IX Subsection "file-architecture"
.Vb 1
 file-architecture filename
.Ve

This detects the architecture of the binary _filename_,
and returns it if known.

Currently defined architectures are:
.ie n .IP """aarch64""" 4
.el .IP "\`\`aarch64''" 4
.IX Item "aarch64"
64 bit \s-1ARM.\s0
.ie n .IP """arm""" 4
.el .IP "\`\`arm''" 4
.IX Item "arm"
32 bit \s-1ARM.\s0
.ie n .IP """i386""" 4
.el .IP "\`\`i386''" 4
.IX Item "i386"
This string is returned for all 32 bit i386, i486, i586, i686 binaries
irrespective of the precise processor requirements of the binary.
.ie n .IP """ia64""" 4
.el .IP "\`\`ia64''" 4
.IX Item "ia64"
Intel Itanium.
.ie n .IP """ppc""" 4
.el .IP "\`\`ppc''" 4
.IX Item "ppc"
32 bit Power \s-1PC.\s0
.ie n .IP """ppc64""" 4
.el .IP "\`\`ppc64''" 4
.IX Item "ppc64"
64 bit Power \s-1PC\s0 (big endian).
.ie n .IP """ppc64le""" 4
.el .IP "\`\`ppc64le''" 4
.IX Item "ppc64le"
64 bit Power \s-1PC\s0 (little endian).
.ie n .IP """riscv32""" 4
.el .IP "\`\`riscv32''" 4
.IX Item "riscv32"
.ie n .IP """riscv64""" 4
.el .IP "\`\`riscv64''" 4
.IX Item "riscv64"
.ie n .IP """riscv128""" 4
.el .IP "\`\`riscv128''" 4
.IX Item "riscv128"
RISC-V 32-, 64- or 128-bit variants.
.ie n .IP """s390""" 4
.el .IP "\`\`s390''" 4
.IX Item "s390"
31 bit \s-1IBM S/390.\s0
.ie n .IP """s390x""" 4
.el .IP "\`\`s390x''" 4
.IX Item "s390x"
64 bit \s-1IBM S/390.\s0
.ie n .IP """sparc""" 4
.el .IP "\`\`sparc''" 4
.IX Item "sparc"
32 bit \s-1SPARC.\s0
.ie n .IP """sparc64""" 4
.el .IP "\`\`sparc64''" 4
.IX Item "sparc64"
64 bit \s-1SPARC V9\s0 and above.
.ie n .IP """x86_64""" 4
.el .IP "\`\`x86_64''" 4
.IX Item "x86_64"
64 bit x86-64.

Libguestfs may return other architecture strings in future.

The function works on at least the following types of files:

* ·  
  many types of Un*x and Linux binary
* ·  
  many types of Un*x and Linux shared library
* ·  
  Windows Win32 and Win64 binaries
* ·  
  Windows Win32 and Win64 DLLs
  .Sp
  Win32 binaries and DLLs return \f(CW`i386\*(C'.
  .Sp
  Win64 binaries and DLLs return \f(CW`x86\_64\*(C'.
* ·  
  Linux kernel modules
* ·  
  Linux new-style initrd images
* ·  
  some non-x86 Linux vmlinuz kernels

What it can't do currently:

* ·  
  static libraries (libfoo.a)
* ·  
  Linux old-style initrd as compressed ext2 filesystem (\s-1RHEL 3\s0)
* ·  
  x86 Linux vmlinuz kernels
  .Sp
  x86 vmlinuz images (bzImage format) consist of a mix of 16-, 32- and
  compressed code, and are horribly hard to unpack.  If you want to find
  the architecture of a kernel, use the architecture of the associated
  initrd or kernel module(s) instead.

<a name="filesize"></a>

### filesize

.IX Subsection "filesize"
.Vb 1
 filesize file
.Ve

This command returns the size of _file_ in bytes.

To get other stats about a file, use stat\*(R", \*(L"lstat\*(R",
is-dir\*(R", \*(L"is-file\*(R" etc.
To get the size of block devices, use blockdev-getsize64\*(R".

<a name="filesystem-available"></a>

### filesystem-available

.IX Subsection "filesystem-available"
.Vb 1
 filesystem-available filesystem
.Ve

Check whether libguestfs supports the named filesystem.
The argument \f(CW`filesystem\*(C' is a filesystem name, such as
\f(CW`ext3\*(C'.

You must call launch\*(R" before using this command.

This is mainly useful as a negative test.  If this returns true,
it doesn't mean that a particular filesystem can be created
or mounted, since filesystems can fail for other reasons
such as it being a later version of the filesystem,
or having incompatible features, or lacking the right
mkfs.&lt;_fs_&gt; tool.

See also available\*(R", \*(L"feature-available\*(R",
\s-1AVAILABILITY\*(R"\s0 in **guestfs**\|(3).

<a name="filesystem-walk"></a>

### filesystem-walk

.IX Subsection "filesystem-walk"
.Vb 1
 filesystem-walk device
.Ve

Walk through the internal structures of a disk partition
(eg. _/dev/sda1_) in order to return a list of all the files
and directories stored within.

It is not necessary to mount the disk partition to run this command.

All entries in the filesystem are returned. This function can list deleted
or unaccessible files. The entries are _not_ sorted.

The \f(CW`tsk\_dirent\*(C' structure contains the following fields.
.ie n .IP """tsk_inode""" 4
.el .IP "\f(CWtsk\_inode" 4
.IX Item "tsk_inode"
Filesystem reference number of the node. It might be \f(CW0
if the node has been deleted.
.ie n .IP """tsk_type""" 4
.el .IP "\f(CWtsk\_type" 4
.IX Item "tsk_type"
Basic file type information.
See below for a detailed list of values.
.ie n .IP """tsk_size""" 4
.el .IP "\f(CWtsk\_size" 4
.IX Item "tsk_size"
File size in bytes. It might be \f(CW`-1\*(C'
if the node has been deleted.
.ie n .IP """tsk_name""" 4
.el .IP "\f(CWtsk\_name" 4
.IX Item "tsk_name"
The file path relative to its directory.
.ie n .IP """tsk_flags""" 4
.el .IP "\f(CWtsk\_flags" 4
.IX Item "tsk_flags"
Bitfield containing extra information regarding the entry.
It contains the logical \s-1OR\s0 of the following values:

* 0x0001  
  .IX Item "0x0001"
  If set to \f(CW1, the file is allocated and visible within the filesystem.
  Otherwise, the file has been deleted.
  Under certain circumstances, the function \f(CW`download\_inode\*(C'
  can be used to recover deleted files.
* 0x0002  
  .IX Item "0x0002"
  Filesystem such as \s-1NTFS\s0 and Ext2 or greater, separate the file name
  from the metadata structure.
  The bit is set to \f(CW1 when the file name is in an unallocated state
  and the metadata structure is in an allocated one.
  This generally implies the metadata has been reallocated to a new file.
  Therefore, information such as file type, file size, timestamps,
  number of links and symlink target might not correspond
  with the ones of the original deleted entry.
* 0x0004  
  .IX Item "0x0004"
  The bit is set to \f(CW1 when the file is compressed using filesystem
  native compression support (\s-1NTFS\s0). The \s-1API\s0 is not able to detect
  application level compression.
.ie n .IP """tsk_atime_sec""" 4
.el .IP "\f(CWtsk\_atime\_sec" 4
.IX Item "tsk_atime_sec"
.ie n .IP """tsk_atime_nsec""" 4
.el .IP "\f(CWtsk\_atime\_nsec" 4
.IX Item "tsk_atime_nsec"
.ie n .IP """tsk_mtime_sec""" 4
.el .IP "\f(CWtsk\_mtime\_sec" 4
.IX Item "tsk_mtime_sec"
.ie n .IP """tsk_mtime_nsec""" 4
.el .IP "\f(CWtsk\_mtime\_nsec" 4
.IX Item "tsk_mtime_nsec"
.ie n .IP """tsk_ctime_sec""" 4
.el .IP "\f(CWtsk\_ctime\_sec" 4
.IX Item "tsk_ctime_sec"
.ie n .IP """tsk_ctime_nsec""" 4
.el .IP "\f(CWtsk\_ctime\_nsec" 4
.IX Item "tsk_ctime_nsec"
.ie n .IP """tsk_crtime_sec""" 4
.el .IP "\f(CWtsk\_crtime\_sec" 4
.IX Item "tsk_crtime_sec"
.ie n .IP """tsk_crtime_nsec""" 4
.el .IP "\f(CWtsk\_crtime\_nsec" 4
.IX Item "tsk_crtime_nsec"
Respectively, access, modification, last status change and creation
time in Unix format in seconds and nanoseconds.
.ie n .IP """tsk_nlink""" 4
.el .IP "\f(CWtsk\_nlink" 4
.IX Item "tsk_nlink"
Number of file names pointing to this entry.
.ie n .IP """tsk_link""" 4
.el .IP "\f(CWtsk\_link" 4
.IX Item "tsk_link"
If the entry is a symbolic link, this field will contain the path
to the target file.

The \f(CW`tsk\_type\*(C' field will contain one of the following characters:

* 'b'  
  .IX Item "'b'"
  Block special
* 'c'  
  .IX Item "'c'"
  Char special
* 'd'  
  .IX Item "'d'"
  Directory
* 'f'  
  .IX Item "'f'"
  \s-1FIFO\s0 (named pipe)
* 'l'  
  .IX Item "'l'"
  Symbolic link
* 'r'  
  .IX Item "'r'"
  Regular file
* 's'  
  .IX Item "'s'"
  Socket
* 'h'  
  .IX Item "'h'"
  Shadow inode (Solaris)
* 'w'  
  .IX Item "'w'"
  Whiteout inode (\s-1BSD\s0)
* 'u'  
  .IX Item "'u'"
  Unknown file type

This command depends on the feature \f(CW`libtsk\*(C'.   See also
feature-available\*(R".

<a name="fill"></a>

### fill

.IX Subsection "fill"
.Vb 1
 fill c len path
.Ve

This command creates a new file called \f(CW`path\*(C'.  The initial
content of the file is \f(CW`len\*(C' octets of \f(CW\*(C\`c\*(C', where \f(CW\*(C\`c\*(C'
must be a number in the range \f(CW`[0..255]\*(C'.

To fill a file with zero bytes (sparsely), it is
much more efficient to use truncate-size\*(R".
To create a file with a pattern of repeating bytes
use fill-pattern\*(R".

<a name="fill-dir"></a>

### fill-dir

.IX Subsection "fill-dir"
.Vb 1
 fill-dir dir nr
.Ve

This function, useful for testing filesystems, creates \f(CW`nr\*(C'
empty files in the directory \f(CW`dir\*(C' with names \f(CW00000000
through \f(CW`nr-1\*(C' (ie. each file name is 8 digits long padded
with zeroes).

<a name="fill-pattern"></a>

### fill-pattern

.IX Subsection "fill-pattern"
.Vb 1
 fill-pattern pattern len path
.Ve

This function is like fill\*(R" except that it creates
a new file of length \f(CW`len\*(C' containing the repeating pattern
of bytes in \f(CW`pattern\*(C'.  The pattern is truncated if necessary
to ensure the length of the file is exactly \f(CW`len\*(C' bytes.

<a name="find"></a>

### find

.IX Subsection "find"
.Vb 1
 find directory
.Ve

This command lists out all files and directories, recursively,
starting at _directory_.  It is essentially equivalent to
running the shell command \f(CW`find directory -print\*(C' but some
post-processing happens on the output, described below.

This returns a list of strings _without any prefix_.  Thus
if the directory structure was:

.Vb 3
 /tmp/a
 /tmp/b
 /tmp/c/d
.Ve

then the returned list from find\*(R" _/tmp_ would be
4 elements:

.Vb 4
 a
 b
 c
 c/d
.Ve

If _directory_ is not a directory, then this command returns
an error.

The returned list is sorted.

<a name="find0"></a>

### find0

.IX Subsection "find0"
.Vb 1
 find0 directory (files|-)
.Ve

This command lists out all files and directories, recursively,
starting at _directory_, placing the resulting list in the
external file called _files_.

This command works the same way as find\*(R" with the
following exceptions:

* ·  
  The resulting list is written to an external file.
* ·  
  Items (filenames) in the result are separated
  by \f(CW`\e0\*(C' characters.  See **find**\|(1) option _-print0_.
* ·  
  The result list is not sorted.

Use \f(CW`-\*(C' instead of a filename to read/write from stdin/stdout.

<a name="find-inode"></a>

### find-inode

.IX Subsection "find-inode"
.Vb 1
 find-inode device inode
.Ve

Searches all the entries associated with the given inode.

For each entry, a \f(CW`tsk\_dirent\*(C' structure is returned.
See \f(CW`filesystem\_walk\*(C' for more information about \f(CW\*(C\`tsk\_dirent\*(C' structures.

This command depends on the feature \f(CW`libtsk\*(C'.   See also
feature-available\*(R".

<a name="findfs-label"></a>

### findfs-label

.IX Subsection "findfs-label"
.Vb 1
 findfs-label label
.Ve

This command searches the filesystems and returns the one
which has the given label.  An error is returned if no such
filesystem can be found.

To find the label of a filesystem, use vfs-label\*(R".

<a name="findfs-uuid"></a>

### findfs-uuid

.IX Subsection "findfs-uuid"
.Vb 1
 findfs-uuid uuid
.Ve

This command searches the filesystems and returns the one
which has the given \s-1UUID.\s0  An error is returned if no such
filesystem can be found.

To find the \s-1UUID\s0 of a filesystem, use vfs-uuid\*(R".

<a name="fsck"></a>

### fsck

.IX Subsection "fsck"
.Vb 1
 fsck fstype device
.Ve

This runs the filesystem checker (fsck) on \f(CW`device\*(C' which
should have filesystem type \f(CW`fstype\*(C'.

The returned integer is the status.  See **fsck**\|(8) for the
list of status codes from \f(CW`fsck\*(C'.

Notes:

* ·  
  Multiple status codes can be summed together.
* ·  
  A non-zero return code can mean success\*(R", for example if
  errors have been corrected on the filesystem.
* ·  
  Checking or repairing \s-1NTFS\s0 volumes is not supported
  (by linux-ntfs).

This command is entirely equivalent to running \f(CW`fsck -a -t fstype device\*(C'.

<a name="fstrim"></a>

### fstrim

.IX Subsection "fstrim"
.Vb 1
 fstrim mountpoint [offset:N] [length:N] [minimumfreeextent:N]
.Ve

Trim the free space in the filesystem mounted on \f(CW`mountpoint\*(C'.
The filesystem must be mounted read-write.

The filesystem contents are not affected, but any free space
in the filesystem is trimmed\*(R", that is, given back to the host
device, thus making disk images more sparse, allowing unused space
in qcow2 files to be reused, etc.

This operation requires support in libguestfs, the mounted
filesystem, the host filesystem, qemu and the host kernel.
If this support isn't present it may give an error or even
appear to run but do nothing.

In the case where the kernel vfs driver does not support
trimming, this call will fail with errno set to \f(CW`ENOTSUP\*(C'.
Currently this happens when trying to trim \s-1FAT\s0 filesystems.

See also zero-free-space\*(R".  That is a slightly
different operation that turns free space in the filesystem
into zeroes.  It is valid to call fstrim\*(R" either
instead of, or after calling zero-free-space\*(R".

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

This command depends on the feature \f(CW`fstrim\*(C'.   See also
feature-available\*(R".

<a name="get-append"></a>

### get-append

.IX Subsection "get-append"
.Vb 1
 get-append
.Ve

Return the additional kernel options which are added to the
libguestfs appliance kernel command line.

If \f(CW`NULL\*(C' then no options are added.

<a name="get-attach-method"></a>

### get-attach-method

.IX Subsection "get-attach-method"
.Vb 1
 get-attach-method
.Ve

Return the current backend.

See set-backend\*(R" and \*(L"\s-1BACKEND\*(R"\s0 in **guestfs**\|(3).

_This function is deprecated._
In new code, use the get-backend\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="get-autosync"></a>

### get-autosync

.IX Subsection "get-autosync"
.Vb 1
 get-autosync
.Ve

Get the autosync flag.

<a name="get-backend"></a>

### get-backend

.IX Subsection "get-backend"
.Vb 1
 get-backend
.Ve

Return the current backend.

This handle property was previously called the attach method\*(R".

See set-backend\*(R" and \*(L"\s-1BACKEND\*(R"\s0 in **guestfs**\|(3).

<a name="get-backend-setting"></a>

### get-backend-setting

.IX Subsection "get-backend-setting"
.Vb 1
 get-backend-setting name
.Ve

Find a backend setting string which is either \f(CW"name" or
begins with \f(CW"name=".  If \f(CW"name", this returns the
string \f(CW"1".  If \f(CW"name=", this returns the part
after the equals sign (which may be an empty string).

If no such setting is found, this function throws an error.
The errno (see last-errno\*(R") will be \f(CW\*(C\`ESRCH\*(C' in this
case.

See \s-1BACKEND\*(R"\s0 in **guestfs**\|(3), \*(L"\s-1BACKEND SETTINGS\*(R"\s0 in **guestfs**\|(3).

<a name="get-backend-settings"></a>

### get-backend-settings

.IX Subsection "get-backend-settings"
.Vb 1
 get-backend-settings
.Ve

Return the current backend settings.

This call returns all backend settings strings.  If you want to
find a single backend setting, see get-backend-setting\*(R".

See \s-1BACKEND\*(R"\s0 in **guestfs**\|(3), \*(L"\s-1BACKEND SETTINGS\*(R"\s0 in **guestfs**\|(3).

<a name="get-cachedir"></a>

### get-cachedir

.IX Subsection "get-cachedir"
.Vb 1
 get-cachedir
.Ve

Get the directory used by the handle to store the appliance cache.

<a name="get-direct"></a>

### get-direct

.IX Subsection "get-direct"
.Vb 1
 get-direct
.Ve

Return the direct appliance mode flag.

_This function is deprecated._
In new code, use the internal-get-console-socket\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="get-e2attrs"></a>

### get\-e2attrs

.IX Subsection "get-e2attrs"
.Vb 1
 get-e2attrs file
.Ve

This returns the file attributes associated with _file_.

The attributes are a set of bits associated with each
inode which affect the behaviour of the file.  The attributes
are returned as a string of letters (described below).  The
string may be empty, indicating that no file attributes are
set for this file.

These attributes are only present when the file is located on
an ext2/3/4 filesystem.  Using this call on other filesystem
types will result in an error.

The characters (file attributes) in the returned string are
currently:

* 'A'  
  .IX Item "'A'"
  When the file is accessed, its atime is not modified.
* 'a'  
  .IX Item "'a'"
  The file is append-only.
* 'c'  
  .IX Item "'c'"
  The file is compressed on-disk.
* 'D'  
  .IX Item "'D'"
  (Directories only.)  Changes to this directory are written
  synchronously to disk.
* 'd'  
  .IX Item "'d'"
  The file is not a candidate for backup (see **dump**\|(8)).
* 'E'  
  .IX Item "'E'"
  The file has compression errors.
* 'e'  
  .IX Item "'e'"
  The file is using extents.
* 'h'  
  .IX Item "'h'"
  The file is storing its blocks in units of the filesystem blocksize
  instead of sectors.
* 'I'  
  .IX Item "'I'"
  (Directories only.)  The directory is using hashed trees.
* 'i'  
  .IX Item "'i'"
  The file is immutable.  It cannot be modified, deleted or renamed.
  No link can be created to this file.
* 'j'  
  .IX Item "'j'"
  The file is data-journaled.
* 's'  
  .IX Item "'s'"
  When the file is deleted, all its blocks will be zeroed.
* 'S'  
  .IX Item "'S'"
  Changes to this file are written synchronously to disk.
* 'T'  
  .IX Item "'T'"
  (Directories only.)  This is a hint to the block allocator
  that subdirectories contained in this directory should be
  spread across blocks.  If not present, the block allocator
  will try to group subdirectories together.
* 't'  
  .IX Item "'t'"
  For a file, this disables tail-merging.
  (Not used by upstream implementations of ext2.)
* 'u'  
  .IX Item "'u'"
  When the file is deleted, its blocks will be saved, allowing
  the file to be undeleted.
* 'X'  
  .IX Item "'X'"
  The raw contents of the compressed file may be accessed.
* 'Z'  
  .IX Item "'Z'"
  The compressed file is dirty.

More file attributes may be added to this list later.  Not all
file attributes may be set for all kinds of files.  For
detailed information, consult the **chattr**\|(1) man page.

See also set-e2attrs\*(R".

Don't confuse these attributes with extended attributes
(see getxattr\*(R").

<a name="get-e2generation"></a>

### get\-e2generation

.IX Subsection "get-e2generation"
.Vb 1
 get-e2generation file
.Ve

This returns the ext2 file generation of a file.  The generation
(which used to be called the version\*(R") is a number associated
with an inode.  This is most commonly used by \s-1NFS\s0 servers.

The generation is only present when the file is located on
an ext2/3/4 filesystem.  Using this call on other filesystem
types will result in an error.

See set-e2generation\*(R".

<a name="get-e2label"></a>

### get\-e2label

.IX Subsection "get-e2label"
.Vb 1
 get-e2label device
.Ve

This returns the ext2/3/4 filesystem label of the filesystem on
\f(CW`device\*(C'.

_This function is deprecated._
In new code, use the vfs-label\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="get-e2uuid"></a>

### get\-e2uuid

.IX Subsection "get-e2uuid"
.Vb 1
 get-e2uuid device
.Ve

This returns the ext2/3/4 filesystem \s-1UUID\s0 of the filesystem on
\f(CW`device\*(C'.

_This function is deprecated._
In new code, use the vfs-uuid\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="get-hv"></a>

### get-hv

.IX Subsection "get-hv"
.Vb 1
 get-hv
.Ve

Return the current hypervisor binary.

This is always non-NULL.  If it wasn't set already, then this will
return the default qemu binary name.

<a name="get-identifier"></a>

### get-identifier

.IX Subsection "get-identifier"
.Vb 1
 get-identifier
.Ve

Get the handle identifier.  See set-identifier\*(R".

<a name="get-libvirt-requested-credential-challenge"></a>

### get-libvirt-requested-credential-challenge

.IX Subsection "get-libvirt-requested-credential-challenge"
.Vb 1
 get-libvirt-requested-credential-challenge index
.Ve

Get the challenge (provided by libvirt) for the \f(CW`index\*(C''th
requested credential.  If libvirt did not provide a challenge,
this returns the empty string \f(CW"".

See \s-1LIBVIRT AUTHENTICATION\*(R"\s0 in **guestfs**\|(3) for documentation and example code.

<a name="get-libvirt-requested-credential-defresult"></a>

### get-libvirt-requested-credential-defresult

.IX Subsection "get-libvirt-requested-credential-defresult"
.Vb 1
 get-libvirt-requested-credential-defresult index
.Ve

Get the default result (provided by libvirt) for the \f(CW`index\*(C''th
requested credential.  If libvirt did not provide a default result,
this returns the empty string \f(CW"".

See \s-1LIBVIRT AUTHENTICATION\*(R"\s0 in **guestfs**\|(3) for documentation and example code.

<a name="get-libvirt-requested-credential-prompt"></a>

### get-libvirt-requested-credential-prompt

.IX Subsection "get-libvirt-requested-credential-prompt"
.Vb 1
 get-libvirt-requested-credential-prompt index
.Ve

Get the prompt (provided by libvirt) for the \f(CW`index\*(C''th
requested credential.  If libvirt did not provide a prompt,
this returns the empty string \f(CW"".

See \s-1LIBVIRT AUTHENTICATION\*(R"\s0 in **guestfs**\|(3) for documentation and example code.

<a name="get-libvirt-requested-credentials"></a>

### get-libvirt-requested-credentials

.IX Subsection "get-libvirt-requested-credentials"
.Vb 1
 get-libvirt-requested-credentials
.Ve

This should only be called during the event callback
for events of type \f(CW`GUESTFS\_EVENT\_LIBVIRT\_AUTH\*(C'.

Return the list of credentials requested by libvirt.  Possible
values are a subset of the strings provided when you called
set-libvirt-supported-credentials\*(R".

See \s-1LIBVIRT AUTHENTICATION\*(R"\s0 in **guestfs**\|(3) for documentation and example code.

<a name="get-memsize"></a>

### get-memsize

.IX Subsection "get-memsize"
.Vb 1
 get-memsize
.Ve

This gets the memory size in megabytes allocated to the
hypervisor.

If set-memsize\*(R" was not called
on this handle, and if \f(CW`LIBGUESTFS\_MEMSIZE\*(C' was not set,
then this returns the compiled-in default value for memsize.

For more information on the architecture of libguestfs,
see **guestfs**\|(3).

<a name="get-network"></a>

### get-network

.IX Subsection "get-network"
.Vb 1
 get-network
.Ve

This returns the enable network flag.

<a name="get-path"></a>

### get-path

.IX Subsection "get-path"
.Vb 1
 get-path
.Ve

Return the current search path.

This is always non-NULL.  If it wasn't set already, then this will
return the default path.

<a name="get-pgroup"></a>

### get-pgroup

.IX Subsection "get-pgroup"
.Vb 1
 get-pgroup
.Ve

This returns the process group flag.

<a name="get-pid"></a>

### get-pid

.IX Subsection "get-pid"

<a name="pid"></a>

### pid

.IX Subsection "pid"
.Vb 1
 get-pid
.Ve

Return the process \s-1ID\s0 of the hypervisor.  If there is no
hypervisor running, then this will return an error.

This is an internal call used for debugging and testing.

<a name="get-program"></a>

### get-program

.IX Subsection "get-program"
.Vb 1
 get-program
.Ve

Get the program name.  See set-program\*(R".

<a name="get-qemu"></a>

### get-qemu

.IX Subsection "get-qemu"
.Vb 1
 get-qemu
.Ve

Return the current hypervisor binary (usually qemu).

This is always non-NULL.  If it wasn't set already, then this will
return the default qemu binary name.

_This function is deprecated._
In new code, use the get-hv\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="get-recovery-proc"></a>

### get-recovery-proc

.IX Subsection "get-recovery-proc"
.Vb 1
 get-recovery-proc
.Ve

Return the recovery process enabled flag.

<a name="get-selinux"></a>

### get-selinux

.IX Subsection "get-selinux"
.Vb 1
 get-selinux
.Ve

This returns the current setting of the selinux flag which
is passed to the appliance at boot time.  See set-selinux\*(R".

For more information on the architecture of libguestfs,
see **guestfs**\|(3).

_This function is deprecated._
In new code, use the selinux-relabel\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="get-smp"></a>

### get-smp

.IX Subsection "get-smp"
.Vb 1
 get-smp
.Ve

This returns the number of virtual CPUs assigned to the appliance.

<a name="get-sockdir"></a>

### get-sockdir

.IX Subsection "get-sockdir"
.Vb 1
 get-sockdir
.Ve

Get the directory used by the handle to store temporary socket files.

This is different from tmpdir\*(R", as we need shorter paths for
sockets (due to the limited buffers of filenames for \s-1UNIX\s0 sockets),
and tmpdir\*(R" may be too long for them.

The environment variable \f(CW`XDG\_RUNTIME\_DIR\*(C' controls the default
value: If \f(CW`XDG\_RUNTIME\_DIR\*(C' is set, then that is the default.
Else _/tmp_ is the default.

<a name="get-tmpdir"></a>

### get-tmpdir

.IX Subsection "get-tmpdir"
.Vb 1
 get-tmpdir
.Ve

Get the directory used by the handle to store temporary files.

<a name="get-trace"></a>

### get-trace

.IX Subsection "get-trace"
.Vb 1
 get-trace
.Ve

Return the command trace flag.

<a name="get-umask"></a>

### get-umask

.IX Subsection "get-umask"
.Vb 1
 get-umask
.Ve

Return the current umask.  By default the umask is \f(CW022
unless it has been set by calling umask\*(R".

<a name="get-verbose"></a>

### get-verbose

.IX Subsection "get-verbose"
.Vb 1
 get-verbose
.Ve

This returns the verbose messages flag.

<a name="getcon"></a>

### getcon

.IX Subsection "getcon"
.Vb 1
 getcon
.Ve

This gets the SELinux security context of the daemon.

See the documentation about \s-1SELINUX\s0 in **guestfs**\|(3),
and setcon\*(R"

_This function is deprecated._
In new code, use the selinux-relabel\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

This command depends on the feature \f(CW`selinux\*(C'.   See also
feature-available\*(R".

<a name="getxattr"></a>

### getxattr

.IX Subsection "getxattr"
.Vb 1
 getxattr path name
.Ve

Get a single extended attribute from file \f(CW`path\*(C' named \f(CW\*(C\`name\*(C'.
This call follows symlinks.  If you want to lookup an extended
attribute for the symlink itself, use lgetxattr\*(R".

Normally it is better to get all extended attributes from a file
in one go by calling getxattrs\*(R".  However some Linux
filesystem implementations are buggy and do not provide a way to
list out attributes.  For these filesystems (notably ntfs-3g)
you have to know the names of the extended attributes you want
in advance and call this function.

Extended attribute values are blobs of binary data.  If there
is no extended attribute named \f(CW`name\*(C', this returns an error.

See also: getxattrs\*(R", \*(L"lgetxattr\*(R", **attr**\|(5).

This command depends on the feature \f(CW`linuxxattrs\*(C'.   See also
feature-available\*(R".

<a name="getxattrs"></a>

### getxattrs

.IX Subsection "getxattrs"
.Vb 1
 getxattrs path
.Ve

This call lists the extended attributes of the file or directory
\f(CW`path\*(C'.

At the system call level, this is a combination of the
**listxattr**\|(2) and **getxattr**\|(2) calls.

See also: lgetxattrs\*(R", **attr**\|(5).

This command depends on the feature \f(CW`linuxxattrs\*(C'.   See also
feature-available\*(R".

<a name="glob-expand"></a>

### glob-expand

.IX Subsection "glob-expand"

<a name="glob-expand-opts"></a>

### glob-expand-opts

.IX Subsection "glob-expand-opts"
.Vb 1
 glob-expand pattern [directoryslash:true|false]
.Ve

This command searches for all the pathnames matching
\f(CW`pattern\*(C' according to the wildcard expansion rules
used by the shell.

If no paths match, then this returns an empty list
(note: not an error).

It is just a wrapper around the C **glob**\|(3) function
with flags \f(CW`GLOB\_MARK|GLOB\_BRACE\*(C'.
See that manual page for more details.

\f(CW`directoryslash\*(C' controls whether use the \f(CW\*(C\`GLOB\_MARK\*(C' flag for
**glob**\|(3), and it defaults to true.  It can be explicitly set as
off to return no trailing slashes in filenames of directories.

Notice that there is no equivalent command for expanding a device
name (eg. _/dev/sd*_).  Use list-devices\*(R",
list-partitions\*(R" etc functions instead.

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

<a name="grep"></a>

### grep

.IX Subsection "grep"

<a name="grep-opts"></a>

### grep-opts

.IX Subsection "grep-opts"
.Vb 1
 grep regex path [extended:true|false] [fixed:true|false] [insensitive:true|false] [compressed:true|false]
.Ve

This calls the external \f(CW`grep\*(C' program and returns the
matching lines.

The optional flags are:
.ie n .IP """extended""" 4
.el .IP "\f(CWextended" 4
.IX Item "extended"
Use extended regular expressions.
This is the same as using the _-E_ flag.
.ie n .IP """fixed""" 4
.el .IP "\f(CWfixed" 4
.IX Item "fixed"
Match fixed (don't use regular expressions).
This is the same as using the _-F_ flag.
.ie n .IP """insensitive""" 4
.el .IP "\f(CWinsensitive" 4
.IX Item "insensitive"
Match case-insensitive.  This is the same as using the _-i_ flag.
.ie n .IP """compressed""" 4
.el .IP "\f(CWcompressed" 4
.IX Item "compressed"
Use \f(CW`zgrep\*(C' instead of \f(CW\*(C\`grep\*(C'.  This allows the input to be
compress- or gzip-compressed.

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

Because of the message protocol, there is a transfer limit
of somewhere between 2MB and 4MB.  See \s-1PROTOCOL LIMITS\*(R"\s0 in **guestfs**\|(3).

<a name="grepi"></a>

### grepi

.IX Subsection "grepi"
.Vb 1
 grepi regex path
.Ve

This calls the external \f(CW`grep -i\*(C' program and returns the
matching lines.

Because of the message protocol, there is a transfer limit
of somewhere between 2MB and 4MB.  See \s-1PROTOCOL LIMITS\*(R"\s0 in **guestfs**\|(3).

_This function is deprecated._
In new code, use the grep\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="grub-install"></a>

### grub-install

.IX Subsection "grub-install"
.Vb 1
 grub-install root device
.Ve

This command installs \s-1GRUB 1\s0 (the Grand Unified Bootloader) on
\f(CW`device\*(C', with the root directory being \f(CW\*(C\`root\*(C'.

Notes:

* ·  
  There is currently no way in the \s-1API\s0 to install grub2, which
  is used by most modern Linux guests.  It is possible to run
  the grub2 command from the guest, although see the
  caveats in \s-1RUNNING COMMANDS\*(R"\s0 in **guestfs**\|(3).
* ·  
  This uses \f(CW`grub-install\*(C' from the host.  Unfortunately grub is
  not always compatible with itself, so this only works in rather
  narrow circumstances.  Careful testing with each guest version
  is advisable.
* ·  
  If grub-install reports the error
  No suitable drive was found in the generated device map.\*(R"
  it may be that you need to create a _/boot/grub/device.map_
  file first that contains the mapping between grub device names
  and Linux device names.  It is usually sufficient to create
  a file containing:
  .Sp
  .Vb 1
   (hd0) /dev/vda
  .Ve
  .Sp
  replacing _/dev/vda_ with the name of the installation device.

This command depends on the feature \f(CW`grub\*(C'.   See also
feature-available\*(R".

<a name="head"></a>

### head

.IX Subsection "head"
.Vb 1
 head path
.Ve

This command returns up to the first 10 lines of a file as
a list of strings.

Because of the message protocol, there is a transfer limit
of somewhere between 2MB and 4MB.  See \s-1PROTOCOL LIMITS\*(R"\s0 in **guestfs**\|(3).

<a name="head-n"></a>

### head-n

.IX Subsection "head-n"
.Vb 1
 head-n nrlines path
.Ve

If the parameter \f(CW`nrlines\*(C' is a positive number, this returns the first
\f(CW`nrlines\*(C' lines of the file \f(CW\*(C\`path\*(C'.

If the parameter \f(CW`nrlines\*(C' is a negative number, this returns lines
from the file \f(CW`path\*(C', excluding the last \f(CW\*(C\`nrlines\*(C' lines.

If the parameter \f(CW`nrlines\*(C' is zero, this returns an empty list.

Because of the message protocol, there is a transfer limit
of somewhere between 2MB and 4MB.  See \s-1PROTOCOL LIMITS\*(R"\s0 in **guestfs**\|(3).

<a name="hexdump"></a>

### hexdump

.IX Subsection "hexdump"
.Vb 1
 hexdump path
.Ve

This runs \f(CW`hexdump -C\*(C' on the given \f(CW\*(C\`path\*(C'.  The result is
the human-readable, canonical hex dump of the file.

Because of the message protocol, there is a transfer limit
of somewhere between 2MB and 4MB.  See \s-1PROTOCOL LIMITS\*(R"\s0 in **guestfs**\|(3).

<a name="hivex-close"></a>

### hivex-close

.IX Subsection "hivex-close"
.Vb 1
 hivex-close
.Ve

Close the current hivex handle.

This is a wrapper around the **hivex**\|(3) call of the same name.

This command depends on the feature \f(CW`hivex\*(C'.   See also
feature-available\*(R".

<a name="hivex-commit"></a>

### hivex-commit

.IX Subsection "hivex-commit"
.Vb 1
 hivex-commit filename
.Ve

Commit (write) changes to the hive.

If the optional _filename_ parameter is null, then the changes
are written back to the same hive that was opened.  If this is
not null then they are written to the alternate filename given
and the original hive is left untouched.

This is a wrapper around the **hivex**\|(3) call of the same name.

This command depends on the feature \f(CW`hivex\*(C'.   See also
feature-available\*(R".

<a name="hivex-node-add-child"></a>

### hivex-node-add-child

.IX Subsection "hivex-node-add-child"
.Vb 1
 hivex-node-add-child parent name
.Ve

Add a child node to \f(CW`parent\*(C' named \f(CW\*(C\`name\*(C'.

This is a wrapper around the **hivex**\|(3) call of the same name.

This command depends on the feature \f(CW`hivex\*(C'.   See also
feature-available\*(R".

<a name="hivex-node-children"></a>

### hivex-node-children

.IX Subsection "hivex-node-children"
.Vb 1
 hivex-node-children nodeh
.Ve

Return the list of nodes which are subkeys of \f(CW`nodeh\*(C'.

This is a wrapper around the **hivex**\|(3) call of the same name.

This command depends on the feature \f(CW`hivex\*(C'.   See also
feature-available\*(R".

<a name="hivex-node-delete-child"></a>

### hivex-node-delete-child

.IX Subsection "hivex-node-delete-child"
.Vb 1
 hivex-node-delete-child nodeh
.Ve

Delete \f(CW`nodeh\*(C', recursively if necessary.

This is a wrapper around the **hivex**\|(3) call of the same name.

This command depends on the feature \f(CW`hivex\*(C'.   See also
feature-available\*(R".

<a name="hivex-node-get-child"></a>

### hivex-node-get-child

.IX Subsection "hivex-node-get-child"
.Vb 1
 hivex-node-get-child nodeh name
.Ve

Return the child of \f(CW`nodeh\*(C' with the name \f(CW\*(C\`name\*(C', if it exists.
This can return \f(CW0 meaning the name was not found.

This is a wrapper around the **hivex**\|(3) call of the same name.

This command depends on the feature \f(CW`hivex\*(C'.   See also
feature-available\*(R".

<a name="hivex-node-get-value"></a>

### hivex-node-get-value

.IX Subsection "hivex-node-get-value"
.Vb 1
 hivex-node-get-value nodeh key
.Ve

Return the value attached to \f(CW`nodeh\*(C' which has the
name \f(CW`key\*(C', if it exists.  This can return \f(CW0 meaning
the key was not found.

This is a wrapper around the **hivex**\|(3) call of the same name.

This command depends on the feature \f(CW`hivex\*(C'.   See also
feature-available\*(R".

<a name="hivex-node-name"></a>

### hivex-node-name

.IX Subsection "hivex-node-name"
.Vb 1
 hivex-node-name nodeh
.Ve

Return the name of \f(CW`nodeh\*(C'.

This is a wrapper around the **hivex**\|(3) call of the same name.

This command depends on the feature \f(CW`hivex\*(C'.   See also
feature-available\*(R".

<a name="hivex-node-parent"></a>

### hivex-node-parent

.IX Subsection "hivex-node-parent"
.Vb 1
 hivex-node-parent nodeh
.Ve

Return the parent node of \f(CW`nodeh\*(C'.

This is a wrapper around the **hivex**\|(3) call of the same name.

This command depends on the feature \f(CW`hivex\*(C'.   See also
feature-available\*(R".

<a name="hivex-node-set-value"></a>

### hivex-node-set-value

.IX Subsection "hivex-node-set-value"
.Vb 1
 hivex-node-set-value nodeh key t val
.Ve

Set or replace a single value under the node \f(CW`nodeh\*(C'.  The
\f(CW`key\*(C' is the name, \f(CW\*(C\`t\*(C' is the type, and \f(CW\*(C\`val\*(C' is the data.

This is a wrapper around the **hivex**\|(3) call of the same name.

This command depends on the feature \f(CW`hivex\*(C'.   See also
feature-available\*(R".

<a name="hivex-node-values"></a>

### hivex-node-values

.IX Subsection "hivex-node-values"
.Vb 1
 hivex-node-values nodeh
.Ve

Return the array of (key, datatype, data) tuples attached to \f(CW`nodeh\*(C'.

This is a wrapper around the **hivex**\|(3) call of the same name.

This command depends on the feature \f(CW`hivex\*(C'.   See also
feature-available\*(R".

<a name="hivex-open"></a>

### hivex-open

.IX Subsection "hivex-open"
.Vb 1
 hivex-open filename [verbose:true|false] [debug:true|false] [write:true|false] [unsafe:true|false]
.Ve

Open the Windows Registry hive file named _filename_.
If there was any previous hivex handle associated with this
guestfs session, then it is closed.

This is a wrapper around the **hivex**\|(3) call of the same name.

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

This command depends on the feature \f(CW`hivex\*(C'.   See also
feature-available\*(R".

<a name="hivex-root"></a>

### hivex-root

.IX Subsection "hivex-root"
.Vb 1
 hivex-root
.Ve

Return the root node of the hive.

This is a wrapper around the **hivex**\|(3) call of the same name.

This command depends on the feature \f(CW`hivex\*(C'.   See also
feature-available\*(R".

<a name="hivex-value-key"></a>

### hivex-value-key

.IX Subsection "hivex-value-key"
.Vb 1
 hivex-value-key valueh
.Ve

Return the key (name) field of a (key, datatype, data) tuple.

This is a wrapper around the **hivex**\|(3) call of the same name.

This command depends on the feature \f(CW`hivex\*(C'.   See also
feature-available\*(R".

<a name="hivex-value-string"></a>

### hivex-value-string

.IX Subsection "hivex-value-string"
.Vb 1
 hivex-value-string valueh
.Ve

This calls hivex-value-value\*(R" (which returns the
data field from a hivex value tuple).  It then assumes that
the field is a \s-1UTF-16LE\s0 string and converts the result to
\s-1UTF-8\s0 (or if this is not possible, it returns an error).

This is useful for reading strings out of the Windows registry.
However it is not foolproof because the registry is not
strongly-typed and fields can contain arbitrary or unexpected
data.

This command depends on the feature \f(CW`hivex\*(C'.   See also
feature-available\*(R".

<a name="hivex-value-type"></a>

### hivex-value-type

.IX Subsection "hivex-value-type"
.Vb 1
 hivex-value-type valueh
.Ve

Return the data type field from a (key, datatype, data) tuple.

This is a wrapper around the **hivex**\|(3) call of the same name.

This command depends on the feature \f(CW`hivex\*(C'.   See also
feature-available\*(R".

<a name="hivex-value-utf8"></a>

### hivex\-value\-utf8

.IX Subsection "hivex-value-utf8"
.Vb 1
 hivex-value-utf8 valueh
.Ve

This calls hivex-value-value\*(R" (which returns the
data field from a hivex value tuple).  It then assumes that
the field is a \s-1UTF-16LE\s0 string and converts the result to
\s-1UTF-8\s0 (or if this is not possible, it returns an error).

This is useful for reading strings out of the Windows registry.
However it is not foolproof because the registry is not
strongly-typed and fields can contain arbitrary or unexpected
data.

_This function is deprecated._
In new code, use the hivex-value-string\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

This command depends on the feature \f(CW`hivex\*(C'.   See also
feature-available\*(R".

<a name="hivex-value-value"></a>

### hivex-value-value

.IX Subsection "hivex-value-value"
.Vb 1
 hivex-value-value valueh
.Ve

Return the data field of a (key, datatype, data) tuple.

This is a wrapper around the **hivex**\|(3) call of the same name.

See also: hivex-value-utf8\*(R".

This command depends on the feature \f(CW`hivex\*(C'.   See also
feature-available\*(R".

<a name="initrd-cat"></a>

### initrd-cat

.IX Subsection "initrd-cat"
.Vb 1
 initrd-cat initrdpath filename
.Ve

This command unpacks the file _filename_ from the initrd file
called _initrdpath_.  The filename must be given _without_ the
initial _/_ character.

For example, in guestfish you could use the following command
to examine the boot script (usually called _/init_)
contained in a Linux initrd or initramfs image:

.Vb 1
 initrd-cat /boot/initrd-&lt;version&gt;.img init
.Ve

See also initrd-list\*(R".

Because of the message protocol, there is a transfer limit
of somewhere between 2MB and 4MB.  See \s-1PROTOCOL LIMITS\*(R"\s0 in **guestfs**\|(3).

<a name="initrd-list"></a>

### initrd-list

.IX Subsection "initrd-list"
.Vb 1
 initrd-list path
.Ve

This command lists out files contained in an initrd.

The files are listed without any initial _/_ character.  The
files are listed in the order they appear (not necessarily
alphabetical).  Directory names are listed as separate items.

Old Linux kernels (2.4 and earlier) used a compressed ext2
filesystem as initrd.  We _only_ support the newer initramfs
format (compressed cpio files).

<a name="inotify-add-watch"></a>

### inotify-add-watch

.IX Subsection "inotify-add-watch"
.Vb 1
 inotify-add-watch path mask
.Ve

Watch \f(CW`path\*(C' for the events listed in \f(CW\*(C\`mask\*(C'.

Note that if \f(CW`path\*(C' is a directory then events within that
directory are watched, but this does _not_ happen recursively
(in subdirectories).

Note for non-C or non-Linux callers: the inotify events are
defined by the Linux kernel \s-1ABI\s0 and are listed in
_/usr/include/sys/inotify.h_.

This command depends on the feature \f(CW`inotify\*(C'.   See also
feature-available\*(R".

<a name="inotify-close"></a>

### inotify-close

.IX Subsection "inotify-close"
.Vb 1
 inotify-close
.Ve

This closes the inotify handle which was previously
opened by inotify_init.  It removes all watches, throws
away any pending events, and deallocates all resources.

This command depends on the feature \f(CW`inotify\*(C'.   See also
feature-available\*(R".

<a name="inotify-files"></a>

### inotify-files

.IX Subsection "inotify-files"
.Vb 1
 inotify-files
.Ve

This function is a helpful wrapper around inotify-read\*(R"
which just returns a list of pathnames of objects that were
touched.  The returned pathnames are sorted and deduplicated.

This command depends on the feature \f(CW`inotify\*(C'.   See also
feature-available\*(R".

<a name="inotify-init"></a>

### inotify-init

.IX Subsection "inotify-init"
.Vb 1
 inotify-init maxevents
.Ve

This command creates a new inotify handle.
The inotify subsystem can be used to notify events which happen to
objects in the guest filesystem.

\f(CW`maxevents\*(C' is the maximum number of events which will be
queued up between calls to inotify-read\*(R" or
inotify-files\*(R".
If this is passed as \f(CW0, then the kernel (or previously set)
default is used.  For Linux 2.6.29 the default was 16384 events.
Beyond this limit, the kernel throws away events, but records
the fact that it threw them away by setting a flag
\f(CW`IN\_Q\_OVERFLOW\*(C' in the returned structure list (see
inotify-read\*(R").

Before any events are generated, you have to add some
watches to the internal watch list.  See: inotify-add-watch\*(R" and
inotify-rm-watch\*(R".

Queued up events should be read periodically by calling
inotify-read\*(R"
(or inotify-files\*(R" which is just a helpful
wrapper around inotify-read\*(R").  If you don't
read the events out often enough then you risk the internal
queue overflowing.

The handle should be closed after use by calling
inotify-close\*(R".  This also removes any
watches automatically.

See also **inotify**\|(7) for an overview of the inotify interface
as exposed by the Linux kernel, which is roughly what we expose
via libguestfs.  Note that there is one global inotify handle
per libguestfs instance.

This command depends on the feature \f(CW`inotify\*(C'.   See also
feature-available\*(R".

<a name="inotify-read"></a>

### inotify-read

.IX Subsection "inotify-read"
.Vb 1
 inotify-read
.Ve

Return the complete queue of events that have happened
since the previous read call.

If no events have happened, this returns an empty list.

_Note_: In order to make sure that all events have been
read, you must call this function repeatedly until it
returns an empty list.  The reason is that the call will
read events up to the maximum appliance-to-host message
size and leave remaining events in the queue.

This command depends on the feature \f(CW`inotify\*(C'.   See also
feature-available\*(R".

<a name="inotify-rm-watch"></a>

### inotify-rm-watch

.IX Subsection "inotify-rm-watch"
.Vb 1
 inotify-rm-watch wd
.Ve

Remove a previously defined inotify watch.
See inotify-add-watch\*(R".

This command depends on the feature \f(CW`inotify\*(C'.   See also
feature-available\*(R".

<a name="inspect-get-arch"></a>

### inspect-get-arch

.IX Subsection "inspect-get-arch"
.Vb 1
 inspect-get-arch root
.Ve

This returns the architecture of the inspected operating system.
The possible return values are listed under
file-architecture\*(R".

If the architecture could not be determined, then the
string \f(CW`unknown\*(C' is returned.

Please read \s-1INSPECTION\*(R"\s0 in **guestfs**\|(3) for more details.

<a name="inspect-get-distro"></a>

### inspect-get-distro

.IX Subsection "inspect-get-distro"
.Vb 1
 inspect-get-distro root
.Ve

This returns the distro (distribution) of the inspected operating
system.

Currently defined distros are:
.ie n .IP """alpinelinux""" 4
.el .IP "\`\`alpinelinux''" 4
.IX Item "alpinelinux"
Alpine Linux.
.ie n .IP """altlinux""" 4
.el .IP "\`\`altlinux''" 4
.IX Item "altlinux"
\s-1ALT\s0 Linux.
.ie n .IP """archlinux""" 4
.el .IP "\`\`archlinux''" 4
.IX Item "archlinux"
Arch Linux.
.ie n .IP """buildroot""" 4
.el .IP "\`\`buildroot''" 4
.IX Item "buildroot"
Buildroot-derived distro, but not one we specifically recognize.
.ie n .IP """centos""" 4
.el .IP "\`\`centos''" 4
.IX Item "centos"
CentOS.
.ie n .IP """cirros""" 4
.el .IP "\`\`cirros''" 4
.IX Item "cirros"
Cirros.
.ie n .IP """coreos""" 4
.el .IP "\`\`coreos''" 4
.IX Item "coreos"
CoreOS.
.ie n .IP """debian""" 4
.el .IP "\`\`debian''" 4
.IX Item "debian"
Debian.
.ie n .IP """fedora""" 4
.el .IP "\`\`fedora''" 4
.IX Item "fedora"
Fedora.
.ie n .IP """freebsd""" 4
.el .IP "\`\`freebsd''" 4
.IX Item "freebsd"
FreeBSD.
.ie n .IP """freedos""" 4
.el .IP "\`\`freedos''" 4
.IX Item "freedos"
FreeDOS.
.ie n .IP """frugalware""" 4
.el .IP "\`\`frugalware''" 4
.IX Item "frugalware"
Frugalware.
.ie n .IP """gentoo""" 4
.el .IP "\`\`gentoo''" 4
.IX Item "gentoo"
Gentoo.
.ie n .IP """kalilinux""" 4
.el .IP "\`\`kalilinux''" 4
.IX Item "kalilinux"
Kali Linux.
.ie n .IP """linuxmint""" 4
.el .IP "\`\`linuxmint''" 4
.IX Item "linuxmint"
Linux Mint.
.ie n .IP """mageia""" 4
.el .IP "\`\`mageia''" 4
.IX Item "mageia"
Mageia.
.ie n .IP """mandriva""" 4
.el .IP "\`\`mandriva''" 4
.IX Item "mandriva"
Mandriva.
.ie n .IP """meego""" 4
.el .IP "\`\`meego''" 4
.IX Item "meego"
MeeGo.
.ie n .IP """msdos""" 4
.el .IP "\`\`msdos''" 4
.IX Item "msdos"
Microsoft \s-1DOS.\s0
.ie n .IP """neokylin""" 4
.el .IP "\`\`neokylin''" 4
.IX Item "neokylin"
NeoKylin.
.ie n .IP """netbsd""" 4
.el .IP "\`\`netbsd''" 4
.IX Item "netbsd"
NetBSD.
.ie n .IP """openbsd""" 4
.el .IP "\`\`openbsd''" 4
.IX Item "openbsd"
OpenBSD.
.ie n .IP """opensuse""" 4
.el .IP "\`\`opensuse''" 4
.IX Item "opensuse"
OpenSUSE.
.ie n .IP """oraclelinux""" 4
.el .IP "\`\`oraclelinux''" 4
.IX Item "oraclelinux"
Oracle Linux.
.ie n .IP """pardus""" 4
.el .IP "\`\`pardus''" 4
.IX Item "pardus"
Pardus.
.ie n .IP """pldlinux""" 4
.el .IP "\`\`pldlinux''" 4
.IX Item "pldlinux"
\s-1PLD\s0 Linux.
.ie n .IP """redhat-based""" 4
.el .IP "\`\`redhat-based''" 4
.IX Item "redhat-based"
Some Red Hat-derived distro.
.ie n .IP """rhel""" 4
.el .IP "\`\`rhel''" 4
.IX Item "rhel"
Red Hat Enterprise Linux.
.ie n .IP """scientificlinux""" 4
.el .IP "\`\`scientificlinux''" 4
.IX Item "scientificlinux"
Scientific Linux.
.ie n .IP """slackware""" 4
.el .IP "\`\`slackware''" 4
.IX Item "slackware"
Slackware.
.ie n .IP """sles""" 4
.el .IP "\`\`sles''" 4
.IX Item "sles"
SuSE Linux Enterprise Server or Desktop.
.ie n .IP """suse-based""" 4
.el .IP "\`\`suse-based''" 4
.IX Item "suse-based"
Some openSuSE-derived distro.
.ie n .IP """ttylinux""" 4
.el .IP "\`\`ttylinux''" 4
.IX Item "ttylinux"
ttylinux.
.ie n .IP """ubuntu""" 4
.el .IP "\`\`ubuntu''" 4
.IX Item "ubuntu"
Ubuntu.
.ie n .IP """unknown""" 4
.el .IP "\`\`unknown''" 4
.IX Item "unknown"
The distro could not be determined.
.ie n .IP """voidlinux""" 4
.el .IP "\`\`voidlinux''" 4
.IX Item "voidlinux"
Void Linux.
.ie n .IP """windows""" 4
.el .IP "\`\`windows''" 4
.IX Item "windows"
Windows does not have distributions.  This string is
returned if the \s-1OS\s0 type is Windows.

Future versions of libguestfs may return other strings here.
The caller should be prepared to handle any string.

Please read \s-1INSPECTION\*(R"\s0 in **guestfs**\|(3) for more details.

<a name="inspect-get-drive-mappings"></a>

### inspect-get-drive-mappings

.IX Subsection "inspect-get-drive-mappings"
.Vb 1
 inspect-get-drive-mappings root
.Ve

This call is useful for Windows which uses a primitive system
of assigning drive letters (like _C:\e_) to partitions.
This inspection \s-1API\s0 examines the Windows Registry to find out
how disks/partitions are mapped to drive letters, and returns
a hash table as in the example below:

.Vb 3
 C      =&gt;     /dev/vda2
 E      =&gt;     /dev/vdb1
 F      =&gt;     /dev/vdc1
.Ve

Note that keys are drive letters.  For Windows, the key is
case insensitive and just contains the drive letter, without
the customary colon separator character.

In future we may support other operating systems that also used drive
letters, but the keys for those might not be case insensitive
and might be longer than 1 character.  For example in \s-1OS-9,\s0
hard drives were named \f(CW`h0\*(C', \f(CW\*(C\`h1\*(C' etc.

For Windows guests, currently only hard drive mappings are
returned.  Removable disks (eg. DVD-ROMs) are ignored.

For guests that do not use drive mappings, or if the drive mappings
could not be determined, this returns an empty hash table.

Please read \s-1INSPECTION\*(R"\s0 in **guestfs**\|(3) for more details.
See also inspect-get-mountpoints\*(R",
inspect-get-filesystems\*(R".

<a name="inspect-get-filesystems"></a>

### inspect-get-filesystems

.IX Subsection "inspect-get-filesystems"
.Vb 1
 inspect-get-filesystems root
.Ve

This returns a list of all the filesystems that we think
are associated with this operating system.  This includes
the root filesystem, other ordinary filesystems, and
non-mounted devices like swap partitions.

In the case of a multi-boot virtual machine, it is possible
for a filesystem to be shared between operating systems.

Please read \s-1INSPECTION\*(R"\s0 in **guestfs**\|(3) for more details.
See also inspect-get-mountpoints\*(R".

<a name="inspect-get-format"></a>

### inspect-get-format

.IX Subsection "inspect-get-format"
.Vb 1
 inspect-get-format root
.Ve

Before libguestfs 1.38, there was some unreliable support for detecting
installer CDs.  This \s-1API\s0 would return:
.ie n .IP """installed""" 4
.el .IP "\`\`installed''" 4
.IX Item "installed"
This is an installed operating system.
.ie n .IP """installer""" 4
.el .IP "\`\`installer''" 4
.IX Item "installer"
The disk image being inspected is not an installed operating system,
but a _bootable_ install disk, live \s-1CD,\s0 or similar.
.ie n .IP """unknown""" 4
.el .IP "\`\`unknown''" 4
.IX Item "unknown"
The format of this disk image is not known.

In libguestfs ≥ 1.38, this only returns \f(CW`installed\*(C'.
Use libosinfo directly to detect installer CDs.

Please read \s-1INSPECTION\*(R"\s0 in **guestfs**\|(3) for more details.

_This function is deprecated._
There is no replacement.  Consult the \s-1API\s0 documentation in
**guestfs**\|(3) for further information.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="inspect-get-hostname"></a>

### inspect-get-hostname

.IX Subsection "inspect-get-hostname"
.Vb 1
 inspect-get-hostname root
.Ve

This function returns the hostname of the operating system
as found by inspection of the guest’s configuration files.

If the hostname could not be determined, then the
string \f(CW`unknown\*(C' is returned.

Please read \s-1INSPECTION\*(R"\s0 in **guestfs**\|(3) for more details.

<a name="inspect-get-icon"></a>

### inspect-get-icon

.IX Subsection "inspect-get-icon"
.Vb 1
 inspect-get-icon root [favicon:true|false] [highquality:true|false]
.Ve

This function returns an icon corresponding to the inspected
operating system.  The icon is returned as a buffer containing a
\s-1PNG\s0 image (re-encoded to \s-1PNG\s0 if necessary).

If it was not possible to get an icon this function returns a
zero-length (non-NULL) buffer.  _Callers must check for this case_.

Libguestfs will start by looking for a file called
_/etc/favicon.png_ or _C:\eetc\efavicon.png_
and if it has the correct format, the contents of this file will
be returned.  You can disable favicons by passing the
optional \f(CW`favicon\*(C' boolean as false (default is true).

If finding the favicon fails, then we look in other places in the
guest for a suitable icon.

If the optional \f(CW`highquality\*(C' boolean is true then
only high quality icons are returned, which means only icons of
high resolution with an alpha channel.  The default (false) is
to return any icon we can, even if it is of substandard quality.

Notes:

* ·  
  Unlike most other inspection \s-1API\s0 calls, the guest’s disks must be
  mounted up before you call this, since it needs to read information
  from the guest filesystem during the call.
* ·  
  **Security:** The icon data comes from the untrusted guest,
  and should be treated with caution.  \s-1PNG\s0 files have been
  known to contain exploits.  Ensure that libpng (or other relevant
  libraries) are fully up to date before trying to process or
  display the icon.
* ·  
  The \s-1PNG\s0 image returned can be any size.  It might not be square.
  Libguestfs tries to return the largest, highest quality
  icon available.  The application must scale the icon to the
  required size.
* ·  
  Extracting icons from Windows guests requires the external
  \f(CW`wrestool\*(C' program from the \f(CW\*(C\`icoutils\*(C' package, and
  several programs (\f(CW`bmptopnm\*(C', \f(CW\*(C\`pnmtopng\*(C', \f(CW\*(C\`pamcut\*(C')
  from the \f(CW`netpbm\*(C' package.  These must be installed separately.
* ·  
  Operating system icons are usually trademarks.  Seek legal
  advice before using trademarks in applications.

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

<a name="inspect-get-major-version"></a>

### inspect-get-major-version

.IX Subsection "inspect-get-major-version"
.Vb 1
 inspect-get-major-version root
.Ve

This returns the major version number of the inspected operating
system.

Windows uses a consistent versioning scheme which is _not_
reflected in the popular public names used by the operating system.
Notably the operating system known as Windows 7\*(R" is really
version 6.1 (ie. major = 6, minor = 1).  You can find out the
real versions corresponding to releases of Windows by consulting
Wikipedia or \s-1MSDN.\s0

If the version could not be determined, then \f(CW0 is returned.

Please read \s-1INSPECTION\*(R"\s0 in **guestfs**\|(3) for more details.

<a name="inspect-get-minor-version"></a>

### inspect-get-minor-version

.IX Subsection "inspect-get-minor-version"
.Vb 1
 inspect-get-minor-version root
.Ve

This returns the minor version number of the inspected operating
system.

If the version could not be determined, then \f(CW0 is returned.

Please read \s-1INSPECTION\*(R"\s0 in **guestfs**\|(3) for more details.
See also inspect-get-major-version\*(R".

<a name="inspect-get-mountpoints"></a>

### inspect-get-mountpoints

.IX Subsection "inspect-get-mountpoints"
.Vb 1
 inspect-get-mountpoints root
.Ve

This returns a hash of where we think the filesystems
associated with this operating system should be mounted.
Callers should note that this is at best an educated guess
made by reading configuration files such as _/etc/fstab_.
_In particular note_ that this may return filesystems
which are non-existent or not mountable and callers should
be prepared to handle or ignore failures if they try to
mount them.

Each element in the returned hashtable has a key which
is the path of the mountpoint (eg. _/boot_) and a value
which is the filesystem that would be mounted there
(eg. _/dev/sda1_).

Non-mounted devices such as swap devices are _not_
returned in this list.

For operating systems like Windows which still use drive
letters, this call will only return an entry for the first
drive mounted on\*(R" _/_.  For information about the
mapping of drive letters to partitions, see
inspect-get-drive-mappings\*(R".

Please read \s-1INSPECTION\*(R"\s0 in **guestfs**\|(3) for more details.
See also inspect-get-filesystems\*(R".

<a name="inspect-get-osinfo"></a>

### inspect-get-osinfo

.IX Subsection "inspect-get-osinfo"
.Vb 1
 inspect-get-osinfo root
.Ve

This function returns a possible short \s-1ID\s0 for libosinfo corresponding
to the guest.

_Note:_ The returned \s-1ID\s0 is only a guess by libguestfs, and nothing
ensures that it actually exists in osinfo-db.

If no \s-1ID\s0 could not be determined, then the string \f(CW`unknown\*(C' is
returned.

<a name="inspect-get-package-format"></a>

### inspect-get-package-format

.IX Subsection "inspect-get-package-format"
.Vb 1
 inspect-get-package-format root
.Ve

This function and inspect-get-package-management\*(R" return
the package format and package management tool used by the
inspected operating system.  For example for Fedora these
functions would return \f(CW`rpm\*(C' (package format), and
\f(CW`yum\*(C' or \f(CW\*(C\`dnf\*(C' (package management).

This returns the string \f(CW`unknown\*(C' if we could not determine the
package format _or_ if the operating system does not have
a real packaging system (eg. Windows).

Possible strings include:
\f(CW`rpm\*(C', \f(CW\*(C\`deb\*(C', \f(CW\*(C\`ebuild\*(C', \f(CW\*(C\`pisi\*(C', \f(CW\*(C\`pacman\*(C', \f(CW\*(C\`pkgsrc\*(C', \f(CW\*(C\`apk\*(C',
\f(CW`xbps\*(C'.
Future versions of libguestfs may return other strings.

Please read \s-1INSPECTION\*(R"\s0 in **guestfs**\|(3) for more details.

<a name="inspect-get-package-management"></a>

### inspect-get-package-management

.IX Subsection "inspect-get-package-management"
.Vb 1
 inspect-get-package-management root
.Ve

inspect-get-package-format\*(R" and this function return
the package format and package management tool used by the
inspected operating system.  For example for Fedora these
functions would return \f(CW`rpm\*(C' (package format), and
\f(CW`yum\*(C' or \f(CW\*(C\`dnf\*(C' (package management).

This returns the string \f(CW`unknown\*(C' if we could not determine the
package management tool _or_ if the operating system does not have
a real packaging system (eg. Windows).

Possible strings include: \f(CW`yum\*(C', \f(CW\*(C\`dnf\*(C', \f(CW\*(C\`up2date\*(C',
\f(CW`apt\*(C' (for all Debian derivatives),
\f(CW`portage\*(C', \f(CW\*(C\`pisi\*(C', \f(CW\*(C\`pacman\*(C', \f(CW\*(C\`urpmi\*(C', \f(CW\*(C\`zypper\*(C', \f(CW\*(C\`apk\*(C', \f(CW\*(C\`xbps\*(C'.
Future versions of libguestfs may return other strings.

Please read \s-1INSPECTION\*(R"\s0 in **guestfs**\|(3) for more details.

<a name="inspect-get-product-name"></a>

### inspect-get-product-name

.IX Subsection "inspect-get-product-name"
.Vb 1
 inspect-get-product-name root
.Ve

This returns the product name of the inspected operating
system.  The product name is generally some freeform string
which can be displayed to the user, but should not be
parsed by programs.

If the product name could not be determined, then the
string \f(CW`unknown\*(C' is returned.

Please read \s-1INSPECTION\*(R"\s0 in **guestfs**\|(3) for more details.

<a name="inspect-get-product-variant"></a>

### inspect-get-product-variant

.IX Subsection "inspect-get-product-variant"
.Vb 1
 inspect-get-product-variant root
.Ve

This returns the product variant of the inspected operating
system.

For Windows guests, this returns the contents of the Registry key
\f(CW`HKLM\eSoftware\eMicrosoft\eWindows NT\eCurrentVersion\*(C'
\f(CW`InstallationType\*(C' which is usually a string such as
\f(CW`Client\*(C' or \f(CW\*(C\`Server\*(C' (other values are possible).  This
can be used to distinguish consumer and enterprise versions
of Windows that have the same version number (for example,
Windows 7 and Windows 2008 Server are both version 6.1,
but the former is \f(CW`Client\*(C' and the latter is \f(CW\*(C\`Server\*(C').

For enterprise Linux guests, in future we intend this to return
the product variant such as \f(CW`Desktop\*(C', \f(CW\*(C\`Server\*(C' and so on.  But
this is not implemented at present.

If the product variant could not be determined, then the
string \f(CW`unknown\*(C' is returned.

Please read \s-1INSPECTION\*(R"\s0 in **guestfs**\|(3) for more details.
See also inspect-get-product-name\*(R",
inspect-get-major-version\*(R".

<a name="inspect-get-roots"></a>

### inspect-get-roots

.IX Subsection "inspect-get-roots"
.Vb 1
 inspect-get-roots
.Ve

This function is a convenient way to get the list of root
devices, as returned from a previous call to inspect-os\*(R",
but without redoing the whole inspection process.

This returns an empty list if either no root devices were
found or the caller has not called inspect-os\*(R".

Please read \s-1INSPECTION\*(R"\s0 in **guestfs**\|(3) for more details.

<a name="inspect-get-type"></a>

### inspect-get-type

.IX Subsection "inspect-get-type"
.Vb 1
 inspect-get-type root
.Ve

This returns the type of the inspected operating system.
Currently defined types are:
.ie n .IP """linux""" 4
.el .IP "\`\`linux''" 4
.IX Item "linux"
Any Linux-based operating system.
.ie n .IP """windows""" 4
.el .IP "\`\`windows''" 4
.IX Item "windows"
Any Microsoft Windows operating system.
.ie n .IP """freebsd""" 4
.el .IP "\`\`freebsd''" 4
.IX Item "freebsd"
FreeBSD.
.ie n .IP """netbsd""" 4
.el .IP "\`\`netbsd''" 4
.IX Item "netbsd"
NetBSD.
.ie n .IP """openbsd""" 4
.el .IP "\`\`openbsd''" 4
.IX Item "openbsd"
OpenBSD.
.ie n .IP """hurd""" 4
.el .IP "\`\`hurd''" 4
.IX Item "hurd"
GNU/Hurd.
.ie n .IP """dos""" 4
.el .IP "\`\`dos''" 4
.IX Item "dos"
MS-DOS, FreeDOS and others.
.ie n .IP """minix""" 4
.el .IP "\`\`minix''" 4
.IX Item "minix"
\s-1MINIX.\s0
.ie n .IP """unknown""" 4
.el .IP "\`\`unknown''" 4
.IX Item "unknown"
The operating system type could not be determined.

Future versions of libguestfs may return other strings here.
The caller should be prepared to handle any string.

Please read \s-1INSPECTION\*(R"\s0 in **guestfs**\|(3) for more details.

<a name="inspect-get-windows-current-control-set"></a>

### inspect-get-windows-current-control-set

.IX Subsection "inspect-get-windows-current-control-set"
.Vb 1
 inspect-get-windows-current-control-set root
.Ve

This returns the Windows CurrentControlSet of the inspected guest.
The CurrentControlSet is a registry key name such as \f(CW`ControlSet001\*(C'.

This call assumes that the guest is Windows and that the
Registry could be examined by inspection.  If this is not
the case then an error is returned.

Please read \s-1INSPECTION\*(R"\s0 in **guestfs**\|(3) for more details.

<a name="inspect-get-windows-software-hive"></a>

### inspect-get-windows-software-hive

.IX Subsection "inspect-get-windows-software-hive"
.Vb 1
 inspect-get-windows-software-hive root
.Ve

This returns the path to the hive (binary Windows Registry file)
corresponding to HKLM\eSOFTWARE.

This call assumes that the guest is Windows and that the guest
has a software hive file with the right name.  If this is not the
case then an error is returned.  This call does not check that the
hive is a valid Windows Registry hive.

You can use hivex-open\*(R" to read or write to the hive.

Please read \s-1INSPECTION\*(R"\s0 in **guestfs**\|(3) for more details.

<a name="inspect-get-windows-system-hive"></a>

### inspect-get-windows-system-hive

.IX Subsection "inspect-get-windows-system-hive"
.Vb 1
 inspect-get-windows-system-hive root
.Ve

This returns the path to the hive (binary Windows Registry file)
corresponding to HKLM\eSYSTEM.

This call assumes that the guest is Windows and that the guest
has a system hive file with the right name.  If this is not the
case then an error is returned.  This call does not check that the
hive is a valid Windows Registry hive.

You can use hivex-open\*(R" to read or write to the hive.

Please read \s-1INSPECTION\*(R"\s0 in **guestfs**\|(3) for more details.

<a name="inspect-get-windows-systemroot"></a>

### inspect-get-windows-systemroot

.IX Subsection "inspect-get-windows-systemroot"
.Vb 1
 inspect-get-windows-systemroot root
.Ve

This returns the Windows systemroot of the inspected guest.
The systemroot is a directory path such as _/WINDOWS_.

This call assumes that the guest is Windows and that the
systemroot could be determined by inspection.  If this is not
the case then an error is returned.

Please read \s-1INSPECTION\*(R"\s0 in **guestfs**\|(3) for more details.

<a name="inspect-is-live"></a>

### inspect-is-live

.IX Subsection "inspect-is-live"
.Vb 1
 inspect-is-live root
.Ve

This is deprecated and always returns \f(CW`false\*(C'.

Please read \s-1INSPECTION\*(R"\s0 in **guestfs**\|(3) for more details.

_This function is deprecated._
There is no replacement.  Consult the \s-1API\s0 documentation in
**guestfs**\|(3) for further information.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="inspect-is-multipart"></a>

### inspect-is-multipart

.IX Subsection "inspect-is-multipart"
.Vb 1
 inspect-is-multipart root
.Ve

This is deprecated and always returns \f(CW`false\*(C'.

Please read \s-1INSPECTION\*(R"\s0 in **guestfs**\|(3) for more details.

_This function is deprecated._
There is no replacement.  Consult the \s-1API\s0 documentation in
**guestfs**\|(3) for further information.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="inspect-is-netinst"></a>

### inspect-is-netinst

.IX Subsection "inspect-is-netinst"
.Vb 1
 inspect-is-netinst root
.Ve

This is deprecated and always returns \f(CW`false\*(C'.

Please read \s-1INSPECTION\*(R"\s0 in **guestfs**\|(3) for more details.

_This function is deprecated._
There is no replacement.  Consult the \s-1API\s0 documentation in
**guestfs**\|(3) for further information.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="inspect-list-applications"></a>

### inspect-list-applications

.IX Subsection "inspect-list-applications"
.Vb 1
 inspect-list-applications root
.Ve

Return the list of applications installed in the operating system.

_Note:_ This call works differently from other parts of the
inspection \s-1API.\s0  You have to call inspect-os\*(R", then
inspect-get-mountpoints\*(R", then mount up the disks,
before calling this.  Listing applications is a significantly
more difficult operation which requires access to the full
filesystem.  Also note that unlike the other
inspect-get-*\*(R" calls which are just returning
data cached in the libguestfs handle, this call actually reads
parts of the mounted filesystems during the call.

This returns an empty list if the inspection code was not able
to determine the list of applications.

The application structure contains the following fields:
.ie n .IP """app_name""" 4
.el .IP "\f(CWapp\_name" 4
.IX Item "app_name"
The name of the application.  For Red Hat-derived and Debian-derived
Linux guests, this is the package name.
.ie n .IP """app_display_name""" 4
.el .IP "\f(CWapp\_display\_name" 4
.IX Item "app_display_name"
The display name of the application, sometimes localized to the
install language of the guest operating system.
.Sp
If unavailable this is returned as an empty string \f(CW"".
Callers needing to display something can use \f(CW`app\_name\*(C' instead.
.ie n .IP """app_epoch""" 4
.el .IP "\f(CWapp\_epoch" 4
.IX Item "app_epoch"
For package managers which use epochs, this contains the epoch of
the package (an integer).  If unavailable, this is returned as \f(CW0.
.ie n .IP """app_version""" 4
.el .IP "\f(CWapp\_version" 4
.IX Item "app_version"
The version string of the application or package.  If unavailable
this is returned as an empty string \f(CW"".
.ie n .IP """app_release""" 4
.el .IP "\f(CWapp\_release" 4
.IX Item "app_release"
The release string of the application or package, for package
managers that use this.  If unavailable this is returned as an
empty string \f(CW"".
.ie n .IP """app_install_path""" 4
.el .IP "\f(CWapp\_install\_path" 4
.IX Item "app_install_path"
The installation path of the application (on operating systems
such as Windows which use installation paths).  This path is
in the format used by the guest operating system, it is not
a libguestfs path.
.Sp
If unavailable this is returned as an empty string \f(CW"".
.ie n .IP """app_trans_path""" 4
.el .IP "\f(CWapp\_trans\_path" 4
.IX Item "app_trans_path"
The install path translated into a libguestfs path.
If unavailable this is returned as an empty string \f(CW"".
.ie n .IP """app_publisher""" 4
.el .IP "\f(CWapp\_publisher" 4
.IX Item "app_publisher"
The name of the publisher of the application, for package
managers that use this.  If unavailable this is returned
as an empty string \f(CW"".
.ie n .IP """app_url""" 4
.el .IP "\f(CWapp\_url" 4
.IX Item "app_url"
The \s-1URL\s0 (eg. upstream \s-1URL\s0) of the application.
If unavailable this is returned as an empty string \f(CW"".
.ie n .IP """app_source_package""" 4
.el .IP "\f(CWapp\_source\_package" 4
.IX Item "app_source_package"
For packaging systems which support this, the name of the source
package.  If unavailable this is returned as an empty string \f(CW"".
.ie n .IP """app_summary""" 4
.el .IP "\f(CWapp\_summary" 4
.IX Item "app_summary"
A short (usually one line) description of the application or package.
If unavailable this is returned as an empty string \f(CW"".
.ie n .IP """app_description""" 4
.el .IP "\f(CWapp\_description" 4
.IX Item "app_description"
A longer description of the application or package.
If unavailable this is returned as an empty string \f(CW"".

Please read \s-1INSPECTION\*(R"\s0 in **guestfs**\|(3) for more details.

_This function is deprecated._
In new code, use the inspect-list-applications2\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="inspect-list-applications2"></a>

### inspect\-list\-applications2

.IX Subsection "inspect-list-applications2"
.Vb 1
 inspect-list-applications2 root
.Ve

Return the list of applications installed in the operating system.

_Note:_ This call works differently from other parts of the
inspection \s-1API.\s0  You have to call inspect-os\*(R", then
inspect-get-mountpoints\*(R", then mount up the disks,
before calling this.  Listing applications is a significantly
more difficult operation which requires access to the full
filesystem.  Also note that unlike the other
inspect-get-*\*(R" calls which are just returning
data cached in the libguestfs handle, this call actually reads
parts of the mounted filesystems during the call.

This returns an empty list if the inspection code was not able
to determine the list of applications.

The application structure contains the following fields:
.ie n .IP """app2_name""" 4
.el .IP "\f(CWapp2\_name" 4
.IX Item "app2_name"
The name of the application.  For Red Hat-derived and Debian-derived
Linux guests, this is the package name.
.ie n .IP """app2_display_name""" 4
.el .IP "\f(CWapp2\_display\_name" 4
.IX Item "app2_display_name"
The display name of the application, sometimes localized to the
install language of the guest operating system.
.Sp
If unavailable this is returned as an empty string \f(CW"".
Callers needing to display something can use \f(CW`app2\_name\*(C' instead.
.ie n .IP """app2_epoch""" 4
.el .IP "\f(CWapp2\_epoch" 4
.IX Item "app2_epoch"
For package managers which use epochs, this contains the epoch of
the package (an integer).  If unavailable, this is returned as \f(CW0.
.ie n .IP """app2_version""" 4
.el .IP "\f(CWapp2\_version" 4
.IX Item "app2_version"
The version string of the application or package.  If unavailable
this is returned as an empty string \f(CW"".
.ie n .IP """app2_release""" 4
.el .IP "\f(CWapp2\_release" 4
.IX Item "app2_release"
The release string of the application or package, for package
managers that use this.  If unavailable this is returned as an
empty string \f(CW"".
.ie n .IP """app2_arch""" 4
.el .IP "\f(CWapp2\_arch" 4
.IX Item "app2_arch"
The architecture string of the application or package, for package
managers that use this.  If unavailable this is returned as an empty
string \f(CW"".
.ie n .IP """app2_install_path""" 4
.el .IP "\f(CWapp2\_install\_path" 4
.IX Item "app2_install_path"
The installation path of the application (on operating systems
such as Windows which use installation paths).  This path is
in the format used by the guest operating system, it is not
a libguestfs path.
.Sp
If unavailable this is returned as an empty string \f(CW"".
.ie n .IP """app2_trans_path""" 4
.el .IP "\f(CWapp2\_trans\_path" 4
.IX Item "app2_trans_path"
The install path translated into a libguestfs path.
If unavailable this is returned as an empty string \f(CW"".
.ie n .IP """app2_publisher""" 4
.el .IP "\f(CWapp2\_publisher" 4
.IX Item "app2_publisher"
The name of the publisher of the application, for package
managers that use this.  If unavailable this is returned
as an empty string \f(CW"".
.ie n .IP """app2_url""" 4
.el .IP "\f(CWapp2\_url" 4
.IX Item "app2_url"
The \s-1URL\s0 (eg. upstream \s-1URL\s0) of the application.
If unavailable this is returned as an empty string \f(CW"".
.ie n .IP """app2_source_package""" 4
.el .IP "\f(CWapp2\_source\_package" 4
.IX Item "app2_source_package"
For packaging systems which support this, the name of the source
package.  If unavailable this is returned as an empty string \f(CW"".
.ie n .IP """app2_summary""" 4
.el .IP "\f(CWapp2\_summary" 4
.IX Item "app2_summary"
A short (usually one line) description of the application or package.
If unavailable this is returned as an empty string \f(CW"".
.ie n .IP """app2_description""" 4
.el .IP "\f(CWapp2\_description" 4
.IX Item "app2_description"
A longer description of the application or package.
If unavailable this is returned as an empty string \f(CW"".

Please read \s-1INSPECTION\*(R"\s0 in **guestfs**\|(3) for more details.

<a name="inspect-os"></a>

### inspect-os

.IX Subsection "inspect-os"
.Vb 1
 inspect-os
.Ve

This function uses other libguestfs functions and certain
heuristics to inspect the disk(s) (usually disks belonging to
a virtual machine), looking for operating systems.

The list returned is empty if no operating systems were found.

If one operating system was found, then this returns a list with
a single element, which is the name of the root filesystem of
this operating system.  It is also possible for this function
to return a list containing more than one element, indicating
a dual-boot or multi-boot virtual machine, with each element being
the root filesystem of one of the operating systems.

You can pass the root string(s) returned to other
inspect-get-*\*(R" functions in order to query further
information about each operating system, such as the name
and version.

This function uses other libguestfs features such as
mount-ro\*(R" and \*(L"umount-all\*(R" in order to mount
and unmount filesystems and look at the contents.  This should
be called with no disks currently mounted.  The function may also
use Augeas, so any existing Augeas handle will be closed.

This function cannot decrypt encrypted disks.  The caller
must do that first (supplying the necessary keys) if the
disk is encrypted.

Please read \s-1INSPECTION\*(R"\s0 in **guestfs**\|(3) for more details.

See also list-filesystems\*(R".

<a name="is-blockdev"></a>

### is-blockdev

.IX Subsection "is-blockdev"

<a name="is-blockdev-opts"></a>

### is-blockdev-opts

.IX Subsection "is-blockdev-opts"
.Vb 1
 is-blockdev path [followsymlinks:true|false]
.Ve

This returns \f(CW`true\*(C' if and only if there is a block device
with the given \f(CW`path\*(C' name.

If the optional flag \f(CW`followsymlinks\*(C' is true, then a symlink
(or chain of symlinks) that ends with a block device also causes the
function to return true.

This call only looks at files within the guest filesystem.  Libguestfs
partitions and block devices (eg. _/dev/sda_) cannot be used as the
\f(CW`path\*(C' parameter of this call.

See also stat\*(R".

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

<a name="is-chardev"></a>

### is-chardev

.IX Subsection "is-chardev"

<a name="is-chardev-opts"></a>

### is-chardev-opts

.IX Subsection "is-chardev-opts"
.Vb 1
 is-chardev path [followsymlinks:true|false]
.Ve

This returns \f(CW`true\*(C' if and only if there is a character device
with the given \f(CW`path\*(C' name.

If the optional flag \f(CW`followsymlinks\*(C' is true, then a symlink
(or chain of symlinks) that ends with a chardev also causes the
function to return true.

See also stat\*(R".

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

<a name="is-config"></a>

### is-config

.IX Subsection "is-config"
.Vb 1
 is-config
.Ve

This returns true iff this handle is being configured
(in the \f(CW`CONFIG\*(C' state).

For more information on states, see **guestfs**\|(3).

<a name="is-dir"></a>

### is-dir

.IX Subsection "is-dir"

<a name="is-dir-opts"></a>

### is-dir-opts

.IX Subsection "is-dir-opts"
.Vb 1
 is-dir path [followsymlinks:true|false]
.Ve

This returns \f(CW`true\*(C' if and only if there is a directory
with the given \f(CW`path\*(C' name.  Note that it returns false for
other objects like files.

If the optional flag \f(CW`followsymlinks\*(C' is true, then a symlink
(or chain of symlinks) that ends with a directory also causes the
function to return true.

See also stat\*(R".

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

<a name="is-fifo"></a>

### is-fifo

.IX Subsection "is-fifo"

<a name="is-fifo-opts"></a>

### is-fifo-opts

.IX Subsection "is-fifo-opts"
.Vb 1
 is-fifo path [followsymlinks:true|false]
.Ve

This returns \f(CW`true\*(C' if and only if there is a \s-1FIFO\s0 (named pipe)
with the given \f(CW`path\*(C' name.

If the optional flag \f(CW`followsymlinks\*(C' is true, then a symlink
(or chain of symlinks) that ends with a \s-1FIFO\s0 also causes the
function to return true.

See also stat\*(R".

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

<a name="is-file"></a>

### is-file

.IX Subsection "is-file"

<a name="is-file-opts"></a>

### is-file-opts

.IX Subsection "is-file-opts"
.Vb 1
 is-file path [followsymlinks:true|false]
.Ve

This returns \f(CW`true\*(C' if and only if there is a regular file
with the given \f(CW`path\*(C' name.  Note that it returns false for
other objects like directories.

If the optional flag \f(CW`followsymlinks\*(C' is true, then a symlink
(or chain of symlinks) that ends with a file also causes the
function to return true.

See also stat\*(R".

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

<a name="is-lv"></a>

### is-lv

.IX Subsection "is-lv"
.Vb 1
 is-lv mountable
.Ve

This command tests whether \f(CW`mountable\*(C' is a logical volume, and
returns true iff this is the case.

<a name="is-socket"></a>

### is-socket

.IX Subsection "is-socket"

<a name="is-socket-opts"></a>

### is-socket-opts

.IX Subsection "is-socket-opts"
.Vb 1
 is-socket path [followsymlinks:true|false]
.Ve

This returns \f(CW`true\*(C' if and only if there is a Unix domain socket
with the given \f(CW`path\*(C' name.

If the optional flag \f(CW`followsymlinks\*(C' is true, then a symlink
(or chain of symlinks) that ends with a socket also causes the
function to return true.

See also stat\*(R".

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

<a name="is-symlink"></a>

### is-symlink

.IX Subsection "is-symlink"
.Vb 1
 is-symlink path
.Ve

This returns \f(CW`true\*(C' if and only if there is a symbolic link
with the given \f(CW`path\*(C' name.

See also stat\*(R".

<a name="is-whole-device"></a>

### is-whole-device

.IX Subsection "is-whole-device"
.Vb 1
 is-whole-device device
.Ve

This returns \f(CW`true\*(C' if and only if \f(CW\*(C\`device\*(C' refers to a whole block
device. That is, not a partition or a logical device.

<a name="is-zero"></a>

### is-zero

.IX Subsection "is-zero"
.Vb 1
 is-zero path
.Ve

This returns true iff the file exists and the file is empty or
it contains all zero bytes.

<a name="is-zero-device"></a>

### is-zero-device

.IX Subsection "is-zero-device"
.Vb 1
 is-zero-device device
.Ve

This returns true iff the device exists and contains all zero bytes.

Note that for large devices this can take a long time to run.

<a name="isoinfo"></a>

### isoinfo

.IX Subsection "isoinfo"
.Vb 1
 isoinfo isofile
.Ve

This is the same as isoinfo-device\*(R" except that it
works for an \s-1ISO\s0 file located inside some other mounted filesystem.
Note that in the common case where you have added an \s-1ISO\s0 file
as a libguestfs device, you would _not_ call this.  Instead
you would call isoinfo-device\*(R".

<a name="isoinfo-device"></a>

### isoinfo-device

.IX Subsection "isoinfo-device"
.Vb 1
 isoinfo-device device
.Ve

\f(CW`device\*(C' is an \s-1ISO\s0 device.  This returns a struct of information
read from the primary volume descriptor (the \s-1ISO\s0 equivalent of the
superblock) of the device.

Usually it is more efficient to use the **isoinfo**\|(1) command
with the _-d_ option on the host to analyze \s-1ISO\s0 files,
instead of going through libguestfs.

For information on the primary volume descriptor fields, see
http://wiki.osdev.org/ISO_9660#The_Primary_Volume_Descriptor

<a name="journal-close"></a>

### journal-close

.IX Subsection "journal-close"
.Vb 1
 journal-close
.Ve

Close the journal handle.

This command depends on the feature \f(CW`journal\*(C'.   See also
feature-available\*(R".

<a name="journal-get"></a>

### journal-get

.IX Subsection "journal-get"
.Vb 1
 journal-get
.Ve

Read the current journal entry.  This returns all the fields
in the journal as a set of \f(CW`(attrname, attrval)\*(C' pairs.  The
\f(CW`attrname\*(C' is the field name (a string).

The \f(CW`attrval\*(C' is the field value (a binary blob, often but
not always a string).  Please note that \f(CW`attrval\*(C' is a byte
array, _not_ a \e0-terminated C string.

The length of data may be truncated to the data threshold
(see: journal-set-data-threshold\*(R",
journal-get-data-threshold\*(R").

If you set the data threshold to unlimited (\f(CW0) then this call
can read a journal entry of any size, ie. it is not limited by
the libguestfs protocol.

This command depends on the feature \f(CW`journal\*(C'.   See also
feature-available\*(R".

<a name="journal-get-data-threshold"></a>

### journal-get-data-threshold

.IX Subsection "journal-get-data-threshold"
.Vb 1
 journal-get-data-threshold
.Ve

Get the current data threshold for reading journal entries.
This is a hint to the journal that it may truncate data fields to
this size when reading them (note also that it may not truncate them).
If this returns \f(CW0, then the threshold is unlimited.

See also journal-set-data-threshold\*(R".

This command depends on the feature \f(CW`journal\*(C'.   See also
feature-available\*(R".

<a name="journal-get-realtime-usec"></a>

### journal-get-realtime-usec

.IX Subsection "journal-get-realtime-usec"
.Vb 1
 journal-get-realtime-usec
.Ve

Get the realtime (wallclock) timestamp of the current journal entry.

This command depends on the feature \f(CW`journal\*(C'.   See also
feature-available\*(R".

<a name="journal-next"></a>

### journal-next

.IX Subsection "journal-next"
.Vb 1
 journal-next
.Ve

Move to the next journal entry.  You have to call this
at least once after opening the handle before you are able
to read data.

The returned boolean tells you if there are any more journal
records to read.  \f(CW`true\*(C' means you can read the next record
(eg. using journal-get\*(R"), and \f(CW\*(C\`false\*(C' means you
have reached the end of the journal.

This command depends on the feature \f(CW`journal\*(C'.   See also
feature-available\*(R".

<a name="journal-open"></a>

### journal-open

.IX Subsection "journal-open"
.Vb 1
 journal-open directory
.Ve

Open the systemd journal located in _directory_.  Any previously
opened journal handle is closed.

The contents of the journal can be read using journal-next\*(R"
and journal-get\*(R".

After you have finished using the journal, you should close the
handle by calling journal-close\*(R".

This command depends on the feature \f(CW`journal\*(C'.   See also
feature-available\*(R".

<a name="journal-set-data-threshold"></a>

### journal-set-data-threshold

.IX Subsection "journal-set-data-threshold"
.Vb 1
 journal-set-data-threshold threshold
.Ve

Set the data threshold for reading journal entries.
This is a hint to the journal that it may truncate data fields to
this size when reading them (note also that it may not truncate them).
If you set this to \f(CW0, then the threshold is unlimited.

See also journal-get-data-threshold\*(R".

This command depends on the feature \f(CW`journal\*(C'.   See also
feature-available\*(R".

<a name="journal-skip"></a>

### journal-skip

.IX Subsection "journal-skip"
.Vb 1
 journal-skip skip
.Ve

Skip forwards (\f(CW`skip ≥ 0\*(C') or backwards (\f(CW\*(C\`skip &lt; 0\*(C') in the
journal.

The number of entries actually skipped is returned (note \f(CW`rskip ≥ 0\*(C').
If this is not the same as the absolute value of the skip parameter
(\f(CW`|skip|\*(C') you passed in then it means you have reached the end or
the start of the journal.

This command depends on the feature \f(CW`journal\*(C'.   See also
feature-available\*(R".

<a name="kill-subprocess"></a>

### kill-subprocess

.IX Subsection "kill-subprocess"
.Vb 1
 kill-subprocess
.Ve

This kills the hypervisor.

Do not call this.  See: shutdown\*(R" instead.

_This function is deprecated._
In new code, use the shutdown\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="launch"></a>

### launch

.IX Subsection "launch"

<a name="run"></a>

### run

.IX Subsection "run"
.Vb 1
 launch
.Ve

You should call this after configuring the handle
(eg. adding drives) but before performing any actions.

Do not call launch\*(R" twice on the same handle.  Although
it will not give an error (for historical reasons), the precise
behaviour when you do this is not well defined.  Handles are
very cheap to create, so create a new one for each launch.

<a name="lchown"></a>

### lchown

.IX Subsection "lchown"
.Vb 1
 lchown owner group path
.Ve

Change the file owner to \f(CW`owner\*(C' and group to \f(CW\*(C\`group\*(C'.
This is like chown\*(R" but if \f(CW\*(C\`path\*(C' is a symlink then
the link itself is changed, not the target.

Only numeric uid and gid are supported.  If you want to use
names, you will need to locate and parse the password file
yourself (Augeas support makes this relatively easy).

<a name="ldmtool-create-all"></a>

### ldmtool-create-all

.IX Subsection "ldmtool-create-all"
.Vb 1
 ldmtool-create-all
.Ve

This function scans all block devices looking for Windows
dynamic disk volumes and partitions, and creates devices
for any that were found.

Call list-ldm-volumes\*(R" and \*(L"list-ldm-partitions\*(R"
to return all devices.

Note that you **don't** normally need to call this explicitly,
since it is done automatically at launch\*(R" time.
However you might want to call this function if you have
hotplugged disks or have just created a Windows dynamic disk.

This command depends on the feature \f(CW`ldm\*(C'.   See also
feature-available\*(R".

<a name="ldmtool-diskgroup-disks"></a>

### ldmtool-diskgroup-disks

.IX Subsection "ldmtool-diskgroup-disks"
.Vb 1
 ldmtool-diskgroup-disks diskgroup
.Ve

Return the disks in a Windows dynamic disk group.  The \f(CW`diskgroup\*(C'
parameter should be the \s-1GUID\s0 of a disk group, one element from
the list returned by ldmtool-scan\*(R".

This command depends on the feature \f(CW`ldm\*(C'.   See also
feature-available\*(R".

<a name="ldmtool-diskgroup-name"></a>

### ldmtool-diskgroup-name

.IX Subsection "ldmtool-diskgroup-name"
.Vb 1
 ldmtool-diskgroup-name diskgroup
.Ve

Return the name of a Windows dynamic disk group.  The \f(CW`diskgroup\*(C'
parameter should be the \s-1GUID\s0 of a disk group, one element from
the list returned by ldmtool-scan\*(R".

This command depends on the feature \f(CW`ldm\*(C'.   See also
feature-available\*(R".

<a name="ldmtool-diskgroup-volumes"></a>

### ldmtool-diskgroup-volumes

.IX Subsection "ldmtool-diskgroup-volumes"
.Vb 1
 ldmtool-diskgroup-volumes diskgroup
.Ve

Return the volumes in a Windows dynamic disk group.  The \f(CW`diskgroup\*(C'
parameter should be the \s-1GUID\s0 of a disk group, one element from
the list returned by ldmtool-scan\*(R".

This command depends on the feature \f(CW`ldm\*(C'.   See also
feature-available\*(R".

<a name="ldmtool-remove-all"></a>

### ldmtool-remove-all

.IX Subsection "ldmtool-remove-all"
.Vb 1
 ldmtool-remove-all
.Ve

This is essentially the opposite of ldmtool-create-all\*(R".
It removes the device mapper mappings for all Windows dynamic disk
volumes

This command depends on the feature \f(CW`ldm\*(C'.   See also
feature-available\*(R".

<a name="ldmtool-scan"></a>

### ldmtool-scan

.IX Subsection "ldmtool-scan"
.Vb 1
 ldmtool-scan
.Ve

This function scans for Windows dynamic disks.  It returns a list
of identifiers (GUIDs) for all disk groups that were found.  These
identifiers can be passed to other ldmtool-*\*(R" functions.

This function scans all block devices.  To scan a subset of
block devices, call ldmtool-scan-devices\*(R" instead.

This command depends on the feature \f(CW`ldm\*(C'.   See also
feature-available\*(R".

<a name="ldmtool-scan-devices"></a>

### ldmtool-scan-devices

.IX Subsection "ldmtool-scan-devices"
.Vb 1
 ldmtool-scan-devices devices ...\*(Aq
.Ve

This function scans for Windows dynamic disks.  It returns a list
of identifiers (GUIDs) for all disk groups that were found.  These
identifiers can be passed to other ldmtool-*\*(R" functions.

The parameter \f(CW`devices\*(C' is a list of block devices which are
scanned.  If this list is empty, all block devices are scanned.

This command depends on the feature \f(CW`ldm\*(C'.   See also
feature-available\*(R".

<a name="ldmtool-volume-hint"></a>

### ldmtool-volume-hint

.IX Subsection "ldmtool-volume-hint"
.Vb 1
 ldmtool-volume-hint diskgroup volume
.Ve

Return the hint field of the volume named \f(CW`volume\*(C' in the disk
group with \s-1GUID\s0 \f(CW`diskgroup\*(C'.  This may not be defined, in which
case the empty string is returned.  The hint field is often, though
not always, the name of a Windows drive, eg. \f(CW`E:\*(C'.

This command depends on the feature \f(CW`ldm\*(C'.   See also
feature-available\*(R".

<a name="ldmtool-volume-partitions"></a>

### ldmtool-volume-partitions

.IX Subsection "ldmtool-volume-partitions"
.Vb 1
 ldmtool-volume-partitions diskgroup volume
.Ve

Return the list of partitions in the volume named \f(CW`volume\*(C' in the disk
group with \s-1GUID\s0 \f(CW`diskgroup\*(C'.

This command depends on the feature \f(CW`ldm\*(C'.   See also
feature-available\*(R".

<a name="ldmtool-volume-type"></a>

### ldmtool-volume-type

.IX Subsection "ldmtool-volume-type"
.Vb 1
 ldmtool-volume-type diskgroup volume
.Ve

Return the type of the volume named \f(CW`volume\*(C' in the disk
group with \s-1GUID\s0 \f(CW`diskgroup\*(C'.

Possible volume types that can be returned here include:
\f(CW`simple\*(C', \f(CW\*(C\`spanned\*(C', \f(CW\*(C\`striped\*(C', \f(CW\*(C\`mirrored\*(C', \f(CW\*(C\`raid5\*(C'.
Other types may also be returned.

This command depends on the feature \f(CW`ldm\*(C'.   See also
feature-available\*(R".

<a name="lgetxattr"></a>

### lgetxattr

.IX Subsection "lgetxattr"
.Vb 1
 lgetxattr path name
.Ve

Get a single extended attribute from file \f(CW`path\*(C' named \f(CW\*(C\`name\*(C'.
If \f(CW`path\*(C' is a symlink, then this call returns an extended
attribute from the symlink.

Normally it is better to get all extended attributes from a file
in one go by calling getxattrs\*(R".  However some Linux
filesystem implementations are buggy and do not provide a way to
list out attributes.  For these filesystems (notably ntfs-3g)
you have to know the names of the extended attributes you want
in advance and call this function.

Extended attribute values are blobs of binary data.  If there
is no extended attribute named \f(CW`name\*(C', this returns an error.

See also: lgetxattrs\*(R", \*(L"getxattr\*(R", **attr**\|(5).

This command depends on the feature \f(CW`linuxxattrs\*(C'.   See also
feature-available\*(R".

<a name="lgetxattrs"></a>

### lgetxattrs

.IX Subsection "lgetxattrs"
.Vb 1
 lgetxattrs path
.Ve

This is the same as getxattrs\*(R", but if \f(CW\*(C\`path\*(C'
is a symbolic link, then it returns the extended attributes
of the link itself.

This command depends on the feature \f(CW`linuxxattrs\*(C'.   See also
feature-available\*(R".

<a name="list-9p"></a>

### list\-9p

.IX Subsection "list-9p"
.Vb 1
 list-9p
.Ve

List all 9p filesystems attached to the guest.  A list of
mount tags is returned.

<a name="list-devices"></a>

### list-devices

.IX Subsection "list-devices"
.Vb 1
 list-devices
.Ve

List all the block devices.

The full block device names are returned, eg. _/dev/sda_.

See also list-filesystems\*(R".

<a name="list-disk-labels"></a>

### list-disk-labels

.IX Subsection "list-disk-labels"
.Vb 1
 list-disk-labels
.Ve

If you add drives using the optional \f(CW`label\*(C' parameter
of add-drive-opts\*(R", you can use this call to
map between disk labels, and raw block device and partition
names (like _/dev/sda_ and _/dev/sda1_).

This returns a hashtable, where keys are the disk labels
(_without_ the _/dev/disk/guestfs_ prefix), and the values
are the full raw block device and partition names
(eg. _/dev/sda_ and _/dev/sda1_).

<a name="list-dm-devices"></a>

### list-dm-devices

.IX Subsection "list-dm-devices"
.Vb 1
 list-dm-devices
.Ve

List all device mapper devices.

The returned list contains _/dev/mapper/*_ devices, eg. ones created
by a previous call to luks-open\*(R".

Device mapper devices which correspond to logical volumes are _not_
returned in this list.  Call lvs\*(R" if you want to list logical
volumes.

<a name="list-filesystems"></a>

### list-filesystems

.IX Subsection "list-filesystems"
.Vb 1
 list-filesystems
.Ve

This inspection command looks for filesystems on partitions,
block devices and logical volumes, returning a list of \f(CW`mountables\*(C'
containing filesystems and their type.

The return value is a hash, where the keys are the devices
containing filesystems, and the values are the filesystem types.
For example:

.Vb 4
 "/dev/sda1" =&gt; "ntfs"
 "/dev/sda2" =&gt; "ext2"
 "/dev/vg_guest/lv_root" =&gt; "ext4"
 "/dev/vg_guest/lv_swap" =&gt; "swap"
.Ve

The key is not necessarily a block device. It may also be an opaque
‘mountable’ string which can be passed to mount\*(R".

The value can have the special value unknown\*(R", meaning the
content of the device is undetermined or empty.
swap\*(R" means a Linux swap partition.

In libguestfs ≤ 1.36 this command ran other libguestfs commands,
which might have included mount\*(R" and \*(L"umount\*(R", and
therefore you had to use this soon after launch and only when
nothing else was mounted.  This restriction is removed in libguestfs
≥ 1.38.

Not all of the filesystems returned will be mountable.  In
particular, swap partitions are returned in the list.  Also
this command does not check that each filesystem
found is valid and mountable, and some filesystems might
be mountable but require special options.  Filesystems may
not all belong to a single logical operating system
(use inspect-os\*(R" to look for OSes).

<a name="list-ldm-partitions"></a>

### list-ldm-partitions

.IX Subsection "list-ldm-partitions"
.Vb 1
 list-ldm-partitions
.Ve

This function returns all Windows dynamic disk partitions
that were found at launch time.  It returns a list of
device names.

This command depends on the feature \f(CW`ldm\*(C'.   See also
feature-available\*(R".

<a name="list-ldm-volumes"></a>

### list-ldm-volumes

.IX Subsection "list-ldm-volumes"
.Vb 1
 list-ldm-volumes
.Ve

This function returns all Windows dynamic disk volumes
that were found at launch time.  It returns a list of
device names.

This command depends on the feature \f(CW`ldm\*(C'.   See also
feature-available\*(R".

<a name="list-md-devices"></a>

### list-md-devices

.IX Subsection "list-md-devices"
.Vb 1
 list-md-devices
.Ve

List all Linux md devices.

<a name="list-partitions"></a>

### list-partitions

.IX Subsection "list-partitions"
.Vb 1
 list-partitions
.Ve

List all the partitions detected on all block devices.

The full partition device names are returned, eg. _/dev/sda1_

This does not return logical volumes.  For that you will need to
call lvs\*(R".

See also list-filesystems\*(R".

<a name="ll"></a>

### ll

.IX Subsection "ll"
.Vb 1
 ll directory
.Ve

List the files in _directory_ (relative to the root directory,
there is no cwd) in the format of 'ls -la'.

This command is mostly useful for interactive sessions.  It
is _not_ intended that you try to parse the output string.

<a name="llz"></a>

### llz

.IX Subsection "llz"
.Vb 1
 llz directory
.Ve

List the files in _directory_ in the format of 'ls -laZ'.

This command is mostly useful for interactive sessions.  It
is _not_ intended that you try to parse the output string.

_This function is deprecated._
In new code, use the lgetxattrs\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="ln"></a>

### ln

.IX Subsection "ln"
.Vb 1
 ln target linkname
.Ve

This command creates a hard link using the \f(CW`ln\*(C' command.

<a name="ln-f"></a>

### ln-f

.IX Subsection "ln-f"
.Vb 1
 ln-f target linkname
.Ve

This command creates a hard link using the \f(CW`ln -f\*(C' command.
The _-f_ option removes the link (\f(CW`linkname\*(C') if it exists already.

<a name="ln-s"></a>

### ln-s

.IX Subsection "ln-s"
.Vb 1
 ln-s target linkname
.Ve

This command creates a symbolic link using the \f(CW`ln -s\*(C' command.

<a name="ln-sf"></a>

### ln-sf

.IX Subsection "ln-sf"
.Vb 1
 ln-sf target linkname
.Ve

This command creates a symbolic link using the \f(CW`ln -sf\*(C' command,
The _-f_ option removes the link (\f(CW`linkname\*(C') if it exists already.

<a name="lremovexattr"></a>

### lremovexattr

.IX Subsection "lremovexattr"
.Vb 1
 lremovexattr xattr path
.Ve

This is the same as removexattr\*(R", but if \f(CW\*(C\`path\*(C'
is a symbolic link, then it removes an extended attribute
of the link itself.

This command depends on the feature \f(CW`linuxxattrs\*(C'.   See also
feature-available\*(R".

<a name="ls"></a>

### ls

.IX Subsection "ls"
.Vb 1
 ls directory
.Ve

List the files in _directory_ (relative to the root directory,
there is no cwd).  The '.' and '..' entries are not returned, but
hidden files are shown.

<a name="ls0"></a>

### ls0

.IX Subsection "ls0"
.Vb 1
 ls0 dir (filenames|-)
.Ve

This specialized command is used to get a listing of
the filenames in the directory \f(CW`dir\*(C'.  The list of filenames
is written to the local file _filenames_ (on the host).

In the output file, the filenames are separated by \f(CW`\e0\*(C' characters.

\f(CW`.\*(C' and \f(CW\*(C\`..\*(C' are not returned.  The filenames are not sorted.

Use \f(CW`-\*(C' instead of a filename to read/write from stdin/stdout.

<a name="lsetxattr"></a>

### lsetxattr

.IX Subsection "lsetxattr"
.Vb 1
 lsetxattr xattr val vallen path
.Ve

This is the same as setxattr\*(R", but if \f(CW\*(C\`path\*(C'
is a symbolic link, then it sets an extended attribute
of the link itself.

This command depends on the feature \f(CW`linuxxattrs\*(C'.   See also
feature-available\*(R".

<a name="lstat"></a>

### lstat

.IX Subsection "lstat"
.Vb 1
 lstat path
.Ve

Returns file information for the given \f(CW`path\*(C'.

This is the same as stat\*(R" except that if \f(CW\*(C\`path\*(C'
is a symbolic link, then the link is stat-ed, not the file it
refers to.

This is the same as the **lstat**\|(2) system call.

_This function is deprecated._
In new code, use the lstatns\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="lstatlist"></a>

### lstatlist

.IX Subsection "lstatlist"
.Vb 1
 lstatlist path names ...\*(Aq
.Ve

This call allows you to perform the lstat\*(R" operation
on multiple files, where all files are in the directory \f(CW`path\*(C'.
\f(CW`names\*(C' is the list of files from this directory.

On return you get a list of stat structs, with a one-to-one
correspondence to the \f(CW`names\*(C' list.  If any name did not exist
or could not be lstat'd, then the \f(CW`st\_ino\*(C' field of that structure
is set to \f(CW`-1\*(C'.

This call is intended for programs that want to efficiently
list a directory contents without making many round-trips.
See also lxattrlist\*(R" for a similarly efficient call
for getting extended attributes.

_This function is deprecated._
In new code, use the lstatnslist\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="lstatns"></a>

### lstatns

.IX Subsection "lstatns"
.Vb 1
 lstatns path
.Ve

Returns file information for the given \f(CW`path\*(C'.

This is the same as statns\*(R" except that if \f(CW\*(C\`path\*(C'
is a symbolic link, then the link is stat-ed, not the file it
refers to.

This is the same as the **lstat**\|(2) system call.

<a name="lstatnslist"></a>

### lstatnslist

.IX Subsection "lstatnslist"
.Vb 1
 lstatnslist path names ...\*(Aq
.Ve

This call allows you to perform the lstatns\*(R" operation
on multiple files, where all files are in the directory \f(CW`path\*(C'.
\f(CW`names\*(C' is the list of files from this directory.

On return you get a list of stat structs, with a one-to-one
correspondence to the \f(CW`names\*(C' list.  If any name did not exist
or could not be lstat'd, then the \f(CW`st\_ino\*(C' field of that structure
is set to \f(CW`-1\*(C'.

This call is intended for programs that want to efficiently
list a directory contents without making many round-trips.
See also lxattrlist\*(R" for a similarly efficient call
for getting extended attributes.

<a name="luks-add-key"></a>

### luks-add-key

.IX Subsection "luks-add-key"
.Vb 1
 luks-add-key device keyslot
.Ve

This command adds a new key on \s-1LUKS\s0 device \f(CW`device\*(C'.
\f(CW`key\*(C' is any existing key, and is used to access the device.
\f(CW`newkey\*(C' is the new key to add.  \f(CW\*(C\`keyslot\*(C' is the key slot
that will be replaced.

Note that if \f(CW`keyslot\*(C' already contains a key, then this
command will fail.  You have to use luks-kill-slot\*(R"
first to remove that key.

This command has one or more key or passphrase parameters.
Guestfish will prompt for these separately.

This command depends on the feature \f(CW`luks\*(C'.   See also
feature-available\*(R".

<a name="luks-close"></a>

### luks-close

.IX Subsection "luks-close"
.Vb 1
 luks-close device
.Ve

This closes a \s-1LUKS\s0 device that was created earlier by
luks-open\*(R" or \*(L"luks-open-ro\*(R".  The
\f(CW`device\*(C' parameter must be the name of the \s-1LUKS\s0 mapping
device (ie. _/dev/mapper/mapname_) and _not_ the name
of the underlying block device.

This command depends on the feature \f(CW`luks\*(C'.   See also
feature-available\*(R".

<a name="luks-format"></a>

### luks-format

.IX Subsection "luks-format"
.Vb 1
 luks-format device keyslot
.Ve

This command erases existing data on \f(CW`device\*(C' and formats
the device as a \s-1LUKS\s0 encrypted device.  \f(CW`key\*(C' is the
initial key, which is added to key slot \f(CW`slot\*(C'.  (\s-1LUKS\s0
supports 8 key slots, numbered 0-7).

This command has one or more key or passphrase parameters.
Guestfish will prompt for these separately.

This command depends on the feature \f(CW`luks\*(C'.   See also
feature-available\*(R".

<a name="luks-format-cipher"></a>

### luks-format-cipher

.IX Subsection "luks-format-cipher"
.Vb 1
 luks-format-cipher device keyslot cipher
.Ve

This command is the same as luks-format\*(R" but
it also allows you to set the \f(CW`cipher\*(C' used.

This command has one or more key or passphrase parameters.
Guestfish will prompt for these separately.

This command depends on the feature \f(CW`luks\*(C'.   See also
feature-available\*(R".

<a name="luks-kill-slot"></a>

### luks-kill-slot

.IX Subsection "luks-kill-slot"
.Vb 1
 luks-kill-slot device keyslot
.Ve

This command deletes the key in key slot \f(CW`keyslot\*(C' from the
encrypted \s-1LUKS\s0 device \f(CW`device\*(C'.  \f(CW\*(C\`key\*(C' must be one of the
_other_ keys.

This command has one or more key or passphrase parameters.
Guestfish will prompt for these separately.

This command depends on the feature \f(CW`luks\*(C'.   See also
feature-available\*(R".

<a name="luks-open"></a>

### luks-open

.IX Subsection "luks-open"
.Vb 1
 luks-open device mapname
.Ve

This command opens a block device which has been encrypted
according to the Linux Unified Key Setup (\s-1LUKS\s0) standard.

\f(CW`device\*(C' is the encrypted block device or partition.

The caller must supply one of the keys associated with the
\s-1LUKS\s0 block device, in the \f(CW`key\*(C' parameter.

This creates a new block device called _/dev/mapper/mapname_.
Reads and writes to this block device are decrypted from and
encrypted to the underlying \f(CW`device\*(C' respectively.

If this block device contains \s-1LVM\s0 volume groups, then
calling lvm-scan\*(R" with the \f(CW\*(C\`activate\*(C'
parameter \f(CW`true\*(C' will make them visible.

Use list-dm-devices\*(R" to list all device mapper
devices.

This command has one or more key or passphrase parameters.
Guestfish will prompt for these separately.

This command depends on the feature \f(CW`luks\*(C'.   See also
feature-available\*(R".

<a name="luks-open-ro"></a>

### luks-open-ro

.IX Subsection "luks-open-ro"
.Vb 1
 luks-open-ro device mapname
.Ve

This is the same as luks-open\*(R" except that a read-only
mapping is created.

This command has one or more key or passphrase parameters.
Guestfish will prompt for these separately.

This command depends on the feature \f(CW`luks\*(C'.   See also
feature-available\*(R".

<a name="lvcreate"></a>

### lvcreate

.IX Subsection "lvcreate"
.Vb 1
 lvcreate logvol volgroup mbytes
.Ve

This creates an \s-1LVM\s0 logical volume called \f(CW`logvol\*(C'
on the volume group \f(CW`volgroup\*(C', with \f(CW\*(C\`size\*(C' megabytes.

This command depends on the feature \f(CW`lvm2\*(C'.   See also
feature-available\*(R".

<a name="lvcreate-free"></a>

### lvcreate-free

.IX Subsection "lvcreate-free"
.Vb 1
 lvcreate-free logvol volgroup percent
.Ve

Create an \s-1LVM\s0 logical volume called _/dev/volgroup/logvol_,
using approximately \f(CW`percent\*(C' % of the free space remaining
in the volume group.  Most usefully, when \f(CW`percent\*(C' is \f(CW100
this will create the largest possible \s-1LV.\s0

This command depends on the feature \f(CW`lvm2\*(C'.   See also
feature-available\*(R".

<a name="lvm-canonical-lv-name"></a>

### lvm-canonical-lv-name

.IX Subsection "lvm-canonical-lv-name"
.Vb 1
 lvm-canonical-lv-name lvname
.Ve

This converts alternative naming schemes for LVs that you
might find to the canonical name.  For example, _/dev/mapper/VG-LV_
is converted to _/dev/VG/LV_.

This command returns an error if the \f(CW`lvname\*(C' parameter does
not refer to a logical volume.

See also is-lv\*(R", \*(L"canonical-device-name\*(R".

<a name="lvm-clear-filter"></a>

### lvm-clear-filter

.IX Subsection "lvm-clear-filter"
.Vb 1
 lvm-clear-filter
.Ve

This undoes the effect of lvm-set-filter\*(R".  \s-1LVM\s0
will be able to see every block device.

This command also clears the \s-1LVM\s0 cache and performs a volume
group scan.

<a name="lvm-remove-all"></a>

### lvm-remove-all

.IX Subsection "lvm-remove-all"
.Vb 1
 lvm-remove-all
.Ve

This command removes all \s-1LVM\s0 logical volumes, volume groups
and physical volumes.

This command depends on the feature \f(CW`lvm2\*(C'.   See also
feature-available\*(R".

<a name="lvm-scan"></a>

### lvm-scan

.IX Subsection "lvm-scan"
.Vb 1
 lvm-scan true|false
.Ve

This scans all block devices and rebuilds the list of \s-1LVM\s0
physical volumes, volume groups and logical volumes.

If the \f(CW`activate\*(C' parameter is \f(CW\*(C\`true\*(C' then newly found
volume groups and logical volumes are activated, meaning
the \s-1LV\s0 _/dev/VG/LV_ devices become visible.

When a libguestfs handle is launched it scans for existing
devices, so you do not normally need to use this \s-1API.\s0  However
it is useful when you have added a new device or deleted an
existing device (such as when the luks-open\*(R" \s-1API\s0
is used).

<a name="lvm-set-filter"></a>

### lvm-set-filter

.IX Subsection "lvm-set-filter"
.Vb 1
 lvm-set-filter devices ...\*(Aq
.Ve

This sets the \s-1LVM\s0 device filter so that \s-1LVM\s0 will only be
able to see\*(R" the block devices in the list \f(CW\*(C\`devices\*(C',
and will ignore all other attached block devices.

Where disk image(s) contain duplicate PVs or VGs, this
command is useful to get \s-1LVM\s0 to ignore the duplicates, otherwise
\s-1LVM\s0 can get confused.  Note also there are two types
of duplication possible: either cloned PVs/VGs which have
identical UUIDs; or VGs that are not cloned but just happen
to have the same name.  In normal operation you cannot
create this situation, but you can do it outside \s-1LVM,\s0 eg.
by cloning disk images or by bit twiddling inside the \s-1LVM\s0
metadata.

This command also clears the \s-1LVM\s0 cache and performs a volume
group scan.

You can filter whole block devices or individual partitions.

You cannot use this if any \s-1VG\s0 is currently in use (eg.
contains a mounted filesystem), even if you are not
filtering out that \s-1VG.\s0

This command depends on the feature \f(CW`lvm2\*(C'.   See also
feature-available\*(R".

<a name="lvremove"></a>

### lvremove

.IX Subsection "lvremove"
.Vb 1
 lvremove device
.Ve

Remove an \s-1LVM\s0 logical volume \f(CW`device\*(C', where \f(CW\*(C\`device\*(C' is
the path to the \s-1LV,\s0 such as _/dev/VG/LV_.

You can also remove all LVs in a volume group by specifying
the \s-1VG\s0 name, _/dev/VG_.

This command depends on the feature \f(CW`lvm2\*(C'.   See also
feature-available\*(R".

<a name="lvrename"></a>

### lvrename

.IX Subsection "lvrename"
.Vb 1
 lvrename logvol newlogvol
.Ve

Rename a logical volume \f(CW`logvol\*(C' with the new name \f(CW\*(C\`newlogvol\*(C'.

<a name="lvresize"></a>

### lvresize

.IX Subsection "lvresize"
.Vb 1
 lvresize device mbytes
.Ve

This resizes (expands or shrinks) an existing \s-1LVM\s0 logical
volume to \f(CW`mbytes\*(C'.  When reducing, data in the reduced part
is lost.

This command depends on the feature \f(CW`lvm2\*(C'.   See also
feature-available\*(R".

<a name="lvresize-free"></a>

### lvresize-free

.IX Subsection "lvresize-free"
.Vb 1
 lvresize-free lv percent
.Ve

This expands an existing logical volume \f(CW`lv\*(C' so that it fills
\f(CW`pc\*(C'% of the remaining free space in the volume group.  Commonly
you would call this with pc = 100 which expands the logical volume
as much as possible, using all remaining free space in the volume
group.

This command depends on the feature \f(CW`lvm2\*(C'.   See also
feature-available\*(R".

<a name="lvs"></a>

### lvs

.IX Subsection "lvs"
.Vb 1
 lvs
.Ve

List all the logical volumes detected.  This is the equivalent
of the **lvs**\|(8) command.

This returns a list of the logical volume device names
(eg. _/dev/VolGroup00/LogVol00_).

See also lvs-full\*(R", \*(L"list-filesystems\*(R".

This command depends on the feature \f(CW`lvm2\*(C'.   See also
feature-available\*(R".

<a name="lvs-full"></a>

### lvs-full

.IX Subsection "lvs-full"
.Vb 1
 lvs-full
.Ve

List all the logical volumes detected.  This is the equivalent
of the **lvs**\|(8) command.  The full\*(R" version includes all fields.

This command depends on the feature \f(CW`lvm2\*(C'.   See also
feature-available\*(R".

<a name="lvuuid"></a>

### lvuuid

.IX Subsection "lvuuid"
.Vb 1
 lvuuid device
.Ve

This command returns the \s-1UUID\s0 of the \s-1LVM LV\s0 \f(CW`device\*(C'.

<a name="lxattrlist"></a>

### lxattrlist

.IX Subsection "lxattrlist"
.Vb 1
 lxattrlist path names ...\*(Aq
.Ve

This call allows you to get the extended attributes
of multiple files, where all files are in the directory \f(CW`path\*(C'.
\f(CW`names\*(C' is the list of files from this directory.

On return you get a flat list of xattr structs which must be
interpreted sequentially.  The first xattr struct always has a zero-length
\f(CW`attrname\*(C'.  \f(CW\*(C\`attrval\*(C' in this struct is zero-length
to indicate there was an error doing \f(CW`lgetxattr\*(C' for this
file, _or_ is a C string which is a decimal number
(the number of following attributes for this file, which could
be \f(CW"0").  Then after the first xattr struct are the
zero or more attributes for the first named file.
This repeats for the second and subsequent files.

This call is intended for programs that want to efficiently
list a directory contents without making many round-trips.
See also lstatlist\*(R" for a similarly efficient call
for getting standard stats.

This command depends on the feature \f(CW`linuxxattrs\*(C'.   See also
feature-available\*(R".

<a name="max-disks"></a>

### max-disks

.IX Subsection "max-disks"
.Vb 1
 max-disks
.Ve

Return the maximum number of disks that may be added to a
handle (eg. by add-drive-opts\*(R" and similar calls).

This function was added in libguestfs 1.19.7.  In previous
versions of libguestfs the limit was 25.

See \s-1MAXIMUM NUMBER OF DISKS\*(R"\s0 in **guestfs**\|(3) for additional
information on this topic.

<a name="md-create"></a>

### md-create

.IX Subsection "md-create"
.Vb 1
 md-create name devices ...\*(Aq [missingbitmap:N] [nrdevices:N] [spare:N] [chunk:N] [level:..]
.Ve

Create a Linux md (\s-1RAID\s0) device named \f(CW`name\*(C' on the devices
in the list \f(CW`devices\*(C'.

The optional parameters are:
.ie n .IP """missingbitmap""" 4
.el .IP "\f(CWmissingbitmap" 4
.IX Item "missingbitmap"
A bitmap of missing devices.  If a bit is set it means that a
missing device is added to the array.  The least significant bit
corresponds to the first device in the array.
.Sp
As examples:
.Sp
If \f(CW`devices = ["/dev/sda"]\*(C' and \f(CW\*(C\`missingbitmap = 0x1\*(C' then
the resulting array would be \f(CW`[&lt;missing&gt;, "/dev/sda"]\*(C'.
.Sp
If \f(CW`devices = ["/dev/sda"]\*(C' and \f(CW\*(C\`missingbitmap = 0x2\*(C' then
the resulting array would be \f(CW`["/dev/sda", &lt;missing&gt;]\*(C'.
.Sp
This defaults to \f(CW0 (no missing devices).
.Sp
The length of \f(CW`devices\*(C' + the number of bits set in
\f(CW`missingbitmap\*(C' must equal \f(CW\*(C\`nrdevices\*(C' + \f(CW\*(C\`spare\*(C'.
.ie n .IP """nrdevices""" 4
.el .IP "\f(CWnrdevices" 4
.IX Item "nrdevices"
The number of active \s-1RAID\s0 devices.
.Sp
If not set, this defaults to the length of \f(CW`devices\*(C' plus
the number of bits set in \f(CW`missingbitmap\*(C'.
.ie n .IP """spare""" 4
.el .IP "\f(CWspare" 4
.IX Item "spare"
The number of spare devices.
.Sp
If not set, this defaults to \f(CW0.
.ie n .IP """chunk""" 4
.el .IP "\f(CWchunk" 4
.IX Item "chunk"
The chunk size in bytes.
.ie n .IP """level""" 4
.el .IP "\f(CWlevel" 4
.IX Item "level"
The \s-1RAID\s0 level, which can be one of:
_linear_, _raid0_, _0_, _stripe_, _raid1_, _1_, _mirror_,
_raid4_, _4_, _raid5_, _5_, _raid6_, _6_, _raid10_, _10_.
Some of these are synonymous, and more levels may be added in future.
.Sp
If not set, this defaults to \f(CW`raid1\*(C'.

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

This command depends on the feature \f(CW`mdadm\*(C'.   See also
feature-available\*(R".

<a name="md-detail"></a>

### md-detail

.IX Subsection "md-detail"
.Vb 1
 md-detail md
.Ve

This command exposes the output of 'mdadm -DY &lt;md&gt;'.
The following fields are usually present in the returned hash.
Other fields may also be present.
.ie n .IP """level""" 4
.el .IP "\f(CWlevel" 4
.IX Item "level"
The raid level of the \s-1MD\s0 device.
.ie n .IP """devices""" 4
.el .IP "\f(CWdevices" 4
.IX Item "devices"
The number of underlying devices in the \s-1MD\s0 device.
.ie n .IP """metadata""" 4
.el .IP "\f(CWmetadata" 4
.IX Item "metadata"
The metadata version used.
.ie n .IP """uuid""" 4
.el .IP "\f(CWuuid" 4
.IX Item "uuid"
The \s-1UUID\s0 of the \s-1MD\s0 device.
.ie n .IP """name""" 4
.el .IP "\f(CWname" 4
.IX Item "name"
The name of the \s-1MD\s0 device.

This command depends on the feature \f(CW`mdadm\*(C'.   See also
feature-available\*(R".

<a name="md-stat"></a>

### md-stat

.IX Subsection "md-stat"
.Vb 1
 md-stat md
.Ve

This call returns a list of the underlying devices which make
up the single software \s-1RAID\s0 array device \f(CW`md\*(C'.

To get a list of software \s-1RAID\s0 devices, call list-md-devices\*(R".

Each structure returned corresponds to one device along with
additional status information:
.ie n .IP """mdstat_device""" 4
.el .IP "\f(CWmdstat\_device" 4
.IX Item "mdstat_device"
The name of the underlying device.
.ie n .IP """mdstat_index""" 4
.el .IP "\f(CWmdstat\_index" 4
.IX Item "mdstat_index"
The index of this device within the array.
.ie n .IP """mdstat_flags""" 4
.el .IP "\f(CWmdstat\_flags" 4
.IX Item "mdstat_flags"
Flags associated with this device.  This is a string containing
(in no specific order) zero or more of the following flags:
.ie n .IP """W""" 4
.el .IP "\f(CWW" 4
.IX Item "W"
write-mostly
.ie n .IP """F""" 4
.el .IP "\f(CWF" 4
.IX Item "F"
device is faulty
.ie n .IP """S""" 4
.el .IP "\f(CWS" 4
.IX Item "S"
device is a \s-1RAID\s0 spare
.ie n .IP """R""" 4
.el .IP "\f(CWR" 4
.IX Item "R"
replacement

This command depends on the feature \f(CW`mdadm\*(C'.   See also
feature-available\*(R".

<a name="md-stop"></a>

### md-stop

.IX Subsection "md-stop"
.Vb 1
 md-stop md
.Ve

This command deactivates the \s-1MD\s0 array named \f(CW`md\*(C'.  The
device is stopped, but it is not destroyed or zeroed.

This command depends on the feature \f(CW`mdadm\*(C'.   See also
feature-available\*(R".

<a name="mkdir"></a>

### mkdir

.IX Subsection "mkdir"
.Vb 1
 mkdir path
.Ve

Create a directory named \f(CW`path\*(C'.

<a name="mkdir-mode"></a>

### mkdir-mode

.IX Subsection "mkdir-mode"
.Vb 1
 mkdir-mode path mode
.Ve

This command creates a directory, setting the initial permissions
of the directory to \f(CW`mode\*(C'.

For common Linux filesystems, the actual mode which is set will
be \f(CW`mode & ~umask & 01777\*(C'.  Non-native-Linux filesystems may
interpret the mode in other ways.

See also mkdir\*(R", \*(L"umask\*(R"

<a name="mkdir-p"></a>

### mkdir-p

.IX Subsection "mkdir-p"
.Vb 1
 mkdir-p path
.Ve

Create a directory named \f(CW`path\*(C', creating any parent directories
as necessary.  This is like the \f(CW`mkdir -p\*(C' shell command.

<a name="mkdtemp"></a>

### mkdtemp

.IX Subsection "mkdtemp"
.Vb 1
 mkdtemp tmpl
.Ve

This command creates a temporary directory.  The
\f(CW`tmpl\*(C' parameter should be a full pathname for the
temporary directory name with the final six characters being
\s-1XXXXXX\*(R".\s0

For example: /tmp/myprogXXXXXX\*(R" or \*(L"/Temp/myprogXXXXXX\*(R",
the second one being suitable for Windows filesystems.

The name of the temporary directory that was created
is returned.

The temporary directory is created with mode 0700
and is owned by root.

The caller is responsible for deleting the temporary
directory and its contents after use.

See also: **mkdtemp**\|(3)

<a name="mke2fs"></a>

### mke2fs

.IX Subsection "mke2fs"
.Vb 1
 mke2fs device [blockscount:N] [blocksize:N] [fragsize:N] [blockspergroup:N] [numberofgroups:N] [bytesperinode:N] [inodesize:N] [journalsize:N] [numberofinodes:N] [stridesize:N] [stripewidth:N] [maxonlineresize:N] [reservedblockspercentage:N] [mmpupdateinterval:N] [journaldevice:..] [label:..] [lastmounteddir:..] [creatoros:..] [fstype:..] [usagetype:..] [uuid:..] [forcecreate:true|false] [writesbandgrouponly:true|false] [lazyitableinit:true|false] [lazyjournalinit:true|false] [testfs:true|false] [discard:true|false] [quotatype:true|false] [extent:true|false] [filetype:true|false] [flexbg:true|false] [hasjournal:true|false] [journaldev:true|false] [largefile:true|false] [quota:true|false] [resizeinode:true|false] [sparsesuper:true|false] [uninitbg:true|false]
.Ve

\f(CW`mke2fs\*(C' is used to create an ext2, ext3, or ext4 filesystem
on \f(CW`device\*(C'.

The optional \f(CW`blockscount\*(C' is the size of the filesystem in blocks.
If omitted it defaults to the size of \f(CW`device\*(C'.  Note if the
filesystem is too small to contain a journal, \f(CW`mke2fs\*(C' will
silently create an ext2 filesystem instead.

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

<a name="mke2fs-j"></a>

### mke2fs\-J

.IX Subsection "mke2fs-J"
.Vb 1
 mke2fs-J fstype blocksize device journal
.Ve

This creates an ext2/3/4 filesystem on \f(CW`device\*(C' with
an external journal on \f(CW`journal\*(C'.  It is equivalent
to the command:

.Vb 1
 mke2fs -t fstype -b blocksize -J device=&lt;journal&gt; &lt;device&gt;
.Ve

See also mke2journal\*(R".

_This function is deprecated._
In new code, use the mke2fs\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="mke2fs-jl"></a>

### mke2fs\-JL

.IX Subsection "mke2fs-JL"
.Vb 1
 mke2fs-JL fstype blocksize device label
.Ve

This creates an ext2/3/4 filesystem on \f(CW`device\*(C' with
an external journal on the journal labeled \f(CW`label\*(C'.

See also mke2journal-L\*(R".

_This function is deprecated._
In new code, use the mke2fs\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="mke2fs-ju"></a>

### mke2fs\-JU

.IX Subsection "mke2fs-JU"
.Vb 1
 mke2fs-JU fstype blocksize device uuid
.Ve

This creates an ext2/3/4 filesystem on \f(CW`device\*(C' with
an external journal on the journal with \s-1UUID\s0 \f(CW`uuid\*(C'.

See also mke2journal-U\*(R".

_This function is deprecated._
In new code, use the mke2fs\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

This command depends on the feature \f(CW`linuxfsuuid\*(C'.   See also
feature-available\*(R".

<a name="mke2journal"></a>

### mke2journal

.IX Subsection "mke2journal"
.Vb 1
 mke2journal blocksize device
.Ve

This creates an ext2 external journal on \f(CW`device\*(C'.  It is equivalent
to the command:

.Vb 1
 mke2fs -O journal_dev -b blocksize device
.Ve

_This function is deprecated._
In new code, use the mke2fs\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="mke2journal-l"></a>

### mke2journal\-L

.IX Subsection "mke2journal-L"
.Vb 1
 mke2journal-L blocksize label device
.Ve

This creates an ext2 external journal on \f(CW`device\*(C' with label \f(CW\*(C\`label\*(C'.

_This function is deprecated._
In new code, use the mke2fs\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="mke2journal-u"></a>

### mke2journal\-U

.IX Subsection "mke2journal-U"
.Vb 1
 mke2journal-U blocksize uuid device
.Ve

This creates an ext2 external journal on \f(CW`device\*(C' with \s-1UUID\s0 \f(CW\*(C\`uuid\*(C'.

_This function is deprecated._
In new code, use the mke2fs\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

This command depends on the feature \f(CW`linuxfsuuid\*(C'.   See also
feature-available\*(R".

<a name="mkfifo"></a>

### mkfifo

.IX Subsection "mkfifo"
.Vb 1
 mkfifo mode path
.Ve

This call creates a \s-1FIFO\s0 (named pipe) called \f(CW`path\*(C' with
mode \f(CW`mode\*(C'.  It is just a convenient wrapper around
mknod\*(R".

Unlike with mknod\*(R", \f(CW\*(C\`mode\*(C' **must** contain only permissions
bits.

The mode actually set is affected by the umask.

This command depends on the feature \f(CW`mknod\*(C'.   See also
feature-available\*(R".

<a name="mkfs"></a>

### mkfs

.IX Subsection "mkfs"

<a name="mkfs-opts"></a>

### mkfs-opts

.IX Subsection "mkfs-opts"
.Vb 1
 mkfs fstype device [blocksize:N] [features:..] [inode:N] [sectorsize:N] [label:..]
.Ve

This function creates a filesystem on \f(CW`device\*(C'.  The filesystem
type is \f(CW`fstype\*(C', for example \f(CW\*(C\`ext3\*(C'.

The optional arguments are:
.ie n .IP """blocksize""" 4
.el .IP "\f(CWblocksize" 4
.IX Item "blocksize"
The filesystem block size.  Supported block sizes depend on the
filesystem type, but typically they are \f(CW1024, \f(CW2048 or \f(CW4096
for Linux ext2/3 filesystems.
.Sp
For \s-1VFAT\s0 and \s-1NTFS\s0 the \f(CW`blocksize\*(C' parameter is treated as
the requested cluster size.
.Sp
For \s-1UFS\s0 block sizes, please see **mkfs.ufs**\|(8).
.ie n .IP """features""" 4
.el .IP "\f(CWfeatures" 4
.IX Item "features"
This passes the _-O_ parameter to the external mkfs program.
.Sp
For certain filesystem types, this allows extra filesystem
features to be selected.  See **mke2fs**\|(8) and **mkfs.ufs**\|(8)
for more details.
.Sp
You cannot use this optional parameter with the \f(CW`gfs\*(C' or
\f(CW`gfs2\*(C' filesystem type.
.ie n .IP """inode""" 4
.el .IP "\f(CWinode" 4
.IX Item "inode"
This passes the _-I_ parameter to the external **mke2fs**\|(8) program
which sets the inode size (only for ext2/3/4 filesystems at present).
.ie n .IP """sectorsize""" 4
.el .IP "\f(CWsectorsize" 4
.IX Item "sectorsize"
This passes the _-S_ parameter to external **mkfs.ufs**\|(8) program,
which sets sector size for ufs filesystem.

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

<a name="mkfs-b"></a>

### mkfs-b

.IX Subsection "mkfs-b"
.Vb 1
 mkfs-b fstype blocksize device
.Ve

This call is similar to mkfs\*(R", but it allows you to
control the block size of the resulting filesystem.  Supported
block sizes depend on the filesystem type, but typically they
are \f(CW1024, \f(CW2048 or \f(CW4096 only.

For \s-1VFAT\s0 and \s-1NTFS\s0 the \f(CW`blocksize\*(C' parameter is treated as
the requested cluster size.

_This function is deprecated._
In new code, use the mkfs\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="mkfs-btrfs"></a>

### mkfs-btrfs

.IX Subsection "mkfs-btrfs"
.Vb 1
 mkfs-btrfs devices ...\*(Aq [allocstart:N] [bytecount:N] [datatype:..] [leafsize:N] [label:..] [metadata:..] [nodesize:N] [sectorsize:N]
.Ve

Create a btrfs filesystem, allowing all configurables to be set.
For more information on the optional arguments, see **mkfs.btrfs**\|(8).

Since btrfs filesystems can span multiple devices, this takes a
non-empty list of devices.

To create general filesystems, use mkfs\*(R".

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

This command depends on the feature \f(CW`btrfs\*(C'.   See also
feature-available\*(R".

<a name="mklost-and-found"></a>

### mklost-and-found

.IX Subsection "mklost-and-found"
.Vb 1
 mklost-and-found mountpoint
.Ve

Make the \f(CW`lost+found\*(C' directory, normally in the root directory
of an ext2/3/4 filesystem.  \f(CW`mountpoint\*(C' is the directory under
which we try to create the \f(CW`lost+found\*(C' directory.

<a name="mkmountpoint"></a>

### mkmountpoint

.IX Subsection "mkmountpoint"
.Vb 1
 mkmountpoint exemptpath
.Ve

mkmountpoint\*(R" and \*(L"rmmountpoint\*(R" are
specialized calls that can be used to create extra mountpoints
before mounting the first filesystem.

These calls are _only_ necessary in some very limited circumstances,
mainly the case where you want to mount a mix of unrelated and/or
read-only filesystems together.

For example, live CDs often contain a Russian doll\*(R" nest of
filesystems, an \s-1ISO\s0 outer layer, with a squashfs image inside, with
an ext2/3 image inside that.  You can unpack this as follows
in guestfish:

.Vb 8
 add-ro Fedora-11-i686-Live.iso
 run
 mkmountpoint /cd
 mkmountpoint /sqsh
 mkmountpoint /ext3fs
 mount /dev/sda /cd
 mount-loop /cd/LiveOS/squashfs.img /sqsh
 mount-loop /sqsh/LiveOS/ext3fs.img /ext3fs
.Ve

The inner filesystem is now unpacked under the /ext3fs mountpoint.

mkmountpoint\*(R" is not compatible with \*(L"umount-all\*(R".
You may get unexpected errors if you try to mix these calls.  It is
safest to manually unmount filesystems and remove mountpoints after use.

umount-all\*(R" unmounts filesystems by sorting the paths
longest first, so for this to work for manual mountpoints, you
must ensure that the innermost mountpoints have the longest
pathnames, as in the example code above.

For more details see https://bugzilla.redhat.com/show_bug.cgi?id=599503

Autosync [see set-autosync\*(R", this is set by default on
handles] can cause umount-all\*(R" to be called when the handle
is closed which can also trigger these issues.

<a name="mknod"></a>

### mknod

.IX Subsection "mknod"
.Vb 1
 mknod mode devmajor devminor path
.Ve

This call creates block or character special devices, or
named pipes (FIFOs).

The \f(CW`mode\*(C' parameter should be the mode, using the standard
constants.  \f(CW`devmajor\*(C' and \f(CW\*(C\`devminor\*(C' are the
device major and minor numbers, only used when creating block
and character special devices.

Note that, just like **mknod**\|(2), the mode must be bitwise
\s-1OR\s0'd with S_IFBLK, S_IFCHR, S_IFIFO or S_IFSOCK (otherwise this call
just creates a regular file).  These constants are
available in the standard Linux header files, or you can use
mknod-b\*(R", \*(L"mknod-c\*(R" or \*(L"mkfifo\*(R"
which are wrappers around this command which bitwise \s-1OR\s0
in the appropriate constant for you.

The mode actually set is affected by the umask.

This command depends on the feature \f(CW`mknod\*(C'.   See also
feature-available\*(R".

<a name="mknod-b"></a>

### mknod-b

.IX Subsection "mknod-b"
.Vb 1
 mknod-b mode devmajor devminor path
.Ve

This call creates a block device node called \f(CW`path\*(C' with
mode \f(CW`mode\*(C' and device major/minor \f(CW\*(C\`devmajor\*(C' and \f(CW\*(C\`devminor\*(C'.
It is just a convenient wrapper around mknod\*(R".

Unlike with mknod\*(R", \f(CW\*(C\`mode\*(C' **must** contain only permissions
bits.

The mode actually set is affected by the umask.

This command depends on the feature \f(CW`mknod\*(C'.   See also
feature-available\*(R".

<a name="mknod-c"></a>

### mknod-c

.IX Subsection "mknod-c"
.Vb 1
 mknod-c mode devmajor devminor path
.Ve

This call creates a char device node called \f(CW`path\*(C' with
mode \f(CW`mode\*(C' and device major/minor \f(CW\*(C\`devmajor\*(C' and \f(CW\*(C\`devminor\*(C'.
It is just a convenient wrapper around mknod\*(R".

Unlike with mknod\*(R", \f(CW\*(C\`mode\*(C' **must** contain only permissions
bits.

The mode actually set is affected by the umask.

This command depends on the feature \f(CW`mknod\*(C'.   See also
feature-available\*(R".

<a name="mksquashfs"></a>

### mksquashfs

.IX Subsection "mksquashfs"
.Vb 1
 mksquashfs path (filename|-) [compress:..] [excludes:..]
.Ve

Create a squashfs filesystem for the specified \f(CW`path\*(C'.

The optional \f(CW`compress\*(C' flag controls compression.  If not given,
then the output compressed using \f(CW`gzip\*(C'.  Otherwise one
of the following strings may be given to select the compression
type of the squashfs: \f(CW`gzip\*(C', \f(CW\*(C\`lzma\*(C', \f(CW\*(C\`lzo\*(C', \f(CW\*(C\`lz4\*(C', \f(CW\*(C\`xz\*(C'.

The other optional arguments are:
.ie n .IP """excludes""" 4
.el .IP "\f(CWexcludes" 4
.IX Item "excludes"
A list of wildcards.  Files are excluded if they match any of the
wildcards.

Please note that this \s-1API\s0 may fail when used to compress directories
with large files, such as the resulting squashfs will be over 3GB big.

Use \f(CW`-\*(C' instead of a filename to read/write from stdin/stdout.

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

This command depends on the feature \f(CW`squashfs\*(C'.   See also
feature-available\*(R".

<a name="mkswap"></a>

### mkswap

.IX Subsection "mkswap"

<a name="mkswap-opts"></a>

### mkswap-opts

.IX Subsection "mkswap-opts"
.Vb 1
 mkswap device [label:..] [uuid:..]
.Ve

Create a Linux swap partition on \f(CW`device\*(C'.

The option arguments \f(CW`label\*(C' and \f(CW\*(C\`uuid\*(C' allow you to set the
label and/or \s-1UUID\s0 of the new swap partition.

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

<a name="mkswap-l"></a>

### mkswap-L

.IX Subsection "mkswap-L"
.Vb 1
 mkswap-L label device
.Ve

Create a swap partition on \f(CW`device\*(C' with label \f(CW\*(C\`label\*(C'.

Note that you cannot attach a swap label to a block device
(eg. _/dev/sda_), just to a partition.  This appears to be
a limitation of the kernel or swap tools.

_This function is deprecated._
In new code, use the mkswap\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="mkswap-u"></a>

### mkswap-U

.IX Subsection "mkswap-U"
.Vb 1
 mkswap-U uuid device
.Ve

Create a swap partition on \f(CW`device\*(C' with \s-1UUID\s0 \f(CW\*(C\`uuid\*(C'.

_This function is deprecated._
In new code, use the mkswap\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

This command depends on the feature \f(CW`linuxfsuuid\*(C'.   See also
feature-available\*(R".

<a name="mkswap-file"></a>

### mkswap-file

.IX Subsection "mkswap-file"
.Vb 1
 mkswap-file path
.Ve

Create a swap file.

This command just writes a swap file signature to an existing
file.  To create the file itself, use something like fallocate\*(R".

<a name="mktemp"></a>

### mktemp

.IX Subsection "mktemp"
.Vb 1
 mktemp tmpl [suffix:..]
.Ve

This command creates a temporary file.  The
\f(CW`tmpl\*(C' parameter should be a full pathname for the
temporary directory name with the final six characters being
\s-1XXXXXX\*(R".\s0

For example: /tmp/myprogXXXXXX\*(R" or \*(L"/Temp/myprogXXXXXX\*(R",
the second one being suitable for Windows filesystems.

The name of the temporary file that was created
is returned.

The temporary file is created with mode 0600
and is owned by root.

The caller is responsible for deleting the temporary
file after use.

If the optional \f(CW`suffix\*(C' parameter is given, then the suffix
(eg. \f(CW`.txt\*(C') is appended to the temporary name.

See also: mkdtemp\*(R".

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

<a name="modprobe"></a>

### modprobe

.IX Subsection "modprobe"
.Vb 1
 modprobe modulename
.Ve

This loads a kernel module in the appliance.

This command depends on the feature \f(CW`linuxmodules\*(C'.   See also
feature-available\*(R".

<a name="mount"></a>

### mount

.IX Subsection "mount"
.Vb 1
 mount mountable mountpoint
.Ve

Mount a guest disk at a position in the filesystem.  Block devices
are named _/dev/sda_, _/dev/sdb_ and so on, as they were added to
the guest.  If those block devices contain partitions, they will have
the usual names (eg. _/dev/sda1_).  Also \s-1LVM\s0 _/dev/VG/LV_-style
names can be used, or ‘mountable’ strings returned by
list-filesystems\*(R" or \*(L"inspect-get-mountpoints\*(R".

The rules are the same as for **mount**\|(2):  A filesystem must
first be mounted on _/_ before others can be mounted.  Other
filesystems can only be mounted on directories which already
exist.

The mounted filesystem is writable, if we have sufficient permissions
on the underlying device.

Before libguestfs 1.13.16, this call implicitly added the options
\f(CW`sync\*(C' and \f(CW\*(C\`noatime\*(C'.  The \f(CW\*(C\`sync\*(C' option greatly slowed
writes and caused many problems for users.  If your program
might need to work with older versions of libguestfs, use
mount-options\*(R" instead (using an empty string for the
first parameter if you don't want any options).

<a name="mount-9p"></a>

### mount\-9p

.IX Subsection "mount-9p"
.Vb 1
 mount-9p mounttag mountpoint [options:..]
.Ve

Mount the virtio-9p filesystem with the tag \f(CW`mounttag\*(C' on the
directory \f(CW`mountpoint\*(C'.

If required, \f(CW`trans=virtio\*(C' will be automatically added to the options.
Any other options required can be passed in the optional \f(CW`options\*(C'
parameter.

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

<a name="mount-local"></a>

### mount-local

.IX Subsection "mount-local"
.Vb 1
 mount-local localmountpoint [readonly:true|false] [options:..] [cachetimeout:N] [debugcalls:true|false]
.Ve

This call exports the libguestfs-accessible filesystem to
a local mountpoint (directory) called \f(CW`localmountpoint\*(C'.
Ordinary reads and writes to files and directories under
\f(CW`localmountpoint\*(C' are redirected through libguestfs.

If the optional \f(CW`readonly\*(C' flag is set to true, then
writes to the filesystem return error \f(CW`EROFS\*(C'.

\f(CW`options\*(C' is a comma-separated list of mount options.
See **guestmount**\|(1) for some useful options.

\f(CW`cachetimeout\*(C' sets the timeout (in seconds) for cached directory
entries.  The default is 60 seconds.  See **guestmount**\|(1)
for further information.

If \f(CW`debugcalls\*(C' is set to true, then additional debugging
information is generated for every \s-1FUSE\s0 call.

When mount-local\*(R" returns, the filesystem is ready,
but is not processing requests (access to it will block).  You
have to call mount-local-run\*(R" to run the main loop.

See \s-1MOUNT LOCAL\*(R"\s0 in **guestfs**\|(3) for full documentation.

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

<a name="mount-local-run"></a>

### mount-local-run

.IX Subsection "mount-local-run"
.Vb 1
 mount-local-run
.Ve

Run the main loop which translates kernel calls to libguestfs
calls.

This should only be called after mount-local\*(R"
returns successfully.  The call will not return until the
filesystem is unmounted.

**Note** you must _not_ make concurrent libguestfs calls
on the same handle from another thread.

You may call this from a different thread than the one which
called mount-local\*(R", subject to the usual rules
for threads and libguestfs (see
\s-1MULTIPLE HANDLES AND MULTIPLE THREADS\*(R"\s0 in **guestfs**\|(3)).

See \s-1MOUNT LOCAL\*(R"\s0 in **guestfs**\|(3) for full documentation.

<a name="mount-loop"></a>

### mount-loop

.IX Subsection "mount-loop"
.Vb 1
 mount-loop file mountpoint
.Ve

This command lets you mount _file_ (a filesystem image
in a file) on a mount point.  It is entirely equivalent to
the command \f(CW`mount -o loop file mountpoint\*(C'.

<a name="mount-options"></a>

### mount-options

.IX Subsection "mount-options"
.Vb 1
 mount-options options mountable mountpoint
.Ve

This is the same as the mount\*(R" command, but it
allows you to set the mount options as for the
**mount**\|(8) _-o_ flag.

If the \f(CW`options\*(C' parameter is an empty string, then
no options are passed (all options default to whatever
the filesystem uses).

<a name="mount-ro"></a>

### mount-ro

.IX Subsection "mount-ro"
.Vb 1
 mount-ro mountable mountpoint
.Ve

This is the same as the mount\*(R" command, but it
mounts the filesystem with the read-only (_-o ro_) flag.

<a name="mount-vfs"></a>

### mount-vfs

.IX Subsection "mount-vfs"
.Vb 1
 mount-vfs options vfstype mountable mountpoint
.Ve

This is the same as the mount\*(R" command, but it
allows you to set both the mount options and the vfstype
as for the **mount**\|(8) _-o_ and _-t_ flags.

<a name="mountable-device"></a>

### mountable-device

.IX Subsection "mountable-device"
.Vb 1
 mountable-device mountable
.Ve

Returns the device name of a mountable. In quite a lot of
cases, the mountable is the device name.

However this doesn't apply for btrfs subvolumes, where the
mountable is a combination of both the device name and the
subvolume path (see also mountable-subvolume\*(R" to
extract the subvolume path of the mountable if any).

<a name="mountable-subvolume"></a>

### mountable-subvolume

.IX Subsection "mountable-subvolume"
.Vb 1
 mountable-subvolume mountable
.Ve

Returns the subvolume path of a mountable. Btrfs subvolumes
mountables are a combination of both the device name and the
subvolume path (see also mountable-device\*(R" to extract
the device of the mountable).

If the mountable does not represent a btrfs subvolume, then
this function fails and the \f(CW`errno\*(C' is set to \f(CW\*(C\`EINVAL\*(C'.

<a name="mountpoints"></a>

### mountpoints

.IX Subsection "mountpoints"
.Vb 1
 mountpoints
.Ve

This call is similar to mounts\*(R".  That call returns
a list of devices.  This one returns a hash table (map) of
device name to directory where the device is mounted.

<a name="mounts"></a>

### mounts

.IX Subsection "mounts"
.Vb 1
 mounts
.Ve

This returns the list of currently mounted filesystems.  It returns
the list of devices (eg. _/dev/sda1_, _/dev/VG/LV_).

Some internal mounts are not shown.

See also: mountpoints\*(R"

<a name="mv"></a>

### mv

.IX Subsection "mv"
.Vb 1
 mv src dest
.Ve

This moves a file from \f(CW`src\*(C' to \f(CW\*(C\`dest\*(C' where \f(CW\*(C\`dest\*(C' is
either a destination filename or destination directory.

See also: rename\*(R".

<a name="nr-devices"></a>

### nr-devices

.IX Subsection "nr-devices"
.Vb 1
 nr-devices
.Ve

This returns the number of whole block devices that were
added.  This is the same as the number of devices that would
be returned if you called list-devices\*(R".

To find out the maximum number of devices that could be added,
call max-disks\*(R".

<a name="ntfs-3g-probe"></a>

### ntfs\-3g\-probe

.IX Subsection "ntfs-3g-probe"
.Vb 1
 ntfs-3g-probe true|false device
.Ve

This command runs the **ntfs-3g.probe**\|(8) command which probes
an \s-1NTFS\s0 \f(CW`device\*(C' for mountability.  (Not all \s-1NTFS\s0 volumes can
be mounted read-write, and some cannot be mounted at all).

\f(CW`rw\*(C' is a boolean flag.  Set it to true if you want to test
if the volume can be mounted read-write.  Set it to false if
you want to test if the volume can be mounted read-only.

The return value is an integer which \f(CW0 if the operation
would succeed, or some non-zero value documented in the
**ntfs-3g.probe**\|(8) manual page.

This command depends on the feature \f(CW`ntfs3g\*(C'.   See also
feature-available\*(R".

<a name="ntfscat-i"></a>

### ntfscat-i

.IX Subsection "ntfscat-i"
.Vb 1
 ntfscat-i device inode (filename|-)
.Ve

Download a file given its inode from a \s-1NTFS\s0 filesystem and save it as
_filename_ on the local machine.

This allows to download some otherwise inaccessible files such as the ones
within the \f(CW$Extend folder.

The filesystem from which to extract the file must be unmounted,
otherwise the call will fail.

Use \f(CW`-\*(C' instead of a filename to read/write from stdin/stdout.

<a name="ntfsclone-in"></a>

### ntfsclone-in

.IX Subsection "ntfsclone-in"
.Vb 1
 ntfsclone-in (backupfile|-) device
.Ve

Restore the \f(CW`backupfile\*(C' (from a previous call to
ntfsclone-out\*(R") to \f(CW\*(C\`device\*(C', overwriting
any existing contents of this device.

Use \f(CW`-\*(C' instead of a filename to read/write from stdin/stdout.

This command depends on the feature \f(CW`ntfs3g\*(C'.   See also
feature-available\*(R".

<a name="ntfsclone-out"></a>

### ntfsclone-out

.IX Subsection "ntfsclone-out"
.Vb 1
 ntfsclone-out device (backupfile|-) [metadataonly:true|false] [rescue:true|false] [ignorefscheck:true|false] [preservetimestamps:true|false] [force:true|false]
.Ve

Stream the \s-1NTFS\s0 filesystem \f(CW`device\*(C' to the local file
\f(CW`backupfile\*(C'.  The format used for the backup file is a
special format used by the **ntfsclone**\|(8) tool.

If the optional \f(CW`metadataonly\*(C' flag is true, then _only_ the
metadata is saved, losing all the user data (this is useful
for diagnosing some filesystem problems).

The optional \f(CW`rescue\*(C', \f(CW\*(C\`ignorefscheck\*(C', \f(CW\*(C\`preservetimestamps\*(C'
and \f(CW`force\*(C' flags have precise meanings detailed in the
**ntfsclone**\|(8) man page.

Use ntfsclone-in\*(R" to restore the file back to a
libguestfs device.

Use \f(CW`-\*(C' instead of a filename to read/write from stdin/stdout.

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

This command depends on the feature \f(CW`ntfs3g\*(C'.   See also
feature-available\*(R".

<a name="ntfsfix"></a>

### ntfsfix

.IX Subsection "ntfsfix"
.Vb 1
 ntfsfix device [clearbadsectors:true|false]
.Ve

This command repairs some fundamental \s-1NTFS\s0 inconsistencies,
resets the \s-1NTFS\s0 journal file, and schedules an \s-1NTFS\s0 consistency
check for the first boot into Windows.

This is _not_ an equivalent of Windows \f(CW`chkdsk\*(C'.  It does _not_
scan the filesystem for inconsistencies.

The optional \f(CW`clearbadsectors\*(C' flag clears the list of bad sectors.
This is useful after cloning a disk with bad sectors to a new disk.

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

This command depends on the feature \f(CW`ntfs3g\*(C'.   See also
feature-available\*(R".

<a name="ntfsresize"></a>

### ntfsresize

.IX Subsection "ntfsresize"

<a name="ntfsresize-opts"></a>

### ntfsresize-opts

.IX Subsection "ntfsresize-opts"
.Vb 1
 ntfsresize device [size:N] [force:true|false]
.Ve

This command resizes an \s-1NTFS\s0 filesystem, expanding or
shrinking it to the size of the underlying device.

The optional parameters are:
.ie n .IP """size""" 4
.el .IP "\f(CWsize" 4
.IX Item "size"
The new size (in bytes) of the filesystem.  If omitted, the filesystem
is resized to fit the container (eg. partition).
.ie n .IP """force""" 4
.el .IP "\f(CWforce" 4
.IX Item "force"
If this option is true, then force the resize of the filesystem
even if the filesystem is marked as requiring a consistency check.
.Sp
After the resize operation, the filesystem is always marked
as requiring a consistency check (for safety).  You have to boot
into Windows to perform this check and clear this condition.
If you _don't_ set the \f(CW`force\*(C' option then it is not
possible to call ntfsresize\*(R" multiple times on a
single filesystem without booting into Windows between each resize.

See also **ntfsresize**\|(8).

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

This command depends on the feature \f(CW`ntfsprogs\*(C'.   See also
feature-available\*(R".

<a name="ntfsresize-size"></a>

### ntfsresize-size

.IX Subsection "ntfsresize-size"
.Vb 1
 ntfsresize-size device size
.Ve

This command is the same as ntfsresize\*(R" except that it
allows you to specify the new size (in bytes) explicitly.

_This function is deprecated._
In new code, use the ntfsresize\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

This command depends on the feature \f(CW`ntfsprogs\*(C'.   See also
feature-available\*(R".

<a name="parse-environment"></a>

### parse-environment

.IX Subsection "parse-environment"
.Vb 1
 parse-environment
.Ve

Parse the program’s environment and set flags in the handle
accordingly.  For example if \f(CW`LIBGUESTFS\_DEBUG=1\*(C' then the
‘verbose’ flag is set in the handle.

_Most programs do not need to call this_.  It is done implicitly
when you call create\*(R".

See \s-1ENVIRONMENT VARIABLES\*(R"\s0 in **guestfs**\|(3) for a list of environment
variables that can affect libguestfs handles.  See also
guestfs_create_flags\*(R" in **guestfs**\|(3), and
parse-environment-list\*(R".

<a name="parse-environment-list"></a>

### parse-environment-list

.IX Subsection "parse-environment-list"
.Vb 1
 parse-environment-list environment ...\*(Aq
.Ve

Parse the list of strings in the argument \f(CW`environment\*(C'
and set flags in the handle accordingly.
For example if \f(CW`LIBGUESTFS\_DEBUG=1\*(C' is a string in the list,
then the ‘verbose’ flag is set in the handle.

This is the same as parse-environment\*(R" except that
it parses an explicit list of strings instead of the program's
environment.

<a name="part-add"></a>

### part-add

.IX Subsection "part-add"
.Vb 1
 part-add device prlogex startsect endsect
.Ve

This command adds a partition to \f(CW`device\*(C'.  If there is no partition
table on the device, call part-init\*(R" first.

The \f(CW`prlogex\*(C' parameter is the type of partition.  Normally you
should pass \f(CW`p\*(C' or \f(CW\*(C\`primary\*(C' here, but \s-1MBR\s0 partition tables also
support \f(CW`l\*(C' (or \f(CW\*(C\`logical\*(C') and \f(CW\*(C\`e\*(C' (or \f(CW\*(C\`extended\*(C') partition
types.

\f(CW`startsect\*(C' and \f(CW\*(C\`endsect\*(C' are the start and end of the partition
in _sectors_.  \f(CW`endsect\*(C' may be negative, which means it counts
backwards from the end of the disk (\f(CW`-1\*(C' is the last sector).

Creating a partition which covers the whole disk is not so easy.
Use part-disk\*(R" to do that.

<a name="part-del"></a>

### part-del

.IX Subsection "part-del"
.Vb 1
 part-del device partnum
.Ve

This command deletes the partition numbered \f(CW`partnum\*(C' on \f(CW\*(C\`device\*(C'.

Note that in the case of \s-1MBR\s0 partitioning, deleting an
extended partition also deletes any logical partitions
it contains.

<a name="part-disk"></a>

### part-disk

.IX Subsection "part-disk"
.Vb 1
 part-disk device parttype
.Ve

This command is simply a combination of part-init\*(R"
followed by part-add\*(R" to create a single primary partition
covering the whole disk.

\f(CW`parttype\*(C' is the partition table type, usually \f(CW\*(C\`mbr\*(C' or \f(CW\*(C\`gpt\*(C',
but other possible values are described in part-init\*(R".

<a name="part-expand-gpt"></a>

### part-expand-gpt

.IX Subsection "part-expand-gpt"
.Vb 1
 part-expand-gpt device
.Ve

Move backup \s-1GPT\s0 data structures to the end of the disk.
This is useful in case of in-place image expand
since disk space after backup \s-1GPT\s0 header is not usable.
This is equivalent to \f(CW`sgdisk -e\*(C'.

See also **sgdisk**\|(8).

This command depends on the feature \f(CW`gdisk\*(C'.   See also
feature-available\*(R".

<a name="part-get-bootable"></a>

### part-get-bootable

.IX Subsection "part-get-bootable"
.Vb 1
 part-get-bootable device partnum
.Ve

This command returns true if the partition \f(CW`partnum\*(C' on
\f(CW`device\*(C' has the bootable flag set.

See also part-set-bootable\*(R".

<a name="part-get-disk-guid"></a>

### part-get-disk-guid

.IX Subsection "part-get-disk-guid"
.Vb 1
 part-get-disk-guid device
.Ve

Return the disk identifier (\s-1GUID\s0) of a GPT-partitioned \f(CW`device\*(C'.
Behaviour is undefined for other partition types.

This command depends on the feature \f(CW`gdisk\*(C'.   See also
feature-available\*(R".

<a name="part-get-gpt-attributes"></a>

### part-get-gpt-attributes

.IX Subsection "part-get-gpt-attributes"
.Vb 1
 part-get-gpt-attributes device partnum
.Ve

Return the attribute flags of numbered \s-1GPT\s0 partition \f(CW`partnum\*(C'.
An error is returned for \s-1MBR\s0 partitions.

This command depends on the feature \f(CW`gdisk\*(C'.   See also
feature-available\*(R".

<a name="part-get-gpt-guid"></a>

### part-get-gpt-guid

.IX Subsection "part-get-gpt-guid"
.Vb 1
 part-get-gpt-guid device partnum
.Ve

Return the \s-1GUID\s0 of numbered \s-1GPT\s0 partition \f(CW`partnum\*(C'.

This command depends on the feature \f(CW`gdisk\*(C'.   See also
feature-available\*(R".

<a name="part-get-gpt-type"></a>

### part-get-gpt-type

.IX Subsection "part-get-gpt-type"
.Vb 1
 part-get-gpt-type device partnum
.Ve

Return the type \s-1GUID\s0 of numbered \s-1GPT\s0 partition \f(CW`partnum\*(C'. For \s-1MBR\s0 partitions,
return an appropriate \s-1GUID\s0 corresponding to the \s-1MBR\s0 type. Behaviour is undefined
for other partition types.

This command depends on the feature \f(CW`gdisk\*(C'.   See also
feature-available\*(R".

<a name="part-get-mbr-id"></a>

### part-get-mbr-id

.IX Subsection "part-get-mbr-id"
.Vb 1
 part-get-mbr-id device partnum
.Ve

Returns the \s-1MBR\s0 type byte (also known as the \s-1ID\s0 byte) from
the numbered partition \f(CW`partnum\*(C'.

Note that only \s-1MBR\s0 (old DOS-style) partitions have type bytes.
You will get undefined results for other partition table
types (see part-get-parttype\*(R").

<a name="part-get-mbr-part-type"></a>

### part-get-mbr-part-type

.IX Subsection "part-get-mbr-part-type"
.Vb 1
 part-get-mbr-part-type device partnum
.Ve

This returns the partition type of an \s-1MBR\s0 partition
numbered \f(CW`partnum\*(C' on device \f(CW\*(C\`device\*(C'.

It returns \f(CW`primary\*(C', \f(CW\*(C\`logical\*(C', or \f(CW\*(C\`extended\*(C'.

<a name="part-get-name"></a>

### part-get-name

.IX Subsection "part-get-name"
.Vb 1
 part-get-name device partnum
.Ve

This gets the partition name on partition numbered \f(CW`partnum\*(C' on
device \f(CW`device\*(C'.  Note that partitions are numbered from 1.

The partition name can only be read on certain types of partition
table.  This works on \f(CW`gpt\*(C' but not on \f(CW\*(C\`mbr\*(C' partitions.

<a name="part-get-parttype"></a>

### part-get-parttype

.IX Subsection "part-get-parttype"
.Vb 1
 part-get-parttype device
.Ve

This command examines the partition table on \f(CW`device\*(C' and
returns the partition table type (format) being used.

Common return values include: \f(CW`msdos\*(C' (a DOS/Windows style \s-1MBR\s0
partition table), \f(CW`gpt\*(C' (a GPT/EFI-style partition table).  Other
values are possible, although unusual.  See part-init\*(R"
for a full list.

<a name="part-init"></a>

### part-init

.IX Subsection "part-init"
.Vb 1
 part-init device parttype
.Ve

This creates an empty partition table on \f(CW`device\*(C' of one of the
partition types listed below.  Usually \f(CW`parttype\*(C' should be
either \f(CW`msdos\*(C' or \f(CW\*(C\`gpt\*(C' (for large disks).

Initially there are no partitions.  Following this, you should
call part-add\*(R" for each partition required.

Possible values for \f(CW`parttype\*(C' are:

* **efi**  
  .IX Item "efi"
* **gpt**  
  .IX Item "gpt"
  Intel \s-1EFI / GPT\s0 partition table.
  .Sp
  This is recommended for &gt;= 2 \s-1TB\s0 partitions that will be accessed
  from Linux and Intel-based Mac \s-1OS X.\s0  It also has limited backwards
  compatibility with the \f(CW`mbr\*(C' format.
* **mbr**  
  .IX Item "mbr"
* **msdos**  
  .IX Item "msdos"
  The standard \s-1PC\s0 Master Boot Record\*(R" (\s-1MBR\s0) format used
  by MS-DOS and Windows.  This partition type will **only** work
  for device sizes up to 2 \s-1TB.\s0  For large disks we recommend
  using \f(CW`gpt\*(C'.

Other partition table types that may work but are not
supported include:

* **aix**  
  .IX Item "aix"
  \s-1AIX\s0 disk labels.
* **amiga**  
  .IX Item "amiga"
* **rdb**  
  .IX Item "rdb"
  Amiga Rigid Disk Block\*(R" format.
* **bsd**  
  .IX Item "bsd"
  \s-1BSD\s0 disk labels.
* **dasd**  
  .IX Item "dasd"
  \s-1DASD,\s0 used on \s-1IBM\s0 mainframes.
* **dvh**  
  .IX Item "dvh"
  \s-1MIPS/SGI\s0 volumes.
* **mac**  
  .IX Item "mac"
  Old Mac partition format.  Modern Macs use \f(CW`gpt\*(C'.
* **pc98**  
  .IX Item "pc98"
  \s-1NEC PC-98\s0 format, common in Japan apparently.
* **sun**  
  .IX Item "sun"
  Sun disk labels.

<a name="part-list"></a>

### part-list

.IX Subsection "part-list"
.Vb 1
 part-list device
.Ve

This command parses the partition table on \f(CW`device\*(C' and
returns the list of partitions found.

The fields in the returned structure are:

* **part\_num**  
  .IX Item "part_num"
  Partition number, counting from 1.
* **part\_start**  
  .IX Item "part_start"
  Start of the partition _in bytes_.  To get sectors you have to
  divide by the device’s sector size, see blockdev-getss\*(R".
* **part\_end**  
  .IX Item "part_end"
  End of the partition in bytes.
* **part\_size**  
  .IX Item "part_size"
  Size of the partition in bytes.

<a name="part-resize"></a>

### part-resize

.IX Subsection "part-resize"
.Vb 1
 part-resize device partnum endsect
.Ve

This command resizes the partition numbered \f(CW`partnum\*(C' on \f(CW\*(C\`device\*(C'
by moving the end position.

Note that this does not modify any filesystem present in the partition.
If you wish to do this, you will need to use filesystem resizing
commands like resize2fs\*(R".

When growing a partition you will want to grow the filesystem
afterwards, but when shrinking, you need to shrink the filesystem
before the partition.

<a name="part-set-bootable"></a>

### part-set-bootable

.IX Subsection "part-set-bootable"
.Vb 1
 part-set-bootable device partnum true|false
.Ve

This sets the bootable flag on partition numbered \f(CW`partnum\*(C' on
device \f(CW`device\*(C'.  Note that partitions are numbered from 1.

The bootable flag is used by some operating systems (notably
Windows) to determine which partition to boot from.  It is by
no means universally recognized.

<a name="part-set-disk-guid"></a>

### part-set-disk-guid

.IX Subsection "part-set-disk-guid"
.Vb 1
 part-set-disk-guid device guid
.Ve

Set the disk identifier (\s-1GUID\s0) of a GPT-partitioned \f(CW`device\*(C' to \f(CW\*(C\`guid\*(C'.
Return an error if the partition table of \f(CW`device\*(C' isn't \s-1GPT,\s0
or if \f(CW`guid\*(C' is not a valid \s-1GUID.\s0

This command depends on the feature \f(CW`gdisk\*(C'.   See also
feature-available\*(R".

<a name="part-set-disk-guid-random"></a>

### part-set-disk-guid-random

.IX Subsection "part-set-disk-guid-random"
.Vb 1
 part-set-disk-guid-random device
.Ve

Set the disk identifier (\s-1GUID\s0) of a GPT-partitioned \f(CW`device\*(C' to
a randomly generated value.
Return an error if the partition table of \f(CW`device\*(C' isn't \s-1GPT.\s0

This command depends on the feature \f(CW`gdisk\*(C'.   See also
feature-available\*(R".

<a name="part-set-gpt-attributes"></a>

### part-set-gpt-attributes

.IX Subsection "part-set-gpt-attributes"
.Vb 1
 part-set-gpt-attributes device partnum attributes
.Ve

Set the attribute flags of numbered \s-1GPT\s0 partition \f(CW`partnum\*(C' to \f(CW\*(C\`attributes\*(C'. Return an
error if the partition table of \f(CW`device\*(C' isn't \s-1GPT.\s0

See https://en.wikipedia.org/wiki/GUID_Partition_Table#Partition_entries
for a useful list of partition attributes.

This command depends on the feature \f(CW`gdisk\*(C'.   See also
feature-available\*(R".

<a name="part-set-gpt-guid"></a>

### part-set-gpt-guid

.IX Subsection "part-set-gpt-guid"
.Vb 1
 part-set-gpt-guid device partnum guid
.Ve

Set the \s-1GUID\s0 of numbered \s-1GPT\s0 partition \f(CW`partnum\*(C' to \f(CW\*(C\`guid\*(C'.  Return an
error if the partition table of \f(CW`device\*(C' isn't \s-1GPT,\s0 or if \f(CW\*(C\`guid\*(C' is not a
valid \s-1GUID.\s0

This command depends on the feature \f(CW`gdisk\*(C'.   See also
feature-available\*(R".

<a name="part-set-gpt-type"></a>

### part-set-gpt-type

.IX Subsection "part-set-gpt-type"
.Vb 1
 part-set-gpt-type device partnum guid
.Ve

Set the type \s-1GUID\s0 of numbered \s-1GPT\s0 partition \f(CW`partnum\*(C' to \f(CW\*(C\`guid\*(C'. Return an
error if the partition table of \f(CW`device\*(C' isn't \s-1GPT,\s0 or if \f(CW\*(C\`guid\*(C' is not a
valid \s-1GUID.\s0

See http://en.wikipedia.org/wiki/GUID_Partition_Table#Partition_type_GUIDs
for a useful list of type GUIDs.

This command depends on the feature \f(CW`gdisk\*(C'.   See also
feature-available\*(R".

<a name="part-set-mbr-id"></a>

### part-set-mbr-id

.IX Subsection "part-set-mbr-id"
.Vb 1
 part-set-mbr-id device partnum idbyte
.Ve

Sets the \s-1MBR\s0 type byte (also known as the \s-1ID\s0 byte) of
the numbered partition \f(CW`partnum\*(C' to \f(CW\*(C\`idbyte\*(C'.  Note
that the type bytes quoted in most documentation are
in fact hexadecimal numbers, but usually documented
without any leading 0x\*(R" which might be confusing.

Note that only \s-1MBR\s0 (old DOS-style) partitions have type bytes.
You will get undefined results for other partition table
types (see part-get-parttype\*(R").

<a name="part-set-name"></a>

### part-set-name

.IX Subsection "part-set-name"
.Vb 1
 part-set-name device partnum name
.Ve

This sets the partition name on partition numbered \f(CW`partnum\*(C' on
device \f(CW`device\*(C'.  Note that partitions are numbered from 1.

The partition name can only be set on certain types of partition
table.  This works on \f(CW`gpt\*(C' but not on \f(CW\*(C\`mbr\*(C' partitions.

<a name="part-to-dev"></a>

### part-to-dev

.IX Subsection "part-to-dev"
.Vb 1
 part-to-dev partition
.Ve

This function takes a partition name (eg. /dev/sdb1\*(R") and
removes the partition number, returning the device name
(eg. /dev/sdb\*(R").

The named partition must exist, for example as a string returned
from list-partitions\*(R".

See also part-to-partnum\*(R", \*(L"device-index\*(R".

<a name="part-to-partnum"></a>

### part-to-partnum

.IX Subsection "part-to-partnum"
.Vb 1
 part-to-partnum partition
.Ve

This function takes a partition name (eg. /dev/sdb1\*(R") and
returns the partition number (eg. \f(CW1).

The named partition must exist, for example as a string returned
from list-partitions\*(R".

See also part-to-dev\*(R".

<a name="ping-daemon"></a>

### ping-daemon

.IX Subsection "ping-daemon"
.Vb 1
 ping-daemon
.Ve

This is a test probe into the guestfs daemon running inside
the libguestfs appliance.  Calling this function checks that the
daemon responds to the ping message, without affecting the daemon
or attached block device(s) in any other way.

<a name="pread"></a>

### pread

.IX Subsection "pread"
.Vb 1
 pread path count offset
.Ve

This command lets you read part of a file.  It reads \f(CW`count\*(C'
bytes of the file, starting at \f(CW`offset\*(C', from file \f(CW\*(C\`path\*(C'.

This may read fewer bytes than requested.  For further details
see the **pread**\|(2) system call.

See also pwrite\*(R", \*(L"pread-device\*(R".

Because of the message protocol, there is a transfer limit
of somewhere between 2MB and 4MB.  See \s-1PROTOCOL LIMITS\*(R"\s0 in **guestfs**\|(3).

<a name="pread-device"></a>

### pread-device

.IX Subsection "pread-device"
.Vb 1
 pread-device device count offset
.Ve

This command lets you read part of a block device.  It reads \f(CW`count\*(C'
bytes of \f(CW`device\*(C', starting at \f(CW\*(C\`offset\*(C'.

This may read fewer bytes than requested.  For further details
see the **pread**\|(2) system call.

See also pread\*(R".

Because of the message protocol, there is a transfer limit
of somewhere between 2MB and 4MB.  See \s-1PROTOCOL LIMITS\*(R"\s0 in **guestfs**\|(3).

<a name="pvchange-uuid"></a>

### pvchange-uuid

.IX Subsection "pvchange-uuid"
.Vb 1
 pvchange-uuid device
.Ve

Generate a new random \s-1UUID\s0 for the physical volume \f(CW`device\*(C'.

This command depends on the feature \f(CW`lvm2\*(C'.   See also
feature-available\*(R".

<a name="pvchange-uuid-all"></a>

### pvchange-uuid-all

.IX Subsection "pvchange-uuid-all"
.Vb 1
 pvchange-uuid-all
.Ve

Generate new random UUIDs for all physical volumes.

This command depends on the feature \f(CW`lvm2\*(C'.   See also
feature-available\*(R".

<a name="pvcreate"></a>

### pvcreate

.IX Subsection "pvcreate"
.Vb 1
 pvcreate device
.Ve

This creates an \s-1LVM\s0 physical volume on the named \f(CW`device\*(C',
where \f(CW`device\*(C' should usually be a partition name such
as _/dev/sda1_.

This command depends on the feature \f(CW`lvm2\*(C'.   See also
feature-available\*(R".

<a name="pvremove"></a>

### pvremove

.IX Subsection "pvremove"
.Vb 1
 pvremove device
.Ve

This wipes a physical volume \f(CW`device\*(C' so that \s-1LVM\s0 will no longer
recognise it.

The implementation uses the \f(CW`pvremove\*(C' command which refuses to
wipe physical volumes that contain any volume groups, so you have
to remove those first.

This command depends on the feature \f(CW`lvm2\*(C'.   See also
feature-available\*(R".

<a name="pvresize"></a>

### pvresize

.IX Subsection "pvresize"
.Vb 1
 pvresize device
.Ve

This resizes (expands or shrinks) an existing \s-1LVM\s0 physical
volume to match the new size of the underlying device.

This command depends on the feature \f(CW`lvm2\*(C'.   See also
feature-available\*(R".

<a name="pvresize-size"></a>

### pvresize-size

.IX Subsection "pvresize-size"
.Vb 1
 pvresize-size device size
.Ve

This command is the same as pvresize\*(R" except that it
allows you to specify the new size (in bytes) explicitly.

This command depends on the feature \f(CW`lvm2\*(C'.   See also
feature-available\*(R".

<a name="pvs"></a>

### pvs

.IX Subsection "pvs"
.Vb 1
 pvs
.Ve

List all the physical volumes detected.  This is the equivalent
of the **pvs**\|(8) command.

This returns a list of just the device names that contain
PVs (eg. _/dev/sda2_).

See also pvs-full\*(R".

This command depends on the feature \f(CW`lvm2\*(C'.   See also
feature-available\*(R".

<a name="pvs-full"></a>

### pvs-full

.IX Subsection "pvs-full"
.Vb 1
 pvs-full
.Ve

List all the physical volumes detected.  This is the equivalent
of the **pvs**\|(8) command.  The full\*(R" version includes all fields.

This command depends on the feature \f(CW`lvm2\*(C'.   See also
feature-available\*(R".

<a name="pvuuid"></a>

### pvuuid

.IX Subsection "pvuuid"
.Vb 1
 pvuuid device
.Ve

This command returns the \s-1UUID\s0 of the \s-1LVM PV\s0 \f(CW`device\*(C'.

<a name="pwrite"></a>

### pwrite

.IX Subsection "pwrite"
.Vb 1
 pwrite path content offset
.Ve

This command writes to part of a file.  It writes the data
buffer \f(CW`content\*(C' to the file \f(CW\*(C\`path\*(C' starting at offset \f(CW\*(C\`offset\*(C'.

This command implements the **pwrite**\|(2) system call, and like
that system call it may not write the full data requested.  The
return value is the number of bytes that were actually written
to the file.  This could even be 0, although short writes are
unlikely for regular files in ordinary circumstances.

See also pread\*(R", \*(L"pwrite-device\*(R".

Because of the message protocol, there is a transfer limit
of somewhere between 2MB and 4MB.  See \s-1PROTOCOL LIMITS\*(R"\s0 in **guestfs**\|(3).

<a name="pwrite-device"></a>

### pwrite-device

.IX Subsection "pwrite-device"
.Vb 1
 pwrite-device device content offset
.Ve

This command writes to part of a device.  It writes the data
buffer \f(CW`content\*(C' to \f(CW\*(C\`device\*(C' starting at offset \f(CW\*(C\`offset\*(C'.

This command implements the **pwrite**\|(2) system call, and like
that system call it may not write the full data requested
(although short writes to disk devices and partitions are
probably impossible with standard Linux kernels).

See also pwrite\*(R".

Because of the message protocol, there is a transfer limit
of somewhere between 2MB and 4MB.  See \s-1PROTOCOL LIMITS\*(R"\s0 in **guestfs**\|(3).

<a name="read-file"></a>

### read-file

.IX Subsection "read-file"
.Vb 1
 read-file path
.Ve

This calls returns the contents of the file \f(CW`path\*(C' as a
buffer.

Unlike cat\*(R", this function can correctly
handle files that contain embedded \s-1ASCII NUL\s0 characters.

<a name="read-lines"></a>

### read-lines

.IX Subsection "read-lines"
.Vb 1
 read-lines path
.Ve

Return the contents of the file named \f(CW`path\*(C'.

The file contents are returned as a list of lines.  Trailing
\f(CW`LF\*(C' and \f(CW\*(C\`CRLF\*(C' character sequences are _not_ returned.

Note that this function cannot correctly handle binary files
(specifically, files containing \f(CW`\e0\*(C' character which is treated
as end of string).  For those you need to use the read-file\*(R"
function and split the buffer into lines yourself.

<a name="readdir"></a>

### readdir

.IX Subsection "readdir"
.Vb 1
 readdir dir
.Ve

This returns the list of directory entries in directory \f(CW`dir\*(C'.

All entries in the directory are returned, including \f(CW`.\*(C' and
\f(CW`..\*(C'.  The entries are _not_ sorted, but returned in the same
order as the underlying filesystem.

Also this call returns basic file type information about each
file.  The \f(CW`ftyp\*(C' field will contain one of the following characters:

* 'b'  
  .IX Item "'b'"
  Block special
* 'c'  
  .IX Item "'c'"
  Char special
* 'd'  
  .IX Item "'d'"
  Directory
* 'f'  
  .IX Item "'f'"
  \s-1FIFO\s0 (named pipe)
* 'l'  
  .IX Item "'l'"
  Symbolic link
* 'r'  
  .IX Item "'r'"
  Regular file
* 's'  
  .IX Item "'s'"
  Socket
* 'u'  
  .IX Item "'u'"
  Unknown file type
* '?'  
  The **readdir**\|(3) call returned a \f(CW`d\_type\*(C' field with an
  unexpected value

This function is primarily intended for use by programs.  To
get a simple list of names, use ls\*(R".  To get a printable
directory for human consumption, use ll\*(R".

Because of the message protocol, there is a transfer limit
of somewhere between 2MB and 4MB.  See \s-1PROTOCOL LIMITS\*(R"\s0 in **guestfs**\|(3).

<a name="readlink"></a>

### readlink

.IX Subsection "readlink"
.Vb 1
 readlink path
.Ve

This command reads the target of a symbolic link.

<a name="readlinklist"></a>

### readlinklist

.IX Subsection "readlinklist"
.Vb 1
 readlinklist path names ...\*(Aq
.Ve

This call allows you to do a \f(CW`readlink\*(C' operation
on multiple files, where all files are in the directory \f(CW`path\*(C'.
\f(CW`names\*(C' is the list of files from this directory.

On return you get a list of strings, with a one-to-one
correspondence to the \f(CW`names\*(C' list.  Each string is the
value of the symbolic link.

If the **readlink**\|(2) operation fails on any name, then
the corresponding result string is the empty string \f(CW"".
However the whole operation is completed even if there
were **readlink**\|(2) errors, and so you can call this
function with names where you don't know if they are
symbolic links already (albeit slightly less efficient).

This call is intended for programs that want to efficiently
list a directory contents without making many round-trips.

<a name="realpath"></a>

### realpath

.IX Subsection "realpath"
.Vb 1
 realpath path
.Ve

Return the canonicalized absolute pathname of \f(CW`path\*(C'.  The
returned path has no \f(CW`.\*(C', \f(CW\*(C\`..\*(C' or symbolic link path elements.

<a name="remount"></a>

### remount

.IX Subsection "remount"
.Vb 1
 remount mountpoint [rw:true|false]
.Ve

This call allows you to change the \f(CW`rw\*(C' (readonly/read-write)
flag on an already mounted filesystem at \f(CW`mountpoint\*(C',
converting a readonly filesystem to be read-write, or vice-versa.

Note that at the moment you must supply the optional\*(R" \f(CW\*(C\`rw\*(C'
parameter.  In future we may allow other flags to be adjusted.

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

<a name="remove-drive"></a>

### remove-drive

.IX Subsection "remove-drive"
.Vb 1
 remove-drive label
.Ve

This function is conceptually the opposite of add-drive-opts\*(R".
It removes the drive that was previously added with label \f(CW`label\*(C'.

Note that in order to remove drives, you have to add them with
labels (see the optional \f(CW`label\*(C' argument to \*(L"add-drive-opts\*(R").
If you didn't use a label, then they cannot be removed.

You can call this function before or after launching the handle.
If called after launch, if the backend supports it, we try to hot
unplug the drive: see \s-1HOTPLUGGING\*(R"\s0 in **guestfs**\|(3).  The disk **must not**
be in use (eg. mounted) when you do this.  We try to detect if the
disk is in use and stop you from doing this.

<a name="removexattr"></a>

### removexattr

.IX Subsection "removexattr"
.Vb 1
 removexattr xattr path
.Ve

This call removes the extended attribute named \f(CW`xattr\*(C'
of the file \f(CW`path\*(C'.

See also: lremovexattr\*(R", **attr**\|(5).

This command depends on the feature \f(CW`linuxxattrs\*(C'.   See also
feature-available\*(R".

<a name="rename"></a>

### rename

.IX Subsection "rename"
.Vb 1
 rename oldpath newpath
.Ve

Rename a file to a new place on the same filesystem.  This is
the same as the Linux **rename**\|(2) system call.  In most cases
you are better to use mv\*(R" instead.

<a name="resize2fs"></a>

### resize2fs

.IX Subsection "resize2fs"
.Vb 1
 resize2fs device
.Ve

This resizes an ext2, ext3 or ext4 filesystem to match the size of
the underlying device.

See also \s-1RESIZE2FS ERRORS\*(R"\s0 in **guestfs**\|(3).

<a name="resize2fs-m"></a>

### resize2fs\-M

.IX Subsection "resize2fs-M"
.Vb 1
 resize2fs-M device
.Ve

This command is the same as resize2fs\*(R", but the filesystem
is resized to its minimum size.  This works like the _-M_ option
to the \f(CW`resize2fs\*(C' command.

To get the resulting size of the filesystem you should call
tune2fs-l\*(R" and read the \f(CW\*(C\`Block size\*(C' and \f(CW\*(C\`Block count\*(C'
values.  These two numbers, multiplied together, give the
resulting size of the minimal filesystem in bytes.

See also \s-1RESIZE2FS ERRORS\*(R"\s0 in **guestfs**\|(3).

<a name="resize2fs-size"></a>

### resize2fs\-size

.IX Subsection "resize2fs-size"
.Vb 1
 resize2fs-size device size
.Ve

This command is the same as resize2fs\*(R" except that it
allows you to specify the new size (in bytes) explicitly.

See also \s-1RESIZE2FS ERRORS\*(R"\s0 in **guestfs**\|(3).

<a name="rm"></a>

### rm

.IX Subsection "rm"
.Vb 1
 rm path
.Ve

Remove the single file \f(CW`path\*(C'.

<a name="rm-f"></a>

### rm-f

.IX Subsection "rm-f"
.Vb 1
 rm-f path
.Ve

Remove the file \f(CW`path\*(C'.

If the file doesn't exist, that error is ignored.  (Other errors,
eg. I/O errors or bad paths, are not ignored)

This call cannot remove directories.
Use rmdir\*(R" to remove an empty directory,
or rm-rf\*(R" to remove directories recursively.

<a name="rm-rf"></a>

### rm-rf

.IX Subsection "rm-rf"
.Vb 1
 rm-rf path
.Ve

Remove the file or directory \f(CW`path\*(C', recursively removing the
contents if its a directory.  This is like the \f(CW`rm -rf\*(C' shell
command.

<a name="rmdir"></a>

### rmdir

.IX Subsection "rmdir"
.Vb 1
 rmdir path
.Ve

Remove the single directory \f(CW`path\*(C'.

<a name="rmmountpoint"></a>

### rmmountpoint

.IX Subsection "rmmountpoint"
.Vb 1
 rmmountpoint exemptpath
.Ve

This call removes a mountpoint that was previously created
with mkmountpoint\*(R".  See \*(L"mkmountpoint\*(R"
for full details.

<a name="rsync"></a>

### rsync

.IX Subsection "rsync"
.Vb 1
 rsync src dest [archive:true|false] [deletedest:true|false]
.Ve

This call may be used to copy or synchronize two directories
under the same libguestfs handle.  This uses the **rsync**\|(1)
program which uses a fast algorithm that avoids copying files
unnecessarily.

\f(CW`src\*(C' and \f(CW\*(C\`dest\*(C' are the source and destination directories.
Files are copied from \f(CW`src\*(C' to \f(CW\*(C\`dest\*(C'.

The optional arguments are:
.ie n .IP """archive""" 4
.el .IP "\f(CWarchive" 4
.IX Item "archive"
Turns on archive mode.  This is the same as passing the
_--archive_ flag to \f(CW`rsync\*(C'.
.ie n .IP """deletedest""" 4
.el .IP "\f(CWdeletedest" 4
.IX Item "deletedest"
Delete files at the destination that do not exist at the source.

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

This command depends on the feature \f(CW`rsync\*(C'.   See also
feature-available\*(R".

<a name="rsync-in"></a>

### rsync-in

.IX Subsection "rsync-in"
.Vb 1
 rsync-in remote dest [archive:true|false] [deletedest:true|false]
.Ve

This call may be used to copy or synchronize the filesystem
on the host or on a remote computer with the filesystem
within libguestfs.  This uses the **rsync**\|(1) program
which uses a fast algorithm that avoids copying files unnecessarily.

This call only works if the network is enabled.  See
set-network\*(R" or the _--network_ option to
various tools like **guestfish**\|(1).

Files are copied from the remote server and directory
specified by \f(CW`remote\*(C' to the destination directory \f(CW\*(C\`dest\*(C'.

The format of the remote server string is defined by **rsync**\|(1).
Note that there is no way to supply a password or passphrase
so the target must be set up not to require one.

The optional arguments are the same as those of rsync\*(R".

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

This command depends on the feature \f(CW`rsync\*(C'.   See also
feature-available\*(R".

<a name="rsync-out"></a>

### rsync-out

.IX Subsection "rsync-out"
.Vb 1
 rsync-out src remote [archive:true|false] [deletedest:true|false]
.Ve

This call may be used to copy or synchronize the filesystem within
libguestfs with a filesystem on the host or on a remote computer.
This uses the **rsync**\|(1) program which uses a fast algorithm that
avoids copying files unnecessarily.

This call only works if the network is enabled.  See
set-network\*(R" or the _--network_ option to
various tools like **guestfish**\|(1).

Files are copied from the source directory \f(CW`src\*(C' to the
remote server and directory specified by \f(CW`remote\*(C'.

The format of the remote server string is defined by **rsync**\|(1).
Note that there is no way to supply a password or passphrase
so the target must be set up not to require one.

The optional arguments are the same as those of rsync\*(R".

Globbing does not happen on the \f(CW`src\*(C' parameter.  In programs
which use the \s-1API\s0 directly you have to expand wildcards yourself
(see glob-expand\*(R").  In guestfish you can use the \f(CW\*(C\`glob\*(C'
command (see glob\*(R"), for example:

.Vb 1
 &gt;&lt;fs&gt; glob rsync-out /* rsync://remote/
.Ve

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

This command depends on the feature \f(CW`rsync\*(C'.   See also
feature-available\*(R".

<a name="scrub-device"></a>

### scrub-device

.IX Subsection "scrub-device"
.Vb 1
 scrub-device device
.Ve

This command writes patterns over \f(CW`device\*(C' to make data retrieval
more difficult.

It is an interface to the **scrub**\|(1) program.  See that
manual page for more details.

This command depends on the feature \f(CW`scrub\*(C'.   See also
feature-available\*(R".

<a name="scrub-file"></a>

### scrub-file

.IX Subsection "scrub-file"
.Vb 1
 scrub-file file
.Ve

This command writes patterns over a file to make data retrieval
more difficult.

The file is _removed_ after scrubbing.

It is an interface to the **scrub**\|(1) program.  See that
manual page for more details.

This command depends on the feature \f(CW`scrub\*(C'.   See also
feature-available\*(R".

<a name="scrub-freespace"></a>

### scrub-freespace

.IX Subsection "scrub-freespace"
.Vb 1
 scrub-freespace dir
.Ve

This command creates the directory \f(CW`dir\*(C' and then fills it
with files until the filesystem is full, and scrubs the files
as for scrub-file\*(R", and deletes them.
The intention is to scrub any free space on the partition
containing \f(CW`dir\*(C'.

It is an interface to the **scrub**\|(1) program.  See that
manual page for more details.

This command depends on the feature \f(CW`scrub\*(C'.   See also
feature-available\*(R".

<a name="selinux-relabel"></a>

### selinux-relabel

.IX Subsection "selinux-relabel"
.Vb 1
 selinux-relabel specfile path [force:true|false]
.Ve

SELinux relabel parts of the filesystem.

The \f(CW`specfile\*(C' parameter controls the policy spec file used.
You have to parse \f(CW`/etc/selinux/config\*(C' to find the correct
SELinux policy and then pass the spec file, usually:
\f(CW`/etc/selinux/\*(C' + _selinuxtype_ + \f(CW\*(C\`/contexts/files/file\_contexts\*(C'.

The required \f(CW`path\*(C' parameter is the top level directory where
relabelling starts.  Normally you should pass \f(CW`path\*(C' as \f(CW\*(C\`/\*(C'
to relabel the whole guest filesystem.

The optional \f(CW`force\*(C' boolean controls whether the context
is reset for customizable files, and also whether the
user, role and range parts of the file context is changed.

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

This command depends on the feature \f(CW`selinuxrelabel\*(C'.   See also
feature-available\*(R".

<a name="set-append"></a>

### set-append

.IX Subsection "set-append"

<a name="append"></a>

### append

.IX Subsection "append"
.Vb 1
 set-append append
.Ve

This function is used to add additional options to the
libguestfs appliance kernel command line.

The default is \f(CW`NULL\*(C' unless overridden by setting
\f(CW`LIBGUESTFS\_APPEND\*(C' environment variable.

Setting \f(CW`append\*(C' to \f(CW\*(C\`NULL\*(C' means _no_ additional options
are passed (libguestfs always adds a few of its own).

<a name="set-attach-method"></a>

### set-attach-method

.IX Subsection "set-attach-method"

<a name="attach-method"></a>

### attach-method

.IX Subsection "attach-method"
.Vb 1
 set-attach-method backend
.Ve

Set the method that libguestfs uses to connect to the backend
guestfsd daemon.

See \s-1BACKEND\*(R"\s0 in **guestfs**\|(3).

_This function is deprecated._
In new code, use the set-backend\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="set-autosync"></a>

### set-autosync

.IX Subsection "set-autosync"

<a name="autosync"></a>

### autosync

.IX Subsection "autosync"
.Vb 1
 set-autosync true|false
.Ve

If \f(CW`autosync\*(C' is true, this enables autosync.  Libguestfs will make a
best effort attempt to make filesystems consistent and synchronized
when the handle is closed
(also if the program exits without closing handles).

This is enabled by default (since libguestfs 1.5.24, previously it was
disabled by default).

<a name="set-backend"></a>

### set-backend

.IX Subsection "set-backend"

<a name="backend"></a>

### backend

.IX Subsection "backend"
.Vb 1
 set-backend backend
.Ve

Set the method that libguestfs uses to connect to the backend
guestfsd daemon.

This handle property was previously called the attach method\*(R".

See \s-1BACKEND\*(R"\s0 in **guestfs**\|(3).

<a name="set-backend-setting"></a>

### set-backend-setting

.IX Subsection "set-backend-setting"
.Vb 1
 set-backend-setting name val
.Ve

Append \f(CW"name=value" to the backend settings string list.
However if a string already exists matching \f(CW"name"
or beginning with \f(CW"name=", then that setting is replaced.

See \s-1BACKEND\*(R"\s0 in **guestfs**\|(3), \*(L"\s-1BACKEND SETTINGS\*(R"\s0 in **guestfs**\|(3).

<a name="set-backend-settings"></a>

### set-backend-settings

.IX Subsection "set-backend-settings"
.Vb 1
 set-backend-settings settings ...\*(Aq
.Ve

Set a list of zero or more settings which are passed through to
the current backend.  Each setting is a string which is interpreted
in a backend-specific way, or ignored if not understood by the
backend.

The default value is an empty list, unless the environment
variable \f(CW`LIBGUESTFS\_BACKEND\_SETTINGS\*(C' was set when the handle
was created.  This environment variable contains a colon-separated
list of settings.

This call replaces all backend settings.  If you want to replace
a single backend setting, see set-backend-setting\*(R".
If you want to clear a single backend setting, see
clear-backend-setting\*(R".

See \s-1BACKEND\*(R"\s0 in **guestfs**\|(3), \*(L"\s-1BACKEND SETTINGS\*(R"\s0 in **guestfs**\|(3).

<a name="set-cachedir"></a>

### set-cachedir

.IX Subsection "set-cachedir"

<a name="cachedir"></a>

### cachedir

.IX Subsection "cachedir"
.Vb 1
 set-cachedir cachedir
.Ve

Set the directory used by the handle to store the appliance
cache, when using a supermin appliance.  The appliance is
cached and shared between all handles which have the same
effective user \s-1ID.\s0

The environment variables \f(CW`LIBGUESTFS\_CACHEDIR\*(C' and \f(CW\*(C\`TMPDIR\*(C'
control the default value: If \f(CW`LIBGUESTFS\_CACHEDIR\*(C' is set, then
that is the default.  Else if \f(CW`TMPDIR\*(C' is set, then that is
the default.  Else _/var/tmp_ is the default.

<a name="set-direct"></a>

### set-direct

.IX Subsection "set-direct"

<a name="direct"></a>

### direct

.IX Subsection "direct"
.Vb 1
 set-direct true|false
.Ve

If the direct appliance mode flag is enabled, then stdin and
stdout are passed directly through to the appliance once it
is launched.

One consequence of this is that log messages aren't caught
by the library and handled by set-log-message-callback\*(R",
but go straight to stdout.

You probably don't want to use this unless you know what you
are doing.

The default is disabled.

_This function is deprecated._
In new code, use the internal-get-console-socket\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="set-e2attrs"></a>

### set\-e2attrs

.IX Subsection "set-e2attrs"
.Vb 1
 set-e2attrs file attrs [clear:true|false]
.Ve

This sets or clears the file attributes \f(CW`attrs\*(C'
associated with the inode _file_.

\f(CW`attrs\*(C' is a string of characters representing
file attributes.  See get-e2attrs\*(R" for a list of
possible attributes.  Not all attributes can be changed.

If optional boolean \f(CW`clear\*(C' is not present or false, then
the \f(CW`attrs\*(C' listed are set in the inode.

If \f(CW`clear\*(C' is true, then the \f(CW\*(C\`attrs\*(C' listed are cleared
in the inode.

In both cases, other attributes not present in the \f(CW`attrs\*(C'
string are left unchanged.

These attributes are only present when the file is located on
an ext2/3/4 filesystem.  Using this call on other filesystem
types will result in an error.

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

<a name="set-e2generation"></a>

### set\-e2generation

.IX Subsection "set-e2generation"
.Vb 1
 set-e2generation file generation
.Ve

This sets the ext2 file generation of a file.

See get-e2generation\*(R".

<a name="set-e2label"></a>

### set\-e2label

.IX Subsection "set-e2label"
.Vb 1
 set-e2label device label
.Ve

This sets the ext2/3/4 filesystem label of the filesystem on
\f(CW`device\*(C' to \f(CW\*(C\`label\*(C'.  Filesystem labels are limited to
16 characters.

You can use either tune2fs-l\*(R" or \*(L"get-e2label\*(R"
to return the existing label on a filesystem.

_This function is deprecated._
In new code, use the set-label\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="set-e2uuid"></a>

### set\-e2uuid

.IX Subsection "set-e2uuid"
.Vb 1
 set-e2uuid device uuid
.Ve

This sets the ext2/3/4 filesystem \s-1UUID\s0 of the filesystem on
\f(CW`device\*(C' to \f(CW\*(C\`uuid\*(C'.  The format of the \s-1UUID\s0 and alternatives
such as \f(CW`clear\*(C', \f(CW\*(C\`random\*(C' and \f(CW\*(C\`time\*(C' are described in the
**tune2fs**\|(8) manpage.

You can use vfs-uuid\*(R" to return the existing \s-1UUID\s0
of a filesystem.

_This function is deprecated._
In new code, use the set-uuid\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="set-hv"></a>

### set-hv

.IX Subsection "set-hv"

<a name="hv"></a>

### hv

.IX Subsection "hv"
.Vb 1
 set-hv hv
.Ve

Set the hypervisor binary that we will use.  The hypervisor
depends on the backend, but is usually the location of the
qemu/KVM hypervisor.  For the uml backend, it is the location
of the \f(CW`linux\*(C' or \f(CW\*(C\`vmlinux\*(C' binary.

The default is chosen when the library was compiled by the
configure script.

You can also override this by setting the \f(CW`LIBGUESTFS\_HV\*(C'
environment variable.

Note that you should call this function as early as possible
after creating the handle.  This is because some pre-launch
operations depend on testing qemu features (by running \f(CW`qemu -help\*(C').
If the qemu binary changes, we don't retest features, and
so you might see inconsistent results.  Using the environment
variable \f(CW`LIBGUESTFS\_HV\*(C' is safest of all since that picks
the qemu binary at the same time as the handle is created.

<a name="set-identifier"></a>

### set-identifier

.IX Subsection "set-identifier"

<a name="identifier"></a>

### identifier

.IX Subsection "identifier"
.Vb 1
 set-identifier identifier
.Ve

This is an informative string which the caller may optionally
set in the handle.  It is printed in various places, allowing
the current handle to be identified in debugging output.

One important place is when tracing is enabled.  If the
identifier string is not an empty string, then trace messages
change from this:

.Vb 2
 libguestfs: trace: get_tmpdir
 libguestfs: trace: get_tmpdir = "/tmp"
.Ve

to this:

.Vb 2
 libguestfs: trace: ID: get_tmpdir
 libguestfs: trace: ID: get_tmpdir = "/tmp"
.Ve

where \f(CW`ID\*(C' is the identifier string set by this call.

The identifier must only contain alphanumeric \s-1ASCII\s0 characters,
underscore and minus sign.  The default is the empty string.

See also set-program\*(R", \*(L"set-trace\*(R",
get-identifier\*(R".

<a name="set-label"></a>

### set-label

.IX Subsection "set-label"
.Vb 1
 set-label mountable label
.Ve

Set the filesystem label on \f(CW`mountable\*(C' to \f(CW\*(C\`label\*(C'.

Only some filesystem types support labels, and libguestfs supports
setting labels on only a subset of these.

* ext2, ext3, ext4  
  .IX Item "ext2, ext3, ext4"
  Labels are limited to 16 bytes.
* \s-1NTFS\s0  
  .IX Item "NTFS"
  Labels are limited to 128 unicode characters.
* \s-1XFS\s0  
  .IX Item "XFS"
  The label is limited to 12 bytes.  The filesystem must not
  be mounted when trying to set the label.
* btrfs  
  .IX Item "btrfs"
  The label is limited to 255 bytes and some characters are
  not allowed.  Setting the label on a btrfs subvolume will set the
  label on its parent filesystem.  The filesystem must not be mounted
  when trying to set the label.
* fat  
  .IX Item "fat"
  The label is limited to 11 bytes.
* swap  
  .IX Item "swap"
  The label is limited to 16 bytes.

If there is no support for changing the label
for the type of the specified filesystem,
set_label will fail and set errno as \s-1ENOTSUP.\s0

To read the label on a filesystem, call vfs-label\*(R".

<a name="set-libvirt-requested-credential"></a>

### set-libvirt-requested-credential

.IX Subsection "set-libvirt-requested-credential"
.Vb 1
 set-libvirt-requested-credential index cred
.Ve

After requesting the \f(CW`index\*(C''th credential from the user,
call this function to pass the answer back to libvirt.

See \s-1LIBVIRT AUTHENTICATION\*(R"\s0 in **guestfs**\|(3) for documentation and example code.

<a name="set-libvirt-supported-credentials"></a>

### set-libvirt-supported-credentials

.IX Subsection "set-libvirt-supported-credentials"
.Vb 1
 set-libvirt-supported-credentials creds ...\*(Aq
.Ve

Call this function before setting an event handler for
\f(CW`GUESTFS\_EVENT\_LIBVIRT\_AUTH\*(C', to supply the list of credential types
that the program knows how to process.

The \f(CW`creds\*(C' list must be a non-empty list of strings.
Possible strings are:
.ie n .IP """username""" 4
.el .IP "\f(CWusername" 4
.IX Item "username"
.ie n .IP """authname""" 4
.el .IP "\f(CWauthname" 4
.IX Item "authname"
.ie n .IP """language""" 4
.el .IP "\f(CWlanguage" 4
.IX Item "language"
.ie n .IP """cnonce""" 4
.el .IP "\f(CWcnonce" 4
.IX Item "cnonce"
.ie n .IP """passphrase""" 4
.el .IP "\f(CWpassphrase" 4
.IX Item "passphrase"
.ie n .IP """echoprompt""" 4
.el .IP "\f(CWechoprompt" 4
.IX Item "echoprompt"
.ie n .IP """noechoprompt""" 4
.el .IP "\f(CWnoechoprompt" 4
.IX Item "noechoprompt"
.ie n .IP """realm""" 4
.el .IP "\f(CWrealm" 4
.IX Item "realm"
.ie n .IP """external""" 4
.el .IP "\f(CWexternal" 4
.IX Item "external"

See libvirt documentation for the meaning of these credential types.

See \s-1LIBVIRT AUTHENTICATION\*(R"\s0 in **guestfs**\|(3) for documentation and example code.

<a name="set-memsize"></a>

### set-memsize

.IX Subsection "set-memsize"

<a name="memsize"></a>

### memsize

.IX Subsection "memsize"
.Vb 1
 set-memsize memsize
.Ve

This sets the memory size in megabytes allocated to the
hypervisor.  This only has any effect if called before
launch\*(R".

You can also change this by setting the environment
variable \f(CW`LIBGUESTFS\_MEMSIZE\*(C' before the handle is
created.

For more information on the architecture of libguestfs,
see **guestfs**\|(3).

<a name="set-network"></a>

### set-network

.IX Subsection "set-network"

<a name="network"></a>

### network

.IX Subsection "network"
.Vb 1
 set-network true|false
.Ve

If \f(CW`network\*(C' is true, then the network is enabled in the
libguestfs appliance.  The default is false.

This affects whether commands are able to access the network
(see \s-1RUNNING COMMANDS\*(R"\s0 in **guestfs**\|(3)).

You must call this before calling launch\*(R", otherwise
it has no effect.

<a name="set-path"></a>

### set-path

.IX Subsection "set-path"

<a name="path"></a>

### path

.IX Subsection "path"
.Vb 1
 set-path searchpath
.Ve

Set the path that libguestfs searches for kernel and initrd.img.

The default is \f(CW`$libdir/guestfs\*(C' unless overridden by setting
\f(CW`LIBGUESTFS\_PATH\*(C' environment variable.

Setting \f(CW`path\*(C' to \f(CW\*(C\`NULL\*(C' restores the default path.

<a name="set-pgroup"></a>

### set-pgroup

.IX Subsection "set-pgroup"

<a name="pgroup"></a>

### pgroup

.IX Subsection "pgroup"
.Vb 1
 set-pgroup true|false
.Ve

If \f(CW`pgroup\*(C' is true, child processes are placed into
their own process group.

The practical upshot of this is that signals like \f(CW`SIGINT\*(C' (from
users pressing \f(CW`^C\*(C') won't be received by the child process.

The default for this flag is false, because usually you want
\f(CW`^C\*(C' to kill the subprocess.  Guestfish sets this flag to
true when used interactively, so that \f(CW`^C\*(C' can cancel
long-running commands gracefully (see user-cancel\*(R").

<a name="set-program"></a>

### set-program

.IX Subsection "set-program"

<a name="program"></a>

### program

.IX Subsection "program"
.Vb 1
 set-program program
.Ve

Set the program name.  This is an informative string which the
main program may optionally set in the handle.

When the handle is created, the program name in the handle is
set to the basename from \f(CW`argv[0]\*(C'.  The program name can never
be \f(CW`NULL\*(C'.

<a name="set-qemu"></a>

### set-qemu

.IX Subsection "set-qemu"

<a name="qemu"></a>

### qemu

.IX Subsection "qemu"
.Vb 1
 set-qemu hv
.Ve

Set the hypervisor binary (usually qemu) that we will use.

The default is chosen when the library was compiled by the
configure script.

You can also override this by setting the \f(CW`LIBGUESTFS\_HV\*(C'
environment variable.

Setting \f(CW`hv\*(C' to \f(CW\*(C\`NULL\*(C' restores the default qemu binary.

Note that you should call this function as early as possible
after creating the handle.  This is because some pre-launch
operations depend on testing qemu features (by running \f(CW`qemu -help\*(C').
If the qemu binary changes, we don't retest features, and
so you might see inconsistent results.  Using the environment
variable \f(CW`LIBGUESTFS\_HV\*(C' is safest of all since that picks
the qemu binary at the same time as the handle is created.

_This function is deprecated._
In new code, use the set-hv\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="set-recovery-proc"></a>

### set-recovery-proc

.IX Subsection "set-recovery-proc"

<a name="recovery-proc"></a>

### recovery-proc

.IX Subsection "recovery-proc"
.Vb 1
 set-recovery-proc true|false
.Ve

If this is called with the parameter \f(CW`false\*(C' then
launch\*(R" does not create a recovery process.  The
purpose of the recovery process is to stop runaway hypervisor
processes in the case where the main program aborts abruptly.

This only has any effect if called before launch\*(R",
and the default is true.

About the only time when you would want to disable this is
if the main process will fork itself into the background
(daemonize\*(R" itself).  In this case the recovery process
thinks that the main program has disappeared and so kills
the hypervisor, which is not very helpful.

<a name="set-selinux"></a>

### set-selinux

.IX Subsection "set-selinux"

<a name="selinux"></a>

### selinux

.IX Subsection "selinux"
.Vb 1
 set-selinux true|false
.Ve

This sets the selinux flag that is passed to the appliance
at boot time.  The default is \f(CW`selinux=0\*(C' (disabled).

Note that if SELinux is enabled, it is always in
Permissive mode (\f(CW`enforcing=0\*(C').

For more information on the architecture of libguestfs,
see **guestfs**\|(3).

_This function is deprecated._
In new code, use the selinux-relabel\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="set-smp"></a>

### set-smp

.IX Subsection "set-smp"

<a name="smp"></a>

### smp

.IX Subsection "smp"
.Vb 1
 set-smp smp
.Ve

Change the number of virtual CPUs assigned to the appliance.  The
default is \f(CW1.  Increasing this may improve performance, though
often it has no effect.

This function must be called before launch\*(R".

<a name="set-tmpdir"></a>

### set-tmpdir

.IX Subsection "set-tmpdir"

<a name="tmpdir"></a>

### tmpdir

.IX Subsection "tmpdir"
.Vb 1
 set-tmpdir tmpdir
.Ve

Set the directory used by the handle to store temporary files.

The environment variables \f(CW`LIBGUESTFS\_TMPDIR\*(C' and \f(CW\*(C\`TMPDIR\*(C'
control the default value: If \f(CW`LIBGUESTFS\_TMPDIR\*(C' is set, then
that is the default.  Else if \f(CW`TMPDIR\*(C' is set, then that is
the default.  Else _/tmp_ is the default.

<a name="set-trace"></a>

### set-trace

.IX Subsection "set-trace"

<a name="trace"></a>

### trace

.IX Subsection "trace"
.Vb 1
 set-trace true|false
.Ve

If the command trace flag is set to 1, then libguestfs
calls, parameters and return values are traced.

If you want to trace C \s-1API\s0 calls into libguestfs (and
other libraries) then possibly a better way is to use
the external **ltrace**\|(1) command.

Command traces are disabled unless the environment variable
\f(CW`LIBGUESTFS\_TRACE\*(C' is defined and set to \f(CW1.

Trace messages are normally sent to \f(CW`stderr\*(C', unless you
register a callback to send them somewhere else (see
set-event-callback\*(R").

<a name="set-uuid"></a>

### set-uuid

.IX Subsection "set-uuid"
.Vb 1
 set-uuid device uuid
.Ve

Set the filesystem \s-1UUID\s0 on \f(CW`device\*(C' to \f(CW\*(C\`uuid\*(C'.
If this fails and the errno is \s-1ENOTSUP,\s0
means that there is no support for changing the \s-1UUID\s0
for the type of the specified filesystem.

Only some filesystem types support setting UUIDs.

To read the \s-1UUID\s0 on a filesystem, call vfs-uuid\*(R".

<a name="set-uuid-random"></a>

### set-uuid-random

.IX Subsection "set-uuid-random"
.Vb 1
 set-uuid-random device
.Ve

Set the filesystem \s-1UUID\s0 on \f(CW`device\*(C' to a random \s-1UUID.\s0
If this fails and the errno is \s-1ENOTSUP,\s0
means that there is no support for changing the \s-1UUID\s0
for the type of the specified filesystem.

Only some filesystem types support setting UUIDs.

To read the \s-1UUID\s0 on a filesystem, call vfs-uuid\*(R".

<a name="set-verbose"></a>

### set-verbose

.IX Subsection "set-verbose"

<a name="verbose"></a>

### verbose

.IX Subsection "verbose"
.Vb 1
 set-verbose true|false
.Ve

If \f(CW`verbose\*(C' is true, this turns on verbose messages.

Verbose messages are disabled unless the environment variable
\f(CW`LIBGUESTFS\_DEBUG\*(C' is defined and set to \f(CW1.

Verbose messages are normally sent to \f(CW`stderr\*(C', unless you
register a callback to send them somewhere else (see
set-event-callback\*(R").

<a name="setcon"></a>

### setcon

.IX Subsection "setcon"
.Vb 1
 setcon context
.Ve

This sets the SELinux security context of the daemon
to the string \f(CW`context\*(C'.

See the documentation about \s-1SELINUX\s0 in **guestfs**\|(3).

_This function is deprecated._
In new code, use the selinux-relabel\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

This command depends on the feature \f(CW`selinux\*(C'.   See also
feature-available\*(R".

<a name="setxattr"></a>

### setxattr

.IX Subsection "setxattr"
.Vb 1
 setxattr xattr val vallen path
.Ve

This call sets the extended attribute named \f(CW`xattr\*(C'
of the file \f(CW`path\*(C' to the value \f(CW\*(C\`val\*(C' (of length \f(CW\*(C\`vallen\*(C').
The value is arbitrary 8 bit data.

See also: lsetxattr\*(R", **attr**\|(5).

This command depends on the feature \f(CW`linuxxattrs\*(C'.   See also
feature-available\*(R".

<a name="sfdisk"></a>

### sfdisk

.IX Subsection "sfdisk"
.Vb 1
 sfdisk device cyls heads sectors lines ...\*(Aq
.Ve

This is a direct interface to the **sfdisk**\|(8) program for creating
partitions on block devices.

\f(CW`device\*(C' should be a block device, for example _/dev/sda_.

\f(CW`cyls\*(C', \f(CW\*(C\`heads\*(C' and \f(CW\*(C\`sectors\*(C' are the number of cylinders, heads
and sectors on the device, which are passed directly to sfdisk as
the _-C_, _-H_ and _-S_ parameters.  If you pass \f(CW0 for any
of these, then the corresponding parameter is omitted.  Usually for
‘large’ disks, you can just pass \f(CW0 for these, but for small
(floppy-sized) disks, sfdisk (or rather, the kernel) cannot work
out the right geometry and you will need to tell it.

\f(CW`lines\*(C' is a list of lines that we feed to \f(CW\*(C\`sfdisk\*(C'.  For more
information refer to the **sfdisk**\|(8) manpage.

To create a single partition occupying the whole disk, you would
pass \f(CW`lines\*(C' as a single element list, when the single element being
the string \f(CW`,\*(C' (comma).

See also: sfdisk-l\*(R", \*(L"sfdisk-N\*(R",
part-init\*(R"

_This function is deprecated._
In new code, use the part-add\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="sfdiskm"></a>

### sfdiskM

.IX Subsection "sfdiskM"
.Vb 1
 sfdiskM device lines ...\*(Aq
.Ve

This is a simplified interface to the sfdisk\*(R"
command, where partition sizes are specified in megabytes
only (rounded to the nearest cylinder) and you don't need
to specify the cyls, heads and sectors parameters which
were rarely if ever used anyway.

See also: sfdisk\*(R", the **sfdisk**\|(8) manpage
and part-disk\*(R"

_This function is deprecated._
In new code, use the part-add\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="sfdisk-n"></a>

### sfdisk-N

.IX Subsection "sfdisk-N"
.Vb 1
 sfdisk-N device partnum cyls heads sectors line
.Ve

This runs **sfdisk**\|(8) option to modify just the single
partition \f(CW`n\*(C' (note: \f(CW\*(C\`n\*(C' counts from 1).

For other parameters, see sfdisk\*(R".  You should usually
pass \f(CW0 for the cyls/heads/sectors parameters.

See also: part-add\*(R"

_This function is deprecated._
In new code, use the part-add\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="sfdisk-disk-geometry"></a>

### sfdisk-disk-geometry

.IX Subsection "sfdisk-disk-geometry"
.Vb 1
 sfdisk-disk-geometry device
.Ve

This displays the disk geometry of \f(CW`device\*(C' read from the
partition table.  Especially in the case where the underlying
block device has been resized, this can be different from the
kernel’s idea of the geometry (see sfdisk-kernel-geometry\*(R").

The result is in human-readable format, and not designed to
be parsed.

<a name="sfdisk-kernel-geometry"></a>

### sfdisk-kernel-geometry

.IX Subsection "sfdisk-kernel-geometry"
.Vb 1
 sfdisk-kernel-geometry device
.Ve

This displays the kernel’s idea of the geometry of \f(CW`device\*(C'.

The result is in human-readable format, and not designed to
be parsed.

<a name="sfdisk-l"></a>

### sfdisk-l

.IX Subsection "sfdisk-l"
.Vb 1
 sfdisk-l device
.Ve

This displays the partition table on \f(CW`device\*(C', in the
human-readable output of the **sfdisk**\|(8) command.  It is
not intended to be parsed.

See also: part-list\*(R"

_This function is deprecated._
In new code, use the part-list\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="sh"></a>

### sh

.IX Subsection "sh"
.Vb 1
 sh command
.Ve

This call runs a command from the guest filesystem via the
guest’s _/bin/sh_.

This is like command\*(R", but passes the command to:

.Vb 1
 /bin/sh -c "command"
.Ve

Depending on the guest’s shell, this usually results in
wildcards being expanded, shell expressions being interpolated
and so on.

All the provisos about command\*(R" apply to this call.

<a name="sh-lines"></a>

### sh-lines

.IX Subsection "sh-lines"
.Vb 1
 sh-lines command
.Ve

This is the same as sh\*(R", but splits the result
into a list of lines.

See also: command-lines\*(R"

<a name="shutdown"></a>

### shutdown

.IX Subsection "shutdown"
.Vb 1
 shutdown
.Ve

This is the opposite of launch\*(R".  It performs an orderly
shutdown of the backend process(es).  If the autosync flag is set
(which is the default) then the disk image is synchronized.

If the subprocess exits with an error then this function will return
an error, which should _not_ be ignored (it may indicate that the
disk image could not be written out properly).

It is safe to call this multiple times.  Extra calls are ignored.

This call does _not_ close or free up the handle.  You still
need to call close\*(R" afterwards.

close\*(R" will call this if you don't do it explicitly,
but note that any errors are ignored in that case.

<a name="sleep"></a>

### sleep

.IX Subsection "sleep"
.Vb 1
 sleep secs
.Ve

Sleep for \f(CW`secs\*(C' seconds.

<a name="stat"></a>

### stat

.IX Subsection "stat"
.Vb 1
 stat path
.Ve

Returns file information for the given \f(CW`path\*(C'.

This is the same as the **stat**\|(2) system call.

_This function is deprecated._
In new code, use the statns\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="statns"></a>

### statns

.IX Subsection "statns"
.Vb 1
 statns path
.Ve

Returns file information for the given \f(CW`path\*(C'.

This is the same as the **stat**\|(2) system call.

<a name="statvfs"></a>

### statvfs

.IX Subsection "statvfs"
.Vb 1
 statvfs path
.Ve

Returns file system statistics for any mounted file system.
\f(CW`path\*(C' should be a file or directory in the mounted file system
(typically it is the mount point itself, but it doesn't need to be).

This is the same as the **statvfs**\|(2) system call.

<a name="strings"></a>

### strings

.IX Subsection "strings"
.Vb 1
 strings path
.Ve

This runs the **strings**\|(1) command on a file and returns
the list of printable strings found.

The \f(CW`strings\*(C' command has, in the past, had problems with
parsing untrusted files.  These are mitigated in the current
version of libguestfs, but see \s-1CVE-2014-8484\*(R"\s0 in **guestfs**\|(3).

Because of the message protocol, there is a transfer limit
of somewhere between 2MB and 4MB.  See \s-1PROTOCOL LIMITS\*(R"\s0 in **guestfs**\|(3).

<a name="strings-e"></a>

### strings-e

.IX Subsection "strings-e"
.Vb 1
 strings-e encoding path
.Ve

This is like the strings\*(R" command, but allows you to
specify the encoding of strings that are looked for in
the source file \f(CW`path\*(C'.

Allowed encodings are:

* s  
  .IX Item "s"
  Single 7-bit-byte characters like \s-1ASCII\s0 and the ASCII-compatible
  parts of \s-1ISO-8859-X\s0 (this is what strings\*(R" uses).
* S  
  .IX Item "S"
  Single 8-bit-byte characters.
* b  
  .IX Item "b"
  16-bit big endian strings such as those encoded in
  \s-1UTF-16BE\s0 or \s-1UCS-2BE.\s0
* l (lower case letter L)  
  .IX Item "l (lower case letter L)"
  16-bit little endian such as \s-1UTF-16LE\s0 and \s-1UCS-2LE.\s0
  This is useful for examining binaries in Windows guests.
* B  
  .IX Item "B"
  32-bit big endian such as \s-1UCS-4BE.\s0
* L  
  .IX Item "L"
  32-bit little endian such as \s-1UCS-4LE.\s0

The returned strings are transcoded to \s-1UTF-8.\s0

The \f(CW`strings\*(C' command has, in the past, had problems with
parsing untrusted files.  These are mitigated in the current
version of libguestfs, but see \s-1CVE-2014-8484\*(R"\s0 in **guestfs**\|(3).

Because of the message protocol, there is a transfer limit
of somewhere between 2MB and 4MB.  See \s-1PROTOCOL LIMITS\*(R"\s0 in **guestfs**\|(3).

<a name="swapoff-device"></a>

### swapoff-device

.IX Subsection "swapoff-device"
.Vb 1
 swapoff-device device
.Ve

This command disables the libguestfs appliance swap
device or partition named \f(CW`device\*(C'.
See swapon-device\*(R".

<a name="swapoff-file"></a>

### swapoff-file

.IX Subsection "swapoff-file"
.Vb 1
 swapoff-file file
.Ve

This command disables the libguestfs appliance swap on file.

<a name="swapoff-label"></a>

### swapoff-label

.IX Subsection "swapoff-label"
.Vb 1
 swapoff-label label
.Ve

This command disables the libguestfs appliance swap on
labeled swap partition.

<a name="swapoff-uuid"></a>

### swapoff-uuid

.IX Subsection "swapoff-uuid"
.Vb 1
 swapoff-uuid uuid
.Ve

This command disables the libguestfs appliance swap partition
with the given \s-1UUID.\s0

This command depends on the feature \f(CW`linuxfsuuid\*(C'.   See also
feature-available\*(R".

<a name="swapon-device"></a>

### swapon-device

.IX Subsection "swapon-device"
.Vb 1
 swapon-device device
.Ve

This command enables the libguestfs appliance to use the
swap device or partition named \f(CW`device\*(C'.  The increased
memory is made available for all commands, for example
those run using command\*(R" or \*(L"sh\*(R".

Note that you should not swap to existing guest swap
partitions unless you know what you are doing.  They may
contain hibernation information, or other information that
the guest doesn't want you to trash.  You also risk leaking
information about the host to the guest this way.  Instead,
attach a new host device to the guest and swap on that.

<a name="swapon-file"></a>

### swapon-file

.IX Subsection "swapon-file"
.Vb 1
 swapon-file file
.Ve

This command enables swap to a file.
See swapon-device\*(R" for other notes.

<a name="swapon-label"></a>

### swapon-label

.IX Subsection "swapon-label"
.Vb 1
 swapon-label label
.Ve

This command enables swap to a labeled swap partition.
See swapon-device\*(R" for other notes.

<a name="swapon-uuid"></a>

### swapon-uuid

.IX Subsection "swapon-uuid"
.Vb 1
 swapon-uuid uuid
.Ve

This command enables swap to a swap partition with the given \s-1UUID.\s0
See swapon-device\*(R" for other notes.

This command depends on the feature \f(CW`linuxfsuuid\*(C'.   See also
feature-available\*(R".

<a name="sync"></a>

### sync

.IX Subsection "sync"
.Vb 1
 sync
.Ve

This syncs the disk, so that any writes are flushed through to the
underlying disk image.

You should always call this if you have modified a disk image, before
closing the handle.

<a name="syslinux"></a>

### syslinux

.IX Subsection "syslinux"
.Vb 1
 syslinux device [directory:..]
.Ve

Install the \s-1SYSLINUX\s0 bootloader on \f(CW`device\*(C'.

The device parameter must be either a whole disk formatted
as a \s-1FAT\s0 filesystem, or a partition formatted as a \s-1FAT\s0 filesystem.
In the latter case, the partition should be marked as active\*(R"
(part-set-bootable\*(R") and a Master Boot Record must be
installed (eg. using pwrite-device\*(R") on the first
sector of the whole disk.
The \s-1SYSLINUX\s0 package comes with some suitable Master Boot Records.
See the **syslinux**\|(1) man page for further information.

The optional arguments are:

* _directory_  
  .IX Item "directory"
  Install \s-1SYSLINUX\s0 in the named subdirectory, instead of in the
  root directory of the \s-1FAT\s0 filesystem.

Additional configuration can be supplied to \s-1SYSLINUX\s0 by
placing a file called _syslinux.cfg_ on the \s-1FAT\s0 filesystem,
either in the root directory, or under _directory_ if that
optional argument is being used.  For further information
about the contents of this file, see **syslinux**\|(1).

See also extlinux\*(R".

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

This command depends on the feature \f(CW`syslinux\*(C'.   See also
feature-available\*(R".

<a name="tail"></a>

### tail

.IX Subsection "tail"
.Vb 1
 tail path
.Ve

This command returns up to the last 10 lines of a file as
a list of strings.

Because of the message protocol, there is a transfer limit
of somewhere between 2MB and 4MB.  See \s-1PROTOCOL LIMITS\*(R"\s0 in **guestfs**\|(3).

<a name="tail-n"></a>

### tail-n

.IX Subsection "tail-n"
.Vb 1
 tail-n nrlines path
.Ve

If the parameter \f(CW`nrlines\*(C' is a positive number, this returns the last
\f(CW`nrlines\*(C' lines of the file \f(CW\*(C\`path\*(C'.

If the parameter \f(CW`nrlines\*(C' is a negative number, this returns lines
from the file \f(CW`path\*(C', starting with the \f(CW\*(C\`-nrlines\*(C'th line.

If the parameter \f(CW`nrlines\*(C' is zero, this returns an empty list.

Because of the message protocol, there is a transfer limit
of somewhere between 2MB and 4MB.  See \s-1PROTOCOL LIMITS\*(R"\s0 in **guestfs**\|(3).

<a name="tar-in"></a>

### tar-in

.IX Subsection "tar-in"

<a name="tar-in-opts"></a>

### tar-in-opts

.IX Subsection "tar-in-opts"
.Vb 1
 tar-in (tarfile|-) directory [compress:..] [xattrs:true|false] [selinux:true|false] [acls:true|false]
.Ve

This command uploads and unpacks local file \f(CW`tarfile\*(C' into _directory_.

The optional \f(CW`compress\*(C' flag controls compression.  If not given,
then the input should be an uncompressed tar file.  Otherwise one
of the following strings may be given to select the compression
type of the input file: \f(CW`compress\*(C', \f(CW\*(C\`gzip\*(C', \f(CW\*(C\`bzip2\*(C', \f(CW\*(C\`xz\*(C', \f(CW\*(C\`lzop\*(C'.
(Note that not all builds of libguestfs will support all of these
compression types).

The other optional arguments are:
.ie n .IP """xattrs""" 4
.el .IP "\f(CWxattrs" 4
.IX Item "xattrs"
If set to true, extended attributes are restored from the tar file.
.ie n .IP """selinux""" 4
.el .IP "\f(CWselinux" 4
.IX Item "selinux"
If set to true, SELinux contexts are restored from the tar file.
.ie n .IP """acls""" 4
.el .IP "\f(CWacls" 4
.IX Item "acls"
If set to true, \s-1POSIX\s0 ACLs are restored from the tar file.

Use \f(CW`-\*(C' instead of a filename to read/write from stdin/stdout.

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

<a name="tar-out"></a>

### tar-out

.IX Subsection "tar-out"

<a name="tar-out-opts"></a>

### tar-out-opts

.IX Subsection "tar-out-opts"
.Vb 1
 tar-out directory (tarfile|-) [compress:..] [numericowner:true|false] [excludes:..] [xattrs:true|false] [selinux:true|false] [acls:true|false]
.Ve

This command packs the contents of _directory_ and downloads
it to local file \f(CW`tarfile\*(C'.

The optional \f(CW`compress\*(C' flag controls compression.  If not given,
then the output will be an uncompressed tar file.  Otherwise one
of the following strings may be given to select the compression
type of the output file: \f(CW`compress\*(C', \f(CW\*(C\`gzip\*(C', \f(CW\*(C\`bzip2\*(C', \f(CW\*(C\`xz\*(C', \f(CW\*(C\`lzop\*(C'.
(Note that not all builds of libguestfs will support all of these
compression types).

The other optional arguments are:
.ie n .IP """excludes""" 4
.el .IP "\f(CWexcludes" 4
.IX Item "excludes"
A list of wildcards.  Files are excluded if they match any of the
wildcards.
.ie n .IP """numericowner""" 4
.el .IP "\f(CWnumericowner" 4
.IX Item "numericowner"
If set to true, the output tar file will contain \s-1UID/GID\s0 numbers
instead of user/group names.
.ie n .IP """xattrs""" 4
.el .IP "\f(CWxattrs" 4
.IX Item "xattrs"
If set to true, extended attributes are saved in the output tar.
.ie n .IP """selinux""" 4
.el .IP "\f(CWselinux" 4
.IX Item "selinux"
If set to true, SELinux contexts are saved in the output tar.
.ie n .IP """acls""" 4
.el .IP "\f(CWacls" 4
.IX Item "acls"
If set to true, \s-1POSIX\s0 ACLs are saved in the output tar.

Use \f(CW`-\*(C' instead of a filename to read/write from stdin/stdout.

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

<a name="tgz-in"></a>

### tgz-in

.IX Subsection "tgz-in"
.Vb 1
 tgz-in (tarball|-) directory
.Ve

This command uploads and unpacks local file \f(CW`tarball\*(C' (a
_gzip compressed_ tar file) into _directory_.

Use \f(CW`-\*(C' instead of a filename to read/write from stdin/stdout.

_This function is deprecated._
In new code, use the tar-in\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="tgz-out"></a>

### tgz-out

.IX Subsection "tgz-out"
.Vb 1
 tgz-out directory (tarball|-)
.Ve

This command packs the contents of _directory_ and downloads
it to local file \f(CW`tarball\*(C'.

Use \f(CW`-\*(C' instead of a filename to read/write from stdin/stdout.

_This function is deprecated._
In new code, use the tar-out\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="touch"></a>

### touch

.IX Subsection "touch"
.Vb 1
 touch path
.Ve

Touch acts like the **touch**\|(1) command.  It can be used to
update the timestamps on a file, or, if the file does not exist,
to create a new zero-length file.

This command only works on regular files, and will fail on other
file types such as directories, symbolic links, block special etc.

<a name="truncate"></a>

### truncate

.IX Subsection "truncate"
.Vb 1
 truncate path
.Ve

This command truncates \f(CW`path\*(C' to a zero-length file.  The
file must exist already.

<a name="truncate-size"></a>

### truncate-size

.IX Subsection "truncate-size"
.Vb 1
 truncate-size path size
.Ve

This command truncates \f(CW`path\*(C' to size \f(CW\*(C\`size\*(C' bytes.  The file
must exist already.

If the current file size is less than \f(CW`size\*(C' then
the file is extended to the required size with zero bytes.
This creates a sparse file (ie. disk blocks are not allocated
for the file until you write to it).  To create a non-sparse
file of zeroes, use fallocate64\*(R" instead.

<a name="tune2fs"></a>

### tune2fs

.IX Subsection "tune2fs"
.Vb 1
 tune2fs device [force:true|false] [maxmountcount:N] [mountcount:N] [errorbehavior:..] [group:N] [intervalbetweenchecks:N] [reservedblockspercentage:N] [lastmounteddirectory:..] [reservedblockscount:N] [user:N]
.Ve

This call allows you to adjust various filesystem parameters of
an ext2/ext3/ext4 filesystem called \f(CW`device\*(C'.

The optional parameters are:
.ie n .IP """force""" 4
.el .IP "\f(CWforce" 4
.IX Item "force"
Force tune2fs to complete the operation even in the face of errors.
This is the same as the tune2fs \f(CW`-f\*(C' option.
.ie n .IP """maxmountcount""" 4
.el .IP "\f(CWmaxmountcount" 4
.IX Item "maxmountcount"
Set the number of mounts after which the filesystem is checked
by **e2fsck**\|(8).  If this is \f(CW0 then the number of mounts is
disregarded.  This is the same as the tune2fs \f(CW`-c\*(C' option.
.ie n .IP """mountcount""" 4
.el .IP "\f(CWmountcount" 4
.IX Item "mountcount"
Set the number of times the filesystem has been mounted.
This is the same as the tune2fs \f(CW`-C\*(C' option.
.ie n .IP """errorbehavior""" 4
.el .IP "\f(CWerrorbehavior" 4
.IX Item "errorbehavior"
Change the behavior of the kernel code when errors are detected.
Possible values currently are: \f(CW`continue\*(C', \f(CW\*(C\`remount-ro\*(C', \f(CW\*(C\`panic\*(C'.
In practice these options don't really make any difference,
particularly for write errors.
.Sp
This is the same as the tune2fs \f(CW`-e\*(C' option.
.ie n .IP """group""" 4
.el .IP "\f(CWgroup" 4
.IX Item "group"
Set the group which can use reserved filesystem blocks.
This is the same as the tune2fs \f(CW`-g\*(C' option except that it
can only be specified as a number.
.ie n .IP """intervalbetweenchecks""" 4
.el .IP "\f(CWintervalbetweenchecks" 4
.IX Item "intervalbetweenchecks"
Adjust the maximal time between two filesystem checks
(in seconds).  If the option is passed as \f(CW0 then
time-dependent checking is disabled.
.Sp
This is the same as the tune2fs \f(CW`-i\*(C' option.
.ie n .IP """reservedblockspercentage""" 4
.el .IP "\f(CWreservedblockspercentage" 4
.IX Item "reservedblockspercentage"
Set the percentage of the filesystem which may only be allocated
by privileged processes.
This is the same as the tune2fs \f(CW`-m\*(C' option.
.ie n .IP """lastmounteddirectory""" 4
.el .IP "\f(CWlastmounteddirectory" 4
.IX Item "lastmounteddirectory"
Set the last mounted directory.
This is the same as the tune2fs \f(CW`-M\*(C' option.
.ie n .IP """reservedblockscount"" Set the number of reserved filesystem blocks. This is the same as the tune2fs ""-r"" option." 4
.el .IP "\f(CWreservedblockscount Set the number of reserved filesystem blocks. This is the same as the tune2fs \f(CW-r option." 4
.IX Item "reservedblockscount Set the number of reserved filesystem blocks. This is the same as the tune2fs -r option."
.ie n .IP """user""" 4
.el .IP "\f(CWuser" 4
.IX Item "user"
Set the user who can use the reserved filesystem blocks.
This is the same as the tune2fs \f(CW`-u\*(C' option except that it
can only be specified as a number.

To get the current values of filesystem parameters, see
tune2fs-l\*(R".  For precise details of how tune2fs
works, see the **tune2fs**\|(8) man page.

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

<a name="tune2fs-l"></a>

### tune2fs\-l

.IX Subsection "tune2fs-l"
.Vb 1
 tune2fs-l device
.Ve

This returns the contents of the ext2, ext3 or ext4 filesystem
superblock on \f(CW`device\*(C'.

It is the same as running \f(CW`tune2fs -l device\*(C'.  See **tune2fs**\|(8)
manpage for more details.  The list of fields returned isn't
clearly defined, and depends on both the version of \f(CW`tune2fs\*(C'
that libguestfs was built against, and the filesystem itself.

<a name="txz-in"></a>

### txz-in

.IX Subsection "txz-in"
.Vb 1
 txz-in (tarball|-) directory
.Ve

This command uploads and unpacks local file \f(CW`tarball\*(C' (an
_xz compressed_ tar file) into _directory_.

Use \f(CW`-\*(C' instead of a filename to read/write from stdin/stdout.

_This function is deprecated._
In new code, use the tar-in\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

This command depends on the feature \f(CW`xz\*(C'.   See also
feature-available\*(R".

<a name="txz-out"></a>

### txz-out

.IX Subsection "txz-out"
.Vb 1
 txz-out directory (tarball|-)
.Ve

This command packs the contents of _directory_ and downloads
it to local file \f(CW`tarball\*(C' (as an xz compressed tar archive).

Use \f(CW`-\*(C' instead of a filename to read/write from stdin/stdout.

_This function is deprecated._
In new code, use the tar-out\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

This command depends on the feature \f(CW`xz\*(C'.   See also
feature-available\*(R".

<a name="umask"></a>

### umask

.IX Subsection "umask"
.Vb 1
 umask mask
.Ve

This function sets the mask used for creating new files and
device nodes to \f(CW`mask & 0777\*(C'.

Typical umask values would be \f(CW022 which creates new files
with permissions like -rw-r\*(--r--\*(R" or \*(L"-rwxr-xr-x\*(R", and
\f(CW002 which creates new files with permissions like
-rw-rw-r--\*(R" or \*(L"-rwxrwxr-x\*(R".

The default umask is \f(CW022.  This is important because it
means that directories and device nodes will be created with
\f(CW0644 or \f(CW0755 mode even if you specify \f(CW0777.

See also get-umask\*(R",
**umask**\|(2), mknod\*(R", \*(L"mkdir\*(R".

This call returns the previous umask.

<a name="umount"></a>

### umount

.IX Subsection "umount"

<a name="unmount"></a>

### unmount

.IX Subsection "unmount"

<a name="umount-opts"></a>

### umount-opts

.IX Subsection "umount-opts"
.Vb 1
 umount pathordevice [force:true|false] [lazyunmount:true|false]
.Ve

This unmounts the given filesystem.  The filesystem may be
specified either by its mountpoint (path) or the device which
contains the filesystem.

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

<a name="umount-all"></a>

### umount-all

.IX Subsection "umount-all"

<a name="unmount-all"></a>

### unmount-all

.IX Subsection "unmount-all"
.Vb 1
 umount-all
.Ve

This unmounts all mounted filesystems.

Some internal mounts are not unmounted by this call.

<a name="umount-local"></a>

### umount-local

.IX Subsection "umount-local"
.Vb 1
 umount-local [retry:true|false]
.Ve

If libguestfs is exporting the filesystem on a local
mountpoint, then this unmounts it.

See \s-1MOUNT LOCAL\*(R"\s0 in **guestfs**\|(3) for full documentation.

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

<a name="upload"></a>

### upload

.IX Subsection "upload"
.Vb 1
 upload (filename|-) remotefilename
.Ve

Upload local file _filename_ to _remotefilename_ on the
filesystem.

_filename_ can also be a named pipe.

See also download\*(R".

Use \f(CW`-\*(C' instead of a filename to read/write from stdin/stdout.

<a name="upload-offset"></a>

### upload-offset

.IX Subsection "upload-offset"
.Vb 1
 upload-offset (filename|-) remotefilename offset
.Ve

Upload local file _filename_ to _remotefilename_ on the
filesystem.

_remotefilename_ is overwritten starting at the byte \f(CW`offset\*(C'
specified.  The intention is to overwrite parts of existing
files or devices, although if a non-existent file is specified
then it is created with a hole\*(R" before \f(CW\*(C\`offset\*(C'.  The
size of the data written is implicit in the size of the
source _filename_.

Note that there is no limit on the amount of data that
can be uploaded with this call, unlike with pwrite\*(R",
and this call always writes the full amount unless an
error occurs.

See also upload\*(R", \*(L"pwrite\*(R".

Use \f(CW`-\*(C' instead of a filename to read/write from stdin/stdout.

<a name="user-cancel"></a>

### user-cancel

.IX Subsection "user-cancel"
.Vb 1
 user-cancel
.Ve

This function cancels the current upload or download operation.

Unlike most other libguestfs calls, this function is signal safe and
thread safe.  You can call it from a signal handler or from another
thread, without needing to do any locking.

The transfer that was in progress (if there is one) will stop shortly
afterwards, and will return an error.  The errno (see
guestfs_last_errno\*(R") is set to \f(CW\*(C\`EINTR\*(C', so you can test for this
to find out if the operation was cancelled or failed because of
another error.

No cleanup is performed: for example, if a file was being uploaded
then after cancellation there may be a partially uploaded file.  It is
the caller’s responsibility to clean up if necessary.

There are two common places that you might call user-cancel\*(R":

In an interactive text-based program, you might call it from a
\f(CW`SIGINT\*(C' signal handler so that pressing \f(CW\*(C\`^C\*(C' cancels the current
operation.  (You also need to call guestfs_set_pgroup\*(R" so that
child processes don't receive the \f(CW`^C\*(C' signal).

In a graphical program, when the main thread is displaying a progress
bar with a cancel button, wire up the cancel button to call this
function.

<a name="utimens"></a>

### utimens

.IX Subsection "utimens"
.Vb 1
 utimens path atsecs atnsecs mtsecs mtnsecs
.Ve

This command sets the timestamps of a file with nanosecond
precision.

\f(CW`atsecs, atnsecs\*(C' are the last access time (atime) in secs and
nanoseconds from the epoch.

\f(CW`mtsecs, mtnsecs\*(C' are the last modification time (mtime) in
secs and nanoseconds from the epoch.

If the \f(CW*nsecs field contains the special value \f(CW`-1\*(C' then
the corresponding timestamp is set to the current time.  (The
\f(CW*secs field is ignored in this case).

If the \f(CW*nsecs field contains the special value \f(CW`-2\*(C' then
the corresponding timestamp is left unchanged.  (The
\f(CW*secs field is ignored in this case).

<a name="utsname"></a>

### utsname

.IX Subsection "utsname"
.Vb 1
 utsname
.Ve

This returns the kernel version of the appliance, where this is
available.  This information is only useful for debugging.  Nothing
in the returned structure is defined by the \s-1API.\s0

<a name="version"></a>

### version

.IX Subsection "version"
.Vb 1
 version
.Ve

Return the libguestfs version number that the program is linked
against.

Note that because of dynamic linking this is not necessarily
the version of libguestfs that you compiled against.  You can
compile the program, and then at runtime dynamically link
against a completely different _libguestfs.so_ library.

This call was added in version \f(CW1.0.58.  In previous
versions of libguestfs there was no way to get the version
number.  From C code you can use dynamic linker functions
to find out if this symbol exists (if it doesn't, then
it’s an earlier version).

The call returns a structure with four elements.  The first
three (\f(CW`major\*(C', \f(CW\*(C\`minor\*(C' and \f(CW\*(C\`release\*(C') are numbers and
correspond to the usual version triplet.  The fourth element
(\f(CW`extra\*(C') is a string and is normally empty, but may be
used for distro-specific information.

To construct the original version string:
\f(CW`$major.$minor.$release$extra\*(C'

See also: \s-1LIBGUESTFS VERSION NUMBERS\*(R"\s0 in **guestfs**\|(3).

_Note:_ Don't use this call to test for availability
of features.  In enterprise distributions we backport
features from later versions into earlier versions,
making this an unreliable way to test for features.
Use available\*(R" or \*(L"feature-available\*(R" instead.

<a name="vfs-label"></a>

### vfs-label

.IX Subsection "vfs-label"
.Vb 1
 vfs-label mountable
.Ve

This returns the label of the filesystem on \f(CW`mountable\*(C'.

If the filesystem is unlabeled, this returns the empty string.

To find a filesystem from the label, use findfs-label\*(R".

<a name="vfs-minimum-size"></a>

### vfs-minimum-size

.IX Subsection "vfs-minimum-size"
.Vb 1
 vfs-minimum-size mountable
.Ve

Get the minimum size of filesystem in bytes.
This is the minimum possible size for filesystem shrinking.

If getting minimum size of specified filesystem is not supported,
this will fail and set errno as \s-1ENOTSUP.\s0

See also **ntfsresize**\|(8), **resize2fs**\|(8), **btrfs**\|(8), **xfs\_info**\|(8).

<a name="vfs-type"></a>

### vfs-type

.IX Subsection "vfs-type"
.Vb 1
 vfs-type mountable
.Ve

This command gets the filesystem type corresponding to
the filesystem on \f(CW`mountable\*(C'.

For most filesystems, the result is the name of the Linux
\s-1VFS\s0 module which would be used to mount this filesystem
if you mounted it without specifying the filesystem type.
For example a string such as \f(CW`ext3\*(C' or \f(CW\*(C\`ntfs\*(C'.

<a name="vfs-uuid"></a>

### vfs-uuid

.IX Subsection "vfs-uuid"

<a name="get-uuid"></a>

### get-uuid

.IX Subsection "get-uuid"
.Vb 1
 vfs-uuid mountable
.Ve

This returns the filesystem \s-1UUID\s0 of the filesystem on \f(CW`mountable\*(C'.

If the filesystem does not have a \s-1UUID,\s0 this returns the empty string.

To find a filesystem from the \s-1UUID,\s0 use findfs-uuid\*(R".

<a name="vg-activate"></a>

### vg-activate

.IX Subsection "vg-activate"
.Vb 1
 vg-activate true|false volgroups ...\*(Aq
.Ve

This command activates or (if \f(CW`activate\*(C' is false) deactivates
all logical volumes in the listed volume groups \f(CW`volgroups\*(C'.

This command is the same as running \f(CW`vgchange -a y|n volgroups...\*(C'

Note that if \f(CW`volgroups\*(C' is an empty list then **all** volume groups
are activated or deactivated.

This command depends on the feature \f(CW`lvm2\*(C'.   See also
feature-available\*(R".

<a name="vg-activate-all"></a>

### vg-activate-all

.IX Subsection "vg-activate-all"
.Vb 1
 vg-activate-all true|false
.Ve

This command activates or (if \f(CW`activate\*(C' is false) deactivates
all logical volumes in all volume groups.

This command is the same as running \f(CW`vgchange -a y|n\*(C'

This command depends on the feature \f(CW`lvm2\*(C'.   See also
feature-available\*(R".

<a name="vgchange-uuid"></a>

### vgchange-uuid

.IX Subsection "vgchange-uuid"
.Vb 1
 vgchange-uuid vg
.Ve

Generate a new random \s-1UUID\s0 for the volume group \f(CW`vg\*(C'.

This command depends on the feature \f(CW`lvm2\*(C'.   See also
feature-available\*(R".

<a name="vgchange-uuid-all"></a>

### vgchange-uuid-all

.IX Subsection "vgchange-uuid-all"
.Vb 1
 vgchange-uuid-all
.Ve

Generate new random UUIDs for all volume groups.

This command depends on the feature \f(CW`lvm2\*(C'.   See also
feature-available\*(R".

<a name="vgcreate"></a>

### vgcreate

.IX Subsection "vgcreate"
.Vb 1
 vgcreate volgroup physvols ...\*(Aq
.Ve

This creates an \s-1LVM\s0 volume group called \f(CW`volgroup\*(C'
from the non-empty list of physical volumes \f(CW`physvols\*(C'.

This command depends on the feature \f(CW`lvm2\*(C'.   See also
feature-available\*(R".

<a name="vglvuuids"></a>

### vglvuuids

.IX Subsection "vglvuuids"
.Vb 1
 vglvuuids vgname
.Ve

Given a \s-1VG\s0 called \f(CW`vgname\*(C', this returns the UUIDs of all
the logical volumes created in this volume group.

You can use this along with lvs\*(R" and \*(L"lvuuid\*(R"
calls to associate logical volumes and volume groups.

See also vgpvuuids\*(R".

<a name="vgmeta"></a>

### vgmeta

.IX Subsection "vgmeta"
.Vb 1
 vgmeta vgname
.Ve

\f(CW`vgname\*(C' is an \s-1LVM\s0 volume group.  This command examines the
volume group and returns its metadata.

Note that the metadata is an internal structure used by \s-1LVM,\s0
subject to change at any time, and is provided for information only.

This command depends on the feature \f(CW`lvm2\*(C'.   See also
feature-available\*(R".

<a name="vgpvuuids"></a>

### vgpvuuids

.IX Subsection "vgpvuuids"
.Vb 1
 vgpvuuids vgname
.Ve

Given a \s-1VG\s0 called \f(CW`vgname\*(C', this returns the UUIDs of all
the physical volumes that this volume group resides on.

You can use this along with pvs\*(R" and \*(L"pvuuid\*(R"
calls to associate physical volumes and volume groups.

See also vglvuuids\*(R".

<a name="vgremove"></a>

### vgremove

.IX Subsection "vgremove"
.Vb 1
 vgremove vgname
.Ve

Remove an \s-1LVM\s0 volume group \f(CW`vgname\*(C', (for example \f(CW\*(C\`VG\*(C').

This also forcibly removes all logical volumes in the volume
group (if any).

This command depends on the feature \f(CW`lvm2\*(C'.   See also
feature-available\*(R".

<a name="vgrename"></a>

### vgrename

.IX Subsection "vgrename"
.Vb 1
 vgrename volgroup newvolgroup
.Ve

Rename a volume group \f(CW`volgroup\*(C' with the new name \f(CW\*(C\`newvolgroup\*(C'.

<a name="vgs"></a>

### vgs

.IX Subsection "vgs"
.Vb 1
 vgs
.Ve

List all the volumes groups detected.  This is the equivalent
of the **vgs**\|(8) command.

This returns a list of just the volume group names that were
detected (eg. \f(CW`VolGroup00\*(C').

See also vgs-full\*(R".

This command depends on the feature \f(CW`lvm2\*(C'.   See also
feature-available\*(R".

<a name="vgs-full"></a>

### vgs-full

.IX Subsection "vgs-full"
.Vb 1
 vgs-full
.Ve

List all the volumes groups detected.  This is the equivalent
of the **vgs**\|(8) command.  The full\*(R" version includes all fields.

This command depends on the feature \f(CW`lvm2\*(C'.   See also
feature-available\*(R".

<a name="vgscan"></a>

### vgscan

.IX Subsection "vgscan"
.Vb 1
 vgscan
.Ve

This rescans all block devices and rebuilds the list of \s-1LVM\s0
physical volumes, volume groups and logical volumes.

_This function is deprecated._
In new code, use the lvm-scan\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="vguuid"></a>

### vguuid

.IX Subsection "vguuid"
.Vb 1
 vguuid vgname
.Ve

This command returns the \s-1UUID\s0 of the \s-1LVM VG\s0 named \f(CW`vgname\*(C'.

<a name="wc-c"></a>

### wc-c

.IX Subsection "wc-c"
.Vb 1
 wc-c path
.Ve

This command counts the characters in a file, using the
\f(CW`wc -c\*(C' external command.

<a name="wc-l"></a>

### wc-l

.IX Subsection "wc-l"
.Vb 1
 wc-l path
.Ve

This command counts the lines in a file, using the
\f(CW`wc -l\*(C' external command.

<a name="wc-w"></a>

### wc-w

.IX Subsection "wc-w"
.Vb 1
 wc-w path
.Ve

This command counts the words in a file, using the
\f(CW`wc -w\*(C' external command.

<a name="wipefs"></a>

### wipefs

.IX Subsection "wipefs"
.Vb 1
 wipefs device
.Ve

This command erases filesystem or \s-1RAID\s0 signatures from
the specified \f(CW`device\*(C' to make the filesystem invisible to libblkid.

This does not erase the filesystem itself nor any other data from the
\f(CW`device\*(C'.

Compare with zero\*(R" which zeroes the first few blocks of a
device.

This command depends on the feature \f(CW`wipefs\*(C'.   See also
feature-available\*(R".

<a name="write"></a>

### write

.IX Subsection "write"
.Vb 1
 write path content
.Ve

This call creates a file called \f(CW`path\*(C'.  The content of the
file is the string \f(CW`content\*(C' (which can contain any 8 bit data).

See also write-append\*(R".

<a name="write-append"></a>

### write-append

.IX Subsection "write-append"
.Vb 1
 write-append path content
.Ve

This call appends \f(CW`content\*(C' to the end of file \f(CW\*(C\`path\*(C'.  If
\f(CW`path\*(C' does not exist, then a new file is created.

See also write\*(R".

<a name="write-file"></a>

### write-file

.IX Subsection "write-file"
.Vb 1
 write-file path content size
.Ve

This call creates a file called \f(CW`path\*(C'.  The contents of the
file is the string \f(CW`content\*(C' (which can contain any 8 bit data),
with length \f(CW`size\*(C'.

As a special case, if \f(CW`size\*(C' is \f(CW0
then the length is calculated using \f(CW`strlen\*(C' (so in this case
the content cannot contain embedded \s-1ASCII\s0 NULs).

_\s-1NB.\s0_ Owing to a bug, writing content containing \s-1ASCII NUL\s0
characters does _not_ work, even if the length is specified.

Because of the message protocol, there is a transfer limit
of somewhere between 2MB and 4MB.  See \s-1PROTOCOL LIMITS\*(R"\s0 in **guestfs**\|(3).

_This function is deprecated._
In new code, use the write\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="xfs-admin"></a>

### xfs-admin

.IX Subsection "xfs-admin"
.Vb 1
 xfs-admin device [extunwritten:true|false] [imgfile:true|false] [v2log:true|false] [projid32bit:true|false] [lazycounter:true|false] [label:..] [uuid:..]
.Ve

Change the parameters of the \s-1XFS\s0 filesystem on \f(CW`device\*(C'.

Devices that are mounted cannot be modified.
Administrators must unmount filesystems before this call
can modify parameters.

Some of the parameters of a mounted filesystem can be examined
and modified using the xfs-info\*(R" and
xfs-growfs\*(R" calls.

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

This command depends on the feature \f(CW`xfs\*(C'.   See also
feature-available\*(R".

<a name="xfs-growfs"></a>

### xfs-growfs

.IX Subsection "xfs-growfs"
.Vb 1
 xfs-growfs path [datasec:true|false] [logsec:true|false] [rtsec:true|false] [datasize:N] [logsize:N] [rtsize:N] [rtextsize:N] [maxpct:N]
.Ve

Grow the \s-1XFS\s0 filesystem mounted at \f(CW`path\*(C'.

The returned struct contains geometry information.  Missing
fields are returned as \f(CW`-1\*(C' (for numeric fields) or empty
string.

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

This command depends on the feature \f(CW`xfs\*(C'.   See also
feature-available\*(R".

<a name="xfs-info"></a>

### xfs-info

.IX Subsection "xfs-info"
.Vb 1
 xfs-info pathordevice
.Ve

\f(CW`pathordevice\*(C' is a mounted \s-1XFS\s0 filesystem or a device containing
an \s-1XFS\s0 filesystem.  This command returns the geometry of the filesystem.

The returned struct contains geometry information.  Missing
fields are returned as \f(CW`-1\*(C' (for numeric fields) or empty
string.

This command depends on the feature \f(CW`xfs\*(C'.   See also
feature-available\*(R".

<a name="xfs-repair"></a>

### xfs-repair

.IX Subsection "xfs-repair"
.Vb 1
 xfs-repair device [forcelogzero:true|false] [nomodify:true|false] [noprefetch:true|false] [forcegeometry:true|false] [maxmem:N] [ihashsize:N] [bhashsize:N] [agstride:N] [logdev:..] [rtdev:..]
.Ve

Repair corrupt or damaged \s-1XFS\s0 filesystem on \f(CW`device\*(C'.

The filesystem is specified using the \f(CW`device\*(C' argument which should be
the device name of the disk partition or volume containing the filesystem.
If given the name of a block device, \f(CW`xfs\_repair\*(C' will attempt to find
the raw device associated with the specified block device and will use
the raw device instead.

Regardless, the filesystem to be repaired must be unmounted, otherwise,
the resulting filesystem may be inconsistent or corrupt.

The returned status indicates whether filesystem corruption was
detected (returns \f(CW1) or was not detected (returns \f(CW0).

This command has one or more optional arguments.  See \s-1OPTIONAL ARGUMENTS\*(R"\s0.

This command depends on the feature \f(CW`xfs\*(C'.   See also
feature-available\*(R".

<a name="yara-destroy"></a>

### yara-destroy

.IX Subsection "yara-destroy"
.Vb 1
 yara-destroy
.Ve

Destroy previously loaded Yara rules in order to free libguestfs resources.

This command depends on the feature \f(CW`libyara\*(C'.   See also
feature-available\*(R".

<a name="yara-load"></a>

### yara-load

.IX Subsection "yara-load"
.Vb 1
 yara-load (filename|-)
.Ve

Upload a set of Yara rules from local file _filename_.

Yara rules allow to categorize files based on textual or binary patterns
within their content.
See yara-scan\*(R" to see how to scan files with the loaded rules.

Rules can be in binary format, as when compiled with yarac command, or
in source code format. In the latter case, the rules will be first
compiled and then loaded.

Rules in source code format cannot include external files. In such cases,
it is recommended to compile them first.

Previously loaded rules will be destroyed.

Use \f(CW`-\*(C' instead of a filename to read/write from stdin/stdout.

This command depends on the feature \f(CW`libyara\*(C'.   See also
feature-available\*(R".

<a name="yara-scan"></a>

### yara-scan

.IX Subsection "yara-scan"
.Vb 1
 yara-scan path
.Ve

Scan a file with the previously loaded Yara rules.

For each matching rule, a \f(CW`yara\_detection\*(C' structure is returned.

The \f(CW`yara\_detection\*(C' structure contains the following fields.
.ie n .IP """yara_name""" 4
.el .IP "\f(CWyara\_name" 4
.IX Item "yara_name"
Path of the file matching a Yara rule.
.ie n .IP """yara_rule""" 4
.el .IP "\f(CWyara\_rule" 4
.IX Item "yara_rule"
Identifier of the Yara rule which matched against the given file.

This command depends on the feature \f(CW`libyara\*(C'.   See also
feature-available\*(R".

<a name="zegrep"></a>

### zegrep

.IX Subsection "zegrep"
.Vb 1
 zegrep regex path
.Ve

This calls the external \f(CW`zegrep\*(C' program and returns the
matching lines.

Because of the message protocol, there is a transfer limit
of somewhere between 2MB and 4MB.  See \s-1PROTOCOL LIMITS\*(R"\s0 in **guestfs**\|(3).

_This function is deprecated._
In new code, use the grep\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="zegrepi"></a>

### zegrepi

.IX Subsection "zegrepi"
.Vb 1
 zegrepi regex path
.Ve

This calls the external \f(CW`zegrep -i\*(C' program and returns the
matching lines.

Because of the message protocol, there is a transfer limit
of somewhere between 2MB and 4MB.  See \s-1PROTOCOL LIMITS\*(R"\s0 in **guestfs**\|(3).

_This function is deprecated._
In new code, use the grep\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="zero"></a>

### zero

.IX Subsection "zero"
.Vb 1
 zero device
.Ve

This command writes zeroes over the first few blocks of \f(CW`device\*(C'.

How many blocks are zeroed isn't specified (but it’s _not_ enough
to securely wipe the device).  It should be sufficient to remove
any partition tables, filesystem superblocks and so on.

If blocks are already zero, then this command avoids writing
zeroes.  This prevents the underlying device from becoming non-sparse
or growing unnecessarily.

See also: zero-device\*(R", \*(L"scrub-device\*(R",
is-zero-device\*(R"

<a name="zero-device"></a>

### zero-device

.IX Subsection "zero-device"
.Vb 1
 zero-device device
.Ve

This command writes zeroes over the entire \f(CW`device\*(C'.  Compare
with zero\*(R" which just zeroes the first few blocks of
a device.

If blocks are already zero, then this command avoids writing
zeroes.  This prevents the underlying device from becoming non-sparse
or growing unnecessarily.

<a name="zero-free-space"></a>

### zero-free-space

.IX Subsection "zero-free-space"
.Vb 1
 zero-free-space directory
.Ve

Zero the free space in the filesystem mounted on _directory_.
The filesystem must be mounted read-write.

The filesystem contents are not affected, but any free space
in the filesystem is freed.

Free space is not trimmed\*(R".  You may want to call
fstrim\*(R" either as an alternative to this,
or after calling this, depending on your requirements.

<a name="zerofree"></a>

### zerofree

.IX Subsection "zerofree"
.Vb 1
 zerofree device
.Ve

This runs the _zerofree_ program on \f(CW`device\*(C'.  This program
claims to zero unused inodes and disk blocks on an ext2/3
filesystem, thus making it possible to compress the filesystem
more effectively.

You should **not** run this program if the filesystem is
mounted.

It is possible that using this program can damage the filesystem
or data on the filesystem.

This command depends on the feature \f(CW`zerofree\*(C'.   See also
feature-available\*(R".

<a name="zfgrep"></a>

### zfgrep

.IX Subsection "zfgrep"
.Vb 1
 zfgrep pattern path
.Ve

This calls the external \f(CW`zfgrep\*(C' program and returns the
matching lines.

Because of the message protocol, there is a transfer limit
of somewhere between 2MB and 4MB.  See \s-1PROTOCOL LIMITS\*(R"\s0 in **guestfs**\|(3).

_This function is deprecated._
In new code, use the grep\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="zfgrepi"></a>

### zfgrepi

.IX Subsection "zfgrepi"
.Vb 1
 zfgrepi pattern path
.Ve

This calls the external \f(CW`zfgrep -i\*(C' program and returns the
matching lines.

Because of the message protocol, there is a transfer limit
of somewhere between 2MB and 4MB.  See \s-1PROTOCOL LIMITS\*(R"\s0 in **guestfs**\|(3).

_This function is deprecated._
In new code, use the grep\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="zfile"></a>

### zfile

.IX Subsection "zfile"
.Vb 1
 zfile meth path
.Ve

This command runs _file_ after first decompressing \f(CW`path\*(C'
using \f(CW`method\*(C'.

\f(CW`method\*(C' must be one of \f(CW\*(C\`gzip\*(C', \f(CW\*(C\`compress\*(C' or \f(CW\*(C\`bzip2\*(C'.

Since 1.0.63, use file\*(R" instead which can now
process compressed files.

_This function is deprecated._
In new code, use the file\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="zgrep"></a>

### zgrep

.IX Subsection "zgrep"
.Vb 1
 zgrep regex path
.Ve

This calls the external \f(CW`zgrep\*(C' program and returns the
matching lines.

Because of the message protocol, there is a transfer limit
of somewhere between 2MB and 4MB.  See \s-1PROTOCOL LIMITS\*(R"\s0 in **guestfs**\|(3).

_This function is deprecated._
In new code, use the grep\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="zgrepi"></a>

### zgrepi

.IX Subsection "zgrepi"
.Vb 1
 zgrepi regex path
.Ve

This calls the external \f(CW`zgrep -i\*(C' program and returns the
matching lines.

Because of the message protocol, there is a transfer limit
of somewhere between 2MB and 4MB.  See \s-1PROTOCOL LIMITS\*(R"\s0 in **guestfs**\|(3).

_This function is deprecated._
In new code, use the grep\*(R" call instead.

Deprecated functions will not be removed from the \s-1API,\s0 but the
fact that they are deprecated indicates that there are problems
with correct use of these functions.

<a name="exit-status"></a>

# Exit Status

.IX Header "EXIT STATUS"
guestfish returns 0 if the commands completed without error, or
1 if there was an error.

<a name="environment-variables"></a>

# Environment Variables

.IX Header "ENVIRONMENT VARIABLES"

* \s-1EDITOR\s0  
  .IX Item "EDITOR"
  The \f(CW`edit\*(C' command uses \f(CW$EDITOR as the editor.  If not
  set, it uses \f(CW`vi\*(C'.
* \s-1GUESTFISH_DISPLAY_IMAGE\s0  
  .IX Item "GUESTFISH_DISPLAY_IMAGE"
  The \f(CW`display\*(C' command uses \f(CW$GUESTFISH\_DISPLAY\_IMAGE to
  display images.  If not set, it uses **display**\|(1).
* \s-1GUESTFISH_INIT\s0  
  .IX Item "GUESTFISH_INIT"
  Printed when guestfish starts.  See \s-1PROMPT\*(R"\s0.
* \s-1GUESTFISH_OUTPUT\s0  
  .IX Item "GUESTFISH_OUTPUT"
  Printed before guestfish output.  See \s-1PROMPT\*(R"\s0.
* \s-1GUESTFISH_PID\s0  
  .IX Item "GUESTFISH_PID"
  Used with the _--remote_ option to specify the remote guestfish
  process to control.  See section
  \s-1REMOTE CONTROL GUESTFISH OVER A SOCKET\*(R"\s0.
* \s-1GUESTFISH_PS1\s0  
  .IX Item "GUESTFISH_PS1"
  Set the command prompt.  See \s-1PROMPT\*(R"\s0.
* \s-1GUESTFISH_RESTORE\s0  
  .IX Item "GUESTFISH_RESTORE"
  Printed before guestfish exits.  See \s-1PROMPT\*(R"\s0.
* \s-1HEXEDITOR\s0  
  .IX Item "HEXEDITOR"
  The hexedit\*(R" command uses \f(CW$HEXEDITOR as the external hex
  editor.  If not specified, the external **hexedit**\|(1) program
  is used.
* \s-1HOME\s0  
  .IX Item "HOME"
  If compiled with \s-1GNU\s0 readline support, various files in the
  home directory can be used.  See \s-1FILES\*(R"\s0.
* \s-1LIBGUESTFS_APPEND\s0  
  .IX Item "LIBGUESTFS_APPEND"
  Pass additional options to the guest kernel.
* \s-1LIBGUESTFS_ATTACH_METHOD\s0  
  .IX Item "LIBGUESTFS_ATTACH_METHOD"
  This is the old way to set \f(CW`LIBGUESTFS\_BACKEND\*(C'.
* \s-1LIBGUESTFS_BACKEND\s0  
  .IX Item "LIBGUESTFS_BACKEND"
  Choose the default way to create the appliance.  See
  guestfs_set_backend\*(R" in **guestfs**\|(3).
* \s-1LIBGUESTFS_BACKEND_SETTINGS\s0  
  .IX Item "LIBGUESTFS_BACKEND_SETTINGS"
  A colon-separated list of backend-specific settings.
  See \s-1BACKEND\*(R"\s0 in **guestfs**\|(3), \*(L"\s-1BACKEND SETTINGS\*(R"\s0 in **guestfs**\|(3).
* \s-1LIBGUESTFS_CACHEDIR\s0  
  .IX Item "LIBGUESTFS_CACHEDIR"
  The location where libguestfs will cache its appliance, when
  using a supermin appliance.  The appliance is cached and shared
  between all handles which have the same effective user \s-1ID.\s0
  .Sp
  If \f(CW`LIBGUESTFS\_CACHEDIR\*(C' is not set, then \f(CW\*(C\`TMPDIR\*(C' is used.  If
  \f(CW`TMPDIR\*(C' is not set, then _/var/tmp_ is used.
  .Sp
  See also \s-1LIBGUESTFS_TMPDIR\*(R"\s0, \*(L"set-cachedir\*(R".
* \s-1LIBGUESTFS_DEBUG\s0  
  .IX Item "LIBGUESTFS_DEBUG"
  Set \f(CW`LIBGUESTFS\_DEBUG=1\*(C' to enable verbose messages.  This has the
  same effect as using the **-v** option.
* \s-1LIBGUESTFS_HV\s0  
  .IX Item "LIBGUESTFS_HV"
  Set the default hypervisor (usually qemu) binary that libguestfs uses.
  If not set, then the qemu which was found at compile time by the
  configure script is used.
* \s-1LIBGUESTFS_MEMSIZE\s0  
  .IX Item "LIBGUESTFS_MEMSIZE"
  Set the memory allocated to the qemu process, in megabytes.  For
  example:
  .Sp
  .Vb 1
   LIBGUESTFS_MEMSIZE=700
  .Ve
* \s-1LIBGUESTFS_PATH\s0  
  .IX Item "LIBGUESTFS_PATH"
  Set the path that guestfish uses to search for kernel and initrd.img.
  See the discussion of paths in **guestfs**\|(3).
* \s-1LIBGUESTFS_QEMU\s0  
  .IX Item "LIBGUESTFS_QEMU"
  This is the old way to set \f(CW`LIBGUESTFS\_HV\*(C'.
* \s-1LIBGUESTFS_TMPDIR\s0  
  .IX Item "LIBGUESTFS_TMPDIR"
  The location where libguestfs will store temporary files used
  by each handle.
  .Sp
  If \f(CW`LIBGUESTFS\_TMPDIR\*(C' is not set, then \f(CW\*(C\`TMPDIR\*(C' is used.  If
  \f(CW`TMPDIR\*(C' is not set, then _/tmp_ is used.
  .Sp
  See also \s-1LIBGUESTFS_CACHEDIR\*(R"\s0, \*(L"set-tmpdir\*(R".
* \s-1LIBGUESTFS_TRACE\s0  
  .IX Item "LIBGUESTFS_TRACE"
  Set \f(CW`LIBGUESTFS\_TRACE=1\*(C' to enable command traces.
* \s-1PAGER\s0  
  .IX Item "PAGER"
  The \f(CW`more\*(C' command uses \f(CW$PAGER as the pager.  If not
  set, it uses \f(CW`more\*(C'.
* \s-1PATH\s0  
  .IX Item "PATH"
  Libguestfs and guestfish may run some external programs, and rely on
  \f(CW$PATH being set to a reasonable value.  If using the libvirt
  backend, libvirt will not work at all unless \f(CW$PATH contains
  the path of qemu/KVM.
* \s-1SUPERMIN_KERNEL\s0  
  .IX Item "SUPERMIN_KERNEL"
* \s-1SUPERMIN_KERNEL_VERSION\s0  
  .IX Item "SUPERMIN_KERNEL_VERSION"
* \s-1SUPERMIN_MODULES\s0  
  .IX Item "SUPERMIN_MODULES"
  These three environment variables allow the kernel that libguestfs
  uses in the appliance to be selected.  If \f(CW$SUPERMIN\_KERNEL is not
  set, then the most recent host kernel is chosen.  For more information
  about kernel selection, see **supermin**\|(1).
* \s-1TMPDIR\s0  
  .IX Item "TMPDIR"
  See \s-1LIBGUESTFS_CACHEDIR\*(R"\s0, \*(L"\s-1LIBGUESTFS_TMPDIR\*(R"\s0.
* \s-1XDG_RUNTIME_DIR\s0  
  .IX Item "XDG_RUNTIME_DIR"
  This directory represents a user-specific directory for storing
  non-essential runtime files.
  .Sp
  If it is set, then is used to store temporary sockets.  Otherwise,
  _/tmp_ is used.
  .Sp
  See also get-sockdir\*(R",
  http://www.freedesktop.org/wiki/Specifications/basedir-spec/.

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
  .ie n .IP "$HOME/.guestfish" 4
  .el .IP "\f(CW$HOME/.guestfish" 4
  .IX Item "$HOME/.guestfish"
  If compiled with \s-1GNU\s0 readline support, then the command history
  is saved in this file.
  .ie n .IP "$HOME/.inputrc" 4
  .el .IP "\f(CW$HOME/.inputrc" 4
  .IX Item "$HOME/.inputrc"
* /etc/inputrc  
  .IX Item "/etc/inputrc"
  If compiled with \s-1GNU\s0 readline support, then these files can be used to
  configure readline.  For further information, please see
  \s-1INITIALIZATION FILE\*(R"\s0 in **readline**\|(3).
  .Sp
  To write rules which only apply to guestfish, use:
  .Sp
  .Vb 3
   $if guestfish
   ...
   $endif
  .Ve
  .Sp
  Variables that you can set in inputrc that change the behaviour
  of guestfish in useful ways include:
    * completion-ignore-case (default: on)  
      .IX Item "completion-ignore-case (default: on)"
      By default, guestfish will ignore case when tab-completing
      paths on the disk.  Use:
      .Sp
      .Vb 1
       set completion-ignore-case off
      .Ve
      .Sp
      to make guestfish case sensitive.
* test1.img  
  .IX Item "test1.img"
* test2.img (etc)  
  .IX Item "test2.img (etc)"
  When using the _-N_ or _--new_ option, the prepared disk or
  filesystem will be created in the file _test1.img_ in the current
  directory.  The second use of _-N_ will use _test2.img_ and so on.
  Any existing file with the same name will be overwritten.  You can use
  a different filename by using the \f(CW`filename=\*(C' prefix.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**guestfs**\|(3),
http://libguestfs.org/,
**virt-alignment-scan**\|(1),
**virt-builder**\|(1),
**virt-builder-repository**\|(1),
**virt-cat**\|(1),
**virt-copy-in**\|(1),
**virt-copy-out**\|(1),
**virt-customize**\|(1),
**virt-df**\|(1),
**virt-diff**\|(1),
**virt-edit**\|(1),
**virt-filesystems**\|(1),
**virt-inspector**\|(1),
**virt-list-filesystems**\|(1),
**virt-list-partitions**\|(1),
**virt-log**\|(1),
**virt-ls**\|(1),
**virt-make-fs**\|(1),
**virt-p2v**\|(1),
**virt-rescue**\|(1),
**virt-resize**\|(1),
**virt-sparsify**\|(1),
**virt-sysprep**\|(1),
**virt-tail**\|(1),
**virt-tar**\|(1),
**virt-tar-in**\|(1),
**virt-tar-out**\|(1),
**virt-v2v**\|(1),
**virt-win-reg**\|(1),
**libguestfs-tools.conf**\|(5),
**display**\|(1),
**hexedit**\|(1),
**supermin**\|(1).

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
