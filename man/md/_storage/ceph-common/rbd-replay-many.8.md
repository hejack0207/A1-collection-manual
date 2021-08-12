# rbd-replay-many(8) - replay a rados block device (RBD) workload on several clients

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

    rbd-replay-many [ options ] --original-image name host1 [ host2 [ ... ] ] -- rbd_replay_args
```


```

<a name="description"></a>

# Description


**rbd-replay-many** is a utility for replaying a rados block device (RBD) workload on several clients.
Although all clients use the same workload, they replay against separate images.
This matches normal use of librbd, where each original client is a VM with its own image.

Configuration and replay files are not automatically copied to clients.
Replay images must already exist.

<a name="options"></a>

# Options

.INDENT 0.0

* **--original-image name**  
  Specifies the name (and snap) of the originally traced image.
  Necessary for correct name mapping.
  .UNINDENT
  .INDENT 0.0
* **--image-prefix prefix**  
  Prefix of image names to replay against.
  Specifying --image-prefix=foo results in clients replaying against foo-0, foo-1, etc.
  Defaults to the original image name.
  .UNINDENT
  .INDENT 0.0
* **--exec program**  
  Path to the rbd-replay executable.
  .UNINDENT
  .INDENT 0.0
* **--delay seconds**  
  Delay between starting each client.  Defaults to 0.
  .UNINDENT

<a name="examples"></a>

# Examples


Typical usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    rbd-replay-many host-0 host-1 --original-image=image -- -c ceph.conf replay.bin
    .ft P
.UNINDENT
.UNINDENT

This results in the following commands being executed:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ssh host-0 'rbd-replay' --map-image 'image=image-0' -c ceph.conf replay.bin
    ssh host-1 'rbd-replay' --map-image 'image=image-1' -c ceph.conf replay.bin
    .ft P
.UNINDENT
.UNINDENT

<a name="availability"></a>

# Availability


**rbd-replay-many** is part of Ceph, a massively scalable, open-source, distributed storage system. Please refer to
the Ceph documentation at _http://ceph.com/docs_ for more information.

<a name="see-also"></a>

# See Also


rbd-replay(8),
rbd(8)

<a name="copyright"></a>

# Copyright

2010-2014, Inktank Storage, Inc. and contributors. Licensed under Creative Commons Attribution Share Alike 3.0 (CC-BY-SA-3.0)

