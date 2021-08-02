# hostnamectl(1)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

hostnamectl - Control the system hostname

<a name="synopsis"></a>

# Synopsis

```
.HP \w'hostnamectl&nbsp;'u hostnamectl [OPTIONS...] {COMMAND}
```

<a name="description"></a>

# Description


**hostnamectl**
may be used to query and change the system hostname and related settings.

This tool distinguishes three different hostnames: the high-level "pretty" hostname which might include all kinds of special characters (e.g. "Lennarts Laptop"), the static hostname which is used to initialize the kernel hostname at boot (e.g. "lennarts-laptop"), and the transient hostname which is a fallback value received from network configuration. If a static hostname is set, and is valid (something other than localhost), then the transient hostname is not used.

Note that the pretty hostname has little restrictions on the characters and length used, while the static and transient hostnames are limited to the usually accepted characters of Internet domain names, and 64 characters at maximum (the latter being a Linux limitation).

The static hostname is stored in
/etc/hostname, see
**hostname**(5)
for more information. The pretty hostname, chassis type, and icon name are stored in
/etc/machine-info, see
**machine-info**(5).

Use
**systemd-firstboot**(1)
to initialize the system host name for mounted (but not booted) system images.

<a name="options"></a>

# Options


The following options are understood:

**--no-ask-password**
Do not query the user for authentication for privileged operations.

**--static**, **--transient**, **--pretty**
If
**status**
is invoked (or no explicit command is given) and one of these switches is specified,
**hostnamectl**
will print out just this selected hostname.

If used with
**set-hostname**, only the selected hostname(s) will be updated. When more than one of these switches are specified, all the specified hostnames will be updated.

**-H**, **--host=**
Execute the operation remotely. Specify a hostname, or a username and hostname separated by
"@", to connect to. The hostname may optionally be suffixed by a port ssh is listening on, seperated by
":", and then a container name, separated by
"/", which connects directly to a specific container on the specified host. This will use SSH to talk to the remote machine manager instance. Container names may be enumerated with
**machinectl -H ****HOST**. Put IPv6 addresses in brackets.

**-M**, **--machine=**
Execute operation on a local container. Specify a container name to connect to.

**-h**, **--help**
Print a short help text and exit.

**--version**
Print a short version string and exit.

<a name="commands"></a>

# Commands


The following commands are understood:

**status**
Show current system hostname and related information. If no command is specified, this is the implied default.

**set-hostname ****NAME**
Set the system hostname to
_NAME_. By default, this will alter the pretty, the static, and the transient hostname alike; however, if one or more of
**--static**,
**--transient**,
**--pretty**
are used, only the selected hostnames are changed. If the pretty hostname is being set, and static or transient are being set as well, the specified hostname will be simplified in regards to the character set used before the latter are updated. This is done by removing special characters and spaces. This ensures that the pretty and the static hostname are always closely related while still following the validity rules of the specific name. This simplification of the hostname string is not done if only the transient and/or static host names are set, and the pretty host name is left untouched.

Pass the empty string
""
as the hostname to reset the selected hostnames to their default (usually
"localhost").

**set-icon-name ****NAME**
Set the system icon name to
_NAME_. The icon name is used by some graphical applications to visualize this host. The icon name should follow the
\m[blue]**Icon Naming Specification**\m[]\s-2\u[1]\d\s+2.

Pass an empty string to reset the icon name to the default value, which is determined from chassis type (see below) and possibly other parameters.

**set-chassis ****TYPE**
Set the chassis type to
_TYPE_. The chassis type is used by some graphical applications to visualize the host or alter user interaction. Currently, the following chassis types are defined:
"desktop",
"laptop",
"convertible",
"server",
"tablet",
"handset",
"watch",
"embedded", as well as the special chassis types
"vm"
and
"container"
for virtualized systems that lack an immediate physical chassis.

Pass an empty string to reset the chassis type to the default value which is determined from the firmware and possibly other parameters.

**set-deployment ****ENVIRONMENT**
Set the deployment environment description.
_ENVIRONMENT_
must be a single word without any control characters. One of the following is suggested:
"development",
"integration",
"staging",
"production".

Pass an empty string to reset to the default empty value.

**set-location ****LOCATION**
Set the location string for the system, if it is known.
_LOCATION_
should be a human-friendly, free-form string describing the physical location of the system, if it is known and applicable. This may be as generic as
"Berlin, Germany"
or as specific as
"Left Rack, 2nd Shelf".

Pass an empty string to reset to the default empty value.

<a name="exit-status"></a>

# Exit Status


On success, 0 is returned, a non-zero failure code otherwise.

<a name="see-also"></a>

# See Also


**systemd**(1),
**hostname**(1),
**hostname**(5),
**machine-info**(5),
**systemctl**(1),
**systemd-hostnamed.service**(8),
**systemd-firstboot**(1)

<a name="notes"></a>

# Notes


*  1.  
  Icon Naming Specification
      http://standards.freedesktop.org/icon-naming-spec/icon-naming-spec-latest.html
