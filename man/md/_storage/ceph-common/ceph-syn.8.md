# ceph-syn(8) - ceph synthetic workload generator

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

    ceph-syn [ -m monaddr:port ] --syn command ...
```


```

<a name="description"></a>

# Description


**ceph-syn** is a simple synthetic workload generator for the Ceph
distributed file system. It uses the userspace client library to
generate simple workloads against a currently running file system. The
file system need not be mounted via ceph-fuse(8) or the kernel client.

One or more **--syn** command arguments specify the particular
workload, as documented below.

<a name="options"></a>

# Options

.INDENT 0.0

* **-d**  
  Detach from console and daemonize after startup.
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
* **--num_client num**  
  Run num different clients, each in a separate thread.
  .UNINDENT
  .INDENT 0.0
* **--syn workloadspec**  
  Run the given workload. May be specified as many times as
  needed. Workloads will normally run sequentially.
  .UNINDENT

<a name="workloads"></a>

# Workloads


Each workload should be preceded by **--syn** on the command
line. This is not a complete list.
.INDENT 0.0

* **mknap** _path_ _snapname_  
  Create a snapshot called _snapname_ on _path_.
* **rmsnap** _path_ _snapname_  
  Delete snapshot called _snapname_ on _path_.
* **rmfile** _path_  
  Delete/unlink _path_.
* **writefile** _sizeinmb_ _blocksize_  
  Create a file, named after our client id, that is _sizeinmb_ MB by
  writing _blocksize_ chunks.
* **readfile** _sizeinmb_ _blocksize_  
  Read file, named after our client id, that is _sizeinmb_ MB by
  writing _blocksize_ chunks.
* **rw** _sizeinmb_ _blocksize_  
  Write file, then read it back, as above.
* **makedirs** _numsubdirs_ _numfiles_ _depth_  
  Create a hierarchy of directories that is _depth_ levels deep. Give
  each directory _numsubdirs_ subdirectories and _numfiles_ files.
* **walk**  
  Recursively walk the file system (like find).
  .UNINDENT

<a name="availability"></a>

# Availability


**ceph-syn** is part of Ceph, a massively scalable, open-source, distributed storage system. Please refer to
the Ceph documentation at _http://ceph.com/docs_ for more information.

<a name="see-also"></a>

# See Also


ceph(8),
ceph-fuse(8)

<a name="copyright"></a>

# Copyright

2010-2014, Inktank Storage, Inc. and contributors. Licensed under Creative Commons Attribution Share Alike 3.0 (CC-BY-SA-3.0)

