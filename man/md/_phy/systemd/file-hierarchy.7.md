# file\-hierarchy(7)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

file-hierarchy - File system hierarchy overview

<a name="description"></a>

# Description


Operating systems using the
**systemd**(1)
system and service manager are organized based on a file system hierarchy inspired by UNIX, more specifically the hierarchy described in the
\m[blue]**File System Hierarchy**\m[]\s-2\u[1]\d\s+2
specification and
**hier**(7), with various extensions, partially documented in the
\m[blue]**XDG Base Directory Specification**\m[]\s-2\u[2]\d\s+2
and
\m[blue]**XDG User Directories**\m[]\s-2\u[3]\d\s+2. This manual page describes a more generalized, though minimal and modernized subset of these specifications that defines more strictly the suggestions and restrictions systemd makes on the file system hierarchy.

Many of the paths described here can be queried with the
**systemd-path**(1)
tool.

<a name="general-structure"></a>

# General Structure


/
The file system root. Usually writable, but this is not required. Possibly a temporary file system ("tmpfs"). Not shared with other hosts (unless read-only).

/boot/
The boot partition used for bringing up the system. On EFI systems, this is possibly the EFI System Partition (ESP), also see
**systemd-gpt-auto-generator**(8). This directory is usually strictly local to the host, and should be considered read-only, except when a new kernel or boot loader is installed. This directory only exists on systems that run on physical or emulated hardware that requires boot loaders.

/efi/
If the boot partition
/boot/
is maintained separately from the EFI System Partition (ESP), the latter is mounted here. Tools that need to operate on the EFI system partition should look for it at this mount point first, and fall back to
/boot/
— if the former doesnt qualify (for example if it is not a mount point or does not have the correct file system type
**MSDOS\_SUPER\_MAGIC**).

/etc/
System-specific configuration. This directory may or may not be read-only. Frequently, this directory is pre-populated with vendor-supplied configuration files, but applications should not make assumptions about this directory being fully populated or populated at all, and should fall back to defaults if configuration is missing.

/home/
The location for normal users home directories. Possibly shared with other systems, and never read-only. This directory should only be used for normal users, never for system users. This directory and possibly the directories contained within it might only become available or writable in late boot or even only after user authentication. This directory might be placed on limited-functionality network file systems, hence applications should not assume the full set of file API is available on this directory. Applications should generally not reference this directory directly, but via the per-user
_$HOME_
environment variable, or via the home directory field of the user database.

/root/
The home directory of the root user. The root users home directory is located outside of
/home/
in order to make sure the root user may log in even without
/home/
being available and mounted.

/srv/
The place to store general server payload, managed by the administrator. No restrictions are made how this directory is organized internally. Generally writable, and possibly shared among systems. This directory might become available or writable only very late during boot.

/tmp/
The place for small temporary files. This directory is usually mounted as a
"tmpfs"
instance, and should hence not be used for larger files. (Use
/var/tmp/
for larger files.) Since the directory is accessible to other users of the system, it is essential that this directory is only written to with the
**mkstemp**(3),
**mkdtemp**(3)
and related calls. This directory is usually flushed at boot-up. Also, files that are not accessed within a certain time are usually automatically deleted. If applications find the environment variable
_$TMPDIR_
set, they should prefer using the directory specified in it over directly referencing
/tmp/
(see
**environ**(7)
and
\m[blue]**IEEE Std 1003.1**\m[]\s-2\u[4]\d\s+2
for details).

<a name="runtime-data"></a>

# Runtime Data


/run/
A
"tmpfs"
file system for system packages to place runtime data in. This directory is flushed on boot, and generally writable for privileged programs only. Always writable.

/run/log/
Runtime system logs. System components may place private logs in this directory. Always writable, even when
/var/log/
might not be accessible yet.

/run/user/
Contains per-user runtime directories, each usually individually mounted
"tmpfs"
instances. Always writable, flushed at each reboot and when the user logs out. User code should not reference this directory directly, but via the
_$XDG\_RUNTIME\_DIR_
environment variable, as documented in the
\m[blue]**XDG Base Directory Specification**\m[]\s-2\u[2]\d\s+2.

<a name="vendor-supplied-operating-system-resources"></a>

# Vendor\-Supplied Operating System Resources


/usr/
Vendor-supplied operating system resources. Usually read-only, but this is not required. Possibly shared between multiple hosts. This directory should not be modified by the administrator, except when installing or removing vendor-supplied packages.

/usr/bin/
Binaries and executables for user commands that shall appear in the
_$PATH_
search path. It is recommended not to place binaries in this directory that are not useful for invocation from a shell (such as daemon binaries); these should be placed in a subdirectory of
/usr/lib/
instead.

/usr/include/
C and C++ API header files of system libraries.

/usr/lib/
Static, private vendor data that is compatible with all architectures (though not necessarily architecture-independent). Note that this includes internal executables or other binaries that are not regularly invoked from a shell. Such binaries may be for any architecture supported by the system. Do not place public libraries in this directory, use
_$libdir_
(see below), instead.

/usr/lib/_arch-id_/
Location for placing dynamic libraries into, also called
_$libdir_. The architecture identifier to use is defined on
\m[blue]**Multiarch Architecture Specifiers (Tuples)**\m[]\s-2\u[5]\d\s+2
list. Legacy locations of
_$libdir_
are
/usr/lib/,
/usr/lib64/. This directory should not be used for package-specific data, unless this data is architecture-dependent, too. To query
_$libdir_
for the primary architecture of the system, invoke:

.if n \{.RS 4
.\}
    # systemd-path system-library-arch
.if n \{.RE
.\}

/usr/share/
Resources shared between multiple packages, such as documentation, man pages, time zone information, fonts and other resources. Usually, the precise location and format of files stored below this directory is subject to specifications that ensure interoperability.

/usr/share/doc/
Documentation for the operating system or system packages.

/usr/share/factory/etc/
Repository for vendor-supplied default configuration files. This directory should be populated with pristine vendor versions of all configuration files that may be placed in
/etc/. This is useful to compare the local configuration of a system with vendor defaults and to populate the local configuration with defaults.

/usr/share/factory/var/
Similar to
/usr/share/factory/etc/, but for vendor versions of files in the variable, persistent data directory
/var/.

<a name="persistent-variable-system-data"></a>

# Persistent Variable System Data


/var/
Persistent, variable system data. Must be writable. This directory might be pre-populated with vendor-supplied data, but applications should be able to reconstruct necessary files and directories in this subhierarchy should they be missing, as the system might start up without this directory being populated. Persistency is recommended, but optional, to support ephemeral systems. This directory might become available or writable only very late during boot. Components that are required to operate during early boot hence shall not unconditionally rely on this directory.

/var/cache/
Persistent system cache data. System components may place non-essential data in this directory. Flushing this directory should have no effect on operation of programs, except for increased runtimes necessary to rebuild these caches.

/var/lib/
Persistent system data. System components may place private data in this directory.

/var/log/
Persistent system logs. System components may place private logs in this directory, though it is recommended to do most logging via the
**syslog**(3)
and
**sd\_journal\_print**(3)
calls.

/var/spool/
Persistent system spool data, such as printer or mail queues.

/var/tmp/
The place for larger and persistent temporary files. In contrast to
/tmp/, this directory is usually mounted from a persistent physical file system and can thus accept larger files. (Use
/tmp/
for smaller files.) This directory is generally not flushed at boot-up, but time-based cleanup of files that have not been accessed for a certain time is applied. The same security restrictions as with
/tmp/
apply, and hence only
**mkstemp**(3),
**mkdtemp**(3)
or similar calls should be used to make use of this directory. If applications find the environment variable
_$TMPDIR_
set, they should prefer using the directory specified in it over directly referencing
/var/tmp/
(see
**environ**(7)
for details).

<a name="virtual-kernel-and-api-file-systems"></a>

# Virtual Kernel and Api File Systems


/dev/
The root directory for device nodes. Usually, this directory is mounted as a
"devtmpfs"
instance, but might be of a different type in sandboxed/containerized setups. This directory is managed jointly by the kernel and
**systemd-udevd**(8), and should not be written to by other components. A number of special purpose virtual file systems might be mounted below this directory.

/dev/shm/
Place for POSIX shared memory segments, as created via
**shm\_open**(3). This directory is flushed on boot, and is a
"tmpfs"
file system. Since all users have write access to this directory, special care should be taken to avoid name clashes and vulnerabilities. For normal users, shared memory segments in this directory are usually deleted when the user logs out. Usually, it is a better idea to use memory mapped files in
/run/
(for system programs) or
_$XDG\_RUNTIME\_DIR_
(for user programs) instead of POSIX shared memory segments, since these directories are not world-writable and hence not vulnerable to security-sensitive name clashes.

/proc/
A virtual kernel file system exposing the process list and other functionality. This file system is mostly an API to interface with the kernel and not a place where normal files may be stored. For details, see
**proc**(5). A number of special purpose virtual file systems might be mounted below this directory.

/proc/sys/
A hierarchy below
/proc/
that exposes a number of kernel tunables. The primary way to configure the settings in this API file tree is via
**sysctl.d**(5)
files. In sandboxed/containerized setups, this directory is generally mounted read-only.

/sys/
A virtual kernel file system exposing discovered devices and other functionality. This file system is mostly an API to interface with the kernel and not a place where normal files may be stored. In sandboxed/containerized setups, this directory is generally mounted read-only. A number of special purpose virtual file systems might be mounted below this directory.

<a name="compatibility-symlinks"></a>

# Compatibility Symlinks


/bin/, /sbin/, /usr/sbin/
These compatibility symlinks point to
/usr/bin/, ensuring that scripts and binaries referencing these legacy paths correctly find their binaries.

/lib/
This compatibility symlink points to
/usr/lib/, ensuring that programs referencing this legacy path correctly find their resources.

/lib64/
On some architecture ABIs, this compatibility symlink points to
_$libdir_, ensuring that binaries referencing this legacy path correctly find their dynamic loader. This symlink only exists on architectures whose ABI places the dynamic loader in this path.

/var/run/
This compatibility symlink points to
/run/, ensuring that programs referencing this legacy path correctly find their runtime data.

<a name="home-directory"></a>

# Home Directory


User applications may want to place files and directories in the users home directory. They should follow the following basic structure. Note that some of these directories are also standardized (though more weakly) by the
\m[blue]**XDG Base Directory Specification**\m[]\s-2\u[2]\d\s+2. Additional locations for high-level user resources are defined by
\m[blue]**xdg-user-dirs**\m[]\s-2\u[3]\d\s+2.

~/.cache/
Persistent user cache data. User programs may place non-essential data in this directory. Flushing this directory should have no effect on operation of programs, except for increased runtimes necessary to rebuild these caches. If an application finds
_$XDG\_CACHE\_HOME_
set, it should use the directory specified in it instead of this directory.

~/.config/
Application configuration and state. When a new user is created, this directory will be empty or not exist at all. Applications should fall back to defaults should their configuration or state in this directory be missing. If an application finds
_$XDG\_CONFIG\_HOME_
set, it should use the directory specified in it instead of this directory.

~/.local/bin/
Executables that shall appear in the users
_$PATH_
search path. It is recommended not to place executables in this directory that are not useful for invocation from a shell; these should be placed in a subdirectory of
~/.local/lib/
instead. Care should be taken when placing architecture-dependent binaries in this place, which might be problematic if the home directory is shared between multiple hosts with different architectures.

~/.local/lib/
Static, private vendor data that is compatible with all architectures.

~/.local/lib/_arch-id_/
Location for placing public dynamic libraries. The architecture identifier to use is defined on
\m[blue]**Multiarch Architecture Specifiers (Tuples)**\m[]\s-2\u[5]\d\s+2
list.

~/.local/share/
Resources shared between multiple packages, such as fonts or artwork. Usually, the precise location and format of files stored below this directory is subject to specifications that ensure interoperability. If an application finds
_$XDG\_DATA\_HOME_
set, it should use the directory specified in it instead of this directory.

<a name="unprivileged-write-access"></a>

# Unprivileged Write Access


Unprivileged processes generally lack write access to most of the hierarchy.

The exceptions for normal users are
/tmp/,
/var/tmp/,
/dev/shm/, as well as the home directory
_$HOME_
(usually found below
/home/) and the runtime directory
_$XDG\_RUNTIME\_DIR_
(found below
/run/user/) of the user, which are all writable.

For unprivileged system processes, only
/tmp/,
/var/tmp/
and
/dev/shm/
are writable. If an unprivileged system process needs a private writable directory in
/var/
or
/run/, it is recommended to either create it before dropping privileges in the daemon code, to create it via
**tmpfiles.d**(5)
fragments during boot, or via the
_StateDirectory=_
and
_RuntimeDirectory=_
directives of service units (see
**systemd.unit**(5)
for details).

<a name="node-types"></a>

# Node Types


Unix file systems support different types of file nodes, including regular files, directories, symlinks, character and block device nodes, sockets and FIFOs.

It is strongly recommended that
/dev/
is the only location below which device nodes shall be placed. Similarly,
/run/
shall be the only location to place sockets and FIFOs. Regular files, directories and symlinks may be used in all directories.

<a name="system-packages"></a>

# System Packages


Developers of system packages should follow strict rules when placing their own files in the file system. The following table lists recommended locations for specific types of files supplied by the vendor.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;1.&nbsp;System Package Vendor Files Locations**
.TS
allbox tab(:);
lB lB.
T{
Directory
T}:T{
Purpose
T}
.T&
l l
l l
l l
l l
l l.
T{
/usr/bin/
T}:T{
Package executables that shall appear in the _$PATH_ executable search path, compiled for any of the supported architectures compatible with the operating system. It is not recommended to place internal binaries or binaries that are not commonly invoked from the shell in this directory, such as daemon binaries. As this directory is shared with most other packages of the system, special care should be taken to pick unique names for files placed here, that are unlikely to clash with other packages files.
T}
T{
/usr/lib/_arch-id_/
T}:T{
Public shared libraries of the package. As above, be careful with using too generic names, and pick unique names for your libraries to place here to avoid name clashes.
T}
T{
/usr/lib/_package_/
T}:T{
Private static vendor resources of the package, including private binaries and libraries, or any other kind of read-only vendor data.
T}
T{
/usr/lib/_arch-id_/_package_/
T}:T{
Private other vendor resources of the package that are architecture-specific and cannot be shared between architectures. Note that this generally does not include private executables since binaries of a specific architecture may be freely invoked from any other supported system architecture.
T}
T{
/usr/include/_package_/
T}:T{
Public C/C++ APIs of public shared libraries of the package.
T}
.TE


Additional static vendor files may be installed in the
/usr/share/
hierarchy to the locations defined by the various relevant specifications.

During runtime, and for local configuration and state, additional directories are defined:

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;2.&nbsp;System Package Variable Files Locations**
.TS
allbox tab(:);
lB lB.
T{
Directory
T}:T{
Purpose
T}
.T&
l l
l l
l l
l l
l l
l l
l l.
T{
/etc/_package_/
T}:T{
System-specific configuration for the package. It is recommended to default to safe fallbacks if this configuration is missing, if this is possible. Alternatively, a **tmpfiles.d**(5) fragment may be used to copy or symlink the necessary files and directories from /usr/share/factory/ during boot, via the "L" or "C" directives.
T}
T{
/run/_package_/
T}:T{
Runtime data for the package. Packages must be able to create the necessary subdirectories in this tree on their own, since the directory is flushed automatically on boot. Alternatively, a **tmpfiles.d**(5) fragment may be used to create the necessary directories during boot, or the _RuntimeDirectory=_ directive of service units may be used to create them at service startup (see **systemd.unit**(5) for details).
T}
T{
/run/log/_package_/
T}:T{
Runtime log data for the package. As above, the package needs to make sure to create this directory if necessary, as it will be flushed on every boot.
T}
T{
/var/cache/_package_/
T}:T{
Persistent cache data of the package. If this directory is flushed, the application should work correctly on next invocation, though possibly slowed down due to the need to rebuild any local cache files. The application must be capable of recreating this directory should it be missing and necessary. To create an empty directory, a **tmpfiles.d**(5) fragment or the _CacheDirectory=_ directive of service units (see **systemd.unit**(5)) may be used.
T}
T{
/var/lib/_package_/
T}:T{
Persistent private data of the package. This is the primary place to put persistent data that does not fall into the other categories listed. Packages should be able to create the necessary subdirectories in this tree on their own, since the directory might be missing on boot. To create an empty directory, a **tmpfiles.d**(5) fragment or the _StateDirectory=_ directive of service units (see **systemd.unit**(5)) may be used.
T}
T{
/var/log/_package_/
T}:T{
Persistent log data of the package. As above, the package should make sure to create this directory if necessary, possibly using **tmpfiles.d**(5) or _LogsDirectory=_ (see **systemd.unit**(5)), as it might be missing.
T}
T{
/var/spool/_package_/
T}:T{
Persistent spool/queue data of the package. As above, the package should make sure to create this directory if necessary, as it might be missing.
T}
.TE


<a name="user-packages"></a>

# User Packages


Programs running in user context should follow strict rules when placing their own files in the users home directory. The following table lists recommended locations in the home directory for specific types of files supplied by the vendor if the application is installed in the home directory. (Note, however, that user applications installed system-wide should follow the rules outlined above regarding placing vendor files.)

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;3.&nbsp;User Package Vendor File Locations**
.TS
allbox tab(:);
lB lB.
T{
Directory
T}:T{
Purpose
T}
.T&
l l
l l
l l
l l.
T{
~/.local/bin/
T}:T{
Package executables that shall appear in the _$PATH_ executable search path. It is not recommended to place internal executables or executables that are not commonly invoked from the shell in this directory, such as daemon executables. As this directory is shared with most other packages of the user, special care should be taken to pick unique names for files placed here, that are unlikely to clash with other packages files.
T}
T{
~/.local/lib/_arch-id_/
T}:T{
Public shared libraries of the package. As above, be careful with using too generic names, and pick unique names for your libraries to place here to avoid name clashes.
T}
T{
~/.local/lib/_package_/
T}:T{
Private, static vendor resources of the package, compatible with any architecture, or any other kind of read-only vendor data.
T}
T{
~/.local/lib/_arch-id_/_package_/
T}:T{
Private other vendor resources of the package that are architecture-specific and cannot be shared between architectures.
T}
.TE


Additional static vendor files may be installed in the
~/.local/share/
hierarchy to the locations defined by the various relevant specifications.

During runtime, and for local configuration and state, additional directories are defined:

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;4.&nbsp;User Package Variable File Locations**
.TS
allbox tab(:);
lB lB.
T{
Directory
T}:T{
Purpose
T}
.T&
l l
l l
l l.
T{
~/.config/_package_/
T}:T{
User-specific configuration and state for the package. It is required to default to safe fallbacks if this configuration is missing.
T}
T{
_$XDG\_RUNTIME\_DIR_/_package_/
T}:T{
User runtime data for the package.
T}
T{
~/.cache/_package_/
T}:T{
Persistent cache data of the package. If this directory is flushed, the application should work correctly on next invocation, though possibly slowed down due to the need to rebuild any local cache files. The application must be capable of recreating this directory should it be missing and necessary.
T}
.TE


<a name="see-also"></a>

# See Also


**systemd**(1),
**hier**(7),
**systemd-path**(1),
**systemd-gpt-auto-generator**(8),
**sysctl.d**(5),
**tmpfiles.d**(5),
**pkg-config**(1),
**systemd.unit**(5)

<a name="notes"></a>

# Notes


*  1.  
  File System Hierarchy
      http://refspecs.linuxfoundation.org/FHS_3.0/fhs-3.0.html
*  2.  
  XDG Base Directory Specification
      http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
*  3.  
  XDG User Directories
      https://www.freedesktop.org/wiki/Software/xdg-user-dirs/
*  4.  
  IEEE Std 1003.1
      http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap08.html#tag_08_03
*  5.  
  Multiarch Architecture Specifiers (Tuples)
      https://wiki.debian.org/Multiarch/Tuples
