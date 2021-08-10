# dracut\&.cmdline(7)

dracut 1507b65, 09/29/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

dracut.cmdline - dracut kernel command line options

<a name="description"></a>

# Description


The root device used by the kernel is specified in the boot configuration file on the kernel command line, as always.

The traditional _root=/dev/sda1_ style device specification is allowed, but not encouraged. The root device should better be identified by LABEL or UUID. If a label is used, as in _root=LABEL=&lt;label\_of\_root&gt;_ the initramfs will search all available devices for a filesystem with the appropriate label, and mount that device as the root filesystem. _root=UUID=&lt;uuidnumber&gt;_ will mount the partition with that UUID as the root filesystem.

In the following all kernel command line parameters, which are processed by dracut, are described.

"rd.*" parameters mentioned without "=" are boolean parameters. They can be turned on/off by setting them to {0|1}. If the assignment with "=" is missing "=1" is implied. For example _rd.info_ can be turned off with _rd.info=0_ or turned on with _rd.info=1_ or _rd.info_. The last value in the kernel command line is the value, which is honored.

<a name="standard"></a>

### Standard


**init=**_&lt;path to real init&gt;_
specify the path to the init program to be started after the initramfs has finished

**root=**_&lt;path to blockdevice&gt;_
specify the block device to use as the root filesystem.

**Example**. 

.if n \{.RS 4
.\}
    root=/dev/sda1
    root=/dev/disk/by-path/pci-0000:00:1f.1-scsi-0:0:1:0-part1
    root=/dev/disk/by-label/Root
    root=LABEL=Root
    root=/dev/disk/by-uuid/3f5ad593-4546-4a94-a374-bcfb68aa11f7
    root=UUID=3f5ad593-4546-4a94-a374-bcfb68aa11f7
    root=PARTUUID=3f5ad593-4546-4a94-a374-bcfb68aa11f7
.if n \{.RE
.\}


**rootfstype=**_&lt;filesystem type&gt;_
"auto" if not specified.

**Example**. 

.if n \{.RS 4
.\}
    rootfstype=ext3
.if n \{.RE
.\}


**rootflags=**_&lt;mount options&gt;_
specify additional mount options for the root filesystem. If not set,
_/etc/fstab_
of the real root will be parsed for special mount options and mounted accordingly.

**ro**
force mounting
_/_
and
_/usr_
(if it is a separate device) read-only. If none of ro and rw is present, both are mounted according to
_/etc/fstab_.

**rw**
force mounting
_/_
and
_/usr_
(if it is a separate device) read-write. See also ro option.

**rootfallback=**_&lt;path to blockdevice&gt;_
specify the block device to use as the root filesystem, if the normal root cannot be found. This can only be a simple block device with a simple file system, for which the filesystem driver is either compiled in, or added manually to the initramfs. This parameter can be specified multiple times.

**rd.auto** **rd.auto=1**
enable autoassembly of special devices like cryptoLUKS, dmraid, mdraid or lvm. Default is off as of dracut version &gt;= 024.

**rd.hostonly=0**
removes all compiled in configuration of the host system the initramfs image was built on. This helps booting, if any disk layout changed, especially in combination with rd.auto or other parameters specifying the layout.

**rd.cmdline=ask**
prompts the user for additional kernel command line parameters

**rd.fstab=0**
do not honor special mount options for the root filesystem found in
_/etc/fstab_
of the real root.

**resume=**_&lt;path to resume partition&gt;_
resume from a swap partition

**Example**. 

.if n \{.RS 4
.\}
    resume=/dev/disk/by-path/pci-0000:00:1f.1-scsi-0:0:1:0-part1
    resume=/dev/disk/by-uuid/3f5ad593-4546-4a94-a374-bcfb68aa11f7
    resume=UUID=3f5ad593-4546-4a94-a374-bcfb68aa11f7
.if n \{.RE
.\}


**rd.skipfsck**
skip fsck for rootfs and
_/usr_. If you’re mounting
_/usr_
read-only and the init system performs fsck before remount, you might want to use this option to avoid duplication.

<a name="iso-scanfilename"></a>

### iso\-scan/filename


Using iso-scan/filename with a Fedora/Red Hat/CentOS Live iso should just work by copying the original kernel cmdline parameters.

**Example**. 

.if n \{.RS 4
.\}
    menuentry Live Fedora 20*(Aq --class fedora --class gnu-linux --class gnu --class os {
        set isolabel=Fedora-Live-LXDE-x86_64-20-1
        set isofile="/boot/iso/Fedora-Live-LXDE-x86_64-20-1.iso"
        loopback loop $isofile
        linux (loop)/isolinux/vmlinuz0 boot=isolinux iso-scan/filename=$isofile root=live:LABEL=$isolabel ro rd.live.image quiet rhgb
        initrd (loop)/isolinux/initrd0.img
    }
.if n \{.RE
.\}


<a name="misc"></a>

### Misc


**rd.emergency=**_[reboot|poweroff|halt]_
specify, what action to execute in case of a critical failure. rd.shell=0 also be specified.

**rd.driver.blacklist=**_&lt;drivername&gt;_[,_&lt;drivername&gt;_,...]
do not load kernel module &lt;drivername&gt;. This parameter can be specified multiple times.

**rd.driver.pre=**_&lt;drivername&gt;_[,_&lt;drivername&gt;_,...]
force loading kernel module &lt;drivername&gt;. This parameter can be specified multiple times.

**rd.driver.post=**_&lt;drivername&gt;_[,_&lt;drivername&gt;_,...]
force loading kernel module &lt;drivername&gt; after all automatic loading modules have been loaded. This parameter can be specified multiple times.

**rd.retry=**_&lt;seconds&gt;_
specify how long dracut should retry the initqueue to configure devices. The default is 30 seconds. After 2/3 of the time, degraded raids are force started. If you have hardware, which takes a very long time to announce its drives, you might want to extend this value.

**rd.timeout=**_&lt;seconds&gt;_
specify how long dracut should wait for devices to appear. The default is
_0_, which means
_forever_. Note that this timeout should be longer than rd.retry to allow for proper configuration.

**rd.noverifyssl**
accept self-signed certificates for ssl downloads.

**rd.ctty=**_&lt;terminal device&gt;_
specify the controlling terminal for the console. This is useful, if you have multiple "console=" arguments.

<a name="debug"></a>

### Debug


If you are dropped to an emergency shell, the file _/run/initramfs/rdsosreport.txt_ is created, which can be saved to a (to be mounted by hand) partition (usually /boot) or a USB stick. Additional debugging info can be produced by adding **rd.debug** to the kernel command line. _/run/initramfs/rdsosreport.txt_ contains all logs and the output of some tools. It should be attached to any report about dracut problems.

**rd.info**
print informational output though "quiet" is set

**rd.shell**
allow dropping to a shell, if root mounting fails

**rd.debug**
set -x for the dracut shell. If systemd is active in the initramfs, all output is logged to the systemd journal, which you can inspect with "journalctl -ab". If systemd is not active, the logs are written to dmesg and
_/run/initramfs/init.log_. If "quiet" is set, it also logs to the console.

**rd.memdebug=[0-5]**
Print memory usage info at various points, set the verbose level from 0 to 5.

.if n \{.RS 4
.\}
    Higher level means more debugging output:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
        0 - no output
        1 - partial /proc/meminfo
        2 - /proc/meminfo
        3 - /proc/meminfo + /proc/slabinfo
        4 - /proc/meminfo + /proc/slabinfo + memstrack summary
            NOTE: memstrack is a memory tracing tool that tracks the total memory
                  consumption, and peak memory consumption of each kernel modules
                  and userspace progress during the whole initramfs runtime, report
                  is genereted and the end of initramsfs run.
        5 - /proc/meminfo + /proc/slabinfo + memstrack (with top memory stacktrace)
            NOTE: memstrack (with top memory stacktrace) will print top memory
                  allocation stack traces during the whole initramfs runtime.
.if n \{.RE
.\}

**rd.break**
drop to a shell at the end

**rd.break=**_{cmdline|pre-udev|pre-trigger|initqueue|pre-mount|mount|pre-pivot|cleanup}_
drop to a shell on defined breakpoint

**rd.udev.info**
set udev to loglevel info

**rd.udev.debug**
set udev to loglevel debug

<a name="i18n"></a>

### I18N


**rd.vconsole.keymap=**_&lt;keymap base file name&gt;_
keyboard translation table loaded by loadkeys; taken from keymaps directory; will be written as KEYMAP to
_/etc/vconsole.conf_
in the initramfs.

**Example**. 

.if n \{.RS 4
.\}
    rd.vconsole.keymap=de-latin1-nodeadkeys
.if n \{.RE
.\}


**rd.vconsole.keymap.ext=**_&lt;list of keymap base file names&gt;_
list of extra keymaps to bo loaded (sep. by space); will be written as EXT_KEYMAP to
_/etc/vconsole.conf_
in the initramfs

**rd.vconsole.unicode**
boolean, indicating UTF-8 mode; will be written as UNICODE to
_/etc/vconsole.conf_
in the initramfs

**rd.vconsole.font=**_&lt;font base file name&gt;_
console font; taken from consolefonts directory; will be written as FONT to
_/etc/vconsole.conf_
in the initramfs.

**Example**. 

.if n \{.RS 4
.\}
    rd.vconsole.font=eurlatgr
.if n \{.RE
.\}


**rd.vconsole.font.map=**_&lt;console map base file name&gt;_
see description of
_-m_
parameter in setfont manual; taken from consoletrans directory; will be written as FONT_MAP to
_/etc/vconsole.conf_
in the initramfs

**rd.vconsole.font.unimap=**_&lt;unicode table base file name&gt;_
see description of
_-u_
parameter in setfont manual; taken from unimaps directory; will be written as FONT_UNIMAP to
_/etc/vconsole.conf_
in the initramfs

**rd.locale.LANG=**_&lt;locale&gt;_
taken from the environment; if no UNICODE is defined we set its value in basis of LANG value (whether it ends with ".utf8" (or similar) or not); will be written as LANG to
_/etc/locale.conf_
in the initramfs.

**Example**. 

.if n \{.RS 4
.\}
    rd.locale.LANG=pl_PL.utf8
.if n \{.RE
.\}


**rd.locale.LC\_ALL=**_&lt;locale&gt;_
taken from the environment; will be written as LC_ALL to
_/etc/locale.conf_
in the initramfs

<a name="lvm"></a>

### LVM


**rd.lvm=0**
disable LVM detection

**rd.lvm.vg=**_&lt;volume group name&gt;_
only activate all logical volumes in the the volume groups with the given name. rd.lvm.vg can be specified multiple times on the kernel command line.

**rd.lvm.lv=**_&lt;volume group name&gt;/&lt;logical volume name&gt;_
only activate the logical volumes with the given name. rd.lvm.lv can be specified multiple times on the kernel command line.

**rd.lvm.conf=0**
remove any
_/etc/lvm/lvm.conf_, which may exist in the initramfs

<a name="crypto-luks"></a>

### crypto LUKS


**rd.luks=0**
disable crypto LUKS detection

**rd.luks.uuid=**_&lt;luks uuid&gt;_
only activate the LUKS partitions with the given UUID. Any "luks-" of the LUKS UUID is removed before comparing to
_&lt;luks uuid&gt;_. The comparisons also matches, if
_&lt;luks uuid&gt;_
is only the beginning of the LUKS UUID, so you don’t have to specify the full UUID. This parameter can be specified multiple times.

**rd.luks.allow-discards=**_&lt;luks uuid&gt;_
Allow using of discards (TRIM) requests for LUKS partitions with the given UUID. Any "luks-" of the LUKS UUID is removed before comparing to
_&lt;luks uuid&gt;_. The comparisons also matches, if
_&lt;luks uuid&gt;_
is only the beginning of the LUKS UUID, so you don’t have to specify the full UUID. This parameter can be specified multiple times.

**rd.luks.allow-discards**
Allow using of discards (TRIM) requests on all LUKS partitions.

**rd.luks.crypttab=0**
do not check, if LUKS partition is in
_/etc/crypttab_

**rd.luks.timeout=**_&lt;seconds&gt;_
specify how long dracut should wait when waiting for the user to enter the password. This avoid blocking the boot if no password is entered. It does not apply to luks key. The default is
_0_, which means
_forever_.

<a name="crypto-luks-key-on-removable-device-support"></a>

### crypto LUKS \- key on removable device support


NB: If systemd is included in the dracut initrd, dracut’s built in removable device keying support won’t work. systemd will prompt for a password from the console even if you’ve supplied **rd.luks.key**. You may be able to use standard systemd **fstab**(5) syntax to get the same effect. If you do need **rd.luks.key** to work, you will have to exclude the "systemd" dracut module and any modules that depend on it. See **dracut.conf**(5) and \m[blue]**https://bugzilla.redhat.com/show\_bug.cgi?id=905683**\m[] for more information.

**rd.luks.key=**_&lt;keypath&gt;[:&lt;keydev&gt;[:&lt;luksdev&gt;]]_
_&lt;keypath&gt;_
is the pathname of a key file, relative to the root of the filesystem on some device. It’s REQUIRED. When
_&lt;keypath&gt;_
ends with
_.gpg_
it’s considered to be key encrypted symmetrically with GPG. You will be prompted for the GPG password on boot. GPG support comes with the
_crypt-gpg_
module, which needs to be added explicitly.

_&lt;keydev&gt;_
identifies the device on which the key file resides. It may be the kernel name of the device (should start with "/dev/"), a UUID (prefixed with "UUID=") or a label (prefix with "LABEL="). You don’t have to specify a full UUID. Just its beginning will suffice, even if its ambiguous. All matching devices will be probed. This parameter is recommended, but not required. If it’s not present, all block devices will be probed, which may significantly increase boot time.

If
_&lt;luksdev&gt;_
is given, the specified key will only be used for the specified LUKS device. Possible values are the same as for
_&lt;keydev&gt;_. Unless you have several LUKS devices, you don’t have to specify this parameter. The simplest usage is:

**Example**. 

.if n \{.RS 4
.\}
    rd.luks.key=/foo/bar.key
.if n \{.RE
.\}


As you see, you can skip colons in such a case.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  

Your LUKS partition must match your key file.

dracut provides keys to cryptsetup with _-d_ (an older alias for _--key-file_). This uses the entire binary content of the key file as part of the secret. If you pipe a password into cryptsetup **without** _-d_ or _--key-file_, it will be treated as text user input, and only characters before the first newline will be used. Therefore, when you’re creating an encrypted partition for dracut to mount, and you pipe a key into _cryptsetup luksFormat_,you must use _-d -_.

Here is an example for a key encrypted with GPG (warning: _--batch-mode_ will overwrite the device without asking for confirmation):

.if n \{.RS 4
.\}
    gpg --quiet --decrypt rootkey.gpg | e
    cryptsetup --batch-mode --key-file - e
               luksFormat /dev/sda47
.if n \{.RE
.\}

If you use unencrypted key files, just use the key file pathname instead of the standard input. For a random key with 256 bits of entropy, you might use:

.if n \{.RS 4
.\}
    head -32c /dev/urandom > rootkey.key
    cryptsetup --batch-mode --key-file rootkey.key e
               luksFormat /dev/sda47
.if n \{.RE
.\}


<a name="md-raid"></a>

### MD RAID


**rd.md=0**
disable MD RAID detection

**rd.md.imsm=0**
disable MD RAID for imsm/isw raids, use DM RAID instead

**rd.md.ddf=0**
disable MD RAID for SNIA ddf raids, use DM RAID instead

**rd.md.conf=0**
ignore mdadm.conf included in initramfs

**rd.md.waitclean=1**
wait for any resync, recovery, or reshape activity to finish before continuing

**rd.md.uuid=**_&lt;md raid uuid&gt;_
only activate the raid sets with the given UUID. This parameter can be specified multiple times.

<a name="dm-raid"></a>

### DM RAID


**rd.dm=0**
disable DM RAID detection

**rd.dm.uuid=**_&lt;dm raid uuid&gt;_
only activate the raid sets with the given UUID. This parameter can be specified multiple times.

<a name="multipath"></a>

### MULTIPATH


**rd.multipath=0**
disable multipath detection

**rd.multipath=default**
use default multipath settings

<a name="fips"></a>

### FIPS


**rd.fips**
enable FIPS

**boot=**_&lt;boot device&gt;_
specify the device, where /boot is located.

**Example**. 

.if n \{.RS 4
.\}
    boot=/dev/sda1
    boot=/dev/disk/by-path/pci-0000:00:1f.1-scsi-0:0:1:0-part1
    boot=UUID=<uuid>
    boot=LABEL=<label>
.if n \{.RE
.\}


**rd.fips.skipkernel**
skip checksum check of the kernel image. Useful, if the kernel image is not in a separate boot partition.

<a name="network"></a>

### Network

.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Important**
.ps -1  

It is recommended to either bind an interface to a MAC with the **ifname** argument, or to use the systemd-udevd predictable network interface names.

Predictable network interface device names based on:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  firmware/bios-provided index numbers for on-board devices

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  firmware-provided pci-express hotplug slot index number

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  physical/geographical location of the hardware

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  the interface’s MAC address

See: \m[blue]**http://www.freedesktop.org/wiki/Software/systemd/PredictableNetworkInterfaceNames**\m[]

Two character prefixes based on the type of interface:

en
ethernet

wl
wlan

ww
wwan

Type of names:

o&lt;index&gt;
on-board device index number

s&lt;slot&gt;[f&lt;function&gt;][d&lt;dev_id&gt;]
hotplug slot index number

x&lt;MAC&gt;
MAC address

[P&lt;domain&gt;]p&lt;bus&gt;s&lt;slot&gt;[f&lt;function&gt;][d&lt;dev_id&gt;]
PCI geographical location

[P&lt;domain&gt;]p&lt;bus&gt;s&lt;slot&gt;[f&lt;function&gt;][u&lt;port&gt;][..][c&lt;config&gt;][i&lt;interface&gt;]
USB port number chain

All multi-function PCI devices will carry the [f&lt;function&gt;] number in the device name, including the function 0 device.

When using PCI geography, The PCI domain is only prepended when it is not 0.

For USB devices the full chain of port numbers of hubs is composed. If the name gets longer than the maximum number of 15 characters, the name is not exported. The usual USB configuration == 1 and interface == 0 values are suppressed.

PCI ethernet card with firmware index "1"

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  eno1

PCI ethernet card in hotplug slot with firmware index number

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  ens1

PCI ethernet multi-function card with 2 ports

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  enp2s0f0

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  enp2s0f1

PCI wlan card

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  wlp3s0

USB built-in 3G modem

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  wwp0s29u1u4i6

USB Android phone

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  enp0s29u1u2


**ip=**_{dhcp|on|any|dhcp6|auto6|either6}_

dhcp|on|any
get ip from dhcp server from all interfaces. If root=dhcp, loop sequentially through all interfaces (eth0, eth1, ...) and use the first with a valid DHCP root-path.

auto6
IPv6 autoconfiguration

dhcp6
IPv6 DHCP

either6
if auto6 fails, then dhcp6

**ip=**_&lt;interface&gt;_:_{dhcp|on|any|dhcp6|auto6}_[:[_&lt;mtu&gt;_][:_&lt;macaddr&gt;_]]
This parameter can be specified multiple times.

dhcp|on|any|dhcp6
get ip from dhcp server on a specific interface

auto6
do IPv6 autoconfiguration

&lt;macaddr&gt;
optionally
**set**
&lt;macaddr&gt; on the &lt;interface&gt;. This cannot be used in conjunction with the
**ifname**
argument for the same &lt;interface&gt;.

**ip=**_&lt;client-IP&gt;_:[_&lt;peer&gt;_]:_&lt;gateway-IP&gt;_:_&lt;netmask&gt;_:_&lt;client\_hostname&gt;_:_&lt;interface&gt;_:_{none|off|dhcp|on|any|dhcp6|auto6|ibft}_[:[_&lt;mtu&gt;_][:_&lt;macaddr&gt;_]]
explicit network configuration. If you want do define a IPv6 address, put it in brackets (e.g. [2001:DB8::1]). This parameter can be specified multiple times.
_&lt;peer&gt;_
is optional and is the address of the remote endpoint for pointopoint interfaces and it may be followed by a slash and a decimal number, encoding the network prefix length.

&lt;macaddr&gt;
optionally
**set**
&lt;macaddr&gt; on the &lt;interface&gt;. This cannot be used in conjunction with the
**ifname**
argument for the same &lt;interface&gt;.

**ip=**_&lt;client-IP&gt;_:[_&lt;peer&gt;_]:_&lt;gateway-IP&gt;_:_&lt;netmask&gt;_:_&lt;client\_hostname&gt;_:_&lt;interface&gt;_:_{none|off|dhcp|on|any|dhcp6|auto6|ibft}_[:[_&lt;dns1&gt;_][:_&lt;dns2&gt;_]]
explicit network configuration. If you want do define a IPv6 address, put it in brackets (e.g. [2001:DB8::1]). This parameter can be specified multiple times.
_&lt;peer&gt;_
is optional and is the address of the remote endpoint for pointopoint interfaces and it may be followed by a slash and a decimal number, encoding the network prefix length.

**ifname=**_&lt;interface&gt;_:_&lt;MAC&gt;_
Assign network device name &lt;interface&gt; (i.e. "bootnet") to the NIC with MAC &lt;MAC&gt;.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Warning**
.ps -1  
Do
**not**
use the default kernel naming scheme for the interface name, as it can conflict with the kernel names. So, don’t use "eth[0-9]+" for the interface name. Better name it "bootnet" or "bluesocket".


**rd.route=**_&lt;net&gt;_/_&lt;netmask&gt;_:_&lt;gateway&gt;_[:_&lt;interface&gt;_]
Add a static route with route options, which are separated by a colon. IPv6 addresses have to be put in brackets.

**Example**. 

.if n \{.RS 4
.\}
        rd.route=192.168.200.0/24:192.168.100.222:ens10
        rd.route=192.168.200.0/24:192.168.100.222
        rd.route=192.168.200.0/24::ens10
        rd.route=[2001:DB8:3::/8]:[2001:DB8:2::1]:ens10
.if n \{.RE
.\}


**bootdev=**_&lt;interface&gt;_
specify network interface to use routing and netroot information from. Required if multiple ip= lines are used.

**BOOTIF=**_&lt;MAC&gt;_
specify network interface to use routing and netroot information from.

**rd.bootif=0**
Disable BOOTIF parsing, which is provided by PXE

**nameserver=**_&lt;IP&gt;_ [**nameserver=**_&lt;IP&gt;_ ...]
specify nameserver(s) to use

**rd.peerdns=0**
Disable DNS setting of DHCP parameters.

**biosdevname=0**
boolean, turn off biosdevname network interface renaming

**rd.neednet=1**
boolean, bring up network even without netroot set

**vlan=**_&lt;vlanname&gt;_:_&lt;phydevice&gt;_
Setup vlan device named &lt;vlanname&gt; on &lt;phydeivce&gt;. We support the four styles of vlan names: VLAN_PLUS_VID (vlan0005), VLAN_PLUS_VID_NO_PAD (vlan5), DEV_PLUS_VID (eth0.0005), DEV_PLUS_VID_NO_PAD (eth0.5)

**bond=**_&lt;bondname&gt;_[:_&lt;bondslaves&gt;_:[:_&lt;options&gt;_[:&lt;mtu&gt;]]]
Setup bonding device &lt;bondname&gt; on top of &lt;bondslaves&gt;. &lt;bondslaves&gt; is a comma-separated list of physical (ethernet) interfaces. &lt;options&gt; is a comma-separated list on bonding options (modinfo bonding for details) in format compatible with initscripts. If &lt;options&gt; includes multi-valued arp_ip_target option, then its values should be separated by semicolon. if the mtu is specified, it will be set on the bond master. Bond without parameters assumes bond=bond0:eth0,eth1:mode=balance-rr

**team=**_&lt;teammaster&gt;_:_&lt;teamslaves&gt;_
Setup team device &lt;teammaster&gt; on top of &lt;teamslaves&gt;. &lt;teamslaves&gt; is a comma-separated list of physical (ethernet) interfaces.

**bridge=**_&lt;bridgename&gt;_:_&lt;ethnames&gt;_
Setup bridge &lt;bridgename&gt; with &lt;ethnames&gt;. &lt;ethnames&gt; is a comma-separated list of physical (ethernet) interfaces. Bridge without parameters assumes bridge=br0:eth0

<a name="nfs"></a>

### NFS


**root=**[_&lt;server-ip&gt;_:]_&lt;root-dir&gt;_[:_&lt;nfs-options&gt;_]
mount nfs share from &lt;server-ip&gt;:/&lt;root-dir&gt;, if no server-ip is given, use dhcp next_server. If server-ip is an IPv6 address it has to be put in brackets, e.g. [2001:DB8::1]. NFS options can be appended with the prefix ":" or "," and are separated by ",".

**root=**nfs:[_&lt;server-ip&gt;_:]_&lt;root-dir&gt;_[:_&lt;nfs-options&gt;_], **root=**nfs4:[_&lt;server-ip&gt;_:]_&lt;root-dir&gt;_[:_&lt;nfs-options&gt;_], **root=**_{dhcp|dhcp6}_
root=dhcp alone directs initrd to look at the DHCP root-path where NFS options can be specified.

**Example**. 

.if n \{.RS 4
.\}
        root-path=<server-ip>:<root-dir>[,<nfs-options>]
        root-path=nfs:<server-ip>:<root-dir>[,<nfs-options>]
        root-path=nfs4:<server-ip>:<root-dir>[,<nfs-options>]
.if n \{.RE
.\}


**root=**_/dev/nfs_ nfsroot=[_&lt;server-ip&gt;_:]_&lt;root-dir&gt;_[:_&lt;nfs-options&gt;_]
_Deprecated!_
kernel Documentation_/filesystems/nfsroot.txt_ defines this method. This is supported by dracut, but not recommended.

**rd.nfs.domain=**_&lt;NFSv4 domain name&gt;_
Set the NFSv4 domain name. Will override the settings in
_/etc/idmap.conf_.

**rd.net.dhcp.retry=**_&lt;cnt&gt;_
If this option is set, dracut will try to connect via dhcp &lt;cnt&gt; times before failing. Default is 1.

**rd.net.timeout.dhcp=**_&lt;arg&gt;_
If this option is set, dhclient is called with "-timeout &lt;arg&gt;".

**rd.net.timeout.iflink=**_&lt;seconds&gt;_
Wait &lt;seconds&gt; until link shows up. Default is 60 seconds.

**rd.net.timeout.ifup=**_&lt;seconds&gt;_
Wait &lt;seconds&gt; until link has state "UP". Default is 20 seconds.

**rd.net.timeout.route=**_&lt;seconds&gt;_
Wait &lt;seconds&gt; until route shows up. Default is 20 seconds.

**rd.net.timeout.ipv6dad=**_&lt;seconds&gt;_
Wait &lt;seconds&gt; until IPv6 DAD is finished. Default is 50 seconds.

**rd.net.timeout.ipv6auto=**_&lt;seconds&gt;_
Wait &lt;seconds&gt; until IPv6 automatic addresses are assigned. Default is 40 seconds.

**rd.net.timeout.carrier=**_&lt;seconds&gt;_
Wait &lt;seconds&gt; until carrier is recognized. Default is 10 seconds.

<a name="cifs"></a>

### CIFS


**root=**cifs://[_&lt;username&gt;_[:_&lt;password&gt;_]@]_&lt;server-ip&gt;_:_&lt;root-dir&gt;_
mount cifs share from &lt;server-ip&gt;:/&lt;root-dir&gt;, if no server-ip is given, use dhcp next_server. if server-ip is an IPv6 address it has to be put in brackets, e.g. [2001:DB8::1]. If a username or password are not specified as part of the root, then they must be passed on the command line through cifsuser/cifspass.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Warning**
.ps -1  
Passwords specified on the kernel command line are visible for all users via the file
_/proc/cmdline_
and via dmesg or can be sniffed on the network, when using DHCP with DHCP root-path.


**cifsuser**=_&lt;username&gt;_
Set the cifs username, if not specified as part of the root.

**cifspass**=_&lt;password&gt;_
Set the cifs password, if not specified as part of the root.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Warning**
.ps -1  
Passwords specified on the kernel command line are visible for all users via the file
_/proc/cmdline_
and via dmesg or can be sniffed on the network, when using DHCP with DHCP root-path.


<a name="iscsi"></a>

### iSCSI


**root=**iscsi:[_&lt;username&gt;_:_&lt;password&gt;_[:_&lt;reverse&gt;_:_&lt;password&gt;_]@][_&lt;servername&gt;_]:[_&lt;protocol&gt;_]:[_&lt;port&gt;_][:[_&lt;iscsi\_iface\_name&gt;_]:[_&lt;netdev\_name&gt;_]]:[_&lt;LUN&gt;_]:_&lt;targetname&gt;_
protocol defaults to "6", LUN defaults to "0". If the "servername" field is provided by BOOTP or DHCP, then that field is used in conjunction with other associated fields to contact the boot server in the Boot stage. However, if the "servername" field is not provided, then the "targetname" field is then used in the Discovery Service stage in conjunction with other associated fields. See
\m[blue]**rfc4173**\m[]\s-2\u[1]\d\s+2.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Warning**
.ps -1  
Passwords specified on the kernel command line are visible for all users via the file
_/proc/cmdline_
and via dmesg or can be sniffed on the network, when using DHCP with DHCP root-path.


**Example**. 

.if n \{.RS 4
.\}
    root=iscsi:192.168.50.1::::iqn.2009-06.dracut:target0
.if n \{.RE
.\}


If servername is an IPv6 address, it has to be put in brackets:

**Example**. 

.if n \{.RS 4
.\}
    root=iscsi:[2001:DB8::1]::::iqn.2009-06.dracut:target0
.if n \{.RE
.\}


**root=**_???_ **netroot=**iscsi:[_&lt;username&gt;_:_&lt;password&gt;_[:_&lt;reverse&gt;_:_&lt;password&gt;_]@][_&lt;servername&gt;_]:[_&lt;protocol&gt;_]:[_&lt;port&gt;_][:[_&lt;iscsi\_iface\_name&gt;_]:[_&lt;netdev\_name&gt;_]]:[_&lt;LUN&gt;_]:_&lt;targetname&gt;_ ...
multiple netroot options allow setting up multiple iscsi disks:

**Example**. 

.if n \{.RS 4
.\}
    root=UUID=12424547
    netroot=iscsi:192.168.50.1::::iqn.2009-06.dracut:target0
    netroot=iscsi:192.168.50.1::::iqn.2009-06.dracut:target1
.if n \{.RE
.\}


If servername is an IPv6 address, it has to be put in brackets:

**Example**. 

.if n \{.RS 4
.\}
    netroot=iscsi:[2001:DB8::1]::::iqn.2009-06.dracut:target0
.if n \{.RE
.\}

.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Warning**
.ps -1  
Passwords specified on the kernel command line are visible for all users via the file
_/proc/cmdline_
and via dmesg or can be sniffed on the network, when using DHCP with DHCP root-path. You may want to use rd.iscsi.firmware.


**root=**_???_ **rd.iscsi.initiator=**_&lt;initiator&gt;_ **rd.iscsi.target.name=**_&lt;target name&gt;_ **rd.iscsi.target.ip=**_&lt;target ip&gt;_ **rd.iscsi.target.port=**_&lt;target port&gt;_ **rd.iscsi.target.group=**_&lt;target group&gt;_ **rd.iscsi.username=**_&lt;username&gt;_ **rd.iscsi.password=**_&lt;password&gt;_ **rd.iscsi.in.username=**_&lt;in username&gt;_ **rd.iscsi.in.password=**_&lt;in password&gt;_
manually specify all iscsistart parameter (see
**iscsistart&nbsp;--help**)
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Warning**
.ps -1  
Passwords specified on the kernel command line are visible for all users via the file
_/proc/cmdline_
and via dmesg or can be sniffed on the network, when using DHCP with DHCP root-path. You may want to use rd.iscsi.firmware.


**root=**_???_ **netroot=**iscsi **rd.iscsi.firmware=1**
will read the iscsi parameter from the BIOS firmware

**rd.iscsi.login\_retry\_max=**_&lt;num&gt;_
maximum number of login retries

**rd.iscsi.param=**_&lt;param&gt;_
&lt;param&gt; will be passed as "--param &lt;param&gt;" to iscsistart. This parameter can be specified multiple times.

**Example**. 

.if n \{.RS 4
.\}
    "netroot=iscsi rd.iscsi.firmware=1 rd.iscsi.param=node.session.timeo.replacement_timeout=30"
.if n \{.RE
.\}


will result in

.if n \{.RS 4
.\}
    iscsistart -b --param node.session.timeo.replacement_timeout=30
.if n \{.RE
.\}

**rd.iscsi.ibft** **rd.iscsi.ibft=1**: Turn on iBFT autoconfiguration for the interfaces

**rd.iscsi.mp** **rd.iscsi.mp=1**: Configure all iBFT interfaces, not only used for booting (multipath)

**rd.iscsi.waitnet=0**: Turn off waiting for all interfaces to be up before trying to login to the iSCSI targets.

**rd.iscsi.testroute=0**: Turn off checking, if the route to the iSCSI target IP is possible before trying to login.

<a name="fcoe"></a>

### FCoE


**rd.nofcoe=0**
disable FCoE and lldpad

**fcoe=**_&lt;edd|interface|MAC&gt;_:_{dcb|nodcb}_:_{fabric|vn2vn}_
Try to connect to a FCoE SAN through the NIC specified by
_&lt;interface&gt;_
or
_&lt;MAC&gt;_
or EDD settings. The second argument specifies if DCB should be used. The optional third argument specifies whether fabric or VN2VN mode should be used. This parameter can be specified multiple times.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
letters in the MAC-address must be lowercase!


<a name="nbd"></a>

### NBD


**root=**??? **netroot=**nbd:_&lt;server&gt;_:_&lt;port/exportname&gt;_[:_&lt;fstype&gt;_[:_&lt;mountopts&gt;_[:_&lt;nbdopts&gt;_]]]
mount nbd share from &lt;server&gt;.

NOTE: If "exportname" instead of "port" is given the standard port is used. Newer versions of nbd are only supported with "exportname".

**root=dhcp** with **dhcp** **root-path=**nbd:_&lt;server&gt;_:_&lt;port/exportname&gt;_[:_&lt;fstype&gt;_[:_&lt;mountopts&gt;_[:_&lt;nbdopts&gt;_]]]
root=dhcp alone directs initrd to look at the DHCP root-path where NBD options can be specified. This syntax is only usable in cases where you are directly mounting the volume as the rootfs.

NOTE: If "exportname" instead of "port" is given the standard port is used. Newer versions of nbd are only supported with "exportname".

<a name="dasd"></a>

### DASD


**rd.dasd=**....
same syntax as the kernel module parameter (s390 only)

<a name="zfcp"></a>

### ZFCP


**rd.zfcp=**_&lt;zfcp adaptor device bus ID&gt;_,_&lt;WWPN&gt;_,_&lt;FCPLUN&gt;_
rd.zfcp can be specified multiple times on the kernel command line.

**rd.zfcp=**_&lt;zfcp adaptor device bus ID&gt;_
If NPIV is enabled and the
_allow\_lun\_scan_
parameter to the zfcp module is set to
_Y_
then the zfcp adaptor will be initiating a scan internally and the &lt;WWPN&gt; and &lt;FCPLUN&gt; parameters can be omitted.

**Example**. 

.if n \{.RS 4
.\}
    rd.zfcp=0.0.4000,0x5005076300C213e9,0x5022000000000000
    rd.zfcp=0.0.4000
.if n \{.RE
.\}


**rd.zfcp.conf=0**
ignore zfcp.conf included in the initramfs

<a name="znet"></a>

### ZNET


**rd.znet=**_&lt;nettype&gt;_,_&lt;subchannels&gt;_,_&lt;options&gt;_
The whole parameter is appended to /etc/ccw.conf, which is used on RHEL/Fedora with ccw_init, which is called from udev for certain devices on z-series. rd.znet can be specified multiple times on the kernel command line.

**rd.znet\_ifname=**_&lt;ifname&gt;_:_&lt;subchannels&gt;_
Assign network device name &lt;interface&gt; (i.e. "bootnet") to the NIC corresponds to the subchannels. This is useful when dracut’s default "ifname=" doesn’t work due to device having a changing MAC address.

**Example**. 

.if n \{.RS 4
.\}
    rd.znet=qeth,0.0.0600,0.0.0601,0.0.0602,layer2=1,portname=foo
    rd.znet=ctc,0.0.0600,0.0.0601,protocol=bar
.if n \{.RE
.\}


<a name="booting-live-images"></a>

### Booting live images


Dracut offers multiple options for live booted images:

SquashFS with read-only filesystem image
The system will boot with a read-only filesystem from the SquashFS and apply a writable Device-mapper snapshot or an OverlayFS overlay mount for the read-only base filesystem. This method ensures a relatively fast boot and lower RAM usage. Users
**must be careful**
to avoid writing too many blocks to a snapshot volume. Once the blocks of the snapshot overlay are exhausted, the root filesystem becomes read-only and may cause application failures. The snapshot overlay file is marked
_Overflow_, and a difficult recovery is required to repair and enlarge the overlay offline. Non-persistent overlays are sparse files in RAM that only consume content space as required blocks are allocated. They default to an apparent size of 32 GiB in RAM. The size can be adjusted with the
**rd.live.overlay.size=**
kernel command line option.

The filesystem structure is traditionally expected to be:

.if n \{.RS 4
.\}
    squashfs.img          |  SquashFS from LiveCD .iso
       !(mount)
       /LiveOS
           |- rootfs.img  |  Filesystem image to mount read-only
                !(mount)
                /bin      |  Live filesystem
                /boot     |
                /dev      |
                ...       |
.if n \{.RE
.\}

For OverlayFS mount overlays, the filesystem structure may also be a direct compression of the root filesystem:

.if n \{.RS 4
.\}
    squashfs.img          |  SquashFS from LiveCD .iso
       !(mount)
       /bin               |  Live filesystem
       /boot              |
       /dev               |
       ...                |
.if n \{.RE
.\}

Dracut uses one of the overlay methods of live booting by default. No additional command line options are required other than
**root=live:&lt;URL&gt;**
to specify the location of your squashed filesystem.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  The compressed SquashFS image can be copied during boot to RAM at
  /run/initramfs/squashed.img
  by using the
  **rd.live.ram=1**
  option.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  A device with a persistent overlay can be booted read-only by using the
  **rd.live.overlay.readonly**
  option on the kernel command line. This will either cause a temporary, writable overlay to be stacked over a read-only snapshot of the root filesystem or the OverlayFS mount will use an additional lower layer with the root filesystem.

Uncompressed live filesystem image
When the live system was installed with the
_--skipcompress_
option of the
_livecd-iso-to-disk_
installation script for Live USB devices, the root filesystem image,
_rootfs.img_, is expanded on installation and no SquashFS is involved during boot.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  If
  **rd.live.ram=1**
  is used in this situation, the full, uncompressed root filesystem is copied during boot to
  /run/initramfs/rootfs.img
  in the
  /run
  tmpfs.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  If
  **rd.live.overlay=none**
  is provided as a kernel command line option, a writable, linear Device-mapper target is created on boot with no overlay.

Writable filesystem image
The system will retrieve a compressed filesystem image, extract it to
/run/initramfs/fsimg/rootfs.img, connect it to a loop device, create a writable, linear Device-mapper target at
/dev/mapper/live-rw, and mount that as a writable volume at
/. More RAM is required during boot but the live filesystem is easier to manage if it becomes full. Users can make a filesystem image of any size and that size will be maintained when the system boots. There is no persistence of root filesystem changes between boots with this option.

The filesystem structure is expected to be:

.if n \{.RS 4
.\}
    rootfs.tgz            |  Compressed tarball containing filesystem image
       !(unpack)
       /rootfs.img        |  Filesystem image at /run/initramfs/fsimg/
          !(mount)
          /bin            |  Live filesystem
          /boot           |
          /dev            |
          ...             |
.if n \{.RE
.\}

To use this boot option, ensure that
**rd.writable.fsimg=1**
is in your kernel command line and add the
**root=live:&lt;URL&gt;**
to specify the location of your compressed filesystem image tarball or SquashFS image.

**rd.writable.fsimg=**1
Enables writable filesystem support. The system will boot with a fully writable (but non-persistent) filesystem without snapshots
_(see notes above about available live boot options)_. You can use the
**rootflags**
option to set mount options for the live filesystem as well
_(see documentation about rootflags in the __**Standard** section above)_. This implies that the whole image is copied to RAM before the boot continues.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
There must be enough free RAM available to hold the complete image.

This method is very suitable for diskless boots.

**root=**live:_&lt;url&gt;_
Boots a live image retrieved from
_&lt;url&gt;_. Requires the dracut
_livenet_
module. Valid handlers:
_http, https, ftp, torrent, tftp_.

**Examples**. 

.if n \{.RS 4
.\}
    root=live:http://example.com/liveboot.img
    root=live:ftp://ftp.example.com/liveboot.img
    root=live:torrent://example.com/liveboot.img.torrent
.if n \{.RE
.\}


**rd.live.debug=**1
Enables debug output from the live boot process.

**rd.live.dir=**_&lt;path&gt;_
Specifies the directory within the boot device where the squashfs.img or rootfs.img can be found. By default, this is
/LiveOS.

**rd.live.squashimg=**_&lt;filename of SquashFS image&gt;_
Specifies the filename for a SquashFS image of the root filesystem. By default, this is
_squashfs.img_.

**rd.live.ram=**1
Copy the complete image to RAM and use this for booting. This is useful when the image resides on, e.g., a DVD which needs to be ejected later on.

**rd.live.overlay={**_&lt;devspec&gt;_[:_{&lt;pathspec&gt;|auto}_]|_none_}
Manage the usage of a permanent overlay.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _&lt;devspec&gt;_
  specifies the path to a device with a mountable filesystem.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _&lt;pathspec&gt;_
  is the path to a file within that filesystem, which shall be used to persist the changes made to the device specified by the
  **root=live:****&lt;url&gt;**
  option.

The default
_pathspec_, when
_auto_
or no
_:&lt;pathspec&gt;_
is given, is
/&lt;&lt;b&gt;rd.live.dir&lt;/b&gt;&gt;/overlay-&lt;label&gt;-&lt;uuid&gt;, where
_&lt;label&gt;_
is the device LABEL, and
_&lt;uuid&gt;_
is the device UUID. *
_none_
(the word itself) specifies that no overlay will be used, such as when an uncompressed, writable live root filesystem is available.

If a persistent overlay
_is detected_
at the standard LiveOS path, the overlay & overlay type detected, whether Device-mapper or OverlayFS, will be used.

**Examples**. 

.if n \{.RS 4
.\}
    rd.live.overlay=/dev/sdb1:persistent-overlay.img
    rd.live.overlay=UUID=99440c1f-8daa-41bf-b965-b7240a8996f4
.if n \{.RE
.\}


**rd.live.overlay.size=**_&lt;size\_MiB&gt;_
Specifies a non-persistent Device-mapper overlay size in MiB. The default is
_32768_.

**rd.live.overlay.readonly=**1
This is used to boot with a normally read-write persistent overlay in a read-only mode. With this option, either an additional, non-persistent, writable snapshot overlay will be stacked over a read-only snapshot,
/dev/mapper/live-ro, of the base filesystem with the persistent overlay, or a read-only loop device, in the case of a writable
_rootfs.img_, or an OverlayFS mount will use the persistent overlay directory linked at
/run/overlayfs-r
as an additional lower layer along with the base root filesystem and apply a transient, writable upper directory overlay, in order to complete the booted root filesystem.

**rd.live.overlay.reset=**1
Specifies that a persistent overlay should be reset on boot. All previous root filesystem changes are vacated by this action.

**rd.live.overlay.thin=**1
Enables the usage of thin snapshots instead of classic dm snapshots. The advantage of thin snapshots is that they support discards, and will free blocks that are not claimed by the filesystem. In this use case, this means that memory is given back to the kernel when the filesystem does not claim it anymore.

**rd.live.overlay.overlayfs=**1
Enables the use of the
**OverlayFS**
kernel module, if available, to provide a copy-on-write union directory for the root filesystem. OverlayFS overlays are directories of the files that have changed on the read-only base (lower) filesystem. The root filesystem is provided through a special overlay type mount that merges the lower and upper directories. If an OverlayFS upper directory is not present on the boot device, a tmpfs directory will be created at
/run/overlayfs
to provide temporary storage. Persistent storage can be provided on vfat or msdos formatted devices by supplying the OverlayFS upper directory within an embedded filesystem that supports the creation of trusted.* extended attributes and provides a valid d_type in readdir responses, such as with ext4 and xfs. On non-vfat-formatted devices, a persistent OverlayFS overlay can extend the available root filesystem storage up to the capacity of the LiveOS disk device.

If a persistent overlay is detected at the standard LiveOS path, the overlay & overlay type detected, whether OverlayFS or Device-mapper, will be used.

The
**rd.live.overlay.readonly**
option, which allows a persistent overlayfs to be mounted read-only through a higher level transient overlay directory, has been implemented through the multiple lower layers feature of OverlayFS.

<a name="zipl"></a>

### ZIPL


**rd.zipl=**_&lt;path to blockdevice&gt;_
Update the dracut commandline with the values found in the
_dracut-cmdline.conf_
file on the given device. The values are merged into the existing commandline values and the udev events are regenerated.

**Example**. 

.if n \{.RS 4
.\}
    rd.zipl=UUID=0fb28157-99e3-4395-adef-da3f7d44835a
.if n \{.RE
.\}


<a name="cio_ignore"></a>

### CIO_IGNORE


**rd.cio\_accept=**_&lt;device-ids&gt;_
Remove the devices listed in &lt;device-ids&gt; from the default cio_ignore kernel command-line settings. &lt;device-ids&gt; is a list of comma-separated CCW device ids. The default for this value is taken from the
_/boot/zipl/active\_devices.txt_
file.

**Example**. 

.if n \{.RS 4
.\}
    rd.cio_accept=0.0.0180,0.0.0800,0.0.0801,0.0.0802
.if n \{.RE
.\}


<a name="plymouth-boot-splash"></a>

### Plymouth Boot Splash


**plymouth.enable=0**
disable the plymouth bootsplash completely.

**rd.plymouth=0**
disable the plymouth bootsplash only for the initramfs.

<a name="kernel-keys"></a>

### Kernel keys


**masterkey=**_&lt;kernel master key path name&gt;_
Set the path name of the kernel master key.

**Example**. 

.if n \{.RS 4
.\}
    masterkey=/etc/keys/kmk-trusted.blob
.if n \{.RE
.\}


**masterkeytype=**_&lt;kernel master key type&gt;_
Set the type of the kernel master key.

**Example**. 

.if n \{.RS 4
.\}
    masterkeytype=trusted
.if n \{.RE
.\}


**evmkey=**_&lt;EVM key path name&gt;_
Set the path name of the EVM key.

**Example**. 

.if n \{.RS 4
.\}
    evmkey=/etc/keys/evm-trusted.blob
.if n \{.RE
.\}


**ecryptfskey=**_&lt;eCryptfs key path name&gt;_
Set the path name of the eCryptfs key.

**Example**. 

.if n \{.RS 4
.\}
    ecryptfskey=/etc/keys/ecryptfs-trusted.blob
.if n \{.RE
.\}


<a name="deprecated-renamed-options"></a>

### Deprecated, renamed Options


Here is a list of options, which were used in dracut prior to version 008, and their new replacement.

rdbreak
rd.break

rd.ccw
rd.znet

rd_CCW
rd.znet

rd_DASD_MOD
rd.dasd

rd_DASD
rd.dasd

rdinitdebug rdnetdebug
rd.debug

rd_NO_DM
rd.dm=0

rd_DM_UUID
rd.dm.uuid

rdblacklist
rd.driver.blacklist

rdinsmodpost
rd.driver.post

rdloaddriver
rd.driver.pre

rd_NO_FSTAB
rd.fstab=0

rdinfo
rd.info

check
rd.live.check

rdlivedebug
rd.live.debug

live_dir
rd.live.dir

liveimg
rd.live.image

overlay
rd.live.overlay

readonly_overlay
rd.live.overlay.readonly

reset_overlay
rd.live.overlay.reset

live_ram
rd.live.ram

rd_NO_CRYPTTAB
rd.luks.crypttab=0

rd_LUKS_KEYDEV_UUID
rd.luks.keydev.uuid

rd_LUKS_KEYPATH
rd.luks.keypath

rd_NO_LUKS
rd.luks=0

rd_LUKS_UUID
rd.luks.uuid

rd_NO_LVMCONF
rd.lvm.conf

rd_LVM_LV
rd.lvm.lv

rd_NO_LVM
rd.lvm=0

rd_LVM_SNAPSHOT
rd.lvm.snapshot

rd_LVM_SNAPSIZE
rd.lvm.snapsize

rd_LVM_VG
rd.lvm.vg

rd_NO_MDADMCONF
rd.md.conf=0

rd_NO_MDIMSM
rd.md.imsm=0

rd_NO_MD
rd.md=0

rd_MD_UUID
rd.md.uuid

rd_NO_MULTIPATH: rd.multipath=0

rd_NFS_DOMAIN
rd.nfs.domain

iscsi_initiator
rd.iscsi.initiator

iscsi_target_name
rd.iscsi.target.name

iscsi_target_ip
rd.iscsi.target.ip

iscsi_target_port
rd.iscsi.target.port

iscsi_target_group
rd.iscsi.target.group

iscsi_username
rd.iscsi.username

iscsi_password
rd.iscsi.password

iscsi_in_username
rd.iscsi.in.username

iscsi_in_password
rd.iscsi.in.password

iscsi_firmware
rd.iscsi.firmware=0

rd_NO_PLYMOUTH
rd.plymouth=0

rd_retry
rd.retry

rdshell
rd.shell

rd_NO_SPLASH
rd.splash

rdudevdebug
rd.udev.debug

rdudevinfo
rd.udev.info

rd_NO_ZFCPCONF
rd.zfcp.conf=0

rd_ZFCP
rd.zfcp

rd_ZNET
rd.znet

KEYMAP
vconsole.keymap

KEYTABLE
vconsole.keymap

SYSFONT
vconsole.font

CONTRANS
vconsole.font.map

UNIMAP
vconsole.font.unimap

UNICODE
vconsole.unicode

EXT_KEYMAP
vconsole.keymap.ext

<a name="configuration-in-the-initramfs"></a>

### Configuration in the Initramfs


_/etc/conf.d/_
Any files found in
_/etc/conf.d/_
will be sourced in the initramfs to set initial values. Command line options will override these values set in the configuration files.

_/etc/cmdline_
Can contain additional command line options. Deprecated, better use /etc/cmdline.d/*.conf.

_/etc/cmdline.d/*.conf_
Can contain additional command line options.

<a name="author"></a>

# Author


Harald Hoyer

<a name="see-also"></a>

# See Also


**dracut**(8) **dracut.conf**(5)

<a name="notes"></a>

# Notes


*  1.  
  rfc4173
      http://tools.ietf.org/html/rfc4173#section-5
