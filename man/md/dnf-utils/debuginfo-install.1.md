# debuginfo-install(1) - redirecting to DNF debuginfo-install Plugin

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

Install the associated debuginfo packages for a given package specification.

<a name="synopsis"></a>

# Synopsis

```

 dnf debuginfo-install <pkg-spec>...
```

<a name="arguments"></a>

# Arguments

.INDENT 0.0

* <b>**&lt;pkg-spec&gt;**</b>  
  The package to install the associated debuginfo package for.
  .UNINDENT

<a name="options"></a>

# Options


All general DNF options are accepted, see _Options_ in **dnf(8)** for details.

<a name="configuration"></a>

# Configuration


**/etc/dnf/plugins/debuginfo-install.conf**

The minimal content of conf file should contain **main** sections with **enabled** and
**autoupdate** parameter.
.INDENT 0.0

* <b>**autoupdate**</b>  
  A boolean option which controls updates of debuginfo packages. If options is enabled
  and there are debuginfo packages installed it automatically enables all configured
  debuginfo repositories.
  (Disabled by default.)
  .UNINDENT

<a name="examples"></a>

# Examples

.INDENT 0.0

* <b>**dnf debuginfo-install foobar**</b>  
  Install the debuginfo packages for the foobar package.
* <b>**dnf upgrade --enablerepo=*-debuginfo &lt;package-name&gt;-debuginfo**</b>  
  Upgrade debuginfo package of a &lt;package-name&gt;.
* <b>**dnf upgrade --enablerepo=*-debuginfo *-debuginfo **</b>  
  Upgrade all debuginfo packages.
  .UNINDENT

<a name="author"></a>

# Author

See AUTHORS in your Core DNF Plugins distribution

<a name="copyright"></a>

# Copyright

2021, Red Hat, Licensed under GPLv2+

