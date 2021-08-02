# systemd\&.unit(5)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd.unit - Unit configuration

<a name="synopsis"></a>

# Synopsis

```

 service.service, socket.socket, device.device, mount.mount, automount.automount, swap.swap, target.target, path.path, timer.timer, slice.slice, scope.scope
</synopsis>

<a name="system-unit-search-path"></a>

### System Unit Search Path

<synopsis>


</synopsis>
    /etc/systemd/system.control/*
    /run/systemd/system.control/*
    /run/systemd/transient/*
    /run/systemd/generator.early/*
    /etc/systemd/system/*
    /etc/systemd/systemd.attached/*
    /run/systemd/system/*
    /run/systemd/systemd.attached/*
    /run/systemd/generator/*
    ...
    /usr/lib/systemd/system/*
    /run/systemd/generator.late/*

<a name="user-unit-search-path"></a>

### User Unit Search Path

<synopsis>


```
    ~/.config/systemd/user.control/*
    $XDG_RUNTIME_DIR/systemd/user.control/*
    $XDG_RUNTIME_DIR/systemd/transient/*
    $XDG_RUNTIME_DIR/systemd/generator.early/*
    ~/.config/systemd/user/*
    /etc/systemd/user/*
    $XDG_RUNTIME_DIR/systemd/user/*
    /run/systemd/user/*
    $XDG_RUNTIME_DIR/systemd/generator/*
    ~/.local/share/systemd/user/*
    ...
    /usr/lib/systemd/user/*
    $XDG_RUNTIME_DIR/systemd/generator.late/*

<a name="description"></a>

# Description


A unit file is a plain text ini-style file that encodes information about a service, a socket, a device, a mount point, an automount point, a swap file or partition, a start-up target, a watched file system path, a timer controlled and supervised by
**systemd**(1), a resource management slice or a group of externally created processes. See
**systemd.syntax**(5)
for a general description of the syntax.

This man page lists the common configuration options of all the unit types. These options need to be configured in the [Unit] or [Install] sections of the unit files.

In addition to the generic [Unit] and [Install] sections described here, each unit may have a type-specific section, e.g. [Service] for a service unit. See the respective man pages for more information:
**systemd.service**(5),
**systemd.socket**(5),
**systemd.device**(5),
**systemd.mount**(5),
**systemd.automount**(5),
**systemd.swap**(5),
**systemd.target**(5),
**systemd.path**(5),
**systemd.timer**(5),
**systemd.slice**(5),
**systemd.scope**(5).

Unit files are loaded from a set of paths determined during compilation, described in the next section.

Unit files can be parameterized by a single argument called the "instance name". The unit is then constructed based on a "template file" which serves as the definition of multiple services or other units. A template unit must have a single
"@"
at the end of the name (right before the type suffix). The name of the full unit is formed by inserting the instance name between
"@"
and the unit type suffix. In the unit file itself, the instance parameter may be referred to using
"%i"
and other specifiers, see below.

Unit files may contain additional options on top of those listed here. If systemd encounters an unknown option, it will write a warning log message but continue loading the unit. If an option or section name is prefixed with
**X-**, it is ignored completely by systemd. Options within an ignored section do not need the prefix. Applications may use this to include additional information in the unit files.

Units can be aliased (have an alternative name), by creating a symlink from the new name to the existing name in one of the unit search paths. For example,
systemd-networkd.service
has the alias
dbus-org.freedesktop.network1.service, created during installation as a symlink, so when
**systemd**
is asked through D-Bus to load
dbus-org.freedesktop.network1.service, itll load
systemd-networkd.service. Alias names may be used in commands like
**enable**,
**disable**,
**start**,
**stop**,
**status**, and similar, and in all unit dependency directives, including
_Wants=_,
_Requires=_,
_Before=_,
_After=_. Aliases cannot be used with the
**preset**
command.

Unit files may specify aliases through the
_Alias=_
directive in the [Install] section. When the unit is enabled, symlinks will be created for those names, and removed when the unit is disabled. For example,
reboot.target
specifies
_Alias=ctrl-alt-del.target_, so when enabled, the symlink
/etc/systemd/systemd/ctrl-alt-del.service
pointing to the
reboot.target
file will be created, and when
Ctrl+Alt+Del
is invoked,
**systemd**
will look for the
ctrl-alt-del.service
and execute
reboot.service.
**systemd**
does not look at the [Install] section at all during normal operation, so any directives in that section only have an effect through the symlinks created during enablement.

Along with a unit file
foo.service, the directory
foo.service.wants/
may exist. All unit files symlinked from such a directory are implicitly added as dependencies of type
_Wants=_
to the unit. Similar functionality exists for
_Requires=_
type dependencies as well, the directory suffix is
.requires/
in this case. This functionality is useful to hook units into the start-up of other units, without having to modify their unit files. For details about the semantics of
_Wants=_, see below. The preferred way to create symlinks in the
.wants/
or
.requires/
directory of a unit file is by embedding the dependency in [Install] section of the target unit, and creating the symlink in the file system with the
**enable**
or
**preset**
commands of
**systemctl**(1).

Along with a unit file
foo.service, a "drop-in" directory
foo.service.d/
may exist. All files with the suffix
".conf"
from this directory will be parsed after the unit file itself is parsed. This is useful to alter or add configuration settings for a unit, without having to modify unit files. Drop-in files must contain appropriate section headers. For instantiated units, this logic will first look for the instance
".d/"
subdirectory (e.g.
"foo@bar.service.d/") and read its
".conf"
files, followed by the template
".d/"
subdirectory (e.g.
"foo@.service.d/") and the
".conf"
files there. Moreover for units names containing dashes ("-"), the set of directories generated by truncating the unit name after all dashes is searched too. Specifically, for a unit name
foo-bar-baz.service
not only the regular drop-in directory
foo-bar-baz.service.d/
is searched but also both
foo-bar-.service.d/
and
foo-.service.d/. This is useful for defining common drop-ins for a set of related units, whose names begin with a common prefix. This scheme is particularly useful for mount, automount and slice units, whose systematic naming structure is built around dashes as component separators. Note that equally named drop-in files further down the prefix hierarchy override those further up, i.e.
foo-bar-.service.d/10-override.conf
overrides
foo-.service.d/10-override.conf.

In addition to
/etc/systemd/system, the drop-in
".d/"
directories for system services can be placed in
/usr/lib/systemd/system
or
/run/systemd/system
directories. Drop-in files in
/etc
take precedence over those in
/run
which in turn take precedence over those in
/usr/lib. Drop-in files under any of these directories take precedence over unit files wherever located. Multiple drop-in files with different names are applied in lexicographic order, regardless of which of the directories they reside in.

Note that while systemd offers a flexible dependency system between units it is recommended to use this functionality only sparingly and instead rely on techniques such as bus-based or socket-based activation which make dependencies implicit, resulting in a both simpler and more flexible system.

As mentioned above, a unit may be instantiated from a template file. This allows creation of multiple units from a single configuration file. If systemd looks for a unit configuration file, it will first search for the literal unit name in the file system. If that yields no success and the unit name contains an
"@"
character, systemd will look for a unit template that shares the same name but with the instance string (i.e. the part between the
"@"
character and the suffix) removed. Example: if a service
getty@tty3.service
is requested and no file by that name is found, systemd will look for
getty@.service
and instantiate a service from that configuration file if it is found.

To refer to the instance string from within the configuration file you may use the special
"%i"
specifier in many of the configuration options. See below for details.

If a unit file is empty (i.e. has the file size 0) or is symlinked to
/dev/null, its configuration will not be loaded and it appears with a load state of
"masked", and cannot be activated. Use this as an effective way to fully disable a unit, making it impossible to start it even manually.

The unit file format is covered by the
\m[blue]**Interface Stability Promise**\m[]\s-2\u[1]\d\s+2.

<a name="string-escaping-for-inclusion-in-unit-names"></a>

# String Escaping for Inclusion in Unit Names


Sometimes it is useful to convert arbitrary strings into unit names. To facilitate this, a method of string escaping is used, in order to map strings containing arbitrary byte values (except NUL) into valid unit names and their restricted character set. A common special case are unit names that reflect paths to objects in the file system hierarchy. Example: a device unit
dev-sda.device
refers to a device with the device node
/dev/sda
in the file system.

The escaping algorithm operates as follows: given a string, any
"/"
character is replaced by
"-", and all other characters which are not ASCII alphanumerics or
"_"
are replaced by C-style
"\ex2d"
escapes. In addition,
"."
is replaced with such a C-style escape when it would appear as the first character in the escaped string.

When the input qualifies as absolute file system path, this algorithm is extended slightly: the path to the root directory
"/"
is encoded as single dash
"-". In addition, any leading, trailing or duplicate
"/"
characters are removed from the string before transformation. Example:
/foo//bar/baz/
becomes
"foo-bar-baz".

This escaping is fully reversible, as long as it is known whether the escaped string was a path (the unescaping results are different for paths and non-path strings). The
**systemd-escape**(1)
command may be used to apply and reverse escaping on arbitrary strings. Use
**systemd-escape --path**
to escape path strings, and
**systemd-escape**
without
**--path**
otherwise.

<a name="automatic-dependencies"></a>

# Automatic Dependencies


<a name="implicit-dependencies"></a>

### Implicit Dependencies


A number of unit dependencies are implicitly established, depending on unit type and unit configuration. These implicit dependencies can make unit configuration file cleaner. For the implicit dependencies in each unit type, please refer to section "Implicit Dependencies" in respective man pages.

For example, service units with
_Type=dbus_
automatically acquire dependencies of type
_Requires=_
and
_After=_
on
dbus.socket. See
**systemd.service**(5)
for details.

<a name="default-dependencies"></a>

### Default Dependencies


Default dependencies are similar to implicit dependencies, but can be turned on and off by setting
_DefaultDependencies=_
to
_yes_
(the default) and
_no_, while implicit dependencies are always in effect. See section "Default Dependencies" in respective man pages for the effect of enabling
_DefaultDependencies=_
in each unit types.

For example, target units will complement all configured dependencies of type
_Wants=_
or
_Requires=_
with dependencies of type
_After=_
unless
_DefaultDependencies=no_
is set in the specified units. See
**systemd.target**(5)
for details. Note that this behavior can be turned off by setting
_DefaultDependencies=no_.

<a name="unit-file-load-path"></a>

# Unit File Load Path


Unit files are loaded from a set of paths determined during compilation, described in the two tables below. Unit files found in directories listed earlier override files with the same name in directories lower in the list.

When the variable
_$SYSTEMD\_UNIT\_PATH_
is set, the contents of this variable overrides the unit load path. If
_$SYSTEMD\_UNIT\_PATH_
ends with an empty component (":"), the usual unit load path will be appended to the contents of the variable.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;1.&nbsp; Load path when running in system mode (--system).**
.TS
allbox tab(:);
lB lB.
T{
Path
T}:T{
Description
T}
.T&
l l
l ^
l l
l l
l l
l l
l l
l l
l ^
l l.
T{
/etc/systemd/system.control
T}:T{
Persistent and transient configuration created using the dbus API
T}
T{
/run/systemd/system.control
T}:
T{
/run/systemd/transient
T}:T{
Dynamic configuration for transient units
T}
T{
/run/systemd/generator.early
T}:T{
Generated units with high priority (see _early-dir_ in **systemd.generator**(7))
T}
T{
/etc/systemd/system
T}:T{
Local configuration
T}
T{
/run/systemd/system
T}:T{
Runtime units
T}
T{
/run/systemd/generator
T}:T{
Generated units with medium priority (see _normal-dir_ in **systemd.generator**(7))
T}
T{
/usr/local/lib/systemd/system
T}:T{
Units of installed packages
T}
T{
/usr/lib/systemd/system
T}:
T{
/run/systemd/generator.late
T}:T{
Generated units with low priority (see _late-dir_ in **systemd.generator**(7))
T}
.TE


.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;2.&nbsp; Load path when running in user mode (--user).**
.TS
allbox tab(:);
lB lB.
T{
Path
T}:T{
Description
T}
.T&
l l
l ^
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
l ^
l l.
T{
$XDG_CONFIG_HOME/systemd/user.control or ~/.config/systemd/user.control
T}:T{
Persistent and transient configuration created using the dbus API (_$XDG\_CONFIG\_HOME_ is used if set, ~/.config otherwise)
T}
T{
$XDG_RUNTIME_DIR/systemd/user.control
T}:
T{
/run/systemd/transient
T}:T{
Dynamic configuration for transient units
T}
T{
/run/systemd/generator.early
T}:T{
Generated units with high priority (see _early-dir_ in **systemd.generator**(7))
T}
T{
$XDG_CONFIG_HOME/systemd/user or $HOME/.config/systemd/user
T}:T{
User configuration (_$XDG\_CONFIG\_HOME_ is used if set, ~/.config otherwise)
T}
T{
/etc/systemd/user
T}:T{
Local configuration
T}
T{
$XDG_RUNTIME_DIR/systemd/user
T}:T{
Runtime units (only used when $XDG_RUNTIME_DIR is set)
T}
T{
/run/systemd/user
T}:T{
Runtime units
T}
T{
$XDG_RUNTIME_DIR/systemd/generator
T}:T{
Generated units with medium priority (see _normal-dir_ in **systemd.generator**(7))
T}
T{
$XDG_DATA_HOME/systemd/user or $HOME/.local/share/systemd/user
T}:T{
Units of packages that have been installed in the home directory (_$XDG\_DATA\_HOME_ is used if set, ~/.local/share otherwise)
T}
T{
$dir/systemd/user for each _$dir_ in _$XDG\_DATA\_DIRS_
T}:T{
Additional locations for installed user units, one for each entry in _$XDG\_DATA\_DIRS_
T}
T{
/usr/local/lib/systemd/user
T}:T{
Units of packages that have been installed system-wide
T}
T{
/usr/lib/systemd/user
T}:
T{
$XDG_RUNTIME_DIR/systemd/generator.late
T}:T{
Generated units with low priority (see _late-dir_ in **systemd.generator**(7))
T}
.TE


The set of load paths for the user manager instance may be augmented or changed using various environment variables. And environment variables may in turn be set using environment generators, see
**systemd.environment-generator**(7). In particular,
_$XDG\_DATA\_HOME_
and
_$XDG\_DATA\_DIRS_
may be easily set using
**systemd-environment-d-generator**(8). Thus, directories listed here are just the defaults. To see the actual list that would be used based on compilation options and current environment use

.if n \{.RS 4
.\}
    systemd-analyze --user unit-paths
.if n \{.RE
.\}

Moreover, additional units might be loaded into systemd ("linked") from directories not on the unit load path. See the
**link**
command for
**systemctl**(1).

<a name="unit-garbage-collection"></a>

# Unit Garbage Collection


The system and service manager loads a units configuration automatically when a unit is referenced for the first time. It will automatically unload the unit configuration and state again when the unit is not needed anymore ("garbage collection"). A unit may be referenced through a number of different mechanisms:

.ie n \{\h'-04' 1.\h'+01'\c
.\}
.el \{.sp -1

*   1.  
  .\}
  Another loaded unit references it with a dependency such as
  _After=_,
  _Wants=_, ...

.ie n \{\h'-04' 2.\h'+01'\c
.\}
.el \{.sp -1

*   2.  
  .\}
  The unit is currently starting, running, reloading or stopping.

.ie n \{\h'-04' 3.\h'+01'\c
.\}
.el \{.sp -1

*   3.  
  .\}
  The unit is currently in the
  **failed**
  state. (But see below.)

.ie n \{\h'-04' 4.\h'+01'\c
.\}
.el \{.sp -1

*   4.  
  .\}
  A job for the unit is pending.

.ie n \{\h'-04' 5.\h'+01'\c
.\}
.el \{.sp -1

*   5.  
  .\}
  The unit is pinned by an active IPC client program.

.ie n \{\h'-04' 6.\h'+01'\c
.\}
.el \{.sp -1

*   6.  
  .\}
  The unit is a special "perpetual" unit that is always active and loaded. Examples for perpetual units are the root mount unit
  -.mount
  or the scope unit
  init.scope
  that the service manager itself lives in.

.ie n \{\h'-04' 7.\h'+01'\c
.\}
.el \{.sp -1

*   7.  
  .\}
  The unit has running processes associated with it.

The garbage collection logic may be altered with the
_CollectMode=_
option, which allows configuration whether automatic unloading of units that are in
**failed**
state is permissible, see below.

Note that when a units configuration and state is unloaded, all execution results, such as exit codes, exit signals, resource consumption and other statistics are lost, except for what is stored in the log subsystem.

Use
**systemctl daemon-reload**
or an equivalent command to reload unit configuration while the unit is already loaded. In this case all configuration settings are flushed out and replaced with the new configuration (which however might not be in effect immediately), however all runtime state is saved/restored.

<a name="unit-section-options"></a>

# [Unit] Section Options


The unit file may include a [Unit] section, which carries generic information about the unit that is not dependent on the type of unit:

_Description=_
A human readable name for the unit. This is used by
**systemd**
(and other UIs) as the label for the unit, so this string should identify the unit rather than describe it, despite the name.
"Apache2 Web Server"
is a good example. Bad examples are
"high-performance light-weight HTTP server"
(too generic) or
"Apache2"
(too specific and meaningless for people who do not know Apache).
**systemd**
will use this string as a noun in status messages ("Starting _description_...",
"Started _description_.",
"Reached target _description_.",
"Failed to start _description_."), so it should be capitalized, and should not be a full sentence or a phrase with a continous verb. Bad examples include
"exiting the container"
or
"updating the database once per day.".

_Documentation=_
A space-separated list of URIs referencing documentation for this unit or its configuration. Accepted are only URIs of the types
"http://",
"https://",
"file:",
"info:",
"man:". For more information about the syntax of these URIs, see
**uri**(7). The URIs should be listed in order of relevance, starting with the most relevant. It is a good idea to first reference documentation that explains what the units purpose is, followed by how it is configured, followed by any other related documentation. This option may be specified more than once, in which case the specified list of URIs is merged. If the empty string is assigned to this option, the list is reset and all prior assignments will have no effect.

_Requires=_
Configures requirement dependencies on other units. If this unit gets activated, the units listed here will be activated as well. If one of the other units fails to activate, and an ordering dependency
_After=_
on the failing unit is set, this unit will not be started. Besides, with or without specifying
_After=_, this unit will be stopped if one of the other units is explicitly stopped. This option may be specified more than once or multiple space-separated units may be specified in one option in which case requirement dependencies for all listed names will be created. Note that requirement dependencies do not influence the order in which services are started or stopped. This has to be configured independently with the
_After=_
or
_Before=_
options. If a unit
foo.service
requires a unit
bar.service
as configured with
_Requires=_
and no ordering is configured with
_After=_
or
_Before=_, then both units will be started simultaneously and without any delay between them if
foo.service
is activated. Often, it is a better choice to use
_Wants=_
instead of
_Requires=_
in order to achieve a system that is more robust when dealing with failing services.

Note that this dependency type does not imply that the other unit always has to be in active state when this unit is running. Specifically: failing condition checks (such as
_ConditionPathExists=_,
_ConditionPathIsSymbolicLink=_, ... — see below) do not cause the start job of a unit with a
_Requires=_
dependency on it to fail. Also, some unit types may deactivate on their own (for example, a service process may decide to exit cleanly, or a device may be unplugged by the user), which is not propagated to units having a
_Requires=_
dependency. Use the
_BindsTo=_
dependency type together with
_After=_
to ensure that a unit may never be in active state without a specific other unit also in active state (see below).

Note that dependencies of this type may also be configured outside of the unit configuration file by adding a symlink to a
.requires/
directory accompanying the unit file. For details, see above.

_Requisite=_
Similar to
_Requires=_. However, if the units listed here are not started already, they will not be started and the starting of this unit will fail immediately.
_Requisite=_
does not imply an ordering dependency, even if both units are started in the same transaction. Hence this setting should usually be combined with
_After=_, to ensure this unit is not started before the other unit.

When
_Requisite=b.service_
is used on
a.service, this dependency will show as
_RequisiteOf=a.service_
in property listing of
b.service.
_RequisiteOf=_
dependency cannot be specified directly.

_Wants=_
A weaker version of
_Requires=_. Units listed in this option will be started if the configuring unit is. However, if the listed units fail to start or cannot be added to the transaction, this has no impact on the validity of the transaction as a whole. This is the recommended way to hook start-up of one unit to the start-up of another unit.

Note that dependencies of this type may also be configured outside of the unit configuration file by adding symlinks to a
.wants/
directory accompanying the unit file. For details, see above.

_BindsTo=_
Configures requirement dependencies, very similar in style to
_Requires=_. However, this dependency type is stronger: in addition to the effect of
_Requires=_
it declares that if the unit bound to is stopped, this unit will be stopped too. This means a unit bound to another unit that suddenly enters inactive state will be stopped too. Units can suddenly, unexpectedly enter inactive state for different reasons: the main process of a service unit might terminate on its own choice, the backing device of a device unit might be unplugged or the mount point of a mount unit might be unmounted without involvement of the system and service manager.

When used in conjunction with
_After=_
on the same unit the behaviour of
_BindsTo=_
is even stronger. In this case, the unit bound to strictly has to be in active state for this unit to also be in active state. This not only means a unit bound to another unit that suddenly enters inactive state, but also one that is bound to another unit that gets skipped due to a failed condition check (such as
_ConditionPathExists=_,
_ConditionPathIsSymbolicLink=_, ... — see below) will be stopped, should it be running. Hence, in many cases it is best to combine
_BindsTo=_
with
_After=_.

When
_BindsTo=b.service_
is used on
a.service, this dependency will show as
_BoundBy=a.service_
in property listing of
b.service.
_BoundBy=_
dependency cannot be specified directly.

_PartOf=_
Configures dependencies similar to
_Requires=_, but limited to stopping and restarting of units. When systemd stops or restarts the units listed here, the action is propagated to this unit. Note that this is a one-way dependency&nbsp;— changes to this unit do not affect the listed units.

When
_PartOf=b.service_
is used on
a.service, this dependency will show as
_ConsistsOf=a.service_
in property listing of
b.service.
_ConsistsOf=_
dependency cannot be specified directly.

_Conflicts=_
A space-separated list of unit names. Configures negative requirement dependencies. If a unit has a
_Conflicts=_
setting on another unit, starting the former will stop the latter and vice versa. Note that this setting is independent of and orthogonal to the
_After=_
and
_Before=_
ordering dependencies.

If a unit A that conflicts with a unit B is scheduled to be started at the same time as B, the transaction will either fail (in case both are required parts of the transaction) or be modified to be fixed (in case one or both jobs are not a required part of the transaction). In the latter case, the job that is not required will be removed, or in case both are not required, the unit that conflicts will be started and the unit that is conflicted is stopped.

_Before=_, _After=_
These two settings expect a space-separated list of unit names. They configure ordering dependencies between units. If a unit
foo.service
contains a setting
**Before=bar.service**
and both units are being started,
bar.services start-up is delayed until
foo.service
has finished starting up. Note that this setting is independent of and orthogonal to the requirement dependencies as configured by
_Requires=_,
_Wants=_
or
_BindsTo=_. It is a common pattern to include a unit name in both the
_After=_
and
_Requires=_
options, in which case the unit listed will be started before the unit that is configured with these options. This option may be specified more than once, in which case ordering dependencies for all listed names are created.
_After=_
is the inverse of
_Before=_, i.e. while
_After=_
ensures that the configured unit is started after the listed unit finished starting up,
_Before=_
ensures the opposite, that the configured unit is fully started up before the listed unit is started. Note that when two units with an ordering dependency between them are shut down, the inverse of the start-up order is applied. i.e. if a unit is configured with
_After=_
on another unit, the former is stopped before the latter if both are shut down. Given two units with any ordering dependency between them, if one unit is shut down and the other is started up, the shutdown is ordered before the start-up. It doesnt matter if the ordering dependency is
_After=_
or
_Before=_, in this case. It also doesnt matter which of the two is shut down, as long as one is shut down and the other is started up. The shutdown is ordered before the start-up in all cases. If two units have no ordering dependencies between them, they are shut down or started up simultaneously, and no ordering takes place. It depends on the unit type when precisely a unit has finished starting up. Most importantly, for service units start-up is considered completed for the purpose of
_Before=_/_After=_
when all its configured start-up commands have been invoked and they either failed or reported start-up success.

_OnFailure=_
A space-separated list of one or more units that are activated when this unit enters the
"failed"
state. A service unit using
_Restart=_
enters the failed state only after the start limits are reached.

_PropagatesReloadTo=_, _ReloadPropagatedFrom=_
A space-separated list of one or more units where reload requests on this unit will be propagated to, or reload requests on the other unit will be propagated to this unit, respectively. Issuing a reload request on a unit will automatically also enqueue a reload request on all units that the reload request shall be propagated to via these two settings.

_JoinsNamespaceOf=_
For units that start processes (such as service units), lists one or more other units whose network and/or temporary file namespace to join. This only applies to unit types which support the
_PrivateNetwork=_
and
_PrivateTmp=_
directives (see
**systemd.exec**(5)
for details). If a unit that has this setting set is started, its processes will see the same
/tmp,
/var/tmp
and network namespace as one listed unit that is started. If multiple listed units are already started, it is not defined which namespace is joined. Note that this setting only has an effect if
_PrivateNetwork=_
and/or
_PrivateTmp=_
is enabled for both the unit that joins the namespace and the unit whose namespace is joined.

_RequiresMountsFor=_
Takes a space-separated list of absolute paths. Automatically adds dependencies of type
_Requires=_
and
_After=_
for all mount units required to access the specified path.

Mount points marked with
**noauto**
are not mounted automatically through
local-fs.target, but are still honored for the purposes of this option, i.e. they will be pulled in by this unit.

_OnFailureJobMode=_
Takes a value of
"fail",
"replace",
"replace-irreversibly",
"isolate",
"flush",
"ignore-dependencies"
or
"ignore-requirements". Defaults to
"replace". Specifies how the units listed in
_OnFailure=_
will be enqueued. See
**systemctl**(1)s
**--job-mode=**
option for details on the possible values. If this is set to
"isolate", only a single unit may be listed in
_OnFailure=_..

_IgnoreOnIsolate=_
Takes a boolean argument. If
**true**, this unit will not be stopped when isolating another unit. Defaults to
**false**
for service, target, socket, busname, timer, and path units, and
**true**
for slice, scope, device, swap, mount, and automount units.

_StopWhenUnneeded=_
Takes a boolean argument. If
**true**, this unit will be stopped when it is no longer used. Note that, in order to minimize the work to be executed, systemd will not stop units by default unless they are conflicting with other units, or the user explicitly requested their shut down. If this option is set, a unit will be automatically cleaned up if no other active unit requires it. Defaults to
**false**.

_RefuseManualStart=_, _RefuseManualStop=_
Takes a boolean argument. If
**true**, this unit can only be activated or deactivated indirectly. In this case, explicit start-up or termination requested by the user is denied, however if it is started or stopped as a dependency of another unit, start-up or termination will succeed. This is mostly a safety feature to ensure that the user does not accidentally activate units that are not intended to be activated explicitly, and not accidentally deactivate units that are not intended to be deactivated. These options default to
**false**.

_AllowIsolate=_
Takes a boolean argument. If
**true**, this unit may be used with the
**systemctl isolate**
command. Otherwise, this will be refused. It probably is a good idea to leave this disabled except for target units that shall be used similar to runlevels in SysV init systems, just as a precaution to avoid unusable system states. This option defaults to
**false**.

_DefaultDependencies=_
Takes a boolean argument. If
**true**, (the default), a few default dependencies will implicitly be created for the unit. The actual dependencies created depend on the unit type. For example, for service units, these dependencies ensure that the service is started only after basic system initialization is completed and is properly terminated on system shutdown. See the respective man pages for details. Generally, only services involved with early boot or late shutdown should set this option to
**false**. It is highly recommended to leave this option enabled for the majority of common units. If set to
**false**, this option does not disable all implicit dependencies, just non-essential ones.

_CollectMode=_
Tweaks the "garbage collection" algorithm for this unit. Takes one of
**inactive**
or
**inactive-or-failed**. If set to
**inactive**
the unit will be unloaded if it is in the
**inactive**
state and is not referenced by clients, jobs or other units — however it is not unloaded if it is in the
**failed**
state. In
**failed**
mode, failed units are not unloaded until the user invoked
**systemctl reset-failed**
on them to reset the
**failed**
state, or an equivalent command. This behaviour is altered if this option is set to
**inactive-or-failed**: in this case the unit is unloaded even if the unit is in a
**failed**
state, and thus an explicitly resetting of the
**failed**
state is not necessary. Note that if this mode is used unit results (such as exit codes, exit signals, consumed resources, ...) are flushed out immediately after the unit completed, except for what is stored in the logging subsystem. Defaults to
**inactive**.

_FailureAction=_, _SuccessAction=_
Configure the action to take when the unit stops and enters a failed state or inactive state. Takes one of
**none**,
**reboot**,
**reboot-force**,
**reboot-immediate**,
**poweroff**,
**poweroff-force**,
**poweroff-immediate**,
**exit**, and
**exit-force**. In system mode, all options are allowed. In user mode, only
**none**,
**exit**, and
**exit-force**
are allowed. Both options default to
**none**.

If
**none**
is set, no action will be triggered.
**reboot**
causes a reboot following the normal shutdown procedure (i.e. equivalent to
**systemctl reboot**).
**reboot-force**
causes a forced reboot which will terminate all processes forcibly but should cause no dirty file systems on reboot (i.e. equivalent to
**systemctl reboot -f**) and
**reboot-immediate**
causes immediate execution of the
**reboot**(2)
system call, which might result in data loss (i.e. equivalent to
**systemctl reboot -ff**). Similarly,
**poweroff**,
**poweroff-force**,
**poweroff-immediate**
have the effect of powering down the system with similar semantics.
**exit**
causes the manager to exit following the normal shutdown procedure, and
**exit-force**
causes it terminate without shutting down services. When
**exit**
or
**exit-force**
is used by default the exit status of the main process of the unit (if this applies) is returned from the service manager. However, this may be overriden with
_FailureActionExitStatus=_/_SuccessActionExitStatus=_, see below.

_FailureActionExitStatus=_, _SuccessActionExitStatus=_
Controls the exit status to propagate back to an invoking container manager (in case of a system service) or service manager (in case of a user manager) when the
_FailureAction=_/_SuccessAction=_
are set to
**exit**
or
**exit-force**
and the action is triggered. By default the exit status of the main process of the triggering unit (if this applies) is propagated. Takes a value in the range 0...255 or the empty string to request default behaviour.

_JobTimeoutSec=_, _JobRunningTimeoutSec=_
When a job for this unit is queued, a timeout
_JobTimeoutSec=_
may be configured. Similarly,
_JobRunningTimeoutSec=_
starts counting when the queued job is actually started. If either time limit is reached, the job will be cancelled, the unit however will not change state or even enter the
"failed"
mode. This value defaults to
"infinity"
(job timeouts disabled), except for device units (_JobRunningTimeoutSec=_
defaults to
_DefaultTimeoutStartSec=_). NB: this timeout is independent from any unit-specific timeout (for example, the timeout set with
_TimeoutStartSec=_
in service units) as the job timeout has no effect on the unit itself, only on the job that might be pending for it. Or in other words: unit-specific timeouts are useful to abort unit state changes, and revert them. The job timeout set with this option however is useful to abort only the job waiting for the unit state to change.

_JobTimeoutAction=_, _JobTimeoutRebootArgument=_
_JobTimeoutAction=_
optionally configures an additional action to take when the timeout is hit, see description of
_JobTimeoutSec=_
and
_JobRunningTimeoutSec=_
above. It takes the same values as
_StartLimitAction=_. Defaults to
**none**.
_JobTimeoutRebootArgument=_
configures an optional reboot string to pass to the
**reboot**(2)
system call.

_StartLimitIntervalSec=__interval_, _StartLimitBurst=__burst_
Configure unit start rate limiting. Units which are started more than
_burst_
times within an
_interval_
time interval are not permitted to start any more. Use
_StartLimitIntervalSec=_
to configure the checking interval (defaults to
_DefaultStartLimitIntervalSec=_
in manager configuration file, set it to 0 to disable any kind of rate limiting). Use
_StartLimitBurst=_
to configure how many starts per interval are allowed (defaults to
_DefaultStartLimitBurst=_
in manager configuration file). These configuration options are particularly useful in conjunction with the service setting
_Restart=_
(see
**systemd.service**(5)); however, they apply to all kinds of starts (including manual), not just those triggered by the
_Restart=_
logic. Note that units which are configured for
_Restart=_
and which reach the start limit are not attempted to be restarted anymore; however, they may still be restarted manually at a later point, after the
_interval_
has passed. From this point on, the restart logic is activated again. Note that
**systemctl reset-failed**
will cause the restart rate counter for a service to be flushed, which is useful if the administrator wants to manually start a unit and the start limit interferes with that. Note that this rate-limiting is enforced after any unit condition checks are executed, and hence unit activations with failing conditions do not count towards this rate limit. This setting does not apply to slice, target, device, and scope units, since they are unit types whose activation may either never fail, or may succeed only a single time.

When a unit is unloaded due to the garbage collection logic (see above) its rate limit counters are flushed out too. This means that configuring start rate limiting for a unit that is not referenced continuously has no effect.

_StartLimitAction=_
Configure an additional action to take if the rate limit configured with
_StartLimitIntervalSec=_
and
_StartLimitBurst=_
is hit. Takes the same values as the setting
_FailureAction=_/_SuccessAction=_
settings and executes the same actions. If
**none**
is set, hitting the rate limit will trigger no action besides that the start will not be permitted. Defaults to
**none**.

_RebootArgument=_
Configure the optional argument for the
**reboot**(2)
system call if
_StartLimitAction=_
or
_FailureAction=_
is a reboot action. This works just like the optional argument to
**systemctl reboot**
command.

_ConditionArchitecture=_, _ConditionVirtualization=_, _ConditionHost=_, _ConditionKernelCommandLine=_, _ConditionKernelVersion=_, _ConditionSecurity=_, _ConditionCapability=_, _ConditionACPower=_, _ConditionNeedsUpdate=_, _ConditionFirstBoot=_, _ConditionPathExists=_, _ConditionPathExistsGlob=_, _ConditionPathIsDirectory=_, _ConditionPathIsSymbolicLink=_, _ConditionPathIsMountPoint=_, _ConditionPathIsReadWrite=_, _ConditionDirectoryNotEmpty=_, _ConditionFileNotEmpty=_, _ConditionFileIsExecutable=_, _ConditionUser=_, _ConditionGroup=_, _ConditionControlGroupController=_
Before starting a unit, verify that the specified condition is true. If it is not true, the starting of the unit will be (mostly silently) skipped, however all ordering dependencies of it are still respected. A failing condition will not result in the unit being moved into the
"failed"
state. The condition is checked at the time the queued start job is to be executed. Use condition expressions in order to silently skip units that do not apply to the local running system, for example because the kernel or runtime environment doesnt require their functionality. Use the various
_AssertArchitecture=_,
_AssertVirtualization=_, ... options for a similar mechanism that causes the job to fail (instead of being skipped) and results in logging about the failed check (instead of being silently processed). For details about assertion conditions see below.

_ConditionArchitecture=_
may be used to check whether the system is running on a specific architecture. Takes one of
_x86_,
_x86-64_,
_ppc_,
_ppc-le_,
_ppc64_,
_ppc64-le_,
_ia64_,
_parisc_,
_parisc64_,
_s390_,
_s390x_,
_sparc_,
_sparc64_,
_mips_,
_mips-le_,
_mips64_,
_mips64-le_,
_alpha_,
_arm_,
_arm-be_,
_arm64_,
_arm64-be_,
_sh_,
_sh64_,
_m68k_,
_tilegx_,
_cris_,
_arc_,
_arc-be_
to test against a specific architecture. The architecture is determined from the information returned by
**uname**(2)
and is thus subject to
**personality**(2). Note that a
_Personality=_
setting in the same unit file has no effect on this condition. A special architecture name
_native_
is mapped to the architecture the system manager itself is compiled for. The test may be negated by prepending an exclamation mark.

_ConditionVirtualization=_
may be used to check whether the system is executed in a virtualized environment and optionally test whether it is a specific implementation. Takes either boolean value to check if being executed in any virtualized environment, or one of
_vm_
and
_container_
to test against a generic type of virtualization solution, or one of
_qemu_,
_kvm_,
_zvm_,
_vmware_,
_microsoft_,
_oracle_,
_xen_,
_bochs_,
_uml_,
_bhyve_,
_qnx_,
_openvz_,
_lxc_,
_lxc-libvirt_,
_systemd-nspawn_,
_docker_,
_rkt_
to test against a specific implementation, or
_private-users_
to check whether we are running in a user namespace. See
**systemd-detect-virt**(1)
for a full list of known virtualization technologies and their identifiers. If multiple virtualization technologies are nested, only the innermost is considered. The test may be negated by prepending an exclamation mark.

_ConditionHost=_
may be used to match against the hostname or machine ID of the host. This either takes a hostname string (optionally with shell style globs) which is tested against the locally set hostname as returned by
**gethostname**(2), or a machine ID formatted as string (see
**machine-id**(5)). The test may be negated by prepending an exclamation mark.

_ConditionKernelCommandLine=_
may be used to check whether a specific kernel command line option is set (or if prefixed with the exclamation mark unset). The argument must either be a single word, or an assignment (i.e. two words, separated
"="). In the former case the kernel command line is searched for the word appearing as is, or as left hand side of an assignment. In the latter case, the exact assignment is looked for with right and left hand side matching.

_ConditionKernelVersion=_
may be used to check whether the kernel version (as reported by
**uname -r**) matches a certain expression (or if prefixed with the exclamation mark does not match it). The argument must be a single string. If the string starts with one of
"&lt;",
"&lt;=",
"=",
"&gt;=",
"&gt;"
a relative version comparison is done, otherwise the specified string is matched with shell-style globs.

Note that using the kernel version string is an unreliable way to determine which features are supported by a kernel, because of the widespread practice of backporting drivers, features, and fixes from newer upstream kernels into older versions provided by distributions. Hence, this check is inherently unportable and should not be used for units which may be used on different distributions.

_ConditionSecurity=_
may be used to check whether the given security technology is enabled on the system. Currently, the recognized values are
_selinux_,
_apparmor_,
_tomoyo_,
_ima_,
_smack_,
_audit_
and
_uefi-secureboot_. The test may be negated by prepending an exclamation mark.

_ConditionCapability=_
may be used to check whether the given capability exists in the capability bounding set of the service manager (i.e. this does not check whether capability is actually available in the permitted or effective sets, see
**capabilities**(7)
for details). Pass a capability name such as
"CAP_MKNOD", possibly prefixed with an exclamation mark to negate the check.

_ConditionACPower=_
may be used to check whether the system has AC power, or is exclusively battery powered at the time of activation of the unit. This takes a boolean argument. If set to
_true_, the condition will hold only if at least one AC connector of the system is connected to a power source, or if no AC connectors are known. Conversely, if set to
_false_, the condition will hold only if there is at least one AC connector known and all AC connectors are disconnected from a power source.

_ConditionNeedsUpdate=_
takes one of
/var
or
/etc
as argument, possibly prefixed with a
"!"
(for inverting the condition). This condition may be used to conditionalize units on whether the specified directory requires an update because
/usrs modification time is newer than the stamp file
.updated
in the specified directory. This is useful to implement offline updates of the vendor operating system resources in
/usr
that require updating of
/etc
or
/var
on the next following boot. Units making use of this condition should order themselves before
**systemd-update-done.service**(8), to make sure they run before the stamp files modification time gets reset indicating a completed update.

_ConditionFirstBoot=_
takes a boolean argument. This condition may be used to conditionalize units on whether the system is booting up with an unpopulated
/etc
directory (specifically: an
/etc
with no
/etc/machine-id). This may be used to populate
/etc
on the first boot after factory reset, or when a new system instance boots up for the first time.

With
_ConditionPathExists=_
a file existence condition is checked before a unit is started. If the specified absolute path name does not exist, the condition will fail. If the absolute path name passed to
_ConditionPathExists=_
is prefixed with an exclamation mark ("!"), the test is negated, and the unit is only started if the path does not exist.

_ConditionPathExistsGlob=_
is similar to
_ConditionPathExists=_, but checks for the existence of at least one file or directory matching the specified globbing pattern.

_ConditionPathIsDirectory=_
is similar to
_ConditionPathExists=_
but verifies whether a certain path exists and is a directory.

_ConditionPathIsSymbolicLink=_
is similar to
_ConditionPathExists=_
but verifies whether a certain path exists and is a symbolic link.

_ConditionPathIsMountPoint=_
is similar to
_ConditionPathExists=_
but verifies whether a certain path exists and is a mount point.

_ConditionPathIsReadWrite=_
is similar to
_ConditionPathExists=_
but verifies whether the underlying file system is readable and writable (i.e. not mounted read-only).

_ConditionDirectoryNotEmpty=_
is similar to
_ConditionPathExists=_
but verifies whether a certain path exists and is a non-empty directory.

_ConditionFileNotEmpty=_
is similar to
_ConditionPathExists=_
but verifies whether a certain path exists and refers to a regular file with a non-zero size.

_ConditionFileIsExecutable=_
is similar to
_ConditionPathExists=_
but verifies whether a certain path exists, is a regular file and marked executable.

_ConditionUser=_
takes a numeric
"UID", a UNIX user name, or the special value
"@system". This condition may be used to check whether the service manager is running as the given user. The special value
"@system"
can be used to check if the user id is within the system user range. This option is not useful for system services, as the system manager exclusively runs as the root user, and thus the test result is constant.

_ConditionGroup=_
is similar to
_ConditionUser=_
but verifies that the service managers real or effective group, or any of its auxiliary groups match the specified group or GID. This setting does not have a special value
"@system".

_ConditionControlGroupController=_
takes a cgroup controller name (eg.
**cpu**), verifying that it is available for use on the system. For example, a particular controller may not be available if it was disabled on the kernel command line with
_cgroup\_disable=controller_. Multiple controllers may be passed with a space separating them; in this case the condition will only pass if all listed controllers are available for use. Controllers unknown to systemd are ignored. Valid controllers are
**cpu**,
**cpuacct**,
**io**,
**blkio**,
**memory**,
**devices**, and
**pids**.

If multiple conditions are specified, the unit will be executed if all of them apply (i.e. a logical AND is applied). Condition checks can be prefixed with a pipe symbol (|) in which case a condition becomes a triggering condition. If at least one triggering condition is defined for a unit, then the unit will be executed if at least one of the triggering conditions apply and all of the non-triggering conditions. If you prefix an argument with the pipe symbol and an exclamation mark, the pipe symbol must be passed first, the exclamation second. Except for
_ConditionPathIsSymbolicLink=_, all path checks follow symlinks. If any of these options is assigned the empty string, the list of conditions is reset completely, all previous condition settings (of any kind) will have no effect.

_AssertArchitecture=_, _AssertVirtualization=_, _AssertHost=_, _AssertKernelCommandLine=_, _AssertKernelVersion=_, _AssertSecurity=_, _AssertCapability=_, _AssertACPower=_, _AssertNeedsUpdate=_, _AssertFirstBoot=_, _AssertPathExists=_, _AssertPathExistsGlob=_, _AssertPathIsDirectory=_, _AssertPathIsSymbolicLink=_, _AssertPathIsMountPoint=_, _AssertPathIsReadWrite=_, _AssertDirectoryNotEmpty=_, _AssertFileNotEmpty=_, _AssertFileIsExecutable=_, _AssertUser=_, _AssertGroup=_, _AssertControlGroupController=_
Similar to the
_ConditionArchitecture=_,
_ConditionVirtualization=_, ..., condition settings described above, these settings add assertion checks to the start-up of the unit. However, unlike the conditions settings, any assertion setting that is not met results in failure of the start job (which means this is logged loudly). Note that hitting a configured assertion does not cause the unit to enter the
"failed"
state (or in fact result in any state change of the unit), it affects only the job queued for it. Use assertion expressions for units that cannot operate when specific requirements are not met, and when this is something the administrator or user should look into.

Note that neither assertion nor condition expressions result in unit state changes. Also note that both are checked at the time the job is to be executed, i.e. long after depending jobs and it itself were queued. Thus, neither condition nor assertion expressions are suitable for conditionalizing unit dependencies.

_SourcePath=_
A path to a configuration file this unit has been generated from. This is primarily useful for implementation of generator tools that convert configuration from an external configuration file format into native unit files. This functionality should not be used in normal units.

<a name="mapping-of-unit-properties-to-their-inverses"></a>

# Mapping of Unit Properties to Their Inverses


Unit settings that create a relationship with a second unit usually show up in properties of both units, for example in
**systemctl show**
output. In some cases the name of the property is the same as the name of the configuration setting, but not always. This table lists the properties that are shown on two units which are connected through some dependency, and shows which property on "source" unit corresponds to which property on the "target" unit.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;3.&nbsp; Forward and reverse unit properties**
.TS
allbox tab(:);
lB lB lB.
T{
"Forward" property
T}:T{
"Reverse" property
T}:T{
Where used
T}
.T&
l l l
l l ^
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l ^
l l l.
T{
_Before=_
T}:T{
_After=_
T}:T{
Both are unit file options
T}
T{
_After=_
T}:T{
_Before=_
T}:
T{
_Requires=_
T}:T{
_RequiredBy=_
T}:T{
A unit file option; an option in the [Install] section
T}
T{
_Wants=_
T}:T{
_WantedBy=_
T}:T{
A unit file option; an option in the [Install] section
T}
T{
_PartOf=_
T}:T{
_ConsistsOf=_
T}:T{
A unit file option; an automatic property
T}
T{
_BindsTo=_
T}:T{
_BoundBy=_
T}:T{
A unit file option; an automatic property
T}
T{
_Requisite=_
T}:T{
_RequisiteOf=_
T}:T{
A unit file option; an automatic property
T}
T{
_Triggers=_
T}:T{
_TriggeredBy=_
T}:T{
Automatic properties, see notes below
T}
T{
_Conflicts=_
T}:T{
_ConflictedBy=_
T}:T{
A unit file option; an automatic property
T}
T{
_PropagatesReloadTo=_
T}:T{
_ReloadPropagatedFrom=_
T}:T{
Both are unit file options
T}
T{
_ReloadPropagatedFrom=_
T}:T{
_PropagatesReloadTo=_
T}:
T{
_Following=_
T}:T{
n/a
T}:T{
An automatic property
T}
.TE


Note:
_WantedBy=_
and
_RequiredBy=_
are used in the [Install] section to create symlinks in
.wants/
and
.requires/
directories. They cannot be used directly as a unit configuration setting.

Note:
_ConsistsOf=_,
_BoundBy=_,
_RequisiteOf=_,
_ConflictedBy=_
are created implicitly along with their reverses and cannot be specified directly.

Note:
_Triggers=_
is created implicitly between a socket, path unit, or an automount unit, and the unit they activate. By default a unit with the same name is triggered, but this can be overridden using
_Sockets=_,
_Service=_, and
_Unit=_
settings. See
**systemd.service**(5),
**systemd.socket**(5),
**systemd.path**(5), and
**systemd.automount**(5)
for details.
_TriggeredBy=_
is created implicitly on the triggered unit.

Note:
_Following=_
is used to group device aliases and points to the "primary" device unit that systemd is using to track device state, usually corresponding to a sysfs path. It does not show up in the "target" unit.

<a name="install-section-options"></a>

# [Install] Section Options


Unit files may include an
"[Install]"
section, which carries installation information for the unit. This section is not interpreted by
**systemd**(1)
during runtime; it is used by the
**enable**
and
**disable**
commands of the
**systemctl**(1)
tool during installation of a unit.

_Alias=_
A space-separated list of additional names this unit shall be installed under. The names listed here must have the same suffix (i.e. type) as the unit filename. This option may be specified more than once, in which case all listed names are used. At installation time,
**systemctl enable**
will create symlinks from these names to the unit filename. Note that not all unit types support such alias names, and this setting is not supported for them. Specifically, mount, slice, swap, and automount units do not support aliasing.

_WantedBy=_, _RequiredBy=_
This option may be used more than once, or a space-separated list of unit names may be given. A symbolic link is created in the
.wants/
or
.requires/
directory of each of the listed units when this unit is installed by
**systemctl enable**. This has the effect that a dependency of type
_Wants=_
or
_Requires=_
is added from the listed unit to the current unit. The primary result is that the current unit will be started when the listed unit is started. See the description of
_Wants=_
and
_Requires=_
in the [Unit] section for details.

**WantedBy=foo.service**
in a service
bar.service
is mostly equivalent to
**Alias=foo.service.wants/bar.service**
in the same file. In case of template units,
**systemctl enable**
must be called with an instance name, and this instance will be added to the
.wants/
or
.requires/
list of the listed unit. E.g.
**WantedBy=getty.target**
in a service
getty@.service
will result in
**systemctl enable getty@tty2.service**
creating a
getty.target.wants/getty@tty2.service
link to
getty@.service.

_Also=_
Additional units to install/deinstall when this unit is installed/deinstalled. If the user requests installation/deinstallation of a unit with this option configured,
**systemctl enable**
and
**systemctl disable**
will automatically install/uninstall units listed in this option as well.

This option may be used more than once, or a space-separated list of unit names may be given.

_DefaultInstance=_
In template unit files, this specifies for which instance the unit shall be enabled if the template is enabled without any explicitly set instance. This option has no effect in non-template unit files. The specified string must be usable as instance identifier.

The following specifiers are interpreted in the Install section: %n, %N, %p, %i, %j, %g, %G, %U, %u, %m, %H, %b, %v. For their meaning see the next section.

<a name="specifiers"></a>

# Specifiers


Many settings resolve specifiers which may be used to write generic unit files referring to runtime or unit parameters that are replaced when the unit files are loaded. Specifiers must be known and resolvable for the setting to be valid. The following specifiers are understood:

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;4.&nbsp;Specifiers available in unit files**
.TS
allbox tab(:);
lB lB lB.
T{
Specifier
T}:T{
Meaning
T}:T{
Details
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
l l l.
T{
"%b"
T}:T{
Boot ID
T}:T{
The boot ID of the running system, formatted as string. See **random**(4) for more information.
T}
T{
"%C"
T}:T{
Cache directory root
T}:T{
This is either /var/cache (for the system manager) or the path "$XDG_CACHE_HOME" resolves to (for user managers).
T}
T{
"%E"
T}:T{
Configuration directory root
T}:T{
This is either /etc (for the system manager) or the path "$XDG_CONFIG_HOME" resolves to (for user managers).
T}
T{
"%f"
T}:T{
Unescaped filename
T}:T{
This is either the unescaped instance name (if applicable) with / prepended (if applicable), or the unescaped prefix name prepended with /. This implements unescaping according to the rules for escaping absolute file system paths discussed above.
T}
T{
"%h"
T}:T{
User home directory
T}:T{
This is the home directory of the user running the service manager instance. In case of the system manager this resolves to "/root".
T}
T{
"%H"
T}:T{
Host name
T}:T{
The hostname of the running system at the point in time the unit configuration is loaded.
T}
T{
"%i"
T}:T{
Instance name
T}:T{
For instantiated units this is the string between the first "@" character and the type suffix. Empty for non-instantiated units.
T}
T{
"%I"
T}:T{
Unescaped instance name
T}:T{
Same as "%i", but with escaping undone.
T}
T{
"%j"
T}:T{
Final component of the prefix
T}:T{
This is the string between the last "-" and the end of the prefix name. If there is no "-", this is the same as "%p".
T}
T{
"%J"
T}:T{
Unescaped final component of the prefix
T}:T{
Same as "%j", but with escaping undone.
T}
T{
"%L"
T}:T{
Log directory root
T}:T{
This is either /var/log (for the system manager) or the path "$XDG_CONFIG_HOME" resolves to with /log appended (for user managers).
T}
T{
"%m"
T}:T{
Machine ID
T}:T{
The machine ID of the running system, formatted as string. See **machine-id**(5) for more information.
T}
T{
"%n"
T}:T{
Full unit name
T}:T{
&nbsp;T}
T{
"%N"
T}:T{
Full unit name
T}:T{
Same as "%n", but with the type suffix removed.
T}
T{
"%p"
T}:T{
Prefix name
T}:T{
For instantiated units, this refers to the string before the first "@" character of the unit name. For non-instantiated units, same as "%N".
T}
T{
"%P"
T}:T{
Unescaped prefix name
T}:T{
Same as "%p", but with escaping undone.
T}
T{
"%s"
T}:T{
User shell
T}:T{
This is the shell of the user running the service manager instance. In case of the system manager this resolves to "/bin/sh".
T}
T{
"%S"
T}:T{
State directory root
T}:T{
This is either /var/lib (for the system manager) or the path "$XDG_CONFIG_HOME" resolves to (for user managers).
T}
T{
"%t"
T}:T{
Runtime directory root
T}:T{
This is either /run (for the system manager) or the path "$XDG_RUNTIME_DIR" resolves to (for user managers).
T}
T{
"%T"
T}:T{
Directory for temporary files
T}:T{
This is either /tmp or the path "$TMPDIR", "$TEMP" or "$TMP" are set to.
T}
T{
"%g"
T}:T{
User group
T}:T{
This is the name of the group running the service manager instance. In case of the system manager this resolves to "root".
T}
T{
"%G"
T}:T{
User GID
T}:T{
This is the numeric GID of the user running the service manager instance. In case of the system manager this resolves to "0".
T}
T{
"%u"
T}:T{
User name
T}:T{
This is the name of the user running the service manager instance. In case of the system manager this resolves to "root".
T}
T{
"%U"
T}:T{
User UID
T}:T{
This is the numeric UID of the user running the service manager instance. In case of the system manager this resolves to "0".
T}
T{
"%v"
T}:T{
Kernel release
T}:T{
Identical to **uname -r** output
T}
T{
"%V"
T}:T{
Directory for larger and persistent temporary files
T}:T{
This is either /var/tmp or the path "$TMPDIR", "$TEMP" or "$TMP" are set to.
T}
T{
"%%"
T}:T{
Single percent sign
T}:T{
Use "%%" in place of "%" to specify a single percent sign.
T}
.TE


<a name="examples"></a>

# Examples


**Example&nbsp;1.&nbsp;Allowing units to be enabled**

The following snippet (highlighted) allows a unit (e.g.
foo.service) to be enabled via
**systemctl enable**:

.if n \{.RS 4
.\}
    [Unit]
    Description=Foo
    
    [Service]
    ExecStart=/usr/sbin/foo-daemon
    
    [Install]
    WantedBy=multi-user.target
.if n \{.RE
.\}

After running
**systemctl enable**, a symlink
/etc/systemd/system/multi-user.target.wants/foo.service
linking to the actual unit will be created. It tells systemd to pull in the unit when starting
multi-user.target. The inverse
**systemctl disable**
will remove that symlink again.

**Example&nbsp;2.&nbsp;Overriding vendor settings**

There are two methods of overriding vendor settings in unit files: copying the unit file from
/usr/lib/systemd/system
to
/etc/systemd/system
and modifying the chosen settings. Alternatively, one can create a directory named
_unit_.d/
within
/etc/systemd/system
and place a drop-in file
_name_.conf
there that only changes the specific settings one is interested in. Note that multiple such drop-in files are read if present, processed in lexicographic order of their filename.

The advantage of the first method is that one easily overrides the complete unit, the vendor unit is not parsed at all anymore. It has the disadvantage that improvements to the unit file by the vendor are not automatically incorporated on updates.

The advantage of the second method is that one only overrides the settings one specifically wants, where updates to the unit by the vendor automatically apply. This has the disadvantage that some future updates by the vendor might be incompatible with the local changes.

This also applies for user instances of systemd, but with different locations for the unit files. See the section on unit load paths for further details.

Suppose there is a vendor-supplied unit
/usr/lib/systemd/system/httpd.service
with the following contents:

.if n \{.RS 4
.\}
    [Unit]
    Description=Some HTTP server
    After=remote-fs.target sqldb.service
    Requires=sqldb.service
    AssertPathExists=/srv/webserver
    
    [Service]
    Type=notify
    ExecStart=/usr/sbin/some-fancy-httpd-server
    Nice=5
    
    [Install]
    WantedBy=multi-user.target
.if n \{.RE
.\}

Now one wants to change some settings as an administrator: firstly, in the local setup,
/srv/webserver
might not exist, because the HTTP server is configured to use
/srv/www
instead. Secondly, the local configuration makes the HTTP server also depend on a memory cache service,
memcached.service, that should be pulled in (_Requires=_) and also be ordered appropriately (_After=_). Thirdly, in order to harden the service a bit more, the administrator would like to set the
_PrivateTmp=_
setting (see
**systemd.exec**(5)
for details). And lastly, the administrator would like to reset the niceness of the service to its default value of 0.

The first possibility is to copy the unit file to
/etc/systemd/system/httpd.service
and change the chosen settings:

.if n \{.RS 4
.\}
    [Unit]
    Description=Some HTTP server
    After=remote-fs.target sqldb.service memcached.service
    Requires=sqldb.service memcached.service
    AssertPathExists=/srv/www
    
    [Service]
    Type=notify
    ExecStart=/usr/sbin/some-fancy-httpd-server
    Nice=0
    PrivateTmp=yes
    
    [Install]
    WantedBy=multi-user.target
.if n \{.RE
.\}

Alternatively, the administrator could create a drop-in file
/etc/systemd/system/httpd.service.d/local.conf
with the following contents:

.if n \{.RS 4
.\}
    [Unit]
    After=memcached.service
    Requires=memcached.service
    # Reset all assertions and then re-add the condition we want
    AssertPathExists=
    AssertPathExists=/srv/www
    
    [Service]
    Nice=0
    PrivateTmp=yes
.if n \{.RE
.\}

Note that for drop-in files, if one wants to remove entries from a setting that is parsed as a list (and is not a dependency), such as
_AssertPathExists=_
(or e.g.
_ExecStart=_
in service units), one needs to first clear the list before re-adding all entries except the one that is to be removed. Dependencies (_After=_, etc.) cannot be reset to an empty list, so dependencies can only be added in drop-ins. If you want to remove dependencies, you have to override the entire unit.

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemctl**(1),
**systemd-system.conf**(5),
**systemd.special**(7),
**systemd.service**(5),
**systemd.socket**(5),
**systemd.device**(5),
**systemd.mount**(5),
**systemd.automount**(5),
**systemd.swap**(5),
**systemd.target**(5),
**systemd.path**(5),
**systemd.timer**(5),
**systemd.scope**(5),
**systemd.slice**(5),
**systemd.time**(7),
**systemd-analyze**(1),
**capabilities**(7),
**systemd.directives**(7),
**uname**(1)

<a name="notes"></a>

# Notes


*  1.  
  Interface Stability Promise
      https://www.freedesktop.org/wiki/Software/systemd/InterfaceStabilityPromise
