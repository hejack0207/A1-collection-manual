# systemd\&.path(5)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd.path - Path unit configuration

<a name="synopsis"></a>

# Synopsis

```

 path.path
```

<a name="description"></a>

# Description


A unit configuration file whose name ends in
".path"
encodes information about a path monitored by systemd, for path-based activation.

This man page lists the configuration options specific to this unit type. See
**systemd.unit**(5)
for the common options of all unit configuration files. The common configuration items are configured in the generic [Unit] and [Install] sections. The path specific configuration options are configured in the [Path] section.

For each path file, a matching unit file must exist, describing the unit to activate when the path changes. By default, a service by the same name as the path (except for the suffix) is activated. Example: a path file
foo.path
activates a matching service
foo.service. The unit to activate may be controlled by
_Unit=_
(see below).

Internally, path units use the
**inotify**(7)
API to monitor file systems. Due to that, it suffers by the same limitations as inotify, and for example cannot be used to monitor files or directories changed by other machines on remote NFS file systems.

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
  If a path unit is beneath another mount unit in the file system hierarchy, both a requirement and an ordering dependency between both units are created automatically.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  An implicit
  _Before=_
  dependency is added between a path unit and the unit it is supposed to activate.

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
  Path units will automatically have dependencies of type
  _Before=_
  on
  paths.target, dependencies of type
  _After=_
  and
  _Requires=_
  on
  sysinit.target, and have dependencies of type
  _Conflicts=_
  and
  _Before=_
  on
  shutdown.target. These ensure that path units are terminated cleanly prior to system shutdown. Only path units involved with early boot or late system shutdown should disable
  _DefaultDependencies=_
  option.


<a name="options"></a>

# Options


Path files must include a [Path] section, which carries information about the path(s) it monitors. The options specific to the [Path] section of path units are the following:

_PathExists=_, _PathExistsGlob=_, _PathChanged=_, _PathModified=_, _DirectoryNotEmpty=_
Defines paths to monitor for certain changes:
_PathExists=_
may be used to watch the mere existence of a file or directory. If the file specified exists, the configured unit is activated.
_PathExistsGlob=_
works similar, but checks for the existence of at least one file matching the globbing pattern specified.
_PathChanged=_
may be used to watch a file or directory and activate the configured unit whenever it changes. It is not activated on every write to the watched file but it is activated if the file which was open for writing gets closed.
_PathModified=_
is similar, but additionally it is activated also on simple writes to the watched file.
_DirectoryNotEmpty=_
may be used to watch a directory and activate the configured unit whenever it contains at least one file.

The arguments of these directives must be absolute file system paths.

Multiple directives may be combined, of the same and of different types, to watch multiple paths. If the empty string is assigned to any of these options, the list of paths to watch is reset, and any prior assignments of these options will not have any effect.

If a path already exists (in case of
_PathExists=_
and
_PathExistsGlob=_) or a directory already is not empty (in case of
_DirectoryNotEmpty=_) at the time the path unit is activated, then the configured unit is immediately activated as well. Something similar does not apply to
_PathChanged=_
and
_PathModified=_.

If the path itself or any of the containing directories are not accessible,
**systemd**
will watch for permission changes and notice that conditions are satisfied when permissions allow that.

_Unit=_
The unit to activate when any of the configured paths changes. The argument is a unit name, whose suffix is not
".path". If not specified, this value defaults to a service that has the same name as the path unit, except for the suffix. (See above.) It is recommended that the unit name that is activated and the unit name of the path unit are named identical, except for the suffix.

_MakeDirectory=_
Takes a boolean argument. If true, the directories to watch are created before watching. This option is ignored for
_PathExists=_
settings. Defaults to
**false**.

_DirectoryMode=_
If
_MakeDirectory=_
is enabled, use the mode specified here to create the directories in question. Takes an access mode in octal notation. Defaults to
**0755**.

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemctl**(1),
**systemd.unit**(5),
**systemd.service**(5),
**inotify**(7),
**systemd.directives**(7)
