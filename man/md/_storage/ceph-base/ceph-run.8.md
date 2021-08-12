# ceph-run(8) - restart daemon on core dump

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

    ceph-run command ...
```


```

<a name="description"></a>

# Description


**ceph-run** is a simple wrapper that will restart a daemon if it exits
with a signal indicating it crashed and possibly core dumped (that is,
signals 3, 4, 5, 6, 8, or 11).

The command should run the daemon in the foreground. For Ceph daemons,
that means the **-f** option.

<a name="options"></a>

# Options


None

<a name="availability"></a>

# Availability


**ceph-run** is part of Ceph, a massively scalable, open-source, distributed storage system. Please refer to
the Ceph documentation at _http://ceph.com/docs_ for more information.

<a name="see-also"></a>

# See Also


ceph(8),
ceph-mon(8),
ceph-mds(8),
ceph-osd(8)

<a name="copyright"></a>

# Copyright

2010-2014, Inktank Storage, Inc. and contributors. Licensed under Creative Commons Attribution Share Alike 3.0 (CC-BY-SA-3.0)

