# virt-v2v(1)

virt-v2v-1.44.0, 2021-04-30

.if n .ad l
.nh

<a name="name"></a>

# Name

virt-v2v - Convert a guest to use KVM

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" .Vb 3  virt-v2v [-i mode] [other -i* options]           [-o mode] [other -o* options]           [guest|filename]   virt-v2v --in-place           [-i mode] [other -i* options]           [guest|filename] .Ve
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
Virt-v2v converts a single guest from a foreign hypervisor to run on
\s-1KVM.\s0  It can read Linux and Windows guests running on VMware, Xen,
Hyper-V and some other hypervisors, and convert them to \s-1KVM\s0 managed by
libvirt, OpenStack, oVirt, Red Hat Virtualisation (\s-1RHV\s0) or several
other targets.  It can modify the guest to make it bootable on \s-1KVM\s0 and
install virtio drivers so it will run quickly.

There is also a companion front-end called **virt-p2v**\|(1) which comes
as an \s-1ISO, CD\s0 or \s-1PXE\s0 image that can be booted on physical machines to
virtualize those machines (physical to virtual, or p2v).

<a name="input-and-output"></a>

### Input and Output

.IX Subsection "Input and Output"
You normally run virt-v2v with several _-i*_ options controlling the
input mode and also several _-o*_ options controlling the output
mode.  In this sense, input\*(R" refers to the source foreign hypervisor
such as VMware, and output\*(R" refers to the target KVM-based management
system such as oVirt or OpenStack.

The input and output sides of virt-v2v are separate and unrelated.
Virt-v2v can read from any input and write to any output.  Therefore
these sides of virt-v2v are documented separately in this manual.

Virt-v2v normally copies from the input to the output, called copying
mode.  In this case the source guest is always left unchanged.
In-place conversion (_--in-place_) only uses the _-i*_ options and
modifies the source guest in-place.  (See In-place conversion\*(R"
below.)

<a name="other-virt-v2v-topics"></a>

### Other virt\-v2v topics

.IX Subsection "Other virt-v2v topics"
**virt-v2v-support**\|(1) — Supported hypervisors, virtualization
management systems, guests.

**virt-v2v-input-vmware**\|(1) — Input from VMware.

**virt-v2v-input-xen**\|(1) — Input from Xen.

**virt-v2v-output-local**\|(1) — Output to local files or local libvirt.

**virt-v2v-output-rhv**\|(1) — Output to oVirt or \s-1RHV.\s0

**virt-v2v-output-openstack**\|(1) — Output to OpenStack.

**virt-v2v-release-notes-1.42**\|(1) — Release notes for this release.

**virt-v2v-copy-to-local**\|(1) — Deprecated tool to handle Xen guests
using host block device storage.

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"

<a name="convert-from-vmware-vcenter-server-to-local-libvirt"></a>

### Convert from VMware vCenter server to local libvirt

.IX Subsection "Convert from VMware vCenter server to local libvirt"
You have a VMware vCenter server called \f(CW`vcenter.example.com\*(C', a
datacenter called \f(CW`Datacenter\*(C', and an ESXi hypervisor called
\f(CW`esxi\*(C'.  You want to convert a guest called \f(CW\*(C\`vmware\_guest\*(C' to run
locally under libvirt.

.Vb 1
 virt-v2v -ic vpx://vcenter.example.com/Datacenter/esxi vmware_guest
.Ve

In this case you will most likely have to run virt-v2v as \f(CW`root\*(C',
since it needs to talk to the system libvirt daemon and copy the guest
disks to _/var/lib/libvirt/images_.

For more information see **virt-v2v-input-vmware**\|(1).

<a name="convert-from-vmware-to-rhvovirt"></a>

### Convert from VMware to RHV/oVirt

.IX Subsection "Convert from VMware to RHV/oVirt"
This is the same as the previous example, except you want to send the
guest to a \s-1RHV\s0 Data Domain using the \s-1RHV REST API.\s0  Guest network
interface(s) are connected to the target network called \f(CW`ovirtmgmt\*(C'.

.Vb 5
 virt-v2v -ic vpx://vcenter.example.com/Datacenter/esxi vmware_guest \e
   -o rhv-upload -oc https://ovirt-engine.example.com/ovirt-engine/api \e
   -os ovirt-data -op /tmp/ovirt-admin-password -of raw \e
   -oo rhv-cafile=/tmp/ca.pem -oo rhv-direct \e
   --bridge ovirtmgmt
.Ve

In this case the host running virt-v2v acts as a **conversion server**.

For more information see **virt-v2v-output-rhv**\|(1).

<a name="convert-from-esxi-hypervisor-over-s-1sshs0-to-local-libvirt"></a>

### Convert from ESXi hypervisor over \s-1SSH\s0 to local libvirt

.IX Subsection "Convert from ESXi hypervisor over SSH to local libvirt"
You have an ESXi hypervisor called \f(CW`esxi.example.com\*(C' with \s-1SSH\s0 access
enabled.  You want to convert from \s-1VMFS\s0 storage on that server to
a local file.

.Vb 4
 virt-v2v \e
   -i vmx -it ssh \e
   "ssh://root@esxi.example.com/vmfs/volumes/datastore1/guest/guest.vmx" \e
   -o local -os /var/tmp
.Ve

The guest must not be running.  Virt-v2v would _not_ need to be run
as root in this case.

For more information about converting from \s-1VMX\s0 files see
**virt-v2v-input-vmware**\|(1).

<a name="convert-disk-image-to-openstack"></a>

### Convert disk image to OpenStack

.IX Subsection "Convert disk image to OpenStack"
Given a disk image from another hypervisor that you want to convert to
run on OpenStack (only KVM-based OpenStack is supported), you can run
virt-v2v inside an OpenStack \s-1VM\s0 (called \f(CW`v2v-vm\*(C' below), and do:

.Vb 1
 virt-v2v -i disk disk.img -o openstack -oo server-id=v2v-vm
.Ve

See **virt-v2v-output-openstack**\|(1).

<a name="convert-disk-image-to-disk-image"></a>

### Convert disk image to disk image

.IX Subsection "Convert disk image to disk image"
Given a disk image from another hypervisor that you want to convert to
run on \s-1KVM,\s0 you have two options.  The simplest way is to try:

.Vb 1
 virt-v2v -i disk disk.img -o local -os /var/tmp
.Ve

where virt-v2v guesses everything about the input _disk.img_ and (in
this case) writes the converted result to _/var/tmp_.

A more complex method is to write some
libvirt \s-1XML\s0 describing the
input guest (if you can get the source hypervisor to provide you with
libvirt \s-1XML,\s0 then so much the better).  You can then do:

.Vb 1
 virt-v2v -i libvirtxml guest-domain.xml -o local -os /var/tmp
.Ve

Since _guest-domain.xml_ contains the path(s) to the guest disk
image(s) you do not need to specify the name of the disk image on the
command line.

To convert a local disk image and immediately boot it in local
qemu, do:

.Vb 1
 virt-v2v -i disk disk.img -o qemu -os /var/tmp --qemu-boot
.Ve

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **--help**  
  .IX Item "--help"
  Display help.
* **--bandwidth** bps  
  .IX Item "--bandwidth bps"
* **--bandwidth-file** filename  
  .IX Item "--bandwidth-file filename"
  Some input methods are able to limit the network bandwidth they will
  use statically or dynamically.  In the first variant this sets the
  bandwidth limit statically in bits per second.  Formats like \f(CW`10M\*(C'
  may be used (meaning 10 megabits per second).
  .Sp
  In the second variant the bandwidth is limited dynamically from the
  content of the file (also in bits per second, in the same formats
  supported by the first variant).  You may use both parameters
  together, meaning: first limit to a static rate, then you can create
  the file while virt-v2v is running to adjust the rate dynamically.
  .Sp
  This is only supported for:
    * ·  
      input from Xen
    * ·  
      input from VMware \s-1VMX\s0
      when using the \s-1SSH\s0 transport method
    * ·  
      input from \s-1VDDK\s0
    * ·  
      _-i libvirtxml_ when using \s-1HTTP\s0 or \s-1HTTPS\s0 disks
    * ·  
      input from VMware vCenter server
      .Sp
      The options are silently ignored for other input methods.
* **-b** ...  
  .IX Item "-b ..."
* **--bridge** ...  
  .IX Item "--bridge ..."
  See _--network_ below.
* **--colors**  
  .IX Item "--colors"
* **--colours**  
  .IX Item "--colours"
  Use \s-1ANSI\s0 colour sequences to colourize messages.  This is the default
  when the output is a tty.  If the output of the program is redirected
  to a file, \s-1ANSI\s0 colour sequences are disabled unless you use this
  option.
* **--compressed**  
  .IX Item "--compressed"
  Write a compressed output file.  This is only allowed if the output
  format is qcow2 (see _-of_ below), and is equivalent to the _-c_
  option of **qemu-img**\|(1).
* **--debug-overlays**  
  .IX Item "--debug-overlays"
  Save the overlay file(s) created during conversion.  This option is
  only used for debugging virt-v2v and may be removed in a future
  version.
* **--echo-keys**  
  .IX Item "--echo-keys"
  When prompting for keys and passphrases, virt-v2v normally turns
  echoing off so you cannot see what you are typing.  If you are not
  worried about Tempest attacks and there is no one else in the room you
  can specify this flag to see what you are typing.
  .Sp
  Note this options only applies to keys and passphrases for encrypted
  devices and partitions, not for passwords used to connect to remote
  servers.
* **-i** **disk**  
  .IX Item "-i disk"
  Set the input method to _disk_.
  .Sp
  In this mode you can read a virtual machine disk image with no
  metadata.  virt-v2v tries to guess the best default metadata.  This is
  usually adequate but you can get finer control (eg. of memory and
  vCPUs) by using _-i libvirtxml_ instead.  Only guests that use a single
  disk can be imported this way.
* **-i** **libvirt**  
  .IX Item "-i libvirt"
  Set the input method to _libvirt_.  This is the default.
  .Sp
  In this mode you have to specify a libvirt guest name or \s-1UUID\s0 on the
  command line.  You may also specify a libvirt connection \s-1URI\s0 (see
  _-ic_).
* **-i** **libvirtxml**  
  .IX Item "-i libvirtxml"
  Set the input method to _libvirtxml_.
  .Sp
  In this mode you have to pass a libvirt \s-1XML\s0 file on the command line.
  This file is read in order to get metadata about the source guest
  (such as its name, amount of memory), and also to locate the input
  disks.  See Minimal \s-1XML\s0 for -i libvirtxml option\*(R" below.
* **-i** **local**  
  .IX Item "-i local"
  This is the same as _-i disk_.
* **-i** **ova**  
  .IX Item "-i ova"
  Set the input method to _ova_.
  .Sp
  In this mode you can read a VMware ova file.  Virt-v2v will read the
  ova manifest file and check the vmdk volumes for validity (checksums)
  as well as analyzing the ovf file, and then convert the guest.  See
  **virt-v2v-input-vmware**\|(1).
* **-i** **vmx**  
  .IX Item "-i vmx"
  Set the input method to _vmx_.
  .Sp
  In this mode you can read a VMware vmx file directly or over \s-1SSH.\s0
  This is useful when VMware VMs are stored on an \s-1NFS\s0 server which you
  can mount directly, or where you have access by \s-1SSH\s0 to an ESXi
  hypervisor.  See **virt-v2v-input-vmware**\|(1).
* **-ic** libvirtURI  
  .IX Item "-ic libvirtURI"
  Specify a libvirt connection \s-1URI\s0 to use when reading the guest.  This
  is only used when _-i libvirt_.
  .Sp
  Only local libvirt connections, VMware vCenter connections, or \s-1RHEL 5\s0
  Xen remote connections can be used.  Other remote libvirt connections
  will not work in general.
  .Sp
  See also **virt-v2v-input-vmware**\|(1),
  **virt-v2v-input-xen**\|(1).
* **-if** format  
  .IX Item "-if format"
  For _-i disk_ only, this specifies the format of the input disk
  image.  For other input methods you should specify the input
  format in the metadata.
* **--in-place**  
  .IX Item "--in-place"
  Do not create an output virtual machine in the target hypervisor.
  Instead, adjust the guest \s-1OS\s0 in the source \s-1VM\s0 to run in the input
  hypervisor.
  .Sp
  This mode is meant for integration with other toolsets, which take the
  responsibility of converting the \s-1VM\s0 configuration, providing for
  rollback in case of errors, transforming the storage, etc.
  .Sp
  See In-place conversion\*(R" below.
  .Sp
  Conflicts with all _-o *_ options.
* **-io** OPTION=VALUE  
  .IX Item "-io OPTION=VALUE"
  Set input option(s) related to the current input mode or transport.
  To display short help on what options are available you can use:
  .Sp
  .Vb 1
   virt-v2v -it vddk -io "?"
  .Ve
* **-io vddk-libdir=**\s-1LIBDIR\s0  
  .IX Item "-io vddk-libdir=LIBDIR"
  Set the \s-1VDDK\s0 library directory.  This directory should _contain_
  subdirectories called _include_, _lib64_ etc., but do not include
  _lib64_ actually in the parameter.
  .Sp
  In most cases this parameter is required when using the _-it vddk_
  (\s-1VDDK\s0) transport.  See **virt-v2v-input-vmware**\|(1) for details.
* **-io vddk-thumbprint=**xx:xx:xx:...  
  .IX Item "-io vddk-thumbprint=xx:xx:xx:..."
  Set the thumbprint of the remote VMware server.
  .Sp
  This parameter is required when using the _-it vddk_ (\s-1VDDK\s0) transport.
  See **virt-v2v-input-vmware**\|(1) for details.
* **-io vddk-config=**\s-1FILENAME\s0  
  .IX Item "-io vddk-config=FILENAME"
* **-io vddk-cookie=**\s-1COOKIE\s0  
  .IX Item "-io vddk-cookie=COOKIE"
* **-io vddk-nfchostport=**\s-1PORT\s0  
  .IX Item "-io vddk-nfchostport=PORT"
* **-io vddk-port=**\s-1PORT\s0  
  .IX Item "-io vddk-port=PORT"
* **-io vddk-snapshot=**SNAPSHOT-MOREF  
  .IX Item "-io vddk-snapshot=SNAPSHOT-MOREF"
* **-io vddk-transports=**\s-1MODE:MODE:...\s0  
  .IX Item "-io vddk-transports=MODE:MODE:..."
  When using \s-1VDDK\s0 mode, these options are passed unmodified to the
  **nbdkit**\|(1) \s-1VDDK\s0 plugin.  Please refer to **nbdkit-vddk-plugin**\|(1).
  Do not use these options unless you know what you are doing.  These
  are all optional.
* **-ip** filename  
  .IX Item "-ip filename"
  Supply a file containing a password to be used when connecting to the
  target hypervisor.  If this is omitted then the input hypervisor may
  ask for the password interactively.  Note the file should contain the
  whole password, **without any trailing newline**, and for security the
  file should have mode \f(CW0600 so that others cannot read it.
* **-it** **ssh**  
  .IX Item "-it ssh"
  When using _-i vmx_, this enables the ssh transport.
  See **virt-v2v-input-vmware**\|(1).
* **-it** **vddk**  
  .IX Item "-it vddk"
  Use VMware \s-1VDDK\s0 as a transport to copy the input disks.  See
  **virt-v2v-input-vmware**\|(1).  If you use this parameter then you
  may need to use other _-io vddk*_ options to specify how to connect
  through \s-1VDDK.\s0
* **--key** \s-1SELECTOR\s0  
  .IX Item "--key SELECTOR"
  Specify a key for \s-1LUKS,\s0 to automatically open a \s-1LUKS\s0 device when using
  the inspection.  \f(CW`ID\*(C' can be either the libguestfs device name, or
  the \s-1UUID\s0 of the \s-1LUKS\s0 device.
      .ie n .IP "**--key** ""ID"":key:KEY_STRING" 4
      .el .IP "**--key** \f(CWID:key:KEY_STRING" 4
      .IX Item "--key ID:key:KEY_STRING"
      Use the specified \f(CW`KEY\_STRING\*(C' as passphrase.
      .ie n .IP "**--key** ""ID"":file:FILENAME" 4
      .el .IP "**--key** \f(CWID:file:FILENAME" 4
      .IX Item "--key ID:file:FILENAME"
      Read the passphrase from _\s-1FILENAME\s0_.
* **--keys-from-stdin**  
  .IX Item "--keys-from-stdin"
  Read key or passphrase parameters from stdin.  The default is
  to try to read passphrases from the user by opening _/dev/tty_.
  .Sp
  If there are multiple encrypted devices then you may need to supply
  multiple keys on stdin, one per line.
  .Sp
  Note _--keys-from-stdin_ only applies to keys and passphrases for
  encrypted devices and partitions, not for passwords used to connect to
  remote servers.
* **--mac** aa:bb:cc:dd:ee:ff**:network:**out  
  .IX Item "--mac aa:bb:cc:dd:ee:ff:network:out"
* **--mac** aa:bb:cc:dd:ee:ff**:bridge:**out  
  .IX Item "--mac aa:bb:cc:dd:ee:ff:bridge:out"
  Map source \s-1NIC MAC\s0 address to a network or bridge.
  .Sp
  See Networks and bridges\*(R" below.
* **--mac** aa:bb:cc:dd:ee:ff**:ip:**ipaddr[,gw[,len[,ns,ns,...]]]  
  .IX Item "--mac aa:bb:cc:dd:ee:ff:ip:ipaddr[,gw[,len[,ns,ns,...]]]"
  Force a particular interface (controlled by its \s-1MAC\s0 address) to have a
  static \s-1IP\s0 address after boot.
  .Sp
  The fields in the parameter are: \f(CW`ipaddr\*(C' is the \s-1IP\s0 address.  \f(CW\*(C\`gw\*(C'
  is the optional gateway \s-1IP\s0 address.  \f(CW`len\*(C' is the subnet mask length
  (an integer).  The final parameters are zero or more nameserver \s-1IP\s0
  addresses.
  .Sp
  This option can be supplied zero or more times.
  .Sp
  You only need to use this option for certain broken guests such as
  Windows which are unable to preserve \s-1MAC\s0 to static \s-1IP\s0 address mappings
  automatically.  You don't need to use it if Windows is using \s-1DHCP.\s0  It
  is currently ignored for Linux guests since they do not have this
  problem.
* **--machine-readable**  
  .IX Item "--machine-readable"
* **--machine-readable**=format  
  .IX Item "--machine-readable=format"
  This option is used to make the output more machine friendly
  when being parsed by other programs.  See
  Machine readable output\*(R" below.
* **-n** in:out  
  .IX Item "-n in:out"
* **-n** out  
  .IX Item "-n out"
* **--network** in:out  
  .IX Item "--network in:out"
* **--network** out  
  .IX Item "--network out"
* **-b** in:out  
  .IX Item "-b in:out"
* **-b** out  
  .IX Item "-b out"
* **--bridge** in:out  
  .IX Item "--bridge in:out"
* **--bridge** out  
  .IX Item "--bridge out"
  Map network (or bridge) called \f(CW`in\*(C' to network (or bridge) called
  \f(CW`out\*(C'.  If no \f(CW\*(C\`in:\*(C' prefix is given, all other networks (or bridges)
  are mapped to \f(CW`out\*(C'.
  .Sp
  See Networks and bridges\*(R" below.
* **--no-copy**  
  .IX Item "--no-copy"
  Don’t copy the disks.  Instead, conversion is performed (and thrown
  away), and metadata is written, but no disks are created.  See
  also discussion of _-o null_ below.
  .Sp
  This is useful in two cases: Either you want to test if conversion is
  likely to succeed, without the long copying process.  Or you are only
  interested in looking at the metadata.
  .Sp
  This option is not compatible with _-o libvirt_ since it would create
  a faulty guest (one with no disks).
  .Sp
  This option is not compatible with _-o glance_ for technical reasons.
* **-o** **disk**  
  .IX Item "-o disk"
  This is the same as _-o local_.
* **-o** **glance**  
  .IX Item "-o glance"
  This is a legacy option.  You should probably use _-o openstack_
  instead.
  .Sp
  Set the output method to OpenStack Glance.  In this mode the converted
  guest is uploaded to Glance.  See **virt-v2v-output-openstack**\|(1).
* **-o** **json**  
  .IX Item "-o json"
  Set the output method to _json_.
  .Sp
  In this mode, the converted guest is written to a local directory
  specified by _-os /dir_ (the directory must exist), with a \s-1JSON\s0 file
  containing the majority of the metadata that virt-v2v gathered during
  the conversion.
  .Sp
  See **virt-v2v-output-local**\|(1).
* **-o** **libvirt**  
  .IX Item "-o libvirt"
  Set the output method to _libvirt_.  This is the default.
  .Sp
  In this mode, the converted guest is created as a libvirt guest.  You
  may also specify a libvirt connection \s-1URI\s0 (see _-oc_).
  .Sp
  See **virt-v2v-output-local**\|(1).
* **-o** **local**  
  .IX Item "-o local"
  Set the output method to _local_.
  .Sp
  In this mode, the converted guest is written to a local directory
  specified by _-os /dir_ (the directory must exist).  The converted
  guest’s disks are written as:
  .Sp
  .Vb 3
   /dir/name-sda
   /dir/name-sdb
   [etc]
  .Ve
  .Sp
  and a libvirt \s-1XML\s0 file is created containing guest metadata:
  .Sp
  .Vb 1
   /dir/name.xml
  .Ve
  .Sp
  where \f(CW`name\*(C' is the guest name.
* **-o** **null**  
  .IX Item "-o null"
  Set the output method to _null_.
  .Sp
  The guest is converted and copied (unless you also specify
  _--no-copy_), but the results are thrown away and no metadata is
  written.
* **-o** **openstack**  
  .IX Item "-o openstack"
  Set the output method to OpenStack.  See **virt-v2v-output-openstack**\|(1).
* **-o** **ovirt**  
  .IX Item "-o ovirt"
  This is the same as _-o rhv_.
* **-o** **ovirt-upload**  
  .IX Item "-o ovirt-upload"
  This is the same as _-o rhv-upload_.
* **-o** **qemu**  
  .IX Item "-o qemu"
  Set the output method to _qemu_.
  .Sp
  This is similar to _-o local_, except that a shell script is written
  which you can use to boot the guest in qemu.  The converted disks and
  shell script are written to the directory specified by _-os_.
  .Sp
  When using this output mode, you can also specify the _--qemu-boot_
  option which boots the guest under qemu immediately.
* **-o** **rhev**  
  .IX Item "-o rhev"
  This is the same as _-o rhv_.
* **-o** **rhv**  
  .IX Item "-o rhv"
  Set the output method to _rhv_.
  .Sp
  The converted guest is written to a \s-1RHV\s0 Export Storage Domain.  The
  _-os_ parameter must also be used to specify the location of the
  Export Storage Domain.  Note this does not actually import the guest
  into \s-1RHV.\s0  You have to do that manually later using the \s-1UI.\s0
  .Sp
  See **virt-v2v-output-rhv**\|(1).
* **-o** **rhv-upload**  
  .IX Item "-o rhv-upload"
  Set the output method to _rhv-upload_.
  .Sp
  The converted guest is written directly to a \s-1RHV\s0 Data Domain.
  This is a faster method than _-o rhv_, but requires oVirt
  or \s-1RHV\s0 ≥ 4.2.
  .Sp
  See **virt-v2v-output-rhv**\|(1).
* **-o** **vdsm**  
  .IX Item "-o vdsm"
  Set the output method to _vdsm_.
  .Sp
  This mode is similar to _-o rhv_, but the full path to the
  data domain must be given:
  _/rhv/data-center/&lt;data-center-uuid&gt;/&lt;data-domain-uuid&gt;_.
  This mode is only used when virt-v2v runs under \s-1VDSM\s0 control.
* **-oa** **sparse**  
  .IX Item "-oa sparse"
* **-oa** **preallocated**  
  .IX Item "-oa preallocated"
  Set the output file allocation mode.  The default is \f(CW`sparse\*(C'.
* **-oc** \s-1URI\s0  
  .IX Item "-oc URI"
  Specify a connection \s-1URI\s0 to use when writing the converted guest.
  .Sp
  For _-o libvirt_ this is the libvirt \s-1URI.\s0  Only local libvirt
  connections can be used.  Remote libvirt connections will not work.
  See **virt-v2v-output-local**\|(1) for further information.
* **-of** format  
  .IX Item "-of format"
  When converting the guest, convert the disks to the given format.
  .Sp
  If not specified, then the input format is used.
* **-on** name  
  .IX Item "-on name"
  Rename the guest when converting it.  If this option is not used then
  the output name is the same as the input name.
* **-oo** OPTION=VALUE  
  .IX Item "-oo OPTION=VALUE"
  Set output option(s) related to the current output mode.
  To display short help on what options are available you can use:
  .Sp
  .Vb 1
   virt-v2v -o rhv-upload -oo "?"
  .Ve
  .ie n .IP "**-oo guest-id=**""ID""" 4
  .el .IP "**-oo guest-id=**\f(CWID" 4
  .IX Item "-oo guest-id=ID"
  For _-o openstack_ (**virt-v2v-output-openstack**\|(1)) only, set a guest \s-1ID\s0
  which is saved on each Cinder volume in the \f(CW`virt\_v2v\_guest\_id\*(C'
  volume property.
* **-oo verify-server-certificate**  
  .IX Item "-oo verify-server-certificate"
  .ie n .IP "**-oo verify-server-certificate=**""true|false""" 4
  .el .IP "**-oo verify-server-certificate=**\f(CWtrue|false" 4
  .IX Item "-oo verify-server-certificate=true|false"
  For _-o openstack_ (**virt-v2v-output-openstack**\|(1)) only, this can
  be used to disable \s-1SSL\s0 certification validation when connecting to
  OpenStack by specifying _-oo verify-server-certificate=false_.
* **-oo os-*****=***  
  .IX Item "-oo os-*=*"
  For _-o openstack_ (**virt-v2v-output-openstack**\|(1)) only, set optional
  OpenStack authentication.  For example _-oo os-username=_\s-1NAME\s0 is
  equivalent to \f(CW`openstack --os-username=NAME\*(C'.
* **-oo rhv-cafile=**_ca.pem_  
  .IX Item "-oo rhv-cafile=ca.pem"
  For _-o rhv-upload_ (**virt-v2v-output-rhv**\|(1)) only, the _ca.pem_ file
  (Certificate Authority), copied from _/etc/pki/ovirt-engine/ca.pem_
  on the oVirt engine.
  .ie n .IP "**-oo rhv-cluster=**""CLUSTERNAME""" 4
  .el .IP "**-oo rhv-cluster=**\f(CWCLUSTERNAME" 4
  .IX Item "-oo rhv-cluster=CLUSTERNAME"
  For _-o rhv-upload_ (**virt-v2v-output-rhv**\|(1)) only, set the \s-1RHV\s0 Cluster
  Name.  If not given it uses \f(CW`Default\*(C'.
* **-oo rhv-direct**  
  .IX Item "-oo rhv-direct"
  For _-o rhv-upload_ (**virt-v2v-output-rhv**\|(1)) only, if this option is given
  then virt-v2v will attempt to directly upload the disk to the oVirt
  node, otherwise it will proxy the upload through the oVirt engine.
  Direct upload requires that you have network access to the oVirt
  nodes.  Non-direct upload is slightly slower but should work in all
  situations.
* **-oo rhv-verifypeer**  
  .IX Item "-oo rhv-verifypeer"
  For _-o rhv-upload_ (**virt-v2v-output-rhv**\|(1)) only, verify the oVirt/RHV
  server’s identity by checking the server‘s certificate against the
  Certificate Authority.
  .ie n .IP "**-oo server-id=**""NAME|UUID""" 4
  .el .IP "**-oo server-id=**\f(CWNAME|UUID" 4
  .IX Item "-oo server-id=NAME|UUID"
  For _-o openstack_ (**virt-v2v-output-openstack**\|(1)) only, set the name
  of the conversion appliance where virt-v2v is running.
* **-oo vdsm-compat=0.10**  
  .IX Item "-oo vdsm-compat=0.10"
* **-oo vdsm-compat=1.1**  
  .IX Item "-oo vdsm-compat=1.1"
  If _-o vdsm_ and the output format is qcow2, then we add the qcow2
  _compat=0.10_ option to the output file for compatibility with \s-1RHEL 6\s0
  (see https://bugzilla.redhat.com/1145582).
  .Sp
  If _-oo vdsm-compat=1.1_ is used then modern qcow2 (_compat=1.1_)
  files are generated instead.
  .Sp
  Currently _-oo vdsm-compat=0.10_ is the default, but this will change
  to _-oo vdsm-compat=1.1_ in a future version of virt-v2v (when we can
  assume that everyone is using a modern version of qemu).
  .Sp
  **Note this option only affects \f(BI-o vdsm output**.  All other output
  modes (including _-o rhv_) generate modern qcow2 _compat=1.1_
  files, always.
  .Sp
  If this option is available, then \f(CW`vdsm-compat-option\*(C' will appear in
  the _--machine-readable_ output.
* **-oo vdsm-image-uuid=**\s-1UUID\s0  
  .IX Item "-oo vdsm-image-uuid=UUID"
* **-oo vdsm-vol-uuid=**\s-1UUID\s0  
  .IX Item "-oo vdsm-vol-uuid=UUID"
* **-oo vdsm-vm-uuid=**\s-1UUID\s0  
  .IX Item "-oo vdsm-vm-uuid=UUID"
* **-oo vdsm-ovf-output=**\s-1DIR\s0  
  .IX Item "-oo vdsm-ovf-output=DIR"
  Normally the \s-1RHV\s0 output mode chooses random UUIDs for the target
  guest.  However \s-1VDSM\s0 needs to control the UUIDs and passes these
  parameters when virt-v2v runs under \s-1VDSM\s0 control.  The parameters
  control:
    * ·  
      the image directory of each guest disk (_-oo vdsm-image-uuid_) (this
      option is passed once for each guest disk)
    * ·  
      UUIDs for each guest disk (_-oo vdsm-vol-uuid_) (this option
      is passed once for each guest disk)
    * ·  
      the \s-1OVF\s0 file name (_-oo vdsm-vm-uuid_).
    * ·  
      the \s-1OVF\s0 output directory (default current directory) (_-oo vdsm-ovf-output_).
      .Sp
      The format of UUIDs is: \f(CW`12345678-1234-1234-1234-123456789abc\*(C' (each
      hex digit can be \f(CW`0-9\*(C' or \f(CW\*(C\`a-f\*(C'), conforming to \s-1OSF DCE 1.1.\s0
      .Sp
      These options can only be used with _-o vdsm_.
* **-oo vdsm-ovf-flavour=**flavour  
  .IX Item "-oo vdsm-ovf-flavour=flavour"
  This option controls the format of the \s-1OVF\s0 generated at the end of conversion.
  Currently there are two possible flavours:
    * rhvexp  
      .IX Item "rhvexp"
      The \s-1OVF\s0 format used in \s-1RHV\s0 export storage domain.
    * ovirt  
      .IX Item "ovirt"
      The \s-1OVF\s0 format understood by oVirt \s-1REST API.\s0
      .Sp
      For backward compatibility the default is _rhvexp_, but this may change in
      the future.
* **-op** file  
  .IX Item "-op file"
  Supply a file containing a password to be used when connecting to the
  target hypervisor.  Note the file should contain the whole password,
  **without any trailing newline**, and for security the file should have
  mode \f(CW0600 so that others cannot read it.
* **-os** storage  
  .IX Item "-os storage"
  The location of the storage for the converted guest.
  .Sp
  For _-o libvirt_, this is a libvirt directory pool
  (see \f(CW`virsh pool-list\*(C') or pool \s-1UUID.\s0
  .Sp
  For _-o json_, _-o local_ and _-o qemu_, this is a directory name.
  The directory must exist.
  .Sp
  For _-o rhv-upload_, this is the name of the destination Storage
  Domain.
  .Sp
  For _-o openstack_, this is the optional Cinder volume type.
  .Sp
  For _-o rhv_, this can be an \s-1NFS\s0 path of the Export Storage Domain
  of the form \f(CW`&lt;host&gt;:&lt;path&gt;\*(C', eg:
  .Sp
  .Vb 1
   rhv-storage.example.com:/rhv/export
  .Ve
  .Sp
  The \s-1NFS\s0 export must be mountable and writable by the user and host
  running virt-v2v, since the virt-v2v program has to actually mount it
  when it runs.  So you probably have to run virt-v2v as \f(CW`root\*(C'.
  .Sp
  **Or:** You can mount the Export Storage Domain yourself, and point
  _-os_ to the mountpoint.  Note that virt-v2v will still need to write
  to this remote directory, so virt-v2v will still need to run as
  \f(CW`root\*(C'.
  .Sp
  You will get an error if virt-v2v is unable to mount/write to the
  Export Storage Domain.
* **--print-estimate**  
  .IX Item "--print-estimate"
  Print the estimated size of the data which will be copied from the
  source disk(s) and stop.  One number (the size in bytes) is printed
  per disk, and a total:
  .Sp
  .Vb 5
   $ virt-v2v --print-estimate
   ...
   disk 1: 100000
   disk 2: 200000
   total: 300000
  .Ve
  .Sp
  With the _--machine-readable_ option you get \s-1JSON\s0 output which can be
  directed into a file or elsewhere:
  .Sp
  .Vb 7
   $ virt-v2v --print-estimate --machine-readable=file:estimates
   ...
   $ cat estimates
   {
    "disks": [ 100000, 200000 ],
    "total": 300000
   }
  .Ve
  .Sp
  When using this option you must specify an output mode.  This is
  because virt-v2v has to perform the conversion in order to print the
  estimate, and the conversion depends on the output mode.  Using
  _-o null_ should be safe for most purposes.
  .Sp
  When this option is used along with _--machine-readable_ you can
  direct the output to an alternate file.
* **--print-source**  
  .IX Item "--print-source"
  Print information about the source guest and stop.  This option is
  useful when you are setting up network and bridge maps.
  See Networks and bridges\*(R".
* **--qemu-boot**  
  .IX Item "--qemu-boot"
  When using _-o qemu_ only, this boots the guest immediately after
  virt-v2v finishes.
* **-q**  
  .IX Item "-q"
* **--quiet**  
  .IX Item "--quiet"
  This disables progress bars and other unnecessary output.
* **--root ask**  
  .IX Item "--root ask"
* **--root single**  
  .IX Item "--root single"
* **--root first**  
  .IX Item "--root first"
* **--root** /dev/sdX  
  .IX Item "--root /dev/sdX"
* **--root** /dev/VG/LV  
  .IX Item "--root /dev/VG/LV"
  Choose the root filesystem to be converted.
  .Sp
  In the case where the virtual machine is dual-boot or multi-boot, or
  where the \s-1VM\s0 has other filesystems that look like operating systems,
  this option can be used to select the root filesystem (a.k.a. \f(CW`C:\*(C'
  drive or _/_) of the operating system that is to be converted.  The
  Windows Recovery Console, certain attached \s-1DVD\s0 drives, and bugs in
  libguestfs inspection heuristics, can make a guest look like a
  multi-boot operating system.
  .Sp
  The default in virt-v2v ≤ 0.7.1 was _--root single_, which
  causes virt-v2v to die if a multi-boot operating system is found.
  .Sp
  Since virt-v2v ≥ 0.7.2 the default is now _--root ask_: If the
  \s-1VM\s0 is found to be multi-boot, then virt-v2v will stop and list the
  possible root filesystems and ask the user which to use.  This
  requires that virt-v2v is run interactively.
  .Sp
  _--root first_ means to choose the first root device in the case
  of a multi-boot operating system.  Since this is a heuristic, it may
  sometimes choose the wrong one.
  .Sp
  You can also name a specific root device, eg. _--root /dev/sda2_
  would mean to use the second partition on the first hard drive.  If
  the named root device does not exist or was not detected as a root
  device, then virt-v2v will fail.
  .Sp
  Note that there is a bug in grub which prevents it from successfully
  booting a multiboot system if virtio is enabled.  Grub is only able to
  boot an operating system from the first virtio disk.  Specifically,
  _/boot_ must be on the first virtio disk, and it cannot chainload an
  \s-1OS\s0 which is not in the first virtio disk.
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

<a name="notes"></a>

# Notes

.IX Header "NOTES"

<a name="xen-paravirtualized-guests"></a>

### Xen paravirtualized guests

.IX Subsection "Xen paravirtualized guests"
Older versions of virt-v2v could turn a Xen paravirtualized (\s-1PV\s0) guest
into a \s-1KVM\s0 guest by installing a new kernel.  This version of virt-v2v
does _not_ attempt to install any new kernels.  Instead it will give
you an error if there are _only_ Xen \s-1PV\s0 kernels available.

Therefore before conversion you should check that a regular kernel is
installed.  For some older Linux distributions, this means installing
a kernel from the table below:

.Vb 1
 RHEL 3         (Does not apply, as there was no Xen PV kernel)
 
 RHEL 4         i686 with &gt; 10GB of RAM: install kernel-hugemem\*(Aq
                i686 SMP: install kernel-smp\*(Aq
                other i686: install kernel\*(Aq
                x86-64 SMP with &gt; 8 CPUs: install kernel-largesmp\*(Aq
                x86-64 SMP: install kernel-smp\*(Aq
                other x86-64: install kernel\*(Aq
 
 RHEL 5         i686: install kernel-PAE\*(Aq
                x86-64: install kernel\*(Aq
 
 SLES 10        i586 with &gt; 10GB of RAM: install kernel-bigsmp\*(Aq
                i586 SMP: install kernel-smp\*(Aq
                other i586: install kernel-default\*(Aq
                x86-64 SMP: install kernel-smp\*(Aq
                other x86-64: install kernel-default\*(Aq
 
 SLES 11+       i586: install kernel-pae\*(Aq
                x86-64: install kernel-default\*(Aq

 Windows        (Does not apply, as there is no Xen PV Windows kernel)
.Ve

<a name="enabling-virtio"></a>

### Enabling virtio

.IX Subsection "Enabling virtio"
Virtio\*(R" is the name for a set of drivers which make disk (block
device), network and other guest operations work much faster on \s-1KVM.\s0

Older versions of virt-v2v could install these drivers for certain
Linux guests.  This version of virt-v2v does _not_ attempt to install
new Linux kernels or drivers, but will warn you if they are not
installed already.

In order to enable virtio, and hence improve performance of the guest
after conversion, you should ensure that the **minimum** versions of
packages are installed _before_ conversion, by consulting the table
below.

.Vb 1
 RHEL 3         No virtio drivers are available
 
 RHEL 4         kernel &gt;= 2.5.9-89.EL
                lvm2 &gt;= 2.02.42-5.el4
                device-mapper &gt;= 1.02.28-2.el4
                selinux-policy-targeted &gt;= 1.17.30-2.152.el4
                policycoreutils &gt;= 1.18.1-4.13
 
 RHEL 5         kernel &gt;= 2.6.18-128.el5
                lvm2 &gt;= 2.02.40-6.el5
                selinux-policy-targeted &gt;= 2.4.6-203.el5
 
 RHEL 6+        All versions support virtio
 
 Fedora         All versions support virtio
 
 SLES 11+       All versions support virtio
 
 SLES 10        kernel &gt;= 2.6.16.60-0.85.1
 
 OpenSUSE 11+   All versions support virtio
 
 OpenSUSE 10    kernel &gt;= 2.6.25.5-1.1

 Debian 6+      All versions support virtio

 Ubuntu 10.04+  All versions support virtio

 Windows        Drivers are installed from the ISO or directory pointed
                to by "VIRTIO_WIN" environment variable if present
.Ve

<a name="s-1rhel-4s0-selinux-relabel-appears-to-hang-forever"></a>

### \s-1RHEL 4:\s0 SELinux relabel appears to hang forever

.IX Subsection "RHEL 4: SELinux relabel appears to hang forever"
In \s-1RHEL\s0 ≤ 4.7 there was a bug which causes SELinux relabelling
to appear to hang forever at:

.Vb 4
 *** Warning -- SELinux relabel is required. ***
 *** Disabling security enforcement.         ***
 *** Relabeling could take a very long time, ***
 *** depending on file system size.          ***
.Ve

In reality it is waiting for you to press a key (but there is no
visual indication of this).  You can either hit the \f(CW`[Return]\*(C' key,
at which point the guest will finish relabelling and reboot, or you
can install policycoreutils ≥ 1.18.1-4.13 before starting the v2v
conversion.  See also
https://bugzilla.redhat.com/show_bug.cgi?id=244636

<a name="debian-and-ubuntu"></a>

### Debian and Ubuntu

.IX Subsection "Debian and Ubuntu"
_warning: could not determine a way to update the configuration of Grub2\*(R"_
.IX Subsection "warning: could not determine a way to update the configuration of Grub2"

Currently, virt-v2v has no way to set the default kernel in Debian
and Ubuntu guests using \s-1GRUB 2\s0 as bootloader.  This means that
virt-v2v will not change the default kernel used for booting, even
in case it is not the best kernel available on the guest.
A recommended procedure is, before using virt-v2v, to check that the
boot kernel is the best kernel available in the guest (for example
by making sure the guest is up-to-date).

_vsyscall attempted with vsyscall=none\*(R"_
.IX Subsection "vsyscall attempted with vsyscall=none"

When run on a recent Debian host virt-v2v may fail to convert guests
which were created before 2013.  In the debugging output you will see
a crash message similar to:

.Vb 2
 vsyscall attempted with vsyscall=none ip:...
 segfault at ...
.Ve

This is caused because Debian removed support for running old binaries
which used the legacy vsyscall page to call into the kernel.

You can work around this problem by running this command before
running virt-v2v:

.Vb 1
 export LIBGUESTFS_APPEND="vsyscall=emulate"
.Ve

For more information, see https://bugzilla.redhat.com/1592061

<a name="windows"></a>

### Windows

.IX Subsection "Windows"
_Windows ≥ 8 Fast Startup is incompatible with virt-v2v_
.IX Subsection "Windows ≥ 8 Fast Startup is incompatible with virt-v2v"

Guests which use the Windows ≥ 8 Fast Startup\*(R" feature (or guests
which are hibernated) cannot be converted with virt-v2v.  You will see
an error:

.Vb 4
 virt-v2v: error: unable to mount the disk image for writing. This has
 probably happened because Windows Hibernation or Fast Restart is being
 used in this guest. You have to disable this (in the guest) in order
 to use virt-v2v.
.Ve

As the message says, you need to boot the guest and disable the Fast
Startup feature (Control Panel → Power Options → Choose what the
power buttons do → Change settings that are currently unavailable →
Turn on fast startup), and shut down the guest, and then you will be
able to convert it.

For more information, see:
\s-1WINDOWS HIBERNATION AND WINDOWS 8 FAST STARTUP\*(R"\s0 in **guestfs**\|(3).

_Boot failure: 0x0000007B_
.IX Subsection "Boot failure: 0x0000007B"

This boot failure is caused by Windows being unable to find or load
the right disk driver (eg. _viostor.sys_).  If you experience this
error, here are some things to check:

* ·  
  First ensure that the guest boots on the source hypervisor before
  conversion.
* ·  
  Check you have the Windows virtio drivers available in
  _/usr/share/virtio-win_, and that virt-v2v did not print any warning
  about not being able to install virtio drivers.
  .Sp
  On Red Hat Enterprise Linux 7, you will need to install the signed
  drivers available in the \f(CW`virtio-win\*(C' package.  If you do not have
  access to the signed drivers, then you will probably need to disable
  driver signing in the boot menus.
* ·  
  Check that you are presenting a virtio-blk interface (**not**
  virtio-scsi and **not** ide) to the guest.  On the qemu/KVM command
  line you should see something similar to this:
  .Sp
  .Vb 1
   ... -drive file=windows-sda,if=virtio ...
  .Ve
  .Sp
  In libvirt \s-1XML,\s0 you should see:
  .Sp
  .Vb 1
   &lt;target dev=vda\*(Aq bus=\*(Aqvirtio\*(Aq/&gt;
  .Ve
* ·  
  Check that Windows Group Policy does not prevent the driver from being
  installed or used.  Try deleting Windows Group Policy before
  conversion.
* ·  
  Check there is no anti-virus or other software which implements Group
  Policy-like prohibitions on installing or using new drivers.
* ·  
  Enable boot debugging and check the _viostor.sys_ driver is being
  loaded.

_OpenStack and Windows reactivation_
.IX Subsection "OpenStack and Windows reactivation"

OpenStack does not offer stable device / \s-1PCI\s0 addresses to guests.
Every time it creates or starts a guest, it regenerates the libvirt
\s-1XML\s0 for that guest from scratch.  The libvirt \s-1XML\s0 will have no
&lt;address&gt; fields.  Libvirt will then assign addresses to
devices, in a predictable manner.  Addresses may change if any of the
following are true:

* ·  
  A new disk or network device has been added or removed from the guest.
* ·  
  The version of OpenStack or (possibly) libvirt has changed.

Because Windows does not like hardware\*(R" changes of this kind, it may
trigger Windows reactivation.

This can also prevent booting with a 7B error [see previous section]
if the guest has group policy containing
\f(CW`Device Installation Restrictions\*(C'.

_Support for \s-1SHA-2\s0 certificates in Windows 7 and Windows Server 2008 R2_
.IX Subsection "Support for SHA-2 certificates in Windows 7 and Windows Server 2008 R2"

Later versions of the Windows virtio drivers are signed using \s-1SHA-2\s0
certificates (instead of \s-1SHA-1\s0).  The original shipping Windows 7 and
Windows Server 2008 R2 did not understand \s-1SHA-2\s0 certificates and so
the Windows virtio drivers will not install properly.

To fix this you must apply \s-1SHA-2\s0 Code Signing Support from:
https://docs.microsoft.com/en-us/security-updates/SecurityAdvisories/2015/3033929
before converting the guest.

For further information see:
https://bugzilla.redhat.com/show_bug.cgi?id=1624878

<a name="networks-and-bridges"></a>

### Networks and bridges

.IX Subsection "Networks and bridges"
Guests are usually connected to one or more networks, and when
converted to the target hypervisor you usually want to reconnect those
networks at the destination.  The options _--network_, _--bridge_
and _--mac_ allow you to do that.

If you are unsure of what networks and bridges are in use on the
source hypervisor, then you can examine the source metadata (libvirt
\s-1XML,\s0 vCenter information, etc.).  Or you can run virt-v2v with the
_--print-source_ option which causes virt-v2v to print out the
information it has about the guest on the source and then exit.

In the _--print-source_ output you will see a section showing the
guest’s Network Interface Cards (NICs):

.Vb 4
 $ virt-v2v [-i ...] --print-source name
 [...]
 NICs:
     Network "default" mac: 52:54:00:d0:cf:0e
.Ve

Bridges are special classes of network devices which are attached to a
named external network on the source hypervisor, for example:

.Vb 4
 $ virt-v2v [-i ...] --print-source name
 [...]
 NICs:
     Bridge "br0"
.Ve

To map a specific source bridge to a target network, for example
\f(CW`br0\*(C' on the source to \f(CW\*(C\`ovirtmgmt\*(C' on the target, use:

.Vb 1
 virt-v2v [...] --bridge br0:ovirtmgmt
.Ve

To map every bridge to a target network, use:

.Vb 1
 virt-v2v [...] --bridge ovirtmgmt
.Ve

_Fine-grained mapping of guest NICs_
.IX Subsection "Fine-grained mapping of guest NICs"

The _--mac_ option gives you more control over the mapping, letting
you map single NICs to either networks or bridges on the target.  For
example a source guest with two NICs could map them individually to
two networks called \f(CW`mgmt\*(C' and \f(CW\*(C\`clientdata\*(C' like this:

.Vb 3
 $ virt-v2v [...] \e
    --mac 52:54:00:d0:cf:0e:network:mgmt \e
    --mac 52:54:00:d0:cf:0f:network:clientdata
.Ve

Note that virt-v2v does not have the ability to change a guest’s \s-1MAC\s0
address.  The \s-1MAC\s0 address is part of the guest metadata and must
remain the same on source and target hypervisors.  Most guests will
use the \s-1MAC\s0 address to set up persistent associations between NICs and
internal names (like \f(CW`eth0\*(C'), with firewall settings, or even for
other purposes like software licensing.

<a name="resource-requirements"></a>

### Resource requirements

.IX Subsection "Resource requirements"
_Network_
.IX Subsection "Network"

The most important resource for virt-v2v appears to be network
bandwidth.  Virt-v2v should be able to copy guest data at gigabit
ethernet speeds or greater.

Ensure that the network connections between servers (conversion
server, \s-1NFS\s0 server, vCenter, Xen) are as fast and as low latency as
possible.

_Disk space_
.IX Subsection "Disk space"

Virt-v2v places potentially large temporary files in
\f(CW$VIRT\_V2V\_TMPDIR (usually _/var/tmp_, see also
\s-1ENVIRONMENT VARIBLES\*(R"\s0 below).  Using tmpfs is a bad idea.

For each guest disk, an overlay is stored temporarily.  This stores
the changes made during conversion, and is used as a cache.  The
overlays are not particularly large - tens or low hundreds of
megabytes per disk is typical.  In addition to the overlay(s), input
and output methods may use disk space, as outlined in the table below.

* _-i ova_  
  .IX Item "-i ova"
  This temporarily places a full copy of the uncompressed source disks
  in \f(CW$VIRT\_V2V\_TMPDIR (or _/var/tmp_).
* _-o glance_  
  .IX Item "-o glance"
  This temporarily places a full copy of the output disks in
  \f(CW$VIRT\_V2V\_TMPDIR (or _/var/tmp_).
* _-o local_  
  .IX Item "-o local"
* _-o qemu_  
  .IX Item "-o qemu"
  You must ensure there is sufficient space in the output directory for
  the converted guest.

See also Minimum free space check in the host\*(R" below.

_VMware vCenter resources_
.IX Subsection "VMware vCenter resources"

Copying from VMware vCenter is currently quite slow, but we believe
this to be an issue with VMware.  Ensuring the VMware ESXi hypervisor
and vCenter are running on fast hardware with plenty of memory should
alleviate this.

_Compute power and \s-1RAM\s0_
.IX Subsection "Compute power and RAM"

Virt-v2v is not especially compute or \s-1RAM\s0 intensive.  If you are
running many parallel conversions, then you may consider allocating
one \s-1CPU\s0 core and 2 \s-1GB\s0 of \s-1RAM\s0 per running instance.

Virt-v2v can be run in a virtual machine.

_Trimming_
.IX Subsection "Trimming"

Virt-v2v attempts to optimize the speed of conversion by ignoring
guest filesystem data which is not used.  This would include unused
filesystem blocks, blocks containing zeroes, and deleted files.

To do this, virt-v2v issues a non-destructive **fstrim**\|(8) operation.
As this happens to an overlay placed over the guest data, it does
**not** affect the source in any way.

If this fstrim operation fails, you will see a warning, but virt-v2v
will continue anyway.  It may run more slowly (in some cases much more
slowly), because it is copying the unused parts of the disk.

Unfortunately support for fstrim is not universal, and it also depends
on specific details of the filesystem, partition alignment, and
backing storage.  As an example, \s-1NTFS\s0 filesystems cannot be fstrimmed
if they occupy a partition which is not aligned to the underlying
storage.  That was the default on Windows before Vista.  As another
example, \s-1VFAT\s0 filesystems (used by \s-1UEFI\s0 guests) cannot be trimmed at
all.

fstrim support in the Linux kernel is improving gradually, so over
time some of these restrictions will be lifted and virt-v2v will work
faster.

<a name="post-conversion-tasks"></a>

### Post-conversion tasks

.IX Subsection "Post-conversion tasks"
_Guest network configuration_
.IX Subsection "Guest network configuration"

Virt-v2v cannot currently reconfigure a guest’s network configuration.
If the converted guest is not connected to the same subnet as the
source, its network configuration may have to be updated.  See also
**virt-customize**\|(1).

_Converting a Windows guest_
.IX Subsection "Converting a Windows guest"

When converting a Windows guests, the conversion process is split into
two stages:

* 1.  
  Offline conversion.
* 2.  
  First boot.

The guest will be bootable after the offline conversion stage, but
will not yet have all necessary drivers installed to work correctly.
These will be installed automatically the first time the guest boots.

**N.B.** Take care not to interrupt the automatic driver installation
process when logging in to the guest for the first time, as this may
prevent the guest from subsequently booting correctly.

<a name="free-space-for-conversion"></a>

### Free space for conversion

.IX Subsection "Free space for conversion"
_Free space in the guest_
.IX Subsection "Free space in the guest"

Virt-v2v checks there is sufficient free space in the guest filesystem
to perform the conversion.  Currently it checks:

* Linux root filesystem  
  .IX Item "Linux root filesystem"
  Minimum free space: 20 \s-1MB\s0
* Linux _/boot_  
  .IX Item "Linux /boot"
  Minimum free space: 50 \s-1MB\s0
  .Sp
  This is because we need to build a new initramfs for some Enterprise
  Linux conversions.
  .ie n .IP "Windows ""C:"" drive" 4
  .el .IP "Windows \f(CWC: drive" 4
  .IX Item "Windows C: drive"
  Minimum free space: 100 \s-1MB\s0
  .Sp
  We may have to copy in many virtio drivers and guest agents.
* Any other mountable filesystem  
  .IX Item "Any other mountable filesystem"
  Minimum free space: 10 \s-1MB\s0

In addition to the actual free space, each filesystem is required to
have at least 100 available inodes.

_Minimum free space check in the host_
.IX Subsection "Minimum free space check in the host"

You must have sufficient free space in the host directory used to
store large temporary overlays (except in _--in-place_ mode).  To
find out which directory this is, use:

.Vb 3
 $ df -h "\\`guestfish get-cachedir\\`"
 Filesystem        Size  Used Avail Use% Mounted on
 /dev/mapper/root   50G   40G  6.8G  86% /
.Ve

and look under the \f(CW`Avail\*(C' column.  Virt-v2v will refuse to do the
conversion at all unless at least 1GB is available there.  You can
change the directory that virt-v2v uses by setting
\f(CW$VIRT\_V2V\_TMPDIR.

See also Resource requirements\*(R" above and \*(L"\s-1ENVIRONMENT VARIABLES\*(R"\s0
below.

<a name="running-virt-v2v-as-root-or-non-root"></a>

### Running virt\-v2v as root or non-root

.IX Subsection "Running virt-v2v as root or non-root"
Nothing in virt-v2v inherently needs root access, and it will run just
fine as a non-root user.  However, certain external features may
require either root or a special user:

* Mounting the Export Storage Domain  
  .IX Item "Mounting the Export Storage Domain"
  When using _-o rhv -os server:/esd_ virt-v2v has to have sufficient
  privileges to \s-1NFS\s0 mount the Export Storage Domain from \f(CW`server\*(C'.
  .Sp
  You can avoid needing root here by mounting it yourself before running
  virt-v2v, and passing _-os /mountpoint_ instead, but first of all
  read the next section ...
* Writing to the Export Storage Domain as 36:36  
  .IX Item "Writing to the Export Storage Domain as 36:36"
  RHV-M cannot read files and directories from the Export Storage
  Domain unless they have \s-1UID:GID 36:36.\s0  You will see \s-1VM\s0 import
  problems if the \s-1UID:GID\s0 is not correct.
  .Sp
  When you run virt-v2v _-o rhv_ as root, virt-v2v attempts to create
  files and directories with the correct ownership.  If you run virt-v2v
  as non-root, it will probably still work, but you will need to
  manually change ownership after virt-v2v has finished.
* Writing to libvirt  
  .IX Item "Writing to libvirt"
  When using _-o libvirt_, you may need to run virt-v2v as root so that
  it can write to the libvirt system instance (ie. \f(CW`qemu:///system\*(C')
  and to the default location for disk images (usually
  _/var/lib/libvirt/images_).
  .Sp
  You can avoid this by setting up libvirt connection authentication,
  see http://libvirt.org/auth.html.  Alternatively, use
  _-oc qemu:///session_, which will write to your per-user libvirt
  instance.
* Writing to Openstack  
  .IX Item "Writing to Openstack"
  Because of how Cinder volumes are presented as _/dev_ block devices,
  using _-o openstack_ normally requires that virt-v2v is run as root.
* Writing to Glance  
  .IX Item "Writing to Glance"
  This does _not_ need root (in fact it probably won’t work), but may
  require either a special user and/or for you to source a script that
  sets authentication environment variables.  Consult the Glance
  documentation.
* Writing to block devices  
  .IX Item "Writing to block devices"
  This normally requires root.  See the next section.

<a name="writing-to-block-devices"></a>

### Writing to block devices

.IX Subsection "Writing to block devices"
Some output modes write to local files.  In general these modes also
let you write to block devices, but before you run virt-v2v you may
have to arrange for symbolic links to the desired block devices in the
output directory.

For example if using _-o local -os /dir_ then virt-v2v would normally
create files called:

.Vb 4
 /dir/name-sda     # first disk
 /dir/name-sdb     # second disk
 ...
 /dir/name.xml     # metadata
.Ve

If you wish the disks to be written to block devices then you would
need to create _/dir/name-sda_ (etc) as symlinks to the block
devices:

.Vb 4
 # lvcreate -L 10G -n VolumeForDiskA VG
 # lvcreate -L 6G -n VolumeForDiskB VG
 # ln -sf /dev/VG/VolumeForDiskA /dir/name-sda
 # ln -sf /dev/VG/VolumeForDiskB /dir/name-sdb
.Ve

Note that you must precreate the correct number of block devices of
the correct size.  Typically _-of raw_ has to be used too, but other
formats such as qcow2 can be useful occasionally so virt-v2v does not
force you to use raw on block devices.

<a name="minimal-s-1xmls0-for-i-libvirtxml-option"></a>

### Minimal \s-1XML\s0 for \-i libvirtxml option

.IX Subsection "Minimal XML for -i libvirtxml option"
When using the _-i libvirtxml_ option, you have to supply some
libvirt \s-1XML.\s0  Writing this from scratch is hard, so the template below
is helpful.

Note this should only be used for testing and/or where you know what
you're doing!  If you have libvirt metadata for the guest, always use
that instead.

.Vb 10
 &lt;domain type=kvm\*(Aq&gt;
   &lt;name&gt; NAME &lt;/name&gt;
   &lt;memory&gt;1048576&lt;/memory&gt;
   &lt;vcpu&gt;2&lt;/vcpu&gt;
   &lt;os&gt;
     &lt;type&gt;hvm&lt;/type&gt;
     &lt;boot dev=hd\*(Aq/&gt;
   &lt;/os&gt;
   &lt;features&gt;
     &lt;acpi/&gt;
     &lt;apic/&gt;
     &lt;pae/&gt;
   &lt;/features&gt;
   &lt;devices&gt;
     &lt;disk type=file\*(Aq device=\*(Aqdisk\*(Aq&gt;
       &lt;driver name=qemu\*(Aq type=\*(Aqraw\*(Aq/&gt;
       &lt;source file=/path/to/disk/image\*(Aq/&gt;
       &lt;target dev=hda\*(Aq bus=\*(Aqide\*(Aq/&gt;
     &lt;/disk&gt;
     &lt;interface type=network\*(Aq&gt;
       &lt;mac address=52:54:00:01:02:03\*(Aq/&gt;
       &lt;source network=default\*(Aq/&gt;
       &lt;model type=rtl8139\*(Aq/&gt;
     &lt;/interface&gt;
   &lt;/devices&gt;
 &lt;/domain&gt;
.Ve

<a name="in-place-conversion"></a>

### In-place conversion

.IX Subsection "In-place conversion"
It is also possible to use virt-v2v in scenarios where a foreign \s-1VM\s0
has already been imported into a KVM-based hypervisor, but still needs
adjustments in the guest to make it run in the new virtual hardware.

In that case it is assumed that a third-party tool has created the
target \s-1VM\s0 in the supported KVM-based hypervisor based on the source \s-1VM\s0
configuration and contents, but using virtual devices more appropriate
for \s-1KVM\s0 (e.g. virtio storage and network, etc.).

Then, to make the guest \s-1OS\s0 boot and run in the changed environment,
one can use:

.Vb 1
 virt-v2v -ic qemu:///system converted_vm --in-place
.Ve

Virt-v2v will analyze the configuration of \f(CW`converted\_vm\*(C' in the
\f(CW`qemu:///system\*(C' libvirt instance, and apply various fixups to the
guest \s-1OS\s0 configuration to make it match the \s-1VM\s0 configuration.  This
may include installing virtio drivers, configuring the bootloader, the
mountpoints, the network interfaces, and so on.

Should an error occur during the operation, virt-v2v exits with an
error code leaving the \s-1VM\s0 in an undefined state.

<a name="machine-readable-output"></a>

### Machine readable output

.IX Subsection "Machine readable output"
The _--machine-readable_ option can be used to make the output more
machine friendly, which is useful when calling virt-v2v from
other programs, GUIs etc.

There are two ways to use this option.

Firstly use the option on its own to query the capabilities of the
virt-v2v binary.  Typical output looks like this:

.Vb 11
 $ virt-v2v --machine-readable
 virt-v2v
 libguestfs-rewrite
 colours-option
 vdsm-compat-option
 input:disk
 [...]
 output:local
 [...]
 convert:linux
 convert:windows
.Ve

A list of features is printed, one per line, and the program exits
with status 0.

The \f(CW`input:\*(C' and \f(CW\*(C\`output:\*(C' features refer to _-i_ and _-o_ (input
and output mode) options supported by this binary.  The \f(CW`convert:\*(C'
features refer to guest types that this binary knows how to convert.

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
  messages.  In addition, virt-v2v exits with a non-zero status
  code if there was a fatal error.

Virt-v2v ≤ 0.9.1 did not support the _--machine-readable_
option at all.  The option was added when virt-v2v was rewritten in 2014.

It is possible to specify a format string for controlling the output;
see \s-1ADVANCED MACHINE READABLE OUTPUT\*(R"\s0 in **guestfs**\|(3).

<a name="files"></a>

# Files

.IX Header "FILES"

* _/usr/share/virtio-win_  
  .IX Item "/usr/share/virtio-win"
  (Optional)
  .Sp
  If this directory is present, then virtio drivers for Windows guests
  will be found from this directory and installed in the guest during
  conversion.

<a name="environment-variables"></a>

# Environment Variables

.IX Header "ENVIRONMENT VARIABLES"
.ie n .IP """VIRT_V2V_TMPDIR""" 4
.el .IP "\f(CWVIRT\_V2V\_TMPDIR" 4
.IX Item "VIRT_V2V_TMPDIR"
.ie n .IP """LIBGUESTFS_CACHEDIR""" 4
.el .IP "\f(CWLIBGUESTFS\_CACHEDIR" 4
.IX Item "LIBGUESTFS_CACHEDIR"
Location of the temporary directory used for the potentially large
temporary overlay file.  If neither environment variable is set then
_/var/tmp_ is used.
.Sp
To reliably ensure large temporary files are cleaned up (for example
in case virt-v2v crashes) you should create a randomly named directory
under _/var/tmp_, set \f(CW`VIRT\_V2V\_TMPDIR\*(C' to point to this directory,
then when virt-v2v exits remove the directory.
.Sp
See the Disk space\*(R" section above.
.ie n .IP """VIRT_TOOLS_DATA_DIR""" 4
.el .IP "\f(CWVIRT\_TOOLS\_DATA\_DIR" 4
.IX Item "VIRT_TOOLS_DATA_DIR"
This can point to the directory containing data files used for Windows
conversion.
.Sp
Normally you do not need to set this.  If not set, a compiled-in
default will be used (something like _/usr/share/virt-tools_).
.Sp
This directory may contain the following files:

* _rhsrvany.exe_  
  .IX Item "rhsrvany.exe"
  (Required when doing conversions of Windows guests)
  .Sp
  This is the RHSrvAny Windows binary, used to install a firstboot\*(R"
  script in the guest during conversion of Windows guests.
  .Sp
  See also: \f(CW`https://github.com/rwmjones/rhsrvany\*(C'
* _pvvxsvc.exe_  
  .IX Item "pvvxsvc.exe"
  This is a Windows binary shipped with \s-1SUSE VMDP,\s0 used to install a firstboot\*(R"
  script in Windows guests.  It is required if you intend to use the
  _--firstboot_ or _--firstboot-command_ options with Windows guests.
* _rhev-apt.exe_  
  .IX Item "rhev-apt.exe"
  (Optional)
  .Sp
  The \s-1RHV\s0 Application Provisioning Tool (\s-1RHEV APT\s0).  If this file is
  present, then \s-1RHEV APT\s0 will be installed in the Windows guest during
  conversion.  This tool is a guest agent which ensures that the virtio
  drivers remain up to date when the guest is running on Red Hat
  Virtualization (\s-1RHV\s0).
  .Sp
  This file comes from Red Hat Virtualization (\s-1RHV\s0), and is not
  distributed with virt-v2v.
.ie n .IP """VIRTIO_WIN""" 4
.el .IP "\f(CWVIRTIO\_WIN" 4
.IX Item "VIRTIO_WIN"
This is where virtio drivers for Windows are searched for.  It can be
a directory _or_ point to _virtio-win.iso_ (\s-1CD ROM\s0 image containing
drivers).
.Sp
If unset, then we look for drivers in whichever of these paths
is found first:

* _/usr/share/virtio-win/virtio-win.iso_  
  .IX Item "/usr/share/virtio-win/virtio-win.iso"
  The \s-1ISO\s0 containing virtio drivers for Windows.
* _/usr/share/virtio-win_  
  .IX Item "/usr/share/virtio-win"
  The exploded tree of virtio drivers for Windows.  This is
  usually incomplete, hence the \s-1ISO\s0 is preferred.
.Sp
See Enabling virtio\*(R".

For other environment variables, see \s-1ENVIRONMENT VARIABLES\*(R"\s0 in **guestfs**\|(3).

<a name="other-tools"></a>

# Other Tools

.IX Header "OTHER TOOLS"

* **virt-v2v-copy-to-local**\|(1)  
  .IX Item "virt-v2v-copy-to-local"
  There are some special cases where virt-v2v cannot directly access the
  remote hypervisor.  In that case you have to use
  **virt-v2v-copy-to-local**\|(1) to make a local copy of the guest first,
  followed by running \f(CW`virt-v2v -i libvirtxml\*(C' to perform the
  conversion.
* **engine-image-uploader**\|(8)  
  .IX Item "engine-image-uploader"
  Variously called \f(CW`engine-image-uploader\*(C', \f(CW\*(C\`ovirt-image-uploader\*(C' or
  \f(CW`rhevm-image-uploader\*(C', this tool allows you to copy a guest from one
  oVirt or \s-1RHV\s0 Export Storage Domain to another.  It only permits
  importing a guest that was previously exported from another oVirt/RHV
  instance.
* import-to-ovirt.pl  
  .IX Item "import-to-ovirt.pl"
  This script can be used to import guests that already run on \s-1KVM\s0 to
  oVirt or \s-1RHV.\s0  For more information, see this blog posting by the
  author of virt-v2v:
  .Sp
  https://rwmj.wordpress.com/2015/09/18/importing-kvm-guests-to-ovirt-or-rhev/#content

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**virt-p2v**\|(1),
**virt-customize**\|(1),
**virt-df**\|(1),
**virt-filesystems**\|(1),
**virt-sparsify**\|(1),
**virt-sysprep**\|(1),
**guestfs**\|(3),
**guestfish**\|(1),
**qemu-img**\|(1),
**virt-v2v-copy-to-local**\|(1),
**virt-v2v-test-harness**\|(1),
**engine-image-uploader**\|(8),
import-to-ovirt.pl,
**nbdkit**\|(1),
**nbdkit-vddk-plugin**\|(1),
http://libguestfs.org/.

<a name="authors"></a>

# Authors

.IX Header "AUTHORS"
Matthew Booth

Cédric Bosdonnat

Tomáš Golembiovský

Shahar Havivi

Roman Kagan

Mike Latimer

Nir Soffer

Richard W.M. Jones

Pino Toscano

Tingting Zheng

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright (C) 2009-2020 Red Hat Inc.

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
