# systemd\&.mount(5)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd.mount - Mount unit configuration

<a name="synopsis"></a>

# Synopsis

```

 mount.mount
```

<a name="description"></a>

# Description


A unit configuration file whose name ends in
".mount"
encodes information about a file system mount point controlled and supervised by systemd.

This man page lists the configuration options specific to this unit type. See
**systemd.unit**(5)
for the common options of all unit configuration files. The common configuration items are configured in the generic [Unit] and [Install] sections. The mount specific configuration options are configured in the [Mount] section.

Additional options are listed in
**systemd.exec**(5), which define the execution environment the
**mount**(8)
program is executed in, and in
**systemd.kill**(5), which define the way the processes are terminated, and in
**systemd.resource-control**(5), which configure resource control settings for the processes of the service.

Note that the options
_User=_
and
_Group=_
are not useful for mount units. systemd passes two parameters to
**mount**(8); the values of
_What=_
and
_Where=_. When invoked in this way,
**mount**(8)
does not read any options from
/etc/fstab, and must be run as UID 0.

Mount units must be named after the mount point directories they control. Example: the mount point
/home/lennart
must be configured in a unit file
home-lennart.mount. For details about the escaping logic used to convert a file system path to a unit name, see
**systemd.unit**(5). Note that mount units cannot be templated, nor is possible to add multiple names to a mount unit by creating additional symlinks to it.

Optionally, a mount unit may be accompanied by an automount unit, to allow on-demand or parallelized mounting. See
**systemd.automount**(5).

Mount points created at runtime (independently of unit files or
/etc/fstab) will be monitored by systemd and appear like any other mount unit in systemd. See
/proc/self/mountinfo
description in
**proc**(5).

Some file systems have special semantics as API file systems for kernel-to-userspace and userspace-to-userspace interfaces. Some of them may not be changed via mount units, and cannot be disabled. For a longer discussion see
\m[blue]**API File Systems**\m[]\s-2\u[1]\d\s+2.

<a name="automatic-dependencies"></a>

# Automatic Dependencies


<a name="implicit-dependencies"></a>

### Implicit Dependencies


The following dependencies are implicitly added:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  If a mount unit is beneath another mount unit in the file system hierarchy, both a requirement dependency and an ordering dependency between both units are created automatically.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Block device backed file systems automatically gain
  _BindsTo=_
  and
  _After=_
  type dependencies on the device unit encapsulating the block device (see below).

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  If traditional file system quota is enabled for a mount unit, automatic
  _Wants=_
  and
  _Before=_
  dependencies on
  systemd-quotacheck.service
  and
  quotaon.service
  are added.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Additional implicit dependencies may be added as result of execution and resource control parameters as documented in
  **systemd.exec**(5)
  and
  **systemd.resource-control**(5).

<a name="default-dependencies"></a>

### Default Dependencies


The following dependencies are added unless
_DefaultDependencies=no_
is set:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  All mount units acquire automatic
  _Before=_
  and
  _Conflicts=_
  on
  umount.target
  in order to be stopped during shutdown.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Mount units referring to local file systems automatically gain an
  _After=_
  dependency on
  local-fs-pre.target, and a
  _Before=_
  dependency on
  local-fs.target
  unless
  **nofail**
  mount option is set.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Network mount units automatically acquire
  _After=_
  dependencies on
  remote-fs-pre.target,
  network.target
  and
  network-online.target, and gain a
  _Before=_
  dependency on
  remote-fs.target
  unless
  **nofail**
  mount option is set. Towards the latter a
  _Wants=_
  unit is added as well.

Mount units referring to local and network file systems are distinguished by their file system type specification. In some cases this is not sufficient (for example network block device based mounts, such as iSCSI), in which case
**\_netdev**
may be added to the mount option string of the unit, which forces systemd to consider the mount unit a network mount.

<a name="fstab"></a>

# Fstab


Mount units may either be configured via unit files, or via
/etc/fstab
(see
**fstab**(5)
for details). Mounts listed in
/etc/fstab
will be converted into native units dynamically at boot and when the configuration of the system manager is reloaded. In general, configuring mount points through
/etc/fstab
is the preferred approach. See
**systemd-fstab-generator**(8)
for details about the conversion.

The NFS mount option
**bg**
for NFS background mounts as documented in
**nfs**(5)
is detected by
**systemd-fstab-generator**
and the options are transformed so that systemd fulfills the job-control implications of that option. Specifically
**systemd-fstab-generator**
acts as though
"x-systemd.mount-timeout=infinity,retry=10000"
was prepended to the option list, and
"fg,nofail"
was appended. Depending on specific requirements, it may be appropriate to provide some of these options explicitly, or to make use of the
"x-systemd.automount"
option described below instead of using
"bg".

When reading
/etc/fstab
a few special mount options are understood by systemd which influence how dependencies are created for mount points. systemd will create a dependency of type
_Wants=_
or
**Requires**
(see option
**nofail**
below), from either
local-fs.target
or
remote-fs.target, depending whether the file system is local or remote.

**x-systemd.requires=**
Configures a
_Requires=_
and an
_After=_
dependency between the created mount unit and another systemd unit, such as a device or mount unit. The argument should be a unit name, or an absolute path to a device node or mount point. This option may be specified more than once. This option is particularly useful for mount point declarations that need an additional device to be around (such as an external journal device for journal file systems) or an additional mount to be in place (such as an overlay file system that merges multiple mount points). See
_After=_
and
_Requires=_
in
**systemd.unit**(5)
for details.

**x-systemd.before=**, **x-systemd.after=**
Configures a
_Before=_
dependency or
_After=_
between the created mount unit and another systemd unit, such as a mount unit. The argument should be a unit name or an absolute path to a mount point. This option may be specified more than once. This option is particularly useful for mount point declarations with
**nofail**
option that are mounted asynchronously but need to be mounted before or after some unit start, for example, before
local-fs.target
unit. See
_Before=_
and
_After=_
in
**systemd.unit**(5)
for details.

**x-systemd.requires-mounts-for=**
Configures a
_RequiresMountsFor=_
dependency between the created mount unit and other mount units. The argument must be an absolute path. This option may be specified more than once. See
_RequiresMountsFor=_
in
**systemd.unit**(5)
for details.

**x-systemd.device-bound**
The block device backed file system will be upgraded to
_BindsTo=_
dependency. This option is only useful when mounting file systems manually with
**mount**(8)
as the default dependency in this case is
_Requires=_. This option is already implied by entries in
/etc/fstab
or by mount units.

**x-systemd.automount**
An automount unit will be created for the file system. See
**systemd.automount**(5)
for details.

**x-systemd.idle-timeout=**
Configures the idle timeout of the automount unit. See
_TimeoutIdleSec=_
in
**systemd.automount**(5)
for details.

**x-systemd.device-timeout=**
Configure how long systemd should wait for a device to show up before giving up on an entry from
/etc/fstab. Specify a time in seconds or explicitly append a unit such as
"s",
"min",
"h",
"ms".

Note that this option can only be used in
/etc/fstab, and will be ignored when part of the
_Options=_
setting in a unit file.

**x-systemd.mount-timeout=**
Configure how long systemd should wait for the mount command to finish before giving up on an entry from
/etc/fstab. Specify a time in seconds or explicitly append a unit such as
"s",
"min",
"h",
"ms".

Note that this option can only be used in
/etc/fstab, and will be ignored when part of the
_Options=_
setting in a unit file.

See
_TimeoutSec=_
below for details.

**x-systemd.makefs**
The file system will be initialized on the device. If the device is not "empty", i.e. it contains any signature, the operation will be skipped. It is hence expected that this option remains set even after the device has been initalized.

Note that this option can only be used in
/etc/fstab, and will be ignored when part of the
_Options=_
setting in a unit file.

See
**systemd-makefs@.service**(8).

**wipefs**(8)
may be used to remove any signatures from a block device to force
**x-systemd.makefs**
to reinitialize the device.

**x-systemd.growfs**
The file system will be grown to occupy the full block device. If the file system is already at maximum size, no action will be performed. It is hence expected that this option remains set even after the file system has been grown. Only certain file system types are supported, see
**systemd-makefs@.service**(8)
for details.

Note that this option can only be used in
/etc/fstab, and will be ignored when part of the
_Options=_
setting in a unit file.

**\_netdev**
Normally the file system type is used to determine if a mount is a "network mount", i.e. if it should only be started after the network is available. Using this option overrides this detection and specifies that the mount requires network.

Network mount units are ordered between
remote-fs-pre.target
and
remote-fs.target, instead of
local-fs-pre.target
and
local-fs.target. They also pull in
network-online.target
and are ordered after it and
network.target.

**noauto**, **auto**
With
**noauto**, the mount unit will not be added as a dependency for
local-fs.target
or
remote-fs.target. This means that it will not be mounted automatically during boot, unless it is pulled in by some other unit. The
**auto**
option has the opposite meaning and is the default. Note that the
**noauto**
option has an effect on the mount unit itself only — if
**x-systemd.automount**
is used (see above), then the matching automount unit will still be pulled in by these targets.

**nofail**
With
**nofail**, this mount will be only wanted, not required, by
local-fs.target
or
remote-fs.target. Moreover the mount unit is not ordered before these target units. This means that the boot will continue without waiting for the mount unit and regardless whether the mount point can be mounted successfully.

**x-initrd.mount**
An additional filesystem to be mounted in the initramfs. See
initrd-fs.target
description in
**systemd.special**(7).

If a mount point is configured in both
/etc/fstab
and a unit file that is stored below
/usr, the former will take precedence. If the unit file is stored below
/etc, it will take precedence. This means: native unit files take precedence over traditional configuration files, but this is superseded by the rule that configuration in
/etc
will always take precedence over configuration in
/usr.

<a name="options"></a>

# Options


Mount files must include a [Mount] section, which carries information about the file system mount points it supervises. A number of options that may be used in this section are shared with other unit types. These options are documented in
**systemd.exec**(5)
and
**systemd.kill**(5). The options specific to the [Mount] section of mount units are the following:

_What=_
Takes an absolute path of a device node, file or other resource to mount. See
**mount**(8)
for details. If this refers to a device node, a dependency on the respective device unit is automatically created. (See
**systemd.device**(5)
for more information.) This option is mandatory. Note that the usual specifier expansion is applied to this setting, literal percent characters should hence be written as
"%%".

_Where=_
Takes an absolute path of a directory for the mount point; in particular, the destination cannot be a symbolic link. If the mount point does not exist at the time of mounting, it is created. This string must be reflected in the unit filename. (See above.) This option is mandatory.

_Type=_
Takes a string for the file system type. See
**mount**(8)
for details. This setting is optional.

_Options=_
Mount options to use when mounting. This takes a comma-separated list of options. This setting is optional. Note that the usual specifier expansion is applied to this setting, literal percent characters should hence be written as
"%%".

_SloppyOptions=_
Takes a boolean argument. If true, parsing of the options specified in
_Options=_
is relaxed, and unknown mount options are tolerated. This corresponds with
**mount**(8)s
_-s_
switch. Defaults to off.

_LazyUnmount=_
Takes a boolean argument. If true, detach the filesystem from the filesystem hierarchy at time of the unmount operation, and clean up all references to the filesystem as soon as they are not busy anymore. This corresponds with
**umount**(8)s
_-l_
switch. Defaults to off.

_ForceUnmount=_
Takes a boolean argument. If true, force an unmount (in case of an unreachable NFS system). This corresponds with
**umount**(8)s
_-f_
switch. Defaults to off.

_DirectoryMode=_
Directories of mount points (and any parent directories) are automatically created if needed. This option specifies the file system access mode used when creating these directories. Takes an access mode in octal notation. Defaults to 0755.

_TimeoutSec=_
Configures the time to wait for the mount command to finish. If a command does not exit within the configured time, the mount will be considered failed and be shut down again. All commands still running will be terminated forcibly via
**SIGTERM**, and after another delay of this time with
**SIGKILL**. (See
**KillMode=**
in
**systemd.kill**(5).) Takes a unit-less value in seconds, or a time span value such as "5min 20s". Pass 0 to disable the timeout logic. The default value is set from
_DefaultTimeoutStartSec=_
option in
**systemd-system.conf**(5).

Check
**systemd.exec**(5)
and
**systemd.kill**(5)
for more settings.

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemctl**(1),
**systemd-system.conf**(5),
**systemd.unit**(5),
**systemd.exec**(5),
**systemd.kill**(5),
**systemd.resource-control**(5),
**systemd.service**(5),
**systemd.device**(5),
**proc**(5),
**mount**(8),
**systemd-fstab-generator**(8),
**systemd.directives**(7)

<a name="notes"></a>

# Notes


*  1.  
  API File Systems
      https://www.freedesktop.org/wiki/Software/systemd/APIFileSystems
