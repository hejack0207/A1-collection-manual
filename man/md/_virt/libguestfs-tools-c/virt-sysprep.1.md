# virt-sysprep(1)

libguestfs-1.40.2, 2019-02-07

.if n .ad l
.nh

<a name="name"></a>

# Name

virt-sysprep - Reset, unconfigure or customize a virtual machine so clones can be made

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" .Vb 1  virt-sysprep [--options] -d domname   virt-sysprep [--options] -a disk.img [-a disk.img ...] .Ve
```

<a name="warning"></a>

# Warning

.IX Header "WARNING"
Using \f(CW`virt-sysprep\*(C'
on live virtual machines, or concurrently with other
disk editing tools, can be dangerous, potentially causing disk
corruption.  The virtual machine must be shut down before you use this
command, and disk images must not be edited concurrently.

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
Virt-sysprep can reset or unconfigure a virtual machine so that
clones can be made from it.  Steps in this process include removing
\s-1SSH\s0 host keys, removing persistent network \s-1MAC\s0 configuration, and
removing user accounts.  Virt-sysprep can also customize a virtual
machine, for instance by adding \s-1SSH\s0 keys, users or logos.  Each step
can be enabled or disabled as required.

Virt-sysprep modifies the guest or disk image _in place_.  The guest
must be shut down.  If you want to preserve the existing contents of
the guest, _you must snapshot, copy or clone the disk first_.  See
\s-1COPYING AND CLONING\*(R"\s0 below.

You do _not_ need to run virt-sysprep as root.  In fact we'd
generally recommend that you don't.  The time you might want to run it
as root is when you need root in order to access the disk image, but
even in this case it would be better to change the permissions on the
disk image to be writable as the non-root user running virt-sysprep.

Sysprep\*(R" stands for \*(L"system preparation\*(R" tool.  The name comes from
the Microsoft program _sysprep.exe_ which is used to unconfigure
Windows machines in preparation for cloning them.  Having said that,
virt-sysprep does _not_ currently work on Microsoft Windows guests.
We plan to support Windows sysprepping in a future version, and we
already have code to do it.

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
  Add _file_ which should be a disk image from a virtual machine.
  .Sp
  The format of the disk image is auto-detected.  To override this and
  force a particular format use the _--format_ option.
* **-a** \s-1URI\s0  
  .IX Item "-a URI"
* **--add** \s-1URI\s0  
  .IX Item "--add URI"
  Add a remote disk.  The \s-1URI\s0 format is compatible with guestfish.
  See \s-1ADDING REMOTE STORAGE\*(R"\s0 in **guestfish**\|(1).
* **--colors**  
  .IX Item "--colors"
* **--colours**  
  .IX Item "--colours"
  Use \s-1ANSI\s0 colour sequences to colourize messages.  This is the default
  when the output is a tty.  If the output of the program is redirected
  to a file, \s-1ANSI\s0 colour sequences are disabled unless you use this
  option.
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
* **-n**  
  .IX Item "-n"
* **--dry-run**  
  .IX Item "--dry-run"
  Perform a read-only dry run\*(R" on the guest.  This runs the sysprep
  operation, but throws away any changes to the disk at the end.
* **--enable** operations  
  .IX Item "--enable operations"
  Choose which sysprep operations to perform.  Give a comma-separated
  list of operations, for example:
  .Sp
  .Vb 1
   --enable ssh-hostkeys,udev-persistent-net
  .Ve
  .Sp
  would enable \s-1ONLY\s0 \f(CW`ssh-hostkeys\*(C' and \f(CW\*(C\`udev-persistent-net\*(C' operations.
  .Sp
  If the _--enable_ option is not given, then we default to trying most
  sysprep operations (see _--list-operations_ to show which are
  enabled).
  .Sp
  Regardless of the _--enable_ option, sysprep operations are skipped
  for some guest types.
  .Sp
  Use _--list-operations_ to list operations supported by a particular
  version of virt-sysprep.
  .Sp
  See \s-1OPERATIONS\*(R"\s0 below for a list and an explanation of each
  operation.
* **--operation** operations  
  .IX Item "--operation operations"
* **--operations** operations  
  .IX Item "--operations operations"
  Choose which sysprep operations to perform.  Give a comma-separated
  list of operations, for example:
  .Sp
  .Vb 1
   --operations ssh-hostkeys,udev-persistent-net
  .Ve
  .Sp
  would enable \s-1ONLY\s0 \f(CW`ssh-hostkeys\*(C' and \f(CW\*(C\`udev-persistent-net\*(C' operations.
  .Sp
  _--operations_ allows you to enable and disable any operation, including
  the default ones (which would be tried when specifying neither
  _--operations_ nor _--enable_) and all the available ones; prepending
  a \f(CW`-\*(C' in front of an operation name removes it from the list of enabled
  operations, while the meta-names \f(CW`defaults\*(C' and \f(CW\*(C\`all\*(C' represent
  respectively the operations enabled by default and all the available ones.
  For example:
  .Sp
  .Vb 1
   --operations firewall-rules,defaults,-tmp-files
  .Ve
  .Sp
  would enable the \f(CW`firewall-rules\*(C' operation (regardless whether it is enabled by
  default), all the default ones, and disable the \f(CW`tmp-files\*(C' operation.
  .Sp
  _--operations_ can be specified multiple times; the first time the set
  of enabled operations is empty, while any further _--operations_ affects
  the operations enabled so far.
  .Sp
  If the _--operations_ option is not given, then we default to trying most
  sysprep operations (see _--list-operations_ to show which are
  enabled).
  .Sp
  Regardless of the _--operations_ option, sysprep operations are skipped
  for some guest types.
  .Sp
  Use _--list-operations_ to list operations supported by a particular
  version of virt-sysprep.
  .Sp
  See \s-1OPERATIONS\*(R"\s0 below for a list and an explanation of each
  operation.
* **--echo-keys**  
  .IX Item "--echo-keys"
  When prompting for keys and passphrases, virt-sysprep normally turns
  echoing off so you cannot see what you are typing.  If you are not
  worried about Tempest attacks and there is no one else in the room
  you can specify this flag to see what you are typing.
* **--format** raw|qcow2|..  
  .IX Item "--format raw|qcow2|.."
* **--format** auto  
  .IX Item "--format auto"
  The default for the _-a_ option is to auto-detect the format of the
  disk image.  Using this forces the disk format for _-a_ options which
  follow on the command line.  Using _--format auto_ switches back to
  auto-detection for subsequent _-a_ options.
  .Sp
  For example:
  .Sp
  .Vb 1
   virt-sysprep --format raw -a disk.img
  .Ve
  .Sp
  forces raw format (no auto-detection) for _disk.img_.
  .Sp
  .Vb 1
   virt-sysprep --format raw -a disk.img --format auto -a another.img
  .Ve
  .Sp
  forces raw format (no auto-detection) for _disk.img_ and reverts to
  auto-detection for _another.img_.
  .Sp
  If you have untrusted raw-format guest disk images, you should use
  this option to specify the disk format.  This avoids a possible
  security problem with malicious guests (\s-1CVE-2010-3851\s0).
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
* **--list-operations**  
  .IX Item "--list-operations"
  List the operations supported by the virt-sysprep program.
  .Sp
  These are listed one per line, with one or more single-space-separated
  fields, eg:
  .Sp
  .Vb 6
   $ virt-sysprep --list-operations
   bash-history * Remove the bash history in the guest
   cron-spool * Remove user at-jobs and cron-jobs
   dhcp-client-state * Remove DHCP client leases
   dhcp-server-state * Remove DHCP server leases
   [etc]
  .Ve
  .Sp
  The first field is the operation name, which can be supplied
  to _--enable_.  The second field is a \f(CW`*\*(C' character if the
  operation is enabled by default or blank if not.  Subsequent
  fields on the same line are the description of the operation.
  .Sp
  Before libguestfs 1.17.33 only the first (operation name) field was
  shown and all operations were enabled by default.
* **--mount-options** mp:opts[;mp:opts;...]  
  .IX Item "--mount-options mp:opts[;mp:opts;...]"
  Set the mount options used when libguestfs opens the disk image.  Note
  this has no effect on the guest.  It is used when opening certain
  guests such as ones using the \s-1UFS\s0 (\s-1BSD\s0) filesystem.
  .Sp
  Use a semicolon-separated list of \f(CW`mountpoint:options\*(C' pairs.
  You may need to quote this list to protect it from the shell.
  .Sp
  For example:
  .Sp
  .Vb 1
   --mount-options "/:noatime"
  .Ve
  .Sp
  will mount the root directory with \f(CW`notime\*(C'.  This example:
  .Sp
  .Vb 1
   --mount-options "/:noatime;/var:rw,nodiratime"
  .Ve
  .Sp
  will do the same, plus mount _/var_ with \f(CW`rw,nodiratime\*(C'.
* **-q**  
  .IX Item "-q"
* **--quiet**  
  .IX Item "--quiet"
  Don’t print log messages.
  .Sp
  To enable detailed logging of individual file operations, use _-x_.
* **--network**  
  .IX Item "--network"
* **--no-network**  
  .IX Item "--no-network"
  Enable or disable network access from the guest during the installation.
  .Sp
  In virt-sysprep, the network is _disabled_ by default.  You must use
  _--network_ to enable it, in order that options such as _--install_
  or _--update_ will work.
  .Sp
  **virt-builder**\|(1) has more information about the security advantages
  of disabling the network.
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
  .ie n .IP "**--append-line** \s-1FILE:LINE\s0 (see ""customize"" below)" 4
  .el .IP "**--append-line** \s-1FILE:LINE\s0 (see \f(CWcustomize below)" 4
  .IX Item "--append-line FILE:LINE (see customize below)"
  Append a single line of text to the \f(CW`FILE\*(C'.  If the file does not already
  end with a newline, then one is added before the appended
  line.  Also a newline is added to the end of the \f(CW`LINE\*(C' string
  automatically.
  .Sp
  For example (assuming ordinary shell quoting) this command:
  .Sp
  .Vb 1
   --append-line /etc/hosts:10.0.0.1 foo\*(Aq
  .Ve
  .Sp
  will add either \f(CW`10.0.0.1 foo⏎\*(C' or \f(CW\*(C\`⏎10.0.0.1 foo⏎\*(C' to
  the file, the latter only if the existing file does not
  already end with a newline.
  .Sp
  \f(CW`⏎\*(C' represents a newline character, which is guessed by
  looking at the existing content of the file, so this command
  does the right thing for files using Unix or Windows line endings.
  It also works for empty or non-existent files.
  .Sp
  To insert several lines, use the same option several times:
  .Sp
  .Vb 2
   --append-line /etc/hosts:10.0.0.1 foo\*(Aq
   --append-line /etc/hosts:10.0.0.2 bar\*(Aq
  .Ve
  .Sp
  To insert a blank line before the appended line, do:
  .Sp
  .Vb 2
   --append-line /etc/hosts:\*(Aq
   --append-line /etc/hosts:10.0.0.1 foo\*(Aq
  .Ve
  .ie n .IP "**--chmod** \s-1PERMISSIONS:FILE\s0 (see ""customize"" below)" 4
  .el .IP "**--chmod** \s-1PERMISSIONS:FILE\s0 (see \f(CWcustomize below)" 4
  .IX Item "--chmod PERMISSIONS:FILE (see customize below)"
  Change the permissions of \f(CW`FILE\*(C' to \f(CW\*(C\`PERMISSIONS\*(C'.
  .Sp
  _Note_: \f(CW`PERMISSIONS\*(C' by default would be decimal, unless you prefix
  it with \f(CW0 to get octal, ie. use \f(CW0700 not \f(CW700.
  .ie n .IP "**--commands-from-file** \s-1FILENAME\s0 (see ""customize"" below)" 4
  .el .IP "**--commands-from-file** \s-1FILENAME\s0 (see \f(CWcustomize below)" 4
  .IX Item "--commands-from-file FILENAME (see customize below)"
  Read the customize commands from a file, one (and its arguments)
  each line.
  .Sp
  Each line contains a single customization command and its arguments,
  for example:
  .Sp
  .Vb 3
   delete /some/file
   install some-package
   password some-user:password:its-new-password
  .Ve
  .Sp
  Empty lines are ignored, and lines starting with \f(CW`#\*(C' are comments
  and are ignored as well.  Furthermore, arguments can be spread across
  multiple lines, by adding a \f(CW`\e\*(C' (continuation character) at the of
  a line, for example
  .Sp
  .Vb 2
   edit /some/file:\e
     s/^OPT=.*/OPT=ok/
  .Ve
  .Sp
  The commands are handled in the same order as they are in the file,
  as if they were specified as _--delete /some/file_ on the command
  line.
  .ie n .IP "**--copy** \s-1SOURCE:DEST\s0 (see ""customize"" below)" 4
  .el .IP "**--copy** \s-1SOURCE:DEST\s0 (see \f(CWcustomize below)" 4
  .IX Item "--copy SOURCE:DEST (see customize below)"
  Copy files or directories recursively inside the guest.
  .Sp
  Wildcards cannot be used.
  .ie n .IP "**--copy-in** \s-1LOCALPATH:REMOTEDIR\s0 (see ""customize"" below)" 4
  .el .IP "**--copy-in** \s-1LOCALPATH:REMOTEDIR\s0 (see \f(CWcustomize below)" 4
  .IX Item "--copy-in LOCALPATH:REMOTEDIR (see customize below)"
  Copy local files or directories recursively into the disk image,
  placing them in the directory \f(CW`REMOTEDIR\*(C' (which must exist).
  .Sp
  Wildcards cannot be used.
  .ie n .IP "**--delete** \s-1PATH\s0 (see ""customize"" below)" 4
  .el .IP "**--delete** \s-1PATH\s0 (see \f(CWcustomize below)" 4
  .IX Item "--delete PATH (see customize below)"
  Delete a file from the guest.  Or delete a directory (and all its
  contents, recursively).
  .Sp
  You can use shell glob characters in the specified path.  Be careful
  to escape glob characters from the host shell, if that is required.
  For example:
  .Sp
  .Vb 1
   virt-customize --delete /var/log/*.log\*(Aq.
  .Ve
  .Sp
  See also: _--upload_, _--scrub_.
  .ie n .IP "**--edit** \s-1FILE:EXPR\s0 (see ""customize"" below)" 4
  .el .IP "**--edit** \s-1FILE:EXPR\s0 (see \f(CWcustomize below)" 4
  .IX Item "--edit FILE:EXPR (see customize below)"
  Edit \f(CW`FILE\*(C' using the Perl expression \f(CW\*(C\`EXPR\*(C'.
  .Sp
  Be careful to properly quote the expression to prevent it from
  being altered by the shell.
  .Sp
  Note that this option is only available when Perl 5 is installed.
  .Sp
  See NON-INTERACTIVE \s-1EDITING\*(R"\s0 in **virt-edit**\|(1).
  .ie n .IP "**--firstboot** \s-1SCRIPT\s0 (see ""customize"" below)" 4
  .el .IP "**--firstboot** \s-1SCRIPT\s0 (see \f(CWcustomize below)" 4
  .IX Item "--firstboot SCRIPT (see customize below)"
  Install \f(CW`SCRIPT\*(C' inside the guest, so that when the guest first boots
  up, the script runs (as root, late in the boot process).
  .Sp
  The script is automatically chmod +x after installation in the guest.
  .Sp
  The alternative version _--firstboot-command_ is the same, but it
  conveniently wraps the command up in a single line script for you.
  .Sp
  You can have multiple _--firstboot_ options.  They run in the same
  order that they appear on the command line.
  .Sp
  Please take a look at \s-1FIRST BOOT SCRIPTS\*(R"\s0 in **virt-builder**\|(1) for more
  information and caveats about the first boot scripts.
  .Sp
  See also _--run_.
  .ie n .IP "**--firstboot-command** '\s-1CMD+ARGS\s0' (see ""customize"" below)" 4
  .el .IP "**--firstboot-command** '\s-1CMD+ARGS\s0' (see \f(CWcustomize below)" 4
  .IX Item "--firstboot-command 'CMD+ARGS' (see customize below)"
  Run command (and arguments) inside the guest when the guest first
  boots up (as root, late in the boot process).
  .Sp
  You can have multiple _--firstboot_ options.  They run in the same
  order that they appear on the command line.
  .Sp
  Please take a look at \s-1FIRST BOOT SCRIPTS\*(R"\s0 in **virt-builder**\|(1) for more
  information and caveats about the first boot scripts.
  .Sp
  See also _--run_.
  .ie n .IP "**--firstboot-install** \s-1PKG,PKG..\s0 (see ""customize"" below)" 4
  .el .IP "**--firstboot-install** \s-1PKG,PKG..\s0 (see \f(CWcustomize below)" 4
  .IX Item "--firstboot-install PKG,PKG.. (see customize below)"
  Install the named packages (a comma-separated list).  These are
  installed when the guest first boots using the guest’s package manager
  (eg. apt, yum, etc.) and the guest’s network connection.
  .Sp
  For an overview on the different ways to install packages, see
  \s-1INSTALLING PACKAGES\*(R"\s0 in **virt-builder**\|(1).
  .ie n .IP "**--hostname** \s-1HOSTNAME\s0 (see ""customize"" below)" 4
  .el .IP "**--hostname** \s-1HOSTNAME\s0 (see \f(CWcustomize below)" 4
  .IX Item "--hostname HOSTNAME (see customize below)"
  Set the hostname of the guest to \f(CW`HOSTNAME\*(C'.  You can use a
  dotted hostname.domainname (\s-1FQDN\s0) if you want.
  .ie n .IP "**--install** \s-1PKG,PKG..\s0 (see ""customize"" below)" 4
  .el .IP "**--install** \s-1PKG,PKG..\s0 (see \f(CWcustomize below)" 4
  .IX Item "--install PKG,PKG.. (see customize below)"
  Install the named packages (a comma-separated list).  These are
  installed during the image build using the guest’s package manager
  (eg. apt, yum, etc.) and the host’s network connection.
  .Sp
  For an overview on the different ways to install packages, see
  \s-1INSTALLING PACKAGES\*(R"\s0 in **virt-builder**\|(1).
  .Sp
  See also _--update_, _--uninstall_.
  .ie n .IP "**--keep-user-accounts** \s-1USERS\s0 (see ""user-account"" below)" 4
  .el .IP "**--keep-user-accounts** \s-1USERS\s0 (see \f(CWuser-account below)" 4
  .IX Item "--keep-user-accounts USERS (see user-account below)"
  The user accounts to be kept in the guest.
  The value of this option is a list of user names separated by comma,
  where specifying an user means it is going to be kept.
  For example:
  .Sp
  .Vb 1
   --keep-user-accounts mary
  .Ve
  .Sp
  would keep the user account \f(CW`mary\*(C'.
  .Sp
  This option can be specified multiple times.
  .ie n .IP "**--link** TARGET:LINK[:LINK..] (see ""customize"" below)" 4
  .el .IP "**--link** TARGET:LINK[:LINK..] (see \f(CWcustomize below)" 4
  .IX Item "--link TARGET:LINK[:LINK..] (see customize below)"
  Create symbolic link(s) in the guest, starting at \f(CW`LINK\*(C' and
  pointing at \f(CW`TARGET\*(C'.
  .ie n .IP "**--mkdir** \s-1DIR\s0 (see ""customize"" below)" 4
  .el .IP "**--mkdir** \s-1DIR\s0 (see \f(CWcustomize below)" 4
  .IX Item "--mkdir DIR (see customize below)"
  Create a directory in the guest.
  .Sp
  This uses \f(CW`mkdir -p\*(C' so any intermediate directories are created,
  and it also works if the directory already exists.
  .ie n .IP "**--move** \s-1SOURCE:DEST\s0 (see ""customize"" below)" 4
  .el .IP "**--move** \s-1SOURCE:DEST\s0 (see \f(CWcustomize below)" 4
  .IX Item "--move SOURCE:DEST (see customize below)"
  Move files or directories inside the guest.
  .Sp
  Wildcards cannot be used.
  .ie n .IP "**--no-logfile** (see ""customize"" below)" 4
  .el .IP "**--no-logfile** (see \f(CWcustomize below)" 4
  .IX Item "--no-logfile (see customize below)"
  Scrub \f(CW`builder.log\*(C' (log file from build commands) from the image
  after building is complete.  If you don't want to reveal precisely how
  the image was built, use this option.
  .Sp
  See also: \s-1LOG FILE\*(R"\s0.
  .ie n .IP "**--password** \s-1USER:SELECTOR\s0 (see ""customize"" below)" 4
  .el .IP "**--password** \s-1USER:SELECTOR\s0 (see \f(CWcustomize below)" 4
  .IX Item "--password USER:SELECTOR (see customize below)"
  Set the password for \f(CW`USER\*(C'.  (Note this option does _not_
  create the user account).
  .Sp
  See \s-1USERS AND PASSWORDS\*(R"\s0 in **virt-builder**\|(1) for the format of
  the \f(CW`SELECTOR\*(C' field, and also how to set up user accounts.
  .ie n .IP "**--password-crypto** md5|sha256|sha512 (see ""customize"" below)" 4
  .el .IP "**--password-crypto** md5|sha256|sha512 (see \f(CWcustomize below)" 4
  .IX Item "--password-crypto md5|sha256|sha512 (see customize below)"
  When the virt tools change or set a password in the guest, this
  option sets the password encryption of that password to
  \f(CW`md5\*(C', \f(CW\*(C\`sha256\*(C' or \f(CW\*(C\`sha512\*(C'.
  .Sp
  \f(CW`sha256\*(C' and \f(CW\*(C\`sha512\*(C' require glibc ≥ 2.7 (check **crypt**\|(3) inside
  the guest).
  .Sp
  \f(CW`md5\*(C' will work with relatively old Linux guests (eg. \s-1RHEL 3\s0), but
  is not secure against modern attacks.
  .Sp
  The default is \f(CW`sha512\*(C' unless libguestfs detects an old guest that
  didn't have support for \s-1SHA-512,\s0 in which case it will use \f(CW`md5\*(C'.
  You can override libguestfs by specifying this option.
  .Sp
  Note this does not change the default password encryption used
  by the guest when you create new user accounts inside the guest.
  If you want to do that, then you should use the _--edit_ option
  to modify \f(CW`/etc/sysconfig/authconfig\*(C' (Fedora, \s-1RHEL\s0) or
  \f(CW`/etc/pam.d/common-password\*(C' (Debian, Ubuntu).
  .ie n .IP "**--remove-user-accounts** \s-1USERS\s0 (see ""user-account"" below)" 4
  .el .IP "**--remove-user-accounts** \s-1USERS\s0 (see \f(CWuser-account below)" 4
  .IX Item "--remove-user-accounts USERS (see user-account below)"
  The user accounts to be removed from the guest.
  The value of this option is a list of user names separated by comma,
  where specifying an user means it is going to be removed.
  For example:
  .Sp
  .Vb 1
   --remove-user-accounts bob,eve
  .Ve
  .Sp
  would only remove the user accounts \f(CW`bob\*(C' and \f(CW\*(C\`eve\*(C'.
  .Sp
  This option can be specified multiple times.
  .ie n .IP "**--root-password** \s-1SELECTOR\s0 (see ""customize"" below)" 4
  .el .IP "**--root-password** \s-1SELECTOR\s0 (see \f(CWcustomize below)" 4
  .IX Item "--root-password SELECTOR (see customize below)"
  Set the root password.
  .Sp
  See \s-1USERS AND PASSWORDS\*(R"\s0 in **virt-builder**\|(1) for the format of
  the \f(CW`SELECTOR\*(C' field, and also how to set up user accounts.
  .Sp
  Note: In virt-builder, if you _don't_ set _--root-password_
  then the guest is given a _random_ root password.
  .ie n .IP "**--run** \s-1SCRIPT\s0 (see ""customize"" below)" 4
  .el .IP "**--run** \s-1SCRIPT\s0 (see \f(CWcustomize below)" 4
  .IX Item "--run SCRIPT (see customize below)"
  Run the shell script (or any program) called \f(CW`SCRIPT\*(C' on the disk
  image.  The script runs virtualized inside a small appliance, chrooted
  into the guest filesystem.
  .Sp
  The script is automatically chmod +x.
  .Sp
  If libguestfs supports it then a limited network connection is
  available but it only allows outgoing network connections.  You can
  also attach data disks (eg. \s-1ISO\s0 files) as another way to provide data
  (eg. software packages) to the script without needing a network
  connection (_--attach_).  You can also upload data files (_--upload_).
  .Sp
  You can have multiple _--run_ options.  They run
  in the same order that they appear on the command line.
  .Sp
  See also: _--firstboot_, _--attach_, _--upload_.
  .ie n .IP "**--run-command** '\s-1CMD+ARGS\s0' (see ""customize"" below)" 4
  .el .IP "**--run-command** '\s-1CMD+ARGS\s0' (see \f(CWcustomize below)" 4
  .IX Item "--run-command 'CMD+ARGS' (see customize below)"
  Run the command and arguments on the disk image.  The command runs
  virtualized inside a small appliance, chrooted into the guest filesystem.
  .Sp
  If libguestfs supports it then a limited network connection is
  available but it only allows outgoing network connections.  You can
  also attach data disks (eg. \s-1ISO\s0 files) as another way to provide data
  (eg. software packages) to the script without needing a network
  connection (_--attach_).  You can also upload data files (_--upload_).
  .Sp
  You can have multiple _--run-command_ options.  They run
  in the same order that they appear on the command line.
  .Sp
  See also: _--firstboot_, _--attach_, _--upload_.
  .ie n .IP "**--script** \s-1SCRIPT\s0 (see ""script"" below)" 4
  .el .IP "**--script** \s-1SCRIPT\s0 (see \f(CWscript below)" 4
  .IX Item "--script SCRIPT (see script below)"
  Run the named \f(CW`SCRIPT\*(C' (a shell script or program) against the
  guest.  The script can be any program on the host.  The script’s
  current directory will be the guest’s root directory.
  .Sp
  **Note:** If the script is not on the \f(CW$PATH, then you must give
  the full absolute path to the script.
  .ie n .IP "**--scriptdir** \s-1SCRIPTDIR\s0 (see ""script"" below)" 4
  .el .IP "**--scriptdir** \s-1SCRIPTDIR\s0 (see \f(CWscript below)" 4
  .IX Item "--scriptdir SCRIPTDIR (see script below)"
  The mount point (an empty directory on the host) used when
  the \f(CW`script\*(C' operation is enabled and one or more scripts
  are specified using _--script_ parameter(s).
  .Sp
  **Note:** \f(CW`SCRIPTDIR\*(C' **must** be an absolute path.
  .Sp
  If _--scriptdir_ is not specified then a temporary mountpoint
  will be created.
  .ie n .IP "**--scrub** \s-1FILE\s0 (see ""customize"" below)" 4
  .el .IP "**--scrub** \s-1FILE\s0 (see \f(CWcustomize below)" 4
  .IX Item "--scrub FILE (see customize below)"
  Scrub a file from the guest.  This is like _--delete_ except that:
    * ·  
      It scrubs the data so a guest could not recover it.
    * ·  
      It cannot delete directories, only regular files.
  .ie n .IP "**--selinux-relabel** (see ""customize"" below)" 4
  .el .IP "**--selinux-relabel** (see \f(CWcustomize below)" 4
  .IX Item "--selinux-relabel (see customize below)"
  Relabel files in the guest so that they have the correct SELinux label.
  .Sp
  This will attempt to relabel files immediately, but if the operation fails
  this will instead touch _/.autorelabel_ on the image to schedule a
  relabel operation for the next time the image boots.
  .Sp
  You should only use this option for guests which support SELinux.
  .ie n .IP "**--sm-attach** \s-1SELECTOR\s0 (see ""customize"" below)" 4
  .el .IP "**--sm-attach** \s-1SELECTOR\s0 (see \f(CWcustomize below)" 4
  .IX Item "--sm-attach SELECTOR (see customize below)"
  Attach to a pool using \f(CW`subscription-manager\*(C'.
  .Sp
  See SUBSCRIPTION-MANAGER\*(R" in **virt-builder**\|(1) for the format of
  the \f(CW`SELECTOR\*(C' field.
  .ie n .IP "**--sm-credentials** \s-1SELECTOR\s0 (see ""customize"" below)" 4
  .el .IP "**--sm-credentials** \s-1SELECTOR\s0 (see \f(CWcustomize below)" 4
  .IX Item "--sm-credentials SELECTOR (see customize below)"
  Set the credentials for \f(CW`subscription-manager\*(C'.
  .Sp
  See SUBSCRIPTION-MANAGER\*(R" in **virt-builder**\|(1) for the format of
  the \f(CW`SELECTOR\*(C' field.
  .ie n .IP "**--sm-register** (see ""customize"" below)" 4
  .el .IP "**--sm-register** (see \f(CWcustomize below)" 4
  .IX Item "--sm-register (see customize below)"
  Register the guest using \f(CW`subscription-manager\*(C'.
  .Sp
  This requires credentials being set using _--sm-credentials_.
  .ie n .IP "**--sm-remove** (see ""customize"" below)" 4
  .el .IP "**--sm-remove** (see \f(CWcustomize below)" 4
  .IX Item "--sm-remove (see customize below)"
  Remove all the subscriptions from the guest using
  \f(CW`subscription-manager\*(C'.
  .ie n .IP "**--sm-unregister** (see ""customize"" below)" 4
  .el .IP "**--sm-unregister** (see \f(CWcustomize below)" 4
  .IX Item "--sm-unregister (see customize below)"
  Unregister the guest using \f(CW`subscription-manager\*(C'.
  .ie n .IP "**--ssh-inject** USER[:SELECTOR] (see ""customize"" below)" 4
  .el .IP "**--ssh-inject** USER[:SELECTOR] (see \f(CWcustomize below)" 4
  .IX Item "--ssh-inject USER[:SELECTOR] (see customize below)"
  Inject an ssh key so the given \f(CW`USER\*(C' will be able to log in over
  ssh without supplying a password.  The \f(CW`USER\*(C' must exist already
  in the guest.
  .Sp
  See \s-1SSH KEYS\*(R"\s0 in **virt-builder**\|(1) for the format of
  the \f(CW`SELECTOR\*(C' field.
  .Sp
  You can have multiple _--ssh-inject_ options, for different users
  and also for more keys for each user.
  .ie n .IP "**--timezone** \s-1TIMEZONE\s0 (see ""customize"" below)" 4
  .el .IP "**--timezone** \s-1TIMEZONE\s0 (see \f(CWcustomize below)" 4
  .IX Item "--timezone TIMEZONE (see customize below)"
  Set the default timezone of the guest to \f(CW`TIMEZONE\*(C'.  Use a location
  string like \f(CW`Europe/London\*(C'
  .ie n .IP "**--touch** \s-1FILE\s0 (see ""customize"" below)" 4
  .el .IP "**--touch** \s-1FILE\s0 (see \f(CWcustomize below)" 4
  .IX Item "--touch FILE (see customize below)"
  This command performs a **touch**\|(1)-like operation on \f(CW`FILE\*(C'.
  .ie n .IP "**--truncate** \s-1FILE\s0 (see ""customize"" below)" 4
  .el .IP "**--truncate** \s-1FILE\s0 (see \f(CWcustomize below)" 4
  .IX Item "--truncate FILE (see customize below)"
  This command truncates \f(CW`FILE\*(C' to a zero-length file. The file must exist
  already.
  .ie n .IP "**--truncate-recursive** \s-1PATH\s0 (see ""customize"" below)" 4
  .el .IP "**--truncate-recursive** \s-1PATH\s0 (see \f(CWcustomize below)" 4
  .IX Item "--truncate-recursive PATH (see customize below)"
  This command recursively truncates all files under \f(CW`PATH\*(C' to zero-length.
  .ie n .IP "**--uninstall** \s-1PKG,PKG..\s0 (see ""customize"" below)" 4
  .el .IP "**--uninstall** \s-1PKG,PKG..\s0 (see \f(CWcustomize below)" 4
  .IX Item "--uninstall PKG,PKG.. (see customize below)"
  Uninstall the named packages (a comma-separated list).  These are
  removed during the image build using the guest’s package manager
  (eg. apt, yum, etc.).  Dependent packages may also need to be
  uninstalled to satisfy the request.
  .Sp
  See also _--install_, _--update_.
  .ie n .IP "**--update** (see ""customize"" below)" 4
  .el .IP "**--update** (see \f(CWcustomize below)" 4
  .IX Item "--update (see customize below)"
  Do the equivalent of \f(CW`yum update\*(C', \f(CW\*(C\`apt-get upgrade\*(C', or whatever
  command is required to update the packages already installed in the
  template to their latest versions.
  .Sp
  See also _--install_, _--uninstall_.
  .ie n .IP "**--upload** \s-1FILE:DEST\s0 (see ""customize"" below)" 4
  .el .IP "**--upload** \s-1FILE:DEST\s0 (see \f(CWcustomize below)" 4
  .IX Item "--upload FILE:DEST (see customize below)"
  Upload local file \f(CW`FILE\*(C' to destination \f(CW\*(C\`DEST\*(C' in the disk image.
  File owner and permissions from the original are preserved, so you
  should set them to what you want them to be in the disk image.
  .Sp
  \f(CW`DEST\*(C' could be the final filename.  This can be used to rename
  the file on upload.
  .Sp
  If \f(CW`DEST\*(C' is a directory name (which must already exist in the guest)
  then the file is uploaded into that directory, and it keeps the same
  name as on the local filesystem.
  .Sp
  See also: _--mkdir_, _--delete_, _--scrub_.
  .ie n .IP "**--write** \s-1FILE:CONTENT\s0 (see ""customize"" below)" 4
  .el .IP "**--write** \s-1FILE:CONTENT\s0 (see \f(CWcustomize below)" 4
  .IX Item "--write FILE:CONTENT (see customize below)"
  Write \f(CW`CONTENT\*(C' to \f(CW\*(C\`FILE\*(C'.

<a name="operations"></a>

# Operations

.IX Header "OPERATIONS"
If the _--enable_/_--operations_ option is _not_ given,
then most sysprep operations are enabled.

Use \f(CW`virt-sysprep --list-operations\*(C' to list all operations for your
virt-sysprep binary.  The ones which are enabled by default are marked
with a \f(CW`*\*(C' character.  Regardless of the _--enable_/_--operations_
options, sysprep operations are skipped for some guest types.

Operations can be individually enabled using the
_--enable_/_--operations_ options.
Use a comma-separated list, for example:

.Vb 1
 virt-sysprep --operations ssh-hostkeys,udev-persistent-net [etc..]
.Ve

Future versions of virt-sysprep may add more operations.  If you are
using virt-sysprep and want predictable behaviour, specify only the
operations that you want to have enabled.

\f(CW`*\*(C' = enabled by default when no _--enable_/_--operations_ option
is given.

<a name="fbabrt-datafp-"></a>

### \fBabrt-data\fP *

.IX Subsection "abrt-data *"
Remove the crash data generated by \s-1ABRT.\s0

Remove the automatically generated \s-1ABRT\s0 crash data in
\f(CW`/var/spool/abrt/\*(C'.

<a name="fbbackup-filesfp-"></a>

### \fBbackup-files\fP *

.IX Subsection "backup-files *"
Remove editor backup files from the guest.

The following files are removed from anywhere in the guest
filesystem:

* ·  
  *.bak
* ·  
  *~

On Linux and Unix operating systems, only the following filesystems
will be examined:

* ·  
  /etc
* ·  
  /root
* ·  
  /srv
* ·  
  /tmp
* ·  
  /var

<a name="fbbash-historyfp-"></a>

### \fBbash-history\fP *

.IX Subsection "bash-history *"
Remove the bash history in the guest.

Remove the bash history of user root\*(R" and any other users
who have a \f(CW`.bash\_history\*(C' file in their home directory.

_Notes on bash-history_
.IX Subsection "Notes on bash-history"

Currently this only looks in \f(CW`/root\*(C' and \f(CW\*(C\`/home/*\*(C' for
home directories, so users with home directories in other
locations won't have the bash history removed.

<a name="fbblkid-tabfp-"></a>

### \fBblkid-tab\fP *

.IX Subsection "blkid-tab *"
Remove blkid tab in the guest.

<a name="fbca-certificatesfp"></a>

### \fBca-certificates\fP

.IX Subsection "ca-certificates"
Remove \s-1CA\s0 certificates in the guest.

<a name="fbcrash-datafp-"></a>

### \fBcrash-data\fP *

.IX Subsection "crash-data *"
Remove the crash data generated by kexec-tools.

Remove the automatically generated kdump kernel crash data.

<a name="fbcron-spoolfp-"></a>

### \fBcron-spool\fP *

.IX Subsection "cron-spool *"
Remove user at-jobs and cron-jobs.

<a name="fbcustomizefp-"></a>

### \fBcustomize\fP *

.IX Subsection "customize *"
Customize the guest.

Customize the guest by providing **virt-customize**\|(1) options
for installing packages, editing files and so on.

<a name="fbdhcp-client-statefp-"></a>

### \fBdhcp-client-state\fP *

.IX Subsection "dhcp-client-state *"
Remove \s-1DHCP\s0 client leases.

<a name="fbdhcp-server-statefp-"></a>

### \fBdhcp-server-state\fP *

.IX Subsection "dhcp-server-state *"
Remove \s-1DHCP\s0 server leases.

<a name="fbdovecot-datafp-"></a>

### \fBdovecot-data\fP *

.IX Subsection "dovecot-data *"
Remove Dovecot (mail server) data.

<a name="fbfirewall-rulesfp"></a>

### \fBfirewall-rules\fP

.IX Subsection "firewall-rules"
Remove the firewall rules.

This removes custom firewall rules by removing \f(CW`/etc/sysconfig/iptables\*(C'
or custom firewalld configuration in \f(CW`/etc/firewalld/*/*\*(C'.

Note this is _not_ enabled by default since it may expose guests to
exploits.  Use with care.

<a name="fbflag-reconfigurationfp"></a>

### \fBflag-reconfiguration\fP

.IX Subsection "flag-reconfiguration"
Flag the system for reconfiguration.

For Linux guests, this touches \f(CW`/.unconfigured\*(C', which causes
the first boot to interactively query the user for settings such
as the root password and timezone.

<a name="fbfs-uuidsfp"></a>

### \fBfs-uuids\fP

.IX Subsection "fs-uuids"
Change filesystem UUIDs.

On guests and filesystem types where this is supported,
new random UUIDs are generated and assigned to filesystems.

_Notes on fs-uuids_
.IX Subsection "Notes on fs-uuids"

The fs-uuids operation is disabled by default because it does
not yet find and update all the places in the guest that use
the UUIDs.  For example \f(CW`/etc/fstab\*(C' or the bootloader.
Enabling this operation is more likely than not to make your
guest unbootable.

See: https://bugzilla.redhat.com/show_bug.cgi?id=991641

<a name="fbkerberos-datafp"></a>

### \fBkerberos-data\fP

.IX Subsection "kerberos-data"
Remove Kerberos data in the guest.

<a name="fblogfilesfp-"></a>

### \fBlogfiles\fP *

.IX Subsection "logfiles *"
Remove many log files from the guest.

On Linux the following files are removed:

* ·  
  /etc/Pegasus/*.cnf
* ·  
  /etc/Pegasus/*.crt
* ·  
  /etc/Pegasus/*.csr
* ·  
  /etc/Pegasus/*.pem
* ·  
  /etc/Pegasus/*.srl
* ·  
  /root/anaconda-ks.cfg
* ·  
  /root/anaconda-post.log
* ·  
  /root/initial-setup-ks.cfg
* ·  
  /root/install.log
* ·  
  /root/install.log.syslog
* ·  
  /root/original-ks.cfg
* ·  
  /var/cache/fontconfig/*
* ·  
  /var/cache/gdm/*
* ·  
  /var/cache/man/*
* ·  
  /var/lib/AccountService/users/*
* ·  
  /var/lib/fprint/*
* ·  
  /var/lib/logrotate.status
* ·  
  /var/log/*.log*
* ·  
  /var/log/BackupPC/LOG
* ·  
  /var/log/ConsoleKit/*
* ·  
  /var/log/anaconda.syslog
* ·  
  /var/log/anaconda/*
* ·  
  /var/log/apache2/*_log
* ·  
  /var/log/apache2/*_log-*
* ·  
  /var/log/apt/*
* ·  
  /var/log/aptitude*
* ·  
  /var/log/audit/*
* ·  
  /var/log/btmp*
* ·  
  /var/log/ceph/*.log
* ·  
  /var/log/chrony/*.log
* ·  
  /var/log/cron*
* ·  
  /var/log/cups/*_log*
* ·  
  /var/log/debug*
* ·  
  /var/log/dmesg*
* ·  
  /var/log/exim4/*
* ·  
  /var/log/faillog*
* ·  
  /var/log/firewalld*
* ·  
  /var/log/gdm/*
* ·  
  /var/log/glusterfs/*glusterd.vol.log
* ·  
  /var/log/glusterfs/glusterfs.log
* ·  
  /var/log/grubby*
* ·  
  /var/log/httpd/*log
* ·  
  /var/log/installer/*
* ·  
  /var/log/jetty/jetty-console.log
* ·  
  /var/log/journal/*
* ·  
  /var/log/lastlog*
* ·  
  /var/log/libvirt/libvirtd.log
* ·  
  /var/log/libvirt/libxl/*.log
* ·  
  /var/log/libvirt/lxc/*.log
* ·  
  /var/log/libvirt/qemu/*.log
* ·  
  /var/log/libvirt/uml/*.log
* ·  
  /var/log/lightdm/*
* ·  
  /var/log/mail/*
* ·  
  /var/log/maillog*
* ·  
  /var/log/messages*
* ·  
  /var/log/ntp
* ·  
  /var/log/ntpstats/*
* ·  
  /var/log/ppp/connect-errors
* ·  
  /var/log/rhsm/*
* ·  
  /var/log/sa/*
* ·  
  /var/log/secure*
* ·  
  /var/log/setroubleshoot/*.log
* ·  
  /var/log/spooler*
* ·  
  /var/log/squid/*.log
* ·  
  /var/log/syslog*
* ·  
  /var/log/tallylog*
* ·  
  /var/log/tuned/tuned.log
* ·  
  /var/log/wtmp*
* ·  
  /var/log/xferlog*
* ·  
  /var/named/data/named.run

<a name="fblvm-uuidsfp-"></a>

### \fBlvm-uuids\fP *

.IX Subsection "lvm-uuids *"
Change \s-1LVM2 PV\s0 and \s-1VG\s0 UUIDs.

On Linux guests that have \s-1LVM2\s0 physical volumes (PVs) or volume groups (VGs),
new random UUIDs are generated and assigned to those PVs and VGs.

<a name="fbmachine-idfp-"></a>

### \fBmachine-id\fP *

.IX Subsection "machine-id *"
Remove the local machine \s-1ID.\s0

The machine \s-1ID\s0 is usually generated from a random source during system
installation and stays constant for all subsequent boots.  Optionally,
for stateless systems it is generated during runtime at boot if it is
found to be empty.

<a name="fbmail-spoolfp-"></a>

### \fBmail-spool\fP *

.IX Subsection "mail-spool *"
Remove email from the local mail spool directory.

<a name="fbnet-hostnamefp-"></a>

### \fBnet-hostname\fP *

.IX Subsection "net-hostname *"
Remove \s-1HOSTNAME\s0 and \s-1DHCP_HOSTNAME\s0 in network interface configuration.

For Fedora and Red Hat Enterprise Linux,
this is removed from \f(CW`ifcfg-*\*(C' files.

<a name="fbnet-hwaddrfp-"></a>

### \fBnet-hwaddr\fP *

.IX Subsection "net-hwaddr *"
Remove \s-1HWADDR\s0 (hard-coded \s-1MAC\s0 address) configuration.

For Fedora and Red Hat Enterprise Linux,
this is removed from \f(CW`ifcfg-*\*(C' files.

<a name="fbpacct-logfp-"></a>

### \fBpacct-log\fP *

.IX Subsection "pacct-log *"
Remove the process accounting log files.

The system wide process accounting will store to the pacct
log files if the process accounting is on.

<a name="fbpackage-manager-cachefp-"></a>

### \fBpackage-manager-cache\fP *

.IX Subsection "package-manager-cache *"
Remove package manager cache.

<a name="fbpam-datafp-"></a>

### \fBpam-data\fP *

.IX Subsection "pam-data *"
Remove the \s-1PAM\s0 data in the guest.

<a name="fbpasswd-backupsfp-"></a>

### \fBpasswd-backups\fP *

.IX Subsection "passwd-backups *"
Remove /etc/passwd- and similar backup files.

On Linux the following files are removed:

* ·  
  /etc/group-
* ·  
  /etc/gshadow-
* ·  
  /etc/passwd-
* ·  
  /etc/shadow-
* ·  
  /etc/subgid-
* ·  
  /etc/subuid-

<a name="fbpuppet-data-logfp-"></a>

### \fBpuppet-data-log\fP *

.IX Subsection "puppet-data-log *"
Remove the data and log files of puppet.

<a name="fbrh-subscription-managerfp-"></a>

### \fBrh-subscription-manager\fP *

.IX Subsection "rh-subscription-manager *"
Remove the \s-1RH\s0 subscription manager files.

<a name="fbrhn-systemidfp-"></a>

### \fBrhn-systemid\fP *

.IX Subsection "rhn-systemid *"
Remove the \s-1RHN\s0 system \s-1ID.\s0

<a name="fbrpm-dbfp-"></a>

### \fBrpm-db\fP *

.IX Subsection "rpm-db *"
Remove host-specific \s-1RPM\s0 database files.

Remove host-specific \s-1RPM\s0 database files and locks.  \s-1RPM\s0 will
recreate these files automatically if needed.

<a name="fbsamba-db-logfp-"></a>

### \fBsamba-db-log\fP *

.IX Subsection "samba-db-log *"
Remove the database and log files of Samba.

<a name="fbscriptfp-"></a>

### \fBscript\fP *

.IX Subsection "script *"
Run arbitrary scripts against the guest.

The \f(CW`script\*(C' module lets you run arbitrary shell scripts or programs
against the guest.

Note this feature requires \s-1FUSE\s0 support.  You may have to enable
this in your host, for example by adding the current user to the
\f(CW`fuse\*(C' group, or by loading a kernel module.

Use one or more _--script_ parameters to specify scripts or programs
that will be run against the guest.

The script or program is run with its current directory being the
guest’s root directory, so relative paths should be used.  For
example: \f(CW`rm etc/resolv.conf\*(C' in the script would remove a Linux
guest’s \s-1DNS\s0 configuration file, but \f(CW`rm /etc/resolv.conf\*(C' would
(try to) remove the host’s file.

Normally a temporary mount point for the guest is used, but you
can choose a specific one by using the _--scriptdir_ parameter.

**Note:** This is different from _--firstboot_ scripts (which run
in the context of the guest when it is booting first time).
_--script_ scripts run on the host, not in the guest.

<a name="fbsmolt-uuidfp-"></a>

### \fBsmolt-uuid\fP *

.IX Subsection "smolt-uuid *"
Remove the Smolt hardware \s-1UUID.\s0

<a name="fbssh-hostkeysfp-"></a>

### \fBssh-hostkeys\fP *

.IX Subsection "ssh-hostkeys *"
Remove the \s-1SSH\s0 host keys in the guest.

The \s-1SSH\s0 host keys are regenerated (differently) next time the guest is
booted.

If, after cloning, the guest gets the same \s-1IP\s0 address, ssh will give
you a stark warning about the host key changing:

.Vb 4
 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
 @    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
 IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
.Ve

<a name="fbssh-userdirfp-"></a>

### \fBssh-userdir\fP *

.IX Subsection "ssh-userdir *"
Remove .ssh\*(R" directories in the guest.

Remove the \f(CW`.ssh\*(C' directory of user \*(L"root\*(R" and any other
users who have a \f(CW`.ssh\*(C' directory in their home directory.

_Notes on ssh-userdir_
.IX Subsection "Notes on ssh-userdir"

Currently this only looks in \f(CW`/root\*(C' and \f(CW\*(C\`/home/*\*(C' for
home directories, so users with home directories in other
locations won't have the ssh files removed.

<a name="fbsssd-db-logfp-"></a>

### \fBsssd-db-log\fP *

.IX Subsection "sssd-db-log *"
Remove the database and log files of sssd.

<a name="fbtmp-filesfp-"></a>

### \fBtmp-files\fP *

.IX Subsection "tmp-files *"
Remove temporary files.

This removes temporary files under \f(CW`/tmp\*(C' and \f(CW\*(C\`/var/tmp\*(C'.

<a name="fbudev-persistent-netfp-"></a>

### \fBudev-persistent-net\fP *

.IX Subsection "udev-persistent-net *"
Remove udev persistent net rules.

Remove udev persistent net rules which map the guest’s existing \s-1MAC\s0
address to a fixed ethernet device (eg. eth0).

After a guest is cloned, the \s-1MAC\s0 address usually changes.  Since the
old \s-1MAC\s0 address occupies the old name (eg. eth0), this means the fresh
\s-1MAC\s0 address is assigned to a new name (eg. eth1) and this is usually
undesirable.  Erasing the udev persistent net rules avoids this.

<a name="fbuser-accountfp"></a>

### \fBuser-account\fP

.IX Subsection "user-account"
Remove the user accounts in the guest.

By default remove all the user accounts and their home directories.
The root\*(R" account is not removed.

See the _--remove-user-accounts_ parameter for a way to specify
how to remove only some users, or to not remove some others.

<a name="fbutmpfp-"></a>

### \fButmp\fP *

.IX Subsection "utmp *"
Remove the utmp file.

This file records who is currently logged in on a machine.  In modern
Linux distros it is stored in a ramdisk and hence not part of the
virtual machine’s disk, but it was stored on disk in older distros.

<a name="fbyum-uuidfp-"></a>

### \fByum-uuid\fP *

.IX Subsection "yum-uuid *"
Remove the yum \s-1UUID.\s0

Yum creates a fresh \s-1UUID\s0 the next time it runs when it notices that the
original \s-1UUID\s0 has been erased.

<a name="copying-and-cloning"></a>

# Copying and Cloning

.IX Header "COPYING AND CLONING"
Virt-sysprep can be used as part of a process of cloning guests, or to
prepare a template from which guests can be cloned.  There are many
different ways to achieve this using the virt tools, and this section
is just an introduction.

A virtual machine (when switched off) consists of two parts:

* _configuration_  
  .IX Item "configuration"
  The configuration or description of the guest.  eg. The libvirt
  \s-1XML\s0 (see \f(CW`virsh dumpxml\*(C'), the running configuration of the guest,
  or another external format like \s-1OVF.\s0
  .Sp
  Some configuration items that might need to be changed:
    * ·  
      name
    * ·  
      \s-1UUID\s0
    * ·  
      path to block device(s)
    * ·  
      network card \s-1MAC\s0 address
* _block device(s)_  
  .IX Item "block device(s)"
  One or more hard disk images, themselves containing files,
  directories, applications, kernels, configuration, etc.
  .Sp
  Some things inside the block devices that might need to be changed:
    * ·  
      hostname and other net configuration
    * ·  
      \s-1UUID\s0
    * ·  
      \s-1SSH\s0 host keys
    * ·  
      Windows unique security \s-1ID\s0 (\s-1SID\s0)
    * ·  
      Puppet registration

<a name="s-1copying-the-block-devices0"></a>

### \s-1COPYING THE BLOCK DEVICE\s0

.IX Subsection "COPYING THE BLOCK DEVICE"
Starting with an original guest, you probably wish to copy the guest
block device and its configuration to make a template.  Then once you
are happy with the template, you will want to make many clones from
it.

.Vb 7
                        virt-sysprep
                             |
                             v
 original guest --------&gt; template ----------&gt;
                                      \e------&gt; cloned
                                       \e-----&gt; guests
                                        \e----&gt;
.Ve

You can, of course, just copy the block device on the host using
**cp**\|(1) or **dd**\|(1).

.Vb 5
                   dd                 dd
 original guest --------&gt; template ----------&gt;
                                      \e------&gt; cloned
                                       \e-----&gt; guests
                                        \e----&gt;
.Ve

There are some smarter (and faster) ways too:

.Vb 5
                          snapshot
                template ----------&gt;
                            \e------&gt; cloned
                             \e-----&gt; guests
                              \e----&gt;
.Ve

You may want to run virt-sysprep twice, once to reset the guest (to
make a template) and a second time to customize the guest for a
specific user:

.Vb 6
                    virt-sysprep        virt-sysprep
                      (reset)      (add user, keys, logos)
                         |                   |
                 dd      v          dd       v
 original guest ----&gt; template ---------&gt; copied ------&gt; custom
                                          template       guest
.Ve

* ·  
  Create a snapshot using qemu-img:
  .Sp
  .Vb 1
   qemu-img create -f qcow2 -o backing_file=original snapshot.qcow
  .Ve
  .Sp
  The advantage is that you don’t need to copy the original (very fast)
  and only changes are stored (less storage required).
  .Sp
  Note that writing to the backing file once you have created guests on
  top of it is not possible: you will corrupt the guests.
* ·  
  Create a snapshot using \f(CW`lvcreate --snapshot\*(C'.
* ·  
  Other ways to create snapshots include using filesystems-level tools
  (for filesystems such as btrfs).
  .Sp
  Most Network Attached Storage (\s-1NAS\s0) devices can also create cheap
  snapshots from files or LUNs.
* ·  
  Get your \s-1NAS\s0 to duplicate the \s-1LUN.\s0  Most \s-1NAS\s0 devices can also
  duplicate LUNs very cheaply (they copy them on-demand in the
  background).
* ·  
  Prepare your template using **virt-sparsify**\|(1).  See below.

<a name="virt-clone"></a>

### VIRT-CLONE

.IX Subsection "VIRT-CLONE"
A separate tool, **virt-clone**\|(1), can be used to duplicate the block
device and/or modify the external libvirt configuration of a guest.
It will reset the name, \s-1UUID\s0 and \s-1MAC\s0 address of the guest in the
libvirt \s-1XML.\s0

**virt-clone**\|(1) does not use libguestfs and cannot look inside the
disk image.  This was the original motivation to write virt-sysprep.

<a name="s-1sparsifys0"></a>

### \s-1SPARSIFY\s0

.IX Subsection "SPARSIFY"
.Vb 2
              virt-sparsify
 original guest --------&gt; template
.Ve

**virt-sparsify**\|(1) can be used to make the cloning template smaller,
making it easier to compress and/or faster to copy.

Notice that since virt-sparsify also copies the image, you can use it
to make the initial copy (instead of \f(CW`dd\*(C').

<a name="s-1resizes0"></a>

### \s-1RESIZE\s0

.IX Subsection "RESIZE"
.Vb 5
                         virt-resize
                template ----------&gt;
                            \e------&gt; cloned
                             \e-----&gt; guests
                              \e----&gt;
.Ve

If you want to give people cloned guests, but let them pick the size
of the guest themselves (eg. depending on how much they are prepared
to pay for disk space), then instead of copying the template, you can
run **virt-resize**\|(1).  Virt-resize performs a copy and resize, and
thus is ideal for cloning guests from a template.

<a name="firstboot-vs-script"></a>

# Firstboot Vs Script

.IX Header "FIRSTBOOT VS SCRIPT"
The two options _--firstboot_ and _--script_ both supply shell
scripts that are run against the guest.  However these two options are
significantly different.

_--firstboot script_ uploads the file \f(CW`script\*(C' into the guest
and arranges that it will run, in the guest, when the guest is
next booted.  (The script will only run once, at the first boot\*(R").

_--script script_ runs the shell \f(CW`script\*(C' _on the host_, with its
current directory inside the guest filesystem.

If you needed, for example, to \f(CW`yum install\*(C' new packages, then you
_must not_ use _--script_ for this, since that would (a) run the
\f(CW`yum\*(C' command on the host and (b) wouldn't have access to the same
resources (repositories, keys, etc.) as the guest.  Any command that
needs to run on the guest _must_ be run via _--firstboot_.

On the other hand if you need to make adjustments to the guest
filesystem (eg. copying in files), then _--script_ is ideal since (a)
it has access to the host filesystem and (b) you will get immediate
feedback on errors.

Either or both options can be used multiple times on the command line.

<a name="security"></a>

# Security

.IX Header "SECURITY"
Although virt-sysprep removes some sensitive information from the
guest, it does not pretend to remove all of it.  You should examine
the \s-1OPERATIONS\*(R"\s0 above and the guest afterwards.

Sensitive files are simply removed.  The data they contained may still
exist on the disk, easily recovered with a hex editor or undelete
tool.  The _--scrub_ option can be used to scrub files instead of
just deleting them.  **virt-sparsify**\|(1) is another way to remove this
content.  See also the **scrub**\|(1) command to get rid of deleted
content in directory entries and inodes.

<a name="s-1random-seeds0"></a>

### \s-1RANDOM SEED\s0

.IX Subsection "RANDOM SEED"
_(This section applies to Linux guests only)_

For supported guests, virt-sysprep writes a few bytes of randomness
from the host into the guest’s random seed file.

If this is just done once and the guest is cloned from the same
template, then each guest will start with the same entropy, and things
like \s-1SSH\s0 host keys and \s-1TCP\s0 sequence numbers may be predictable.

Therefore you should arrange to add more randomness _after_ cloning
from a template too, which can be done by enabling just the customize
module:

.Vb 2
 cp template.img newguest.img
 virt-sysprep --enable customize -a newguest.img
.Ve

<a name="selinux"></a>

# Selinux

.IX Header "SELINUX"
For guests which make use of SELinux, special handling for them might
be needed when using operations which create new files or alter
existing ones.

For further details, see \s-1SELINUX\*(R"\s0 in **virt-builder**\|(1).

<a name="windows-8"></a>

# Windows 8

.IX Header "WINDOWS 8"
Windows 8 fast startup\*(R" can prevent virt-sysprep from working.
See \s-1WINDOWS HIBERNATION AND WINDOWS 8 FAST STARTUP\*(R"\s0 in **guestfs**\|(3).

<a name="exit-status"></a>

# Exit Status

.IX Header "EXIT STATUS"
This program returns 0 on success, or 1 if there was an error.

<a name="environment-variables"></a>

# Environment Variables

.IX Header "ENVIRONMENT VARIABLES"
.ie n .IP """VIRT_TOOLS_DATA_DIR""" 4
.el .IP "\f(CWVIRT\_TOOLS\_DATA\_DIR" 4
.IX Item "VIRT_TOOLS_DATA_DIR"
This can point to the directory containing data files used for Windows
firstboot installation.
.Sp
Normally you do not need to set this.  If not set, a compiled-in
default will be used (something like _/usr/share/virt-tools_).
.Sp
This directory may contain the following files:

* _rhsrvany.exe_  
  .IX Item "rhsrvany.exe"
  This is the RHSrvAny Windows binary, used to install a firstboot\*(R"
  script in Windows guests.  It is required if you intend to use the
  _--firstboot_ or _--firstboot-command_ options with Windows guests.
  .Sp
  See also: \f(CW`https://github.com/rwmjones/rhsrvany\*(C'
* _pvvxsvc.exe_  
  .IX Item "pvvxsvc.exe"
  This is a Windows binary shipped with \s-1SUSE VMDP,\s0 used to install a firstboot\*(R"
  script in Windows guests.  It is required if you intend to use the
  _--firstboot_ or _--firstboot-command_ options with Windows guests.

For other environment variables, see \s-1ENVIRONMENT VARIABLES\*(R"\s0 in **guestfs**\|(3).

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**guestfs**\|(3),
**guestfish**\|(1),
**virt-builder**\|(1),
**virt-clone**\|(1),
**virt-customize**\|(1),
**virt-rescue**\|(1),
**virt-resize**\|(1),
**virt-sparsify**\|(1),
**virsh**\|(1),
**lvcreate**\|(8),
**qemu-img**\|(1),
**scrub**\|(1),
http://libguestfs.org/,
http://libvirt.org/.

<a name="authors"></a>

# Authors

.IX Header "AUTHORS"
Richard W.M. Jones http://people.redhat.com/~rjones/

Wanlong Gao, Fujitsu Ltd.

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright (C) 2011-2019 Red Hat Inc.

Copyright (C) 2012 Fujitsu Ltd.

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
