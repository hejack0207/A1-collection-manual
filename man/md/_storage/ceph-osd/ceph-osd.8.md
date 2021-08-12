# ceph-osd(8) - ceph object storage daemon

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

    ceph-osd -i osdnum [ --osd-data datapath ] [ --osd-journal
    journal ] [ --mkfs ] [ --mkjournal ] [--flush-journal] [--check-allows-journal] [--check-wants-journal] [--check-needs-journal] [ --mkkey ]
```


```

<a name="description"></a>

# Description


**ceph-osd** is the object storage daemon for the Ceph distributed file
system. It is responsible for storing objects on a local file system
and providing access to them over the network.

The datapath argument should be a directory on a xfs file system
where the object data resides. The journal is optional, and is only
useful performance-wise when it resides on a different disk than
datapath with low latency (ideally, an NVRAM device).

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
* **--osd-data osddata**  
  Use object store at _osddata_.
  .UNINDENT
  .INDENT 0.0
* **--osd-journal journal**  
  Journal updates to _journal_.
  .UNINDENT
  .INDENT 0.0
* **--check-wants-journal**  
  Check whether a journal is desired.
  .UNINDENT
  .INDENT 0.0
* **--check-allows-journal**  
  Check whether a journal is allowed.
  .UNINDENT
  .INDENT 0.0
* **--check-needs-journal**  
  Check whether a journal is required.
  .UNINDENT
  .INDENT 0.0
* **--mkfs**  
  Create an empty object repository. This also initializes the journal
  (if one is defined).
  .UNINDENT
  .INDENT 0.0
* **--mkkey**  
  Generate a new secret key. This is normally used in combination
  with **--mkfs** as it is more convenient than generating a key by
  hand with ceph-authtool(8).
  .UNINDENT
  .INDENT 0.0
* **--mkjournal**  
  Create a new journal file to match an existing object repository.
  This is useful if the journal device or file is wiped out due to a
  disk or file system failure.
  .UNINDENT
  .INDENT 0.0
* **--flush-journal**  
  Flush the journal to permanent store. This runs in the foreground
  so you know when it's completed. This can be useful if you want to
  resize the journal or need to otherwise destroy it: this guarantees
  you won't lose data.
  .UNINDENT
  .INDENT 0.0
* **--get-cluster-fsid**  
  Print the cluster fsid (uuid) and exit.
  .UNINDENT
  .INDENT 0.0
* **--get-osd-fsid**  
  Print the OSD's fsid and exit.  The OSD's uuid is generated at
  --mkfs time and is thus unique to a particular instantiation of
  this OSD.
  .UNINDENT
  .INDENT 0.0
* **--get-journal-fsid**  
  Print the journal's uuid.  The journal fsid is set to match the OSD
  fsid at --mkfs time.
  .UNINDENT
  .INDENT 0.0
* **-c ceph.conf, --conf=ceph.conf**  
  Use _ceph.conf_ configuration file instead of the default
  **/etc/ceph/ceph.conf** for runtime configuration options.
  .UNINDENT
  .INDENT 0.0
* **-m monaddress[:port]**  
  Connect to specified monitor (instead of looking through
  **ceph.conf**).
  .UNINDENT

<a name="availability"></a>

# Availability


**ceph-osd** is part of Ceph, a massively scalable, open-source, distributed storage system. Please refer to
the Ceph documentation at _http://ceph.com/docs_ for more information.

<a name="see-also"></a>

# See Also


ceph(8),
ceph-mds(8),
ceph-mon(8),
ceph-authtool(8)

<a name="copyright"></a>

# Copyright

2010-2014, Inktank Storage, Inc. and contributors. Licensed under Creative Commons Attribution Share Alike 3.0 (CC-BY-SA-3.0)

