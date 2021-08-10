# dracut\&.conf(5)

dracut 1507b65, 09/29/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

dracut.conf - configuration file(s) for dracut

<a name="synopsis"></a>

# Synopsis

```

 /etc/dracut.conf /etc/dracut.conf.d/*.conf /usr/lib/dracut/dracut.conf.d/*.conf
```

<a name="description"></a>

# Description


_dracut.conf_ is loaded during the initialisation phase of dracut. Command line parameter will override any values set here.

_*.conf_ files are read from /usr/lib/dracut/dracut.conf.d and /etc/dracut.conf.d. Files with the same name in /etc/dracut.conf.d will replace files in /usr/lib/dracut/dracut.conf.d. The files are then read in alphanumerical order and will override parameters set in _/etc/dracut.conf_. Each line specifies an attribute and a value. A _#_ indicates the beginning of a comment; following characters, up to the end of the line are not interpreted.

dracut command line options will override any values set here.

Configuration files must have the extension .conf; other extensions are ignored.

**add\_dracutmodules+=**"&nbsp;_&lt;dracut modules&gt;_&nbsp;"
Add a space-separated list of dracut modules to call when building the initramfs. Modules are located in
_/usr/lib/dracut/modules.d_.

**dracutmodules+=**"&nbsp;_&lt;dracut modules&gt;_&nbsp;"
Specify a space-separated list of dracut modules to call when building the initramfs. Modules are located in
_/usr/lib/dracut/modules.d_. This option forces dracut to only include the specified dracut modules. In most cases the "add_dracutmodules" option is what you want to use.

**omit\_dracutmodules+=**"&nbsp;_&lt;dracut modules&gt;_&nbsp;"
Omit a space-separated list of dracut modules to call when building the initramfs. Modules are located in
_/usr/lib/dracut/modules.d_.

**drivers+=**"&nbsp;_&lt;kernel modules&gt;_&nbsp;"
Specify a space-separated list of kernel modules to exclusively include in the initramfs. The kernel modules have to be specified without the ".ko" suffix.

**add\_drivers+=**"&nbsp;_&lt;kernel modules&gt;_&nbsp;"
Specify a space-separated list of kernel modules to add to the initramfs. The kernel modules have to be specified without the ".ko" suffix.

**force\_drivers+=**"&nbsp;_&lt;list of kernel modules&gt;_&nbsp;"
See add_drivers above. But in this case it is ensured that the drivers are tried to be loaded early via modprobe.

**omit\_drivers+=**"&nbsp;_&lt;kernel modules&gt;_&nbsp;"
Specify a space-separated list of kernel modules not to add to the initramfs. The kernel modules have to be specified without the ".ko" suffix.

**filesystems+=**"&nbsp;_&lt;filesystem names&gt;_&nbsp;"
Specify a space-separated list of kernel filesystem modules to exclusively include in the generic initramfs.

**drivers\_dir=**"_&lt;kernel modules directory&gt;_"
Specify the directory, where to look for kernel modules

**fw\_dir+=**"&nbsp;:_&lt;dir&gt;_[:_&lt;dir&gt;_&nbsp;...]&nbsp;"
Specify additional directories, where to look for firmwares, separated by :

**install\_items+=**"&nbsp;_&lt;file&gt;_[ _&lt;file&gt;_&nbsp;...]&nbsp;"
Specify additional files to include in the initramfs, separated by spaces.

**install\_optional\_items+=**"&nbsp;_&lt;file&gt;_[ _&lt;file&gt;_&nbsp;...]&nbsp;"
Specify additional files to include in the initramfs, separated by spaces, if they exist.

**compress=**"_{cat|bzip2|lzma|xz|gzip|lzo|lz4|zstd|&lt;compressor [args ...]&gt;}_"
Compress the generated initramfs using the passed compression program. If you pass it just the name of a compression program, it will call that program with known-working arguments. If you pass arguments, it will be called with exactly those arguments. Depending on what you pass, this may result in an initramfs that the kernel cannot decompress. To disable compression, use "cat".

**do\_strip=**"_{yes|no}_"
Strip binaries in the initramfs (default=yes)

**hostonly=**"_{yes|no}_"
Host-Only mode: Install only what is needed for booting the local host instead of a generic host and generate host-specific configuration.

**hostonly\_cmdline=**"_{yes|no}_"
If set to "yes", store the kernel command line arguments needed in the initramfs

**persistent\_policy=**"_&lt;policy&gt;_"
Use
_&lt;policy&gt;_
to address disks and partitions.
_&lt;policy&gt;_
can be any directory name found in /dev/disk. E.g. "by-uuid", "by-label"

**tmpdir=**"_&lt;temporary directory&gt;_"
Specify temporary directory to use.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Warning**
.ps -1  

If chrooted to another root other than the real root device, use --fstab and provide a valid _/etc/fstab_.


**use\_fstab=**"_{yes|no}_"
Use
_/etc/fstab_
instead of
_/proc/self/mountinfo_.

**add\_fstab+=**"&nbsp;_&lt;filename&gt;_&nbsp;"
Add entries of
_&lt;filename&gt;_
to the initramfs /etc/fstab.

**add\_device+=**"&nbsp;_&lt;device&gt;_&nbsp;"
Bring up
_&lt;device&gt;_
in initramfs,
_&lt;device&gt;_
should be the device name. This can be useful in hostonly mode for resume support when your swap is on LVM an encrypted partition.

**mdadmconf=**"_{yes|no}_"
Include local
_/etc/mdadm.conf_
(default=yes)

**lvmconf=**"_{yes|no}_"
Include local
_/etc/lvm/lvm.conf_
(default=yes)

**fscks=**"&nbsp;_&lt;fsck tools&gt;_&nbsp;"
Add a space-separated list of fsck tools. If nothing is specified, the default is: "umount mount /sbin/fsck* xfs_db xfs_check xfs_repair e2fsck jfs_fsck reiserfsck btrfsck". The installation is opportunistic (non-existing tools are ignored).

**nofscks=**"_{yes|no}_"
If specified, inhibit installation of any fsck tools.

**ro\_mnt=**"_{yes|no}_"
Mount
_/_
and
_/usr_
read-only by default.

**kernel\_cmdline=**"_parameters_"
Specify default kernel command line parameters

**kernel\_only=**"_{yes|no}_"
Only install kernel drivers and firmware files. (default=no)

**no\_kernel=**"_{yes|no}_"
Do not install kernel drivers and firmware files (default=no)

**acpi\_override=**"_{yes|no}_"
[WARNING] ONLY USE THIS IF YOU KNOW WHAT YOU ARE DOING!

Override BIOS provided ACPI tables. For further documentation read Documentation/acpi/initrd_table_override.txt in the kernel sources. Search for ACPI table files (must have .aml suffix) in acpi_table_dir= directory (see below) and add them to a separate uncompressed cpio archive. This cpio archive gets glued (concatenated, uncompressed one must be the first one) to the compressed cpio archive. The first, uncompressed cpio archive is for data which the kernel must be able to access very early (and cannot make use of uncompress algorithms yet) like microcode or ACPI tables (default=no).

**acpi\_table\_dir=**"_&lt;dir&gt;_"
Directory to search for ACPI tables if acpi_override= is set to yes.

**early\_microcode=**"{yes|no}"
Combine early microcode with ramdisk (default=yes)

**stdloglvl**="_{0-6}_"
Set logging to standard error level.

**sysloglvl**="_{0-6}_"
Set logging to syslog level.

**fileloglvl=**"_{0-6}_"
Set logging to file level.

**logfile=**"_&lt;file&gt;_"
Path to log file.

**show\_modules=**"_{yes|no}_"
Print the name of the included modules to standard output during build.

**i18n\_vars=**"_&lt;variable mapping&gt;_"
Distribution specific variable mapping. See dracut/modules.d/10i18n/README for a detailed description.

**i18n\_default\_font=**"_&lt;fontname&gt;_"
The font &lt;fontname&gt; to install, if not specified otherwise. Default is "eurlatgr".

**i18n\_install\_all=**"_{yes|no}_"
Install everything regardless of generic or hostonly mode.

**reproducible=**"_{yes|no}_"
Create reproducible images.

**loginstall=**"_&lt;DIR&gt;_"
Log all files installed from the host to
_&lt;DIR&gt;_.

**uefi\_stub=**"_&lt;FILE&gt;_"
Specifies the UEFI stub loader, which will load the attached kernel, initramfs and kernel command line and boots the kernel. The default is
_/lib/systemd/boot/efi/linux&lt;EFI-MACHINE-TYPE-NAME&gt;.efi.stub_
or
_/usr/lib/gummiboot/linux&lt;EFI-MACHINE-TYPE-NAME&gt;.efi.stub_

**uefi\_splash\_image=**"_&lt;FILE&gt;_"
Specifies the UEFI stub loader’s splash image. Requires bitmap (**.bmp**) image format.

**uefi\_secureboot\_cert=**"_&lt;FILE&gt;_", **uefi\_secureboot\_key=**"_&lt;FILE&gt;_"
Specifies a certificate and corresponding key, which are used to sign the created UEFI executable. Requires both certificate and key need to be specified and
_sbsign_
to be installed.

**kernel\_image=**"_&lt;FILE&gt;_"
Specifies the kernel image, which to include in the UEFI executable. The default is
_/lib/modules/&lt;KERNEL-VERSION&gt;/vmlinuz_
or
_/boot/vmlinuz-&lt;KERNEL-VERSION&gt;_

<a name="files"></a>

# Files


_/etc/dracut.conf_
Old configuration file. You better use your own file in
_/etc/dracut.conf.d/_.

_/etc/dracut.conf.d/_
Any
_/etc/dracut.conf.d/*.conf_
file can override the values in
_/etc/dracut.conf_. The configuration files are read in alphanumerical order.

<a name="author"></a>

# Author


Harald Hoyer

<a name="see-also"></a>

# See Also


**dracut**(8) **dracut.cmdline**(7)
