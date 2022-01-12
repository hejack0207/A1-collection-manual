# yum-builddep(1) - redirecting to DNF builddep Plugin

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

Install whatever is needed to build the given .src.rpm, .nosrc.rpm or .spec file.

**WARNING:**
.INDENT 0.0
.INDENT 3.5
Build dependencies in a package (i.e. src.rpm) might be different
than you would expect because they were evaluated according macros
set on the package build host.
.UNINDENT
.UNINDENT

<a name="synopsis"></a>

# Synopsis

```

 dnf builddep <package>...
```

<a name="arguments"></a>

# Arguments

.INDENT 0.0

* <b>**&lt;package&gt;**</b>  
  Either path to .src.rpm, .nosrc.rpm or .spec file or package available in a repository.
  .UNINDENT

<a name="options"></a>

# Options


All general DNF options are accepted, see _Options_ in **dnf(8)** for details.
.INDENT 0.0

* <b>**--help-cmd**</b>  
  Show this help.
* <b>**-D &lt;macro expr&gt;, --define &lt;macro expr&gt;**</b>  
  Define the RPM macro named _macro_ to the value _expr_ when parsing spec files.
* <b>**--spec**</b>  
  Treat arguments as .spec files.
* <b>**--srpm**</b>  
  Treat arguments as source rpm files.
* <b>**--skip-unavailable**</b>  
  Skip build dependencies not available in repositories. All available build dependencies will be installed.
  .UNINDENT

Note that _builddep_ command does not honor the _--skip-broken_ option, so there is no way to skip uninstallable packages (e.g. with broken dependencies).

<a name="examples"></a>

# Examples

.INDENT 0.0

* <b>**dnf builddep foobar.spec**</b>  
  Install the needed build requirements, defined in the foobar.spec file.
* <b>**dnf builddep --spec foobar.spec.in**</b>  
  Install the needed build requirements, defined in the spec file when filename ends
  with something different than **.spec**.
* <b>**dnf builddep foobar-1.0-1.src.rpm**</b>  
  Install the needed build requirements, defined in the foobar-1.0-1.src.rpm file.
* <b>**dnf builddep foobar-1.0-1**</b>  
  Look up foobar-1.0-1 in enabled repositories and install build requirements
  for its source rpm.
* <b>**dnf builddep -D 'scl python27' python-foobar.spec**</b>  
  Install the needed build requirements for the python27 SCL version of python-foobar.
  .UNINDENT

<a name="author"></a>

# Author

See AUTHORS in your Core DNF Plugins distribution

<a name="copyright"></a>

# Copyright

2021, Red Hat, Licensed under GPLv2+

