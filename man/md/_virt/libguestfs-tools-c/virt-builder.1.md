# virt-builder(1)

libguestfs-1.40.2, 2019-02-07

.if n .ad l
.nh

<a name="name"></a>

# Name

virt-builder - Build virtual machine images quickly

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" .Vb 10  virt-builder os-version     [-o|--output DISKIMAGE] [--size SIZE] [--format raw|qcow2]     [--arch ARCHITECTURE] [--attach ISOFILE]     [--append-line FILE:LINE] [--chmod PERMISSIONS:FILE]     [--commands-from-file FILENAME] [--copy SOURCE:DEST]     [--copy-in LOCALPATH:REMOTEDIR] [--delete PATH] [--edit FILE:EXPR]     [--firstboot SCRIPT] [--firstboot-command CMD+ARGS\*(Aq]     [--firstboot-install PKG,PKG..] [--hostname HOSTNAME]     [--install PKG,PKG..] [--link TARGET:LINK[:LINK..]] [--mkdir DIR]     [--move SOURCE:DEST] [--password USER:SELECTOR]     [--root-password SELECTOR] [--run SCRIPT]     [--run-command CMD+ARGS\*(Aq] [--scrub FILE] [--sm-attach SELECTOR]     [--sm-register] [--sm-remove] [--sm-unregister]     [--ssh-inject USER[:SELECTOR]] [--truncate FILE]     [--truncate-recursive PATH] [--timezone TIMEZONE] [--touch FILE]     [--uninstall PKG,PKG..] [--update] [--upload FILE:DEST]     [--write FILE:CONTENT] [--no-logfile]     [--password-crypto md5|sha256|sha512] [--selinux-relabel]     [--sm-credentials SELECTOR]    virt-builder -l|--list [--long] [--list-format short|long|json] [os-version]   virt-builder --notes os-version   virt-builder --print-cache   virt-builder --cache-all-templates   virt-builder --delete-cache   virt-builder --get-kernel DISKIMAGE     [--format raw|qcow2] [--output OUTPUTDIR] .Ve
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
Virt-builder is a tool for quickly building new virtual machines.  You
can build a variety of VMs for local or cloud use, usually within a
few minutes or less.  Virt-builder also has many ways to customize
these VMs.  Everything is run from the command line and nothing
requires root privileges, so automation and scripting is simple.

Note that virt-builder does not install guests from scratch.  It takes
cleanly prepared, digitally signed \s-1OS\s0 templates and customizes them.
This approach is used because it is much faster, but if you need to do
fresh installs you may want to look at **virt-install**\|(1) and
**oz-install**\|(1).

The easiest way to get started is by looking at the examples in the
next section.

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"

<a name="list-the-virtual-machines-available"></a>

### List the virtual machines available

.IX Subsection "List the virtual machines available"
.Vb 1
 virt-builder --list
.Ve

will list out the operating systems available to install.  A selection
of freely redistributable OSes is available as standard.  You can add
your own too (see below).

After choosing a guest from the list, you may want to see if there
are any installation notes:

.Vb 1
 virt-builder --notes fedora-27
.Ve

<a name="build-a-virtual-machine"></a>

### Build a virtual machine

.IX Subsection "Build a virtual machine"
.Vb 1
 virt-builder fedora-27
.Ve

will build a Fedora 25 image for the same architecture as virt-builder
(so running it from an i686 installation will try to build an i686
image, if available).  This will have all default
configuration (minimal size, no user accounts, random root password,
only the bare minimum installed software, etc.).

You _do not_ need to run this command as root.

The first time this runs it has to download the template over the
network, but this gets cached (see \s-1CACHING\*(R"\s0).

The name of the output file is derived from the template name, so
above it will be _fedora-27.img_.  You can change the output filename
using the _-o_ option:

.Vb 1
 virt-builder fedora-27 -o mydisk.img
.Ve

You can also use the _-o_ option to write to existing devices or
logical volumes.

.Vb 1
 virt-builder fedora-27 --format qcow2
.Ve

As above, but write the output in qcow2 format to _fedora-27.qcow2_.

.Vb 1
 virt-builder fedora-27 --size 20G
.Ve

As above, but the output size will be 20 \s-1GB.\s0  The guest \s-1OS\s0 is resized
as it is copied to the output (automatically, using
**virt-resize**\|(1)).

.Vb 1
 virt-builder fedora-27 --arch i686
.Ve

As above, but using an i686 template, if available.

<a name="setting-the-root-password"></a>

### Setting the root password

.IX Subsection "Setting the root password"
.Vb 1
 virt-builder fedora-27 --root-password file:/tmp/rootpw
.Ve

Create a Fedora 25 image.  The root password is taken from the file
_/tmp/rootpw_.

Note if you _don’t_ set _--root-password_ then the guest is given
a _random_ root password which is printed on stdout.

You can also create user accounts.  See \s-1USERS AND PASSWORDS\*(R"\s0 below.

<a name="set-the-hostname"></a>

### Set the hostname

.IX Subsection "Set the hostname"
.Vb 1
 virt-builder fedora-27 --hostname virt.example.com
.Ve

Set the hostname to \f(CW`virt.example.com\*(C'.

<a name="installing-software"></a>

### Installing software

.IX Subsection "Installing software"
To install packages from the ordinary (guest) software repository
(eg. dnf or apt):

.Vb 1
 virt-builder fedora-27 --install "inkscape,@Xfce Desktop"
.Ve

(In Fedora, \f(CW`@\*(C' is used to install groups of packages.  On Debian
you would install a meta-package instead.)

To update the installed packages to the latest version:

.Vb 1
 virt-builder debian-7 --update
.Ve

For guests which use SELinux, like Fedora and Red Hat Enterprise
Linux, you may need to do SELinux relabelling after installing or
updating packages (see \s-1SELINUX\*(R"\s0 below):

.Vb 1
 virt-builder fedora-27 --update --selinux-relabel
.Ve

<a name="customizing-the-installation"></a>

### Customizing the installation

.IX Subsection "Customizing the installation"
There are many options that let you customize the installation.  These
include: _--run_/_--run-command_, which run a shell script or
command while the disk image is being generated and lets you add or
edit files that go into the disk image.
_--firstboot_/_--firstboot-command_, which let you add
scripts/commands that are run the first time the guest boots.
_--edit_ to edit files.  _--upload_ to upload files.

For example:

.Vb 3
 cat &lt;&lt;EOF\*(Aq &gt; /tmp/dnf-update.sh
 dnf -y --best update
 EOF
 
 virt-builder fedora-27 --firstboot /tmp/dnf-update.sh
.Ve

or simply:

.Vb 1
 virt-builder fedora-27 --firstboot-command dnf -y --best update\*(Aq
.Ve

which makes the **dnf**\|(8) \f(CW`update\*(C' command run once the first time
the guest boots.

Or:

.Vb 3
 virt-builder fedora-27 \e
   --edit /etc/dnf/dnf.conf:
             s/gpgcheck=1/gpgcheck=0/
.Ve

which edits _/etc/dnf/dnf.conf_ inside the disk image (during disk
image creation, long before boot).

You can combine these options, and have multiple options of all types.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **--help**  
  .IX Item "--help"
  Display help.
* **--arch** \s-1ARCHITECTURE\s0  
  .IX Item "--arch ARCHITECTURE"
  Use the specified architecture for the output image.  This means
  there must be sources providing the requested template for the
  requested architecture.
  .Sp
  See also \s-1ARCHITECTURE\*(R"\s0.
* **--attach** \s-1ISOFILE\s0  
  .IX Item "--attach ISOFILE"
  During the customization phase, the given disk is attached to the
  libguestfs appliance.  This is used to provide extra software
  repositories or other data for customization.
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
  .Sp
  See also: _--run_,
  Installing packages at build time from a side repository\*(R",
  **genisoimage**\|(1), **virt-make-fs**\|(1).
* **--attach-format** \s-1FORMAT\s0  
  .IX Item "--attach-format FORMAT"
  Specify the disk format for the next _--attach_ option.  The
  \f(CW`FORMAT\*(C' is usually \f(CW\*(C\`raw\*(C' or \f(CW\*(C\`qcow2\*(C'.  Use \f(CW\*(C\`raw\*(C' for ISOs.
* **--cache** \s-1DIR\s0  
  .IX Item "--cache DIR"
* **--no-cache**  
  .IX Item "--no-cache"
  _--cache_ \s-1DIR\s0 sets the directory to use/check for cached template
  files.  If not set, defaults to either
  _\f(CI$XDG\_CACHE\_HOME/virt-builder/_ or _\f(CI$HOME/.cache/virt-builder/_.
  .Sp
  _--no-cache_ disables template caching.
* **--cache-all-templates**  
  .IX Item "--cache-all-templates"
  Download all templates to the cache and then exit.  See \s-1CACHING\*(R"\s0.
  .Sp
  Note this doesn't cache everything.  More templates might be uploaded.
  Also this doesn't cache packages (the _--install_, _--update_ options).
* **--check-signature**  
  .IX Item "--check-signature"
* **--no-check-signature**  
  .IX Item "--no-check-signature"
  Check/don’t check the digital signature of the \s-1OS\s0 template.  The
  default is to check the signature and exit if it is not correct.
  Using _--no-check-signature_ bypasses this check.
  .Sp
  See also _--fingerprint_.
* **--colors**  
  .IX Item "--colors"
* **--colours**  
  .IX Item "--colours"
  Use \s-1ANSI\s0 colour sequences to colourize messages.  This is the default
  when the output is a tty.  If the output of the program is redirected
  to a file, \s-1ANSI\s0 colour sequences are disabled unless you use this
  option.
* **--curl** \s-1CURL\s0  
  .IX Item "--curl CURL"
  Specify an alternate **curl**\|(1) binary.  You can also use this to add
  curl parameters, for example to disable https certificate checks:
  .Sp
  .Vb 1
   virt-builder --curl "curl --insecure" [...]
  .Ve
* **--delete-cache**  
  .IX Item "--delete-cache"
  Delete the template cache.  See \s-1CACHING\*(R"\s0.
* **--no-delete-on-failure**  
  .IX Item "--no-delete-on-failure"
  Don’t delete the output file on failure to build.  You can use this to
  debug failures to run scripts.  See \s-1DEBUGGING BUILDS\*(R"\s0 for ways to
  debug images.
  .Sp
  The default is to delete the output file if virt-builder fails (or,
  for example, some script that it runs fails).
* **--fingerprint** '\s-1AAAA BBBB ...\s0'  
  .IX Item "--fingerprint 'AAAA BBBB ...'"
  Check that the index and templates are signed by the key with the
  given fingerprint.  (The fingerprint is a long string, usually written
  as 10 groups of 4 hexadecimal digits).
  .Sp
  You can give this option multiple times.  If you have multiple source
  URLs, then you can have either no fingerprint, one fingerprint or
  multiple fingerprints.  If you have multiple, then each must
  correspond 1-1 with a source \s-1URL.\s0
* **--format** qcow2  
  .IX Item "--format qcow2"
* **--format** raw  
  .IX Item "--format raw"
  For ordinary builds, this selects the output format.  The default is _raw_.
  .Sp
  With _--get-kernel_ this specifies the input format.
  .Sp
  To create an old-style qcow2 file (for compatibility with \s-1RHEL 6\s0 or
  very old qemu &lt; 1.1), after running virt-builder, use this
  command:
  .Sp
  .Vb 1
   qemu-img amend -f qcow2 -o compat=0.10 output.qcow2
  .Ve
* **--get-kernel** \s-1IMAGE\s0  
  .IX Item "--get-kernel IMAGE"
  This option extracts the kernel and initramfs from a previously built
  disk image called \f(CW`IMAGE\*(C' (in fact it works for any \s-1VM\s0 disk image,
  not just ones built using virt-builder).
  .Sp
  Note this method is **deprecated**: there is a separate tool for this,
  **virt-get-kernel**\|(1), which has more options for the file extraction.
  .Sp
  The kernel and initramfs are written to the current directory, unless
  you also specify the _--output_ \f(CW`outputdir\*(C' **directory** name.
  .Sp
  The format of the disk image is automatically detected unless you
  specify it by using the _--format_ option.
  .Sp
  In the case where the guest contains multiple kernels, the one with
  the highest version number is chosen.  To extract arbitrary kernels
  from the disk image, see **guestfish**\|(1).  To extract the entire
  _/boot_ directory of a guest, see **virt-copy-out**\|(1).
* **--gpg** \s-1GPG\s0  
  .IX Item "--gpg GPG"
  Specify an alternate **gpg**\|(1) (\s-1GNU\s0 Privacy Guard) binary.  By default
  virt-builder looks for either \f(CW`gpg2\*(C' or \f(CW\*(C\`gpg\*(C' in the \f(CW$PATH.
  .Sp
  You can also use this to add gpg parameters, for example to specify an
  alternate home directory:
  .Sp
  .Vb 1
   virt-builder --gpg "gpg --homedir /tmp" [...]
  .Ve
* **-l** [os-version]  
  .IX Item "-l [os-version]"
* **--list** [os-version]  
  .IX Item "--list [os-version]"
* **--list** **--list-format** format [os-version]  
  .IX Item "--list --list-format format [os-version]"
* **--list** **--long** [os-version]  
  .IX Item "--list --long [os-version]"
  List all the available templates if no guest is specified, or only for the
  specified one.
  .Sp
  It is possible to choose with _--list-format_ the output format for the list
  templates:
    * **short**  
      .IX Item "short"
      The default format, prints only the template identifier and, next to it,
      its short description.
    * **long**  
      .IX Item "long"
      Prints a textual list with the details of the available sources, followed
      by the details of the available templates.
    * **json**  
      .IX Item "json"
      Prints a \s-1JSON\s0 object with the details of the available sources and
      the details of the available templates.
      .Sp
      The \f(CW`version\*(C' key in the main object represents the \*(L"compatibility version\*(R",
      and it is bumped every time the resulting \s-1JSON\s0 output is incompatible with
      the previous versions (for example the structure has changed, or non-optional
      keys are no more present).
      .Sp
      _--long_ is a shorthand for the \f(CW`long\*(C' format.
      .Sp
      See also: _--source_, _--notes_, \s-1SOURCES OF TEMPLATES\*(R"\s0.
* **--machine-readable**  
  .IX Item "--machine-readable"
* **--machine-readable**=format  
  .IX Item "--machine-readable=format"
  This option is used to make the output more machine friendly
  when being parsed by other programs.  See
  \s-1MACHINE READABLE OUTPUT\*(R"\s0 below.
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
  cloud environment and has nothing to do with virt-builder.
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
      when running virt-builder.  This is particularly an issue when you
      don't trust the source of the operating system templates.  (See
      \s-1SECURITY\*(R"\s0 below).
    * 4.  
      You don’t have a host network (eg. in secure/restricted environments).
* **--no-sync**  
  .IX Item "--no-sync"
  Do not sync the output file on exit.
  .Sp
  Virt-builder \f(CW`fsync\*(C's the output file or disk image when it exits.
  .Sp
  The reason is that qemu/KVM’s default caching mode is \f(CW`none\*(C' or
  \f(CW`directsync\*(C', both of which bypass the host page cache.  Therefore
  these would not work correctly if you immediately started the guest
  after running virt-builder - they would not see the complete output
  file.  (Note that you should not use these caching modes - they are
  fundamentally broken for this and other reasons.)
  .Sp
  If you are not using these broken caching modes, you can use
  _--no-sync_ to avoid this unnecessary sync and gain considerable
  extra performance.
* **--notes** os-version  
  .IX Item "--notes os-version"
  List any notes associated with this guest, then exit (this does not do
  the install).
* **-o** filename  
  .IX Item "-o filename"
* **--output** filename  
  .IX Item "--output filename"
  Write the output to _filename_.  If you don’t specify this option,
  then the output filename is generated by taking the \f(CW`os-version\*(C'
  string and adding \f(CW`.img\*(C' (for raw format) or \f(CW\*(C\`.qcow2\*(C' (for qcow2
  format).
  .Sp
  Note that the output filename could be a device, partition or logical
  volume.
  .Sp
  When used with _--get-kernel_, this option specifies the output
  directory.
* **--print-cache**  
  .IX Item "--print-cache"
  Print information about the template cache.  See \s-1CACHING\*(R"\s0.
* **-q**  
  .IX Item "-q"
* **--quiet**  
  .IX Item "--quiet"
  Don’t print ordinary progress messages.
* **--size** \s-1SIZE\s0  
  .IX Item "--size SIZE"
  Select the size of the output disk, where the size can be specified
  using common names such as \f(CW`32G\*(C' (32 gigabytes) etc.
  .Sp
  Virt-builder will resize filesystems inside the disk image
  automatically.
  .Sp
  If the size is not specified, then one of two things happens.  If the
  output is a file, then the size is the same as the template.  If the
  output is a device, partition, etc then the size of that device is
  used.
  .Sp
  To specify size in bytes, the number must be followed by the lowercase
  letter _b_, eg: \f(CW`--size 10737418240b\*(C'.
* **--smp** N  
  .IX Item "--smp N"
  Enable N ≥ 2 virtual CPUs for _--run_ scripts to use.
* **--source** \s-1URL\s0  
  .IX Item "--source URL"
  Set the source \s-1URL\s0 to look for indexes.
  .Sp
  You can give this option multiple times to specify multiple sources.
  .Sp
  See also \s-1SOURCES OF TEMPLATES\*(R"\s0 below.
  .Sp
  Note that you should not point _--source_ to sources that you don’t
  trust (unless the source is signed by someone you do trust).  See also
  the _--no-network_ option.
* **--no-warn-if-partition**  
  .IX Item "--no-warn-if-partition"
  Do not emit a warning if the output device is a partition.  This
  warning avoids a common user error when writing to a \s-1USB\s0 key or
  external drive, when you should normally write to the whole device
  (_--output /dev/sdX_), not to a partition on the device
  (_--output /dev/sdX1_).  Use this option to _suppress_ this
  warning.
* **-v**  
  .IX Item "-v"
* **--verbose**  
  .IX Item "--verbose"
  Enable debug messages and/or produce verbose output.
  .Sp
  When reporting bugs, use this option and attach the complete output to
  your bug report.
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
  Please take a look at \s-1FIRST BOOT SCRIPTS\*(R"\s0 for more
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
  Please take a look at \s-1FIRST BOOT SCRIPTS\*(R"\s0 for more
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
  \s-1INSTALLING PACKAGES\*(R"\s0.
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
  \s-1INSTALLING PACKAGES\*(R"\s0.
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
  See \s-1USERS AND PASSWORDS\*(R"\s0 for the format of
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
  See \s-1USERS AND PASSWORDS\*(R"\s0 for the format of
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
  See SUBSCRIPTION-MANAGER\*(R" for the format of
  the \f(CW`SELECTOR\*(C' field.
* **--sm-credentials** \s-1SELECTOR\s0  
  .IX Item "--sm-credentials SELECTOR"
  Set the credentials for \f(CW`subscription-manager\*(C'.
  .Sp
  See SUBSCRIPTION-MANAGER\*(R" for the format of
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
  See \s-1SSH KEYS\*(R"\s0 for the format of
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

<a name="reference"></a>

# Reference

.IX Header "REFERENCE"

<a name="s-1installing-packagess0"></a>

### \s-1INSTALLING PACKAGES\s0

.IX Subsection "INSTALLING PACKAGES"
There are several approaches to installing packages or applications in
the guest which have different trade-offs.

_Installing packages at build time_
.IX Subsection "Installing packages at build time"

If the guest \s-1OS\s0 you are installing is similar to the host \s-1OS\s0 (eg.
both are Linux), and if libguestfs supports network connections, then
you can use _--install_ to install packages like this:

.Vb 1
 virt-builder fedora-27 --install inkscape
.Ve

This uses the guest’s package manager and the host’s network
connection.

_Updating packages at build time_
.IX Subsection "Updating packages at build time"

To update the installed packages in the template at build time:

.Vb 1
 virt-builder fedora-27 --update
.Ve

Most of the templates that ship with virt-builder come with a very
minimal selection of packages (known as a \s-1JEOS\*(R"\s0 or \*(L"Just Enough
Operating System), which are up to date at the time the template is
created, but could be out of date by the time you come to install an
\s-1OS\s0 from the template.  This option updates those template packages.

_Installing packages at first boot_
.IX Subsection "Installing packages at first boot"

Another option is to install the packages when the guest first boots:

.Vb 1
 virt-builder fedora-27 --firstboot-install inkscape
.Ve

This uses the guest’s package manager and the guest’s network
connection.

The downsides are that it will take the guest a lot longer to boot
first time, and there’s nothing much you can do if package
installation fails (eg. if a network problem means the guest can't
reach the package repositories).

_Installing packages at build time from a side repository_
.IX Subsection "Installing packages at build time from a side repository"

If the software you want to install is not available in the main
package repository of the guest, then you can add a side repository.
Usually this is presented as an \s-1ISO\s0 (\s-1CD\s0 disk image) file containing
extra packages.

You can create the disk image using either **genisoimage**\|(1) or
**virt-make-fs**\|(1).  For genisoimage, use a command like this:

.Vb 1
 genisoimage -o extra-packages.iso -R -J -V EXTRA cdcontents/
.Ve

Create a script that mounts the \s-1ISO\s0 and sets up the repository.  For
dnf, create /tmp/install.sh containing:

.Vb 2
 mkdir /tmp/mount
 mount LABEL=EXTRA /tmp/mount
 
 cat &lt;&lt;EOF\*(Aq &gt; /etc/yum.repos.d/extra.repo
 [extra]
 name=extra
 baseurl=file:///tmp/mount
 enabled=1
 EOF
 
 dnf -y install famousdatabase
.Ve

For apt, create /tmp/install.sh containing:

.Vb 2
 mkdir /tmp/mount
 mount LABEL=EXTRA /tmp/mount
 
 apt-cdrom -d=/tmp/mount add
 apt-get -y install famousdatabase
.Ve

Use the _--attach_ option to attach the \s-1CD /\s0 disk image and the
_--run_ option to run the script:

.Vb 3
 virt-builder fedora-27 \e
   --attach extra-packages.iso \e
   --run /tmp/install.sh
.Ve

<a name="s-1users-and-passwordss0"></a>

### \s-1USERS AND PASSWORDS\s0

.IX Subsection "USERS AND PASSWORDS"
The _--root-password_ option is used to change the root password
(otherwise a random password is used).  This option takes a password
\f(CW`SELECTOR\*(C' in one of the following formats:

* **--root-password** file:FILENAME  
  .IX Item "--root-password file:FILENAME"
  Read the root password from \f(CW`FILENAME\*(C'.  The whole first line
  of this file is the replacement password.  Any other lines are
  ignored.  You should create the file with mode 0600 to ensure
  no one else can read it.
* **--root-password** password:PASSWORD  
  .IX Item "--root-password password:PASSWORD"
  Set the root password to the literal string \f(CW`PASSWORD\*(C'.
  .Sp
  **Note: this is not secure** since any user on the same machine can
  see the cleartext password using **ps**\|(1).
* **--root-password** random  
  .IX Item "--root-password random"
  Choose a random password, which is printed on stdout.  The password
  has approximately 120 bits of randomness.
  .Sp
  This is the default.
* **--root-password** disabled  
  .IX Item "--root-password disabled"
  The root account password is disabled.  This is like putting \f(CW`*\*(C'
  in the password field.
* **--root-password** locked:file:FILENAME  
  .IX Item "--root-password locked:file:FILENAME"
* **--root-password** locked:password:PASSWORD  
  .IX Item "--root-password locked:password:PASSWORD"
* **--root-password** locked:random  
  .IX Item "--root-password locked:random"
  The root account is locked, but a password is placed on the
  account.  If first unlocked (using \f(CW`passwd -u\*(C') then logins will
  use the given password.
* **--root-password** locked  
  .IX Item "--root-password locked"
* **--root-password** locked:disabled  
  .IX Item "--root-password locked:disabled"
  The root account is locked _and_ password is disabled.

_Creating user accounts_
.IX Subsection "Creating user accounts"

To create user accounts, use the **useradd**\|(8) command with
--firstboot-command like this:

.Vb 2
 virt-builder --firstboot-command \e
    useradd -m -p "" rjones ; chage -d 0 rjones\*(Aq
.Ve

The above command will create an \f(CW`rjones\*(C' account with no password,
and force the user to set a password when they first log in.  There
are other ways to manage passwords, see **useradd**\|(8) for details.

<a name="s-1keyboard-layouts0"></a>

### \s-1KEYBOARD LAYOUT\s0

.IX Subsection "KEYBOARD LAYOUT"
Because there are so many different ways to set the keyboard layout in
Linux distributions, virt-builder does not yet attempt to have a
simple command line option.  This section describes how to set the
keyboard for some common Linux distributions.

_Keyboard layout with systemd_
.IX Subsection "Keyboard layout with systemd"

For distros that use systemd \f(CW`localectl\*(C', use a command like this:

.Vb 2
 virt-builder fedora-27 \e
   --firstboot-command localectl set-keymap uk\*(Aq
.Ve

See **localectl**\|(1) and
https://www.happyassassin.net/2013/11/23/keyboard-layouts-in-fedora-20-and-previously/
for more details.

_Keyboard layout using /etc/sysconfig/keyboard_
.IX Subsection "Keyboard layout using /etc/sysconfig/keyboard"

For \s-1RHEL\s0 ≤ 6, Fedora ≤ 18 and similar, upload or modify the
keyboard configuration file using the _--upload_, _--write_ or
_--edit_ options.  For example:

.Vb 2
 virt-builder centos-6 \e
   --edit /etc/sysconfig/keyboard: s/^KEYTABLE=.*/KEYTABLE="uk"/\*(Aq
.Ve

The format of this file can be found documented in many places online.

_Keyboard layout with Debian-derived distros_
.IX Subsection "Keyboard layout with Debian-derived distros"

For Debian-derived distros using _/etc/default/keyboard_, upload or
modify the keyboard file using the _--upload_, _--write_ or
_--edit_ options.  For example:

.Vb 2
 virt-builder debian-8 \e
   --edit /etc/default/keyboard: s/^XKBLAYOUT=.*/XKBLAYOUT="gb"/\*(Aq
.Ve

See https://wiki.debian.org/Keyboard.

<a name="s-1languages0"></a>

### \s-1LANGUAGE\s0

.IX Subsection "LANGUAGE"
Most Linux distributions support multiple locale settings so that you
can have guest messages printed in another language such as Russian.

However there is no single setting which controls this, since extra
packages may need to be installed to support console and X fonts, and
keyboard input methods.  The packages required, and their
configuration is highly distro-specific, and it is outside the scope
of virt-builder to do this.

This section contains examples for some common Linux distributions.

_Setting Japanese in Fedora 25_
.IX Subsection "Setting Japanese in Fedora 25"

.Vb 10
 virt-builder fedora-27 \e
   --size 20G \e
   --update \e
   --install @japanese-support \e
   --install @xfce \e
   --install xorg-x11-server-Xorg,xorg-x11-drivers,rsyslog \e
   --link /usr/lib/systemd/system/graphical.target:/etc/systemd/system/default.target \e
   --firstboot-command localectl set-locale LANG=ja_JP.utf8\*(Aq \e
   --firstboot-command localectl set-keymap jp\*(Aq \e
   --firstboot-command systemctl isolate graphical.target\*(Aq
.Ve

_Setting Japanese in Debian 8 (Jessie)_
.IX Subsection "Setting Japanese in Debian 8 (Jessie)"

Note that although this enables Japanese in the text console too, it
is unlikely that you will see properly rendered Japanese there.
However Japanese is properly rendered in X applications and terminals.

.Vb 6
 pkgs=locales,xfce4,\e
 ibus,ibus-anthy,\e
 fonts-ipafont-gothic,fonts-ipafont-mincho,\e
 fonts-takao-mincho,\e
 xfonts-intl-japanese,xfonts-intl-japanese-big,\e
 iceweasel-l10n-ja,manpages-ja
 
 virt-builder debian-8 \e
   --size 20G \e
   --install $pkgs \e
   --edit /etc/locale.gen: s,^#\es*ja,ja,\*(Aq \e
   --write /etc/default/locale:LANG="ja_JP.UTF-8"\*(Aq \e
   --run-command "locale-gen"
.Ve

<a name="s-1log-files0"></a>

### \s-1LOG FILE\s0

.IX Subsection "LOG FILE"
Scripts and package installation that runs at build time (_--run_,
_--run-command_, _--install_, _--update_, but _not_ firstboot) is
logged in one of the following locations:

* _/tmp/builder.log_  
  .IX Item "/tmp/builder.log"
  On Linux, \s-1BSD,\s0 and other non-Windows guests.
* _C:\eTemp\ebuilder.log_  
  .IX Item "C:Tempbuilder.log"
  On Windows, \s-1DOS\s0 guests.
* _/builder.log_  
  .IX Item "/builder.log"
  If _/tmp_ or _C:\eTemp_ is missing.

If you don’t want the log file to appear in the final image, then
use the _--no-logfile_ command line option.

<a name="s-1ssh-keyss0"></a>

### \s-1SSH KEYS\s0

.IX Subsection "SSH KEYS"
The _--ssh-inject_ option is used to inject ssh keys for users in
the guest, so they can login without supplying a password.

The \f(CW`SELECTOR\*(C' part of the option value is optional; in this case,
_--ssh-inject_ \f(CW`USER\*(C' means that we look in the _current_
user’s _~/.ssh_ directory to find the default public \s-1ID\s0 file.  That
key is uploaded.  default public \s-1ID\*(R"\s0 is the _default\_ID\_file_ file
described in **ssh-copy-id**\|(1).

If specified, the \f(CW`SELECTOR\*(C' can be in one of the following formats:

* **--ssh-inject** USER:file:FILENAME  
  .IX Item "--ssh-inject USER:file:FILENAME"
  Read the ssh key from _\s-1FILENAME\s0_.  _\s-1FILENAME\s0_ is usually a _.pub_
  file.
* **--ssh-inject** USER:string:KEY_STRING  
  .IX Item "--ssh-inject USER:string:KEY_STRING"
  Use the specified \f(CW`KEY\_STRING\*(C'.  \f(CW\*(C\`KEY\_STRING\*(C' is usually a public
  string like _ssh-rsa \s-1AAAA....\s0 user@localhost_.

In any case, the _~USER/.ssh_ directory and the
_~USER/.ssh/authorized\_keys_ file will be created if not existing
already.

<a name="s-1first-boot-scriptss0"></a>

### \s-1FIRST BOOT SCRIPTS\s0

.IX Subsection "FIRST BOOT SCRIPTS"
The _--firstboot_ and _--firstboot-command_ options allow you to
execute commands at the first boot of the guest.  To do so, an init
script for the guest init system is installed, which takes care of
running all the added scripts and commands.

Supported operating systems are:

* Linux  
  .IX Item "Linux"
  Init systems supported are: systemd, System-V init (known also as sysvinit),
  and Upstart (using the System-V scripts).
  .Sp
  Note that usually init scripts run as root, but with a more limited
  environment than what could be available from a normal shell:
  for example, \f(CW$HOME may be unset or empty.
  .Sp
  The output of the first boot scripts is available in the guest as
  _~root/virt-sysprep-firstboot.log_.
* Windows  
  .IX Item "Windows"
  _rhsrvany.exe_, available from sources at
  https://github.com/rwmjones/rhsrvany, or _pvvxsvc.exe_, available
  with \s-1SUSE VMDP\s0 is installed to run the
  first boot scripts.  It is required, and the setup of first boot
  scripts will fail if it is not present.
  .Sp
  _rhsrvany.exe_ or _pvvxsvc.exe_ is copied from the location pointed to by the
  \f(CW`VIRT\_TOOLS\_DATA\_DIR\*(C' environment variable; if not set, a compiled-in
  default will be used (something like _/usr/share/virt-tools_).
  .Sp
  The output of the first boot scripts is available in the guest as
  _C:\eProgram Files\eGuestfs\eFirstboot\elog.txt_.

<a name="subscription-manager"></a>

### SUBSCRIPTION-MANAGER

.IX Subsection "SUBSCRIPTION-MANAGER"
It is possible to automate the registration and attaching of the
system using \f(CW`subscription-manager\*(C'.  This is typical on
Red Hat Enterprise Linux guests.  There are few options which ease
this process, avoid executing commands manually and exposing
passwords on command line.

_--sm-register_ starts the registration process, and requires
_--sm-credentials_ to be specified; the format of the \f(CW`SELECTOR\*(C'
of _--sm-credentials_ is one of the following formats:

* **--sm-credentials** USER:file:FILENAME  
  .IX Item "--sm-credentials USER:file:FILENAME"
  Read the password for the specified \f(CW`USER\*(C' from _\s-1FILENAME\s0_.
* **--sm-credentials** USER:password:PASSWORD  
  .IX Item "--sm-credentials USER:password:PASSWORD"
  Use the literal string \f(CW`PASSWORD\*(C' for the specified \f(CW\*(C\`USER\*(C'.

_--sm-attach_ attaches the system to subscriptions; the format
of its \f(CW`SELECTOR\*(C' is one of the following:

* **--sm-attach** auto  
  .IX Item "--sm-attach auto"
  \f(CW`subscription-manager\*(C' attaches to the best-fitting subscriptions
  for the system.
* **--sm-attach** file:FILENAME  
  .IX Item "--sm-attach file:FILENAME"
  Read the pool \s-1ID\s0 from _\s-1FILENAME\s0_.
* **--sm-attach** pool:POOL  
  .IX Item "--sm-attach pool:POOL"
  Use the literal string \f(CW`POOL\*(C' as pool \s-1ID.\s0

_--sm-remove_ removes all the subscriptions from the guest, while
_--sm-unregister_ completely unregister the system.

<a name="s-1installation-processs0"></a>

### \s-1INSTALLATION PROCESS\s0

.IX Subsection "INSTALLATION PROCESS"
When you invoke virt-builder, installation proceeds as follows:

* ·  
  The template image is downloaded.
  .Sp
  If the template image is present in the cache, the cached version
  is used instead.  (See \s-1CACHING\*(R"\s0).
* ·  
  The template signature is checked.
* ·  
  The template is uncompressed to a tmp file.
* ·  
  The template image is resized into the destination, using
  **virt-resize**\|(1).
* ·  
  Extra disks are attached (_--attach_).
* ·  
  A new random seed is generated for the guest.
* ·  
  Guest customization is performed, in the order specified on the
  command line.
* ·  
  SELinux relabelling is done (_--selinux-relabel_).

<a name="s-1importing-the-disk-images0"></a>

### \s-1IMPORTING THE DISK IMAGE\s0

.IX Subsection "IMPORTING THE DISK IMAGE"
_Importing into libvirt_
.IX Subsection "Importing into libvirt"

Import the disk image into libvirt using **virt-install**\|(1)
_--import_ option.

.Vb 3
 virt-install --import \e
   --name guest --ram 2048 \e
   --disk path=disk.img,format=raw --os-variant fedora27
.Ve

Notes:

* 1.  
  You _must_ specify the correct format.  The format is \f(CW`raw\*(C' unless
  you used virt-builder’s _--format_ option.
* 2.  
  _--os-variant_ is highly recommended, because it will present optimum
  devices to enable the guest to run most efficiently.  To get a list
  of all variants, do:
  .Sp
  .Vb 1
   osinfo-query os
  .Ve
  .Sp
  The above tool is provided by libosinfo package.
* 3.  
  You can run virt-install as root or non-root.  Each works slightly
  differently because libvirt manages a different set of virtual
  machines for each user.  In particular virt-manager normally shows the
  root-owned VMs, whereas Boxes shows the user-owned VMs, and other
  tools probably work differently as well.

_Importing into OpenStack_
.IX Subsection "Importing into OpenStack"

Import the image into Glance (the OpenStack image store) by doing:

.Vb 3
 glance image-create --name fedora-27-image --file fedora-27.img \e
   --disk-format raw --container-format bare \e
   --is-public True
.Ve

The _--file_ parameter is the virt-builder-generated disk image.  It
should match virt-builder’s _--output_ option.  The _--disk-format_
parameter should match virt-builder’s _--format_ option (or \f(CW`raw\*(C' if
you didn't use that option).  The _--container-format_ should always
be \f(CW`bare\*(C' since virt-builder doesn't put images into containers.

You can use the \f(CW`glance image-show \f(CIfedora-27-image\f(CW\*(C' command to
display the properties of the image.

To boot up an instance of your image on a Nova compute node, do:

.Vb 2
 nova boot fedora-27-server --image fedora-27-image \e
   --flavor m1.medium
.Ve

Use \f(CW`nova flavor-list\*(C' to list possible machine flavors.  Use
\f(CW`nova list\*(C' to list running instances.

_Booting directly using qemu or \s-1KVM\s0_
.IX Subsection "Booting directly using qemu or KVM"

The qemu command line is not very stable or easy to use, hence libvirt
should be used if possible.  However a command line similar to the
following could be used to boot the virtual machine:

.Vb 5
 qemu-system-x86_64 \e
   -machine accel=kvm:tcg \e
   -cpu host \e
   -m 2048 \e
   -drive file=disk.img,format=raw,if=virtio
.Ve

As with libvirt, it is very important that the correct format is
chosen.  It will be \f(CW`raw\*(C' unless the _--format_ option was used.

<a name="s-1configuration-managements0"></a>

### \s-1CONFIGURATION MANAGEMENT\s0

.IX Subsection "CONFIGURATION MANAGEMENT"
_Puppet_
.IX Subsection "Puppet"

To enable the Puppet agent in a guest, install the package, point
the configuration at your Puppetmaster, and ensure the agent runs
at boot.

A typical virt-builder command would be:

.Vb 8
 virt-builder fedora-27 \e
   --hostname client.example.com \e
   --update \e
   --install puppet \e
   --append-line /etc/puppet/puppet.conf:[agent]\*(Aq \e
   --append-line /etc/puppet/puppet.conf:server = puppetmaster.example.com/\*(Aq \e
   --run-command systemctl enable puppet\*(Aq \e
   --selinux-relabel
.Ve

The precise instructions vary according to the Linux distro.  For
further information see:
https://docs.puppet.com/puppet/latest/install_pre.html

<a name="s-1debugging-buildss0"></a>

### \s-1DEBUGGING BUILDS\s0

.IX Subsection "DEBUGGING BUILDS"
If virt-builder itself fails, then enable debugging (_-v_) and report
a bug (see \s-1BUGS\*(R"\s0 below).

If virt-builder fails because some script or package it is installing
fails, try using _--no-delete-on-failure_ to preserve the output
file, and continue reading this section.

If virt-builder is successful but the image doesn't work, here are
some things to try:

* Use virt-rescue  
  .IX Item "Use virt-rescue"
  Run **virt-rescue**\|(1) on the disk image:
  .Sp
  .Vb 1
   virt-rescue -a disk.img
  .Ve
  .Sp
  This gives you a rescue shell.  You can mount the filesystems from the
  disk image on _/sysroot_ and examine them using ordinary Linux
  commands.  You can also chroot into the guest to reinstall the
  bootloader.  The virt-rescue man page has a lot more information and
  examples.
* Use guestfish  
  .IX Item "Use guestfish"
  Run **guestfish**\|(1) on the disk image:
  .Sp
  .Vb 1
   guestfish -a disk.img -i
  .Ve
  .Sp
  Use guestfish commands like \f(CW`ll /directory\*(C' and \f(CW\*(C\`cat /file\*(C' to
  examine directories and files.
* Use guestmount  
  .IX Item "Use guestmount"
  Mount the disk image safely on the host using \s-1FUSE\s0 and **guestmount**\|(1):
  .Sp
  .Vb 3
   mkdir /tmp/mp
   guestmount -a disk.img -i /tmp/mp
   cd /tmp/mp
  .Ve
  .Sp
  To unmount the disk image do:
  .Sp
  .Vb 1
   fusermount -u /tmp/mp
  .Ve
* Add a serial console  
  .IX Item "Add a serial console"
  If the guest hangs during boot, it can be helpful to add a serial
  console to the guest, and direct kernel messages to the serial
  console.  Adding the serial console will involve looking at the
  documentation for your hypervisor.  To direct kernel messages to the
  serial console, add the following on the kernel command line:
  .Sp
  .Vb 1
   console=tty0 console=ttyS0,115200
  .Ve

<a name="s-1sources-of-templatess0"></a>

### \s-1SOURCES OF TEMPLATES\s0

.IX Subsection "SOURCES OF TEMPLATES"
virt-builder reads the available sources from configuration files,
with the _.conf_ extension and located in the following paths:

* ·  
  \f(CW$XDG\_CONFIG\_HOME/virt-builder/repos.d/ (\f(CW$XDG\_CONFIG\_HOME is
  _\f(CI$HOME/.config_ if not set).
* ·  
  \f(CW$XDG\_CONFIG\_DIRS/virt-builder/repos.d/ (where \f(CW$XDG\_CONFIG\_DIRS
  means any of the directories in that environment variable, or just _/etc/xdg_
  if not set)

Each _.conf_ file in those paths has a simple text format like the
following:

.Vb 3
 [libguestfs.org]
 uri=http://libguestfs.org/download/builder/index.asc
 gpgkey=file:///etc/xdg/virt-builder/repos.d/libguestfs.gpg
.Ve

The part in square brackets is the repository identifier, which is
used as unique identifier.

The following fields can appear:
.ie n .IP """uri=URI""" 4
.el .IP "\f(CWuri=URI" 4
.IX Item "uri=URI"
The \s-1URI\s0 of the index file which this repository refers to.
.Sp
This field is required.
.ie n .IP """gpgkey=URI""" 4
.el .IP "\f(CWgpgkey=URI" 4
.IX Item "gpgkey=URI"
This optional field represents the \s-1URI\s0 (although only _file://_ URIs
are accepted) of the key used to sign the index file.
If not present, the index file referred by _uri=.._ is not signed.
.ie n .IP """proxy=MODE""" 4
.el .IP "\f(CWproxy=MODE" 4
.IX Item "proxy=MODE"
This optional field specifies the proxy mode, to be used when downloading
the index file of this repository.  The possible values are:

* **no**, **off**  
  .IX Item "no, off"
  No proxy is being used at all, even overriding the system configuration.
* **system**  
  .IX Item "system"
  The proxy used is the system one.
* _anything else_  
  .IX Item "anything else"
  Specifies the actual proxy configuration to be used, overriding the system
  configuration.
.Sp
If not present, the assumed value is to respect the proxy settings of the
system (i.e. as if **system** would be specified).
.ie n .IP """format=FORMAT""" 4
.el .IP "\f(CWformat=FORMAT" 4
.IX Item "format=FORMAT"
This optional field specifies the format of the repository.
The possible values are:

* **native**  
  .IX Item "native"
  The native format of the \f(CW`virt-builder\*(C' repository.  See also
  Creating and signing the index file\*(R" below.
* **simplestreams**  
  .IX Item "simplestreams"
  The \s-1URI\s0 represents the root of a Simple Streams v1.0 tree of metadata.
  .Sp
  For more information about Simple Streams, see also
  https://launchpad.net/simplestreams.
.Sp
If not present, the assumed value is \f(CW`native\*(C'.

For serious virt-builder use, you may want to create your own
repository of templates.

_Libguestfs.org repository_
.IX Subsection "Libguestfs.org repository"

Out of the box, virt-builder downloads the file
http://libguestfs.org/download/builder/index.asc which is an index
of available templates plus some information about each one, wrapped
up in a digital signature.  The command \f(CW`virt-builder --list\*(C' lists
out the information in this index file.

The templates hosted on libguestfs.org were created using shell
scripts, kickstart files and preseed files which can be found in the
libguestfs source tree, in \f(CW`builder/templates\*(C'.

_Setting up the repository_
.IX Subsection "Setting up the repository"

You can set up your own site containing an index file and some
templates, and then point virt-builder at the site by creating a
_.conf_ file pointing to it.

Note that if your index is signed, you will need to properly fill
_gpgkey=.._ in your _.conf_ file, making sure to deploy also the
\s-1GPG\s0 key file.

.Vb 3
 virt-builder --source https://example.com/builder/index.asc \e
    --fingerprint AAAA BBBB ...\*(Aq \e
    --list
.Ve

You can host this on any web or \s-1FTP\s0 server, or a local or network
filesystem.

_Setting up a \s-1GPG\s0 key_
.IX Subsection "Setting up a GPG key"

If you don’t have a GnuPG key, you will need to set one up.  (Strictly
speaking this is optional, but if your index and template files are
not signed then virt-builder users will have to use the
_--no-check-signature_ flag every time they use virt-builder.)

To create a key, see the \s-1GPG\s0 manual
http://www.gnupg.org/gph/en/manual.html.

Export your \s-1GPG\s0 public key:

.Vb 1
 gpg --export -a "you@example.com" &gt; pubkey
.Ve

_Create the templates_
.IX Subsection "Create the templates"

There are many ways to create the templates.  For example you could
clone existing guests (see **virt-sysprep**\|(1)), or you could install a
guest by hand (**virt-install**\|(1)).  To see how the templates were
created for virt-builder, look at the scripts in \f(CW`builder/templates\*(C'

Virt-builder supports any image format (e.g. raw, qcow2, etc) as
template, both as-is, and compressed as \s-1XZ.\s0  This way, existing images
(e.g. cleaned using **virt-sysprep**\|(1)) can be used as templates.

For best results when compressing the templates, use the following xz
options (see **nbdkit-xz-plugin**\|(1) for further explanation):

.Vb 1
 xz --best --block-size=16777216 disk
.Ve

_Creating and signing the index file_
.IX Subsection "Creating and signing the index file"

The index file has a simple text format (shown here without the
digital signature):

.Vb 10
 [fedora-18]
 name=Fedora® 18
 osinfo=fedora18
 arch=x86_64
 file=fedora-18.xz
 checksum[sha512]=...
 format=raw
 size=6442450944
 compressed_size=148947524
 expand=/dev/sda3
 
 [fedora-19]
 name=Fedora® 19
 osinfo=fedora19
 arch=x86_64
 file=fedora-19.xz
 checksum[sha512]=...
 revision=3
 format=raw
 size=4294967296
 compressed_size=172190964
 expand=/dev/sda3
.Ve

The part in square brackets is the \f(CW`os-version\*(C', which is the same
string that is used on the virt-builder command line to build that \s-1OS.\s0

The index file creation and signature can be eased with the
**virt-builder-repository**\|(1) tool.

After preparing the \f(CW`index\*(C' file in the correct format, clearsign it
using the following command:

.Vb 1
 gpg --clearsign --armor index
.Ve

This will create the final file called _index.asc_ which can be
uploaded to the server (and is the _uri=.._ \s-1URL\s0).  As noted above,
signing the index file is optional, but recommended.

The following fields can appear:
.ie n .IP """name=NAME""" 4
.el .IP "\f(CWname=NAME" 4
.IX Item "name=NAME"
The user-friendly name of this template.  This is displayed in the
_--list_ output but is otherwise not significant.
.ie n .IP """osinfo=ID""" 4
.el .IP "\f(CWosinfo=ID" 4
.IX Item "osinfo=ID"
This optional field maps the operating system to the associated
libosinfo \s-1ID.\s0  Virt-builder does not use it (yet).
.ie n .IP """arch=ARCH""" 4
.el .IP "\f(CWarch=ARCH" 4
.IX Item "arch=ARCH"
The architecture of the operating system installed within the
template. This field is required.
.ie n .IP """file=PATH""" 4
.el .IP "\f(CWfile=PATH" 4
.IX Item "file=PATH"
The path (relative to the index) of the xz-compressed template.
.Sp
Note that absolute paths or URIs are **not** permitted here.  This is
because virt-builder has a same origin\*(R" policy for templates so they
cannot come from other servers.
.ie n .IP """sig=PATH""" 4
.el .IP "\f(CWsig=PATH" 4
.IX Item "sig=PATH"
**This option is deprecated**.  Use the checksum field instead.
.Sp
The path (relative to the index) of the \s-1GPG\s0 detached signature of the
xz file.
.Sp
Note that absolute paths or URIs are **not** permitted here.  This is
because virt-builder has a same origin\*(R" policy for templates so they
cannot come from other servers.
.Sp
The file can be created as follows:
.Sp
.Vb 1
 gpg --detach-sign --armor -o disk.xz.sig disk.xz
.Ve
.ie n .IP """checksum[sha512]=7b882fe9b82eb0fef...""" 4
.el .IP "\f(CWchecksum[sha512]=7b882fe9b82eb0fef..." 4
.IX Item "checksum[sha512]=7b882fe9b82eb0fef..."
The \s-1SHA-512\s0 checksum of the file specified in _file=.._ is checked
after it is downloaded.  To work out the signature, do:
.Sp
.Vb 1
 sha512sum disk.xz
.Ve
.Sp
Note if you use this, you don’t need to sign the file, ie. don’t use
\f(CW`sig\*(C'.  This option overrides \f(CW\*(C\`sig\*(C'.
.ie n .IP """checksum=7b882fe9b82eb0fef...""" 4
.el .IP "\f(CWchecksum=7b882fe9b82eb0fef..." 4
.IX Item "checksum=7b882fe9b82eb0fef..."
\f(CW`checksum\*(C' is an alias for \f(CW\*(C\`checksum[sha512]\*(C'.
.Sp
If you need to interoperate with virt-builder = 1.24.0 then you have
to use \f(CW`checksum\*(C' because that version would give a parse error with
square brackets and numbers in the key of a field.  This is fixed in
virt-builder ≥ 1.24.1.
.ie n .IP """revision=N""" 4
.el .IP "\f(CWrevision=N" 4
.IX Item "revision=N"
The revision is an integer which is used to control the template
cache.  Increasing the revision number causes clients to download the
template again even if they have a copy in the cache.
.Sp
The revision number is optional.  If omitted it defaults to \f(CW1.
.ie n .IP """format=raw""" 4
.el .IP "\f(CWformat=raw" 4
.IX Item "format=raw"
.ie n .IP """format=qcow2""" 4
.el .IP "\f(CWformat=qcow2" 4
.IX Item "format=qcow2"
Specify the format of the disk image; in case it is compressed, that
is the format before the compression.  If not given, the format is
autodetected, but generally it is better to be explicit about the
intended format.
.Sp
Note this is the source format, which is different from the
_--format_ option (requested output format).  Virt-builder does
on-the-fly conversion from the source format to the requested output
format.
.ie n .IP """size=NNN""" 4
.el .IP "\f(CWsize=NNN" 4
.IX Item "size=NNN"
The virtual size of the image in bytes.  This is the size of the image
when uncompressed.  If using a non-raw format such as qcow2 then it
means the virtual disk size, not the size of the qcow2 file.
.Sp
This field is required.
.Sp
Virt-builder also uses this as the minimum size that users can request
via the _--size_ option, or as the default size if there is no
_--size_ option.
.ie n .IP """compressed_size=NNN""" 4
.el .IP "\f(CWcompressed\_size=NNN" 4
.IX Item "compressed_size=NNN"
The actual size of the disk image in bytes, i.e. what was specified
in _file=.._.  This is just used for information (when using \f(CW`long\*(C',
and \f(CW`json\*(C' formats of _--list_).
.ie n .IP """expand=/dev/sdaX""" 4
.el .IP "\f(CWexpand=/dev/sdaX" 4
.IX Item "expand=/dev/sdaX"
When expanding the image to its final size, instruct **virt-resize**\|(1)
to expand the named partition in the guest image to fill up all
available space.  This works like the virt-resize _--expand_ option.
.Sp
You should usually put the device name of the guest’s root filesystem here.
.Sp
It’s a good idea to use this, but not required.  If the field is
omitted then virt-resize will create an extra partition at the end of
the disk to cover the free space, which is much less user-friendly.
.ie n .IP """lvexpand=/dev/VolGroup/LogVol""" 4
.el .IP "\f(CWlvexpand=/dev/VolGroup/LogVol" 4
.IX Item "lvexpand=/dev/VolGroup/LogVol"
When expanding the image to its final size, instruct **virt-resize**\|(1)
to expand the named logical volume in the guest image to fill up all
available space.  This works like the virt-resize _--lv-expand_ option.
.Sp
If the guest uses \s-1LVM2\s0 you should usually put the \s-1LV\s0 of the guest’s
root filesystem here.  If the guest does not use \s-1LVM2\s0 or its root
filesystem is not on an \s-1LV,\s0 don't use this option.
.ie n .IP """notes=NOTES""" 4
.el .IP "\f(CWnotes=NOTES" 4
.IX Item "notes=NOTES"
Any notes that go with this image, especially notes describing what
packages are in the image, how the image was prepared, and licensing
information.
.Sp
This information is shown in the _--notes_ and _--list_ _--long_ modes.
.Sp
You can use multi-line notes here by indenting each new line with at
least one character of whitespace (even on blank lines):
.Sp
.Vb 5
 notes=This image was prepared using
  the following kickstart script:
                                &lt;-- one space at beginning of line
  part /boot --fstype ext3
  ...
.Ve
.ie n .IP """hidden=true""" 4
.el .IP "\f(CWhidden=true" 4
.IX Item "hidden=true"
Using the hidden flag prevents the template from being listed by the
_--list_ option (but it is still installable).  This is used for test
images.
.ie n .IP """aliases=ALIAS1 ALIAS2 ...""" 4
.el .IP "\f(CWaliases=ALIAS1 ALIAS2 ..." 4
.IX Item "aliases=ALIAS1 ALIAS2 ..."
This optional field specifies a list of aliases, separated by spaces,
for the image.  For example, an alias could be used to always point
to the latest version of a certain image, leaving the old versions
available in the index instead of updating the same image (see the
\f(CW`revision\*(C' field).

_Running virt-builder against multiple sources_
.IX Subsection "Running virt-builder against multiple sources"

It is possible to use multiple sources with virt-builder.
The recommended way is to deploy _.conf_ files pointing to the
index files. Another way is to specify the sources using
multiple _--source_ and/or _--fingerprint_ options:

.Vb 3
 virt-builder \e
   --source http://example.com/s1/index.asc \e
   --source http://example.com/s2/index.asc
.Ve

You can provide N or 1 fingerprints.  In the case where you
provide N fingerprints, N = number of sources and there is a 1-1
correspondence between each source and each fingerprint:

.Vb 3
 virt-builder \e
   --source http://example.com/s1/index.asc --fingerprint 0123 ...\*(Aq \e
   --source http://example.com/s2/index.asc --fingerprint 9876 ...\*(Aq
.Ve

In the case where you provide 1 fingerprint, the same fingerprint
is used for all sources.

You \f(CW`must\*(C' provide at least 1 fingerprint.

_Licensing of templates_
.IX Subsection "Licensing of templates"

You should be aware of the licensing of images that you distribute.
For open source guests, provide a link to the source code in the
\f(CW`notes\*(C' field and comply with other requirements (eg. around
trademarks).

_Formal specification of the index file_
.IX Subsection "Formal specification of the index file"

The index file format has a formal specification defined by the flex
scanner and bison parser used to parse the file.  This can be found in
the following files in the libguestfs source tree:

.Vb 2
 builder/index-scan.l
 builder/index-parse.y
.Ve

A tool called **virt-index-validate**\|(1) is available to validate the
index file to ensure it is correct.

Note that the parser and tool can work on either the signed or
unsigned index file (ie. _index_ or _index.asc_).

The index is always encoded in \s-1UTF-8.\s0

<a name="s-1cachings0"></a>

### \s-1CACHING\s0

.IX Subsection "CACHING"
_Caching templates_
.IX Subsection "Caching templates"

Since the templates are usually very large, downloaded templates are
cached in the user’s home directory.

The location of the cache is _\f(CI$XDG\_CACHE\_HOME/virt-builder/_ or
_\f(CI$HOME/.cache/virt-builder_.

You can print out information about the cache directory, including
which guests are currently cached, by doing:

.Vb 1
 virt-builder --print-cache
.Ve

The cache can be deleted if you want to save space by doing:

.Vb 1
 virt-builder --delete-cache
.Ve

You can download all (current) templates to the local cache by doing:

.Vb 1
 virt-builder --cache-all-templates
.Ve

To disable the template cache, use _--no-cache_.

Only templates are cached.  The index and detached digital signatures
are not cached.

_Caching packages_
.IX Subsection "Caching packages"

Virt-builder uses **curl**\|(1) to download files and it also uses the
current \f(CW`http\_proxy\*(C' (etc) settings when installing packages
(_--install_, _--update_).

You may therefore want to set those environment variables in order to
maximize the amount of local caching that happens.  See
\s-1ENVIRONMENT VARIABLES\*(R"\s0 and **curl**\|(1).

_Local mirrors_
.IX Subsection "Local mirrors"

To increase both speed and reliability of installing packages, you can
set up a local mirror of the target distribution, and point the guest
package manager at that.

Using a local mirror with Fedora
.IX Subsection "Using a local mirror with Fedora"

To install a Fedora guest using a local mirror:

.Vb 11
 virt-builder fedora-27 \e
   --edit /etc/yum.repos.d/fedora.repo:
       s{.*baseurl=.*}{baseurl=http://example.com/mirror/};
       s{.*metalink=.*}{};
    \e
   --edit /etc/yum.repos.d/fedora-updates.repo:
       s{.*baseurl=.*}{baseurl=http://example.com/mirror-updates/};
       s{.*metalink=.*}{};
    \e
   --run-command dnf -y update\*(Aq \e
   --install pkg1,pkg2,...\*(Aq
.Ve

Using a local mirror with Debian
.IX Subsection "Using a local mirror with Debian"

Assuming that you are using \f(CW`apt-proxy\*(C' to mirror the repository, you
should create a new _sources.list_ file to point to your proxy (see
https://help.ubuntu.com/community/AptProxy) and then do:

.Vb 4
 virt-builder debian-8 \e
   --upload sources.list:/etc/apt/sources.list \e
   --run-command apt-get -y update\*(Aq \e
   --install pkg1,pkg2,...\*(Aq
.Ve

<a name="s-1digital-signaturess0"></a>

### \s-1DIGITAL SIGNATURES\s0

.IX Subsection "DIGITAL SIGNATURES"
Virt-builder uses \s-1GNU\s0 Privacy Guard (GnuPG or gpg) to verify that the
index and templates have not been tampered with.

The source points to an index file, which is optionally signed.

Virt-builder downloads the index and checks that the signature is
valid and the signer’s fingerprint matches the specified fingerprint
(ie. the one specified in _gpgkey=.._ in the _.conf_, or with
_--fingerprint_, in that order).

For checking against the built-in public key/fingerprint, this
requires importing the public key into the user’s local gpg keyring
(that’s just the way that gpg works).

When a template is downloaded, its signature is checked in the same
way.

Although the signatures are optional, if you don’t have them then
virt-builder users will have to use _--no-check-signature_ on the
command line.  This prevents an attacker from replacing the signed
index file with an unsigned index file and having virt-builder
silently work without checking the signature.  In any case it is
highly recommended that you always create signed index and templates.

<a name="s-1architectures0"></a>

### \s-1ARCHITECTURE\s0

.IX Subsection "ARCHITECTURE"
Virt-builder can build a guest for any architecture no matter what the
host architecture is.  For example an x86-64 guest on an \s-1ARM\s0 host.

However certain options may not work, specifically options
that require running commands in the guest during the build process:
_--install_, _--update_, _--run_, _--run-command_.  You may need
to replace these with their firstboot-equivalents.

An x86-64 host building 32 bit i686 guests should work without any
special steps.

<a name="s-1securitys0"></a>

### \s-1SECURITY\s0

.IX Subsection "SECURITY"
Virt-builder does not need to run as root (in fact, should not be run
as root), and doesn't use setuid, \f(CW`sudo\*(C' or any similar mechanism.

_--install_, _--update_, _--run_ and _--run-command_ are
implemented using an appliance (a small virtual machine) so these
commands do not run on the host.  If you are using the libguestfs
libvirt backend and have SELinux enabled then the virtual machine is
additionally encapsulated in an SELinux container (sVirt).

However these options will have access to the host’s network and since
the template may contain untrusted code, the code might try to access
host network resources which it should not.  You can use
_--no-network_ to prevent this.

Firstboot commands run in the context of the guest when it is booted,
and so the security of your hypervisor / cloud should be considered.

Virt-builder injects a random seed into every guest which it builds.
This helps to ensure that \s-1TCP\s0 sequence numbers, UUIDs, ssh host keys
etc are truly random when the guest boots.

You should check digital signatures and not ignore any signing errors.

<a name="s-1cloness0"></a>

### \s-1CLONES\s0

.IX Subsection "CLONES"
If you wish to create many new guests of the same type, it is tempting
to run virt-builder once and then copy the output file.  You should
**not** do this.  You should run virt-builder once for each new guest
you need.

The reason is that each clone needs to have (at least) a separate
random seed, and possibly other unique features (such as filesystem
UUIDs) in future versions of virt-builder.

Another thing you should _not_ do is to boot the guest, then clone
the booted disk image.  The reason is that some guests create unique
machine IDs, \s-1SSH\s0 host keys and so on at first boot, and you would not
want clones to have duplicate identities.

See also: **virt-sysprep**\|(1).

<a name="s-1performances0"></a>

### \s-1PERFORMANCE\s0

.IX Subsection "PERFORMANCE"
The most important aspect of getting good performance is caching.
Templates gets downloaded into the cache the first time they are used,
or if you use the _--cache-all-templates_ option.  See \s-1CACHING\*(R"\s0
above for further information.

Packages required for the _--install_ and _--update_ options are
downloaded using the host network connection.  Setting the
\f(CW`http\_proxy\*(C', \f(CW\*(C\`https\_proxy\*(C' and \f(CW\*(C\`ftp\_proxy\*(C' environment variables
to point to a local web cache may ensure they only need to be
downloaded once.  You can also try using a local package repository,
although this can be complex to set up and varies according to which
Linux distro you are trying to install.

_Using --no-sync_
.IX Subsection "Using --no-sync"

Use _--no-sync_.  However read the caveats in the \s-1OPTIONS\*(R"\s0 section
above, since this can cause disk corruption if not used correctly.

_Skipping virt-resize_
.IX Subsection "Skipping virt-resize"

Virt-builder can skip the virt-resize step under certain conditions.
This makes virt-builder much faster.  The conditions are:

* ·  
  the output must be a regular file (not a block device), **and**
* ·  
  the user did **not** use the _--size_ option, **and**
* ·  
  the output format is the same as the template format (usually raw).

_pxzcat_
.IX Subsection "pxzcat"

Virt-builder uses an internal implementation of pxzcat (parallel
xzcat) if liblzma was found at build time.  If liblzma was not found
at build time, regular \f(CW`xzcat\*(C' is used which is single-threaded.

_User-Mode Linux_
.IX Subsection "User-Mode Linux"

You can use virt-builder with the User-Mode Linux (\s-1UML\s0) backend.  This
may be faster when running virt-builder inside a virtual machine
(eg. in the cloud).

To enable the \s-1UML\s0 backend, read the instructions in
USER-MODE \s-1LINUX BACKEND\*(R"\s0 in **guestfs**\|(3).

Currently you have to use the _--no-network_ option.  This should be
fixed in a future version.

The qcow2 output format is not supported by \s-1UML.\s0  You can only create
raw-format guests.

<a name="s-1selinuxs0"></a>

### \s-1SELINUX\s0

.IX Subsection "SELINUX"
Guests which use SELinux (such as Fedora and Red Hat Enterprise Linux)
require that each file has a correct SELinux label.

Virt-builder does not know how to give new files a label, so there are
two possible strategies it can use to ensure correct labelling:

* Using _--selinux-relabel_  
  .IX Item "Using --selinux-relabel"
  This runs **setfiles**\|(8) just before finalizing the guest, which sets
  SELinux labels correctly in the disk image.
  .Sp
  This is the recommended method.
* _--touch_ _/.autorelabel_  
  .IX Item "--touch /.autorelabel"
  Guest templates may already contain a file called _/.autorelabel_ or
  you may touch it.
  .Sp
  For guests that use SELinux, this causes **restorecon**\|(8) to run at
  first boot.  Guests will reboot themselves once the first time you use
  them, which is normal and harmless.

Please note that if your guest uses SELinux, and you are doing operations
on it which might create new files or change existing ones, you are
recommended to use _--selinux-relabel_.  This will help in making sure
that files have the right SELinux labels.

<a name="machine-readable-output"></a>

# Machine Readable Output

.IX Header "MACHINE READABLE OUTPUT"
The _--machine-readable_ option can be used to make the output more
machine friendly, which is useful when calling virt-builder from other
programs, GUIs etc.

Use the option on its own to query the capabilities of the
virt-builder binary.  Typical output looks like this:

.Vb 7
 $ virt-builder --machine-readable
 virt-builder
 arch
 config-file
 customize
 json-list
 pxzcat
.Ve

A list of features is printed, one per line, and the program exits
with status 0.

It is possible to specify a format string for controlling the output;
see \s-1ADVANCED MACHINE READABLE OUTPUT\*(R"\s0 in **guestfs**\|(3).

<a name="environment-variables"></a>

# Environment Variables

.IX Header "ENVIRONMENT VARIABLES"
For other environment variables which affect all libguestfs programs,
see \s-1ENVIRONMENT VARIABLES\*(R"\s0 in **guestfs**\|(3).
.ie n .IP """http_proxy""" 4
.el .IP "\f(CWhttp\_proxy" 4
.IX Item "http_proxy"
.ie n .IP """https_proxy""" 4
.el .IP "\f(CWhttps\_proxy" 4
.IX Item "https_proxy"
.ie n .IP """no_proxy""" 4
.el .IP "\f(CWno\_proxy" 4
.IX Item "no_proxy"
Set the proxy for downloads.  These environment variables (and more)
are actually interpreted by **curl**\|(1), not virt-builder.
.ie n .IP """HOME""" 4
.el .IP "\f(CWHOME" 4
.IX Item "HOME"
Used to determine the location of the template cache, and the location
of the user' sources.  See \s-1CACHING\*(R"\s0 and \*(L"\s-1SOURCES OF TEMPLATES\*(R"\s0.
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
.ie n .IP """XDG_CACHE_HOME""" 4
.el .IP "\f(CWXDG\_CACHE\_HOME" 4
.IX Item "XDG_CACHE_HOME"
Used to determine the location of the template cache.  See \s-1CACHING\*(R"\s0.
.ie n .IP """XDG_CONFIG_HOME""" 4
.el .IP "\f(CWXDG\_CONFIG\_HOME" 4
.IX Item "XDG_CONFIG_HOME"
Used to determine the location of the user' sources.  See
\s-1SOURCES OF TEMPLATES\*(R"\s0.
.ie n .IP """XDG_CONFIG_DIRS""" 4
.el .IP "\f(CWXDG\_CONFIG\_DIRS" 4
.IX Item "XDG_CONFIG_DIRS"
Used to determine the location of the system sources.  See
\s-1SOURCES OF TEMPLATES\*(R"\s0.

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
**guestmount**\|(1),
**virt-builder-repository**\|(1),
**virt-copy-out**\|(1),
**virt-customize**\|(1),
**virt-get-kernel**\|(1),
**virt-install**\|(1),
**virt-rescue**\|(1),
**virt-resize**\|(1),
**virt-sysprep**\|(1),
**oz-install**\|(1),
**gpg**\|(1),
**gpg2**\|(1),
**curl**\|(1),
**virt-make-fs**\|(1),
**genisoimage**\|(1),
http://libguestfs.org/.

<a name="author"></a>

# Author

.IX Header "AUTHOR"
Richard W.M. Jones http://people.redhat.com/~rjones/

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright (C) 2013 Red Hat Inc.

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
