# mount.ceph(8) - mount a ceph file system

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

    mount.ceph [monaddr1,monaddr2,...]:/[subdir] dir [
    -o options ]
```


```

<a name="description"></a>

# Description


**mount.ceph** is a helper for mounting the Ceph file system on
a Linux host. It serves to resolve monitor hostname(s) into IP
addresses and read authentication keys from disk; the Linux kernel
client component does most of the real work. In fact, it is possible
to mount a non-authenticated Ceph file system without mount.ceph by
specifying monitor address(es) by IP:
.INDENT 0.0
.INDENT 3.5

    .ft C
    mount -t ceph 1.2.3.4:/ mountpoint
    .ft P
.UNINDENT
.UNINDENT

Each monitor address monaddr takes the form host[:port]. If the port
is not specified, the Ceph default of 6789 is assumed.

Multiple monitor addresses can be separated by commas. Only one
responsible monitor is needed to successfully mount; the client will
learn about all monitors from any responsive monitor. However, it is a
good idea to specify more than one in case one happens to be down at
the time of mount.

If the host portion of the device is left blank, then **mount.ceph** will
attempt to determine monitor addresses using local configuration files
and/or DNS SRV records.

A subdirectory subdir may be specified if a subset of the file system
is to be mounted.

Mount helper application conventions dictate that the first two
options are device to be mounted and destination path. Options must be
passed only after these fixed arguments.

<a name="options"></a>

# Options

.INDENT 0.0

* **wsize**  
  int (bytes), max write size. Default: 16777216 (16*1024*1024) (writeback uses smaller of wsize
  and stripe unit)
* **rsize**  
  int (bytes), max read size. Default: 16777216 (16*1024*1024)
* **rasize**  
  int (bytes), max readahead. Default: 8388608 (8192*1024)
* **osdtimeout**  
  int (seconds), Default: 60
* **osdkeepalive**  
  int, Default: 5
* **mount\_timeout**  
  int (seconds), Default: 60
* **osd\_idle\_ttl**  
  int (seconds), Default: 60
* **caps\_wanted\_delay\_min**  
  int, cap release delay, Default: 5
* **caps\_wanted\_delay\_max**  
  int, cap release delay, Default: 60
* **cap\_release\_safety**  
  int, Default: calculated
* **readdir\_max\_entries**  
  int, Default: 1024
* **readdir\_max\_bytes**  
  int, Default: 524288 (512*1024)
* **write\_congestion\_kb**  
  int (kb), max writeback in flight. scale with available
  memory. Default: calculated from available memory
* **snapdirname**  
  string, set the name of the hidden snapdir. Default: .snap
* **name**  
  RADOS user to authenticate as when using cephx. Default: guest
* **secret**  
  secret key for use with cephx. This option is insecure because it exposes
  the secret on the command line. To avoid this, use the secretfile option.
* **secretfile**  
  path to file containing the secret key to use with cephx
* **ip**  
  my ip
* **noshare**  
  create a new client instance, instead of sharing an existing
  instance of a client mounting the same cluster
* **dirstat**  
  funky _cat dirname_ for stats, Default: off
* **nodirstat**  
  no funky _cat dirname_ for stats
* **rbytes**  
  Report the recursive size of the directory contents for st_size on
  directories.  Default: off
* **norbytes**  
  Do not report the recursive size of the directory contents for
  st_size on directories.
* **nocrc**  
  no data crc on writes
* **noasyncreaddir**  
  no dcache readdir
* **conf**  
  Path to a ceph.conf file. This is used to initialize the ceph context
  for autodiscovery of monitor addresses and auth secrets. The default is
  to use the standard search path for ceph.conf files.
  .UNINDENT

<a name="mount-secrets"></a>

# Mount Secrets


If the _secret_ and _secretfile_ options are not specified on the command-line
then the mount helper will spawn a child process that will use the standard
ceph library routines to find a keyring and fetch the secret from it.

<a name="examples"></a>

# Examples


Mount the full file system:
.INDENT 0.0
.INDENT 3.5

    .ft C
    mount.ceph monhost:/ /mnt/foo
    .ft P
.UNINDENT
.UNINDENT

If there are multiple monitors:
.INDENT 0.0
.INDENT 3.5

    .ft C
    mount.ceph monhost1,monhost2,monhost3:/ /mnt/foo
    .ft P
.UNINDENT
.UNINDENT

If ceph-mon(8) is running on a non-standard
port:
.INDENT 0.0
.INDENT 3.5

    .ft C
    mount.ceph monhost1:7000,monhost2:7000,monhost3:7000:/ /mnt/foo
    .ft P
.UNINDENT
.UNINDENT

To automatically determine the monitor addresses from local configuration:
.INDENT 0.0
.INDENT 3.5

    .ft C
    mount.ceph :/ /mnt/foo
    .ft P
.UNINDENT
.UNINDENT

To mount only part of the namespace:
.INDENT 0.0
.INDENT 3.5

    .ft C
    mount.ceph monhost1:/some/small/thing /mnt/thing
    .ft P
.UNINDENT
.UNINDENT

Assuming mount.ceph(8) is installed properly, it should be
automatically invoked by mount(8) like so:
.INDENT 0.0
.INDENT 3.5

    .ft C
    mount -t ceph monhost:/ /mnt/foo
    .ft P
.UNINDENT
.UNINDENT

<a name="availability"></a>

# Availability


**mount.ceph** is part of Ceph, a massively scalable, open-source, distributed storage system. Please
refer to the Ceph documentation at _http://ceph.com/docs_ for more
information.

<a name="see-also"></a>

# See Also


ceph-fuse(8),
ceph(8)

<a name="copyright"></a>

# Copyright

2010-2014, Inktank Storage, Inc. and contributors. Licensed under Creative Commons Attribution Share Alike 3.0 (CC-BY-SA-3.0)

