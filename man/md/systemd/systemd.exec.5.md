# systemd\&.exec(5)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd.exec - Execution environment configuration

<a name="synopsis"></a>

# Synopsis

```

 service.service, socket.socket, mount.mount, swap.swap
```

<a name="description"></a>

# Description


Unit configuration files for services, sockets, mount points, and swap devices share a subset of configuration options which define the execution environment of spawned processes.

This man page lists the configuration options shared by these four unit types. See
**systemd.unit**(5)
for the common options of all unit configuration files, and
**systemd.service**(5),
**systemd.socket**(5),
**systemd.swap**(5), and
**systemd.mount**(5)
for more information on the specific unit configuration files. The execution specific configuration options are configured in the [Service], [Socket], [Mount], or [Swap] sections, depending on the unit type.

In addition, options which control resources through Linux Control Groups (cgroups) are listed in
**systemd.resource-control**(5). Those options complement options listed here.

<a name="implicit-dependencies"></a>

# Implicit Dependencies


A few execution parameters result in additional, automatic dependencies to be added:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Units with
  _WorkingDirectory=_,
  _RootDirectory=_,
  _RootImage=_,
  _RuntimeDirectory=_,
  _StateDirectory=_,
  _CacheDirectory=_,
  _LogsDirectory=_
  or
  _ConfigurationDirectory=_
  set automatically gain dependencies of type
  _Requires=_
  and
  _After=_
  on all mount units required to access the specified paths. This is equivalent to having them listed explicitly in
  _RequiresMountsFor=_.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Similar, units with
  _PrivateTmp=_
  enabled automatically get mount unit dependencies for all mounts required to access
  /tmp
  and
  /var/tmp. They will also gain an automatic
  _After=_
  dependency on
  **systemd-tmpfiles-setup.service**(8).

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Units whose standard output or error output is connected to
  **journal**,
  **syslog**
  or
  **kmsg**
  (or their combinations with console output, see below) automatically acquire dependencies of type
  _After=_
  on
  systemd-journald.socket.

<a name="paths"></a>

# Paths


The following settings may be used to change a services view of the filesystem. Please note that the paths must be absolute and must not contain a
".."
path component.

_WorkingDirectory=_
Takes a directory path relative to the services root directory specified by
_RootDirectory=_, or the special value
"~". Sets the working directory for executed processes. If set to
"~", the home directory of the user specified in
_User=_
is used. If not set, defaults to the root directory when systemd is running as a system instance and the respective users home directory if run as user. If the setting is prefixed with the
"-"
character, a missing working directory is not considered fatal. If
_RootDirectory=_/_RootImage=_
is not set, then
_WorkingDirectory=_
is relative to the root of the system running the service manager. Note that setting this parameter might result in additional dependencies to be added to the unit (see above).

_RootDirectory=_
Takes a directory path relative to the hosts root directory (i.e. the root of the system running the service manager). Sets the root directory for executed processes, with the
**chroot**(2)
system call. If this is used, it must be ensured that the process binary and all its auxiliary files are available in the
**chroot()**
jail. Note that setting this parameter might result in additional dependencies to be added to the unit (see above).

The
_MountAPIVFS=_
and
_PrivateUsers=_
settings are particularly useful in conjunction with
_RootDirectory=_. For details, see below.

This option is only available for system services and is not supported for services running in per-user instances of the service manager.

_RootImage=_
Takes a path to a block device node or regular file as argument. This call is similar to
_RootDirectory=_
however mounts a file system hierarchy from a block device node or loopback file instead of a directory. The device node or file system image file needs to contain a file system without a partition table, or a file system within an MBR/MS-DOS or GPT partition table with only a single Linux-compatible partition, or a set of file systems within a GPT partition table that follows the
\m[blue]**Discoverable Partitions Specification**\m[]\s-2\u[1]\d\s+2.

When
_DevicePolicy=_
is set to
"closed"
or
"strict", or set to
"auto"
and
_DeviceAllow=_
is set, then this setting adds
/dev/loop-control
with
**rw**
mode,
"block-loop"
and
"block-blkext"
with
**rwm**
mode to
_DeviceAllow=_. See
**systemd.resource-control**(5)
for the details about
_DevicePolicy=_
or
_DeviceAllow=_. Also, see
_PrivateDevices=_
below, as it may change the setting of
_DevicePolicy=_.

This option is only available for system services and is not supported for services running in per-user instances of the service manager.

_MountAPIVFS=_
Takes a boolean argument. If on, a private mount namespace for the units processes is created and the API file systems
/proc,
/sys, and
/dev
are mounted inside of it, unless they are already mounted. Note that this option has no effect unless used in conjunction with
_RootDirectory=_/_RootImage=_
as these three mounts are generally mounted in the host anyway, and unless the root directory is changed, the private mount namespace will be a 1:1 copy of the hosts, and include these three mounts. Note that the
/dev
file system of the host is bind mounted if this option is used without
_PrivateDevices=_. To run the service with a private, minimal version of
/dev/, combine this option with
_PrivateDevices=_.

This option is only available for system services and is not supported for services running in per-user instances of the service manager.

_BindPaths=_, _BindReadOnlyPaths=_
Configures unit-specific bind mounts. A bind mount makes a particular file or directory available at an additional place in the units view of the file system. Any bind mounts created with this option are specific to the unit, and are not visible in the host\*(Aqs mount table. This option expects a whitespace separated list of bind mount definitions. Each definition consists of a colon-separated triple of source path, destination path and option string, where the latter two are optional. If only a source path is specified the source and destination is taken to be the same. The option string may be either
"rbind"
or
"norbind"
for configuring a recursive or non-recursive bind mount. If the destination path is omitted, the option string must be omitted too. Each bind mount definition may be prefixed with
"-", in which case it will be ignored when its source path does not exist.

_BindPaths=_
creates regular writable bind mounts (unless the source file system mount is already marked read-only), while
_BindReadOnlyPaths=_
creates read-only bind mounts. These settings may be used more than once, each usage appends to the units list of bind mounts. If the empty string is assigned to either of these two options the entire list of bind mounts defined prior to this is reset. Note that in this case both read-only and regular bind mounts are reset, regardless which of the two settings is used.

This option is particularly useful when
_RootDirectory=_/_RootImage=_
is used. In this case the source path refers to a path on the host file system, while the destination path refers to a path below the root directory of the unit.

Note that the destination directory must exist or systemd must be able to create it. Thus, it is not possible to use those options for mount points nested underneath paths specified in
_InaccessiblePaths=_, or under
/home/
and other protected directories if
_ProtectHome=yes_
is specified.
_TemporaryFileSystem=_
with
":ro"
or
_ProtectHome=tmpfs_
should be used instead.

This option is only available for system services and is not supported for services running in per-user instances of the service manager.

<a name="credentials"></a>

# Credentials


These options are only available for system services and are not supported for services running in per-user instances of the service manager.

_User=_, _Group=_
Set the UNIX user or group that the processes are executed as, respectively. Takes a single user or group name, or a numeric ID as argument. For system services (services run by the system service manager, i.e. managed by PID 1) and for user services of the root user (services managed by roots instance of
**systemd --user**), the default is
"root", but
_User=_
may be used to specify a different user. For user services of any other user, switching user identity is not permitted, hence the only valid setting is the same user the users service manager is running as. If no group is set, the default group of the user is used. This setting does not affect commands whose command line is prefixed with
"+".

Note that restrictions on the user/group name syntax are enforced: the specified name must consist only of the characters a-z, A-Z, 0-9,
"_"
and
"-", except for the first character which must be one of a-z, A-Z or
"_"
(i.e. numbers and
"-"
are not permitted as first character). The user/group name must have at least one character, and at most 31. These restrictions are enforced in order to avoid ambiguities and to ensure user/group names and unit files remain portable among Linux systems.

When used in conjunction with
_DynamicUser=_
the user/group name specified is dynamically allocated at the time the service is started, and released at the time the service is stopped — unless it is already allocated statically (see below). If
_DynamicUser=_
is not used the specified user and group must have been created statically in the user database no later than the moment the service is started, for example using the
**sysusers.d**(5)
facility, which is applied at boot or package install time.

If the
_User=_
setting is used the supplementary group list is initialized from the specified users default group list, as defined in the system\*(Aqs user and group database. Additional groups may be configured through the
_SupplementaryGroups=_
setting (see below).

_DynamicUser=_
Takes a boolean parameter. If set, a UNIX user and group pair is allocated dynamically when the unit is started, and released as soon as it is stopped. The user and group will not be added to
/etc/passwd
or
/etc/group, but are managed transiently during runtime. The
**nss-systemd**(8)
glibc NSS module provides integration of these dynamic users/groups into the systems user and group databases. The user and group name to use may be configured via
_User=_
and
_Group=_
(see above). If these options are not used and dynamic user/group allocation is enabled for a unit, the name of the dynamic user/group is implicitly derived from the unit name. If the unit name without the type suffix qualifies as valid user name it is used directly, otherwise a name incorporating a hash of it is used. If a statically allocated user or group of the configured name already exists, it is used and no dynamic user/group is allocated. Note that if
_User=_
is specified and the static group with the name exists, then it is required that the static user with the name already exists. Similarly, if
_Group=_
is specified and the static user with the name exists, then it is required that the static group with the name already exists. Dynamic users/groups are allocated from the UID/GID range 61184...65519. It is recommended to avoid this range for regular system or login users. At any point in time each UID/GID from this range is only assigned to zero or one dynamically allocated users/groups in use. However, UID/GIDs are recycled after a unit is terminated. Care should be taken that any processes running as part of a unit for which dynamic users/groups are enabled do not leave files or directories owned by these users/groups around, as a different unit might get the same UID/GID assigned later on, and thus gain access to these files or directories. If
_DynamicUser=_
is enabled,
_RemoveIPC=_,
_PrivateTmp=_
are implied. This ensures that the lifetime of IPC objects and temporary files created by the executed processes is bound to the runtime of the service, and hence the lifetime of the dynamic user/group. Since
/tmp
and
/var/tmp
are usually the only world-writable directories on a system this ensures that a unit making use of dynamic user/group allocation cannot leave files around after unit termination. Moreover
_ProtectSystem=strict_
and
_ProtectHome=read-only_
are implied, thus prohibiting the service to write to arbitrary file system locations. In order to allow the service to write to certain directories, they have to be whitelisted using
_ReadWritePaths=_, but care must be taken so that UID/GID recycling doesnt create security issues involving files created by the service. Use
_RuntimeDirectory=_
(see below) in order to assign a writable runtime directory to a service, owned by the dynamic user/group and removed automatically when the unit is terminated. Use
_StateDirectory=_,
_CacheDirectory=_
and
_LogsDirectory=_
in order to assign a set of writable directories for specific purposes to the service in a way that they are protected from vulnerabilities due to UID reuse (see below). If this option is enabled, care should be taken that the units processes do not get access to directories outside of these explicitly configured and managed ones. Specifically, do not use
_BindPaths=_
and be careful with
**AF\_UNIX**
file descriptor passing for directory file descriptors, as this would permit processes to create files or directories owned by the dynamic user/group that are not subject to the life-cycle and access guarantees of the service. Defaults to off.

_SupplementaryGroups=_
Sets the supplementary Unix groups the processes are executed as. This takes a space-separated list of group names or IDs. This option may be specified more than once, in which case all listed groups are set as supplementary groups. When the empty string is assigned, the list of supplementary groups is reset, and all assignments prior to this one will have no effect. In any way, this option does not override, but extends the list of supplementary groups configured in the system group database for the user. This does not affect commands prefixed with
"+".

_PAMName=_
Sets the PAM service name to set up a session as. If set, the executed process will be registered as a PAM session under the specified service name. This is only useful in conjunction with the
_User=_
setting, and is otherwise ignored. If not set, no PAM session will be opened for the executed processes. See
**pam**(8)
for details.

Note that for each unit making use of this option a PAM session handler process will be maintained as part of the unit and stays around as long as the unit is active, to ensure that appropriate actions can be taken when the unit and hence the PAM session terminates. This process is named
"(sd-pam)"
and is an immediate child process of the units main process.

Note that when this option is used for a unit it is very likely (depending on PAM configuration) that the main unit process will be migrated to its own session scope unit when it is activated. This process will hence be associated with two units: the unit it was originally started from (and for which
_PAMName=_
was configured), and the session scope unit. Any child processes of that process will however be associated with the session scope unit only. This has implications when used in combination with
_NotifyAccess=_**all**, as these child processes will not be able to affect changes in the original unit through notification messages. These messages will be considered belonging to the session scope unit and not the original unit. It is hence not recommended to use
_PAMName=_
in combination with
_NotifyAccess=_**all**.

<a name="capabilities"></a>

# Capabilities


These options are only available for system services and are not supported for services running in per-user instances of the service manager.

_CapabilityBoundingSet=_
Controls which capabilities to include in the capability bounding set for the executed process. See
**capabilities**(7)
for details. Takes a whitespace-separated list of capability names, e.g.
**CAP\_SYS\_ADMIN**,
**CAP\_DAC\_OVERRIDE**,
**CAP\_SYS\_PTRACE**. Capabilities listed will be included in the bounding set, all others are removed. If the list of capabilities is prefixed with
"~", all but the listed capabilities will be included, the effect of the assignment inverted. Note that this option also affects the respective capabilities in the effective, permitted and inheritable capability sets. If this option is not used, the capability bounding set is not modified on process execution, hence no limits on the capabilities of the process are enforced. This option may appear more than once, in which case the bounding sets are merged by
**OR**, or by
**AND**
if the lines are prefixed with
"~"
(see below). If the empty string is assigned to this option, the bounding set is reset to the empty capability set, and all prior settings have no effect. If set to
"~"
(without any further argument), the bounding set is reset to the full set of available capabilities, also undoing any previous settings. This does not affect commands prefixed with
"+".

Example: if a unit has the following,

.if n \{.RS 4
.\}
    CapabilityBoundingSet=CAP_A CAP_B
    CapabilityBoundingSet=CAP_B CAP_C
.if n \{.RE
.\}

then
**CAP\_A**,
**CAP\_B**, and
**CAP\_C**
are set. If the second line is prefixed with
"~", e.g.,

.if n \{.RS 4
.\}
    CapabilityBoundingSet=CAP_A CAP_B
    CapabilityBoundingSet=~CAP_B CAP_C
.if n \{.RE
.\}

then, only
**CAP\_A**
is set.

_AmbientCapabilities=_
Controls which capabilities to include in the ambient capability set for the executed process. Takes a whitespace-separated list of capability names, e.g.
**CAP\_SYS\_ADMIN**,
**CAP\_DAC\_OVERRIDE**,
**CAP\_SYS\_PTRACE**. This option may appear more than once in which case the ambient capability sets are merged (see the above examples in
_CapabilityBoundingSet=_). If the list of capabilities is prefixed with
"~", all but the listed capabilities will be included, the effect of the assignment inverted. If the empty string is assigned to this option, the ambient capability set is reset to the empty capability set, and all prior settings have no effect. If set to
"~"
(without any further argument), the ambient capability set is reset to the full set of available capabilities, also undoing any previous settings. Note that adding capabilities to ambient capability set adds them to the processs inherited capability set.

Ambient capability sets are useful if you want to execute a process as a non-privileged user but still want to give it some capabilities. Note that in this case option
**keep-caps**
is automatically added to
_SecureBits=_
to retain the capabilities over the user change.
_AmbientCapabilities=_
does not affect commands prefixed with
"+".

<a name="security"></a>

# Security


_NoNewPrivileges=_
Takes a boolean argument. If true, ensures that the service process and all its children can never gain new privileges through
**execve()**
(e.g. via setuid or setgid bits, or filesystem capabilities). This is the simplest and most effective way to ensure that a process and its children can never elevate privileges again. Defaults to false, but certain settings override this and ignore the value of this setting. This is the case when
_SystemCallFilter=_,
_SystemCallArchitectures=_,
_RestrictAddressFamilies=_,
_RestrictNamespaces=_,
_PrivateDevices=_,
_ProtectKernelTunables=_,
_ProtectKernelModules=_,
_MemoryDenyWriteExecute=_,
_RestrictRealtime=_,
_RestrictSUIDSGID=_
or
_LockPersonality=_
are specified. Note that even if this setting is overridden by them,
**systemctl show**
shows the original value of this setting. Also see
\m[blue]**No New Privileges Flag**\m[]\s-2\u[2]\d\s+2.

_SecureBits=_
Controls the secure bits set for the executed process. Takes a space-separated combination of options from the following list:
**keep-caps**,
**keep-caps-locked**,
**no-setuid-fixup**,
**no-setuid-fixup-locked**,
**noroot**, and
**noroot-locked**. This option may appear more than once, in which case the secure bits are ORed. If the empty string is assigned to this option, the bits are reset to 0. This does not affect commands prefixed with
"+". See
**capabilities**(7)
for details.

<a name="mandatory-access-control"></a>

# Mandatory Access Control


These options are only available for system services and are not supported for services running in per-user instances of the service manager.

_SELinuxContext=_
Set the SELinux security context of the executed process. If set, this will override the automated domain transition. However, the policy still needs to authorize the transition. This directive is ignored if SELinux is disabled. If prefixed by
"-", all errors will be ignored. This does not affect commands prefixed with
"+". See
**setexeccon**(3)
for details.

_AppArmorProfile=_
Takes a profile name as argument. The process executed by the unit will switch to this profile when started. Profiles must already be loaded in the kernel, or the unit will fail. This result in a non operation if AppArmor is not enabled. If prefixed by
"-", all errors will be ignored. This does not affect commands prefixed with
"+".

_SmackProcessLabel=_
Takes a
**SMACK64**
security label as argument. The process executed by the unit will be started under this label and SMACK will decide whether the process is allowed to run or not, based on it. The process will continue to run under the label specified here unless the executable has its own
**SMACK64EXEC**
label, in which case the process will transition to run under that label. When not specified, the label that systemd is running under is used. This directive is ignored if SMACK is disabled.

The value may be prefixed by
"-", in which case all errors will be ignored. An empty value may be specified to unset previous assignments. This does not affect commands prefixed with
"+".

<a name="process-properties"></a>

# Process Properties


_LimitCPU=_, _LimitFSIZE=_, _LimitDATA=_, _LimitSTACK=_, _LimitCORE=_, _LimitRSS=_, _LimitNOFILE=_, _LimitAS=_, _LimitNPROC=_, _LimitMEMLOCK=_, _LimitLOCKS=_, _LimitSIGPENDING=_, _LimitMSGQUEUE=_, _LimitNICE=_, _LimitRTPRIO=_, _LimitRTTIME=_
Set soft and hard limits on various resources for executed processes. See
**setrlimit**(2)
for details on the resource limit concept. Resource limits may be specified in two formats: either as single value to set a specific soft and hard limit to the same value, or as colon-separated pair
**soft:hard**
to set both limits individually (e.g.
"LimitAS=4G:16G"). Use the string
**infinity**
to configure no limit on a specific resource. The multiplicative suffixes K, M, G, T, P and E (to the base 1024) may be used for resource limits measured in bytes (e.g. LimitAS=16G). For the limits referring to time values, the usual time units ms, s, min, h and so on may be used (see
**systemd.time**(7)
for details). Note that if no time unit is specified for
_LimitCPU=_
the default unit of seconds is implied, while for
_LimitRTTIME=_
the default unit of microseconds is implied. Also, note that the effective granularity of the limits might influence their enforcement. For example, time limits specified for
_LimitCPU=_
will be rounded up implicitly to multiples of 1s. For
_LimitNICE=_
the value may be specified in two syntaxes: if prefixed with
"+"
or
"-", the value is understood as regular Linux nice value in the range -20..19. If not prefixed like this the value is understood as raw resource limit parameter in the range 0..40 (with 0 being equivalent to 1).

Note that most process resource limits configured with these options are per-process, and processes may fork in order to acquire a new set of resources that are accounted independently of the original process, and may thus escape limits set. Also note that
_LimitRSS=_
is not implemented on Linux, and setting it has no effect. Often it is advisable to prefer the resource controls listed in
**systemd.resource-control**(5)
over these per-process limits, as they apply to services as a whole, may be altered dynamically at runtime, and are generally more expressive. For example,
_MemoryLimit=_
is a more powerful (and working) replacement for
_LimitRSS=_.

For system units these resource limits may be chosen freely. For user units however (i.e. units run by a per-user instance of
**systemd**(1)), these limits are bound by (possibly more restrictive) per-user limits enforced by the OS.

Resource limits not configured explicitly for a unit default to the value configured in the various
_DefaultLimitCPU=_,
_DefaultLimitFSIZE=_, ... options available in
**systemd-system.conf**(5), and – if not configured there – the kernel or per-user defaults, as defined by the OS (the latter only for user services, see above).

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;1.&nbsp;Resource limit directives, their equivalent ulimit shell commands and the unit used**
.TS
allbox tab(:);
lB lB lB.
T{
Directive
T}:T{
**ulimit** equivalent
T}:T{
Unit
T}
.T&
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l.
T{
LimitCPU=
T}:T{
ulimit -t
T}:T{
Seconds
T}
T{
LimitFSIZE=
T}:T{
ulimit -f
T}:T{
Bytes
T}
T{
LimitDATA=
T}:T{
ulimit -d
T}:T{
Bytes
T}
T{
LimitSTACK=
T}:T{
ulimit -s
T}:T{
Bytes
T}
T{
LimitCORE=
T}:T{
ulimit -c
T}:T{
Bytes
T}
T{
LimitRSS=
T}:T{
ulimit -m
T}:T{
Bytes
T}
T{
LimitNOFILE=
T}:T{
ulimit -n
T}:T{
Number of File Descriptors
T}
T{
LimitAS=
T}:T{
ulimit -v
T}:T{
Bytes
T}
T{
LimitNPROC=
T}:T{
ulimit -u
T}:T{
Number of Processes
T}
T{
LimitMEMLOCK=
T}:T{
ulimit -l
T}:T{
Bytes
T}
T{
LimitLOCKS=
T}:T{
ulimit -x
T}:T{
Number of Locks
T}
T{
LimitSIGPENDING=
T}:T{
ulimit -i
T}:T{
Number of Queued Signals
T}
T{
LimitMSGQUEUE=
T}:T{
ulimit -q
T}:T{
Bytes
T}
T{
LimitNICE=
T}:T{
ulimit -e
T}:T{
Nice Level
T}
T{
LimitRTPRIO=
T}:T{
ulimit -r
T}:T{
Realtime Priority
T}
T{
LimitRTTIME=
T}:T{
No equivalent
T}:T{
Microseconds
T}
.TE


_UMask=_
Controls the file mode creation mask. Takes an access mode in octal notation. See
**umask**(2)
for details. Defaults to 0022.

_KeyringMode=_
Controls how the kernel session keyring is set up for the service (see
**session-keyring**(7)
for details on the session keyring). Takes one of
**inherit**,
**private**,
**shared**. If set to
**inherit**
no special keyring setup is done, and the kernels default behaviour is applied. If
**private**
is used a new session keyring is allocated when a service process is invoked, and it is not linked up with any user keyring. This is the recommended setting for system services, as this ensures that multiple services running under the same system user ID (in particular the root user) do not share their key material among each other. If
**shared**
is used a new session keyring is allocated as for
**private**, but the user keyring of the user configured with
_User=_
is linked into it, so that keys assigned to the user may be requested by the units processes. In this modes multiple units running processes under the same user ID may share key material. Unless
**inherit**
is selected the unique invocation ID for the unit (see below) is added as a protected key by the name
"invocation_id"
to the newly created session keyring. Defaults to
**private**
for services of the system service manager and to
**inherit**
for non-service units and for services of the user service manager.

_OOMScoreAdjust=_
Sets the adjustment level for the Out-Of-Memory killer for executed processes. Takes an integer between -1000 (to disable OOM killing for this process) and 1000 (to make killing of this process under memory pressure very likely). See
\m[blue]**proc.txt**\m[]\s-2\u[3]\d\s+2
for details.

_TimerSlackNSec=_
Sets the timer slack in nanoseconds for the executed processes. The timer slack controls the accuracy of wake-ups triggered by timers. See
**prctl**(2)
for more information. Note that in contrast to most other time span definitions this parameter takes an integer value in nano-seconds if no unit is specified. The usual time units are understood too.

_Personality=_
Controls which kernel architecture
**uname**(2)
shall report, when invoked by unit processes. Takes one of the architecture identifiers
**x86**,
**x86-64**,
**ppc**,
**ppc-le**,
**ppc64**,
**ppc64-le**,
**s390**
or
**s390x**. Which personality architectures are supported depends on the system architecture. Usually the 64bit versions of the various system architectures support their immediate 32bit personality architecture counterpart, but no others. For example,
**x86-64**
systems support the
**x86-64**
and
**x86**
personalities but no others. The personality feature is useful when running 32-bit services on a 64-bit host system. If not specified, the personality is left unmodified and thus reflects the personality of the host systems kernel.

_IgnoreSIGPIPE=_
Takes a boolean argument. If true, causes
**SIGPIPE**
to be ignored in the executed process. Defaults to true because
**SIGPIPE**
generally is useful only in shell pipelines.

<a name="scheduling"></a>

# Scheduling


_Nice=_
Sets the default nice level (scheduling priority) for executed processes. Takes an integer between -20 (highest priority) and 19 (lowest priority). See
**setpriority**(2)
for details.

_CPUSchedulingPolicy=_
Sets the CPU scheduling policy for executed processes. Takes one of
**other**,
**batch**,
**idle**,
**fifo**
or
**rr**. See
**sched\_setscheduler**(2)
for details.

_CPUSchedulingPriority=_
Sets the CPU scheduling priority for executed processes. The available priority range depends on the selected CPU scheduling policy (see above). For real-time scheduling policies an integer between 1 (lowest priority) and 99 (highest priority) can be used. See
**sched\_setscheduler**(2)
for details.

_CPUSchedulingResetOnFork=_
Takes a boolean argument. If true, elevated CPU scheduling priorities and policies will be reset when the executed processes fork, and can hence not leak into child processes. See
**sched\_setscheduler**(2)
for details. Defaults to false.

_CPUAffinity=_
Controls the CPU affinity of the executed processes. Takes a list of CPU indices or ranges separated by either whitespace or commas. CPU ranges are specified by the lower and upper CPU indices separated by a dash. This option may be specified more than once, in which case the specified CPU affinity masks are merged. If the empty string is assigned, the mask is reset, all assignments prior to this will have no effect. See
**sched\_setaffinity**(2)
for details.

_IOSchedulingClass=_
Sets the I/O scheduling class for executed processes. Takes an integer between 0 and 3 or one of the strings
**none**,
**realtime**,
**best-effort**
or
**idle**. If the empty string is assigned to this option, all prior assignments to both
_IOSchedulingClass=_
and
_IOSchedulingPriority=_
have no effect. See
**ioprio\_set**(2)
for details.

_IOSchedulingPriority=_
Sets the I/O scheduling priority for executed processes. Takes an integer between 0 (highest priority) and 7 (lowest priority). The available priorities depend on the selected I/O scheduling class (see above). If the empty string is assigned to this option, all prior assignments to both
_IOSchedulingClass=_
and
_IOSchedulingPriority=_
have no effect. See
**ioprio\_set**(2)
for details.

<a name="sandboxing"></a>

# Sandboxing


The following sandboxing options are an effective way to limit the exposure of the system towards the units processes. It is recommended to turn on as many of these options for each unit as is possible without negatively affecting the process\*(Aq ability to operate. Note that many of these sandboxing features are gracefully turned off on systems where the underlying security mechanism is not available. For example,
_ProtectSystem=_
has no effect if the kernel is built without file system namespacing or if the service manager runs in a container manager that makes file system namespacing unavailable to its payload. Similar,
_RestrictRealtime=_
has no effect on systems that lack support for SECCOMP system call filtering, or in containers where support for this is turned off.

Also note that some sandboxing functionality is generally not available in user services (i.e. services run by the per-user service manager). Specifically, the various settings requiring file system namespacing support (such as
_ProtectSystem=_) are not available, as the underlying kernel functionality is only accessible to privileged processes.

_ProtectSystem=_
Takes a boolean argument or the special values
"full"
or
"strict". If true, mounts the
/usr
and
/boot
directories read-only for processes invoked by this unit. If set to
"full", the
/etc
directory is mounted read-only, too. If set to
"strict"
the entire file system hierarchy is mounted read-only, except for the API file system subtrees
/dev,
/proc
and
/sys
(protect these directories using
_PrivateDevices=_,
_ProtectKernelTunables=_,
_ProtectControlGroups=_). This setting ensures that any modification of the vendor-supplied operating system (and optionally its configuration, and local mounts) is prohibited for the service. It is recommended to enable this setting for all long-running services, unless they are involved with system updates or need to modify the operating system in other ways. If this option is used,
_ReadWritePaths=_
may be used to exclude specific directories from being made read-only. This setting is implied if
_DynamicUser=_
is set. This setting cannot ensure protection in all cases. In general it has the same limitations as
_ReadOnlyPaths=_, see below. Defaults to off.

_ProtectHome=_
Takes a boolean argument or the special values
"read-only"
or
"tmpfs". If true, the directories
/home,
/root, and
/run/user
are made inaccessible and empty for processes invoked by this unit. If set to
"read-only", the three directories are made read-only instead. If set to
"tmpfs", temporary file systems are mounted on the three directories in read-only mode. The value
"tmpfs"
is useful to hide home directories not relevant to the processes invoked by the unit, while still allowing necessary directories to be made visible when listed in
_BindPaths=_
or
_BindReadOnlyPaths=_.

Setting this to
"yes"
is mostly equivalent to set the three directories in
_InaccessiblePaths=_. Similarly,
"read-only"
is mostly equivalent to
_ReadOnlyPaths=_, and
"tmpfs"
is mostly equivalent to
_TemporaryFileSystem=_
with
":ro".

It is recommended to enable this setting for all long-running services (in particular network-facing ones), to ensure they cannot get access to private user data, unless the services actually require access to the users private data. This setting is implied if
_DynamicUser=_
is set. This setting cannot ensure protection in all cases. In general it has the same limitations as
_ReadOnlyPaths=_, see below.

This option is only available for system services and is not supported for services running in per-user instances of the service manager.

_RuntimeDirectory=_, _StateDirectory=_, _CacheDirectory=_, _LogsDirectory=_, _ConfigurationDirectory=_
These options take a whitespace-separated list of directory names. The specified directory names must be relative, and may not include
"..". If set, one or more directories by the specified names will be created (including their parents) below the locations defined in the following table, when the unit is started. Also, the corresponding environment variable is defined with the full path of directories. If multiple directories are set, then in the environment variable the paths are concatenated with colon (":").

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;2.&nbsp;Automatic directory creation and environment variables**
.TS
allbox tab(:);
lB lB lB lB.
T{
Locations
T}:T{
for system
T}:T{
for users
T}:T{
Environment variable
T}
.T&
l l l l
l l l l
l l l l
l l l l
l l l l.
T{
_RuntimeDirectory=_
T}:T{
/run
T}:T{
_$XDG\_RUNTIME\_DIR_
T}:T{
_$RUNTIME\_DIRECTORY_
T}
T{
_StateDirectory=_
T}:T{
/var/lib
T}:T{
_$XDG\_CONFIG\_HOME_
T}:T{
_$STATE\_DIRECTORY_
T}
T{
_CacheDirectory=_
T}:T{
/var/cache
T}:T{
_$XDG\_CACHE\_HOME_
T}:T{
_$CACHE\_DIRECTORY_
T}
T{
_LogsDirectory=_
T}:T{
/var/log
T}:T{
_$XDG\_CONFIG\_HOME_/log
T}:T{
_$LOGS\_DIRECTORY_
T}
T{
_ConfigurationDirectory=_
T}:T{
/etc
T}:T{
_$XDG\_CONFIG\_HOME_
T}:T{
_$CONFIGURATION\_DIRECTORY_
T}
.TE

In case of
_RuntimeDirectory=_
the lowest subdirectories are removed when the unit is stopped. It is possible to preserve the specified directories in this case if
_RuntimeDirectoryPreserve=_
is configured to
**restart**
or
**yes**
(see below). The directories specified with
_StateDirectory=_,
_CacheDirectory=_,
_LogsDirectory=_,
_ConfigurationDirectory=_
are not removed when the unit is stopped.

Except in case of
_ConfigurationDirectory=_, the innermost specified directories will be owned by the user and group specified in
_User=_
and
_Group=_. If the specified directories already exist and their owning user or group do not match the configured ones, all files and directories below the specified directories as well as the directories themselves will have their file ownership recursively changed to match what is configured. As an optimization, if the specified directories are already owned by the right user and group, files and directories below of them are left as-is, even if they do not match what is requested. The innermost specified directories will have their access mode adjusted to the what is specified in
_RuntimeDirectoryMode=_,
_StateDirectoryMode=_,
_CacheDirectoryMode=_,
_LogsDirectoryMode=_
and
_ConfigurationDirectoryMode=_.

These options imply
_BindPaths=_
for the specified paths. When combined with
_RootDirectory=_
or
_RootImage=_
these paths always reside on the host and are mounted from there into the units file system namespace.

If
_DynamicUser=_
is used in conjunction with
_StateDirectory=_,
_CacheDirectory=_
and
_LogsDirectory=_
is slightly altered: the directories are created below
/var/lib/private,
/var/cache/private
and
/var/log/private, respectively, which are host directories made inaccessible to unprivileged users, which ensures that access to these directories cannot be gained through dynamic user ID recycling. Symbolic links are created to hide this difference in behaviour. Both from perspective of the host and from inside the unit, the relevant directories hence always appear directly below
/var/lib,
/var/cache
and
/var/log.

Use
_RuntimeDirectory=_
to manage one or more runtime directories for the unit and bind their lifetime to the daemon runtime. This is particularly useful for unprivileged daemons that cannot create runtime directories in
/run
due to lack of privileges, and to make sure the runtime directory is cleaned up automatically after use. For runtime directories that require more complex or different configuration or lifetime guarantees, please consider using
**tmpfiles.d**(5).

The directories defined by these options are always created under the standard paths used by systemd (/var,
/run,
/etc, ...). If the service needs directories in a different location, a different mechanism has to be used to create them.

**tmpfiles.d**(5)
provides functionality that overlaps with these options. Using these options is recommended, because the lifetime of the directories is tied directly to the lifetime of the unit, and it is not necessary to ensure that the
tmpfiles.d
configuration is executed before the unit is started.

Example: if a system service unit has the following,

.if n \{.RS 4
.\}
    RuntimeDirectory=foo/bar baz
.if n \{.RE
.\}

the service manager creates
/run/foo
(if it does not exist),
/run/foo/bar, and
/run/baz. The directories
/run/foo/bar
and
/run/baz
except
/run/foo
are owned by the user and group specified in
_User=_
and
_Group=_, and removed when the service is stopped.

Example: if a system service unit has the following,

.if n \{.RS 4
.\}
    RuntimeDirectory=foo/bar
    StateDirectory=aaa/bbb ccc
.if n \{.RE
.\}

then the environment variable
"RUNTIME_DIRECTORY"
is set with
"/run/foo/bar", and
"STATE_DIRECTORY"
is set with
"/var/lib/aaa/bbb:/var/lib/ccc".

_RuntimeDirectoryMode=_, _StateDirectoryMode=_, _CacheDirectoryMode=_, _LogsDirectoryMode=_, _ConfigurationDirectoryMode=_
Specifies the access mode of the directories specified in
_RuntimeDirectory=_,
_StateDirectory=_,
_CacheDirectory=_,
_LogsDirectory=_, or
_ConfigurationDirectory=_, respectively, as an octal number. Defaults to
**0755**. See "Permissions" in
**path\_resolution**(7)
for a discussion of the meaning of permission bits.

_RuntimeDirectoryPreserve=_
Takes a boolean argument or
**restart**. If set to
**no**
(the default), the directories specified in
_RuntimeDirectory=_
are always removed when the service stops. If set to
**restart**
the directories are preserved when the service is both automatically and manually restarted. Here, the automatic restart means the operation specified in
_Restart=_, and manual restart means the one triggered by
**systemctl restart foo.service**. If set to
**yes**, then the directories are not removed when the service is stopped. Note that since the runtime directory
/run
is a mount point of
"tmpfs", then for system services the directories specified in
_RuntimeDirectory=_
are removed when the system is rebooted.

_ReadWritePaths=_, _ReadOnlyPaths=_, _InaccessiblePaths=_
Sets up a new file system namespace for executed processes. These options may be used to limit access a process might have to the file system hierarchy. Each setting takes a space-separated list of paths relative to the hosts root directory (i.e. the system running the service manager). Note that if paths contain symlinks, they are resolved relative to the root directory set with
_RootDirectory=_/_RootImage=_.

Paths listed in
_ReadWritePaths=_
are accessible from within the namespace with the same access modes as from outside of it. Paths listed in
_ReadOnlyPaths=_
are accessible for reading only, writing will be refused even if the usual file access controls would permit this. Nest
_ReadWritePaths=_
inside of
_ReadOnlyPaths=_
in order to provide writable subdirectories within read-only directories. Use
_ReadWritePaths=_
in order to whitelist specific paths for write access if
_ProtectSystem=strict_
is used.

Paths listed in
_InaccessiblePaths=_
will be made inaccessible for processes inside the namespace along with everything below them in the file system hierarchy. This may be more restrictive than desired, because it is not possible to nest
_ReadWritePaths=_,
_ReadOnlyPaths=_,
_BindPaths=_, or
_BindReadOnlyPaths=_
inside it. For a more flexible option, see
_TemporaryFileSystem=_.

Non-directory paths may be specified as well. These options may be specified more than once, in which case all paths listed will have limited access from within the namespace. If the empty string is assigned to this option, the specific list is reset, and all prior assignments have no effect.

Paths in
_ReadWritePaths=_,
_ReadOnlyPaths=_
and
_InaccessiblePaths=_
may be prefixed with
"-", in which case they will be ignored when they do not exist. If prefixed with
"+"
the paths are taken relative to the root directory of the unit, as configured with
_RootDirectory=_/_RootImage=_, instead of relative to the root directory of the host (see above). When combining
"-"
and
"+"
on the same path make sure to specify
"-"
first, and
"+"
second.

Note that these settings will disconnect propagation of mounts from the units processes to the host. This means that this setting may not be used for services which shall be able to install mount points in the main mount namespace. For
_ReadWritePaths=_
and
_ReadOnlyPaths=_
propagation in the other direction is not affected, i.e. mounts created on the host generally appear in the unit processes namespace, and mounts removed on the host also disappear there too. In particular, note that mount propagation from host to unit will result in unmodified mounts to be created in the unit\*(Aqs namespace, i.e. writable mounts appearing on the host will be writable in the unit\*(Aqs namespace too, even when propagated below a path marked with
_ReadOnlyPaths=_! Restricting access with these options hence does not extend to submounts of a directory that are created later on. This means the lock-down offered by that setting is not complete, and does not offer full protection.

Note that the effect of these settings may be undone by privileged processes. In order to set up an effective sandboxed environment for a unit it is thus recommended to combine these settings with either
_CapabilityBoundingSet=~CAP\_SYS\_ADMIN_
or
_SystemCallFilter=~@mount_.

These options are only available for system services and are not supported for services running in per-user instances of the service manager.

_TemporaryFileSystem=_
Takes a space-separated list of mount points for temporary file systems (tmpfs). If set, a new file system namespace is set up for executed processes, and a temporary file system is mounted on each mount point. This option may be specified more than once, in which case temporary file systems are mounted on all listed mount points. If the empty string is assigned to this option, the list is reset, and all prior assignments have no effect. Each mount point may optionally be suffixed with a colon (":") and mount options such as
"size=10%"
or
"ro". By default, each temporary file system is mounted with
"nodev,strictatime,mode=0755". These can be disabled by explicitly specifying the corresponding mount options, e.g.,
"dev"
or
"nostrictatime".

This is useful to hide files or directories not relevant to the processes invoked by the unit, while necessary files or directories can be still accessed by combining with
_BindPaths=_
or
_BindReadOnlyPaths=_:

Example: if a unit has the following,

.if n \{.RS 4
.\}
    TemporaryFileSystem=/var:ro
    BindReadOnlyPaths=/var/lib/systemd
.if n \{.RE
.\}

then the invoked processes by the unit cannot see any files or directories under
/var
except for
/var/lib/systemd
or its contents.

This option is only available for system services and is not supported for services running in per-user instances of the service manager.

_PrivateTmp=_
Takes a boolean argument. If true, sets up a new file system namespace for the executed processes and mounts private
/tmp
and
/var/tmp
directories inside it that is not shared by processes outside of the namespace. This is useful to secure access to temporary files of the process, but makes sharing between processes via
/tmp
or
/var/tmp
impossible. If this is enabled, all temporary files created by a service in these directories will be removed after the service is stopped. Defaults to false. It is possible to run two or more units within the same private
/tmp
and
/var/tmp
namespace by using the
_JoinsNamespaceOf=_
directive, see
**systemd.unit**(5)
for details. This setting is implied if
_DynamicUser=_
is set. For this setting the same restrictions regarding mount propagation and privileges apply as for
_ReadOnlyPaths=_
and related calls, see above. Enabling this setting has the side effect of adding
_Requires=_
and
_After=_
dependencies on all mount units necessary to access
/tmp
and
/var/tmp. Moreover an implicitly
_After=_
ordering on
**systemd-tmpfiles-setup.service**(8)
is added.

Note that the implementation of this setting might be impossible (for example if mount namespaces are not available), and the unit should be written in a way that does not solely rely on this setting for security.

This option is only available for system services and is not supported for services running in per-user instances of the service manager.

_PrivateDevices=_
Takes a boolean argument. If true, sets up a new
/dev
mount for the executed processes and only adds API pseudo devices such as
/dev/null,
/dev/zero
or
/dev/random
(as well as the pseudo TTY subsystem) to it, but no physical devices such as
/dev/sda, system memory
/dev/mem, system ports
/dev/port
and others. This is useful to securely turn off physical device access by the executed process. Defaults to false. Enabling this option will install a system call filter to block low-level I/O system calls that are grouped in the
_@raw-io_
set, will also remove
**CAP\_MKNOD**
and
**CAP\_SYS\_RAWIO**
from the capability bounding set for the unit (see above), and set
_DevicePolicy=closed_
(see
**systemd.resource-control**(5)
for details). Note that using this setting will disconnect propagation of mounts from the service to the host (propagation in the opposite direction continues to work). This means that this setting may not be used for services which shall be able to install mount points in the main mount namespace. The new
/dev
will be mounted read-only and noexec\*(Aq. The latter may break old programs which try to set up executable memory by using
**mmap**(2)
of
/dev/zero
instead of using
**MAP\_ANON**. For this setting the same restrictions regarding mount propagation and privileges apply as for
_ReadOnlyPaths=_
and related calls, see above. If turned on and if running in user mode, or in system mode, but without the
**CAP\_SYS\_ADMIN**
capability (e.g. setting
_User=_),
_NoNewPrivileges=yes_
is implied.

Note that the implementation of this setting might be impossible (for example if mount namespaces are not available), and the unit should be written in a way that does not solely rely on this setting for security.

This option is only available for system services and is not supported for services running in per-user instances of the service manager.

_PrivateNetwork=_
Takes a boolean argument. If true, sets up a new network namespace for the executed processes and configures only the loopback network device
"lo"
inside it. No other network devices will be available to the executed process. This is useful to turn off network access by the executed process. Defaults to false. It is possible to run two or more units within the same private network namespace by using the
_JoinsNamespaceOf=_
directive, see
**systemd.unit**(5)
for details. Note that this option will disconnect all socket families from the host, including
**AF\_NETLINK**
and
**AF\_UNIX**. Effectively, for
**AF\_NETLINK**
this means that device configuration events received from
**systemd-udevd.service**(8)
are not delivered to the units processes. And for
**AF\_UNIX**
this has the effect that
**AF\_UNIX**
sockets in the abstract socket namespace of the host will become unavailable to the units processes (however, those located in the file system will continue to be accessible).

Note that the implementation of this setting might be impossible (for example if network namespaces are not available), and the unit should be written in a way that does not solely rely on this setting for security.

This option is only available for system services and is not supported for services running in per-user instances of the service manager.

_PrivateUsers=_
Takes a boolean argument. If true, sets up a new user namespace for the executed processes and configures a minimal user and group mapping, that maps the
"root"
user and group as well as the units own user and group to themselves and everything else to the
"nobody"
user and group. This is useful to securely detach the user and group databases used by the unit from the rest of the system, and thus to create an effective sandbox environment. All files, directories, processes, IPC objects and other resources owned by users/groups not equaling
"root"
or the units own will stay visible from within the unit but appear owned by the
"nobody"
user and group. If this mode is enabled, all unit processes are run without privileges in the host user namespace (regardless if the units own user/group is
"root"
or not). Specifically this means that the process will have zero process capabilities on the hosts user namespace, but full capabilities within the service\*(Aqs user namespace. Settings such as
_CapabilityBoundingSet=_
will affect only the latter, and theres no way to acquire additional capabilities in the host\*(Aqs user namespace. Defaults to off.

This setting is particularly useful in conjunction with
_RootDirectory=_/_RootImage=_, as the need to synchronize the user and group databases in the root directory and on the host is reduced, as the only users and groups who need to be matched are
"root",
"nobody"
and the units own user and group.

Note that the implementation of this setting might be impossible (for example if user namespaces are not available), and the unit should be written in a way that does not solely rely on this setting for security.

This option is only available for system services and is not supported for services running in per-user instances of the service manager.

_ProtectKernelTunables=_
Takes a boolean argument. If true, kernel variables accessible through
/proc/sys,
/sys,
/proc/sysrq-trigger,
/proc/latency_stats,
/proc/acpi,
/proc/timer_stats,
/proc/fs
and
/proc/irq
will be made read-only to all processes of the unit. Usually, tunable kernel variables should be initialized only at boot-time, for example with the
**sysctl.d**(5)
mechanism. Few services need to write to these at runtime; it is hence recommended to turn this on for most services. For this setting the same restrictions regarding mount propagation and privileges apply as for
_ReadOnlyPaths=_
and related calls, see above. Defaults to off. If turned on and if running in user mode, or in system mode, but without the
**CAP\_SYS\_ADMIN**
capability (e.g. services for which
_User=_
is set),
_NoNewPrivileges=yes_
is implied. Note that this option does not prevent indirect changes to kernel tunables effected by IPC calls to other processes. However,
_InaccessiblePaths=_
may be used to make relevant IPC file system objects inaccessible. If
_ProtectKernelTunables=_
is set,
_MountAPIVFS=yes_
is implied.

This option is only available for system services and is not supported for services running in per-user instances of the service manager.

_ProtectKernelModules=_
Takes a boolean argument. If true, explicit module loading will be denied. This allows module load and unload operations to be turned off on modular kernels. It is recommended to turn this on for most services that do not need special file systems or extra kernel modules to work. Defaults to off. Enabling this option removes
**CAP\_SYS\_MODULE**
from the capability bounding set for the unit, and installs a system call filter to block module system calls, also
/usr/lib/modules
is made inaccessible. For this setting the same restrictions regarding mount propagation and privileges apply as for
_ReadOnlyPaths=_
and related calls, see above. Note that limited automatic module loading due to user configuration or kernel mapping tables might still happen as side effect of requested user operations, both privileged and unprivileged. To disable module auto-load feature please see
**sysctl.d**(5)
**kernel.modules\_disabled**
mechanism and
/proc/sys/kernel/modules_disabled
documentation. If turned on and if running in user mode, or in system mode, but without the
**CAP\_SYS\_ADMIN**
capability (e.g. setting
_User=_),
_NoNewPrivileges=yes_
is implied.

This option is only available for system services and is not supported for services running in per-user instances of the service manager.

_ProtectControlGroups=_
Takes a boolean argument. If true, the Linux Control Groups (**cgroups**(7)) hierarchies accessible through
/sys/fs/cgroup
will be made read-only to all processes of the unit. Except for container managers no services should require write access to the control groups hierarchies; it is hence recommended to turn this on for most services. For this setting the same restrictions regarding mount propagation and privileges apply as for
_ReadOnlyPaths=_
and related calls, see above. Defaults to off. If
_ProtectControlGroups=_
is set,
_MountAPIVFS=yes_
is implied.

This option is only available for system services and is not supported for services running in per-user instances of the service manager.

_RestrictAddressFamilies=_
Restricts the set of socket address families accessible to the processes of this unit. Takes a space-separated list of address family names to whitelist, such as
**AF\_UNIX**,
**AF\_INET**
or
**AF\_INET6**. When prefixed with
**~**
the listed address families will be applied as blacklist, otherwise as whitelist. Note that this restricts access to the
**socket**(2)
system call only. Sockets passed into the process by other means (for example, by using socket activation with socket units, see
**systemd.socket**(5)) are unaffected. Also, sockets created with
**socketpair()**
(which creates connected AF_UNIX sockets only) are unaffected. Note that this option has no effect on 32-bit x86, s390, s390x, mips, mips-le, ppc, ppc-le, pcc64, ppc64-le and is ignored (but works correctly on other ABIs, including x86-64). Note that on systems supporting multiple ABIs (such as x86/x86-64) it is recommended to turn off alternative ABIs for services, so that they cannot be used to circumvent the restrictions of this option. Specifically, it is recommended to combine this option with
_SystemCallArchitectures=native_
or similar. If running in user mode, or in system mode, but without the
**CAP\_SYS\_ADMIN**
capability (e.g. setting
_User=nobody_),
_NoNewPrivileges=yes_
is implied. By default, no restrictions apply, all address families are accessible to processes. If assigned the empty string, any previous address familiy restriction changes are undone. This setting does not affect commands prefixed with
"+".

Use this option to limit exposure of processes to remote access, in particular via exotic and sensitive network protocols, such as
**AF\_PACKET**. Note that in most cases, the local
**AF\_UNIX**
address family should be included in the configured whitelist as it is frequently used for local communication, including for
**syslog**(2)
logging.

_RestrictNamespaces=_
Restricts access to Linux namespace functionality for the processes of this unit. For details about Linux namespaces, see
**namespaces**(7). Either takes a boolean argument, or a space-separated list of namespace type identifiers. If false (the default), no restrictions on namespace creation and switching are made. If true, access to any kind of namespacing is prohibited. Otherwise, a space-separated list of namespace type identifiers must be specified, consisting of any combination of:
**cgroup**,
**ipc**,
**net**,
**mnt**,
**pid**,
**user**
and
**uts**. Any namespace type listed is made accessible to the units processes, access to namespace types not listed is prohibited (whitelisting). By prepending the list with a single tilde character ("~") the effect may be inverted: only the listed namespace types will be made inaccessible, all unlisted ones are permitted (blacklisting). If the empty string is assigned, the default namespace restrictions are applied, which is equivalent to false. This option may appear more than once, in which case the namespace types are merged by
**OR**, or by
**AND**
if the lines are prefixed with
"~"
(see examples below). Internally, this setting limits access to the
**unshare**(2),
**clone**(2)
and
**setns**(2)
system calls, taking the specified flags parameters into account. Note that — if this option is used — in addition to restricting creation and switching of the specified types of namespaces (or all of them, if true) access to the
**setns()**
system call with a zero flags parameter is prohibited. This setting is only supported on x86, x86-64, mips, mips-le, mips64, mips64-le, mips64-n32, mips64-le-n32, ppc64, ppc64-le, s390 and s390x, and enforces no restrictions on other architectures. If running in user mode, or in system mode, but without the
**CAP\_SYS\_ADMIN**
capability (e.g. setting
_User=_),
_NoNewPrivileges=yes_
is implied.

Example: if a unit has the following,

.if n \{.RS 4
.\}
    RestrictNamespaces=cgroup ipc
    RestrictNamespaces=cgroup net
.if n \{.RE
.\}

then
**cgroup**,
**ipc**, and
**net**
are set. If the second line is prefixed with
"~", e.g.,

.if n \{.RS 4
.\}
    RestrictNamespaces=cgroup ipc
    RestrictNamespaces=~cgroup net
.if n \{.RE
.\}

then, only
**ipc**
is set.

_LockPersonality=_
Takes a boolean argument. If set, locks down the
**personality**(2)
system call so that the kernel execution domain may not be changed from the default or the personality selected with
_Personality=_
directive. This may be useful to improve security, because odd personality emulations may be poorly tested and source of vulnerabilities. If running in user mode, or in system mode, but without the
**CAP\_SYS\_ADMIN**
capability (e.g. setting
_User=_),
_NoNewPrivileges=yes_
is implied.

_MemoryDenyWriteExecute=_
Takes a boolean argument. If set, attempts to create memory mappings that are writable and executable at the same time, or to change existing memory mappings to become executable, or mapping shared memory segments as executable are prohibited. Specifically, a system call filter is added that rejects
**mmap**(2)
system calls with both
**PROT\_EXEC**
and
**PROT\_WRITE**
set,
**mprotect**(2)
or
**pkey\_mprotect**(2)
system calls with
**PROT\_EXEC**
set and
**shmat**(2)
system calls with
**SHM\_EXEC**
set. Note that this option is incompatible with programs and libraries that generate program code dynamically at runtime, including JIT execution engines, executable stacks, and code "trampoline" feature of various C compilers. This option improves service security, as it makes harder for software exploits to change running code dynamically. However, the protection can be circumvented, if the service can write to a filesystem, which is not mounted with
**noexec**
(such as
/dev/shm), or it can use
**memfd\_create()**. This can be prevented by making such file systems inaccessible to the service (e.g.
_InaccessiblePaths=/dev/shm_) and installing further system call filters (_SystemCallFilter=~memfd\_create_). Note that this feature is fully available on x86-64, and partially on x86. Specifically, the
**shmat()**
protection is not available on x86. Note that on systems supporting multiple ABIs (such as x86/x86-64) it is recommended to turn off alternative ABIs for services, so that they cannot be used to circumvent the restrictions of this option. Specifically, it is recommended to combine this option with
_SystemCallArchitectures=native_
or similar. If running in user mode, or in system mode, but without the
**CAP\_SYS\_ADMIN**
capability (e.g. setting
_User=_),
_NoNewPrivileges=yes_
is implied.

_RestrictRealtime=_
Takes a boolean argument. If set, any attempts to enable realtime scheduling in a process of the unit are refused. This restricts access to realtime task scheduling policies such as
**SCHED\_FIFO**,
**SCHED\_RR**
or
**SCHED\_DEADLINE**. See
**sched**(7)
for details about these scheduling policies. If running in user mode, or in system mode, but without the
**CAP\_SYS\_ADMIN**
capability (e.g. setting
_User=_),
_NoNewPrivileges=yes_
is implied. Realtime scheduling policies may be used to monopolize CPU time for longer periods of time, and may hence be used to lock up or otherwise trigger Denial-of-Service situations on the system. It is hence recommended to restrict access to realtime scheduling to the few programs that actually require them. Defaults to off.

_RestrictSUIDSGID=_
Takes a boolean argument. If set, any attempts to set the set-user-ID (SUID) or set-group-ID (SGID) bits on files or directories will be denied (for details on these bits see
**inode**(7)). If running in user mode, or in system mode, but without the
**CAP\_SYS\_ADMIN**
capability (e.g. setting
_User=_),
_NoNewPrivileges=yes_
is implied. As the SUID/SGID bits are mechanisms to elevate privileges, and allows users to acquire the identity of other users, it is recommended to restrict creation of SUID/SGID files to the few programs that actually require them. Note that this restricts marking of any type of file system object with these bits, including both regular files and directories (where the SGID is a different meaning than for files, see documentation). Defaults to off.

_RemoveIPC=_
Takes a boolean parameter. If set, all System V and POSIX IPC objects owned by the user and group the processes of this unit are run as are removed when the unit is stopped. This setting only has an effect if at least one of
_User=_,
_Group=_
and
_DynamicUser=_
are used. It has no effect on IPC objects owned by the root user. Specifically, this removes System V semaphores, as well as System V and POSIX shared memory segments and message queues. If multiple units use the same user or group the IPC objects are removed when the last of these units is stopped. This setting is implied if
_DynamicUser=_
is set.

This option is only available for system services and is not supported for services running in per-user instances of the service manager.

_PrivateMounts=_
Takes a boolean parameter. If set, the processes of this unit will be run in their own private file system (mount) namespace with all mount propagation from the processes towards the hosts main file system namespace turned off. This means any file system mount points established or removed by the unit\*(Aqs processes will be private to them and not be visible to the host. However, file system mount points established or removed on the host will be propagated to the unit\*(Aqs processes. See
**mount\_namespaces**(7)
for details on file system namespaces. Defaults to off.

When turned on, this executes three operations for each invoked process: a new
**CLONE\_NEWNS**
namespace is created, after which all existing mounts are remounted to
**MS\_SLAVE**
to disable propagation from the units processes to the host (but leaving propagation in the opposite direction in effect). Finally, the mounts are remounted again to the propagation mode configured with
_MountFlags=_, see below.

File system namespaces are set up individually for each process forked off by the service manager. Mounts established in the namespace of the process created by
_ExecStartPre=_
will hence be cleaned up automatically as soon as that process exits and will not be available to subsequent processes forked off for
_ExecStart=_
(and similar applies to the various other commands configured for units). Similarly,
_JoinsNamespaceOf=_
does not permit sharing kernel mount namespaces between units, it only enables sharing of the
/tmp/
and
/var/tmp/
directories.

Other file system namespace unit settings —
_PrivateMounts=_,
_PrivateTmp=_,
_PrivateDevices=_,
_ProtectSystem=_,
_ProtectHome=_,
_ReadOnlyPaths=_,
_InaccessiblePaths=_,
_ReadWritePaths=_, ... — also enable file system namespacing in a fashion equivalent to this option. Hence it is primarily useful to explicitly request this behaviour if none of the other settings are used.

This option is only available for system services and is not supported for services running in per-user instances of the service manager.

_MountFlags=_
Takes a mount propagation setting:
**shared**,
**slave**
or
**private**, which controls whether file system mount points in the file system namespaces set up for this units processes will receive or propagate mounts and unmounts from other file system namespaces. See
**mount**(2)
for details on mount propagation, and the three propagation flags in particular.

This setting only controls the
_final_
propagation setting in effect on all mount points of the file system namespace created for each process of this unit. Other file system namespacing unit settings (see the discussion in
_PrivateMounts=_
above) will implicitly disable mount and unmount propagation from the units processes towards the host by changing the propagation setting of all mount points in the unit\*(Aqs file system namepace to
**slave**
first. Setting this option to
**shared**
does not reestablish propagation in that case.

If not set – but file system namespaces are enabled through another file system namespace unit setting –
**shared**
mount propagation is used, but — as mentioned — as
**slave**
is applied first, propagation from the units processes to the host is still turned off.

It is not recommended to to use
**private**
mount propagation for units, as this means temporary mounts (such as removable media) of the host will stay mounted and thus indefinitely busy in forked off processes, as unmount propagation events wont be received by the file system namespace of the unit.

Usually, it is best to leave this setting unmodified, and use higher level file system namespacing options instead, in particular
_PrivateMounts=_, see above.

This option is only available for system services and is not supported for services running in per-user instances of the service manager.

<a name="system-call-filtering"></a>

# System Call Filtering


_SystemCallFilter=_
Takes a space-separated list of system call names. If this setting is used, all system calls executed by the unit processes except for the listed ones will result in immediate process termination with the
**SIGSYS**
signal (whitelisting). If the first character of the list is
"~", the effect is inverted: only the listed system calls will result in immediate process termination (blacklisting). Blacklisted system calls and system call groups may optionally be suffixed with a colon (":") and
"errno"
error number (between 0 and 4095) or errno name such as
**EPERM**,
**EACCES**
or
**EUCLEAN**. This value will be returned when a blacklisted system call is triggered, instead of terminating the processes immediately. This value takes precedence over the one given in
_SystemCallErrorNumber=_. If running in user mode, or in system mode, but without the
**CAP\_SYS\_ADMIN**
capability (e.g. setting
_User=nobody_),
_NoNewPrivileges=yes_
is implied. This feature makes use of the Secure Computing Mode 2 interfaces of the kernel (seccomp filtering\*(Aq) and is useful for enforcing a minimal sandboxing environment. Note that the
**execve**,
**exit**,
**exit\_group**,
**getrlimit**,
**rt\_sigreturn**,
**sigreturn**
system calls and the system calls for querying time and sleeping are implicitly whitelisted and do not need to be listed explicitly. This option may be specified more than once, in which case the filter masks are merged. If the empty string is assigned, the filter is reset, all prior assignments will have no effect. This does not affect commands prefixed with
"+".

Note that on systems supporting multiple ABIs (such as x86/x86-64) it is recommended to turn off alternative ABIs for services, so that they cannot be used to circumvent the restrictions of this option. Specifically, it is recommended to combine this option with
_SystemCallArchitectures=native_
or similar.

Note that strict system call filters may impact execution and error handling code paths of the service invocation. Specifically, access to the
**execve**
system call is required for the execution of the service binary — if it is blocked service invocation will necessarily fail. Also, if execution of the service binary fails for some reason (for example: missing service executable), the error handling logic might require access to an additional set of system calls in order to process and log this failure correctly. It might be necessary to temporarily disable system call filters in order to simplify debugging of such failures.

If you specify both types of this option (i.e. whitelisting and blacklisting), the first encountered will take precedence and will dictate the default action (termination or approval of a system call). Then the next occurrences of this option will add or delete the listed system calls from the set of the filtered system calls, depending of its type and the default action. (For example, if you have started with a whitelisting of
**read**
and
**write**, and right after it add a blacklisting of
**write**, then
**write**
will be removed from the set.)

As the number of possible system calls is large, predefined sets of system calls are provided. A set starts with
"@"
character, followed by name of the set.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;3.&nbsp;Currently predefined system call sets**
.TS
allbox tab(:);
lB lB.
T{
Set
T}:T{
Description
T}
.T&
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l.
T{
@aio
T}:T{
Asynchronous I/O (**io\_setup**(2), **io\_submit**(2), and related calls)
T}
T{
@basic-io
T}:T{
System calls for basic I/O: reading, writing, seeking, file descriptor duplication and closing (**read**(2), **write**(2), and related calls)
T}
T{
@chown
T}:T{
Changing file ownership (**chown**(2), **fchownat**(2), and related calls)
T}
T{
@clock
T}:T{
System calls for changing the system clock (**adjtimex**(2), **settimeofday**(2), and related calls)
T}
T{
@cpu-emulation
T}:T{
System calls for CPU emulation functionality (**vm86**(2) and related calls)
T}
T{
@debug
T}:T{
Debugging, performance monitoring and tracing functionality (**ptrace**(2), **perf\_event\_open**(2) and related calls)
T}
T{
@file-system
T}:T{
File system operations: opening, creating files and directories for read and write, renaming and removing them, reading file properties, or creating hard and symbolic links.
T}
T{
@io-event
T}:T{
Event loop system calls (**poll**(2), **select**(2), **epoll**(7), **eventfd**(2) and related calls)
T}
T{
@ipc
T}:T{
Pipes, SysV IPC, POSIX Message Queues and other IPC (**mq\_overview**(7), **svipc**(7))
T}
T{
@keyring
T}:T{
Kernel keyring access (**keyctl**(2) and related calls)
T}
T{
@memlock
T}:T{
Locking of memory into RAM (**mlock**(2), **mlockall**(2) and related calls)
T}
T{
@module
T}:T{
Loading and unloading of kernel modules (**init\_module**(2), **delete\_module**(2) and related calls)
T}
T{
@mount
T}:T{
Mounting and unmounting of file systems (**mount**(2), **chroot**(2), and related calls)
T}
T{
@network-io
T}:T{
Socket I/O (including local AF_UNIX): **socket**(7), **unix**(7)
T}
T{
@obsolete
T}:T{
Unusual, obsolete or unimplemented (**create\_module**(2), **gtty**(2), ...)
T}
T{
@privileged
T}:T{
All system calls which need super-user capabilities (**capabilities**(7))
T}
T{
@process
T}:T{
Process control, execution, namespaceing operations (**clone**(2), **kill**(2), **namespaces**(7), ...
T}
T{
@raw-io
T}:T{
Raw I/O port access (**ioperm**(2), **iopl**(2), **pciconfig\_read()**, ...)
T}
T{
@reboot
T}:T{
System calls for rebooting and reboot preparation (**reboot**(2), **kexec()**, ...)
T}
T{
@resources
T}:T{
System calls for changing resource limits, memory and scheduling parameters (**setrlimit**(2), **setpriority**(2), ...)
T}
T{
@setuid
T}:T{
System calls for changing user ID and group ID credentials, (**setuid**(2), **setgid**(2), **setresuid**(2), ...)
T}
T{
@signal
T}:T{
System calls for manipulating and handling process signals (**signal**(2), **sigprocmask**(2), ...)
T}
T{
@swap
T}:T{
System calls for enabling/disabling swap devices (**swapon**(2), **swapoff**(2))
T}
T{
@sync
T}:T{
Synchronizing files and memory to disk: (**fsync**(2), **msync**(2), and related calls)
T}
T{
@system-service
T}:T{
A reasonable set of system calls used by common system services, excluding any special purpose calls. This is the recommended starting point for whitelisting system calls for system services, as it contains what is typically needed by system services, but excludes overly specific interfaces. For example, the following APIs are excluded: "@clock", "@mount", "@swap", "@reboot".
T}
T{
@timer
T}:T{
System calls for scheduling operations by time (**alarm**(2), **timer\_create**(2), ...)
T}
.TE

Note, that as new system calls are added to the kernel, additional system calls might be added to the groups above. Contents of the sets may also change between systemd versions. In addition, the list of system calls depends on the kernel version and architecture for which systemd was compiled. Use
**systemd-analyze&nbsp;syscall-filter**
to list the actual list of system calls in each filter.

Generally, whitelisting system calls (rather than blacklisting) is the safer mode of operation. It is recommended to enforce system call whitelists for all long-running system services. Specifically, the following lines are a relatively safe basic choice for the majority of system services:

.if n \{.RS 4
.\}
    [Service]
    SystemCallFilter=@system-service
    SystemCallErrorNumber=EPERM
.if n \{.RE
.\}

It is recommended to combine the file system namespacing related options with
_SystemCallFilter=~@mount_, in order to prohibit the units processes to undo the mappings. Specifically these are the options
_PrivateTmp=_,
_PrivateDevices=_,
_ProtectSystem=_,
_ProtectHome=_,
_ProtectKernelTunables=_,
_ProtectControlGroups=_,
_ReadOnlyPaths=_,
_InaccessiblePaths=_
and
_ReadWritePaths=_.

_SystemCallErrorNumber=_
Takes an
"errno"
error number (between 1 and 4095) or errno name such as
**EPERM**,
**EACCES**
or
**EUCLEAN**, to return when the system call filter configured with
_SystemCallFilter=_
is triggered, instead of terminating the process immediately. When this setting is not used, or when the empty string is assigned, the process will be terminated immediately when the filter is triggered.

_SystemCallArchitectures=_
Takes a space-separated list of architecture identifiers to include in the system call filter. The known architecture identifiers are the same as for
_ConditionArchitecture=_
described in
**systemd.unit**(5), as well as
**x32**,
**mips64-n32**,
**mips64-le-n32**, and the special identifier
**native**. The special identifier
**native**
implicitly maps to the native architecture of the system (or more precisely: to the architecture the system manager is compiled for). If running in user mode, or in system mode, but without the
**CAP\_SYS\_ADMIN**
capability (e.g. setting
_User=nobody_),
_NoNewPrivileges=yes_
is implied. By default, this option is set to the empty list, i.e. no system call architecture filtering is applied.

If this setting is used, processes of this unit will only be permitted to call native system calls, and system calls of the specified architectures. For the purposes of this option, the x32 architecture is treated as including x86-64 system calls. However, this setting still fulfills its purpose, as explained below, on x32.

System call filtering is not equally effective on all architectures. For example, on x86 filtering of network socket-related calls is not possible, due to ABI limitations — a limitation that x86-64 does not have, however. On systems supporting multiple ABIs at the same time — such as x86/x86-64 — it is hence recommended to limit the set of permitted system call architectures so that secondary ABIs may not be used to circumvent the restrictions applied to the native ABI of the system. In particular, setting
_SystemCallArchitectures=native_
is a good choice for disabling non-native ABIs.

System call architectures may also be restricted system-wide via the
_SystemCallArchitectures=_
option in the global configuration. See
**systemd-system.conf**(5)
for details.

<a name="environment"></a>

# Environment


_Environment=_
Sets environment variables for executed processes. Takes a space-separated list of variable assignments. This option may be specified more than once, in which case all listed variables will be set. If the same variable is set twice, the later setting will override the earlier setting. If the empty string is assigned to this option, the list of environment variables is reset, all prior assignments have no effect. Variable expansion is not performed inside the strings, however, specifier expansion is possible. The $ character has no special meaning. If you need to assign a value containing spaces or the equals sign to a variable, use double quotes (") for the assignment.

Example:

.if n \{.RS 4
.\}
    Environment="VAR1=word1 word2" VAR2=word3 "VAR3=$word 5 6"
.if n \{.RE
.\}

gives three variables
"VAR1",
"VAR2",
"VAR3"
with the values
"word1 word2",
"word3",
"$word 5 6".

See
**environ**(7)
for details about environment variables.

Note that environment variables are not suitable for passing secrets (such as passwords, key material, ...) to service processes. Environment variables set for a unit are exposed to unprivileged clients via D-Bus IPC, and generally not understood as being data that requires protection. Moreover, environment variables are propagated down the process tree, including across security boundaries (such as setuid/setgid executables), and hence might leak to processes that should not have access to the secret data.

_EnvironmentFile=_
Similar to
_Environment=_
but reads the environment variables from a text file. The text file should contain new-line-separated variable assignments. Empty lines, lines without an
"="
separator, or lines starting with ; or # will be ignored, which may be used for commenting. A line ending with a backslash will be concatenated with the following one, allowing multiline variable definitions. The parser strips leading and trailing whitespace from the values of assignments, unless you use double quotes (").

The argument passed should be an absolute filename or wildcard expression, optionally prefixed with
"-", which indicates that if the file does not exist, it will not be read and no error or warning message is logged. This option may be specified more than once in which case all specified files are read. If the empty string is assigned to this option, the list of file to read is reset, all prior assignments have no effect.

The files listed with this directive will be read shortly before the process is executed (more specifically, after all processes from a previous unit state terminated. This means you can generate these files in one unit state, and read it with this option in the next).

Settings from these files override settings made with
_Environment=_. If the same variable is set twice from these files, the files will be read in the order they are specified and the later setting will override the earlier setting.

_PassEnvironment=_
Pass environment variables set for the system service manager to executed processes. Takes a space-separated list of variable names. This option may be specified more than once, in which case all listed variables will be passed. If the empty string is assigned to this option, the list of environment variables to pass is reset, all prior assignments have no effect. Variables specified that are not set for the system manager will not be passed and will be silently ignored. Note that this option is only relevant for the system service manager, as system services by default do not automatically inherit any environment variables set for the service manager itself. However, in case of the user service manager all environment variables are passed to the executed processes anyway, hence this option is without effect for the user service manager.

Variables set for invoked processes due to this setting are subject to being overridden by those configured with
_Environment=_
or
_EnvironmentFile=_.

Example:

.if n \{.RS 4
.\}
    PassEnvironment=VAR1 VAR2 VAR3
.if n \{.RE
.\}

passes three variables
"VAR1",
"VAR2",
"VAR3"
with the values set for those variables in PID1.

See
**environ**(7)
for details about environment variables.

_UnsetEnvironment=_
Explicitly unset environment variable assignments that would normally be passed from the service manager to invoked processes of this unit. Takes a space-separated list of variable names or variable assignments. This option may be specified more than once, in which case all listed variables/assignments will be unset. If the empty string is assigned to this option, the list of environment variables/assignments to unset is reset. If a variable assignment is specified (that is: a variable name, followed by
"=", followed by its value), then any environment variable matching this precise assignment is removed. If a variable name is specified (that is a variable name without any following
"="
or value), then any assignment matching the variable name, regardless of its value is removed. Note that the effect of
_UnsetEnvironment=_
is applied as final step when the environment list passed to executed processes is compiled. That means it may undo assignments from any configuration source, including assignments made through
_Environment=_
or
_EnvironmentFile=_, inherited from the system managers global set of environment variables, inherited via
_PassEnvironment=_, set by the service manager itself (such as
_$NOTIFY\_SOCKET_
and such), or set by a PAM module (in case
_PAMName=_
is used).

See
**environ**(7)
for details about environment variables.

<a name="logging-and-standard-inputoutput"></a>

# Logging and Standard Input/Output


_StandardInput=_
Controls where file descriptor 0 (STDIN) of the executed processes is connected to. Takes one of
**null**,
**tty**,
**tty-force**,
**tty-fail**,
**data**,
**file:****path**,
**socket**
or
**fd:****name**.

If
**null**
is selected, standard input will be connected to
/dev/null, i.e. all read attempts by the process will result in immediate EOF.

If
**tty**
is selected, standard input is connected to a TTY (as configured by
_TTYPath=_, see below) and the executed process becomes the controlling process of the terminal. If the terminal is already being controlled by another process, the executed process waits until the current controlling process releases the terminal.

**tty-force**
is similar to
**tty**, but the executed process is forcefully and immediately made the controlling process of the terminal, potentially removing previous controlling processes from the terminal.

**tty-fail**
is similar to
**tty**, but if the terminal already has a controlling process start-up of the executed process fails.

The
**data**
option may be used to configure arbitrary textual or binary data to pass via standard input to the executed process. The data to pass is configured via
_StandardInputText=_/_StandardInputData=_
(see below). Note that the actual file descriptor type passed (memory file, regular file, UNIX pipe, ...) might depend on the kernel and available privileges. In any case, the file descriptor is read-only, and when read returns the specified data followed by EOF.

The
**file:****path**
option may be used to connect a specific file system object to standard input. An absolute path following the
":"
character is expected, which may refer to a regular file, a FIFO or special file. If an
**AF\_UNIX**
socket in the file system is specified, a stream socket is connected to it. The latter is useful for connecting standard input of processes to arbitrary system services.

The
**socket**
option is valid in socket-activated services only, and requires the relevant socket unit file (see
**systemd.socket**(5)
for details) to have
_Accept=yes_
set, or to specify a single socket only. If this option is set, standard input will be connected to the socket the service was activated from, which is primarily useful for compatibility with daemons designed for use with the traditional
**inetd**(8)
socket activation daemon.

The
**fd:****name**
option connects standard input to a specific, named file descriptor provided by a socket unit. The name may be specified as part of this option, following a
":"
character (e.g.
"fd:foobar"). If no name is specified, the name
"stdin"
is implied (i.e.
"fd"
is equivalent to
"fd:stdin"). At least one socket unit defining the specified name must be provided via the
_Sockets=_
option, and the file descriptor name may differ from the name of its containing socket unit. If multiple matches are found, the first one will be used. See
_FileDescriptorName=_
in
**systemd.socket**(5)
for more details about named file descriptors and their ordering.

This setting defaults to
**null**.

Note that services which specify
**DefaultDependencies=no**
and use
_StandardInput=_
or
_StandardOutput=_
with
**tty**/**tty-force**/**tty-fail**, should specify
**After=systemd-vconsole-setup.service**, to make sure that the tty intialization is finished before they start.

_StandardOutput=_
Controls where file descriptor 1 (STDOUT) of the executed processes is connected to. Takes one of
**inherit**,
**null**,
**tty**,
**journal**,
**syslog**,
**kmsg**,
**journal+console**,
**syslog+console**,
**kmsg+console**,
**file:****path**,
**append:****path**,
**socket**
or
**fd:****name**.

**inherit**
duplicates the file descriptor of standard input for standard output.

**null**
connects standard output to
/dev/null, i.e. everything written to it will be lost.

**tty**
connects standard output to a tty (as configured via
_TTYPath=_, see below). If the TTY is used for output only, the executed process will not become the controlling process of the terminal, and will not fail or wait for other processes to release the terminal.

**journal**
connects standard output with the journal which is accessible via
**journalctl**(1). Note that everything that is written to syslog or kmsg (see below) is implicitly stored in the journal as well, the specific two options listed below are hence supersets of this one.

**syslog**
connects standard output to the
**syslog**(3)
system syslog service, in addition to the journal. Note that the journal daemon is usually configured to forward everything it receives to syslog anyway, in which case this option is no different from
**journal**.

**kmsg**
connects standard output with the kernel log buffer which is accessible via
**dmesg**(1), in addition to the journal. The journal daemon might be configured to send all logs to kmsg anyway, in which case this option is no different from
**journal**.

**journal+console**,
**syslog+console**
and
**kmsg+console**
work in a similar way as the three options above but copy the output to the system console as well.

The
**file:****path**
option may be used to connect a specific file system object to standard output. The semantics are similar to the same option of
_StandardInput=_, see above. If
_path_
refers to a regular file on the filesystem, it is opened (created if it doesnt exist yet) for writing at the beginning of the file, but without truncating it. If standard input and output are directed to the same file path, it is opened only once, for reading as well as writing and duplicated. This is particularly useful when the specified path refers to an
**AF\_UNIX**
socket in the file system, as in that case only a single stream connection is created for both input and output.

**append:****path**
is similar to
**file:****path **
above, but it opens the file in append mode.

**socket**
connects standard output to a socket acquired via socket activation. The semantics are similar to the same option of
_StandardInput=_, see above.

The
**fd:****name**
option connects standard output to a specific, named file descriptor provided by a socket unit. A name may be specified as part of this option, following a
":"
character (e.g.
"fd:foobar"). If no name is specified, the name
"stdout"
is implied (i.e.
"fd"
is equivalent to
"fd:stdout"). At least one socket unit defining the specified name must be provided via the
_Sockets=_
option, and the file descriptor name may differ from the name of its containing socket unit. If multiple matches are found, the first one will be used. See
_FileDescriptorName=_
in
**systemd.socket**(5)
for more details about named descriptors and their ordering.

If the standard output (or error output, see below) of a unit is connected to the journal, syslog or the kernel log buffer, the unit will implicitly gain a dependency of type
_After=_
on
systemd-journald.socket
(also see the "Implicit Dependencies" section above). Also note that in this case stdout (or stderr, see below) will be an
**AF\_UNIX**
stream socket, and not a pipe or FIFO that can be re-opened. This means when executing shell scripts the construct
**echo "hello" &gt; /dev/stderr**
for writing text to stderr will not work. To mitigate this use the construct
**echo "hello" &gt;&2**
instead, which is mostly equivalent and avoids this pitfall.

This setting defaults to the value set with
_DefaultStandardOutput=_
in
**systemd-system.conf**(5), which defaults to
**journal**. Note that setting this parameter might result in additional dependencies to be added to the unit (see above).

_StandardError=_
Controls where file descriptor 2 (STDERR) of the executed processes is connected to. The available options are identical to those of
_StandardOutput=_, with some exceptions: if set to
**inherit**
the file descriptor used for standard output is duplicated for standard error, while
**fd:****name**
will use a default file descriptor name of
"stderr".

This setting defaults to the value set with
_DefaultStandardError=_
in
**systemd-system.conf**(5), which defaults to
**inherit**. Note that setting this parameter might result in additional dependencies to be added to the unit (see above).

_StandardInputText=_, _StandardInputData=_
Configures arbitrary textual or binary data to pass via file descriptor 0 (STDIN) to the executed processes. These settings have no effect unless
_StandardInput=_
is set to
**data**. Use this option to embed process input data directly in the unit file.

_StandardInputText=_
accepts arbitrary textual data. C-style escapes for special characters as well as the usual
"%"-specifiers are resolved. Each time this setting is used the specified text is appended to the per-unit data buffer, followed by a newline character (thus every use appends a new line to the end of the buffer). Note that leading and trailing whitespace of lines configured with this option is removed. If an empty line is specified the buffer is cleared (hence, in order to insert an empty line, add an additional
"\en"
to the end or beginning of a line).

_StandardInputData=_
accepts arbitrary binary data, encoded in
\m[blue]**Base64**\m[]\s-2\u[4]\d\s+2. No escape sequences or specifiers are resolved. Any whitespace in the encoded version is ignored during decoding.

Note that
_StandardInputText=_
and
_StandardInputData=_
operate on the same data buffer, and may be mixed in order to configure both binary and textual data for the same input stream. The textual or binary data is joined strictly in the order the settings appear in the unit file. Assigning an empty string to either will reset the data buffer.

Please keep in mind that in order to maintain readability long unit file settings may be split into multiple lines, by suffixing each line (except for the last) with a
"\e"
character (see
**systemd.unit**(5)
for details). This is particularly useful for large data configured with these two options. Example:

.if n \{.RS 4
.\}
    ...
    StandardInput=data
    StandardInputData=SWNrIHNpdHplIGRhIHVuJyBlc3NlIEtsb3BzLAp1ZmYgZWVtYWwga2xvcHAncy4KSWNrIGtpZWtl e
                      LCBzdGF1bmUsIHd1bmRyZSBtaXIsCnVmZiBlZW1hbCBqZWh0IHNlIHVmZiBkaWUgVMO8ci4KTmFu e
                      dSwgZGVuayBpY2ssIGljayBkZW5rIG5hbnUhCkpldHogaXNzZSB1ZmYsIGVyc2NodCB3YXIgc2Ug e
                      enUhCkljayBqZWhlIHJhdXMgdW5kIGJsaWNrZSDigJQKdW5kIHdlciBzdGVodCBkcmF1w59lbj8g e
                      SWNrZSEK
    ...
.if n \{.RE
.\}

_LogLevelMax=_
Configures filtering by log level of log messages generated by this unit. Takes a
**syslog**
log level, one of
**emerg**
(lowest log level, only highest priority messages),
**alert**,
**crit**,
**err**,
**warning**,
**notice**,
**info**,
**debug**
(highest log level, also lowest priority messages). See
**syslog**(3)
for details. By default no filtering is applied (i.e. the default maximum log level is
**debug**). Use this option to configure the logging system to drop log messages of a specific service above the specified level. For example, set
_LogLevelMax=_**info**
in order to turn off debug logging of a particularly chatty unit. Note that the configured level is applied to any log messages written by any of the processes belonging to this unit, sent via any supported logging protocol. The filtering is applied early in the logging pipeline, before any kind of further processing is done. Moreover, messages which pass through this filter successfully might still be dropped by filters applied at a later stage in the logging subsystem. For example,
_MaxLevelStore=_
configured in
**journald.conf**(5)
might prohibit messages of higher log levels to be stored on disk, even though the per-unit
_LogLevelMax=_
permitted it to be processed.

_LogExtraFields=_
Configures additional log metadata fields to include in all log records generated by processes associated with this unit. This setting takes one or more journal field assignments in the format
"FIELD=VALUE"
separated by whitespace. See
**systemd.journal-fields**(7)
for details on the journal field concept. Even though the underlying journal implementation permits binary field values, this setting accepts only valid UTF-8 values. To include space characters in a journal field value, enclose the assignment in double quotes ("). The usual specifiers are expanded in all assignments (see below). Note that this setting is not only useful for attaching additional metadata to log records of a unit, but given that all fields and values are indexed may also be used to implement cross-unit log record matching. Assign an empty string to reset the list.

_LogRateLimitIntervalSec=_, _LogRateLimitBurst=_
Configures the rate limiting that is applied to messages generated by this unit. If, in the time interval defined by
_LogRateLimitIntervalSec=_, more messages than specified in
_LogRateLimitBurst=_
are logged by a service, all further messages within the interval are dropped until the interval is over. A message about the number of dropped messages is generated. The time specification for
_LogRateLimitIntervalSec=_
may be specified in the following units: "s", "min", "h", "ms", "us" (see
**systemd.time**(7)
for details). The default settings are set by
_RateLimitIntervalSec=_
and
_RateLimitBurst=_
configured in
**journald.conf**(5).

_SyslogIdentifier=_
Sets the process name ("**syslog**
tag") to prefix log lines sent to the logging system or the kernel log buffer with. If not set, defaults to the process name of the executed process. This option is only useful when
_StandardOutput=_
or
_StandardError=_
are set to
**journal**,
**syslog**
or
**kmsg**
(or to the same settings in combination with
**+console**) and only applies to log messages written to stdout or stderr.

_SyslogFacility=_
Sets the
**syslog**
facility identifier to use when logging. One of
**kern**,
**user**,
**mail**,
**daemon**,
**auth**,
**syslog**,
**lpr**,
**news**,
**uucp**,
**cron**,
**authpriv**,
**ftp**,
**local0**,
**local1**,
**local2**,
**local3**,
**local4**,
**local5**,
**local6**
or
**local7**. See
**syslog**(3)
for details. This option is only useful when
_StandardOutput=_
or
_StandardError=_
are set to
**journal**,
**syslog**
or
**kmsg**
(or to the same settings in combination with
**+console**), and only applies to log messages written to stdout or stderr. Defaults to
**daemon**.

_SyslogLevel=_
The default
**syslog**
log level to use when logging to the logging system or the kernel log buffer. One of
**emerg**,
**alert**,
**crit**,
**err**,
**warning**,
**notice**,
**info**,
**debug**. See
**syslog**(3)
for details. This option is only useful when
_StandardOutput=_
or
_StandardError=_
are set to
**journal**,
**syslog**
or
**kmsg**
(or to the same settings in combination with
**+console**), and only applies to log messages written to stdout or stderr. Note that individual lines output by executed processes may be prefixed with a different log level which can be used to override the default log level specified here. The interpretation of these prefixes may be disabled with
_SyslogLevelPrefix=_, see below. For details, see
**sd-daemon**(3). Defaults to
**info**.

_SyslogLevelPrefix=_
Takes a boolean argument. If true and
_StandardOutput=_
or
_StandardError=_
are set to
**journal**,
**syslog**
or
**kmsg**
(or to the same settings in combination with
**+console**), log lines written by the executed process that are prefixed with a log level will be processed with this log level set but the prefix removed. If set to false, the interpretation of these prefixes is disabled and the logged lines are passed on as-is. This only applies to log messages written to stdout or stderr. For details about this prefixing see
**sd-daemon**(3). Defaults to true.

_TTYPath=_
Sets the terminal device node to use if standard input, output, or error are connected to a TTY (see above). Defaults to
/dev/console.

_TTYReset=_
Reset the terminal device specified with
_TTYPath=_
before and after execution. Defaults to
"no".

_TTYVHangup=_
Disconnect all clients which have opened the terminal device specified with
_TTYPath=_
before and after execution. Defaults to
"no".

_TTYVTDisallocate=_
If the terminal device specified with
_TTYPath=_
is a virtual console terminal, try to deallocate the TTY before and after execution. This ensures that the screen and scrollback buffer is cleared. Defaults to
"no".

<a name="system-v-compatibility"></a>

# System V Compatibility


_UtmpIdentifier=_
Takes a four character identifier string for an
**utmp**(5)
and wtmp entry for this service. This should only be set for services such as
**getty**
implementations (such as
**agetty**(8)) where utmp/wtmp entries must be created and cleared before and after execution, or for services that shall be executed as if they were run by a
**getty**
process (see below). If the configured string is longer than four characters, it is truncated and the terminal four characters are used. This setting interprets %I style string replacements. This setting is unset by default, i.e. no utmp/wtmp entries are created or cleaned up for this service.

_UtmpMode=_
Takes one of
"init",
"login"
or
"user". If
_UtmpIdentifier=_
is set, controls which type of
**utmp**(5)/wtmp entries for this service are generated. This setting has no effect unless
_UtmpIdentifier=_
is set too. If
"init"
is set, only an
**INIT\_PROCESS**
entry is generated and the invoked process must implement a
**getty**-compatible utmp/wtmp logic. If
"login"
is set, first an
**INIT\_PROCESS**
entry, followed by a
**LOGIN\_PROCESS**
entry is generated. In this case, the invoked process must implement a
**login**(1)-compatible utmp/wtmp logic. If
"user"
is set, first an
**INIT\_PROCESS**
entry, then a
**LOGIN\_PROCESS**
entry and finally a
**USER\_PROCESS**
entry is generated. In this case, the invoked process may be any process that is suitable to be run as session leader. Defaults to
"init".

<a name="environment-variables-in-spawned-processes"></a>

# Environment Variables in Spawned Processes


Processes started by the service manager are executed with an environment variable block assembled from multiple sources. Processes started by the system service manager generally do not inherit environment variables set for the service manager itself (but this may be altered via
_PassEnvironment=_), but processes started by the user service manager instances generally do inherit all environment variables set for the service manager itself.

For each invoked process the list of environment variables set is compiled from the following sources:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Variables globally configured for the service manager, using the
  _DefaultEnvironment=_
  setting in
  **systemd-system.conf**(5), the kernel command line option
  _systemd.setenv=_
  (see
  **systemd**(1)) or via
  **systemctl set-environment**
  (see
  **systemctl**(1)).

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Variables defined by the service manager itself (see the list below)

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Variables set in the service managers own environment variable block (subject to
  _PassEnvironment=_
  for the system service manager)

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Variables set via
  _Environment=_
  in the unit file

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Variables read from files specified via
  _EnvironmentFile=_
  in the unit file

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Variables set by any PAM modules in case
  _PAMName=_
  is in effect, cf.&nbsp;**pam\_env**(8)

If the same environment variables are set by multiple of these sources, the later source — according to the order of the list above — wins. Note that as final step all variables listed in
_UnsetEnvironment=_
are removed again from the compiled environment variable list, immediately before it is passed to the executed process.

The following select environment variables are set or propagated by the service manager for each invoked process:

_$PATH_
Colon-separated list of directories to use when launching executables. systemd uses a fixed value of
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin.

_$LANG_
Locale. Can be set in
**locale.conf**(5)
or on the kernel command line (see
**systemd**(1)
and
**kernel-command-line**(7)).

_$USER_, _$LOGNAME_, _$HOME_, _$SHELL_
User name (twice), home directory, and the login shell. The variables are set for the units that have
_User=_
set, which includes user
**systemd**
instances. See
**passwd**(5).

_$INVOCATION\_ID_
Contains a randomized, unique 128bit ID identifying each runtime cycle of the unit, formatted as 32 character hexadecimal string. A new ID is assigned each time the unit changes from an inactive state into an activating or active state, and may be used to identify this specific runtime cycle, in particular in data stored offline, such as the journal. The same ID is passed to all processes run as part of the unit.

_$XDG\_RUNTIME\_DIR_
The directory to use for runtime objects (such as IPC objects) and volatile state. Set for all services run by the user
**systemd**
instance, as well as any system services that use
_PAMName=_
with a PAM stack that includes
**pam\_systemd**. See below and
**pam\_systemd**(8)
for more information.

_$MAINPID_
The PID of the units main process if it is known. This is only set for control processes as invoked by
_ExecReload=_
and similar.

_$MANAGERPID_
The PID of the user
**systemd**
instance, set for processes spawned by it.

_$LISTEN\_FDS_, _$LISTEN\_PID_, _$LISTEN\_FDNAMES_
Information about file descriptors passed to a service for socket activation. See
**sd\_listen\_fds**(3).

_$NOTIFY\_SOCKET_
The socket
**sd\_notify()**
talks to. See
**sd\_notify**(3).

_$WATCHDOG\_PID_, _$WATCHDOG\_USEC_
Information about watchdog keep-alive notifications. See
**sd\_watchdog\_enabled**(3).

_$TERM_
Terminal type, set only for units connected to a terminal (_StandardInput=tty_,
_StandardOutput=tty_, or
_StandardError=tty_). See
**termcap**(5).

_$JOURNAL\_STREAM_
If the standard output or standard error output of the executed processes are connected to the journal (for example, by setting
_StandardError=journal_)
_$JOURNAL\_STREAM_
contains the device and inode numbers of the connection file descriptor, formatted in decimal, separated by a colon (":"). This permits invoked processes to safely detect whether their standard output or standard error output are connected to the journal. The device and inode numbers of the file descriptors should be compared with the values set in the environment variable to determine whether the process output is still connected to the journal. Note that it is generally not sufficient to only check whether
_$JOURNAL\_STREAM_
is set at all as services might invoke external processes replacing their standard output or standard error output, without unsetting the environment variable.

If both standard output and standard error of the executed processes are connected to the journal via a stream socket, this environment variable will contain information about the standard error stream, as thats usually the preferred destination for log data. (Note that typically the same stream is used for both standard output and standard error, hence very likely the environment variable contains device and inode information matching both stream file descriptors.)

This environment variable is primarily useful to allow services to optionally upgrade their used log protocol to the native journal protocol (using
**sd\_journal\_print**(3)
and other functions) if their standard output or standard error output is connected to the journal anyway, thus enabling delivery of structured metadata along with logged messages.

_$SERVICE\_RESULT_
Only defined for the service unit type, this environment variable is passed to all
_ExecStop=_
and
_ExecStopPost=_
processes, and encodes the service "result". Currently, the following values are defined:

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;4.&nbsp;Defined _$SERVICE\_RESULT_ values**
.TS
allbox tab(:);
lB lB.
T{
Value
T}:T{
Meaning
T}
.T&
l l
l l
l l
l l
l l
l l
l l
l l
l l.
T{
"success"
T}:T{
The service ran successfully and exited cleanly.
T}
T{
"protocol"
T}:T{
A protocol violation occurred: the service did not take the steps required by its unit configuration (specifically what is configured in its _Type=_ setting).
T}
T{
"timeout"
T}:T{
One of the steps timed out.
T}
T{
"exit-code"
T}:T{
Service process exited with a non-zero exit code; see _$EXIT\_CODE_ below for the actual exit code returned.
T}
T{
"signal"
T}:T{
A service process was terminated abnormally by a signal, without dumping core. See _$EXIT\_CODE_ below for the actual signal causing the termination.
T}
T{
"core-dump"
T}:T{
A service process terminated abnormally with a signal and dumped core. See _$EXIT\_CODE_ below for the signal causing the termination.
T}
T{
"watchdog"
T}:T{
Watchdog keep-alive ping was enabled for the service, but the deadline was missed.
T}
T{
"start-limit-hit"
T}:T{
A start limit was defined for the unit and it was hit, causing the unit to fail to start. See **systemd.unit**(5)s _StartLimitIntervalSec=_ and _StartLimitBurst=_ for details.
T}
T{
"resources"
T}:T{
A catch-all condition in case a system operation failed.
T}
.TE

This environment variable is useful to monitor failure or successful termination of a service. Even though this variable is available in both
_ExecStop=_
and
_ExecStopPost=_, it is usually a better choice to place monitoring tools in the latter, as the former is only invoked for services that managed to start up correctly, and the latter covers both services that failed during their start-up and those which failed during their runtime.

_$EXIT\_CODE_, _$EXIT\_STATUS_
Only defined for the service unit type, these environment variables are passed to all
_ExecStop=_,
_ExecStopPost=_
processes and contain exit status/code information of the main process of the service. For the precise definition of the exit code and status, see
**wait**(2).
_$EXIT\_CODE_
is one of
"exited",
"killed",
"dumped".
_$EXIT\_STATUS_
contains the numeric exit code formatted as string if
_$EXIT\_CODE_
is
"exited", and the signal name in all other cases. Note that these environment variables are only set if the service manager succeeded to start and identify the main process of the service.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;5.&nbsp;Summary of possible service result variable values**
.TS
allbox tab(:);
lB lB lB.
T{
_$SERVICE\_RESULT_
T}:T{
_$EXIT\_CODE_
T}:T{
_$EXIT\_STATUS_
T}
.T&
lt lt l
lt lt l
^ l l
lt lt l
^ lt l
lt lt l
lt lt l
lt lt l
lt l l
^ l l
^ l l
l l l
l l l
l s s.
T{
"success"
T}:T{
"exited"
T}:T{
"0"
T}
T{
"protocol"
T}:T{
not set
T}:T{
not set
T}
:T{
"exited"
T}:T{
"0"
T}
T{
"timeout"
T}:T{
"killed"
T}:T{
"TERM", "KILL"
T}
:T{
"exited"
T}:T{
"0", "1", "2", "3", ..., "255"
T}
T{
"exit-code"
T}:T{
"exited"
T}:T{
"1", "2", "3", ..., "255"
T}
T{
"signal"
T}:T{
"killed"
T}:T{
"HUP", "INT", "KILL", ...
T}
T{
"core-dump"
T}:T{
"dumped"
T}:T{
"ABRT", "SEGV", "QUIT", ...
T}
T{
"watchdog"
T}:T{
"dumped"
T}:T{
"ABRT"
T}
:T{
"killed"
T}:T{
"TERM", "KILL"
T}
:T{
"exited"
T}:T{
"0", "1", "2", "3", ..., "255"
T}
T{
"start-limit-hit"
T}:T{
not set
T}:T{
not set
T}
T{
"resources"
T}:T{
any of the above
T}:T{
any of the above
T}
T{
Note: the process may be also terminated by a signal not sent by systemd. In particular the process may send an arbitrary signal to itself in a handler for any of the non-maskable signals. Nevertheless, in the "timeout" and "watchdog" rows above only the signals that systemd sends have been included. Moreover, using _SuccessExitStatus=_ additional exit statuses may be declared to indicate clean termination, which is not reflected by this table.
T}
.TE


For system services, when
_PAMName=_
is enabled and
**pam\_systemd**
is part of the selected PAM stack, additional environment variables defined by systemd may be set for services. Specifically, these are
_$XDG\_SEAT_,
_$XDG\_VTNR_, see
**pam\_systemd**(8)
for details.

<a name="process-exit-codes"></a>

# Process Exit Codes


When invoking a unit process the service manager possibly fails to apply the execution parameters configured with the settings above. In that case the already created service process will exit with a non-zero exit code before the configured command line is executed. (Or in other words, the child process possibly exits with these error codes, after having been created by the
**fork**(2)
system call, but before the matching
**execve**(2)
system call is called.) Specifically, exit codes defined by the C library, by the LSB specification and by the systemd service manager itself are used.

The following basic service exit codes are defined by the C library.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;6.&nbsp;Basic C library exit codes**
.TS
allbox tab(:);
lB lB lB.
T{
Exit Code
T}:T{
Symbolic Name
T}:T{
Description
T}
.T&
l l l
l l l.
T{
0
T}:T{
**EXIT\_SUCCESS**
T}:T{
Generic success code.
T}
T{
1
T}:T{
**EXIT\_FAILURE**
T}:T{
Generic failure or unspecified error.
T}
.TE


The following service exit codes are defined by the
\m[blue]**LSB specification**\m[]\s-2\u[5]\d\s+2.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;7.&nbsp;LSB service exit codes**
.TS
allbox tab(:);
lB lB lB.
T{
Exit Code
T}:T{
Symbolic Name
T}:T{
Description
T}
.T&
l l l
l l l
l l l
l l l
l l l
l l l.
T{
2
T}:T{
**EXIT\_INVALIDARGUMENT**
T}:T{
Invalid or excess arguments.
T}
T{
3
T}:T{
**EXIT\_NOTIMPLEMENTED**
T}:T{
Unimplemented feature.
T}
T{
4
T}:T{
**EXIT\_NOPERMISSION**
T}:T{
The user has insufficient privileges.
T}
T{
5
T}:T{
**EXIT\_NOTINSTALLED**
T}:T{
The program is not installed.
T}
T{
6
T}:T{
**EXIT\_NOTCONFIGURED**
T}:T{
The program is not configured.
T}
T{
7
T}:T{
**EXIT\_NOTRUNNING**
T}:T{
The program is not running.
T}
.TE


The LSB specification suggests that error codes 200 and above are reserved for implementations. Some of them are used by the service manager to indicate problems during process invocation:

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;8.&nbsp;systemd-specific exit codes**
.TS
allbox tab(:);
lB lB lB.
T{
Exit Code
T}:T{
Symbolic Name
T}:T{
Description
T}
.T&
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l.
T{
200
T}:T{
**EXIT\_CHDIR**
T}:T{
Changing to the requested working directory failed. See _WorkingDirectory=_ above.
T}
T{
201
T}:T{
**EXIT\_NICE**
T}:T{
Failed to set up process scheduling priority (nice level). See _Nice=_ above.
T}
T{
202
T}:T{
**EXIT\_FDS**
T}:T{
Failed to close unwanted file descriptors, or to adjust passed file descriptors.
T}
T{
203
T}:T{
**EXIT\_EXEC**
T}:T{
The actual process execution failed (specifically, the **execve**(2) system call). Most likely this is caused by a missing or non-accessible executable file.
T}
T{
204
T}:T{
**EXIT\_MEMORY**
T}:T{
Failed to perform an action due to memory shortage.
T}
T{
205
T}:T{
**EXIT\_LIMITS**
T}:T{
Failed to adjust resource limits. See _LimitCPU=_ and related settings above.
T}
T{
206
T}:T{
**EXIT\_OOM\_ADJUST**
T}:T{
Failed to adjust the OOM setting. See _OOMScoreAdjust=_ above.
T}
T{
207
T}:T{
**EXIT\_SIGNAL\_MASK**
T}:T{
Failed to set process signal mask.
T}
T{
208
T}:T{
**EXIT\_STDIN**
T}:T{
Failed to set up standard input. See _StandardInput=_ above.
T}
T{
209
T}:T{
**EXIT\_STDOUT**
T}:T{
Failed to set up standard output. See _StandardOutput=_ above.
T}
T{
210
T}:T{
**EXIT\_CHROOT**
T}:T{
Failed to change root directory (**chroot**(2)). See _RootDirectory=_/_RootImage=_ above.
T}
T{
211
T}:T{
**EXIT\_IOPRIO**
T}:T{
Failed to set up IO scheduling priority. See _IOSchedulingClass=_/_IOSchedulingPriority=_ above.
T}
T{
212
T}:T{
**EXIT\_TIMERSLACK**
T}:T{
Failed to set up timer slack. See _TimerSlackNSec=_ above.
T}
T{
213
T}:T{
**EXIT\_SECUREBITS**
T}:T{
Failed to set process secure bits. See _SecureBits=_ above.
T}
T{
214
T}:T{
**EXIT\_SETSCHEDULER**
T}:T{
Failed to set up CPU scheduling. See _CPUSchedulingPolicy=_/_CPUSchedulingPriority=_ above.
T}
T{
215
T}:T{
**EXIT\_CPUAFFINITY**
T}:T{
Failed to set up CPU affinity. See _CPUAffinity=_ above.
T}
T{
216
T}:T{
**EXIT\_GROUP**
T}:T{
Failed to determine or change group credentials. See _Group=_/_SupplementaryGroups=_ above.
T}
T{
217
T}:T{
**EXIT\_USER**
T}:T{
Failed to determine or change user credentials, or to set up user namespacing. See _User=_/_PrivateUsers=_ above.
T}
T{
218
T}:T{
**EXIT\_CAPABILITIES**
T}:T{
Failed to drop capabilities, or apply ambient capabilities. See _CapabilityBoundingSet=_/_AmbientCapabilities=_ above.
T}
T{
219
T}:T{
**EXIT\_CGROUP**
T}:T{
Setting up the service control group failed.
T}
T{
220
T}:T{
**EXIT\_SETSID**
T}:T{
Failed to create new process session.
T}
T{
221
T}:T{
**EXIT\_CONFIRM**
T}:T{
Execution has been cancelled by the user. See the _systemd.confirm\_spawn=_ kernel command line setting on **kernel-command-line**(7) for details.
T}
T{
222
T}:T{
**EXIT\_STDERR**
T}:T{
Failed to set up standard error output. See _StandardError=_ above.
T}
T{
224
T}:T{
**EXIT\_PAM**
T}:T{
Failed to set up PAM session. See _PAMName=_ above.
T}
T{
225
T}:T{
**EXIT\_NETWORK**
T}:T{
Failed to set up network namespacing. See _PrivateNetwork=_ above.
T}
T{
226
T}:T{
**EXIT\_NAMESPACE**
T}:T{
Failed to set up mount namespacing. See _ReadOnlyPaths=_ and related settings above.
T}
T{
227
T}:T{
**EXIT\_NO\_NEW\_PRIVILEGES**
T}:T{
Failed to disable new privileges. See _NoNewPrivileges=yes_ above.
T}
T{
228
T}:T{
**EXIT\_SECCOMP**
T}:T{
Failed to apply system call filters. See _SystemCallFilter=_ and related settings above.
T}
T{
229
T}:T{
**EXIT\_SELINUX\_CONTEXT**
T}:T{
Determining or changing SELinux context failed. See _SELinuxContext=_ above.
T}
T{
230
T}:T{
**EXIT\_PERSONALITY**
T}:T{
Failed to set up an execution domain (personality). See _Personality=_ above.
T}
T{
231
T}:T{
**EXIT\_APPARMOR\_PROFILE**
T}:T{
Failed to prepare changing AppArmor profile. See _AppArmorProfile=_ above.
T}
T{
232
T}:T{
**EXIT\_ADDRESS\_FAMILIES**
T}:T{
Failed to restrict address families. See _RestrictAddressFamilies=_ above.
T}
T{
233
T}:T{
**EXIT\_RUNTIME\_DIRECTORY**
T}:T{
Setting up runtime directory failed. See _RuntimeDirectory=_ and related settings above.
T}
T{
235
T}:T{
**EXIT\_CHOWN**
T}:T{
Failed to adjust socket ownership. Used for socket units only.
T}
T{
236
T}:T{
**EXIT\_SMACK\_PROCESS\_LABEL**
T}:T{
Failed to set SMACK label. See _SmackProcessLabel=_ above.
T}
T{
237
T}:T{
**EXIT\_KEYRING**
T}:T{
Failed to set up kernel keyring.
T}
T{
238
T}:T{
**EXIT\_STATE\_DIRECTORY**
T}:T{
Failed to set up units state directory. See _StateDirectory=_ above.
T}
T{
239
T}:T{
**EXIT\_CACHE\_DIRECTORY**
T}:T{
Failed to set up units cache directory. See _CacheDirectory=_ above.
T}
T{
240
T}:T{
**EXIT\_LOGS\_DIRECTORY**
T}:T{
Failed to set up units logging directory. See _LogsDirectory=_ above.
T}
T{
241
T}:T{
**EXIT\_CONFIGURATION\_DIRECTORY**
T}:T{
Failed to set up units configuration directory. See _ConfigurationDirectory=_ above.
T}
.TE


Finally, the BSD operating systems define a set of exit codes, typically defined on Linux systems too:

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;9.&nbsp;BSD exit codes**
.TS
allbox tab(:);
lB lB lB.
T{
Exit Code
T}:T{
Symbolic Name
T}:T{
Description
T}
.T&
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l.
T{
64
T}:T{
**EX\_USAGE**
T}:T{
Command line usage error
T}
T{
65
T}:T{
**EX\_DATAERR**
T}:T{
Data format error
T}
T{
66
T}:T{
**EX\_NOINPUT**
T}:T{
Cannot open input
T}
T{
67
T}:T{
**EX\_NOUSER**
T}:T{
Addressee unknown
T}
T{
68
T}:T{
**EX\_NOHOST**
T}:T{
Host name unknown
T}
T{
69
T}:T{
**EX\_UNAVAILABLE**
T}:T{
Service unavailable
T}
T{
70
T}:T{
**EX\_SOFTWARE**
T}:T{
internal software error
T}
T{
71
T}:T{
**EX\_OSERR**
T}:T{
System error (e.g., cant fork)
T}
T{
72
T}:T{
**EX\_OSFILE**
T}:T{
Critical OS file missing
T}
T{
73
T}:T{
**EX\_CANTCREAT**
T}:T{
Cant create (user) output file
T}
T{
74
T}:T{
**EX\_IOERR**
T}:T{
Input/output error
T}
T{
75
T}:T{
**EX\_TEMPFAIL**
T}:T{
Temporary failure; user is invited to retry
T}
T{
76
T}:T{
**EX\_PROTOCOL**
T}:T{
Remote error in protocol
T}
T{
77
T}:T{
**EX\_NOPERM**
T}:T{
Permission denied
T}
T{
78
T}:T{
**EX\_CONFIG**
T}:T{
Configuration error
T}
.TE


<a name="see-also"></a>

# See Also


**systemd**(1),
**systemctl**(1),
**systemd-analyze**(1),
**journalctl**(1),
**systemd-system.conf**(5),
**systemd.unit**(5),
**systemd.service**(5),
**systemd.socket**(5),
**systemd.swap**(5),
**systemd.mount**(5),
**systemd.kill**(5),
**systemd.resource-control**(5),
**systemd.time**(7),
**systemd.directives**(7),
**tmpfiles.d**(5),
**exec**(3)

<a name="notes"></a>

# Notes


*  1.  
  Discoverable Partitions Specification
      https://www.freedesktop.org/wiki/Specifications/DiscoverablePartitionsSpec/
*  2.  
  No New Privileges Flag
      https://www.kernel.org/doc/html/latest/userspace-api/no_new_privs.html
*  3.  
  proc.txt
      https://www.kernel.org/doc/Documentation/filesystems/proc.txt
*  4.  
  Base64
      https://tools.ietf.org/html/rfc2045#section-6.8
*  5.  
  LSB specification
      https://refspecs.linuxbase.org/LSB_5.0.0/LSB-Core-generic/LSB-Core-generic/iniscrptact.html
