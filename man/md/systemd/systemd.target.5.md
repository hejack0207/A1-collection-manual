# systemd\&.target(5)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd.target - Target unit configuration

<a name="synopsis"></a>

# Synopsis

```

 target.target
```

<a name="description"></a>

# Description


A unit configuration file whose name ends in
".target"
encodes information about a target unit of systemd, which is used for grouping units and as well-known synchronization points during start-up.

This unit type has no specific options. See
**systemd.unit**(5)
for the common options of all unit configuration files. The common configuration items are configured in the generic [Unit] and [Install] sections. A separate [Target] section does not exist, since no target-specific options may be configured.

Target units do not offer any additional functionality on top of the generic functionality provided by units. They exist merely to group units via dependencies (useful as boot targets), and to establish standardized names for synchronization points used in dependencies between units. Among other things, target units are a more flexible replacement for SysV runlevels in the classic SysV init system. (And for compatibility reasons special target units such as
runlevel3.target
exist which are used by the SysV runlevel compatibility code in systemd. See
**systemd.special**(7)
for details).

<a name="automatic-dependencies"></a>

# Automatic Dependencies


<a name="implicit-dependencies"></a>

### Implicit Dependencies


There are no implicit dependencies for target units.

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
  Target units will automatically complement all configured dependencies of type
  _Wants=_
  or
  _Requires=_
  with dependencies of type
  _After=_
  unless
  _DefaultDependencies=no_
  is set in the specified units. Note that
  _Wants=_
  or
  _Requires=_
  must be defined in the target unit itself — if you for example define
  _Wants=_some.target in some.service, the automatic ordering will not be added.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Target units automatically gain
  _Conflicts=_
  and
  _Before=_
  dependencies against
  shutdown.target.

<a name="example"></a>

# Example


**Example&nbsp;1.&nbsp;Simple standalone target**

.if n \{.RS 4
.\}
    # emergency-net.target
    
    [Unit]
    Description=Emergency Mode with Networking
    Requires=emergency.target systemd-networkd.service
    After=emergency.target systemd-networkd.service
    AllowIsolate=yes
.if n \{.RE
.\}

When adding dependencies to other units, its important to check if they set
_DefaultDependencies=_. Service units, unless they set
_DefaultDependencies=no_, automatically get a dependency on
sysinit.target. In this case, both
emergency.target
and
systemd-networkd.service
have
_DefaultDependencies=no_, so they are suitable for use in this target, and do not pull in
sysinit.target.

You can now switch into this emergency mode by running
_systemctl isolate emergency-net.target_
or by passing the option
_systemd.unit=emergency-net.target_
on the kernel command line.

Other units can have
_WantedBy=emergency-net.target_
in the
_[Install]_
section. After they are enabled using
**systemctl enable**, they will be started before
_emergency-net.target_
is started. It is also possible to add arbitrary units as dependencies of
emergency.target
without modifying them by using
**systemctl add-wants**.

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemctl**(1),
**systemd.unit**(5),
**systemd.special**(7),
**systemd.directives**(7)
