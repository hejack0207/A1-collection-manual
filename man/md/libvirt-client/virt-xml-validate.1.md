# virt-xml-validate(1) - validate libvirt XML files against a schema

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

 virt-xml-validate XML-FILE [SCHEMA-NAME] 
 virt-xml-validate OPTION
```

<a name="description"></a>

# Description


Validates a libvirt XML for compliance with the published schema.
The first compulsory argument is the path to the XML file to be
validated. The optional second argument is the name of the schema
to validate against. If omitted, the schema name will be inferred
from the name of the root element in the XML document.

Valid schema names currently include
.INDENT 0.0

* ·  
  **domainsnapshot**
  .UNINDENT

The schema for the XML format used by domain snapshot configuration
.INDENT 0.0

* ·  
  **domain**
  .UNINDENT

The schema for the XML format used by guest domains configuration
.INDENT 0.0

* ·  
  **network**
  .UNINDENT

The schema for the XML format used by virtual network configuration
.INDENT 0.0

* ·  
  **storagepool**
  .UNINDENT

The schema for the XML format used by storage pool configuration
.INDENT 0.0

* ·  
  **storagevol**
  .UNINDENT

The schema for the XML format used by storage volume descriptions
.INDENT 0.0

* ·  
  **nodedev**
  .UNINDENT

The schema for the XML format used by node device descriptions
.INDENT 0.0

* ·  
  **capability**
  .UNINDENT

The schema for the XML format used to declare driver capabilities
.INDENT 0.0

* ·  
  **nwfilter**
  .UNINDENT

The schema for the XML format used by network traffic filters
.INDENT 0.0

* ·  
  **nwfilterbinding**
  .UNINDENT

The schema for XML format used by network filter bindings.
.INDENT 0.0

* ·  
  **secret**
  .UNINDENT

The schema for the XML format used by secrets descriptions
.INDENT 0.0

* ·  
  **interface**
  .UNINDENT

The schema for the XML format used by physical host interfaces

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


Copyright (C) 2009-2013 by Red Hat, Inc.
Copyright (C) 2009 by Daniel P. Berrangé

<a name="license"></a>

# License


**virt-xml-validate** is distributed under the terms of the GNU GPL v2+.
This is free software; see the source for copying conditions. There
is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
PURPOSE

<a name="see-also"></a>

# See Also


virsh(1), _online XML format descriptions_,
_https://libvirt.org/_

