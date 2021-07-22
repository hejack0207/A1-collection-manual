# initrd(4) - boot loader initialized RAM disk

Linux, 2017-09-15


<a name="configuration"></a>

# Configuration

_/dev/initrd_
is a read-only block device assigned
major number 1 and minor number 250.
Typically
_/dev/initrd_
is owned by
_root.disk_
with mode 0400 (read access by root only).
If the Linux system does not have
_/dev/initrd_
already created, it can be created with the following commands:

.in +4n
.EX
mknod -m 400 /dev/initrd b 1 250
chown root:disk /dev/initrd
.EE
.in

Also, support for both "RAM disk" and "Initial RAM disk"
(e.g.,
**CONFIG_BLK_DEV_RAM=y**
and
**CONFIG_BLK_DEV_INITRD=y**)
must be compiled directly into the Linux kernel to use
_/dev/initrd_.
When using
_/dev/initrd_,
the RAM disk driver cannot be loaded as a module.




<a name="description"></a>

# Description

The special file
_/dev/initrd_
is a read-only block device.
This device is a RAM disk that is initialized (e.g., loaded)
by the boot loader before the kernel is started.
The kernel then can use
_/dev/initrd_'s 
contents for a two-phase system boot-up.

In the first boot-up phase, the kernel starts up
and mounts an initial root filesystem from the contents of
_/dev/initrd_
(e.g., RAM disk initialized by the boot loader).
In the second phase, additional drivers or other modules
are loaded from the initial root device's contents.
After loading the additional modules, a new root filesystem
(i.e., the normal root filesystem) is mounted from a
different device.




<a name="boot-up-operation"></a>

### Boot-up operation

When booting up with
**initrd**,
the system boots as follows:

* 1.  
  The boot loader loads the kernel program and
  _/dev/initrd_'s
  contents into memory.
* 2.  
  On kernel startup,
  the kernel uncompresses and copies the contents of the device
  _/dev/initrd_
  onto device
  _/dev/ram0_
  and then frees the memory used by
  _/dev/initrd_.
* 3.  
  The kernel then read-write mounts the device
  _/dev/ram0_
  as the initial root filesystem.
* 4.  
  If the indicated normal root filesystem is also the initial
  root filesystem (e.g.,
  _/dev/ram0_)
  then the kernel skips to the last step for the usual boot sequence.
* 5.  
  If the executable file
  _/linuxrc_
  is present in the initial root filesystem,
  _/linuxrc_
  is executed with UID 0.
  (The file
  _/linuxrc_
  must have executable permission.
  The file
  _/linuxrc_
  can be any valid executable, including a shell script.)
* 6.  
  If
  _/linuxrc_
  is not executed or when
  _/linuxrc_
  terminates, the normal root filesystem is mounted.
  (If
  _/linuxrc_
  exits with any filesystems mounted on the initial root
  filesystem, then the behavior of the kernel is
  **UNSPECIFIED**.
  See the NOTES section for the current kernel behavior.)
* 7.  
  If the normal root filesystem has a directory
  _/initrd_,
  the device
  _/dev/ram0_
  is moved from
  _/_
  to
  _/initrd_.
  Otherwise, if the directory
  _/initrd_
  does not exist, the device
  _/dev/ram0_
  is unmounted.
  (When moved from
  _/_
  to
  _/initrd_,
  _/dev/ram0_
  is not unmounted and therefore processes can remain running from
  _/dev/ram0_.
  If directory
  _/initrd_
  does not exist on the normal root filesystem
  and any processes remain running from
  _/dev/ram0_
  when
  _/linuxrc_
  exits, the behavior of the kernel is
  **UNSPECIFIED**.
  See the NOTES section for the current kernel behavior.)
* 8.  
  The usual boot sequence (e.g., invocation of
  _/sbin/init_)
  is performed on the normal root filesystem.
  
  
  

<a name="options"></a>

### Options

The following boot loader options, when used with
**initrd**,
affect the kernel's boot-up operation:

* **initrd=**_filename_  
  Specifies the file to load as the contents of
  _/dev/initrd_.
  For
  **LOADLIN**
  this is a command-line option.
  For
  **LILO**
  you have to use this command in the
  **LILO**
  configuration file
  _/etc/lilo.config_.
  The filename specified with this
  option will typically be a gzipped filesystem image.
* _noinitrd_  
  This boot option disables the two-phase boot-up operation.
  The kernel performs the usual boot sequence as if
  _/dev/initrd_
  was not initialized.
  With this option, any contents of
  _/dev/initrd_
  loaded into memory by the boot loader contents are preserved.
  This option permits the contents of
  _/dev/initrd_
  to be any data and need not be limited to a filesystem image.
  However, device
  _/dev/initrd_
  is read-only and can be read only one time after system startup.
* **root=**_device-name_  
  Specifies the device to be used as the normal root filesystem.
  For
  **LOADLIN**
  this is a command-line option.
  For
  **LILO**
  this is a boot time option or
  can be used as an option line in the
  **LILO**
  configuration file
  _/etc/lilo.config_.
  The device specified by the this option must be a mountable
  device having a suitable root filesystem.
  
  
  

<a name="changing-the-normal-root-filesystem"></a>

### Changing the normal root filesystem

By default,
the kernel's settings
(e.g., set in the kernel file with
**rdev**(8)
or compiled into the kernel file),
or the boot loader option setting
is used for the normal root filesystems.
For an NFS-mounted normal root filesystem, one has to use the
**nfs_root_name**
and
**nfs_root_addrs**
boot options to give the NFS settings.
For more information on NFS-mounted root see the kernel documentation file
_Documentation/filesystems/nfs/nfsroot.txt_

(or
_Documentation/filesystems/nfsroot.txt_
before Linux 2.6.33).
For more information on setting the root filesystem see also the
**LILO**
and
**LOADLIN**
documentation.

It is also possible for the
_/linuxrc_
executable to change the normal root device.
For
_/linuxrc_
to change the normal root device,
_/proc_
must be mounted.
After mounting
_/proc_,
_/linuxrc_
changes the normal root device by writing into the proc files
_/proc/sys/kernel/real-root-dev_,
_/proc/sys/kernel/nfs-root-name_,
and
_/proc/sys/kernel/nfs-root-addrs_.
For a physical root device, the root device is changed by having
_/linuxrc_
write the new root filesystem device number into
_/proc/sys/kernel/real-root-dev_.
For an NFS root filesystem, the root device is changed by having
_/linuxrc_
write the NFS setting into files
_/proc/sys/kernel/nfs-root-name_
and
_/proc/sys/kernel/nfs-root-addrs_
and then writing 0xff (e.g., the pseudo-NFS-device number) into file
_/proc/sys/kernel/real-root-dev_.
For example, the following shell command line would change
the normal root device to
_/dev/hdb1_:

.in +4n
.EX
echo 0x365 &gt;/proc/sys/kernel/real-root-dev
.EE
.in

For an NFS example, the following shell command lines would change the
normal root device to the NFS directory
_/var/nfsroot_
on a local networked NFS server with IP number 193.8.232.7 for a system with
IP number 193.8.232.2 and named "idefix":

.in +4n
.EX
echo /var/nfsroot &gt;/proc/sys/kernel/nfs-root-name
echo 193.8.232.2:193.8.232.7::255.255.255.0:idefix &nbsp;   &gt;/proc/sys/kernel/nfs-root-addrs
echo 255 &gt;/proc/sys/kernel/real-root-dev
.EE
.in

**Note**:
The use of
_/proc/sys/kernel/real-root-dev_
to change the root filesystem is obsolete.
See the Linux kernel source file
_Documentation/admin-guide/initrd.rst_

(or
_Documentation/initrd.txt_
before Linux 4.10)
as well as
**pivot_root**(2)
and
**pivot_root**(8)
for information on the modern method of changing the root filesystem.





<a name="usage"></a>

### Usage

The main motivation for implementing
**initrd**
was to allow for modular kernel configuration at system installation.

A possible system installation scenario is as follows:

* 1.  
  The loader program boots from floppy or other media with a minimal kernel
  (e.g., support for
  _/dev/ram_,
  _/dev/initrd_,
  and the ext2 filesystem) and loads
  _/dev/initrd_
  with a gzipped version of the initial filesystem.
* 2.  
  The executable
  _/linuxrc_
  determines what is needed to (1) mount the normal root filesystem
  (i.e., device type, device drivers, filesystem) and (2) the
  distribution media (e.g., CD-ROM, network, tape, ...).
  This can be done by asking the user, by auto-probing,
  or by using a hybrid approach.
* 3.  
  The executable
  _/linuxrc_
  loads the necessary modules from the initial root filesystem.
* 4.  
  The executable
  _/linuxrc_
  creates and populates the root filesystem.
  (At this stage the normal root filesystem does not have to be a
  completed system yet.)
* 5.  
  The executable
  _/linuxrc_
  sets
  _/proc/sys/kernel/real-root-dev_,
  unmount
  _/proc_,
  the normal root filesystem and any other filesystems
  it has mounted, and then terminates.
* 6.  
  The kernel then mounts the normal root filesystem.
* 7.  
  Now that the filesystem is accessible and intact,
  the boot loader can be installed.
* 8.  
  The boot loader is configured to load into
  _/dev/initrd_
  a filesystem with the set of modules that was used to bring up the system.
  (e.g., Device
  _/dev/ram0_
  can be modified, then unmounted, and finally, the image is written from
  _/dev/ram0_
  to a file.)
* 9.  
  The system is now bootable and additional installation tasks can be
  performed.

The key role of
_/dev/initrd_
in the above is to reuse the configuration data during normal system operation
without requiring initial kernel selection, a large generic kernel or,
recompiling the kernel.

A second scenario is for installations where Linux runs on systems with
different hardware configurations in a single administrative network.
In such cases, it may be desirable to use only a small set of kernels
(ideally only one) and to keep the system-specific part of configuration
information as small as possible.
In this case, create a common file
with all needed modules.
Then, only the
_/linuxrc_
file or a file executed by
_/linuxrc_
would be different.

A third scenario is more convenient recovery disks.
Because information like the location of the root filesystem
partition is not needed at boot time, the system loaded from
_/dev/initrd_
can use a dialog and/or auto-detection followed by a
possible sanity check.

Last but not least, Linux distributions on CD-ROM may use
**initrd**
for easy installation from the CD-ROM.
The distribution can use
**LOADLIN**
to directly load
_/dev/initrd_
from CD-ROM without the need of any floppies.
The distribution could also use a
**LILO**
boot floppy and then bootstrap a bigger RAM disk via
_/dev/initrd_
from the CD-ROM.




<a name="files"></a>

# Files

_/dev/initrd_  
_/dev/ram0_  
_/linuxrc_  
_/initrd_




<a name="notes"></a>

# Notes


* 1.  
  With the current kernel, any filesystems that remain mounted when
  _/dev/ram0_
  is moved from
  _/_
  to
  _/initrd_
  continue to be accessible.
  However, the
  _/proc/mounts_
  entries are not updated.
* 2.  
  With the current kernel, if directory
  _/initrd_
  does not exist, then
  _/dev/ram0_
  will
  **not**
  be fully unmounted if
  _/dev/ram0_
  is used by any process or has any filesystem mounted on it.
  If
  _/dev/ram0_
  is
  **not**
  fully unmounted, then
  _/dev/ram0_
  will remain in memory.
* 3.  
  Users of
  _/dev/initrd_
  should not depend on the behavior give in the above notes.
  The behavior may change in future versions of the Linux kernel.
  
  
  
  
  
  
  
  
  
  
  

<a name="see-also"></a>

# See Also

**chown**(1),
**mknod**(1),
**ram**(4),
**freeramdisk**(8),
**rdev**(8)

_Documentation/admin-guide/initrd.rst_

(or
_Documentation/initrd.txt_
before Linux 4.10)
in the Linux kernel source tree, the LILO documentation,
the LOADLIN documentation, the SYSLINUX documentation

<a name="colophon"></a>

# Colophon

This page is part of release 4.16 of the Linux
_man-pages_
project.
A description of the project,
information about reporting bugs,
and the latest version of this page,
can be found at
https://www.kernel.org/doc/man-pages/.
