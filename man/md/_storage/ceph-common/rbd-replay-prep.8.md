# rbd-replay-prep(8) - prepare captured rados block device (RBD) workloads for replay

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

    rbd-replay-prep [ --window seconds ] [ --anonymize ] trace_dir replay_file
```


```

<a name="description"></a>

# Description


**rbd-replay-prep** processes raw rados block device (RBD) traces to prepare them for **rbd-replay**.

<a name="options"></a>

# Options

.INDENT 0.0

* **--window seconds**  
  Requests further apart than 'seconds' seconds are assumed to be independent.
  .UNINDENT
  .INDENT 0.0
* **--anonymize**  
  Anonymizes image and snap names.
  .UNINDENT
  .INDENT 0.0
* **--verbose**  
  Print all processed events to console
  .UNINDENT

<a name="examples"></a>

# Examples


To prepare workload1-trace for replay:
.INDENT 0.0
.INDENT 3.5

    .ft C
    rbd-replay-prep workload1-trace/ust/uid/1000/64-bit workload1
    .ft P
.UNINDENT
.UNINDENT

<a name="availability"></a>

# Availability


**rbd-replay-prep** is part of Ceph, a massively scalable, open-source, distributed storage system. Please refer to
the Ceph documentation at _http://ceph.com/docs_ for more information.

<a name="see-also"></a>

# See Also


rbd-replay(8),
rbd(8)

<a name="copyright"></a>

# Copyright

2010-2014, Inktank Storage, Inc. and contributors. Licensed under Creative Commons Attribution Share Alike 3.0 (CC-BY-SA-3.0)

