# virt-host-validate(1) - validate host virtualization setup

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

 virt-host-validate [OPTIONS...] [HV-TYPE]
```

<a name="description"></a>

# Description


This tool validates that the host is configured in a suitable
way to run libvirt hypervisor drivers. If invoked without any
arguments it will check support for all hypervisor drivers it
is aware of. Optionally it can be given a particular hypervisor
type (**qemu**, **lxc** or **bhyve**) to restrict the checks
to those relevant for that virtualization technology

<a name="options"></a>

# Options


**-v**, **--version**

Display the command version

**-h**, **--help**

Display the command line help

**-q**, **--quiet**

Don't display details of individual checks being performed.
Only display output if a check does not pass.

<a name="exit-status"></a>

# Exit Status


Upon successful validation, an exit status of 0 will be set. Upon
failure a non-zero status will be set.

<a name="author"></a>

# Author


Daniel P. Berrangé

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


Copyright (C) 2012 by Red Hat, Inc.

<a name="license"></a>

# License


**virt-host-validate** is distributed under the terms of the GNU GPL v2+.
This is free software; see the source for copying conditions. There
is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
PURPOSE

<a name="see-also"></a>

# See Also


virsh(1), virt-pki-validate(1), virt-xml-validate(1),
_https://libvirt.org/_

