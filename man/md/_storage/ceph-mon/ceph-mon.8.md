# ceph-mon(8) - ceph monitor daemon

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

    ceph-mon -i monid [ --mon-data mondatapath ]
```


```

<a name="description"></a>

# Description


**ceph-mon** is the cluster monitor daemon for the Ceph distributed
file system. One or more instances of **ceph-mon** form a Paxos
part-time parliament cluster that provides extremely reliable and
durable storage of cluster membership, configuration, and state.

The _mondatapath_ refers to a directory on a local file system storing
monitor data. It is normally specified via the **mon data** option in
the configuration file.

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
* **--mkfs**  
  Initialize the **mon data** directory with seed information to form
  and initial ceph file system or to join an existing monitor
  cluster.  Three pieces of information must be provided:
  .INDENT 7.0
* ·  
  The cluster fsid.  This can come from a monmap (**--monmap &lt;path&gt;**) or
  explicitly via **--fsid &lt;uuid&gt;**.
* ·  
  A list of monitors and their addresses.  This list of monitors
  can come from a monmap (**--monmap &lt;path&gt;**), the **mon host**
  configuration value (in _ceph.conf_ or via -m
  host1,host2,...), or (for backward compatibility) the deprecated **mon addr** lines in _ceph.conf_.  If this
  monitor is to be part of the initial monitor quorum for a new
  Ceph cluster, then it must be included in the initial list,
  matching either the name or address of a monitor in the list.
  When matching by address, either the **public addr** or public
  subnet options may be used.
* ·  
  The monitor secret key **mon.**.  This must be included in the
  keyring provided via **--keyring &lt;path&gt;**.
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **--keyring**  
  Specify a keyring for use with **--mkfs**.
  .UNINDENT

<a name="availability"></a>

# Availability


**ceph-mon** is part of Ceph, a massively scalable, open-source, distributed storage system. Please refer
to the Ceph documentation at _http://ceph.com/docs_ for more
information.

<a name="see-also"></a>

# See Also


ceph(8),
ceph-mds(8),
ceph-osd(8)

<a name="copyright"></a>

# Copyright

2010-2014, Inktank Storage, Inc. and contributors. Licensed under Creative Commons Attribution Share Alike 3.0 (CC-BY-SA-3.0)

