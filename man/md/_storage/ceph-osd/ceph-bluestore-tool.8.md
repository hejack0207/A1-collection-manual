# ceph-bluestore-tool(8) - bluestore administrative tool

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

    ceph-bluestore-tool command
    [ --dev device ... ]
    [ --path osd path ]
    [ --out-dir dir ]
    [ --log-file | -l filename ]
    [ --deep ]
    ceph-bluestore-tool fsck|repair --path osd path [ --deep ]
    ceph-bluestore-tool show-label --dev device ...
    ceph-bluestore-tool prime-osd-dir --dev device --path osd path
    ceph-bluestore-tool bluefs-export --path osd path --out-dir dir
    ceph-bluestore-tool bluefs-bdev-new-wal --path osd path --dev-target new-device
    ceph-bluestore-tool bluefs-bdev-new-db --path osd path --dev-target new-device
    ceph-bluestore-tool bluefs-bdev-migrate --path osd path --dev-target new-device --devs-source device1 [--devs-source device2]
    ceph-bluestore-tool free-dump|free-score --path osd path [ --allocator block/bluefs-wal/bluefs-db/bluefs-slow ]
```


```

<a name="description"></a>

# Description


**ceph-bluestore-tool** is a utility to perform low-level administrative
operations on a BlueStore instance.

<a name="commands"></a>

# Commands


**help**
.INDENT 0.0
.INDENT 3.5
show help
.UNINDENT
.UNINDENT

**fsck** [ --deep ]
.INDENT 0.0
.INDENT 3.5
run consistency check on BlueStore metadata.  If _--deep_ is specified, also read all object data and verify checksums.
.UNINDENT
.UNINDENT

**repair**
.INDENT 0.0
.INDENT 3.5
Run a consistency check _and_ repair any errors we can.
.UNINDENT
.UNINDENT

**bluefs-export**
.INDENT 0.0
.INDENT 3.5
Export the contents of BlueFS (i.e., rocksdb files) to an output directory.
.UNINDENT
.UNINDENT

**bluefs-bdev-sizes** --path _osd path_
.INDENT 0.0
.INDENT 3.5
Print the device sizes, as understood by BlueFS, to stdout.
.UNINDENT
.UNINDENT

**bluefs-bdev-expand** --path _osd path_
.INDENT 0.0
.INDENT 3.5
Instruct BlueFS to check the size of its block devices and, if they have expanded, make use of the additional space.
.UNINDENT
.UNINDENT

**bluefs-bdev-new-wal** --path _osd path_ --dev-target _new-device_
.INDENT 0.0
.INDENT 3.5
Adds WAL device to BlueFS, fails if WAL device already exists.
.UNINDENT
.UNINDENT

**bluefs-bdev-new-db** --path _osd path_ --dev-target _new-device_
.INDENT 0.0
.INDENT 3.5
Adds DB device to BlueFS, fails if DB device already exists.
.UNINDENT
.UNINDENT

**bluefs-bdev-migrate** --dev-target _new-device_ --devs-source _device1_ [--devs-source _device2_]
.INDENT 0.0
.INDENT 3.5
Moves BlueFS data from source device(s) to the target one, source devices
(except the main one) are removed on success. Target device can be both
already attached or new device. In the latter case it's added to OSD
replacing one of the source devices. Following replacement rules apply
(in the order of precedence, stop on the first match):
.INDENT 0.0
.INDENT 3.5
.INDENT 0.0

* ·  
  if source list has DB volume - target device replaces it.
* ·  
  if source list has WAL volume - target device replace it.
* ·  
  if source list has slow volume only - operation isn't permitted, requires explicit allocation via new-db/new-wal command.
  .UNINDENT
  .UNINDENT
  .UNINDENT
  .UNINDENT
  .UNINDENT

**show-label** --dev _device_ [...]
.INDENT 0.0
.INDENT 3.5
Show device label(s).
.UNINDENT
.UNINDENT

**free-dump** --path _osd path_ [ --allocator block/bluefs-wal/bluefs-db/bluefs-slow ]
.INDENT 0.0
.INDENT 3.5
Dump all free regions in allocator.
.UNINDENT
.UNINDENT

**free-score** --path _osd path_ [ --allocator block/bluefs-wal/bluefs-db/bluefs-slow ]
.INDENT 0.0
.INDENT 3.5
Give a [0-1] number that represents quality of fragmentation in allocator.
0 represents case when all free space is in one chunk. 1 represents worst possible fragmentation.
.UNINDENT
.UNINDENT

<a name="options"></a>

# Options

.INDENT 0.0

* **--dev *device***  
  Add _device_ to the list of devices to consider
  .UNINDENT
  .INDENT 0.0
* **--devs-source *device***  
  Add _device_ to the list of devices to consider as sources for migrate operation
  .UNINDENT
  .INDENT 0.0
* **--dev-target *device***  
  Specify target _device_ migrate operation or device to add for adding new DB/WAL.
  .UNINDENT
  .INDENT 0.0
* **--path *osd path***  
  Specify an osd path.  In most cases, the device list is inferred from the symlinks present in _osd path_.  This is usually simpler than explicitly specifying the device(s) with --dev.
  .UNINDENT
  .INDENT 0.0
* **--out-dir *dir***  
  Output directory for bluefs-export
  .UNINDENT
  .INDENT 0.0
* **-l, --log-file *log file***  
  file to log to
  .UNINDENT
  .INDENT 0.0
* **--log-level *num***  
  debug log level.  Default is 30 (extremely verbose), 20 is very
  verbose, 10 is verbose, and 1 is not very verbose.
  .UNINDENT
  .INDENT 0.0
* **--deep**  
  deep scrub/repair (read and validate object data, not just metadata)
  .UNINDENT
  .INDENT 0.0
* **--allocator *name***  
  Useful for _free-dump_ and _free-score_ actions. Selects allocator(s).
  .UNINDENT

<a name="device-labels"></a>

# Device Labels


Every BlueStore block device has a single block label at the beginning of the
device.  You can dump the contents of the label with:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph-bluestore-tool show-label --dev *device*
    .ft P
.UNINDENT
.UNINDENT

The main device will have a lot of metadata, including information
that used to be stored in small files in the OSD data directory.  The
auxiliary devices (db and wal) will only have the minimum required
fields (OSD UUID, size, device type, birth time).

<a name="osd-directory-priming"></a>

# Osd Directory Priming


You can generate the content for an OSD data directory that can start up a
BlueStore OSD with the _prime-osd-dir_ command:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph-bluestore-tool prime-osd-dir --dev *main device* --path /var/lib/ceph/osd/ceph-*id*
    .ft P
.UNINDENT
.UNINDENT

<a name="availability"></a>

# Availability


**ceph-bluestore-tool** is part of Ceph, a massively scalable,
open-source, distributed storage system. Please refer to the Ceph
documentation at _http://ceph.com/docs_ for more information.

<a name="see-also"></a>

# See Also


ceph-osd(8)

<a name="copyright"></a>

# Copyright

2010-2014, Inktank Storage, Inc. and contributors. Licensed under Creative Commons Attribution Share Alike 3.0 (CC-BY-SA-3.0)

