# ceph-mds(8) - ceph metadata server daemon

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

    ceph-mds -i <ID> [flags]
```


```

<a name="description"></a>

# Description


**ceph-mds** is the metadata server daemon for the Ceph distributed file
system. One or more instances of ceph-mds collectively manage the file
system namespace, coordinating access to the shared OSD cluster.

Each ceph-mds daemon instance should have a unique name. The name is used
to identify daemon instances in the ceph.conf.

Once the daemon has started, the monitor cluster will normally assign
it a logical rank, or put it in a standby pool to take over for
another daemon that crashes. Some of the specified options can cause
other behaviors.

<a name="options"></a>

# Options

.INDENT 0.0

* **-f, --foreground**  
  Foreground: do not daemonize after startup (run in foreground). Do
  not generate a pid file. Useful when run via ceph-run(8).
  .UNINDENT
  .INDENT 0.0
* **-d**  
  Debug mode: like **-f**, but also send all log output to stderr.
  .UNINDENT
  .INDENT 0.0
* **--setuser userorgid**  
  Set uid after starting.  If a username is specified, the user
  record is looked up to get a uid and a gid, and the gid is also set
  as well, unless --setgroup is also specified.
  .UNINDENT
  .INDENT 0.0
* **--setgroup grouporgid**  
  Set gid after starting.  If a group name is specified the group
  record is looked up to get a gid.
  .UNINDENT
  .INDENT 0.0
* **-c ceph.conf, --conf=ceph.conf**  
  Use _ceph.conf_ configuration file instead of the default
  **/etc/ceph/ceph.conf** to determine monitor addresses during
  startup.
  .UNINDENT
  .INDENT 0.0
* **-m monaddress[:port]**  
  Connect to specified monitor (instead of looking through
  **ceph.conf**).
  .UNINDENT
  .INDENT 0.0
* **--id/-i ID**  
  Set ID portion of the MDS name.
  .UNINDENT

<a name="availability"></a>

# Availability


**ceph-mds** is part of Ceph, a massively scalable, open-source, distributed storage system. Please refer to the Ceph documentation at
_http://ceph.com/docs_ for more information.

<a name="see-also"></a>

# See Also


ceph(8),
ceph-mon(8),
ceph-osd(8)

<a name="copyright"></a>

# Copyright

2010-2014, Inktank Storage, Inc. and contributors. Licensed under Creative Commons Attribution Share Alike 3.0 (CC-BY-SA-3.0)

