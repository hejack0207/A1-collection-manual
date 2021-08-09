# virt-install(1) - provision new virtual machines

"", ""

.nr rst2man-indent-level 0
.de1 rstReportMargin
\\$1 \\n[an-margin]
level \\n[rst2man-indent-level]
level margin: \\n[rst2man-indent\\n[rst2man-indent-level]]
-
\\n[rst2man-indent0]
\\n[rst2man-indent1]
\\n[rst2man-indent2]
..
.de1 INDENT


..

<a name="synopsis"></a>

# Synopsis

```

 virt-install [OPTION]...
```

<a name="description"></a>

# Description


**virt-install** is a command line tool for creating new KVM, Xen, or Linux
container guests using the **libvirt** hypervisor management library.
See the EXAMPLES section at the end of this document to quickly get started.

**virt-install** tool supports graphical installations using (for example)
VNC or SPICE, as well as text mode installs over serial console. The guest
can be configured to use one or more virtual disks, network interfaces,
audio devices, physical USB or PCI devices, among others.

The installation media can be local ISO or CDROM media, or a distro install
tree hosted remotely over HTTP, FTP, or in a local directory. In the install
tree case **virt-install** will fetch the minimal files
necessary to kick off the installation process, allowing the guest
to fetch the rest of the OS distribution as needed. PXE booting, and importing
an existing disk image (thus skipping the install phase) are also supported.

Given suitable command line arguments, **virt-install** is capable of running
completely unattended, with the guest 'kickstarting' itself too. This allows
for easy automation of guest installs. This can be done manually, or more
simply with the --unattended option.

Many arguments have sub options, specified like opt1=foo,opt2=bar, etc. Try
--option=? to see a complete list of sub options associated with that
argument, example: virt-install --disk=?

Most options are not required. If a suitable --os-variant value is specified
or detected, all defaults will be filled in and reported in the terminal
output. If an --os-variant is not specified. minimum required options, --memory,
guest storage (--disk or --filesystem), and an install method choice.

<a name="connecting-to-libvirt"></a>

# Connecting to Libvirt


<a name="fb-connectfp"></a>

### \fB\-\-connect\fP


**Syntax:** **--connect** URI

Connect to a non-default hypervisor. If this isn't specified, libvirt
will try and choose the most suitable default.

Some valid options here are:
.INDENT 0.0

* **qemu:///system**  
  For creating KVM and QEMU guests to be run by the system libvirtd instance.
  This is the default mode that virt-manager uses, and what most KVM users
  want.
* **qemu:///session**  
  For creating KVM and QEMU guests for libvirtd running as the regular user.
* **xen:///**  
  For connecting to Xen.
* **lxc:///**  
  For creating linux containers
  .UNINDENT

<a name="general-options"></a>

# General Options


General configuration parameters that apply to all types of guest installs.

<a name="fb-nfp-fb-namefp"></a>

### \fB\-n\fP, \fB\-\-name\fP


**Syntax:** **-n**, **--name** NAME

Name of the new guest virtual machine instance. This must be unique amongst
all guests known to the hypervisor on the connection, including those not
currently active. To re-define an existing guest, use the **virsh(1)** tool
to shut it down ('virsh shutdown') & delete ('virsh undefine') it prior to
running **virt-install**.

<a name="fb-memoryfp"></a>

### \fB\-\-memory\fP


**Syntax:** **--memory** OPTIONS

Memory to allocate for the guest, in MiB. This deprecates the -r/--ram option.
Sub options are available, like 'memory', 'currentMemory', 'maxMemory'
and 'maxMemory.slots', which all map to the identically named XML values.

Back compat values 'memory' maps to the &lt;currentMemory&gt; element, and maxmemory
maps to the &lt;memory&gt; element.

To configure memory modules which can be hotunplugged see **--memdev** description.

Use --memory=? to see a list of all available sub options.
Complete details at _https://libvirt.org/formatdomain.html#elementsMemoryAllocation_

<a name="fb-memorybackingfp"></a>

### \fB\-\-memorybacking\fP


**Syntax:** **--memorybacking** OPTIONS

This option will influence how virtual memory pages are backed by host pages.

Use --memorybacking=? to see a list of all available sub options.
Complete details at _https://libvirt.org/formatdomain.html#elementsMemoryBacking_

<a name="fb-archfp"></a>

### \fB\-\-arch\fP


**Syntax:** **--arch** ARCH

Request a non-native CPU architecture for the guest virtual machine.
If omitted, the host CPU architecture will be used in the guest.

<a name="fb-machinefp"></a>

### \fB\-\-machine\fP


**Syntax:** **--machine** MACHINE

The machine type to emulate. This will typically not need to be specified
for Xen or KVM, but is useful for choosing machine types of more exotic
architectures.

<a name="fb-metadatafp"></a>

### \fB\-\-metadata\fP


**Syntax:** **--metadata** OPT=VAL,[...]

Specify metadata values for the guest. Possible options include name, uuid,
title, and description. This option deprecates -u/--uuid and --description.

Use --metadata=? to see a list of all available sub options.
Complete details at _https://libvirt.org/formatdomain.html#elementsMetadata_

<a name="fb-eventsfp"></a>

### \fB\-\-events\fP


**Syntax:** **--events** OPT=VAL,[...]

Specify events values for the guest. Possible options include
on_poweroff, on_reboot, and on_crash.

Use --events=? to see a list of all available sub options.
Complete details at _https://libvirt.org/formatdomain.html#elementsEvents_

<a name="fb-resourcefp"></a>

### \fB\-\-resource\fP


**Syntax:** **--resource** OPT=VAL,[...]

Specify resource partitioning for the guest.

Use --resource=? to see a list of all available sub options.
Complete details at _https://libvirt.org/formatdomain.html#resPartition_

<a name="fb-sysinfofp"></a>

### \fB\-\-sysinfo\fP


**Syntax:** **--sysinfo** OPT=VAL,[...]

Configure sysinfo/SMBIOS values exposed to the VM OS. Examples:
.INDENT 0.0

* <b>**--sysinfo host**</b>  
  Special type that exposes the host's SMBIOS info into the VM.
* <b>**--sysinfo emulate**</b>  
  Special type where hypervisor will generate SMBIOS info into the VM.
* <b>**--sysinfo bios.vendor=custom** or **--sysinfo smbios,bios.vendor=custom**</b>  
  The default type is **smbios** and allows users to specify SMBIOS info manually.
  .UNINDENT

Use --sysinfo=? to see a list of all available sub options.

Complete details at _https://libvirt.org/formatdomain.html#elementsSysinfo_
and _https://libvirt.org/formatdomain.html#elementsOSBIOS_ for **smbios** XML element.

<a name="fb-xmlfp"></a>

### \fB\-\-xml\fP


**Syntax:** **--xml** ARGS

Make direct edits to the generated XML using XPath syntax. Take an example like
.INDENT 0.0
.INDENT 3.5

    .ft C
    virt-install --xml ./@foo=bar --xml ./newelement/subelement=1
    .ft P
.UNINDENT
.UNINDENT

This will alter the generated XML to contain:
.INDENT 0.0
.INDENT 3.5

    .ft C
    <domain foo='bar' ...>
      ...
      <newelement>
        <subelement>1</subelement>
      </newelement>
    </domain>
    .ft P
.UNINDENT
.UNINDENT

The --xml option has 4 sub options:
.INDENT 0.0

* **--xml xpath.set=XPATH[=VALUE]**  
  The default behavior if no explicit suboption is set. Takes the form XPATH=VALUE
  unless paired with **xpath.value** . See below for how value is interpreted.
* **--xml xpath.value=VALUE**  
  **xpath.set** will be interpreted only as the XPath string, and **xpath.value** will
  be used as the value to set. May help sidestep problems if the string you need to
  set contains a '=' equals sign.

If value is empty, it's treated as unsetting that particular node.

* **--xml xpath.create=XPATH**  
  Create the node as an empty element. Needed for boolean elements like &lt;readonly/&gt;
* **--xml xpath.delete=XPATH**  
  Delete the entire node specified by the xpath, and all its children
  .UNINDENT

<a name="fb-qemu-commandlinefp"></a>

### \fB\-\-qemu\-commandline\fP


**Syntax:** **--qemu-commandline** ARGS

Pass options directly to the qemu emulator. Only works for the libvirt
qemu driver. The option can take a string of arguments, for example:
.INDENT 0.0
.INDENT 3.5

    .ft C
    --qemu-commandline="-display gtk,gl=on"
    .ft P
.UNINDENT
.UNINDENT

Environment variables are specified with 'env', for example:
.INDENT 0.0
.INDENT 3.5

    .ft C
    --qemu-commandline=env=DISPLAY=:0.1
    .ft P
.UNINDENT
.UNINDENT

Complete details about the libvirt feature: _https://libvirt.org/drvqemu.html#qemucommand_

<a name="fb-vcpusfp"></a>

### \fB\-\-vcpus\fP


**Syntax:** **--vcpus** OPTIONS

Number of virtual cpus to configure for the guest. If 'maxvcpus' is specified,
the guest will be able to hotplug up to MAX vcpus while the guest is running,
but will startup with VCPUS.

CPU topology can additionally be specified with sockets, cores, and threads.
If values are omitted, the rest will be autofilled preferring sockets over
cores over threads.

'cpuset' sets which physical cpus the guest can use. **CPUSET** is a comma
separated list of numbers, which can also be specified in ranges or cpus
to exclude. Example:
.INDENT 0.0
.INDENT 3.5

    .ft C
    0,2,3,5     : Use processors 0,2,3 and 5
    1-5,^3,8    : Use processors 1,2,4,5 and 8
    .ft P
.UNINDENT
.UNINDENT

If the value 'auto' is passed, virt-install attempts to automatically determine
an optimal cpu pinning using NUMA data, if available.

Use --vcpus=? to see a list of all available sub options.
Complete details at _https://libvirt.org/formatdomain.html#elementsCPUAllocation_

<a name="fb-numatunefp"></a>

### \fB\-\-numatune\fP


**Syntax:** **--numatune** OPTIONS

Tune NUMA policy for the domain process. Example invocations
.INDENT 0.0
.INDENT 3.5

    .ft C
    --numatune 1,2,3,4-7
    --numatune 1-3,5,memory.mode=preferred
    .ft P
.UNINDENT
.UNINDENT

Specifies the numa nodes to allocate memory from. This has the same syntax
as **--vcpus cpuset=** option. mode can be one of 'interleave', 'preferred', or
'strict' (the default). See 'man 8 numactl' for information about each
mode.

Use --numatune=? to see a list of all available sub options.
Complete details at _https://libvirt.org/formatdomain.html#elementsNUMATuning_

<a name="fb-memtunefp"></a>

### \fB\-\-memtune\fP


**Syntax:** **--memtune** OPTIONS

Tune memory policy for the domain process. Example invocations
.INDENT 0.0
.INDENT 3.5

    .ft C
    --memtune 1000
    --memtune hard_limit=100,soft_limit=60,swap_hard_limit=150,min_guarantee=80
    .ft P
.UNINDENT
.UNINDENT

Use --memtune=? to see a list of all available sub options.
Complete details at _https://libvirt.org/formatdomain.html#elementsMemoryTuning_

<a name="fb-blkiotunefp"></a>

### \fB\-\-blkiotune\fP


**Syntax:** **--blkiotune** OPTIONS

Tune blkio policy for the domain process. Example invocations
.INDENT 0.0
.INDENT 3.5

    .ft C
    --blkiotune 100
    --blkiotune weight=100,device.path=/dev/sdc,device.weight=200
    .ft P
.UNINDENT
.UNINDENT

Use --blkiotune=? to see a list of all available sub options.
Complete details at _https://libvirt.org/formatdomain.html#elementsBlockTuning_

<a name="fb-cpufp"></a>

### \fB\-\-cpu\fP


**Syntax:** **--cpu** MODEL[,+feature][,-feature][,match=MATCH][,vendor=VENDOR],...

Configure the CPU model and CPU features exposed to the guest. The only
required value is MODEL, which is a valid CPU model as known to libvirt.

Libvirt's feature policy values force, require, optional, disable, or forbid,
or with the shorthand '+feature' and '-feature', which equal 'force=feature'
and 'disable=feature' respectively.

If exact CPU model is specified virt-install will automatically copy CPU
features available on the host to mitigate recent CPU speculative execution
side channel and Microarchitectural Store Buffer Data security vulnerabilities.
This however will have some impact on performance and will break migration
to hosts without security patches. In order to control this behavior there
is a **secure** parameter. Possible values are **on** and **off**, with **on**
as the default. It is highly recommended to leave this enabled and ensure all
virtualization hosts have fully up to date microcode, kernel & virtualization
software installed.

Some examples:
.INDENT 0.0

* <b>**--cpu core2duo,+x2apic,disable=vmx**</b>  
  Expose the core2duo CPU model, force enable x2apic, but do not expose vmx
* <b>**--cpu host**</b>  
  Expose the host CPUs configuration to the guest. This enables the guest to
  take advantage of many of the host CPUs features (better performance), but
  may cause issues if migrating the guest to a host without an identical CPU.
* <b>**--cpu numa.cell0.memory=1234,numa.cell0.cpus=0-3,numa.cell1.memory=5678,numa.cell1.cpus=4-7**</b>  
  Example of specifying two NUMA cells. This will generate XML like:
  .INDENT 7.0
  .INDENT 3.5

    .ft C
    <cpu>
      <numa>
        <cell cpus="0-3" memory="1234"/>
        <cell cpus="4-7" memory="5678"/>
      </numa>
    </cpu>
    .ft P
.UNINDENT
.UNINDENT

* <b>**--cpu host-passthrough,cache.mode=passthrough**</b>  
  Example of passing through the host cpu's cache information.
  .UNINDENT

Use --cpu=? to see a list of all available sub options.
Complete details at _https://libvirt.org/formatdomain.html#elementsCPU_

<a name="fb-cputunefp"></a>

### \fB\-\-cputune\fP


**Syntax:** **--cputune** OPTIONS

Tune CPU parameters for the guest.

Configure which of the host's physical CPUs the domain VCPU will be pinned to.
Example invocation
.INDENT 0.0
.INDENT 3.5

    .ft C
    --cputune vcpupin0.vcpu=0,vcpupin0.cpuset=0-3,vcpupin1.vcpu=1,vcpupin1.cpuset=4-7
    .ft P
.UNINDENT
.UNINDENT

Use --cputune=? to see a list of all available sub options.
Complete details at _https://libvirt.org/formatdomain.html#elementsCPUTuning_

<a name="fb-securityfp-fb-seclabelfp"></a>

### \fB\-\-security\fP, \fB\-\-seclabel\fP


**Syntax:** **--security**, **--seclabel** type=TYPE[,label=LABEL][,relabel=yes|no],...

Configure domain seclabel domain settings. Type can be either 'static' or
'dynamic'. 'static' configuration requires a security LABEL. Specifying
LABEL without TYPE implies static configuration.

Use --security=? to see a list of all available sub options.
Complete details at _https://libvirt.org/formatdomain.html#seclabel_

<a name="fb-keywrapfp"></a>

### \fB\-\-keywrap\fP


**Syntax:** **--keywrap** OPTIONS

Specify domain &lt;keywrap&gt; XML, used for S390 cryptographic key management operations.

Use --keywrap=? to see a list of all available sub options.
Complete details at _https://libvirt.org/formatdomain.html#keywrap_

<a name="fb-iothreadsfp"></a>

### \fB\-\-iothreads\fP


**Syntax:** **--iothreads** OPTIONS

Specify domain &lt;iothreads&gt; and/or &lt;iothreadids&gt; XML.
For example, to configure **&lt;iothreads&gt;4&lt;/iothreads&gt;**, use **--iothreads 4**

Use --iothreads=? to see a list of all available sub options.
Complete details at _https://libvirt.org/formatdomain.html#elementsIOThreadsAllocation_

<a name="fb-featuresfp"></a>

### \fB\-\-features\fP


**Syntax:** **--features** FEAT=on|off,...

Set elements in the guests &lt;features&gt; XML on or off. Examples include acpi,
apic, eoi, privnet, and hyperv features. Some examples:
.INDENT 0.0

* <b>**--features apic.eoi=on**</b>  
  Enable APIC PV EOI
* <b>**--features hyperv.vapic.state=on,hyperv.spinlocks.state=off**</b>  
  Enable hypver VAPIC, but disable spinlocks
* <b>**--features kvm.hidden.state=on**</b>  
  Allow the KVM hypervisor signature to be hidden from the guest
* <b>**--features pvspinlock=on**</b>  
  Notify the guest that the host supports paravirtual spinlocks for
  example by exposing the pvticketlocks mechanism.
* <b>**--features gic.version=2**</b>  
  This is relevant only for ARM architectures. Possible values are "host" or
  version number.
* <b>**--features smm.state=on**</b>  
  This enables System Management Mode of hypervisor. Some UEFI firmwares may
  require this feature to be present. (QEMU supports SMM only with q35 machine
  type.)
  .UNINDENT

Use --features=? to see a list of all available sub options.
Complete details at _https://libvirt.org/formatdomain.html#elementsFeatures_

<a name="fb-clockfp"></a>

### \fB\-\-clock\fP


**Syntax:** **--clock** offset=OFFSET,TIMER_OPT=VAL,...

Configure the guest's &lt;clock&gt; XML. Some supported options:
.INDENT 0.0

* <b>**--clock offset=OFFSET**</b>  
  Set the clock offset, ex. 'utc' or 'localtime'
* <b>**--clock TIMER\_present=no**</b>  
  Disable a boolean timer. TIMER here might be hpet, kvmclock, etc.
* <b>**--clock TIMER\_tickpolicy=VAL**</b>  
  Set a timer's tickpolicy value. TIMER here might be rtc, pit, etc. VAL
  might be catchup, delay, etc. Refer to the libvirt docs for all values.
  .UNINDENT

Use --clock=? to see a list of all available sub options.
Complete details at _https://libvirt.org/formatdomain.html#elementsTime_

<a name="fb-pmfp"></a>

### \fB\-\-pm\fP


**Syntax:** **--pm** OPTIONS

Configure guest power management features. Example:
.INDENT 0.0
.INDENT 3.5

    .ft C
    --pm suspend_to_memi.enabled=on,suspend_to_disk.enabled=off
    .ft P
.UNINDENT
.UNINDENT

Use --pm=? to see a list of all available sub options.
Complete details at _https://libvirt.org/formatdomain.html#elementsPowerManagement_

<a name="fb-launchsecurityfp"></a>

### \fB\-\-launchSecurity\fP


**Syntax:** **--launchSecurity** TYPE[,OPTS]

Enable launch security for the guest, e.g. AMD SEV. Example invocations:
.INDENT 0.0
.INDENT 3.5

    .ft C
    # This will use a default policy 0x03
    # No dhCert provided, so no data can be exchanged with the SEV firmware
    --launchSecurity sev
    
    # Explicit policy 0x01 - disables debugging, allows guest key sharing
    --launchSecurity sev,policy=0x01
    
    # Provide the session blob obtained from the SEV firmware
    # Provide dhCert to open a secure communication channel with SEV firmware
    --launchSecurity sev,session=BASE64SESSIONSTRING,dhCert=BASE64DHCERTSTRING
    .ft P
.UNINDENT
.UNINDENT

SEV has further implications on usage of virtio devices, so refer to EXAMPLES
section to see a full invocation of virt-install with --launchSecurity.

Use --launchSecurity=? to see a list of all available sub options. Complete
details at _https://libvirt.org/formatdomain.html#launchSecurity_

<a name="installation-options"></a>

# Installation Options


<a name="fb-cfp-fb-cdromfp"></a>

### \fB\-c\fP, \fB\-\-cdrom\fP


**Syntax:** **--cdrom** PATH

ISO file or CDROM device to use for VM install media. After install,
the the virtual CDROM device will remain attached to the VM, but with
the ISO or host path media ejected.

<a name="fb-lfp-fb-locationfp"></a>

### \fB\-l\fP, \fB\-\-location\fP


**Syntax:** **-l**, **--location** OPTIONS

Distribution tree installation source. virt-install can recognize
certain distribution trees and fetches a bootable kernel/initrd pair to
launch the install.

--location allows things like --extra-args for kernel arguments,
and using --initrd-inject. If you want to use those options with CDROM media,
you can pass the ISO to --location as well which works for some, but not
all, CDROM media.

The **LOCATION** can take one of the following forms:
.INDENT 0.0

* **_https://host/path_**  
  An HTTP server location containing an installable distribution image.
* **_ftp://host/path_**  
  An FTP server location containing an installable distribution image.
* **ISO**  
  Probe the ISO and extract files using 'isoinfo'
* **DIRECTORY**  
  Path to a local directory containing an installable distribution image.
  Note that the directory will not be accessible by the guest after initial
  boot, so the OS installer will need another way to access the rest of the
  install media.
  .UNINDENT

Some distro specific url samples:
.INDENT 0.0

* **Fedora/Red Hat Based**  
  _https://download.fedoraproject.org/pub/fedora/linux/releases/29/Server/x86\_64/os_
* **Debian**  
  _https://ftp.us.debian.org/debian/dists/stable/main/installer-amd64/_
* **Ubuntu**  
  _https://us.archive.ubuntu.com/ubuntu/dists/wily/main/installer-amd64/_
* **Suse**  
  _https://download.opensuse.org/pub/opensuse/distribution/leap/42.3/repo/oss/_
  .UNINDENT

Additionally, --location can take 'kernel' and 'initrd' sub options. These paths
relative to the specified location URL/ISO that allow selecting specific files
for kernel/initrd within the install tree. This can be useful if virt-install/
libosinfo doesn't know where to find the kernel in the specified --location.

For example, if you have an ISO that libosinfo doesn't know about called
my-unknown.iso, with a kernel at 'kernel/fookernel' and initrd at
'kernel/fooinitrd', you can make this work with:
.INDENT 0.0
.INDENT 3.5

    .ft C
    --location my-unknown.iso,kernel=kernel/fookernel,initrd=kernel/fooinitrd
    .ft P
.UNINDENT
.UNINDENT

<a name="fb-pxefp"></a>

### \fB\-\-pxe\fP


Install from PXE. This just tells the VM to boot off the network
for the first boot.

<a name="fb-importfp"></a>

### \fB\-\-import\fP


Skip the OS installation process, and build a guest around an existing
disk image. The device used for booting is the first device specified via
**--disk** or **--filesystem**.

<a name="fb-xfp-fb-extra-argsfp"></a>

### \fB\-x\fP, \fB\-\-extra\-args\fP


**Syntax:** **-x**, **--extra-args** KERNELARGS

Additional kernel command line arguments to pass to the installer when
performing a guest install from **--location**. One common usage is specifying
an anaconda kickstart file for automated installs, such as
--extra-args "ks=https://myserver/my.ks"

<a name="fb-initrd-injectfp"></a>

### \fB\-\-initrd\-inject\fP


**Syntax:** **--initrd-inject** PATH

Add PATH to the root of the initrd fetched with **--location**. This can be
used to run an automated install without requiring a network hosted kickstart
file: **--initrd-inject=/path/to/my.ks --extra-args "ks=file:/my.ks"**

<a name="fb-installfp"></a>

### \fB\-\-install\fP


This is a larger entry point for various types of install operations. The
command has multiple subarguments, similar to --disk and friends. This
option is strictly for VM install operations, essentially configuring the
first boot.

The simplest usage to ex: install fedora29 is:
.INDENT 0.0
.INDENT 3.5

    .ft C
    --install fedora29
    .ft P
.UNINDENT
.UNINDENT

And virt-install will fetch a --location URL from libosinfo, and populate
defaults from there.

Available suboptions:
.INDENT 0.0

* <b>**os=**</b>  
  This is os install option described above. The explicit way to specify that
  would be **--install os=fedora29** . os= is the default option if none is
  specified
* <b>**kernel=**, **initrd=**</b>  
  Specify a kernel and initrd pair to use as install media. They are copied
  into a temporary location before booting the VM, so they can be combined
  with --initrd-inject and your source media will not be altered. Media
  will be uploaded to a remote connection if required.

Example case using local filesystem paths:
**--install kernel=/path/to/kernel,initrd=/path/to/initrd**

Example using network paths. Kernel/initrd will be downloaded locally first,
then passed to the VM as local filesystem paths:
**--install kernel=https://127.0.0.1/tree/kernel,initrd=https://127.0.0.1/tree/initrd**

Note, these are just for install time booting. If you want to set the kernel
used for permanent VM booting, use the **--boot** option.

* <b>**kernel\_args=**, **kernel\_args\_overwrite=yes|no**</b>  
  Specify install time kernel arguments (libvirt &lt;cmdline&gt; XML). These can
  be combine with ex: kernel/initrd options, or **--location** media. By
  default, kernel_args is just like --extra-args, and will _append_ to
  the arguments that virt-install will try to set by default for most
  --location installs. If you want to override the virt-install default,
  additionally specify kernel_args_overwrite=yes
* <b>**bootdev=**</b>  
  Specify the install bootdev (hd, cdrom, floppy, network) to boot off of
  for the install phase. This maps to libvirt &lt;os&gt;&lt;boot dev=X&gt; XML.

If you want to install off a cdrom or network, it's probably simpler
and more backwards compatible to just use **--cdrom** or **--pxe** , but
this options gives fine grained control over the install process if
needed.

* <b>**no\_install=yes|no**</b>  
  Tell virt-install that there isn't actually any install happening,
  and you just want to create the VM. **--import** is just an alias
  for this, as is specifying **--boot** without any other install
  options. The deprecated **--live** option is the same as
  '--cdrom $ISO --install no_install=yes'
  .UNINDENT

<a name="fb-reinstall-domainfp"></a>

### \fB\-\-reinstall DOMAIN\fP


Reinstall an existing VM. DOMAIN can be a VM name, UUID, or ID number.
virt-install will fetch the domain XML from libvirt, apply the specified
install config changes, boot the VM for the install process, and then
revert to roughly the same starting XML.

Only install related options are processed, all other VM configuration
options like --name, --disk, etc. are completely ignored.

If --reinstall is used with --cdrom, an existing CDROM attached to
the VM will be used if one is available, otherwise a permanent CDROM
device will be added.

<a name="fb-unattendedfp"></a>

### \fB\-\-unattended\fP


**Syntax:** **--unattended** [OPTIONS]

Perform an unattended install using libosinfo's install script support.
This is essentially a database of auto install scripts for various
distros: Red Hat kickstarts, Debian installer scripting, Windows
unattended installs, and potentially others. The simplest invocation
is to combine it with --install like:
.INDENT 0.0
.INDENT 3.5

    .ft C
    --install fedora29 --unattended
    .ft P
.UNINDENT
.UNINDENT

A Windows install will look like
.INDENT 0.0
.INDENT 3.5

    .ft C
    --cdrom /path/to/my/windows.iso --unattended
    .ft P
.UNINDENT
.UNINDENT

Sub options are:
.INDENT 0.0

* <b>**profile=**</b>  
  Choose which libosinfo unattended profile to use. Most distros have
  a 'desktop' and a 'jeos' profile. virt-install will default to 'desktop'
  if this is unspecified.
* <b>**admin-password-file=**</b>  
  A file used to set the VM OS admin/root password from. This option can
  be used either as "admin-password-file=/path/to/password-file" or as
  "admin-password-file=/dev/fd/n", being n the file descriptor of the
  password-file.
  Note that only the first line of the file will be considered, including
  any whitespace characters and excluding new-line.
* <b>**user-login=**</b>  
  The user login name to be used in th VM. virt-install will default to your
  current host username if this is unspecified.
  Note that when running virt-install as "root", this option must be specified.
* <b>**user-password-file=**</b>  
  A file used to set the VM user password. This option can be used either as
  "user-password-file=/path/to/password-file" or as
  "user-password-file=/dev/fd/n", being n the file descriptor of the
  password-file. The username is either the user-login specified or your current
  host username.
  Note that only the first line of the file will be considered, including
  any whitespace characters and excluding new-line.
* <b>**product-key=**</b>  
  Set a Windows product key
  .UNINDENT

<a name="fb-cloud-initfp"></a>

### \fB\-\-cloud\-init\fP


Pass cloud-init metadata to the VM. A cloud-init NoCloud ISO file is generated,
and attached to the VM as a CDROM device. The device is only attached for the
first boot. This option is particularly useful for distro cloud images, which
have locked login accounts by default; --cloud-init provides the means to
initialize those login accounts, like setting a root password.

The simplest invocation is just plain **--cloud-init** with no suboptions;
this maps to **--cloud-init root-password-generate=on,disable=on**. See those
suboptions for explanation of how they work.

Use --cloud-init=? to see a list of all available sub options.

Sub options are:
.INDENT 0.0

* <b>**root-password-generate=on**</b>  
  Generate a new root password for the VM. When used, virt-install will
  print the generated password to the console, and pause for 10 seconds
  to give the user a chance to notice it and copy it.
* <b>**disable=on**</b>  
  Disable cloud-init in the VM for subsequent boots. Without this,
  cloud-init may reset auth on each boot.
* <b>**root-password-file=**</b>  
  A file used to set the VM root password from. This option can
  be used either as "root-password-file=/path/to/password-file" or as
  "root-password-file=/dev/fd/n", being n the file descriptor of the
  password-file.
  Note that only the first line of the file will be considered, including
  any whitespace characters and excluding new-line.
* <b>**meta-data=**</b>  
  Specify a cloud-init meta-data file to add directly to the iso. All other
  meta-data configuration options on the --cloud-init command line are ignored.
* <b>**user-data=**</b>  
  Specify a cloud-init user-data file to add directly to the iso. All other
  user-data configuration options on the --cloud-init command line are ignored.
* <b>**ssh-key=**</b>  
  Specify a public key to inject into the guest, providing ssh access to the
  unprivileged account. Example: ssh-key=/home/user/.ssh/id_rsa.pub
  .UNINDENT

<a name="fb-bootfp"></a>

### \fB\-\-boot\fP


**Syntax:** **--boot** BOOTOPTS

Optionally specify the post-install VM boot configuration. This option allows
specifying a boot device order, permanently booting off kernel/initrd with
option kernel arguments, and enabling a BIOS boot menu (requires libvirt
0.8.3 or later)

--boot can be specified in addition to other install options
(such as --location, --cdrom, etc.) or can be specified on its own. In
the latter case, behavior is similar to the --import install option: there
is no 'install' phase, the guest is just created and launched as specified.

Some examples:
.INDENT 0.0

* <b>**--boot cdrom,fd,hd,network**</b>  
  Set the boot device priority as first cdrom, first floppy, first harddisk,
  network PXE boot.
* <b>**--boot kernel=KERNEL,initrd=INITRD,kernel\_args="console=/dev/ttyS0"**</b>  
  Have guest permanently boot off a local kernel/initrd pair, with the
  specified kernel options.
* <b>**--boot kernel=KERNEL,initrd=INITRD,dtb=DTB**</b>  
  Have guest permanently boot off a local kernel/initrd pair with an
  external device tree binary. DTB can be required for some non-x86
  configurations like ARM or PPC
* <b>**--boot loader=BIOSPATH**</b>  
  Use BIOSPATH as the virtual machine BIOS.
* <b>**--boot bootmenu.enable=on,bios.useserial=on**</b>  
  Enable the bios boot menu, and enable sending bios text output over
  serial console.
* <b>**--boot init=INITPATH**</b>  
  Path to a binary that the container guest will init. If a root **--filesystem**
  has been specified, virt-install will default to /sbin/init, otherwise
  will default to /bin/sh.
* <b>**--boot uefi**</b>  
  Configure the VM to boot from UEFI. In order for virt-install to know the
  correct UEFI parameters, libvirt needs to be advertising known UEFI binaries
  via domcapabilities XML, so this will likely only work if using properly
  configured distro packages.
* <b>**--boot loader=/.../OVMF\_CODE.fd,loader.readonly=yes,loader.type=pflash,nvram.template=/.../OVMF\_VARS.fd,loader\_secure=no**</b>  
  Specify that the virtual machine use the custom OVMF binary as boot firmware,
  mapped as a virtual flash chip. In addition, request that libvirt instantiate
  the VM-specific UEFI varstore from the custom "/.../OVMF_VARS.fd" varstore
  template. This is the recommended UEFI setup, and should be used if
  --boot uefi doesn't know about your UEFI binaries. If your UEFI firmware
  supports Secure boot feature you can enable it via loader_secure.
  .UNINDENT

Use --boot=? to see a list of all available sub options.
Complete details at _https://libvirt.org/formatdomain.html#elementsOS_

<a name="fb-idmapfp"></a>

### \fB\-\-idmap\fP


**Syntax:** **--idmap** OPTIONS

If the guest configuration declares a UID or GID mapping,
the 'user' namespace will be enabled to apply these.
A suitably configured UID/GID mapping is a pre-requisite to
make containers secure, in the absence of sVirt confinement.

--idmap can be specified to enable user namespace for LXC containers. Example:
.INDENT 0.0
.INDENT 3.5

    .ft C
    --idmap uid.start=0,uid.target=1000,uid.count=10,gid.start=0,gid.target=1000,gid.count=10
    .ft P
.UNINDENT
.UNINDENT

Use --idmap=? to see a list of all available sub options.
Complete details at _https://libvirt.org/formatdomain.html#elementsOSContainer_

<a name="guest-os-options"></a>

# Guest Os Options


<a name="fb-os-variantfp-fb-osinfofp"></a>

### \fB\-\-os\-variant\fP, \fB\-\-osinfo\fP


**Syntax:** **--os-variant** [OS_VARIANT|OPT1=VAL1,...]

Optimize the guest configuration for a specific operating system (ex.
'fedora29', 'rhel7', 'win10'). While not required, specifying this
options is HIGHLY RECOMMENDED, as it can greatly increase performance
by specifying virtio among other guest tweaks.

The simplest usage is **--os-variant OS-NAME**, for example
**--os-variant fedora32**. **--os-variant** supports explicit suboption
syntax as well:
.INDENT 0.0

* <b>**name=**, **short-id=**</b>  
  The OS name/short-id from libosinfo. Examples: **fedora32**, **win10**
* <b>**id=**</b>  
  The full URL style libosinfo ID. For example, **name=win10** is
  the same as **id=http://microsoft.com/win/10**
* <b>**detect=on|off**</b>  
  Whether virt-install should attempt OS detection from the specified
  install media. Detection is presently only attempted for URL and
  CDROM installs, and is not 100% reliable.
* <b>**require=on|off**</b>  
  If **on**, virt-install errors if no OS value is set or detected.
  .UNINDENT

Some interesting examples:
.INDENT 0.0

* <b>**--os-variant detect=on,require=on**</b>  
  This tells virt-install to attempt detection from install media,
  but explicitly fail if that does not succeed. This will ensure
  your virt-install invocations don't fallback to a poorly performing
  config
* <b>**--os-variant detect=on,name=OSNAME**</b>  
  Attempt OS detection from install media, but if that fails, use
  OSNAME as a fallback.
  .UNINDENT

By default, virt-install will do **--os-variant detect=on,name=generic**,
using the detected OS if found, and falling back to the stub **generic**
value otherwise, and printing a warning.

If any manual **--os-variant** value is specified, the default is
all settings off or unset.

Use the command "osinfo-query os" to get the list of the accepted OS
variant names.

<a name="storage-options"></a>

# Storage Options


<a name="fb-diskfp"></a>

### \fB\-\-disk\fP


**Syntax:** **--disk** OPTIONS

Specifies media to use as storage for the guest, with various options. The
general format of a disk string is
.INDENT 0.0
.INDENT 3.5

    .ft C
    --disk opt1=val1,opt2=val2,...
    .ft P
.UNINDENT
.UNINDENT

The simplest invocation to create a new 10G disk image and associated disk device:
.INDENT 0.0
.INDENT 3.5

    .ft C
    --disk size=10
    .ft P
.UNINDENT
.UNINDENT

virt-install will generate a path name, and place it in the default image location for the hypervisor. To specify media, the command can either be:
.INDENT 0.0
.INDENT 3.5

    .ft C
    --disk /some/storage/path[,opt1=val1]...
    .ft P
.UNINDENT
.UNINDENT

or explicitly specify one of the following arguments:
.INDENT 0.0

* <b>**path**</b>  
  A path to some storage media to use, existing or not. Existing media can be
  a file or block device.

Specifying a non-existent path implies attempting to create the new storage,
and will require specifying a 'size' value. Even for remote hosts, virt-install
will try to use libvirt storage APIs to automatically create the given path.

If the hypervisor supports it, **path** can also be a network URL, like
_https://example.com/some-disk.img_ . For network paths, they hypervisor will
directly access the storage, nothing is downloaded locally.

* <b>**pool**</b>  
  An existing libvirt storage pool name to create new storage on. Requires
  specifying a 'size' value.
* <b>**vol**</b>  
  An existing libvirt storage volume to use. This is specified as
  'poolname/volname'.
  .UNINDENT

Options that apply to storage creation:
.INDENT 0.0

* <b>**size**</b>  
  size (in GiB) to use if creating new storage
* <b>**sparse**</b>  
  whether to skip fully allocating newly created storage. Value is 'yes' or
  'no'. Default is 'yes' (do not fully allocate) unless it isn't
  supported by the underlying storage type.

The initial time taken to fully-allocate the guest virtual disk (sparse=no)
will be usually balanced by faster install times inside the guest. Thus
use of this option is recommended to ensure consistently high performance
and to avoid I/O errors in the guest should the host filesystem fill up.

* <b>**format**</b>  
  Disk image format. For file volumes, this can be 'raw', 'qcow2', 'vmdk', etc.
  See format types in _https://libvirt.org/storage.html_ for possible values.
  This is often mapped to the **driver\_type** value as well.

If not specified when creating file images, this will default to 'qcow2'.

If creating storage, this will be the format of the new image.
If using an existing image, this overrides libvirt's format auto-detection.

* <b>**backing\_store**</b>  
  Path to a disk to use as the backing store for the newly created image.
* <b>**backing\_format**</b>  
  Disk image format of **backing\_store**
  .UNINDENT

Some example device configuration suboptions:
.INDENT 0.0

* <b>**device**</b>  
  Disk device type. Example values are be 'cdrom', 'disk', 'lun' or 'floppy'.
  The default is 'disk'.
* <b>**boot.order**</b>  
  Guest installation with multiple disks will need this parameter to boot
  correctly after being installed. A boot.order parameter will take values 1,2,3,...
  Devices with lower value has higher priority.
  This option applies to other bootable device types as well.
* <b>**target.bus** or *bus**</b>  
  Disk bus type. Example values are be 'ide', 'sata', 'scsi', 'usb', 'virtio' or 'xen'.
  The default is hypervisor dependent since not all hypervisors support all
  bus types.
* <b>**readonly**</b>  
  Set drive as readonly (takes 'on' or 'off')
* <b>**shareable**</b>  
  Set drive as shareable (takes 'on' or 'off')
* <b>**cache**</b>  
  The cache mode to be used. The host pagecache provides cache memory.
  The cache value can be 'none', 'writethrough', 'directsync', 'unsafe'
  or 'writeback'.
  'writethrough' provides read caching. 'writeback' provides
  read and write caching. 'directsync' bypasses the host page
  cache. 'unsafe' may cache all content and ignore flush requests from
  the guest.
* <b>**driver.discard**</b>  
  Whether discard (also known as "trim" or "unmap") requests are ignored
  or passed to the filesystem. The value can be either "unmap" (allow
  the discard request to be passed) or "ignore" (ignore the discard
  request). Since 1.0.6 (QEMU and KVM only)
* <b>**driver.name**</b>  
  Driver name the hypervisor should use when accessing the specified
  storage. Typically does not need to be set by the user.
* <b>**driver.type**</b>  
  Driver format/type the hypervisor should use when accessing the specified
  storage. Typically does not need to be set by the user.
* <b>**driver.io**</b>  
  Disk IO backend. Can be either "threads", "native" or "io_uring".
* <b>**driver.error\_policy**</b>  
  How guest should react if a write error is encountered. Can be one of
  "stop", "ignore", or "enospace"
* <b>**serial**</b>  
  Serial number of the emulated disk device. This is used in linux guests
  to set /dev/disk/by-id symlinks. An example serial number might be:
  WD-WMAP9A966149
* <b>**source.startupPolicy**</b>  
  It defines what to do with the disk if the source file is not accessible.
* <b>**snapshot**</b>  
  Defines default behavior of the disk during disk snapshots.
  .UNINDENT

See the examples section for some uses. This option deprecates -f/--file,
-s/--file-size, --nonsparse, and --nodisks.

Use --disk=? to see a list of all available sub options.
Complete details at _https://libvirt.org/formatdomain.html#elementsDisks_

<a name="fb-filesystemfp"></a>

### \fB\-\-filesystem\fP


Specifies a directory on the host to export to the guest. The most simple
invocation is:
.INDENT 0.0
.INDENT 3.5

    .ft C
    --filesystem /source/on/host,/target/point/in/guest
    .ft P
.UNINDENT
.UNINDENT

Which will work for recent QEMU and linux guest OS or LXC containers. For
QEMU, the target point is just a mounting hint in sysfs, so will not be
automatically mounted.

Some example suboptions:
.INDENT 0.0

* <b>**type**</b>  
  The type or the source directory. Valid values are 'mount' (the default) or
  'template' for OpenVZ templates.
* <b>**accessmode** or **mode**</b>  
  The access mode for the source directory from the guest OS. Only used with
  QEMU and type=mount. Valid modes are 'passthrough' (the default), 'mapped',
  or 'squash'. See libvirt domain XML documentation for more info.
* <b>**source**</b>  
  The directory on the host to share.
* <b>**target**</b>  
  The mount location to use in the guest.
  .UNINDENT

Use --filesystem=? to see a list of all available sub options.
Complete details at _https://libvirt.org/formatdomain.html#elementsFilesystems_

<a name="networking-options"></a>

# Networking Options


<a name="fb-wfp-fb-networkfp"></a>

### \fB\-w\fP, \fB\-\-network\fP


**Syntax:** **-w**, **--network** OPTIONS

Connect the guest to the host network. Examples for specifying the network type:
.INDENT 0.0

* <b>**bridge=BRIDGE**</b>  
  Connect to a bridge device in the host called **BRIDGE**. Use this option if
  the host has static networking config & the guest requires full outbound
  and inbound connectivity  to/from the LAN. Also use this if live migration
  will be used with this guest.
* <b>**network=NAME**</b>  
  Connect to a virtual network in the host called **NAME**. Virtual networks
  can be listed, created, deleted using the **virsh** command line tool. In
  an unmodified install of **libvirt** there is usually a virtual network
  with a name of **default**. Use a virtual network if the host has dynamic
  networking (eg NetworkManager), or using wireless. The guest will be
  NATed to the LAN by whichever connection is active.
* <b>**type=direct,source=IFACE[,source.mode=MODE]**</b>  
  Direct connect to host interface IFACE using macvtap.
* <b>**user**</b>  
  Connect to the LAN using SLIRP. Only use this if running a QEMU guest as
  an unprivileged user. This provides a very limited form of NAT.
* <b>**none**</b>  
  Tell virt-install not to add any default network interface.
  .UNINDENT

If **--network** is omitted a single NIC will be created in the guest. If
there is a bridge device in the host with a physical interface attached,
that will be used for connectivity. Failing that, the virtual network
called **default** will be used. This option can be specified multiple
times to setup more than one NIC.

Some example suboptions:
.INDENT 0.0

* <b>**model.type** or **model**</b>  
  Network device model as seen by the guest. Value can be any nic model supported
  by the hypervisor, e.g.: 'e1000', 'rtl8139', 'virtio', ...
* <b>**mac.address** or **mac**</b>  
  Fixed MAC address for the guest; If this parameter is omitted, or the value
  **RANDOM** is specified a suitable address will be randomly generated. For
  Xen virtual machines it is required that the first 3 pairs in the MAC address
  be the sequence '00:16:3e', while for QEMU or KVM virtual machines it must
  be '52:54:00'.
* <b>**filterref.filter**</b>  
  Controlling firewall and network filtering in libvirt. Value can be any nwfilter
  defined by the **virsh** 'nwfilter' subcommands. Available filters can be listed
  by running 'virsh nwfilter-list', e.g.: 'clean-traffic', 'no-mac-spoofing', ...
* <b>**virtualport.*** options</b>  
  Configure the device virtual port profile. This is used for 802.Qbg, 802.Qbh,
  midonet, and openvswitch config.

Use --network=? to see a list of all available sub options.
Complete details at _https://libvirt.org/formatdomain.html#elementsNICS_

This option deprecates -m/--mac, -b/--bridge, and --nonetworks
.UNINDENT

<a name="graphics-options"></a>

# Graphics Options


If no graphics option is specified, **virt-install** will try to select
the appropriate graphics if the DISPLAY environment variable is set,
otherwise '--graphics none' is used.

<a name="fb-graphicsfp"></a>

### \fB\-\-graphics\fP


**Syntax:** **--graphics** TYPE,opt1=arg1,opt2=arg2,...

Specifies the graphical display configuration. This does not configure any
virtual hardware, just how the guest's graphical display can be accessed.
Typically the user does not need to specify this option, virt-install will
try and choose a useful default, and launch a suitable connection.

General format of a graphical string is
.INDENT 0.0
.INDENT 3.5

    .ft C
    --graphics TYPE,opt1=arg1,opt2=arg2,...
    .ft P
.UNINDENT
.UNINDENT

For example:
.INDENT 0.0
.INDENT 3.5

    .ft C
    --graphics vnc,password=foobar
    .ft P
.UNINDENT
.UNINDENT

Some supported TYPE values:
.INDENT 0.0

* <b>**vnc**</b>  
  Setup a virtual console in the guest and export it as a VNC server in
  the host. Unless the **port** parameter is also provided, the VNC
  server will run on the first free port number at 5900 or above. The
  actual VNC display allocated can be obtained using the **vncdisplay**
  command to **virsh** (or virt-viewer(1) can be used which handles this
  detail for the use).
* <b>**spice**</b>  
  Export the guest's console using the Spice protocol. Spice allows advanced
  features like audio and USB device streaming, as well as improved graphical
  performance.

Using spice graphic type will work as if those arguments were given:
.INDENT 7.0
.INDENT 3.5

    .ft C
    --video qxl --channel spicevmc
    .ft P
.UNINDENT
.UNINDENT

* <b>**none**</b>  
  No graphical console will be allocated for the guest. Guests will likely
  need to have a text console configured on the first
  serial port in the guest (this can be done via the --extra-args option). The
  command 'virsh console NAME' can be used to connect to the serial device.
  .UNINDENT

Some supported suboptions:
.INDENT 0.0

* <b>**port**</b>  
  Request a permanent, statically assigned port number for the guest
  console. This is used by 'vnc' and 'spice'
* <b>**tlsPort**</b>  
  Specify the spice tlsport.
* <b>**websocket**</b>  
  Request a VNC WebSocket port for the guest console.

If -1 is specified, the WebSocket port is auto-allocated.

This is used by 'vnc' and 'spice'

* <b>**listen**</b>  
  Address to listen on for VNC/Spice connections. Default is typically 127.0.0.1
  (localhost only), but some hypervisors allow changing this globally (for
  example, the qemu driver default can be changed in /etc/libvirt/qemu.conf).
  Use 0.0.0.0 to allow access from other machines.

Use 'none' to specify that the display server should not listen on any
port. The display server can be accessed only locally through
libvirt unix socket (virt-viewer with --attach for instance).

Use 'socket' to have the VM listen on a libvirt generated unix socket
path on the host filesystem.

This is used by 'vnc' and 'spice'

* <b>**password**</b>  
  Request a console password, required at connection time. Beware, this info may
  end up in virt-install log files, so don't use an important password. This
  is used by 'vnc' and 'spice'
* <b>**gl.enable**</b>  
  Whether to use OpenGL accelerated rendering. Value is 'yes' or 'no'. This is
  used by 'spice'.
* <b>**gl.rendernode**</b>  
  DRM render node path to use. This is used when 'gl' is enabled.
  .UNINDENT

Use --graphics=? to see a list of all available sub options.
Complete details at _https://libvirt.org/formatdomain.html#elementsGraphics_

This deprecates the following options:
--vnc, --vncport, --vnclisten, -k/--keymap, --sdl, --nographics

<a name="fb-autoconsolefp"></a>

### \fB\-\-autoconsole\fP


**Syntax:** **--autoconsole** OPTIONS

Configure what interactive console virt-install will launch for the VM. This
option is not required; the default behavior is adaptive and dependent on
how the VM is configured. But you can use this option to override the default
choice.
.INDENT 0.0

* <b>**--autoconsole graphical**</b>  
  Use the graphical virt-viewer(1) as the interactive console
* <b>**--autoconsole text**</b>  
  Use the text mode **virsh console** as the interactive console.
* <b>**--autoconsole none**</b>  
  This is the same as **--noautoconsole**
* <b>**--noautoconsole**</b>  
  Don't automatically try to connect to the guest console. Same as
  **--autoconsole none**
  .UNINDENT

Note, virt-install exits quickly when this option is specified. If your
command requested a multistep install, like --cdrom or --location, after
the install phase is complete the VM will be shutoff, regardless of
whether a reboot was requested in the VM. If you want the VM to be
rebooted, virt-install must remain running. You can use '--wait' to keep
virt-install alive even if --noautoconsole is specified.

<a name="virtualization-options"></a>

# Virtualization Options


Options to override the default virtualization type choices.

<a name="fb-vfp-fb-hvmfp"></a>

### \fB\-v\fP, \fB\-\-hvm\fP


Request the use of full virtualization, if both para & full virtualization are
available on the host. This parameter may not be available if connecting to a
Xen hypervisor on a machine without hardware virtualization support. This
parameter is implied if connecting to a QEMU based hypervisor.

<a name="fb-pfp-fb-paravirtfp"></a>

### \fB\-p\fP, \fB\-\-paravirt\fP


This guest should be a paravirtualized guest. If the host supports both
para & full virtualization, and neither this parameter nor the **--hvm**
are specified, this will be assumed.

<a name="fb-containerfp"></a>

### \fB\-\-container\fP


This guest should be a container type guest. This option is only required
if the hypervisor supports other guest types as well (so for example this
option is the default behavior for LXC and OpenVZ, but is provided for
completeness).

<a name="fb-virt-typefp"></a>

### \fB\-\-virt\-type\fP


The hypervisor to install on. Example choices are kvm, qemu, or xen.
Available options are listed via 'virsh capabilities' in the &lt;domain&gt; tags.

This deprecates the --accelerate option, which is now the default behavior.
To install a plain QEMU guest, use '--virt-type qemu'

<a name="device-options"></a>

# Device Options


All devices have a set of **address.*** options for configuring the
particulars of the device's address on its parent controller or bus.
See **https://libvirt.org/formatdomain.html#elementsAddress** for details.

<a name="fb-controllerfp"></a>

### \fB\-\-controller\fP


**Syntax:** **--controller** OPTIONS

Attach a controller device to the guest. TYPE is one of:
**ide**, **fdc**, **scsi**, **sata**, **virtio-serial**, or **usb** .

Controller also supports the special values **usb2** and **usb3** to
specify which version of the USB controller should be used (version 2
or 3).

Some example suboptions:
.INDENT 0.0

* <b>**model**</b>  
  Controller model.  These may vary according to the hypervisor and its
  version.  Most commonly used models are e.g. **auto** , **virtio-scsi**
  for the **scsi** controller, **ehci** or **none\`\`for the \`\`usb**
  controller.
  .UNINDENT

Use --controller=? to see a list of all available sub options.
Complete details at _https://libvirt.org/formatdomain.html#elementsControllers_

<a name="fb-inputfp"></a>

### \fB\-\-input\fP


**Syntax:** **--input** OPTIONS

Attach an input device to the guest. Example input device types are mouse, tablet, or keyboard.

Use --input=? to see a list of all available sub options.
Complete details at _https://libvirt.org/formatdomain.html#elementsInput_

<a name="fb-hostdevfp-fb-host-devicefp"></a>

### \fB\-\-hostdev\fP, \fB\-\-host\-device\fP


**Syntax:** **--hostdev**, **--host-device** OPTIONS

Attach a physical host device to the guest. Some example values for HOSTDEV:
.INDENT 0.0

* <b>**--hostdev pci\_0000\_00\_1b\_0**</b>  
  A node device name via libvirt, as shown by 'virsh nodedev-list'
* <b>**--hostdev 001.003**</b>  
  USB by bus, device (via lsusb).
* <b>**--hostdev 0x1234:0x5678**</b>  
  USB by vendor, product (via lsusb).
* <b>**--hostdev 1f.01.02**</b>  
  PCI device (via lspci).
* <b>**--hostdev wlan0,type=net**</b>  
  Network device (in LXC container).
* <b>**--hostdev /dev/net/tun,type=misc**</b>  
  Character device (in LXC container).
* <b>**--hostdev /dev/sdf,type=storage**</b>  
  Block device (in LXC container).
  .UNINDENT

Use --hostdev=? to see a list of all available sub options.
Complete details at _https://libvirt.org/formatdomain.html#elementsHostDev_

<a name="fb-soundfp"></a>

### \fB\-\-sound\fP


**Syntax:** **--sound** MODEL

Attach a virtual audio device to the guest. MODEL specifies the emulated
sound card model. Possible values are ich6, ich9, ac97, es1370, sb16, pcspk,
or default. 'default' will try to pick the best model that the specified
OS supports.

This deprecates the old --soundhw option.
Use --sound=? to see a list of all available sub options.
Complete details at _https://libvirt.org/formatdomain.html#elementsSound_

<a name="fb-watchdogfp"></a>

### \fB\-\-watchdog\fP


**Syntax:** **--watchdog** MODEL[,action=ACTION]

Attach a virtual hardware watchdog device to the guest. This requires a
daemon and device driver in the guest. The watchdog fires a signal when
the virtual machine appears to hung. ACTION specifies what libvirt will do
when the watchdog fires. Values are
.INDENT 0.0

* <b>**reset**</b>  
  Forcefully reset the guest (the default)
* <b>**poweroff**</b>  
  Forcefully power off the guest
* <b>**pause**</b>  
  Pause the guest
* <b>**none**</b>  
  Do nothing
* <b>**shutdown**</b>  
  Gracefully shutdown the guest (not recommended, since a hung guest probably
  won't respond to a graceful shutdown)
  .UNINDENT

MODEL is the emulated device model: either i6300esb (the default) or ib700.
Some examples:
.INDENT 0.0

* <b>**--watchdog default**</b>  
  Use the recommended settings
* <b>**--watchdog i6300esb,action=poweroff**</b>  
  Use the i6300esb with the 'poweroff' action
  .UNINDENT

Use --watchdog=? to see a list of all available sub options.
Complete details at _https://libvirt.org/formatdomain.html#elementsWatchdog_

<a name="fb-serialfp"></a>

### \fB\-\-serial\fP


**Syntax:** **--serial** OPTIONS

Specifies a serial device to attach to the guest, with various options. The
general format of a serial string is
.INDENT 0.0
.INDENT 3.5

    .ft C
    --serial type,opt1=val1,opt2=val2,...
    .ft P
.UNINDENT
.UNINDENT

--serial and --parallel devices share all the same options, unless otherwise
noted. Some of the types of character device redirection are:
.INDENT 0.0

* <b>**--serial pty**</b>  
  Pseudo TTY. The allocated pty will be listed in the running guests XML
  description.
* <b>**--serial dev,path=HOSTPATH**</b>  
  Host device. For serial devices, this could be /dev/ttyS0. For parallel
  devices, this could be /dev/parport0.
* <b>**--serial file,path=FILENAME**</b>  
  Write output to FILENAME.
* <b>**--serial tcp,host=HOST:PORT,source.mode=MODE,protocol.type=PROTOCOL**</b>  
  TCP net console. MODE is either 'bind' (wait for connections on HOST:PORT)
  or 'connect' (send output to HOST:PORT), default is 'bind'. HOST defaults
  to '127.0.0.1', but PORT is required. PROTOCOL can be either 'raw' or 'telnet'
  (default 'raw'). If 'telnet', the port acts like a telnet server or client.
  Some examples:

Wait for connections on any address, port 4567:

--serial tcp,host=0.0.0.0:4567

Connect to localhost, port 1234:

--serial tcp,host=:1234,source.mode=connect

Wait for telnet connection on localhost, port 2222. The user could then
connect interactively to this console via 'telnet localhost 2222':

--serial tcp,host=:2222,source.mode=bind,source.protocol=telnet

* <b>**--serial udp,host=CONNECT\_HOST:PORT,bind\_host=BIND\_HOST:BIND\_PORT**</b>  
  UDP net console. HOST:PORT is the destination to send output to (default
  HOST is '127.0.0.1', PORT is required). BIND_HOST:BIND_PORT is the optional
  local address to bind to (default BIND_HOST is 127.0.0.1, but is only set if
  BIND_PORT is specified). Some examples:

Send output to default syslog port (may need to edit /etc/rsyslog.conf
accordingly):

--serial udp,host=:514

Send output to remote host 192.168.10.20, port 4444 (this output can be
read on the remote host using 'nc -u -l 4444'):

--serial udp,host=192.168.10.20:4444

* <b>**--serial unix,path=UNIXPATH,mode=MODE**</b>  
  Unix socket, see unix(7). MODE has similar behavior and defaults as
  --serial tcp,mode=MODE
  .UNINDENT

Use --serial=? to see a list of all available sub options.
Complete details at _https://libvirt.org/formatdomain.html#elementsCharSerial_

<a name="fb-parallelfp"></a>

### \fB\-\-parallel\fP


**Syntax:** **--parallel** OPTIONS

Specify a parallel device. The format and options are largely identical
to **serial**

Use --parallel=? to see a list of all available sub options.
Complete details at _https://libvirt.org/formatdomain.html#elementsCharParallel_

<a name="fb-channelfp"></a>

### \fB\-\-channel\fP


Specifies a communication channel device to connect the guest and host
machine. This option uses the same options as --serial and --parallel
for specifying the host/source end of the channel. Extra 'target' options
are used to specify how the guest machine sees the channel.

Some of the types of character device redirection are:
.INDENT 0.0

* <b>**--channel SOURCE,target.type=guestfwd,target.address=HOST:PORT**</b>  
  Communication channel using QEMU usermode networking stack. The guest can
  connect to the channel using the specified HOST:PORT combination.
* <b>**--channel SOURCE,target.type=virtio[,target.name=NAME]**</b>  
  Communication channel using virtio serial (requires 2.6.34 or later host and
  guest). Each instance of a virtio --channel line is exposed in the
  guest as /dev/vport0p1, /dev/vport0p2, etc. NAME is optional metadata, and
  can be any string, such as org.linux-kvm.virtioport1.
  If specified, this will be exposed in the guest at
  /sys/class/virtio-ports/vport0p1/NAME
* <b>**--channel spicevmc,target.type=virtio[,target.name=NAME]**</b>  
  Communication channel for QEMU spice agent, using virtio serial
  (requires 2.6.34 or later host and guest). NAME is optional metadata,
  and can be any string, such as the default com.redhat.spice.0 that
  specifies how the guest will see the channel.
  .UNINDENT

Use --channel=? to see a list of all available sub options.
Complete details at _https://libvirt.org/formatdomain.html#elementsCharChannel_

<a name="fb-consolefp"></a>

### \fB\-\-console\fP


Connect a text console between the guest and host. Certain guest and
hypervisor combinations can automatically set up a getty in the guest, so
an out of the box text login can be provided (target_type=xen for xen
paravirt guests, and possibly target_type=virtio in the future).

Example:
.INDENT 0.0

* <b>**--console pty,target.type=virtio**</b>  
  Connect a virtio console to the guest, redirected to a PTY on the host.
  For supported guests, this exposes /dev/hvc0 in the guest. See
  _https://fedoraproject.org/wiki/Features/VirtioSerial_ for more info. virtio
  console requires libvirt 0.8.3 or later.
  .UNINDENT

Use --console=? to see a list of all available sub options.
Complete details at _https://libvirt.org/formatdomain.html#elementsCharConsole_

<a name="fb-videofp"></a>

### \fB\-\-video\fP


**Syntax:** **--video** OPTIONS

Specify what video device model will be attached to the guest. Valid values
for VIDEO are hypervisor specific, but some options for recent kvm are
cirrus, vga, qxl, virtio, or vmvga (vmware).
Use --video=? to see a list of all available sub options.
Complete details at _https://libvirt.org/formatdomain.html#elementsVideo_

<a name="fb-smartcardfp"></a>

### \fB\-\-smartcard\fP


**Syntax:** **--smartcard** MODE[,OPTIONS]

Configure a virtual smartcard device.

Example MODE values are **host**, **host-certificates**, or **passthrough**.
Example suboptions include:
.INDENT 0.0

* <b>**type**</b>  
  Character device type to connect to on the host. This is only applicable
  for **passthrough** mode.
  .UNINDENT

An example invocation:
.INDENT 0.0

* <b>**--smartcard passthrough,type=spicevmc**</b>  
  Use the smartcard channel of a SPICE graphics device to pass smartcard info
  to the guest
  .UNINDENT

Use --smartcard=? to see a list of all available sub options.
Complete details at _https://libvirt.org/formatdomain.html#elementsSmartcard_

<a name="fb-redirdevfp"></a>

### \fB\-\-redirdev\fP


**Syntax:** **--redirdev** BUS[,OPTIONS]

Add a redirected device. Example suboptions:
.INDENT 0.0

* <b>**type**</b>  
  The redirection type, currently supported is **tcp** or **spicevmc** .
* <b>**server**</b>  
  The TCP server connection details, of the form 'server:port'.
  .UNINDENT

Examples invocations:
.INDENT 0.0

* <b>**--redirdev usb,type=tcp,server=localhost:4000**</b>  
  Add a USB redirected device provided by the TCP server on 'localhost'
  port 4000.
* <b>**--redirdev usb,type=spicevmc**</b>  
  Add a USB device redirected via a dedicated Spice channel.
  .UNINDENT

Use --redirdev=? to see a list of all available sub options.
Complete details at _https://libvirt.org/formatdomain.html#elementsRedir_

<a name="fb-memballoonfp"></a>

### \fB\-\-memballoon\fP


**Syntax:** **--memballoon** MODEL[,OPTIONS]

Attach a virtual memory balloon device to the guest. If the memballoon device
needs to be explicitly disabled, MODEL='none' is used.

MODEL is the type of memballoon device provided. The value can be 'virtio',
'xen' or 'none'. Some examples:
.INDENT 0.0

* <b>**--memballoon virtio**</b>  
  Explicitly create a 'virtio' memballoon device
* <b>**--memballoon none**</b>  
  Disable the memballoon device
  .UNINDENT

Use --memballoon=? to see a list of all available sub options.
Complete details at _https://libvirt.org/formatdomain.html#elementsMemBalloon_

<a name="fb-tpmfp"></a>

### \fB\-\-tpm\fP


**Syntax:** **--tpm** TYPE[,OPTIONS]

Configure a virtual TPM device. Examples:
.INDENT 0.0

* <b>**--tpm /dev/tpm**</b>  
  Convenience option for passing through the hosts TPM.
* <b>**--tpm emulator**</b>  
  Request an emulated TPM device.
  .UNINDENT

Use --tpm=? to see a list of all available sub options.
Complete details at _https://libvirt.org/formatdomain.html#elementsTpm_

<a name="fb-rngfp"></a>

### \fB\-\-rng\fP


**Syntax:** **--rng** TYPE[,OPTIONS]

Configure a virtual RNG device.

Example TYPE values include **random**, **egd** or **builtin**.

Example invocations:
.INDENT 0.0

* <b>**--rng /dev/urandom**</b>  
  Use the /dev/urandom device to get entropy data, this form implicitly uses the
  "random" model.
* <b>**--rng builtin**</b>  
  Use the builtin rng device to get entropy data.
* <b>**--rng egd,backend.source.host=localhost,backend.source.service=8000,backend.type=tcp**</b>  
  Connect to localhost to the TCP port 8000 to get entropy data.
  .UNINDENT

Use --rng=? to see a list of all available sub options.
Complete details at _https://libvirt.org/formatdomain.html#elementsRng_

<a name="fb-panicfp"></a>

### \fB\-\-panic\fP


**Syntax:** **--panic** MODEL[,OPTS]

Attach a panic notifier device to the guest.
For the recommended settings, use: **--panic default**

Use --panic=? to see a list of all available sub options.
Complete details at _https://libvirt.org/formatdomain.html#elementsPanic_

<a name="fb-memdevfp"></a>

### \fB\-\-memdev\fP


**Syntax:** **--memdev** OPTS

Add a memory module to a guest which can be hotunplugged. To add a memdev you need
to configure hotplugmemory and NUMA for a guest.

Use --memdev=? to see a list of all available sub options.
Complete details at _https://libvirt.org/formatdomain.html#elementsMemory_.

<a name="fb-vsockfp"></a>

### \fB\-\-vsock\fP


**Syntax:** **--vsock** OPTS

Configure a vsock host/guest interface. A typical configuration would be
.INDENT 0.0
.INDENT 3.5

    .ft C
    --vsock cid.auto=yes
    .ft P
.UNINDENT
.UNINDENT

Use --vsock=? to see a list of all available sub options.
Complete details at _https://libvirt.org/formatdomain.html#vsock_.

<a name="fb-iommufp"></a>

### \fB\-\-iommu\fP


**Syntax:** **--iommu** MODEL[,OPTS]

Add an IOMMU device to the guest.

Use --iommu=? to see a list of all available options.
Complete details at _https://libvirt.org/formatdomain.html#elementsIommu_.

<a name="miscellaneous-options"></a>

# Miscellaneous Options


<a name="fb-hfp-fb-helpfp"></a>

### \fB\-h\fP, \fB\-\-help\fP


Show the help message and exit

<a name="fb-versionfp"></a>

### \fB\-\-version\fP


Show program's version number and exit

<a name="fb-autostartfp"></a>

### \fB\-\-autostart\fP


Set the autostart flag for a domain. This causes the domain to be started
on host boot up.

<a name="fb-transientfp"></a>

### \fB\-\-transient\fP


Use --import or --boot and --transient if you want a transient libvirt
VM.  These VMs exist only until the domain is shut down or the host
server is restarted.  Libvirt forgets the XML configuration of the VM
after either of these events.  Note that the VM's disks will not be
deleted.  See:
_https://wiki.libvirt.org/page/VM\_lifecycle#Transient\_guest\_domains\_vs\_Persistent\_guest\_domains_

<a name="fb-destroy-on-exitfp"></a>

### \fB\-\-destroy\-on\-exit\fP


When the VM console window is exited, destroy (force poweroff) the VM.
If you combine this with --transient, this makes the virt-install command
work similar to qemu, where the VM is shutdown when the console window
is closed by the user.

<a name="fb-print-xmlfp"></a>

### \fB\-\-print\-xml\fP


**Syntax:** **--print-xml** [STEP]

Print the generated XML of the guest, instead of defining it. By default this
WILL do storage creation (can be disabled with --dry-run). This option implies --quiet.

If the VM install has multiple phases, by default this will print all
generated XML. If you want to print a particular step, use --print-xml 2
(for the second phase XML).

<a name="fb-norebootfp"></a>

### \fB\-\-noreboot\fP


Prevent the domain from automatically rebooting after the install has
completed.

<a name="fb-waitfp"></a>

### \fB\-\-wait\fP


**Syntax:** **--wait** WAIT

Configure how virt-install will wait for the install to complete.
Without this option, virt-install will wait for the console to close (not
necessarily indicating the guest has shutdown), or in the case of
--noautoconsole, simply kick off the install and exit.

Bare '--wait' or any negative value will make virt-install wait indefinitely.
Any positive number is the number of minutes virt-install will wait. If the
time limit is exceeded, virt-install simply exits, leaving the virtual machine
in its current state.

<a name="fb-dry-runfp"></a>

### \fB\-\-dry\-run\fP


Proceed through the guest creation process, but do NOT create storage devices,
change host device configuration, or actually teach libvirt about the guest.
virt-install may still fetch install media, since this is required to
properly detect the OS to install.

<a name="fb-checkfp"></a>

### \fB\-\-check\fP


Enable or disable some validation checks. Some examples are warning about using a disk that's already assigned to another VM (--check path_in_use=on|off), or warning about potentially running out of space during disk allocation (--check disk_size=on|off). Most checks are performed by default.

<a name="fb-qfp-fb-quietfp"></a>

### \fB\-q\fP, \fB\-\-quiet\fP


Only print fatal error messages.

<a name="fb-dfp-fb-debugfp"></a>

### \fB\-d\fP, \fB\-\-debug\fP


Print debugging information to the terminal when running the install process.
The debugging information is also stored in
**~/.cache/virt-manager/virt-install.log** even if this parameter is omitted.

<a name="examples"></a>

# Examples


The simplest invocation to interactively install a Fedora 29 KVM VM
with recommended defaults. virt-viewer(1) will be launched to
graphically interact with the VM install
.INDENT 0.0
.INDENT 3.5

    .ft C
    # sudo virt-install --install fedora29
    .ft P
.UNINDENT
.UNINDENT

Similar, but use libosinfo's unattended install support, which will
perform the fedora29 install automatically without user intervention:
.INDENT 0.0
.INDENT 3.5

    .ft C
    # sudo virt-install --install fedora29 --unattended
    .ft P
.UNINDENT
.UNINDENT

Install a Windows 10 VM, using 40GiB storage in the default location
and 4096MiB of ram, and ensure we are connecting to the system libvirtd
instance:
.INDENT 0.0
.INDENT 3.5

    .ft C
    # virt-install e
       --connect qemu:///system e
       --name my-win10-vm e
       --memory 4096 e
       --disk size=40 e
       --os-variant win10 e
       --cdrom /path/to/my/win10.iso
    .ft P
.UNINDENT
.UNINDENT

Install a CentOS 7 KVM from a URL, with recommended device defaults and
default required storage, but specifically request VNC graphics instead
of the default SPICE, and request 8 virtual CPUs and 8192 MiB of memory:
.INDENT 0.0
.INDENT 3.5

    .ft C
    # virt-install e
        --connect qemu:///system e
        --memory 8192 e
        --vcpus 8 e
        --graphics vnc e
        --os-variant centos7.0 e
        --location http://mirror.centos.org/centos-7/7/os/x86_64/
    .ft P
.UNINDENT
.UNINDENT

Create a VM around an existing debian9 disk image:
.INDENT 0.0
.INDENT 3.5

    .ft C
    # virt-install e
        --import e
        --memory 512 e
        --disk /home/user/VMs/my-debian9.img e
        --os-variant debian9
    .ft P
.UNINDENT
.UNINDENT

Start serial QEMU ARM VM, which requires specifying a manual kernel.
.INDENT 0.0
.INDENT 3.5

    .ft C
    # virt-install e
        --name armtest e
        --memory 1024 e
        --arch armv7l --machine vexpress-a9 e
        --disk /home/user/VMs/myarmdisk.img e
        --boot kernel=/tmp/my-arm-kernel,initrd=/tmp/my-arm-initrd,dtb=/tmp/my-arm-dtb,kernel_args="console=ttyAMA0 rw root=/dev/mmcblk0p3" e
        --graphics none
    .ft P
.UNINDENT
.UNINDENT

Start an SEV launch security VM with 4GB RAM, 4GB+256MiB of hard_limit, with a
couple of virtio devices:

Note: The IOMMU flag needs to be turned on with driver.iommu for virtio
devices. Usage of --memtune is currently required because of SEV limitations,
refer to libvirt docs for a detailed explanation.
.INDENT 0.0
.INDENT 3.5

    .ft C
    # virt-install e
        --name foo e
        --memory 4096 e
        --boot uefi e
        --machine q35 e
        --memtune hard_limit=4563402 e
        --disk size=15,target.bus=scsi e
        --import e
        --controller type=scsi,model=virtio-scsi,driver.iommu=on e
        --controller type=virtio-serial,driver.iommu=on e
        --network network=default,model=virtio,driver.iommu=on e
        --rng /dev/random,driver.iommu=on e
        --memballoon driver.iommu=on e
        --launchSecurity sev
    .ft P
.UNINDENT
.UNINDENT

<a name="bugs"></a>

# Bugs


Please see _https://virt-manager.org/bugs_

<a name="copyright"></a>

# Copyright


Copyright (C) Red Hat, Inc, and various contributors.
This is free software. You may redistribute copies of it under the terms of
the GNU General Public License _https://www.gnu.org/licenses/gpl.html_. There
is NO WARRANTY, to the extent permitted by law.

<a name="see-also"></a>

# See Also


**virsh(1)**, **virt-clone(1)**, **virt-manager(1)**, the project website _https://virt-manager.org_

