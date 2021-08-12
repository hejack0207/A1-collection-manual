# ceph-dencoder(8) - ceph encoder/decoder utility

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

    ceph-dencoder [commands...]
```


```

<a name="description"></a>

# Description


**ceph-dencoder** is a utility to encode, decode, and dump ceph data
structures.  It is used for debugging and for testing inter-version
compatibility.

**ceph-dencoder** takes a simple list of commands and performs them
in order.

<a name="commands"></a>

# Commands

.INDENT 0.0

* **version**  
  Print the version string for the **ceph-dencoder** binary.
  .UNINDENT
  .INDENT 0.0
* **import &lt;file&gt;**  
  Read a binary blob of encoded data from the given file.  It will be
  placed in an in-memory buffer.
  .UNINDENT
  .INDENT 0.0
* **export &lt;file&gt;**  
  Write the contents of the current in-memory buffer to the given
  file.
  .UNINDENT
  .INDENT 0.0
* **list_types**  
  List the data types known to this build of **ceph-dencoder**.
  .UNINDENT
  .INDENT 0.0
* **type &lt;name&gt;**  
  Select the given type for future **encode** or **decode** operations.
  .UNINDENT
  .INDENT 0.0
* **skip &lt;bytes&gt;**  
  Seek &lt;bytes&gt; into the imported file before reading data structure, use
  this with objects that have a preamble/header before the object of interest.
  .UNINDENT
  .INDENT 0.0
* **decode**  
  Decode the contents of the in-memory buffer into an instance of the
  previously selected type.  If there is an error, report it.
  .UNINDENT
  .INDENT 0.0
* **encode**  
  Encode the contents of the in-memory instance of the previously
  selected type to the in-memory buffer.
  .UNINDENT
  .INDENT 0.0
* **dump_json**  
  Print a JSON-formatted description of the in-memory object.
  .UNINDENT
  .INDENT 0.0
* **count_tests**  
  Print the number of built-in test instances of the previously
  selected type that **ceph-dencoder** is able to generate.
  .UNINDENT
  .INDENT 0.0
* **select_test &lt;n&gt;**  
  Select the given build-in test instance as a the in-memory instance
  of the type.
  .UNINDENT
  .INDENT 0.0
* **get_features**  
  Print the decimal value of the feature set supported by this version
  of **ceph-dencoder**.  Each bit represents a feature.  These correspond to
  CEPH_FEATURE_* defines in src/include/ceph_features.h.
  .UNINDENT
  .INDENT 0.0
* **set_features &lt;f&gt;**  
  Set the feature bits provided to **encode** to _f_.  This allows
  you to encode objects such that they can be understood by old
  versions of the software (for those types that support it).
  .UNINDENT

<a name="example"></a>

# Example


Say you want to examine an attribute on an object stored by **ceph-osd**.  You can do this:
.INDENT 0.0
.INDENT 3.5

    .ft C
    $ cd /mnt/osd.12/current/2.b_head
    $ attr -l foo_bar_head_EFE6384B
    Attribute "ceph.snapset" has a 31 byte value for foo_bar_head_EFE6384B
    Attribute "ceph._" has a 195 byte value for foo_bar_head_EFE6384B
    $ attr foo_bar_head_EFE6384B -g ceph._ -q > /tmp/a
    $ ceph-dencoder type object_info_t import /tmp/a decode dump_json
    { "oid": { "oid": "foo",
          "key": "bar",
          "snapid": -2,
          "hash": 4024842315,
          "max": 0},
      "locator": { "pool": 2,
          "preferred": -1,
          "key": "bar"},
      "category": "",
      "version": "9'1",
      "prior_version": "0'0",
      "last_reqid": "client.4116.0:1",
      "size": 1681,
      "mtime": "2012-02-21 08:58:23.666639",
      "lost": 0,
      "wrlock_by": "unknown.0.0:0",
      "snaps": [],
      "truncate_seq": 0,
      "truncate_size": 0,
      "watchers": {}}
    .ft P
.UNINDENT
.UNINDENT

Alternatively, perhaps you wish to dump an internal CephFS metadata object, you might
do that like this:
.INDENT 0.0
.INDENT 3.5

    .ft C
    $ rados -p metadata get mds_snaptable mds_snaptable.bin
    $ ceph-dencoder type SnapServer skip 8 import mds_snaptable.bin decode dump_json
    { "snapserver": { "last_snap": 1,
       "pending_noop": [],
       "snaps": [],
       "need_to_purge": {},
       "pending_create": [],
       "pending_destroy": []}}
    .ft P
.UNINDENT
.UNINDENT

<a name="availability"></a>

# Availability


**ceph-dencoder** is part of Ceph, a massively scalable, open-source, distributed storage system. Please
refer to the Ceph documentation at _http://ceph.com/docs_ for more
information.

<a name="see-also"></a>

# See Also


ceph(8)

<a name="copyright"></a>

# Copyright

2010-2014, Inktank Storage, Inc. and contributors. Licensed under Creative Commons Attribution Share Alike 3.0 (CC-BY-SA-3.0)

