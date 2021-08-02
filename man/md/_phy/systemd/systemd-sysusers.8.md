# systemd\-sysusers(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-sysusers, systemd-sysusers.service - Allocate system users and groups

<a name="synopsis"></a>

# Synopsis

```
.HP \w'systemd-sysusers&nbsp;'u systemd-sysusers [OPTIONS...] [CONFIGFILE...] 
 systemd-sysusers.service
```

<a name="description"></a>

# Description


**systemd-sysusers**
creates system users and groups, based on the file format and location specified in
**sysusers.d**(5).

If invoked with no arguments, it applies all directives from all files found in the directories specified by
**sysusers.d**(5). When invoked with positional arguments, if option
**--replace=****PATH**
is specified, arguments specified on the command line are used instead of the configuration file
_PATH_. Otherwise, just the configuration specified by the command line arguments is executed. The string
"-"
may be specified instead of a filename to instruct
**systemd-sysusers**
to read the configuration from standard input. If only the basename of a file is specified, all configuration directories are searched for a matching file and the file found that has the highest priority is executed.

<a name="options"></a>

# Options


The following options are understood:

**--root=****root**
Takes a directory path as an argument. All paths will be prefixed with the given alternate
_root_
path, including config search paths.

**--replace=****PATH**
When this option is given, one ore more positional arguments must be specified. All configuration files found in the directories listed in
**sysusers.d**(5)
will be read, and the configuration given on the command line will be handled instead of and with the same priority as the configuration file
_PATH_.

This option is intended to be used when package installation scripts are running and files belonging to that package are not yet available on disk, so their contents must be given on the command line, but the admin configuration might already exist and should be given higher priority.

**Example&nbsp;1.&nbsp;RPM installation script for radvd**

.if n \{.RS 4
.\}
    echo u radvd - "radvd daemon"*(Aq | e
              systemd-sysusers --replace=/usr/lib/sysusers.d/radvd.conf -
.if n \{.RE
.\}

This will create the radvd user as if
/usr/lib/sysusers.d/radvd.conf
was already on disk. An admin might override the configuration specified on the command line by placing
/etc/sysusers.d/radvd.conf
or even
/etc/sysusers.d/00-overrides.conf.

Note that this is the expanded from, and when used in a package, this would be written using a macro with "radvd" and a file containing the configuration line as arguments.

**--inline**
Treat each positional argument as a separate configuration line instead of a file name.

**--cat-config**
Copy the contents of config files to standard output. Before each file, the filename is printed as a comment.

**--no-pager**
Do not pipe output into a pager.

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
**sysusers.d**(5),
\m[blue]**Users, Groups, UIDs and GIDs on systemd systems**\m[]\s-2\u[1]\d\s+2

<a name="notes"></a>

# Notes


*  1.  
  Users, Groups, UIDs and GIDs on systemd systems
      https://systemd.io/UIDS-GIDS
