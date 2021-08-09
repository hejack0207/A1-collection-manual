# virt-pki-validate(1) - validate libvirt PKI files are configured correctly

"", ""

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

<a name="synopsis"></a>

# Synopsis

```

 virt-pki-validate [OPTION]
```

<a name="description"></a>

# Description


This tool validates that the necessary PKI files are configured for
a secure libvirt server or client using the TLS encryption protocol.
It will report any missing certificate or key files on the host. It
should be run as root to ensure it can read all the necessary files

<a name="options"></a>

# Options


**-h**, **--help**

Display command line help usage then exit.

**-V**, **--version**

Display version information then exit.

<a name="exit-status"></a>

# Exit Status


Upon successful validation, an exit status of 0 will be set. Upon
failure a non-zero status will be set.

<a name="author"></a>

# Author


Richard Jones

<a name="bugs"></a>

# Bugs


Please report all bugs you discover.  This should be done via either:
.INDENT 0.0

* 1.  
  the mailing list

_https://libvirt.org/contact.html_

* 2.  
  the bug tracker

_https://libvirt.org/bugs.html_
.UNINDENT

Alternatively, you may report bugs to your software distributor / vendor.

<a name="copyright"></a>

# Copyright


Copyright (C) 2006-2012 by Red Hat, Inc.

<a name="license"></a>

# License


**virt-pki-validate** is distributed under the terms of the GNU GPL v2+.
This is free software; see the source for copying conditions. There
is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
PURPOSE

<a name="see-also"></a>

# See Also


virsh(1), _online PKI setup instructions_,
_https://www.libvirt.org/_

