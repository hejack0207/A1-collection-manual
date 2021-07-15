# systemd\&.scope(5)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd.scope - Scope unit configuration

<a name="synopsis"></a>

# Synopsis

```

 scope.scope
```

<a name="description"></a>

# Description


Scope units are not configured via unit configuration files, but are only created programmatically using the bus interfaces of systemd. They are named similar to filenames. A unit whose name ends in
".scope"
refers to a scope unit. Scopes units manage a set of system processes. Unlike service units, scope units manage externally created processes, and do not fork off processes on its own.

The main purpose of scope units is grouping worker processes of a system service for organization and for managing resources.

**systemd-run ****--scope**
may be used to easily launch a command in a new scope unit from the command line.

See the
\m[blue]**New Control Group Interfaces**\m[]\s-2\u[1]\d\s+2
for an introduction on how to make use of scope units from programs.

<a name="automatic-dependencies"></a>

# Automatic Dependencies


<a name="implicit-dependencies"></a>

### Implicit Dependencies


Implicit dependencies may be added as result of resource control parameters as documented in
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
  Scope units will automatically have dependencies of type
  _Conflicts=_
  and
  _Before=_
  on
  shutdown.target. These ensure that scope units are removed prior to system shutdown. Only scope units involved with early boot or late system shutdown should disable
  _DefaultDependencies=_
  option.

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemd-run**(1),
**systemd.unit**(5),
**systemd.resource-control**(5),
**systemd.service**(5),
**systemd.directives**(7).

<a name="notes"></a>

# Notes


*  1.  
  New Control Group Interfaces
      https://www.freedesktop.org/wiki/Software/systemd/ControlGroupInterface/
