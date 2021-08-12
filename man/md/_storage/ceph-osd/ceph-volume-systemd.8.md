# ceph-volume-systemd(8) - systemd ceph-volume helper tool

dev, Apr 21, 2020

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

    ceph-volume-systemd systemd instance name
```


```

<a name="description"></a>

# Description


**ceph-volume-systemd** is a systemd helper tool that receives input
from (dynamically created) systemd units so that activation of OSDs can
proceed.

It translates the input into a system call to ceph-volume for activation
purposes only.

<a name="examples"></a>

# Examples


Its input is the **systemd instance name** (represented by **%i** in a systemd
unit), and it should be in the following format:
.INDENT 0.0
.INDENT 3.5

    .ft C
    <ceph-volume subcommand>-<extra metadata>
    .ft P
.UNINDENT
.UNINDENT

In the case of **lvm** a call could look like:
.INDENT 0.0
.INDENT 3.5

    .ft C
    /usr/bin/ceph-volume-systemd lvm-0-8715BEB4-15C5-49DE-BA6F-401086EC7B41
    .ft P
.UNINDENT
.UNINDENT

Which in turn will call **ceph-volume** in the following way:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph-volume lvm trigger  0-8715BEB4-15C5-49DE-BA6F-401086EC7B41
    .ft P
.UNINDENT
.UNINDENT

Any other subcommand will need to have implemented a **trigger** command that
can consume the extra metadata in this format.

<a name="availability"></a>

# Availability


**ceph-volume-systemd** is part of Ceph, a massively scalable,
open-source, distributed storage system. Please refer to the documentation at
_http://docs.ceph.com/_ for more information.

<a name="see-also"></a>

# See Also


ceph-osd(8),

<a name="copyright"></a>

# Copyright

2010-2014, Inktank Storage, Inc. and contributors. Licensed under Creative Commons Attribution Share Alike 3.0 (CC-BY-SA-3.0)

