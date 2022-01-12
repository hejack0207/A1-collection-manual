# virt-p2v(1)

libguestfs-1.40.2, 2019-02-07

.if n .ad l
.nh

<a name="name"></a>

# Name

virt-p2v - Convert a physical machine to use KVM

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" .Vb 1  virt-p2v   virt-p2v.iso .Ve
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
Virt-p2v converts a physical machine to run virtualized on \s-1KVM,\s0
managed by libvirt, OpenStack, oVirt, Red Hat Virtualisation (\s-1RHV\s0), or
one of the other targets supported by **virt-v2v**\|(1).

Normally you don’t run the virt-p2v program directly.  Instead you
have to boot the physical machine using the bootable CD-ROM, \s-1ISO\s0 or
\s-1PXE\s0 image.  This bootable image contains the virt-p2v binary and runs
it automatically.  Booting from a CD-ROM/etc is required because the
disks which are being converted must be quiescent.  It is not safe to
try to convert a running physical machine where other programs may be
modifying the disk content at the same time.

This manual page documents running the virt-p2v program.  To create
the bootable image you should look at **virt-p2v-make-disk**\|(1) or
**virt-p2v-make-kickstart**\|(1).

<a name="network-setup"></a>

# Network Setup

.IX Header "NETWORK SETUP"
Virt-p2v runs on the physical machine which you want to convert.  It
has to talk to another server called the conversion server\*(R" which
must have **virt-v2v**\|(1) installed on it.  It always talks to the
conversion server over \s-1SSH:\s0

.Vb 5
 ┌──────────────┐                  ┌─────────────────┐
 │ virt-p2v     │                  │ virt-v2v        │
 │ (physical    │  ssh connection  │ (conversion     │
 │  server)   ╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍▶ server)       │
 └──────────────┘                  └─────────────────┘
.Ve

The virt-v2v program on the conversion server does the actual
conversion (physical to virtual, and virtual to virtual conversions
are sufficiently similar that we use the same program to do both).

The \s-1SSH\s0 connection is always initiated from the physical server.  All
data is transferred over the \s-1SSH\s0 connection.  In terms of firewall and
network configuration, you only need to ensure that the physical
server has access to a port (usually \s-1TCP\s0 port 22) on the conversion
server.  Note that the physical machine may reconnect several times
during the conversion process.

The reverse port forwarding feature of ssh (ie. \f(CW`ssh -R\*(C') is required
by virt-p2v, and it will not work if this is disabled on the
conversion server.  (\f(CW`AllowTcpForwarding\*(C' must be \f(CW\*(C\`yes\*(C' in the
**sshd\_config**\|(5) file on the conversion server).

The scp (secure copy) feature of ssh is required by virt-p2v so it can
send over small files (this is _not_ the method by which disks are
copied).

The conversion server does not need to be a physical machine.  It
could be a virtual machine, as long as it has sufficient memory and
disk space to do the conversion, and as long as the physical machine
can connect directly to its \s-1SSH\s0 port.  (See also
Resource requirements\*(R" in **virt-v2v**\|(1)).

Because all of the data on the physical server’s hard drive(s) has to
be copied over the network, the speed of conversion is largely
determined by the speed of the network between the two machines.

<a name="gui-interactive-configuration"></a>

# Gui Interactive Configuration

.IX Header "GUI INTERACTIVE CONFIGURATION"
When you start virt-p2v, you'll see a graphical configuration dialog
that walks you through connection to the conversion server, asks for
the password, which local hard disks you want to convert, and other
things like the name of the guest to create and the number of virtual
CPUs to give it.

<a name="s-1ssh-configuration-dialogs0"></a>

### \s-1SSH CONFIGURATION DIALOG\s0

.IX Subsection "SSH CONFIGURATION DIALOG"
When virt-p2v starts up in \s-1GUI\s0 mode, the first dialog looks like this:

.Vb 11
 ┌─────────────────────────────────────────────────────────────┐
 │                           virt-p2v                          │
 │                                                             │
 │ Conversion server: [_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_] : [22_\|_\|_] │
 │                                                             │
 │         User name: [root_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_] │
 │                                                             │
 │          Password: [_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_] │
 │                                                             │
 │  SSH Identity URL: [_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_] │
 │                                                             │
.Ve

In the fields above, you must enter the details of the conversion
server: the hostname, \s-1SSH\s0 port number, remote user name, and either
the password or \s-1SSH\s0 identity (private key) \s-1URL.\s0  The conversion server
must have an up to date version of virt-v2v.

Normally you must log in to the conversion server as root, but if you
check the following box:

.Vb 3
 │                                                             │
 │                    [ ] Use sudo when running virt-v2v       │
 │                                                             │
.Ve

then you can log in as another user, and virt-p2v will use the
**sudo**\|(8) command to elevate privileges to root.  Note that
sudo must not require a password.

It is also possible to run virt-v2v on the conversion server entirely
as non-root, but output modes may be limited.  Consult the
**virt-v2v**\|(1) manual page for details.

At the bottom of the dialog are these buttons:

.Vb 6
 │                                                             │
 │                     [ Test connection ]                     │
 │                                                             │
 │ [ Configure network ] [ XTerm ] [ About virt-p2v ] [ Next ] │
 │                                                             │
 └─────────────────────────────────────────────────────────────┘
.Ve

You must press the \f(CW`Test connection\*(C' button first to test the \s-1SSH\s0
connection to the conversion server.  If that is successful (ie. you
have supplied the correct server name, user name, password, etc., and
a suitable version of virt-v2v is available remotely) then press the
\f(CW`Next\*(C' button to move to the next dialog.

You can use the \f(CW`Configure network\*(C' button if you need to assign a
static \s-1IP\s0 address to the physical machine, or use Wifi, bonding or
other network features.

The \f(CW`XTerm\*(C' button opens a shell which can be used for diagnostics,
manual network configuration, and so on.

<a name="s-1disk-and-network-configuration-dialogs0"></a>

### \s-1DISK AND NETWORK CONFIGURATION DIALOG\s0

.IX Subsection "DISK AND NETWORK CONFIGURATION DIALOG"
The second configuration dialog lets you configure the details of
conversion, including what to convert and where to send the guest.

In the left hand column, starting at the top, the target properties
let you select the name of the guest (ie. after conversion) and how
many virtual CPUs and how much \s-1RAM\s0 to give it.  The defaults come from
the physical machine, and you can usually leave them unchanged:

.Vb 9
 ┌─────────────────────────────────────── ─ ─ ─ ─
 │ Target properties:
 │
 │        Name: [hostname_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_]
 │
 │     # vCPUs: [4_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_]
 │
 │ Memory (MB): [16384_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_]
 │
.Ve

The second panel on the left controls the virt-v2v output options.  To
understand these options it is a really good idea to read the
**virt-v2v**\|(1) manual page.  You can leave the options at the default
to create a guest as a disk image plus libvirt \s-1XML\s0 file located in
_/var/tmp_ on the conversion host.  This is a good idea if you are a
first-time virt-p2v user.

.Vb 10
 │
 │ Virt-v2v output options:
 │
 │          Output to (-o): [local             ▼]
 │
 │      Output conn. (-oc): [_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_]
 │
 │    Output storage (-os): [/var/tmp_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_]
 │
 │     Output format (-of): [_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_]
 │
 │ Output allocation (-oa): [sparse            ▼]
 │
.Ve

All output options and paths are relative to the conversion server
(_not_ to the physical server).

Finally in the left hand column is an information box giving the
version of virt-p2v (on the physical server) and virt-v2v (on the
conversion server).  You should supply this information when reporting
bugs.

In the right hand column are three panels which control what hard
disks, removable media devices, and network interfaces, will be
created in the output guest.  Normally leaving these at the default
settings is fine.

.Vb 11
 ─ ─ ───────────────────────────────────────┐
     Fixed hard disks                       │
                                            │
     Convert  Device                        │
     [✔]      sda                           │
              1024G HITACHI                 │
              s/n 12345                     │
     [✔]      sdb                           │
              119G HITACHI                  │
              s/n 12346                     │
                                            │
.Ve

Normally you would want to convert all hard disks.  If you want
virt-p2v to completely ignore a local hard disk, uncheck it.  The hard
disk that contains the operating system must be selected.  If a hard
disk is part of a \s-1RAID\s0 array or \s-1LVM\s0 volume group (\s-1VG\s0), then either all
hard disks in that array/VG must be selected, or none of them.

.Vb 6
                                            │
     Removable media                        │
                                            │
     Convert  Device                        │
     [✔]      sr0                           │
                                            │
.Ve

If the physical machine has \s-1CD\s0 or \s-1DVD\s0 drives, then you can use the
Removable media panel to create corresponding drives on the guest
after conversion.  Note that any data CDs/DVDs which are mounted in
the drives are _not_ copied over.

.Vb 7
                                            │
     Network interfaces                     │
                                            │
     Convert  Device Connect to ...         |
     [✔]      em1    [default_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_] │
     [ ]      wlp3s0 [default_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_] │
                                            │
.Ve

In the Network interfaces panel, select the network interfaces that
should be created in the guest after conversion.  You can also connect
these to target hypervisor networks (for further information about
this feature, see Networks and bridges\*(R" in **virt-v2v**\|(1)).

On supported hardware, left-clicking on the device name (eg. \f(CW`em1\*(C')
causes a light to start flashing on the physical interface, allowing
the interface to be identified by the operator.

When you are ready to begin the conversion, press the
\f(CW`Start conversion\*(C' button:

.Vb 4
                                            │
             [ Back ]  [ Start conversion ] │
                                            │
 ─ ─ ───────────────────────────────────────┘
.Ve

<a name="s-1conversion-running-dialogs0"></a>

### \s-1CONVERSION RUNNING DIALOG\s0

.IX Subsection "CONVERSION RUNNING DIALOG"
When conversion is running you will see this dialog:

.Vb 10
 ┌────────────────────────────────────────────────────────┐
 │                      virt-p2v                          │
 │                                                        │
 │  ┌──────────────────────────────────────────────────┐  │
 │  │                                                 ▲│  │
 │  │                                                  │  │
 │  │                                                  │  │
 ∼  ∼                                                  ∼  ∼
 │  │                                                  │  │
 │  │                                                  │  │
 │  │                                                 ▼│  │
 │  └──────────────────────────────────────────────────┘  │
 │                                                        │
 │ Log files ... to /tmp/virt-p2v-xxx                     │
 │                                                        │
 │ Doing conversion ...                                   │
 │                                                        │
 │                                 [ Cancel conversion ]  │
 │                                                        │
 └────────────────────────────────────────────────────────┘
.Ve

In the main scrolling area you will see messages from the virt-v2v
process.

Below the main area, virt-p2v shows you the location of the directory
on the conversion server that contains log files and other debugging
information.  Below that is the current status and a button for
cancelling conversion.

Once conversion has finished, you should shut down the physical
machine.  If conversion is successful, you should never reboot it.

<a name="kernel-command-line-configuration"></a>

# Kernel Command Line Configuration

.IX Header "KERNEL COMMAND LINE CONFIGURATION"
If you don’t want to configure things using the graphical \s-1UI,\s0 an
alternative is to configure through the kernel command line.  This is
especially convenient if you are converting a lot of physical machines
which are booted using \s-1PXE.\s0

Where exactly you set command line arguments depends on your \s-1PXE\s0
implementation, but for pxelinux you put them in the \f(CW`APPEND\*(C' field
in the _pxelinux.cfg_ file.  For example:

.Vb 6
 DEFAULT p2v
 TIMEOUT 20
 PROMPT 0
 LABEL p2v
   KERNEL vmlinuz0
   APPEND initrd=initrd0.img [....] p2v.server=conv.example.com p2v.password=secret p2v.o=libvirt
.Ve

You have to set some or all of the following command line arguments:

* **p2v.remote.server=SERVER**  
  .IX Item "p2v.remote.server=SERVER"
* **p2v.server=SERVER**  
  .IX Item "p2v.server=SERVER"
  The name or \s-1IP\s0 address of the conversion server.
  .Sp
  This is always required if you are using the kernel configuration
  method.  If virt-p2v does not find this on the kernel command line
  then it switches to the \s-1GUI\s0 (interactive) configuration method.
* **p2v.remote.port=PORT**  
  .IX Item "p2v.remote.port=PORT"
* **p2v.port=PORT**  
  .IX Item "p2v.port=PORT"
  The \s-1SSH\s0 port number on the conversion server (default: \f(CW22).
* **p2v.auth.username=USERNAME**  
  .IX Item "p2v.auth.username=USERNAME"
* **p2v.username=USERNAME**  
  .IX Item "p2v.username=USERNAME"
  The \s-1SSH\s0 username that we log in as on the conversion server
  (default: \f(CW`root\*(C').
* **p2v.auth.password=PASSWORD**  
  .IX Item "p2v.auth.password=PASSWORD"
* **p2v.password=PASSWORD**  
  .IX Item "p2v.password=PASSWORD"
  The \s-1SSH\s0 password that we use to log in to the conversion server.
  .Sp
  The default is to try with no password.  If this fails then virt-p2v
  will ask the user to type the password (probably several times during
  conversion).
  .Sp
  This setting is ignored if \f(CW`p2v.auth.identity.url\*(C' is present.
* **p2v.auth.identity.url=URL**  
  .IX Item "p2v.auth.identity.url=URL"
* **p2v.identity=URL**  
  .IX Item "p2v.identity=URL"
  Provide a \s-1URL\s0 pointing to an \s-1SSH\s0 identity (private key) file.  The \s-1URL\s0
  is interpreted by **curl**\|(1) so any \s-1URL\s0 that curl supports can be used
  here, including \f(CW`https://\*(C' and \f(CW\*(C\`file://\*(C'.  For more information on
  using \s-1SSH\s0 identities, see \s-1SSH IDENTITIES\*(R"\s0 below.
  .Sp
  If \f(CW`p2v.auth.identity.url\*(C' is present, it overrides \f(CW\*(C\`p2v.auth.password\*(C'.
  There is no fallback.
* **p2v.auth.sudo**  
  .IX Item "p2v.auth.sudo"
* **p2v.sudo**  
  .IX Item "p2v.sudo"
  Use \f(CW`p2v.sudo\*(C' to tell virt-p2v to use **sudo**\|(8) to gain root
  privileges on the conversion server after logging in as a non-root
  user (default: do not use sudo).
* **p2v.guestname=GUESTNAME**  
  .IX Item "p2v.guestname=GUESTNAME"
* **p2v.name=GUESTNAME**  
  .IX Item "p2v.name=GUESTNAME"
  The name of the guest that is created.  The default is to try to
  derive a name from the physical machine’s hostname (if possible) else
  use a randomly generated name.
* **p2v.vcpus=N**  
  .IX Item "p2v.vcpus=N"
  The number of virtual CPUs to give to the guest.  The default is to
  use the same as the number of physical CPUs.
* **p2v.memory=n(M|G)**  
  .IX Item "p2v.memory=n(M|G)"
  The size of the guest memory.  You must specify the unit such as
  megabytes or gigabytes by using for example \f(CW`p2v.memory=1024M\*(C' or
  \f(CW`p2v.memory=1G\*(C'.
  .Sp
  The default is to use the same amount of \s-1RAM\s0 as on the physical
  machine.
* **p2v.cpu.vendor=VENDOR**  
  .IX Item "p2v.cpu.vendor=VENDOR"
  The vCPU vendor, eg. Intel\*(R" or \*(L"\s-1AMD\*(R".\s0  The default is to use
  the same \s-1CPU\s0 vendor as the physical machine.
* **p2v.cpu.model=MODEL**  
  .IX Item "p2v.cpu.model=MODEL"
  The vCPU model, eg. IvyBridge\*(R".  The default is to use the same
  \s-1CPU\s0 model as the physical machine.
* **p2v.cpu.sockets=N**  
  .IX Item "p2v.cpu.sockets=N"
  Number of vCPU sockets to use.  The default is to use the same as the
  physical machine.
* **p2v.cpu.cores=N**  
  .IX Item "p2v.cpu.cores=N"
  Number of vCPU cores to use.  The default is to use the same as the
  physical machine.
* **p2v.cpu.threads=N**  
  .IX Item "p2v.cpu.threads=N"
  Number of vCPU hyperthreads to use.  The default is to use the same
  as the physical machine.
* **p2v.cpu.acpi**  
  .IX Item "p2v.cpu.acpi"
  Whether to enable \s-1ACPI\s0 in the remote virtual machine.  The default is
  to use the same as the physical machine.
* **p2v.cpu.apic**  
  .IX Item "p2v.cpu.apic"
  Whether to enable \s-1APIC\s0 in the remote virtual machine.  The default is
  to use the same as the physical machine.
* **p2v.cpu.pae**  
  .IX Item "p2v.cpu.pae"
  Whether to enable \s-1PAE\s0 in the remote virtual machine.  The default is
  to use the same as the physical machine.
* **p2v.rtc.basis=(unknown|utc|localtime)**  
  .IX Item "p2v.rtc.basis=(unknown|utc|localtime)"
  Set the basis of the Real Time Clock in the virtual machine.  The
  default is to try to detect this setting from the physical machine.
* **p2v.rtc.offset=[+|-]HOURS**  
  .IX Item "p2v.rtc.offset=[+|-]HOURS"
  The offset of the Real Time Clock from \s-1UTC.\s0  The default is to try
  to detect this setting from the physical machine.
* **p2v.disks=sda,sdb,...**  
  .IX Item "p2v.disks=sda,sdb,..."
  A list of physical hard disks to convert, for example:
  .Sp
  .Vb 1
   p2v.disks=sda,sdc
  .Ve
  .Sp
  The default is to convert all local hard disks that are found.
* **p2v.removable=sra,srb,...**  
  .IX Item "p2v.removable=sra,srb,..."
  A list of removable media to convert.  The default is to create
  virtual removable devices for every physical removable device found.
  Note that the content of removable media is never copied over.
* **p2v.interfaces=em1,...**  
  .IX Item "p2v.interfaces=em1,..."
  A list of network interfaces to convert.  The default is to create
  virtual network interfaces for every physical network interface found.
* **p2v.network\_map=interface:target,...**  
  .IX Item "p2v.network_map=interface:target,..."
* **p2v.network=interface:target,...**  
  .IX Item "p2v.network=interface:target,..."
  Controls how network interfaces are connected to virtual networks on
  the target hypervisor.  The default is to connect all network
  interfaces to the target \f(CW`default\*(C' network.
  .Sp
  You give a comma-separated list of \f(CW`interface:target\*(C' pairs, plus
  optionally a default target.  For example:
  .Sp
  .Vb 1
   p2v.network=em1:ovirtmgmt
  .Ve
  .Sp
  maps interface \f(CW`em1\*(C' to target network \f(CW\*(C\`ovirtmgmt\*(C'.
  .Sp
  .Vb 1
   p2v.network=em1:ovirtmgmt,em2:management,other
  .Ve
  .Sp
  maps interface \f(CW`em1\*(C' to \f(CW\*(C\`ovirtmgmt\*(C', and \f(CW\*(C\`em2\*(C' to \f(CW\*(C\`management\*(C',
  and any other interface that is found to \f(CW`other\*(C'.
* **p2v.output.type=(libvirt|local|...)**  
  .IX Item "p2v.output.type=(libvirt|local|...)"
* **p2v.o=(libvirt|local|...)**  
  .IX Item "p2v.o=(libvirt|local|...)"
  Set the output mode.  This is the same as the virt-v2v _-o_ option.
  See \s-1OPTIONS\*(R"\s0 in **virt-v2v**\|(1).
  .Sp
  If not specified, the default is \f(CW`local\*(C', and the converted guest is
  written to _/var/tmp_.
* **p2v.output.allocation=(none|sparse|preallocated)**  
  .IX Item "p2v.output.allocation=(none|sparse|preallocated)"
* **p2v.oa=(none|sparse|preallocated)**  
  .IX Item "p2v.oa=(none|sparse|preallocated)"
  Set the output allocation mode.  This is the same as the virt-v2v
  _-oa_ option.  See \s-1OPTIONS\*(R"\s0 in **virt-v2v**\|(1).
* **p2v.output.connection=URI**  
  .IX Item "p2v.output.connection=URI"
* **p2v.oc=URI**  
  .IX Item "p2v.oc=URI"
  Set the output connection libvirt \s-1URI.\s0  This is the same as the
  virt-v2v _-oc_ option.  See \s-1OPTIONS\*(R"\s0 in **virt-v2v**\|(1) and
  http://libvirt.org/uri.html
* **p2v.output.format=(raw|qcow2|...)**  
  .IX Item "p2v.output.format=(raw|qcow2|...)"
* **p2v.of=(raw|qcow2|...)**  
  .IX Item "p2v.of=(raw|qcow2|...)"
  Set the output format.  This is the same as the virt-v2v _-of_
  option.  See \s-1OPTIONS\*(R"\s0 in **virt-v2v**\|(1).
* **p2v.output.storage=STORAGE**  
  .IX Item "p2v.output.storage=STORAGE"
* **p2v.os=STORAGE**  
  .IX Item "p2v.os=STORAGE"
  Set the output storage.  This is the same as the virt-v2v _-os_
  option.  See \s-1OPTIONS\*(R"\s0 in **virt-v2v**\|(1).
  .Sp
  If not specified, the default is _/var/tmp_ (on the conversion server).
* **p2v.pre=COMMAND**  
  .IX Item "p2v.pre=COMMAND"
  .ie n .IP "**p2v.pre=""\s-1COMMAND ARG ...""\s0**" 4
  .el .IP "**p2v.pre=\`\`\s-1COMMAND ARG ...''\s0**" 4
  .IX Item "p2v.pre=COMMAND ARG ..."
  Select a pre-conversion command to run.  Any command or script can be
  specified here.  If the command contains spaces, you must quote the
  whole command with double quotes.  The default is not to run any
  command.
* **p2v.post=poweroff**  
  .IX Item "p2v.post=poweroff"
* **p2v.post=reboot**  
  .IX Item "p2v.post=reboot"
* **p2v.post=COMMAND**  
  .IX Item "p2v.post=COMMAND"
  .ie n .IP "**p2v.post=""\s-1COMMAND ARG ...""\s0**" 4
  .el .IP "**p2v.post=\`\`\s-1COMMAND ARG ...''\s0**" 4
  .IX Item "p2v.post=COMMAND ARG ..."
  Select a post-conversion command to run if conversion is successful.
  This can be any command or script.  If the command contains spaces,
  you must quote the whole command with double quotes.
  .Sp
  _If_ virt-p2v is running as root, _and_ the command line was set
  from _/proc/cmdline_ (not _--cmdline_), then the default is to run
  the **poweroff**\|(8) command.  Otherwise the default is not to run any
  command.
* **p2v.fail=COMMAND**  
  .IX Item "p2v.fail=COMMAND"
  .ie n .IP "**p2v.fail=""\s-1COMMAND ARG ...""\s0**" 4
  .el .IP "**p2v.fail=\`\`\s-1COMMAND ARG ...''\s0**" 4
  .IX Item "p2v.fail=COMMAND ARG ..."
  Select a post-conversion command to run if conversion fails.  Any
  command or script can be specified here.  If the command contains
  spaces, you must quote the whole command with double quotes.  The
  default is not to run any command.
* **ip=dhcp**  
  .IX Item "ip=dhcp"
  Use \s-1DHCP\s0 for configuring the network interface (this is the default).

<a name="ssh-identities"></a>

# Ssh Identities

.IX Header "SSH IDENTITIES"
As a somewhat more secure alternative to password authentication, you
can use an \s-1SSH\s0 identity (private key) for authentication.

First create a key pair.  It must have an empty passphrase:

.Vb 1
 ssh-keygen -t rsa -N \*(Aq -f id_rsa
.Ve

This creates a private key (\f(CW`id\_rsa\*(C') and a public key
(\f(CW`id\_rsa.pub\*(C') pair.

The public key should be appended to the \f(CW`authorized\_keys\*(C' file on
the virt-v2v conversion server (usually to
\f(CW`/root/.ssh/authorized\_keys\*(C').

For distributing the private key, there are four scenarios from least
secure to most secure:

* 1.  
  Not using \s-1SSH\s0 identities at all, ie. password authentication.
  .Sp
  Anyone who can sniff the \s-1PXE\s0 boot parameters from the network or
  observe the password some other way can log in to the virt-v2v
  conversion server.
* 2.  
  \s-1SSH\s0 identity embedded in the virt-p2v \s-1ISO\s0 or disk image.  In the \s-1GUI,\s0 use:
  .Sp
  .Vb 3
   │          Password: [    &lt;leave this field blank&gt;       ] │
   │                                                          │
   │  SSH Identity URL: [file:///var/tmp/id_rsa_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_] │
  .Ve
  .Sp
  or on the kernel command line:
  .Sp
  .Vb 1
   p2v.identity=file:///var/tmp/id_rsa
  .Ve
  .Sp
  The \s-1SSH\s0 private key can still be sniffed from the network if using
  standard \s-1PXE.\s0
* 3.  
  \s-1SSH\s0 identity downloaded from a website.  In the \s-1GUI,\s0 use:
  .Sp
  .Vb 3
   │          Password: [    &lt;leave this field blank&gt;       ] │
   │                                                          │
   │  SSH Identity URL: [https://internal.example.com/id_rsa] │
  .Ve
  .Sp
  or on the kernel command line:
  .Sp
  .Vb 1
   p2v.identity=https://internal.example.com/id_rsa
  .Ve
  .Sp
  Anyone could still download the private key and use it to log in to
  the virt-v2v conversion server, but you could provide some extra
  security by configuring the web server to only allow connections from
  P2V machines.
  .Sp
  Note that **ssh-keygen**\|(1) creates the \f(CW`id\_rsa\*(C' (private key) file
  with mode 0600.  If you simply copy the file to a webserver, the
  webserver will not serve it.  It will reply with 403 Forbidden\*(R"
  errors.  You will need to change the mode of the file to make it
  publicly readable, for example by using:
  .Sp
  .Vb 1
   chmod 0644 id_rsa
  .Ve
* 4.  
  \s-1SSH\s0 identity embedded in the virt-p2v \s-1ISO\s0 or disk image (like 2.),
  _and_ use of secure \s-1PXE, PXE\s0 over separate physical network, or
  sneakernet to distribute virt-p2v to the physical machine.

Both **virt-p2v-make-disk**\|(1) and **virt-p2v-make-kickstart**\|(1) have
the same option _--inject-ssh-identity_ for injecting the private key
into the virt-p2v disk image / \s-1ISO.\s0  See also the following manual
sections:

\s-1ADDING AN SSH IDENTITY\*(R"\s0 in **virt-p2v-make-disk**\|(1)

\s-1ADDING AN SSH IDENTITY\*(R"\s0 in **virt-p2v-make-kickstart**\|(1)

<a name="common-problems"></a>

# Common Problems

.IX Header "COMMON PROBLEMS"

<a name="timeouts"></a>

### Timeouts

.IX Subsection "Timeouts"
As described below (see \s-1HOW VIRT-P2V WORKS\*(R"\s0) virt-p2v makes several
long-lived ssh connections to the conversion server.  If these
connections time out then virt-p2v will fail.

To test if a timeout might be causing problems, open an XTerm on the
virt-p2v machine, \f(CW`ssh root@\f(CIconversion-server\f(CW\*(C', and leave it for
at least an hour.  If the session disconnects without you doing
anything, then there is a timeout which you should turn off.

Timeouts happen because:
.ie n .IP """TIMEOUT"" or ""TMOUT"" environment variable" 4
.el .IP "\f(CWTIMEOUT or \f(CWTMOUT environment variable" 4
.IX Item "TIMEOUT or TMOUT environment variable"
Check if one of these environment variables is set in the root shell
on the conversion server.
.ie n .IP "sshd ""ClientAlive*"" setting" 4
.el .IP "sshd \f(CWClientAlive* setting" 4
.IX Item "sshd ClientAlive* setting"
Check for \f(CW`ClientAlive*\*(C' settings in \f(CW\*(C\`/etc/ssh/sshd\_config\*(C' on the
conversion server.

* Firewall or \s-1NAT\s0 settings  
  .IX Item "Firewall or NAT settings"
  Check if there is a firewall or \s-1NAT\s0 box between virt-p2v and the
  conversion server, and if this firewall drops idle connections after a
  too-short time.
  .Sp
  virt-p2v ≥ 1.36 attempts to work around firewall timeouts by
  sending ssh keepalive messages every 5 minutes.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **--help**  
  .IX Item "--help"
  Display help.
* **--cmdline=CMDLINE**  
  .IX Item "--cmdline=CMDLINE"
  This is used for debugging. Instead of parsing the kernel command line
  from _/proc/cmdline_, parse the string parameter \f(CW`CMDLINE\*(C'.
* **--colors**  
  .IX Item "--colors"
* **--colours**  
  .IX Item "--colours"
  Use \s-1ANSI\s0 colour sequences to colourize messages.  This is the default
  when the output is a tty.  If the output of the program is redirected
  to a file, \s-1ANSI\s0 colour sequences are disabled unless you use this
  option.
* **--iso**  
  .IX Item "--iso"
  This flag is passed to virt-p2v when it is launched inside the
  virt-p2v \s-1ISO\s0 environment, ie. when it is running on a real physical
  machine (and thus not when testing).  It enables various dangerous
  features such as the Shutdown popup button.
* **--nbd=server[,server...]**  
  .IX Item "--nbd=server[,server...]"
  Select which \s-1NBD\s0 server is used.  By default the following servers are
  checked and the first one found is used:
  _--nbd=qemu-nbd,qemu-nbd-no-sa,nbdkit,nbdkit-no-sa_
    * **qemu-nbd**  
      .IX Item "qemu-nbd"
      Use qemu-nbd.
    * **qemu-nbd-no-sa**  
      .IX Item "qemu-nbd-no-sa"
      Use qemu-nbd, but disable socket activation.
    * **nbdkit**  
      .IX Item "nbdkit"
      Use nbdkit with the file plugin (see: **nbdkit-file-plugin**\|(1)).
    * **nbdkit-no-sa**  
      .IX Item "nbdkit-no-sa"
      Use nbdkit, but disable socket activation
      .Sp
      The \f(CW`*-no-sa\*(C' variants allow virt-p2v to fall back to older versions
      of qemu-nbd and nbdkit which did not support
      socket activation.
* **--test-disk=/PATH/TO/DISK.IMG**  
  .IX Item "--test-disk=/PATH/TO/DISK.IMG"
  For testing or debugging purposes, replace _/dev/sda_ with a local
  file.  You must use an absolute path.
* **-v**  
  .IX Item "-v"
* **--verbose**  
  .IX Item "--verbose"
  In libguestfs ≥ 1.33.41, debugging is always enabled on the
  conversion server, and this option does nothing.
* **-V**  
  .IX Item "-V"
* **--version**  
  .IX Item "--version"
  Display version number and exit.

<a name="how-virt-p2v-works"></a>

# How Virt\-P2v Works

.IX Header "HOW VIRT-P2V WORKS"
**Note this section is not normative.**  We may change how virt-p2v
works at any time in the future.

As described above, virt-p2v runs on a physical machine, interrogates
the user or the kernel command line for configuration, and then
establishes one or more ssh connections to the virt-v2v conversion
server.  The ssh connections are interactive shell sessions to the
remote host, but the commands sent are generated entirely by virt-p2v
itself, not by the user.  For data transfer, virt-p2v will use the
reverse port forward feature of ssh (ie. \f(CW`ssh -R\*(C').

It will first make one or more test connections, which are used to
query the remote version of virt-v2v and its features.  The test
connections are closed before conversion begins.

.Vb 5
 ┌──────────────┐                      ┌─────────────────┐
 │ virt-p2v     │                      │ virt-v2v        │
 │ (physical    │  control connection  │ (conversion     │
 │  server)   ╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍▶ server)       │
 └──────────────┘                      └─────────────────┘
.Ve

Once virt-p2v is ready to start conversion, it will open a single ssh
control connection.  It first sends a mkdir command to create a
temporary directory on the conversion server.  The directory name is
randomly chosen and is displayed in the \s-1GUI.\s0  It has the form:

.Vb 1
 /tmp/virt-p2v-YYYYMMDD-XXXXXXXX
.Ve

where \f(CW`YYYYMMDD\*(C' is the current date, and the ‘X’s are random
characters.

Into this directory are written various files which include:

* _dmesg_  
  .IX Item "dmesg"
* _lscpu_  
  .IX Item "lscpu"
* _lspci_  
  .IX Item "lspci"
* _lsscsi_  
  .IX Item "lsscsi"
* _lsusb_  
  .IX Item "lsusb"
  _(before conversion)_
  .Sp
  The output of the corresponding commands (ie **dmesg**\|(1), **lscpu**\|(1)
  etc) on the physical machine.
  .Sp
  The dmesg output is useful for detecting problems such as missing
  device drivers or firmware on the virt-p2v \s-1ISO.\s0  The others are useful
  for debugging novel hardware configurations.
* _environment_  
  .IX Item "environment"
  _(before conversion)_
  .Sp
  The content of the environment where **virt-v2v**\|(1) will run.
* _name_  
  .IX Item "name"
  _(before conversion)_
  .Sp
  The name (usually the hostname) of the physical machine.
* _physical.xml_  
  .IX Item "physical.xml"
  _(before conversion)_
  .Sp
  Libvirt \s-1XML\s0 describing the physical machine.  It is used to pass data
  about the physical source host to **virt-v2v**\|(1) via the _-i libvirtxml_
  option.
  .Sp
  Note this is not real\*(R" libvirt \s-1XML\s0 (and must **never** be loaded into
  libvirt, which would reject it anyhow).  Also it is not the same as
  the libvirt \s-1XML\s0 which virt-v2v generates in certain output modes.
* _p2v-version_  
  .IX Item "p2v-version"
* _v2v-version_  
  .IX Item "v2v-version"
  _(before conversion)_
  .Sp
  The versions of virt-p2v and virt-v2v respectively.
* _status_  
  .IX Item "status"
  _(after conversion)_
  .Sp
  The final status of the conversion.  \f(CW0 if the conversion was
  successful.  Non-zero if the conversion failed.
* _time_  
  .IX Item "time"
  _(before conversion)_
  .Sp
  The start date/time of conversion.
* _virt-v2v-conversion-log.txt_  
  .IX Item "virt-v2v-conversion-log.txt"
  _(during/after conversion)_
  .Sp
  The conversion log.  This is just the output of the virt-v2v command
  on the conversion server.  If conversion fails, you should examine
  this log file, and you may be asked to supply the **complete**,
  **unedited** log file in any bug reports or support tickets.
* _virt-v2v-wrapper.sh_  
  .IX Item "virt-v2v-wrapper.sh"
  _(before conversion)_
  .Sp
  This is the wrapper script which is used when running virt-v2v.  For
  interest only, do not attempt to run this script yourself.

Before conversion actually begins, virt-p2v then makes one or more
further ssh connections to the server for data transfer.

The transfer protocol used currently is \s-1NBD\s0 (Network Block Device),
which is proxied over ssh.  The \s-1NBD\s0 server is **qemu-nbd**\|(1) by
default but others can be selected using the _--nbd_ command line
option.

There is one ssh connection per physical hard disk on the source
machine (the common case — a single hard disk — is shown below):

.Vb 11
 ┌──────────────┐                      ┌─────────────────┐
 │ virt-p2v     │                      │ virt-v2v        │
 │ (physical    │  control connection  │ (conversion     │
 │  server)   ╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍▶ server)       │
 │              │                      │                 │
 │              │  data connection     │                 │
 │            ╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍▶               │
 │qemu-nbd ← ─┘ │                      │└─ ← NBD         │
 │/dev/sda      │                      │     requests    │
 ∼              ∼                      ∼                 ∼
 └──────────────┘                      └─────────────────┘
.Ve

Although the ssh data connection is originated from the physical
server and terminates on the conversion server, in fact \s-1NBD\s0 requests
flow in the opposite direction.  This is because the reverse port
forward feature of ssh (\f(CW`ssh -R\*(C') is used to open a port on the
loopback interface of the conversion server which is proxied back by
ssh to the \s-1NBD\s0 server running on the physical machine.  The effect is
that virt-v2v via libguestfs can open nbd connections which directly
read the hard disk(s) of the physical server.

Two layers of protection are used to ensure that there are no writes
to the hard disks: Firstly, the qemu-nbd _-r_ (readonly) option is
used.  Secondly libguestfs creates an overlay on top of the \s-1NBD\s0
connection which stores writes in a temporary file on the conversion
file.

The long \f(CW`virt-v2v -i libvirtxml physical.xml ...\*(C' command is
wrapped inside a wrapper script and uploaded to the conversion server.
The final step is to run this wrapper script, in turn running the
virt-v2v command.  The virt-v2v command references the _physical.xml_
file (see above), which in turn references the \s-1NBD\s0 listening port(s)
of the data connection(s).

Output from the virt-v2v command (messages, debugging etc) is saved
both in the log file on the conversion server.  Only informational
messages are sent back over the control connection to be displayed in
the graphical \s-1UI.\s0

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**virt-p2v-make-disk**\|(1),
**virt-p2v-make-kickstart**\|(1),
**virt-p2v-make-kiwi**\|(1),
**virt-v2v**\|(1),
**qemu-nbd**\|(1),
**nbdkit**\|(1), **nbdkit-file-plugin**\|(1),
**ssh**\|(1),
**sshd**\|(8),
**sshd\_config**\|(5),
http://libguestfs.org/.

<a name="authors"></a>

# Authors

.IX Header "AUTHORS"
Matthew Booth

John Eckersberg

Richard W.M. Jones http://people.redhat.com/~rjones/

Mike Latimer

Pino Toscano

Tingting Zheng

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
