# systemd\&.automount(5)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd.automount - Automount unit configuration

<a name="synopsis"></a>

# Synopsis

```

 automount.automount
```

<a name="description"></a>

# Description


A unit configuration file whose name ends in
".automount"
encodes information about a file system automount point controlled and supervised by systemd.

This man page lists the configuration options specific to this unit type. See
**systemd.unit**(5)
for the common options of all unit configuration files. The common configuration items are configured in the generic [Unit] and [Install] sections. The automount specific configuration options are configured in the [Automount] section.

Automount units must be named after the automount directories they control. Example: the automount point
/home/lennart
must be configured in a unit file
home-lennart.automount. For details about the escaping logic used to convert a file system path to a unit name see
**systemd.unit**(5). Note that automount units cannot be templated, nor is it possible to add multiple names to an automount unit by creating additional symlinks to its unit file.

For each automount unit file a matching mount unit file (see
**systemd.mount**(5)
for details) must exist which is activated when the automount path is accessed. Example: if an automount unit
home-lennart.automount
is active and the user accesses
/home/lennart
the mount unit
home-lennart.mount
will be activated.

Automount units may be used to implement on-demand mounting as well as parallelized mounting of file systems.

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
  If an automount unit is beneath another mount unit in the file system hierarchy, both a requirement and an ordering dependency between both units are created automatically.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  An implicit
  _Before=_
  dependency is created between an automount unit and the mount unit it activates.

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
  Automount units acquire automatic
  _Before=_
  and
  _Conflicts=_
  on
  umount.target
  in order to be stopped during shutdown.

<a name="fstab"></a>

# Fstab


Automount units may either be configured via unit files, or via
/etc/fstab
(see
**fstab**(5)
for details).

For details how systemd parses
/etc/fstab
see
**systemd.mount**(5).

If an automount point is configured in both
/etc/fstab
and a unit file, the configuration in the latter takes precedence.

<a name="options"></a>

# Options


Automount files must include an [Automount] section, which carries information about the file system automount points it supervises. The options specific to the [Automount] section of automount units are the following:

_Where=_
Takes an absolute path of a directory of the automount point. If the automount point does not exist at time that the automount point is installed, it is created. This string must be reflected in the unit filename. (See above.) This option is mandatory.

_DirectoryMode=_
Directories of automount points (and any parent directories) are automatically created if needed. This option specifies the file system access mode used when creating these directories. Takes an access mode in octal notation. Defaults to 0755.

_TimeoutIdleSec=_
Configures an idle timeout. Once the mount has been idle for the specified time, systemd will attempt to unmount. Takes a unit-less value in seconds, or a time span value such as "5min 20s". Pass 0 to disable the timeout logic. The timeout is disabled by default.

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemctl**(1),
**systemd.unit**(5),
**systemd.mount**(5),
**mount**(8),
**automount**(8),
**systemd.directives**(7)
