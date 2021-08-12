# ceph-create-keys(8) - ceph keyring generate tool

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

    ceph-create-keys [-h] [-v] [-t seconds] [--cluster name] --id id
```


```

<a name="description"></a>

# Description


**ceph-create-keys** is a utility to generate bootstrap keyrings using
the given monitor when it is ready.

It creates following auth entities (or users)

**client.admin**
.INDENT 0.0
.INDENT 3.5
and its key for your client host.
.UNINDENT
.UNINDENT

**client.bootstrap-{osd, rgw, mds}**
.INDENT 0.0
.INDENT 3.5
and their keys for bootstrapping corresponding services
.UNINDENT
.UNINDENT

To list all users in the cluster:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph auth ls
    .ft P
.UNINDENT
.UNINDENT

<a name="options"></a>

# Options

.INDENT 0.0

* **--cluster**  
  name of the cluster (default 'ceph').
  .UNINDENT
  .INDENT 0.0
* **-t**  
  time out after **seconds** (default: 600) waiting for a response from the monitor
  .UNINDENT
  .INDENT 0.0
* **-i, --id**  
  id of a ceph-mon that is coming up. **ceph-create-keys** will wait until it joins quorum.
  .UNINDENT
  .INDENT 0.0
* **-v, --verbose**  
  be more verbose.
  .UNINDENT

<a name="availability"></a>

# Availability


**ceph-create-keys** is part of Ceph, a massively scalable, open-source, distributed storage system.  Please refer
to the Ceph documentation at _http://ceph.com/docs_ for more
information.

<a name="see-also"></a>

# See Also


ceph(8)

<a name="copyright"></a>

# Copyright

2010-2014, Inktank Storage, Inc. and contributors. Licensed under Creative Commons Attribution Share Alike 3.0 (CC-BY-SA-3.0)

