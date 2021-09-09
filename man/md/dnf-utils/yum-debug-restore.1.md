# yum-debug-restore(1) - redirecting to DNF debug Plugin

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

<a name="description"></a>

# Description


The plugin provides two dnf commands:
.INDENT 0.0

* <b>**debug-dump**</b>  
  Writes system RPM configuration to a dump file
* <b>**debug-restore**</b>  
  Restore the installed packages to the versions written in the dump file. By
  default, it does not remove already installed versions of install-only
  packages and only marks those versions that are mentioned in the dump file
  for installation. The final decision on which versions to keep on the
  system is left to dnf and can be fine-tuned using the _installonly\_limit_
  (see **dnf.conf(5)**) configuration option.
  .UNINDENT

**NOTE:**
.INDENT 0.0
.INDENT 3.5
DNF and Yum debug files are not compatible and thus can't be used
by the other program.
.UNINDENT
.UNINDENT

<a name="synopsis"></a>

# Synopsis

```

 dnf debug-dump [--norepos] [<filename>] 
 dnf debug-restore [--output] [--install-latest] [--ignore-arch] [--filter-types = [install,remove,replace]] <filename>
```

<a name="arguments"></a>

# Arguments

.INDENT 0.0

* <b>**&lt;filename&gt;**</b>  
  File to write dump to or read from.
  .UNINDENT

<a name="options"></a>

# Options


All general DNF options are accepted, see _Options_ in **dnf(8)** for details.

**dnf debug-dump**
.INDENT 0.0

* <b>**--norepos**</b>  
  Do not dump content of enabled repos.
  .UNINDENT

**dnf debug-restore**
.INDENT 0.0

* <b>**--filter-types=[install,remove,replace]**</b>  
  Limit package changes to specified type.
* <b>**--ignore-arch**</b>  
  When installing package ignore architecture and install missing packages
  matching the name, epoch, version and release.
* <b>**--install-latest**</b>  
  When installing use the latest package of the same name and architecture.
* <b>**--output**</b>  
  Only output list of packages which will be installed or removed.
  No actuall changes are done.
* <b>**--remove-installonly**</b>  
  Allow removal of install-only packages. Using this option may result in an
  attempt to remove the running kernel version (in situations when the currently
  running kernel version is not part of the dump file).
  .UNINDENT

<a name="author"></a>

# Author

See AUTHORS in your Core DNF Plugins distribution

<a name="copyright"></a>

# Copyright

2021, Red Hat, Licensed under GPLv2+

