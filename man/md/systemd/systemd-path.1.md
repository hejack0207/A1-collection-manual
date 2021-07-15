# systemd\-path(1)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-path - List and query system and user paths

<a name="synopsis"></a>

# Synopsis

```
.HP \w'systemd-path&nbsp;'u systemd-path [OPTIONS...] [NAME...]
```

<a name="description"></a>

# Description


**systemd-path**
may be used to query system and user paths. The tool makes many of the paths described in
**file-hierarchy**(7)
available for querying.

When invoked without arguments, a list of known paths and their current values is shown. When at least one argument is passed, the path with this name is queried and its value shown. The variables whose name begins with
"search-"
do not refer to individual paths, but instead to a list of colon-separated search paths, in their order of precedence.

<a name="options"></a>

# Options


The following options are understood:

**--suffix=**
Printed paths are suffixed by the specified string.

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
**file-hierarchy**(7)
