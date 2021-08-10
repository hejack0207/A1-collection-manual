# abrt\-handle\-upload(1)

abrt 2\&.14\&.4, 09/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

abrt-handle-upload - Unpacks and moves problem data.

<a name="synopsis"></a>

# Synopsis

```

 abrt-handle-upload [-vd] ABRT_SPOOL_DIR UPLOAD_DIR FILENAME
```

<a name="description"></a>

# Description


The tool unpacks FILENAME located in UPLOAD_DIR and moves the problem data found in it to ABRT_SPOOL_DIR. It supports unpacking tarballs compressed by gzip, bzip2 or xz. It’s called by abrtd when a new file is noticed in the upload directory configured by the _WatchCrashdumpArchiveDir_ option.

<a name="options"></a>

# Options


-v
Be more verbose. Can be given multiple times

-d
Delete uploaded archive

ABRT_SPOOL_DIR
Directory where archives are unpacked to

UPLOAD_DIR
Directory where uploaded archives are stored

FILENAME
File name of the uploaded archive to unpack

<a name="authors"></a>

# Authors


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  ABRT team

<a name="see-also"></a>

# See Also


abrt.conf(5)
