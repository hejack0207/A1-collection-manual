# virt-customize(1)

libguestfs-1.40.2, 2019-02-07

.if n .ad l
.nh

<a name="name"></a>

# Name

virt-customize - Customize a virtual machine

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" .Vb 10  virt-customize     [ -a disk.img [ -a disk.img ... ] | -d domname ]     [--attach ISOFILE] [--attach-format FORMAT]     [ -c URI | --connect URI ] [ -n | --dry-run ]     [ --format FORMAT] [ -m MB | --memsize MB ]     [ --network | --no-network ]     [ -q | --quiet ] [--smp N] [ -v | --verbose ] [-x]     [--append-line FILE:LINE] [--chmod PERMISSIONS:FILE]     [--commands-from-file FILENAME] [--copy SOURCE:DEST]     [--copy-in LOCALPATH:REMOTEDIR] [--delete PATH] [--edit FILE:EXPR]     [--firstboot SCRIPT] [--firstboot-command CMD+ARGS\*(Aq]     [--firstboot-install PKG,PKG..] [--hostname HOSTNAME]     [--install PKG,PKG..] [--link TARGET:LINK[:LINK..]] [--mkdir DIR]     [--move SOURCE:DEST] [--password USER:SELECTOR]     [--root-password SELECTOR] [--run SCRIPT]     [--run-command CMD+ARGS\*(Aq] [--scrub FILE] [--sm-attach SELECTOR]     [--sm-register] [--sm-remove] [--sm-unregister]     [--ssh-inject USER[:SELECTOR]] [--truncate FILE]     [--truncate-recursive PATH] [--timezone TIMEZONE] [--touch FILE]     [--uninstall PKG,PKG..] [--update] [--upload FILE:DEST]     [--write FILE:CONTENT] [--no-logfile]     [--password-crypto md5|sha256|sha512] [--selinux-relabel]     [--sm-credentials SELECTOR]    virt-customize [ -V | --version ] .Ve
```

<a name="warning"></a>

# Warning

.IX Header "WARNING"
Using \f(CW`virt-customize\*(C'
on live virtual machines, or concurrently with other
disk editing tools, can be dangerous, potentially causing disk
corruption.  The virtual machine must be shut down before you use this
command, and disk images must not be edited concurrently.

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
Virt-customize can customize a virtual machine (disk image) by
installing packages, editing configuration files, and so on.

Virt-customize modifies the guest or disk image _in place_.  The
guest must be shut down.  If you want to preserve the existing
contents of the guest, _you must snapshot, copy or clone the disk first_.

You do _not_ need to run virt-customize as root.  In fact we'd
generally recommend that you don't.

Related tools include: **virt-sysprep**\|(1) and **virt-builder**\|(1).

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
* **--attach** \s-1ISOFILE\s0  
  .IX Item "--attach ISOFILE"
  The given disk is attached to the libguestfs appliance.  This is used
  to provide extra software repositories or other data for
  customization.
  .Sp
  You probably want to ensure the volume(s) or filesystems in the
  attached disks are labelled (or use an \s-1ISO\s0 volume name) so that you
  can mount them by label in your run-scripts:
  .Sp
  .Vb 2
   mkdir /tmp/mount
   mount LABEL=EXTRA /tmp/mount
  .Ve
  .Sp
  You can have multiple _--attach_ options, and the format can be any
  disk format (not just an \s-1ISO\s0).
* **--attach-format** \s-1FORMAT\s0  
  .IX Item "--attach-format FORMAT"
  Specify the disk format for the next _--attach_ option.  The
  \f(CW`FORMAT\*(C' is usually \f(CW\*(C\`raw\*(C' or \f(CW\*(C\`qcow2\*(C'.  Use \f(CW\*(C\`raw\*(C' for ISOs.
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
* **--echo-keys**  
  .IX Item "--echo-keys"
  When prompting for keys and passphrases, virt-customize normally turns
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
   virt-customize --format raw -a disk.img
  .Ve
  .Sp
  forces raw format (no auto-detection) for _disk.img_.
  .Sp
  .Vb 1
   virt-customize --format raw -a disk.img --format auto -a another.img
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
* **-m** \s-1MB\s0  
  .IX Item "-m MB"
* **--memsize** \s-1MB\s0  
  .IX Item "--memsize MB"
  Change the amount of memory allocated to _--run_ scripts.  Increase
  this if you find that _--run_ scripts or the _--install_ option are
  running out of memory.
  .Sp
  The default can be found with this command:
  .Sp
  .Vb 1
   guestfish get-memsize
  .Ve
* **--network**  
  .IX Item "--network"
* **--no-network**  
  .IX Item "--no-network"
  Enable or disable network access from the guest during the installation.
  .Sp
  Enabled is the default.  Use _--no-network_ to disable access.
  .Sp
  The network only allows outgoing connections and has other minor
  limitations.  See \s-1NETWORK\*(R"\s0 in **virt-rescue**\|(1).
  .Sp
  If you use _--no-network_ then certain other options such as
  _--install_ will not work.
  .Sp
  This does not affect whether the guest can access the network once it
  has been booted, because that is controlled by your hypervisor or
  cloud environment and has nothing to do with virt-customize.
  .Sp
  Generally speaking you should _not_ use _--no-network_.  But here
  are some reasons why you might want to:
    * 1.  
      Because the libguestfs backend that you are using doesn't support the
      network.  (See: \s-1BACKEND\*(R"\s0 in **guestfs**\|(3)).
    * 2.  
      Any software you need to install comes from an attached \s-1ISO,\s0 so you
      don't need the network.
    * 3.  
      You don’t want untrusted guest code trying to access your host network
      when running virt-customize.  This is particularly an issue when you
      don't trust the source of the operating system templates.  (See
      \s-1SECURITY\*(R"\s0 below).
    * 4.  
      You don’t have a host network (eg. in secure/restricted environments).
* **-q**  
  .IX Item "-q"
* **--quiet**  
  .IX Item "--quiet"
  Don’t print log messages.
  .Sp
  To enable detailed logging of individual file operations, use _-x_.
* **--smp** N  
  .IX Item "--smp N"
  Enable N ≥ 2 virtual CPUs for _--run_ scripts to use.
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

<a name="customization-options"></a>

### Customization options

.IX Subsection "Customization options"

* **--append-line** \s-1FILE:LINE\s0  
  .IX Item "--append-line FILE:LINE"
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
* **--chmod** \s-1PERMISSIONS:FILE\s0  
  .IX Item "--chmod PERMISSIONS:FILE"
  Change the permissions of \f(CW`FILE\*(C' to \f(CW\*(C\`PERMISSIONS\*(C'.
  .Sp
  _Note_: \f(CW`PERMISSIONS\*(C' by default would be decimal, unless you prefix
  it with \f(CW0 to get octal, ie. use \f(CW0700 not \f(CW700.
* **--commands-from-file** \s-1FILENAME\s0  
  .IX Item "--commands-from-file FILENAME"
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
* **--copy** \s-1SOURCE:DEST\s0  
  .IX Item "--copy SOURCE:DEST"
  Copy files or directories recursively inside the guest.
  .Sp
  Wildcards cannot be used.
* **--copy-in** \s-1LOCALPATH:REMOTEDIR\s0  
  .IX Item "--copy-in LOCALPATH:REMOTEDIR"
  Copy local files or directories recursively into the disk image,
  placing them in the directory \f(CW`REMOTEDIR\*(C' (which must exist).
  .Sp
  Wildcards cannot be used.
* **--delete** \s-1PATH\s0  
  .IX Item "--delete PATH"
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
* **--edit** \s-1FILE:EXPR\s0  
  .IX Item "--edit FILE:EXPR"
  Edit \f(CW`FILE\*(C' using the Perl expression \f(CW\*(C\`EXPR\*(C'.
  .Sp
  Be careful to properly quote the expression to prevent it from
  being altered by the shell.
  .Sp
  Note that this option is only available when Perl 5 is installed.
  .Sp
  See NON-INTERACTIVE \s-1EDITING\*(R"\s0 in **virt-edit**\|(1).
* **--firstboot** \s-1SCRIPT\s0  
  .IX Item "--firstboot SCRIPT"
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
* **--firstboot-command** '\s-1CMD+ARGS\s0'  
  .IX Item "--firstboot-command 'CMD+ARGS'"
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
* **--firstboot-install** \s-1PKG,PKG..\s0  
  .IX Item "--firstboot-install PKG,PKG.."
  Install the named packages (a comma-separated list).  These are
  installed when the guest first boots using the guest’s package manager
  (eg. apt, yum, etc.) and the guest’s network connection.
  .Sp
  For an overview on the different ways to install packages, see
  \s-1INSTALLING PACKAGES\*(R"\s0 in **virt-builder**\|(1).
* **--hostname** \s-1HOSTNAME\s0  
  .IX Item "--hostname HOSTNAME"
  Set the hostname of the guest to \f(CW`HOSTNAME\*(C'.  You can use a
  dotted hostname.domainname (\s-1FQDN\s0) if you want.
* **--install** \s-1PKG,PKG..\s0  
  .IX Item "--install PKG,PKG.."
  Install the named packages (a comma-separated list).  These are
  installed during the image build using the guest’s package manager
  (eg. apt, yum, etc.) and the host’s network connection.
  .Sp
  For an overview on the different ways to install packages, see
  \s-1INSTALLING PACKAGES\*(R"\s0 in **virt-builder**\|(1).
  .Sp
  See also _--update_, _--uninstall_.
* **--link** TARGET:LINK[:LINK..]  
  .IX Item "--link TARGET:LINK[:LINK..]"
  Create symbolic link(s) in the guest, starting at \f(CW`LINK\*(C' and
  pointing at \f(CW`TARGET\*(C'.
* **--mkdir** \s-1DIR\s0  
  .IX Item "--mkdir DIR"
  Create a directory in the guest.
  .Sp
  This uses \f(CW`mkdir -p\*(C' so any intermediate directories are created,
  and it also works if the directory already exists.
* **--move** \s-1SOURCE:DEST\s0  
  .IX Item "--move SOURCE:DEST"
  Move files or directories inside the guest.
  .Sp
  Wildcards cannot be used.
* **--no-logfile**  
  .IX Item "--no-logfile"
  Scrub \f(CW`builder.log\*(C' (log file from build commands) from the image
  after building is complete.  If you don't want to reveal precisely how
  the image was built, use this option.
  .Sp
  See also: \s-1LOG FILE\*(R"\s0.
* **--password** \s-1USER:SELECTOR\s0  
  .IX Item "--password USER:SELECTOR"
  Set the password for \f(CW`USER\*(C'.  (Note this option does _not_
  create the user account).
  .Sp
  See \s-1USERS AND PASSWORDS\*(R"\s0 in **virt-builder**\|(1) for the format of
  the \f(CW`SELECTOR\*(C' field, and also how to set up user accounts.
* **--password-crypto** md5|sha256|sha512  
  .IX Item "--password-crypto md5|sha256|sha512"
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
* **--root-password** \s-1SELECTOR\s0  
  .IX Item "--root-password SELECTOR"
  Set the root password.
  .Sp
  See \s-1USERS AND PASSWORDS\*(R"\s0 in **virt-builder**\|(1) for the format of
  the \f(CW`SELECTOR\*(C' field, and also how to set up user accounts.
  .Sp
  Note: In virt-builder, if you _don't_ set _--root-password_
  then the guest is given a _random_ root password.
* **--run** \s-1SCRIPT\s0  
  .IX Item "--run SCRIPT"
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
* **--run-command** '\s-1CMD+ARGS\s0'  
  .IX Item "--run-command 'CMD+ARGS'"
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
* **--scrub** \s-1FILE\s0  
  .IX Item "--scrub FILE"
  Scrub a file from the guest.  This is like _--delete_ except that:
    * ·  
      It scrubs the data so a guest could not recover it.
    * ·  
      It cannot delete directories, only regular files.
* **--selinux-relabel**  
  .IX Item "--selinux-relabel"
  Relabel files in the guest so that they have the correct SELinux label.
  .Sp
  This will attempt to relabel files immediately, but if the operation fails
  this will instead touch _/.autorelabel_ on the image to schedule a
  relabel operation for the next time the image boots.
  .Sp
  You should only use this option for guests which support SELinux.
* **--sm-attach** \s-1SELECTOR\s0  
  .IX Item "--sm-attach SELECTOR"
  Attach to a pool using \f(CW`subscription-manager\*(C'.
  .Sp
  See SUBSCRIPTION-MANAGER\*(R" in **virt-builder**\|(1) for the format of
  the \f(CW`SELECTOR\*(C' field.
* **--sm-credentials** \s-1SELECTOR\s0  
  .IX Item "--sm-credentials SELECTOR"
  Set the credentials for \f(CW`subscription-manager\*(C'.
  .Sp
  See SUBSCRIPTION-MANAGER\*(R" in **virt-builder**\|(1) for the format of
  the \f(CW`SELECTOR\*(C' field.
* **--sm-register**  
  .IX Item "--sm-register"
  Register the guest using \f(CW`subscription-manager\*(C'.
  .Sp
  This requires credentials being set using _--sm-credentials_.
* **--sm-remove**  
  .IX Item "--sm-remove"
  Remove all the subscriptions from the guest using
  \f(CW`subscription-manager\*(C'.
* **--sm-unregister**  
  .IX Item "--sm-unregister"
  Unregister the guest using \f(CW`subscription-manager\*(C'.
* **--ssh-inject** USER[:SELECTOR]  
  .IX Item "--ssh-inject USER[:SELECTOR]"
  Inject an ssh key so the given \f(CW`USER\*(C' will be able to log in over
  ssh without supplying a password.  The \f(CW`USER\*(C' must exist already
  in the guest.
  .Sp
  See \s-1SSH KEYS\*(R"\s0 in **virt-builder**\|(1) for the format of
  the \f(CW`SELECTOR\*(C' field.
  .Sp
  You can have multiple _--ssh-inject_ options, for different users
  and also for more keys for each user.
* **--timezone** \s-1TIMEZONE\s0  
  .IX Item "--timezone TIMEZONE"
  Set the default timezone of the guest to \f(CW`TIMEZONE\*(C'.  Use a location
  string like \f(CW`Europe/London\*(C'
* **--touch** \s-1FILE\s0  
  .IX Item "--touch FILE"
  This command performs a **touch**\|(1)-like operation on \f(CW`FILE\*(C'.
* **--truncate** \s-1FILE\s0  
  .IX Item "--truncate FILE"
  This command truncates \f(CW`FILE\*(C' to a zero-length file. The file must exist
  already.
* **--truncate-recursive** \s-1PATH\s0  
  .IX Item "--truncate-recursive PATH"
  This command recursively truncates all files under \f(CW`PATH\*(C' to zero-length.
* **--uninstall** \s-1PKG,PKG..\s0  
  .IX Item "--uninstall PKG,PKG.."
  Uninstall the named packages (a comma-separated list).  These are
  removed during the image build using the guest’s package manager
  (eg. apt, yum, etc.).  Dependent packages may also need to be
  uninstalled to satisfy the request.
  .Sp
  See also _--install_, _--update_.
* **--update**  
  .IX Item "--update"
  Do the equivalent of \f(CW`yum update\*(C', \f(CW\*(C\`apt-get upgrade\*(C', or whatever
  command is required to update the packages already installed in the
  template to their latest versions.
  .Sp
  See also _--install_, _--uninstall_.
* **--upload** \s-1FILE:DEST\s0  
  .IX Item "--upload FILE:DEST"
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
* **--write** \s-1FILE:CONTENT\s0  
  .IX Item "--write FILE:CONTENT"
  Write \f(CW`CONTENT\*(C' to \f(CW\*(C\`FILE\*(C'.

<a name="selinux"></a>

# Selinux

.IX Header "SELINUX"
For guests which make use of SELinux, special handling for them might
be needed when using operations which create new files or alter
existing ones.

For further details, see \s-1SELINUX\*(R"\s0 in **virt-builder**\|(1).

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
**virt-rescue**\|(1),
**virt-resize**\|(1),
**virt-sparsify**\|(1),
**virt-sysprep**\|(1),
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
