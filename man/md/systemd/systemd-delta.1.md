# systemd\-delta(1)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-delta - Find overridden configuration files

<a name="synopsis"></a>

# Synopsis

```
.HP \w'systemd-delta&nbsp;'u systemd-delta [OPTIONS...] [PREFIX[/SUFFIX]|SUFFIX...]
```

<a name="description"></a>

# Description


**systemd-delta**
may be used to identify and compare configuration files that override other configuration files. Files in
/etc
have highest priority, files in
/run
have the second highest priority, ..., files in
/usr/lib
have lowest priority. Files in a directory with higher priority override files with the same name in directories of lower priority. In addition, certain configuration files can have
".d"
directories which contain "drop-in" files with configuration snippets which augment the main configuration file. "Drop-in" files can be overridden in the same way by placing files with the same name in a directory of higher priority (except that, in case of "drop-in" files, both the "drop-in" file name and the name of the containing directory, which corresponds to the name of the main configuration file, must match). For a fuller explanation, see
**systemd.unit**(5).

The command line argument will be split into a prefix and a suffix. Either is optional. The prefix must be one of the directories containing configuration files (/etc,
/run,
/usr/lib, ...). If it is given, only overriding files contained in this directory will be shown. Otherwise, all overriding files will be shown. The suffix must be a name of a subdirectory containing configuration files like
tmpfiles.d,
sysctl.d
or
systemd/system. If it is given, only configuration files in this subdirectory (across all configuration paths) will be analyzed. Otherwise, all configuration files will be analyzed. If the command line argument is not given at all, all configuration files will be analyzed. See below for some examples.

<a name="options"></a>

# Options


The following options are understood:

**-t**, **--type=**
When listing the differences, only list those that are asked for. The list itself is a comma-separated list of desired difference types.

Recognized types are:

_masked_
Show masked files

_equivalent_
Show overridden files that while overridden, do not differ in content.

_redirected_
Show files that are redirected to another.

_overridden_
Show overridden, and changed files.

_extended_
Show
*.conf
files in drop-in directories for units.

_unchanged_
Show unmodified files too.


**--diff=**
When showing modified files, when a file is overridden show a diff as well. This option takes a boolean argument. If omitted, it defaults to
**true**.

**-h**, **--help**
Print a short help text and exit.

**--version**
Print a short version string and exit.

**--no-pager**
Do not pipe output into a pager.

<a name="examples"></a>

# Examples


To see all local configuration:

.if n \{.RS 4
.\}
    systemd-delta
.if n \{.RE
.\}

To see all runtime configuration:

.if n \{.RS 4
.\}
    systemd-delta /run
.if n \{.RE
.\}

To see all system unit configuration changes:

.if n \{.RS 4
.\}
    systemd-delta systemd/system
.if n \{.RE
.\}

To see all runtime "drop-in" changes for system units:

.if n \{.RS 4
.\}
    systemd-delta --type=extended /run/systemd/system
.if n \{.RE
.\}

<a name="exit-status"></a>

# Exit Status


On success, 0 is returned, a non-zero failure code otherwise.

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemd.unit**(5)
