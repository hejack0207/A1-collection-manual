# systemd\&.slice(5)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd.slice - Slice unit configuration

<a name="synopsis"></a>

# Synopsis

```

 slice.slice
```

<a name="description"></a>

# Description


A unit configuration file whose name ends in
".slice"
encodes information about a slice unit. A slice unit is a concept for hierarchically managing resources of a group of processes. This management is performed by creating a node in the Linux Control Group (cgroup) tree. Units that manage processes (primarily scope and service units) may be assigned to a specific slice. For each slice, certain resource limits may be set that apply to all processes of all units contained in that slice. Slices are organized hierarchically in a tree. The name of the slice encodes the location in the tree. The name consists of a dash-separated series of names, which describes the path to the slice from the root slice. The root slice is named
-.slice. Example:
foo-bar.slice
is a slice that is located within
foo.slice, which in turn is located in the root slice
-.slice.

Note that slice units cannot be templated, nor is possible to add multiple names to a slice unit by creating additional symlinks to its unit file.

By default, service and scope units are placed in
system.slice, virtual machines and containers registered with
**systemd-machined**(1)
are found in
machine.slice, and user sessions handled by
**systemd-logind**(1)
in
user.slice. See
**systemd.special**(5)
for more information.

See
**systemd.unit**(5)
for the common options of all unit configuration files. The common configuration items are configured in the generic [Unit] and [Install] sections. The slice specific configuration options are configured in the [Slice] section. Currently, only generic resource control settings as described in
**systemd.resource-control**(5)
are allowed.

See the
\m[blue]**New Control Group Interfaces**\m[]\s-2\u[1]\d\s+2
for an introduction on how to make use of slice units from programs.

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
  Slice units automatically gain dependencies of type
  _After=_
  and
  _Requires=_
  on their immediate parent slice unit.

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
  Slice units will automatically have dependencies of type
  _Conflicts=_
  and
  _Before=_
  on
  shutdown.target. These ensure that slice units are removed prior to system shutdown. Only slice units involved with late system shutdown should disable
  _DefaultDependencies=_
  option.

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemd.unit**(5),
**systemd.resource-control**(5),
**systemd.service**(5),
**systemd.scope**(5),
**systemd.special**(7),
**systemd.directives**(7)

<a name="notes"></a>

# Notes


*  1.  
  New Control Group Interfaces
      https://www.freedesktop.org/wiki/Software/systemd/ControlGroupInterface/
