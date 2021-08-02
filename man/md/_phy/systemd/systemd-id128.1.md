# systemd\-id128(1)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-id128 - Generate and print sd-128 identifiers

<a name="synopsis"></a>

# Synopsis

```
.HP \w'systemd-id128&nbsp;'u systemd-id128 [OPTIONS...] new .HP \w'systemd-id128&nbsp;'u systemd-id128 [OPTIONS...] machine-id .HP \w'systemd-id128&nbsp;'u systemd-id128 [OPTIONS...] boot-id .HP \w'systemd-id128&nbsp;'u systemd-id128 [OPTIONS...] invocation-id
```

<a name="description"></a>

# Description


**id128**
may be used to conveniently print
**sd-id128**(3)
UUIDs. What identifier is printed depends on the specific verb.

With
**new**, a new random identifier will be generated.

With
**machine-id**, the identifier of the current machine will be printed. See
**machine-id**(5).

With
**boot-id**, the identifier of the current boot will be printed.

Both
**machine-id**
and
**boot-id**
may be combined with the
**--app-specific=****app-id**
switch to generate application-specific IDs. See
**sd\_id128\_get\_machine**(3)
for the discussion when this is useful.

With
**invocation-id**, the identifier of the current service invocation will be printed. This is available in systemd services. See
**systemd.exec**(5).

<a name="options"></a>

# Options


The following options are understood:

**-p**, **--pretty**
Generate output as programming language snippets.

**-a ****app-id**, **--app-specific=****app-id**
With this option, an identifier that is the result of hashing the application identifier
_app-id_
and the machine identifier will be printed. The
_app-id_
argument must be a valid sd-id128 string identifying the application.

**-h**, **--help**
Print a short help text and exit.

**--version**
Print a short version string and exit.

<a name="exit-status"></a>

# Exit Status


On success, 0 is returned, a non-zero failure code otherwise.

<a name="see-also"></a>

# See Also


**systemd**(1),
**sd-id128**(3),
**sd\_id128\_get\_machine**(3)
