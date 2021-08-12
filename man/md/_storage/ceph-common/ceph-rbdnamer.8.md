# ceph-rbdnamer(8) - udev helper to name RBD devices

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

    ceph-rbdnamer num
```


```

<a name="description"></a>

# Description


**ceph-rbdnamer** prints the pool and image name for the given RBD devices
to stdout. It is used by _udev_ (using a rule like the one below) to
set up a device symlink.
.INDENT 0.0
.INDENT 3.5

    .ft C
    KERNEL=="rbd[0-9]*", PROGRAM="/usr/bin/ceph-rbdnamer %n", SYMLINK+="rbd/%c{1}/%c{2}"
    .ft P
.UNINDENT
.UNINDENT

<a name="availability"></a>

# Availability


**ceph-rbdnamer** is part of Ceph, a massively scalable, open-source, distributed storage system.  Please
refer to the Ceph documentation at _http://ceph.com/docs_ for more
information.

<a name="see-also"></a>

# See Also


rbd(8),
ceph(8)

<a name="copyright"></a>

# Copyright

2010-2014, Inktank Storage, Inc. and contributors. Licensed under Creative Commons Attribution Share Alike 3.0 (CC-BY-SA-3.0)

