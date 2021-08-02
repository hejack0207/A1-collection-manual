# systemd\&.resource\-control(5)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd.resource-control - Resource control unit settings

<a name="synopsis"></a>

# Synopsis

```

 slice.slice, scope.scope, service.service, socket.socket, mount.mount, swap.swap
```

<a name="description"></a>

# Description


Unit configuration files for services, slices, scopes, sockets, mount points, and swap devices share a subset of configuration options for resource control of spawned processes. Internally, this relies on the Linux Control Groups (cgroups) kernel concept for organizing processes in a hierarchical tree of named groups for the purpose of resource management.

This man page lists the configuration options shared by those six unit types. See
**systemd.unit**(5)
for the common options of all unit configuration files, and
**systemd.slice**(5),
**systemd.scope**(5),
**systemd.service**(5),
**systemd.socket**(5),
**systemd.mount**(5), and
**systemd.swap**(5)
for more information on the specific unit configuration files. The resource control configuration options are configured in the [Slice], [Scope], [Service], [Socket], [Mount], or [Swap] sections, depending on the unit type.

In addition, options which control resources available to programs
_executed_
by systemd are listed in
**systemd.exec**(5). Those options complement options listed here.

See the
\m[blue]**New Control Group Interfaces**\m[]\s-2\u[1]\d\s+2
for an introduction on how to make use of resource control APIs from programs.

<a name="implicit-dependencies"></a>

# Implicit Dependencies


The following dependencies are implicitly added:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Units with the
  _Slice=_
  setting set automatically acquire
  _Requires=_
  and
  _After=_
  dependencies on the specified slice unit.

<a name="unified-and-legacy-control-group-hierarchies"></a>

# Unified and Legacy Control Group Hierarchies


The unified control group hierarchy is the new version of kernel control group interface, see
\m[blue]**cgroup-v2.txt**\m[]\s-2\u[2]\d\s+2. Depending on the resource type, there are differences in resource control capabilities. Also, because of interface changes, some resource types have separate set of options on the unified hierarchy.


**CPU**
_CPUWeight=_
and
_StartupCPUWeight=_
replace
_CPUShares=_
and
_StartupCPUShares=_, respectively.

The
"cpuacct"
controller does not exist separately on the unified hierarchy.

**Memory**
_MemoryMax=_
replaces
_MemoryLimit=_.
_MemoryLow=_
and
_MemoryHigh=_
are effective only on unified hierarchy.

**IO**
_IO_
prefixed settings are a superset of and replace
_BlockIO_
prefixed ones. On unified hierarchy, IO resource control also applies to buffered writes.

To ease the transition, there is best-effort translation between the two versions of settings. For each controller, if any of the settings for the unified hierarchy are present, all settings for the legacy hierarchy are ignored. If the resulting settings are for the other type of hierarchy, the configurations are translated before application.

Legacy control group hierarchy (see
\m[blue]**cgroups.txt**\m[]\s-2\u[3]\d\s+2), also called cgroup-v1, doesnt allow safe delegation of controllers to unprivileged processes. If the system uses the legacy control group hierarchy, resource control is disabled for systemd user instance, see
**systemd**(1).

<a name="options"></a>

# Options


Units of the types listed above can have settings for resource control configuration:

_CPUAccounting=_
Turn on CPU usage accounting for this unit. Takes a boolean argument. Note that turning on CPU accounting for one unit will also implicitly turn it on for all units contained in the same slice and for all its parent slices and the units contained therein. The system default for this setting may be controlled with
_DefaultCPUAccounting=_
in
**systemd-system.conf**(5).

_CPUWeight=__weight_, _StartupCPUWeight=__weight_
Assign the specified CPU time weight to the processes executed, if the unified control group hierarchy is used on the system. These options take an integer value and control the
"cpu.weight"
control group attribute. The allowed range is 1 to 10000. Defaults to 100. For details about this control group attribute, see
\m[blue]**cgroup-v2.txt**\m[]\s-2\u[2]\d\s+2
and
\m[blue]**sched-design-CFS.txt**\m[]\s-2\u[4]\d\s+2. The available CPU time is split up among all units within one slice relative to their CPU time weight.

While
_StartupCPUWeight=_
only applies to the startup phase of the system,
_CPUWeight=_
applies to normal runtime of the system, and if the former is not set also to the startup phase. Using
_StartupCPUWeight=_
allows prioritizing specific services at boot-up differently than during normal runtime.

These settings replace
_CPUShares=_
and
_StartupCPUShares=_.

_CPUQuota=_
Assign the specified CPU time quota to the processes executed. Takes a percentage value, suffixed with "%". The percentage specifies how much CPU time the unit shall get at maximum, relative to the total CPU time available on one CPU. Use values &gt; 100% for allotting CPU time on more than one CPU. This controls the
"cpu.max"
attribute on the unified control group hierarchy and
"cpu.cfs_quota_us"
on legacy. For details about these control group attributes, see
\m[blue]**cgroup-v2.txt**\m[]\s-2\u[2]\d\s+2
and
\m[blue]**sched-bwc.txt**\m[]\s-2\u[5]\d\s+2.

Example:
_CPUQuota=20%_
ensures that the executed processes will never get more than 20% CPU time on one CPU.

_MemoryAccounting=_
Turn on process and kernel memory accounting for this unit. Takes a boolean argument. Note that turning on memory accounting for one unit will also implicitly turn it on for all units contained in the same slice and for all its parent slices and the units contained therein. The system default for this setting may be controlled with
_DefaultMemoryAccounting=_
in
**systemd-system.conf**(5).

_MemoryMin=__bytes_
Specify the memory usage protection of the executed processes in this unit. If the memory usages of this unit and all its ancestors are below their minimum boundaries, this units memory won\*(Aqt be reclaimed.

Takes a memory size in bytes. If the value is suffixed with K, M, G or T, the specified memory size is parsed as Kilobytes, Megabytes, Gigabytes, or Terabytes (with the base 1024), respectively. Alternatively, a percentage value may be specified, which is taken relative to the installed physical memory on the system. This controls the
"memory.min"
control group attribute. For details about this control group attribute, see
\m[blue]**cgroup-v2.txt**\m[]\s-2\u[2]\d\s+2.

This setting is supported only if the unified control group hierarchy is used and disables
_MemoryLimit=_.

_MemoryLow=__bytes_
Specify the best-effort memory usage protection of the executed processes in this unit. If the memory usages of this unit and all its ancestors are below their low boundaries, this units memory won\*(Aqt be reclaimed as long as memory can be reclaimed from unprotected units.

Takes a memory size in bytes. If the value is suffixed with K, M, G or T, the specified memory size is parsed as Kilobytes, Megabytes, Gigabytes, or Terabytes (with the base 1024), respectively. Alternatively, a percentage value may be specified, which is taken relative to the installed physical memory on the system. This controls the
"memory.low"
control group attribute. For details about this control group attribute, see
\m[blue]**cgroup-v2.txt**\m[]\s-2\u[2]\d\s+2.

This setting is supported only if the unified control group hierarchy is used and disables
_MemoryLimit=_.

_MemoryHigh=__bytes_
Specify the high limit on memory usage of the executed processes in this unit. Memory usage may go above the limit if unavoidable, but the processes are heavily slowed down and memory is taken away aggressively in such cases. This is the main mechanism to control memory usage of a unit.

Takes a memory size in bytes. If the value is suffixed with K, M, G or T, the specified memory size is parsed as Kilobytes, Megabytes, Gigabytes, or Terabytes (with the base 1024), respectively. Alternatively, a percentage value may be specified, which is taken relative to the installed physical memory on the system. If assigned the special value
"infinity", no memory limit is applied. This controls the
"memory.high"
control group attribute. For details about this control group attribute, see
\m[blue]**cgroup-v2.txt**\m[]\s-2\u[2]\d\s+2.

This setting is supported only if the unified control group hierarchy is used and disables
_MemoryLimit=_.

_MemoryMax=__bytes_
Specify the absolute limit on memory usage of the executed processes in this unit. If memory usage cannot be contained under the limit, out-of-memory killer is invoked inside the unit. It is recommended to use
_MemoryHigh=_
as the main control mechanism and use
_MemoryMax=_
as the last line of defense.

Takes a memory size in bytes. If the value is suffixed with K, M, G or T, the specified memory size is parsed as Kilobytes, Megabytes, Gigabytes, or Terabytes (with the base 1024), respectively. Alternatively, a percentage value may be specified, which is taken relative to the installed physical memory on the system. If assigned the special value
"infinity", no memory limit is applied. This controls the
"memory.max"
control group attribute. For details about this control group attribute, see
\m[blue]**cgroup-v2.txt**\m[]\s-2\u[2]\d\s+2.

This setting replaces
_MemoryLimit=_.

_MemorySwapMax=__bytes_
Specify the absolute limit on swap usage of the executed processes in this unit.

Takes a swap size in bytes. If the value is suffixed with K, M, G or T, the specified swap size is parsed as Kilobytes, Megabytes, Gigabytes, or Terabytes (with the base 1024), respectively. If assigned the special value
"infinity", no swap limit is applied. This controls the
"memory.swap.max"
control group attribute. For details about this control group attribute, see
\m[blue]**cgroup-v2.txt**\m[]\s-2\u[2]\d\s+2.

This setting is supported only if the unified control group hierarchy is used and disables
_MemoryLimit=_.

_TasksAccounting=_
Turn on task accounting for this unit. Takes a boolean argument. If enabled, the system manager will keep track of the number of tasks in the unit. The number of tasks accounted this way includes both kernel threads and userspace processes, with each thread counting individually. Note that turning on tasks accounting for one unit will also implicitly turn it on for all units contained in the same slice and for all its parent slices and the units contained therein. The system default for this setting may be controlled with
_DefaultTasksAccounting=_
in
**systemd-system.conf**(5).

_TasksMax=__N_
Specify the maximum number of tasks that may be created in the unit. This ensures that the number of tasks accounted for the unit (see above) stays below a specific limit. This either takes an absolute number of tasks or a percentage value that is taken relative to the configured maximum number of tasks on the system. If assigned the special value
"infinity", no tasks limit is applied. This controls the
"pids.max"
control group attribute. For details about this control group attribute, see
\m[blue]**pids.txt**\m[]\s-2\u[6]\d\s+2.

The system default for this setting may be controlled with
_DefaultTasksMax=_
in
**systemd-system.conf**(5).

_IOAccounting=_
Turn on Block I/O accounting for this unit, if the unified control group hierarchy is used on the system. Takes a boolean argument. Note that turning on block I/O accounting for one unit will also implicitly turn it on for all units contained in the same slice and all for its parent slices and the units contained therein. The system default for this setting may be controlled with
_DefaultIOAccounting=_
in
**systemd-system.conf**(5).

This setting replaces
_BlockIOAccounting=_
and disables settings prefixed with
_BlockIO_
or
_StartupBlockIO_.

_IOWeight=__weight_, _StartupIOWeight=__weight_
Set the default overall block I/O weight for the executed processes, if the unified control group hierarchy is used on the system. Takes a single weight value (between 1 and 10000) to set the default block I/O weight. This controls the
"io.weight"
control group attribute, which defaults to 100. For details about this control group attribute, see
\m[blue]**cgroup-v2.txt**\m[]\s-2\u[2]\d\s+2. The available I/O bandwidth is split up among all units within one slice relative to their block I/O weight.

While
_StartupIOWeight=_
only applies to the startup phase of the system,
_IOWeight=_
applies to the later runtime of the system, and if the former is not set also to the startup phase. This allows prioritizing specific services at boot-up differently than during runtime.

These settings replace
_BlockIOWeight=_
and
_StartupBlockIOWeight=_
and disable settings prefixed with
_BlockIO_
or
_StartupBlockIO_.

_IODeviceWeight=__device__ __weight_
Set the per-device overall block I/O weight for the executed processes, if the unified control group hierarchy is used on the system. Takes a space-separated pair of a file path and a weight value to specify the device specific weight value, between 1 and 10000. (Example:
"/dev/sda 1000"). The file path may be specified as path to a block device node or as any other file, in which case the backing block device of the file system of the file is determined. This controls the
"io.weight"
control group attribute, which defaults to 100. Use this option multiple times to set weights for multiple devices. For details about this control group attribute, see
\m[blue]**cgroup-v2.txt**\m[]\s-2\u[2]\d\s+2.

This setting replaces
_BlockIODeviceWeight=_
and disables settings prefixed with
_BlockIO_
or
_StartupBlockIO_.

_IOReadBandwidthMax=__device__ __bytes_, _IOWriteBandwidthMax=__device__ __bytes_
Set the per-device overall block I/O bandwidth maximum limit for the executed processes, if the unified control group hierarchy is used on the system. This limit is not work-conserving and the executed processes are not allowed to use more even if the device has idle capacity. Takes a space-separated pair of a file path and a bandwidth value (in bytes per second) to specify the device specific bandwidth. The file path may be a path to a block device node, or as any other file in which case the backing block device of the file system of the file is used. If the bandwidth is suffixed with K, M, G, or T, the specified bandwidth is parsed as Kilobytes, Megabytes, Gigabytes, or Terabytes, respectively, to the base of 1000. (Example: "/dev/disk/by-path/pci-0000:00:1f.2-scsi-0:0:0:0 5M"). This controls the
"io.max"
control group attributes. Use this option multiple times to set bandwidth limits for multiple devices. For details about this control group attribute, see
\m[blue]**cgroup-v2.txt**\m[]\s-2\u[2]\d\s+2.

These settings replace
_BlockIOReadBandwidth=_
and
_BlockIOWriteBandwidth=_
and disable settings prefixed with
_BlockIO_
or
_StartupBlockIO_.

_IOReadIOPSMax=__device__ __IOPS_, _IOWriteIOPSMax=__device__ __IOPS_
Set the per-device overall block I/O IOs-Per-Second maximum limit for the executed processes, if the unified control group hierarchy is used on the system. This limit is not work-conserving and the executed processes are not allowed to use more even if the device has idle capacity. Takes a space-separated pair of a file path and an IOPS value to specify the device specific IOPS. The file path may be a path to a block device node, or as any other file in which case the backing block device of the file system of the file is used. If the IOPS is suffixed with K, M, G, or T, the specified IOPS is parsed as KiloIOPS, MegaIOPS, GigaIOPS, or TeraIOPS, respectively, to the base of 1000. (Example: "/dev/disk/by-path/pci-0000:00:1f.2-scsi-0:0:0:0 1K"). This controls the
"io.max"
control group attributes. Use this option multiple times to set IOPS limits for multiple devices. For details about this control group attribute, see
\m[blue]**cgroup-v2.txt**\m[]\s-2\u[2]\d\s+2.

These settings are supported only if the unified control group hierarchy is used and disable settings prefixed with
_BlockIO_
or
_StartupBlockIO_.

_IODeviceLatencyTargetSec=__device__ __target_
Set the per-device average target I/O latency for the executed processes, if the unified control group hierarchy is used on the system. Takes a file path and a timespan separated by a space to specify the device specific latency target. (Example: "/dev/sda 25ms"). The file path may be specified as path to a block device node or as any other file, in which case the backing block device of the file system of the file is determined. This controls the
"io.latency"
control group attribute. Use this option multiple times to set latency target for multiple devices. For details about this control group attribute, see
\m[blue]**cgroup-v2.txt**\m[]\s-2\u[2]\d\s+2.

Implies
"IOAccounting=yes".

These settings are supported only if the unified control group hierarchy is used.

_IPAccounting=_
Takes a boolean argument. If true, turns on IPv4 and IPv6 network traffic accounting for packets sent or received by the unit. When this option is turned on, all IPv4 and IPv6 sockets created by any process of the unit are accounted for.

When this option is used in socket units, it applies to all IPv4 and IPv6 sockets associated with it (including both listening and connection sockets where this applies). Note that for socket-activated services, this configuration setting and the accounting data of the service unit and the socket unit are kept separate, and displayed separately. No propagation of the setting and the collected statistics is done, in either direction. Moreover, any traffic sent or received on any of the socket units sockets is accounted to the socket unit — and never to the service unit it might have activated, even if the socket is used by it.

The system default for this setting may be controlled with
_DefaultIPAccounting=_
in
**systemd-system.conf**(5).

_IPAddressAllow=__ADDRESS[/PREFIXLENGTH]..._, _IPAddressDeny=__ADDRESS[/PREFIXLENGTH]..._
Turn on address range network traffic filtering for packets sent and received over AF_INET and AF_INET6 sockets. Both directives take a space separated list of IPv4 or IPv6 addresses, each optionally suffixed with an address prefix length (separated by a
"/"
character). If the latter is omitted, the address is considered a host address, i.e. the prefix covers the whole address (32 for IPv4, 128 for IPv6).

The access lists configured with this option are applied to all sockets created by processes of this unit (or in the case of socket units, associated with it). The lists are implicitly combined with any lists configured for any of the parent slice units this unit might be a member of. By default all access lists are empty. When configured the lists are enforced as follows:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Access will be granted in case its destination/source address matches any entry in the
  _IPAddressAllow=_
  setting.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Otherwise, access will be denied in case its destination/source address matches any entry in the
  _IPAddressDeny=_
  setting.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Otherwise, access will be granted.

In order to implement a whitelisting IP firewall, it is recommended to use a
_IPAddressDeny=_**any**
setting on an upper-level slice unit (such as the root slice
-.slice
or the slice containing all system services
system.slice
– see
**systemd.special**(7)
for details on these slice units), plus individual per-service
_IPAddressAllow=_
lines permitting network access to relevant services, and only them.

Note that for socket-activated services, the IP access list configured on the socket unit applies to all sockets associated with it directly, but not to any sockets created by the ultimately activated services for it. Conversely, the IP access list configured for the service is not applied to any sockets passed into the service via socket activation. Thus, it is usually a good idea, to replicate the IP access lists on both the socket and the service unit, however it often makes sense to maintain one list more open and the other one more restricted, depending on the usecase.

If these settings are used multiple times in the same unit the specified lists are combined. If an empty string is assigned to these settings the specific access list is reset and all previous settings undone.

In place of explicit IPv4 or IPv6 address and prefix length specifications a small set of symbolic names may be used. The following names are defined:

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;1.&nbsp;Special address/network names**
.TS
allbox tab(:);
lB lB lB.
T{
Symbolic Name
T}:T{
Definition
T}:T{
Meaning
T}
.T&
l l l
l l l
l l l
l l l.
T{
**any**
T}:T{
0.0.0.0/0 ::/0
T}:T{
Any host
T}
T{
**localhost**
T}:T{
127.0.0.0/8 ::1/128
T}:T{
All addresses on the local loopback
T}
T{
**link-local**
T}:T{
169.254.0.0/16 fe80::/64
T}:T{
All link-local IP addresses
T}
T{
**multicast**
T}:T{
224.0.0.0/4 ff00::/8
T}:T{
All IP multicasting addresses
T}
.TE

Note that these settings might not be supported on some systems (for example if eBPF control group support is not enabled in the underlying kernel or container manager). These settings will have no effect in that case. If compatibility with such systems is desired it is hence recommended to not exclusively rely on them for IP security.

_DeviceAllow=_
Control access to specific device nodes by the executed processes. Takes two space-separated strings: a device node specifier followed by a combination of
**r**,
**w**,
**m**
to control
_r_eading,
_w_riting, or creation of the specific device node(s) by the unit (_m_knod), respectively. This controls the
"devices.allow"
and
"devices.deny"
control group attributes. For details about these control group attributes, see
\m[blue]**devices.txt**\m[]\s-2\u[7]\d\s+2.

The device node specifier is either a path to a device node in the file system, starting with
/dev/, or a string starting with either
"char-"
or
"block-"
followed by a device group name, as listed in
/proc/devices. The latter is useful to whitelist all current and future devices belonging to a specific device group at once. The device group is matched according to filename globbing rules, you may hence use the
"*"
and
"?"
wildcards. Examples:
/dev/sda5
is a path to a device node, referring to an ATA or SCSI block device.
"char-pts"
and
"char-alsa"
are specifiers for all pseudo TTYs and all ALSA sound devices, respectively.
"char-cpu/*"
is a specifier matching all CPU related device groups.

_DevicePolicy=auto|closed|strict_
Control the policy for allowing device access:

**strict**
means to only allow types of access that are explicitly specified.

**closed**
in addition, allows access to standard pseudo devices including
/dev/null,
/dev/zero,
/dev/full,
/dev/random, and
/dev/urandom.

**auto**
in addition, allows access to all devices if no explicit
_DeviceAllow=_
is present. This is the default.

_Slice=_
The name of the slice unit to place the unit in. Defaults to
system.slice
for all non-instantiated units of all unit types (except for slice units themselves see below). Instance units are by default placed in a subslice of
system.slice
that is named after the template name.

This option may be used to arrange systemd units in a hierarchy of slices each of which might have resource settings applied.

For units of type slice, the only accepted value for this setting is the parent slice. Since the name of a slice unit implies the parent slice, it is hence redundant to ever set this parameter directly for slice units.

Special care should be taken when relying on the default slice assignment in templated service units that have
_DefaultDependencies=no_
set, see
**systemd.service**(5), section "Default Dependencies" for details.

_Delegate=_
Turns on delegation of further resource control partitioning to processes of the unit. Units where this is enabled may create and manage their own private subhierarchy of control groups below the control group of the unit itself. For unprivileged services (i.e. those using the
_User=_
setting) the units control group will be made accessible to the relevant user. When enabled the service manager will refrain from manipulating control groups or moving processes below the unit\*(Aqs control group, so that a clear concept of ownership is established: the control group tree above the unit\*(Aqs control group (i.e. towards the root control group) is owned and managed by the service manager of the host, while the control group tree below the unit\*(Aqs control group is owned and managed by the unit itself. Takes either a boolean argument or a list of control group controller names. If true, delegation is turned on, and all supported controllers are enabled for the unit, making them available to the unit\*(Aqs processes for management. If false, delegation is turned off entirely (and no additional controllers are enabled). If set to a list of controllers, delegation is turned on, and the specified controllers are enabled for the unit. Note that additional controllers than the ones specified might be made available as well, depending on configuration of the containing slice unit or other units contained in it. Note that assigning the empty string will enable delegation, but reset the list of controllers, all assignments prior to this will have no effect. Defaults to false.

Note that controller delegation to less privileged code is only safe on the unified control group hierarchy. Accordingly, access to the specified controllers will not be granted to unprivileged services on the legacy hierarchy, even when requested.

The following controller names may be specified:
**cpu**,
**cpuacct**,
**io**,
**blkio**,
**memory**,
**devices**,
**pids**. Not all of these controllers are available on all kernels however, and some are specific to the unified hierarchy while others are specific to the legacy hierarchy. Also note that the kernel might support further controllers, which arent covered here yet as delegation is either not supported at all for them or not defined cleanly.

For further details on the delegation model consult
\m[blue]**Control Group APIs and Delegation**\m[]\s-2\u[8]\d\s+2.

_DisableControllers=_
Disables controllers from being enabled for a units children. If a controller listed is already in use in its subtree, the controller will be removed from the subtree. This can be used to avoid child units being able to implicitly or explicitly enable a controller. Defaults to not disabling any controllers.

It may not be possible to successfully disable a controller if the unit or any child of the unit in question delegates controllers to its children, as any delegated subtree of the cgroup hierarchy is unmanaged by systemd.

Multiple controllers may be specified, separated by spaces. You may also pass
_DisableControllers=_
multiple times, in which case each new instance adds another controller to disable. Passing
_DisableControllers=_
by itself with no controller name present resets the disabled controller list.

Valid controllers are
**cpu**,
**cpuacct**,
**io**,
**blkio**,
**memory**,
**devices**, and
**pids**.

<a name="deprecated-options"></a>

# Deprecated Options


The following options are deprecated. Use the indicated superseding options instead:

_CPUShares=__weight_, _StartupCPUShares=__weight_
Assign the specified CPU time share weight to the processes executed. These options take an integer value and control the
"cpu.shares"
control group attribute. The allowed range is 2 to 262144. Defaults to 1024. For details about this control group attribute, see
\m[blue]**sched-design-CFS.txt**\m[]\s-2\u[4]\d\s+2. The available CPU time is split up among all units within one slice relative to their CPU time share weight.

While
_StartupCPUShares=_
only applies to the startup phase of the system,
_CPUShares=_
applies to normal runtime of the system, and if the former is not set also to the startup phase. Using
_StartupCPUShares=_
allows prioritizing specific services at boot-up differently than during normal runtime.

Implies
"CPUAccounting=yes".

These settings are deprecated. Use
_CPUWeight=_
and
_StartupCPUWeight=_
instead.

_MemoryLimit=__bytes_
Specify the limit on maximum memory usage of the executed processes. The limit specifies how much process and kernel memory can be used by tasks in this unit. Takes a memory size in bytes. If the value is suffixed with K, M, G or T, the specified memory size is parsed as Kilobytes, Megabytes, Gigabytes, or Terabytes (with the base 1024), respectively. Alternatively, a percentage value may be specified, which is taken relative to the installed physical memory on the system. If assigned the special value
"infinity", no memory limit is applied. This controls the
"memory.limit_in_bytes"
control group attribute. For details about this control group attribute, see
\m[blue]**memory.txt**\m[]\s-2\u[9]\d\s+2.

Implies
"MemoryAccounting=yes".

This setting is deprecated. Use
_MemoryMax=_
instead.

_BlockIOAccounting=_
Turn on Block I/O accounting for this unit, if the legacy control group hierarchy is used on the system. Takes a boolean argument. Note that turning on block I/O accounting for one unit will also implicitly turn it on for all units contained in the same slice and all for its parent slices and the units contained therein. The system default for this setting may be controlled with
_DefaultBlockIOAccounting=_
in
**systemd-system.conf**(5).

This setting is deprecated. Use
_IOAccounting=_
instead.

_BlockIOWeight=__weight_, _StartupBlockIOWeight=__weight_
Set the default overall block I/O weight for the executed processes, if the legacy control group hierarchy is used on the system. Takes a single weight value (between 10 and 1000) to set the default block I/O weight. This controls the
"blkio.weight"
control group attribute, which defaults to 500. For details about this control group attribute, see
\m[blue]**blkio-controller.txt**\m[]\s-2\u[10]\d\s+2. The available I/O bandwidth is split up among all units within one slice relative to their block I/O weight.

While
_StartupBlockIOWeight=_
only applies to the startup phase of the system,
_BlockIOWeight=_
applies to the later runtime of the system, and if the former is not set also to the startup phase. This allows prioritizing specific services at boot-up differently than during runtime.

Implies
"BlockIOAccounting=yes".

These settings are deprecated. Use
_IOWeight=_
and
_StartupIOWeight=_
instead.

_BlockIODeviceWeight=__device__ __weight_
Set the per-device overall block I/O weight for the executed processes, if the legacy control group hierarchy is used on the system. Takes a space-separated pair of a file path and a weight value to specify the device specific weight value, between 10 and 1000. (Example: "/dev/sda 500"). The file path may be specified as path to a block device node or as any other file, in which case the backing block device of the file system of the file is determined. This controls the
"blkio.weight_device"
control group attribute, which defaults to 1000. Use this option multiple times to set weights for multiple devices. For details about this control group attribute, see
\m[blue]**blkio-controller.txt**\m[]\s-2\u[10]\d\s+2.

Implies
"BlockIOAccounting=yes".

This setting is deprecated. Use
_IODeviceWeight=_
instead.

_BlockIOReadBandwidth=__device__ __bytes_, _BlockIOWriteBandwidth=__device__ __bytes_
Set the per-device overall block I/O bandwidth limit for the executed processes, if the legacy control group hierarchy is used on the system. Takes a space-separated pair of a file path and a bandwidth value (in bytes per second) to specify the device specific bandwidth. The file path may be a path to a block device node, or as any other file in which case the backing block device of the file system of the file is used. If the bandwidth is suffixed with K, M, G, or T, the specified bandwidth is parsed as Kilobytes, Megabytes, Gigabytes, or Terabytes, respectively, to the base of 1000. (Example: "/dev/disk/by-path/pci-0000:00:1f.2-scsi-0:0:0:0 5M"). This controls the
"blkio.throttle.read_bps_device"
and
"blkio.throttle.write_bps_device"
control group attributes. Use this option multiple times to set bandwidth limits for multiple devices. For details about these control group attributes, see
\m[blue]**blkio-controller.txt**\m[]\s-2\u[10]\d\s+2.

Implies
"BlockIOAccounting=yes".

These settings are deprecated. Use
_IOReadBandwidthMax=_
and
_IOWriteBandwidthMax=_
instead.

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemd-system.conf**(5),
**systemd.unit**(5),
**systemd.service**(5),
**systemd.slice**(5),
**systemd.scope**(5),
**systemd.socket**(5),
**systemd.mount**(5),
**systemd.swap**(5),
**systemd.exec**(5),
**systemd.directives**(7),
**systemd.special**(7), The documentation for control groups and specific controllers in the Linux kernel:
\m[blue]**cgroups.txt**\m[]\s-2\u[3]\d\s+2,
\m[blue]**cpuacct.txt**\m[]\s-2\u[11]\d\s+2,
\m[blue]**memory.txt**\m[]\s-2\u[9]\d\s+2,
\m[blue]**blkio-controller.txt**\m[]\s-2\u[10]\d\s+2.
\m[blue]**sched-bwc.txt**\m[]\s-2\u[5]\d\s+2.

<a name="notes"></a>

# Notes


*  1.  
  New Control Group Interfaces
      https://www.freedesktop.org/wiki/Software/systemd/ControlGroupInterface/
*  2.  
  cgroup-v2.txt
      https://www.kernel.org/doc/Documentation/cgroup-v2.txt
*  3.  
  cgroups.txt
      https://www.kernel.org/doc/Documentation/cgroup-v1/cgroups.txt
*  4.  
  sched-design-CFS.txt
      https://www.kernel.org/doc/Documentation/scheduler/sched-design-CFS.txt
*  5.  
  sched-bwc.txt
      https://www.kernel.org/doc/Documentation/scheduler/sched-bwc.txt
*  6.  
  pids.txt
      https://www.kernel.org/doc/Documentation/cgroup-v1/pids.txt
*  7.  
  devices.txt
      https://www.kernel.org/doc/Documentation/cgroup-v1/devices.txt
*  8.  
  Control Group APIs and Delegation
      https://systemd.io/CGROUP_DELEGATION
*  9.  
  memory.txt
      https://www.kernel.org/doc/Documentation/cgroup-v1/memory.txt
* 10.  
  blkio-controller.txt
      https://www.kernel.org/doc/Documentation/cgroup-v1/blkio-controller.txt
* 11.  
  cpuacct.txt
      https://www.kernel.org/doc/Documentation/cgroup-v1/cpuacct.txt
