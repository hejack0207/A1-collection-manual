# monmaptool(8) - ceph monitor cluster map manipulation tool

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

    monmaptool mapfilename [ --clobber ] [ --print ] [ --create ]
    [ --add ip:port ... ] [ --rm ip:port ... ]
```


```

<a name="description"></a>

# Description


**monmaptool** is a utility to create, view, and modify a monitor
cluster map for the Ceph distributed storage system. The monitor map
specifies the only fixed addresses in the Ceph distributed system.
All other daemons bind to arbitrary addresses and register themselves
with the monitors.

When creating a map with --create, a new monitor map with a new,
random UUID will be created. It should be followed by one or more
monitor addresses.

The default Ceph monitor port is 6789.

<a name="options"></a>

# Options

.INDENT 0.0

* **--print**  
  will print a plaintext dump of the map, after any modifications are
  made.
  .UNINDENT
  .INDENT 0.0
* **--clobber**  
  will allow monmaptool to overwrite mapfilename if changes are made.
  .UNINDENT
  .INDENT 0.0
* **--create**  
  will create a new monitor map with a new UUID (and with it, a new,
  empty Ceph file system).
  .UNINDENT
  .INDENT 0.0
* **--generate**  
  generate a new monmap based on the values on the command line or specified
  in the ceph configuration.  This is, in order of preference,
  .INDENT 7.0
  .INDENT 3.5
  .INDENT 0.0
* 1.  
  **--monmap filename** to specify a monmap to load
* 2.  
  **--mon-host 'host1,ip2'** to specify a list of hosts or ip addresses
* 3.  
  **[mon.foo]** sections containing **mon addr** settings in the config. Note that this method is not recommended and support will be removed in a future release.
  .UNINDENT
  .UNINDENT
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **--filter-initial-members**  
  filter the initial monmap by applying the **mon initial members**
  setting.  Monitors not present in that list will be removed, and
  initial members not present in the map will be added with dummy
  addresses.
  .UNINDENT
  .INDENT 0.0
* **--add name ip:port**  
  will add a monitor with the specified ip:port to the map.
  .UNINDENT
  .INDENT 0.0
* **--rm name**  
  will remove the monitor with the specified ip:port from the map.
  .UNINDENT
  .INDENT 0.0
* **--fsid uuid**  
  will set the fsid to the given uuid.  If not specified with --create, a random fsid will be generated.
  .UNINDENT

<a name="example"></a>

# Example


To create a new map with three monitors (for a fresh Ceph file system):
.INDENT 0.0
.INDENT 3.5

    .ft C
    monmaptool  --create  --add  mon.a 192.168.0.10:6789 --add mon.b 192.168.0.11:6789 e
      --add mon.c 192.168.0.12:6789 --clobber monmap
    .ft P
.UNINDENT
.UNINDENT

To display the contents of the map:
.INDENT 0.0
.INDENT 3.5

    .ft C
    monmaptool --print monmap
    .ft P
.UNINDENT
.UNINDENT

To replace one monitor:
.INDENT 0.0
.INDENT 3.5

    .ft C
    monmaptool --rm mon.a --add mon.a 192.168.0.9:6789 --clobber monmap
    .ft P
.UNINDENT
.UNINDENT

<a name="availability"></a>

# Availability


**monmaptool** is part of Ceph, a massively scalable, open-source, distributed
storage system. Please refer to the Ceph documentation at _http://ceph.com/docs_
for more information.

<a name="see-also"></a>

# See Also


ceph(8),
crushtool(8),

<a name="copyright"></a>

# Copyright

2010-2014, Inktank Storage, Inc. and contributors. Licensed under Creative Commons Attribution Share Alike 3.0 (CC-BY-SA-3.0)

