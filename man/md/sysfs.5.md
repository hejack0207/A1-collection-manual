# sysfs(5) - a filesystem for exporting kernel objects

Linux, 2018-04-30


<a name="description"></a>

# Description

The
**sysfs**
filesystem is a pseudo-filesystem which provides an interface to
kernel data structures.
(More precisely, the files and directories in
**sysfs**
provide a view of the
_kobject_
structures defined internally within the kernel.)
The files under
**sysfs**
provide information about devices, kernel modules, filesystems,
and other kernel components.

The
**sysfs**
filesystem is commonly mounted at
_/sys_.
Typically, it is mounted automatically by the system,
but it can also be mounted manually using a command such as:

.in +4n
.EX
mount -t sysfs sysfs /sys
.EE
.in

Many of the files in the
**sysfs**
filesystem are read-only,
but some files are writable, allowing kernel variables to be changed.
To avoid redundancy,
symbolic links are heavily used to connect entries across the filesystem tree.


<a name="files-and-directories"></a>

### Files and directories

The following list describes some of the files and directories under the
_/sys_
hierarchy.

* _/sys/block_  
  This subdirectory contains one symbolic link for each block device
  that has been discovered on the system.
  The symbolic links point to corresponding directories under
  _/sys/devices_.
* _/sys/bus_  
  This directory contains one subdirectory for each of the bus types
  in the kernel.
  Inside each of these directories are two subdirectories:
    * _devices_  
      This subdirectory contains symbolic links to entries in
      _/sys/devices_
      that correspond to the devices discovered on this bus.
    * _drivers_  
      This subdirectory contains one subdirectory for each device driver
      that is loaded on this bus.
* _/sys/class_  
  This subdirectory contains a single layer of further subdirectories
  for each of the device classes that have been registered on the system
  (e.g., terminals, network devices, block devices, graphics devices,
  sound devices, and so on).
  Inside each of these subdirectories are symbolic links for each of the
  devices in this class.
  These symbolic links refer to entries in the
  _/sys/devices_
  directory.
* _/sys/class/net_  
  Each of the entries in this directory is a symbolic link
  representing one of the real or virtual networking devices
  that are visible in the network namespace of the process
  that is accessing the directory.
  Each of these symbolic links refers to entries in the
  _/sys/devices_
  directory.
* _/sys/dev_  
  This directory contains two subdirectories
  _block_/
  and
  _char/_,
  corresponding, respectively,
  to the block and character devices on the system.
  Inside each of these subdirectories are symbolic links with names of the form
  _major-ID_:_minor-ID_,
  where the ID values correspond to the major and minor ID of a specific device.
  Each symbolic link points to the
  **sysfs**
  directory for a device.
  The symbolic links inside
  _/sys/dev_
  thus provide an easy way to look up the
  **sysfs**
  interface using the device IDs returned by a call to
  **stat**(2)
  (or similar).
* The following shell session shows an example from
  _/sys/dev_:
* .in +4n
  .EX
  $ **stat -c "%t %T" /dev/null**
  1 3
  $ **readlink /sys/dev/char/1\​3**
  ../../devices/virtual/mem/null
  $ **ls -Fd /sys/devices/virtual/mem/null**
  /sys/devices/virtual/mem/null/
  $ **ls -d1 /sys/devices/virtual/mem/null/***
  /sys/devices/virtual/mem/null/dev
  /sys/devices/virtual/mem/null/power/
  /sys/devices/virtual/mem/null/subsystem@
  /sys/devices/virtual/mem/null/uevent
  .EE
  .in
* _/sys/devices_  
  This is a directory that contains a filesystem representation of
  the kernel device tree,
  which is a hierarchy of
  _device_
  structures within the kernel.
* _/sys/firmware_  
  This subdirectory contains interfaces for viewing and manipulating
  firmware-specific objects and attributes.
* _/sys/fs_  
  This directory contains subdirectories for some filesystems.
  A filesystem will have a subdirectory here only if it chose
  to explicitly create the subdirectory.
* _/sys/fs/cgroup_  
  This directory conventionally is used as a mount point for a
  **tmpfs**(5)
  filesystem containing mount points for
  **cgroups**(7)
  filesystems.
* _/sys/fs/smackfs_  
  The directory contains configuration files for the SMACK LSM.
  See the kernel source file
  _Documentation/admin-guide/LSM/Smack.rst_.
* _/sys/hypervisor_  
  [To be documented]
* _/sys/kernel_  
  This subdirectory contains various files and subdirectories that provide
  information about the running kernel.
* _/sys/kernel/cgroup/_  
  For information about the files in this directory, see
  **cgroups**(7).
* _/sys/kernel/debug/tracing_  
  Mount point for the
  _tracefs_
  filesystem used by the kernel's
  _ftrace_
  facility.
  (For information on
  _ftrace_,
  see the kernel source file
  _Documentation/trace/ftrace.txt_.)
* _/sys/kernel/mm_  
  This subdirectory contains various files and subdirectories that provide
  information about the kernel's memory management subsystem.
* _/sys/kernel/mm/hugepages_  
  This subdirectory contains one subdirectory for each of the
  huge page sizes that the system supports.
  The subdirectory name indicates the huge page size (e.g.,
  _hugepages-2048kB_).
  Within each of these subdirectories is a set of files
  that can be used to view and (in some cases) change settings
  associated with that huge page size.
  For further information, see the kernel source file
  _Documentation/vm/hugetlbpage.txt_.
* _/sys/module_  
  This subdirectory contains one subdirectory
  for each module that is loaded into the kernel.
  The name of each directory is the name of the module.
  In each of the subdirectories, there may be following files:
    * _coresize_  
      [to be documented]
    * _initsize_  
      [to be documented]
    * _initstate_  
      [to be documented]
    * _refcnt_  
      [to be documented]
    * _srcversion_  
      [to be documented]
    * _taint_  
      [to be documented]
    * _uevent_  
      [to be documented]
    * _version_  
      [to be documented]
* In each of the subdirectories, there may be following subdirectories:
    * _drivers_  
      [To be documented]
    * _holders_  
      [To be documented]
    * _notes_  
      [To be documented]
    * _parameters_  
      This directory contains one file for each module parameter,
      with each file containing the value of the corresponding parameter.
      Some of these files are writable, allowing the
    * _sections_  
      This subdirectories contains files with information about module sections.
      This information is mainly used for debugging.
    * .I  
      [To be documented]
* _/sys/power_  
  [To be documented]

<a name="versions"></a>

# Versions

The
**sysfs**
filesystem first appeared in Linux 2.6.0.

<a name="conforming-to"></a>

# Conforming to

The
**sysfs**
filesystem is Linux-specific.

<a name="notes"></a>

# Notes

This manual page is incomplete, possibly inaccurate, and is the kind
of thing that needs to be updated very often.

<a name="see-also"></a>

# See Also

**proc**(5),
**udev**(7)

P. Mochel. (2005).
_The sysfs filesystem_.
Proceedings of the 2005 Ottawa Linux Symposium.


The kernel source file
_Documentation/filesystems/sysfs.txt_
and various other files in
_Documentation/ABI_
and
_Documentation/*/sysfs.txt_

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
