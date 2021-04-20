# qemu-nbd.8(8)

 , 2019-08-14

.if n .ad l
.nh

<a name="name"></a>

# Name

qemu-nbd - QEMU Disk Network Block Device Server

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" qemu-nbd [\s-1OPTION\s0]... filename 
 qemu-nbd -d dev
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
Export a \s-1QEMU\s0 disk image using the \s-1NBD\s0 protocol.

<a name="options"></a>

# Options

.IX Header "OPTIONS"
_filename_ is a disk image filename, or a set of block
driver options if _--image-opts_ is specified.

_dev_ is an \s-1NBD\s0 device.

* **--object type,id=**_id_**,...props...**  
  .IX Item "--object type,id=id,...props..."
  Define a new instance of the _type_ object class identified by _id_.
  See the \f(CWqemu(1) manual page for full details of the properties
  supported. The common object types that it makes sense to define are the
  \f(CW`secret\*(C' object, which is used to supply passwords and/or encryption
  keys, and the \f(CW`tls-creds\*(C' object, which is used to supply \s-1TLS\s0
  credentials for the qemu-nbd server.
* **-p, --port=**_port_  
  .IX Item "-p, --port=port"
  The \s-1TCP\s0 port to listen on (default **10809**)
* **-o, --offset=**_offset_  
  .IX Item "-o, --offset=offset"
  The offset into the image
* **-b, --bind=**_iface_  
  .IX Item "-b, --bind=iface"
  The interface to bind to (default **0.0.0.0**)
* **-k, --socket=**_path_  
  .IX Item "-k, --socket=path"
  Use a unix socket with path _path_
* **--image-opts**  
  .IX Item "--image-opts"
  Treat _filename_ as a set of image options, instead of a plain
  filename. If this flag is specified, the _-f_ flag should
  not be used, instead the '\f(CW`format=\*(C'' option should be set.
* **-f, --format=**_fmt_  
  .IX Item "-f, --format=fmt"
  Force the use of the block driver for format _fmt_ instead of
  auto-detecting
* **-r, --read-only**  
  .IX Item "-r, --read-only"
  Export the disk as read-only
* **-P, --partition=**_num_  
  .IX Item "-P, --partition=num"
  Only expose partition _num_
* **-s, --snapshot**  
  .IX Item "-s, --snapshot"
  Use _filename_ as an external snapshot, create a temporary
  file with backing\_file=_filename_, redirect the write to
  the temporary one
* **-l, --load-snapshot=**_snapshot\_param_  
  .IX Item "-l, --load-snapshot=snapshot_param"
  Load an internal snapshot inside _filename_ and export it
  as an read-only device, _snapshot\_param_ format is
  'snapshot.id=[\s-1ID\s0],snapshot.name=[\s-1NAME\s0]' or '[\s-1ID_OR_NAME\s0]'
* **-n, --nocache**  
  .IX Item "-n, --nocache"
* **--cache=**_cache_  
  .IX Item "--cache=cache"
  The cache mode to be used with the file.  See the documentation of
  the emulator's \f(CW`-drive cache=...\*(C' option for allowed values.
* **--aio=**_aio_  
  .IX Item "--aio=aio"
  Set the asynchronous I/O mode between **threads** (the default)
  and **native** (Linux only).
* **--discard=**_discard_  
  .IX Item "--discard=discard"
  Control whether _discard_ (also known as _trim_ or _unmap_)
  requests are ignored or passed to the filesystem.  _discard_ is one of
  **ignore** (or **off**), **unmap** (or **on**).  The default is
  **ignore**.
* **--detect-zeroes=**_detect-zeroes_  
  .IX Item "--detect-zeroes=detect-zeroes"
  Control the automatic conversion of plain zero writes by the \s-1OS\s0 to
  driver-specific optimized zero write commands.  _detect-zeroes_ is one of
  **off**, **on** or **unmap**.  **unmap**
  converts a zero write to an unmap operation and can only be used if
  _discard_ is set to **unmap**.  The default is **off**.
* **-c, --connect=**_dev_  
  .IX Item "-c, --connect=dev"
  Connect _filename_ to \s-1NBD\s0 device _dev_
* **-d, --disconnect**  
  .IX Item "-d, --disconnect"
  Disconnect the device _dev_
* **-e, --shared=**_num_  
  .IX Item "-e, --shared=num"
  Allow up to _num_ clients to share the device (default **1**)
* **-t, --persistent**  
  .IX Item "-t, --persistent"
  Don't exit on the last connection
* **-x, --export-name=**_name_  
  .IX Item "-x, --export-name=name"
  Set the \s-1NBD\s0 volume export name. This switches the server to use
  the new style \s-1NBD\s0 protocol negotiation
* **-D, --description=**_description_  
  .IX Item "-D, --description=description"
  Set the \s-1NBD\s0 volume export description, as a human-readable
  string. Requires the use of **-x**
* **--tls-creds=ID**  
  .IX Item "--tls-creds=ID"
  Enable mandatory \s-1TLS\s0 encryption for the server by setting the \s-1ID\s0
  of the \s-1TLS\s0 credentials object previously created with the --object
  option.
* **--fork**  
  .IX Item "--fork"
  Fork off the server process and exit the parent once the server is running.
* **-v, --verbose**  
  .IX Item "-v, --verbose"
  Display extra debugging information
* **-h, --help**  
  .IX Item "-h, --help"
  Display this help and exit
* **-V, --version**  
  .IX Item "-V, --version"
  Display version information and exit
* **-T, --trace [[enable=]**_pattern_**][,events=**_file_**][,file=**_file_**]**  
  .IX Item "-T, --trace [[enable=]pattern][,events=file][,file=file]"
  Specify tracing options.
    * **[enable=]**_pattern_  
      .IX Item "[enable=]pattern"
      Immediately enable events matching _pattern_
      (either event name or a globbing pattern).  This option is only
      available if \s-1QEMU\s0 has been compiled with the _simple_, _log_
      or _ftrace_ tracing backend.  To specify multiple events or patterns,
      specify the **-trace** option multiple times.
      .Sp
      Use \f(CW`-trace help\*(C' to print a list of names of trace points.
    * **events=**_file_  
      .IX Item "events=file"
      Immediately enable events listed in _file_.
      The file must contain one event name (as listed in the _trace-events-all_
      file) per line; globbing patterns are accepted too.  This option is only
      available if \s-1QEMU\s0 has been compiled with the _simple_, _log_ or
      _ftrace_ tracing backend.
    * **file=**_file_  
      .IX Item "file=file"
      Log output traces to _file_.
      This option is only available if \s-1QEMU\s0 has been compiled with
      the _simple_ tracing backend.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**qemu**\|(1), **qemu-img**\|(1)

<a name="author"></a>

# Author

.IX Header "AUTHOR"
Copyright (C) 2006 Anthony Liguori &lt;[anthony@codemonkey.ws](mailto:anthony@codemonkey.ws)&gt;.
This is free software; see the source for copying conditions.  There is \s-1NO\s0
warranty; not even for \s-1MERCHANTABILITY\s0 or \s-1FITNESS FOR A PARTICULAR PURPOSE.\s0
