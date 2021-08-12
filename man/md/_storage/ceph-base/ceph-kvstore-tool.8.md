# ceph-kvstore-tool(8) - ceph kvstore manipulation tool

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

    ceph-kvstore-tool <leveldb|rocksdb|bluestore-kv> <store path> command [args...]
```


```

<a name="description"></a>

# Description


**ceph-kvstore-tool** is a kvstore manipulation tool. It allows users to manipulate
leveldb/rocksdb's data (like OSD's omap) offline.

<a name="commands"></a>

# Commands


**ceph-kvstore-tool** utility uses many commands for debugging purpose
which are as follows:
.INDENT 0.0

* **list [prefix]**  
  Print key of all KV pairs stored with the URL encoded prefix.
* **list-crc [prefix]**  
  Print CRC of all KV pairs stored with the URL encoded prefix.
* **dump [prefix]**  
  Print key and value of all KV pairs stored with the URL encoded prefix.
* **exists &lt;prefix&gt; [key]**  
  Check if there is any KV pair stored with the URL encoded prefix. If key
  is also specified, check for the key with the prefix instead.
* **get &lt;prefix&gt; &lt;key&gt; [out &lt;file&gt;]**  
  Get the value of the KV pair stored with the URL encoded prefix and key.
  If file is also specified, write the value to the file.
* **crc &lt;prefix&gt; &lt;key&gt;**  
  Get the CRC of the KV pair stored with the URL encoded prefix and key.
* **get-size [&lt;prefix&gt; &lt;key&gt;]**  
  Get estimated store size or size of value specified by prefix and key.
* **set &lt;prefix&gt; &lt;key&gt; [ver &lt;N&gt;|in &lt;file&gt;]**  
  Set the value of the KV pair stored with the URL encoded prefix and key.
  The value could be _version\_t_ or text.
* **rm &lt;prefix&gt; &lt;key&gt;**  
  Remove the KV pair stored with the URL encoded prefix and key.
* **rm-prefix &lt;prefix&gt;**  
  Remove all KV pairs stored with the URL encoded prefix.
* **store-copy &lt;path&gt; [num-keys-per-tx]**  
  Copy all KV pairs to another directory specified by **path**.
  [num-keys-per-tx] is the number of KV pairs copied for a transaction.
* **store-crc &lt;path&gt;**  
  Store CRC of all KV pairs to a file specified by **path**.
* **compact**  
  Subcommand **compact** is used to compact all data of kvstore. It will open
  the database, and trigger a database's compaction. After compaction, some
  disk space may be released.
* **compact-prefix &lt;prefix&gt;**  
  Compact all entries specified by the URL encoded prefix.
* **compact-range &lt;prefix&gt; &lt;start&gt; &lt;end&gt;**  
  Compact some entries specified by the URL encoded prefix and range.
* **destructive-repair**  
  Make a (potentially destructive) effort to recover a corrupted database.
  Note that in the case of rocksdb this may corrupt an otherwise uncorrupted
  database--use this only as a last resort!
* **stats**  
  Prints statistics from underlying key-value database. This is only for informative purposes.
  Format and information content may vary between releases. For RocksDB information includes
  compactions stats, performance counters, memory usage and internal RocksDB stats.
  .UNINDENT

<a name="availability"></a>

# Availability


**ceph-kvstore-tool** is part of Ceph, a massively scalable, open-source, distributed storage system. Please refer to
the Ceph documentation at _http://ceph.com/docs_ for more information.

<a name="see-also"></a>

# See Also


ceph(8)

<a name="copyright"></a>

# Copyright

2010-2014, Inktank Storage, Inc. and contributors. Licensed under Creative Commons Attribution Share Alike 3.0 (CC-BY-SA-3.0)

