# rbd-replay(8) - replay rados block device (RBD) workloads

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

    rbd-replay [ options ] replay_file
```


```

<a name="description"></a>

# Description


**rbd-replay** is a utility for replaying rados block device (RBD) workloads.

<a name="options"></a>

# Options

.INDENT 0.0

* **-c ceph.conf, --conf ceph.conf**  
  Use ceph.conf configuration file instead of the default /etc/ceph/ceph.conf to
  determine monitor addresses during startup.
  .UNINDENT
  .INDENT 0.0
* **-p pool, --pool pool**  
  Interact with the given pool.  Defaults to 'rbd'.
  .UNINDENT
  .INDENT 0.0
* **--latency-multiplier**  
  Multiplies inter-request latencies.  Default: 1.
  .UNINDENT
  .INDENT 0.0
* **--read-only**  
  Only replay non-destructive requests.
  .UNINDENT
  .INDENT 0.0
* **--map-image rule**  
  Add a rule to map image names in the trace to image names in the replay cluster.
  A rule of image1@snap1=image2@snap2 would map snap1 of image1 to snap2 of image2.
  .UNINDENT
  .INDENT 0.0
* **--dump-perf-counters**  
  **Experimental**
  Dump performance counters to standard out before an image is closed.
  Performance counters may be dumped multiple times if multiple images are closed,
  or if the same image is opened and closed multiple times.
  Performance counters and their meaning may change between versions.
  .UNINDENT

<a name="examples"></a>

# Examples


To replay workload1 as fast as possible:
.INDENT 0.0
.INDENT 3.5

    .ft C
    rbd-replay --latency-multiplier=0 workload1
    .ft P
.UNINDENT
.UNINDENT

To replay workload1 but use test_image instead of prod_image:
.INDENT 0.0
.INDENT 3.5

    .ft C
    rbd-replay --map-image=prod_image=test_image workload1
    .ft P
.UNINDENT
.UNINDENT

<a name="availability"></a>

# Availability


**rbd-replay** is part of Ceph, a massively scalable, open-source, distributed storage system. Please refer to
the Ceph documentation at _http://ceph.com/docs_ for more information.

<a name="see-also"></a>

# See Also


rbd-replay-prep(8),
rbd(8)

<a name="copyright"></a>

# Copyright

2010-2014, Inktank Storage, Inc. and contributors. Licensed under Creative Commons Attribution Share Alike 3.0 (CC-BY-SA-3.0)

