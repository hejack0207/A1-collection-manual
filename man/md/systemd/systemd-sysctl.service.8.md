# systemd\-sysctl\&.service(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-sysctl.service, systemd-sysctl - Configure kernel parameters at boot

<a name="synopsis"></a>

# Synopsis

```
.HP \w'/usr/lib/systemd/systemd-sysctl&nbsp;'u /usr/lib/systemd/systemd-sysctl [OPTIONS...] [CONFIGFILE...] 
 systemd-sysctl.service
```

<a name="description"></a>

# Description


systemd-sysctl.service
is an early boot service that configures
**sysctl**(8)
kernel parameters by invoking
**/usr/lib/systemd/systemd-sysctl**.

When invoked with no arguments,
**/usr/lib/systemd/systemd-sysctl**
applies all directives from configuration files listed in
**sysctl.d**(5). If one or more filenames are passed on the command line, only the directives in these files are applied.

In addition,
**--prefix=**
option may be used to limit which sysctl settings are applied.

See
**sysctl.d**(5)
for information about the configuration of sysctl settings. After sysctl configuration is changed on disk, it must be written to the files in
/proc/sys
before it takes effect. It is possible to update specific settings, or simply to reload all configuration, see Examples below.

<a name="options"></a>

# Options


**--prefix=**
Only apply rules with the specified prefix.

**--cat-config**
Copy the contents of config files to standard output. Before each file, the filename is printed as a comment.

**--no-pager**
Do not pipe output into a pager.

**-h**, **--help**
Print a short help text and exit.

**--version**
Print a short version string and exit.

<a name="examples"></a>

# Examples


**Example&nbsp;1.&nbsp;Reset all sysctl settings**

.if n \{.RS 4
.\}
    systemctl restart systemd-sysctl
.if n \{.RE
.\}

**Example&nbsp;2.&nbsp;View coredump handler configuration**

.if n \{.RS 4
.\}
    # sysctl kernel.core_pattern
    kernel.core_pattern = |/usr/libexec/abrt-hook-ccpp %s %c %p %u %g %t %P %I
.if n \{.RE
.\}

**Example&nbsp;3.&nbsp;Update coredump handler configuration**

.if n \{.RS 4
.\}
    # /usr/lib/systemd/systemd-sysctl --prefix kernel.core_pattern
.if n \{.RE
.\}

This searches all the directories listed in
**sysctl.d**(5)
for configuration files and writes
/proc/sys/kernel/core_pattern.

**Example&nbsp;4.&nbsp;Update coredump handler configuration according to a specific file**

.if n \{.RS 4
.\}
    # /usr/lib/systemd/systemd-sysctl 50-coredump.conf
.if n \{.RE
.\}

This applies all the settings found in
50-coredump.conf. Either
/etc/sysctl.d/50-coredump.conf, or
/run/sysctl.d/50-coredump.conf, or
/usr/lib/sysctl.d/50-coredump.conf
will be used, in the order of preference.

See
**sysctl**(8)
for various ways to directly apply sysctl settings.

<a name="see-also"></a>

# See Also


**systemd**(1),
**sysctl.d**(5),
**sysctl**(8),
