# needs-restarting(1) - redirecting to DNF needs-restarting Plugin

4.0.22, Jun 15, 2021

.nr rst2man-indent-level 0
.de1 rstReportMargin
\\$1 \\n[an-margin]
level \\n[rst2man-indent-level]
level margin: \\n[rst2man-indent\\n[rst2man-indent-level]]
-
\\n[rst2man-indent0]
\\n[rst2man-indent1]
\\n[rst2man-indent2]
..
.de1 INDENT


..

Check for running processes that should be restarted.

<a name="synopsis"></a>

# Synopsis

```

 dnf needs-restarting [-u] [-r]
```

<a name="description"></a>

# Description


_needs-restarting_ looks through running processes and tries to detect those that use files from packages that have been updated after the given process started. Such processes are reported by this tool.

Note that in most cases a process should survive update of its binary and libraries it is using without requiring to be restarted for proper operation. There are however specific cases when this does not apply. Separately, processes often need to be restarted to reflect security updates.

<a name="options"></a>

# Options


All general DNF options are accepted, see _Options_ in **dnf(8)** for details.

**-u, --useronly**
.INDENT 0.0
.INDENT 3.5
Only consider processes belonging to the running user.
.UNINDENT
.UNINDENT

**-r, --reboothint**
.INDENT 0.0
.INDENT 3.5
Only report whether a reboot is required (exit code 1) or not (exit code 0).
.UNINDENT
.UNINDENT
.INDENT 0.0

* <b>**-s, --services**</b>  
  Only list the affected systemd services.
  .UNINDENT

<a name="configuration"></a>

# Configuration


**/etc/dnf/plugins/needs-restarting.d/**

**/etc/dnf/plugins/needs-restarting.d/pkgname.conf**

Packages can be added to **needs-restarting** via conf files in config
directory. Config files need to have **.conf** extension or will be ignored.

More than one package is allowed in each file (one package per line) although
it is advised to use one file for each package.

Example:
.INDENT 0.0
.INDENT 3.5

    .ft C
    echo "dwm" > /etc/dnf/plugins/needs-restarting.d/dwm.conf
    .ft P
.UNINDENT
.UNINDENT

<a name="author"></a>

# Author

See AUTHORS in your Core DNF Plugins distribution

<a name="copyright"></a>

# Copyright

2021, Red Hat, Licensed under GPLv2+

