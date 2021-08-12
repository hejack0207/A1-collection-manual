# ceph-post-file(8) - post files for ceph developers

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

    ceph-post-file [-d description] [-u *user] file or dir ...
```


```

<a name="description"></a>

# Description


**ceph-post-file** will upload files or directories to ceph.com for
later analysis by Ceph developers.

Each invocation uploads files or directories to a separate directory
with a unique tag.  That tag can be passed to a developer or
referenced in a bug report (_http://tracker.ceph.com/_).  Once the
upload completes, the directory is marked non-readable and
non-writeable to prevent access or modification by other users.

<a name="warning"></a>

# Warning


Basic measures are taken to make posted data be visible only to
developers with access to ceph.com infrastructure. However, users
should think twice and/or take appropriate precautions before
posting potentially sensitive data (for example, logs or data
directories that contain Ceph secrets).

<a name="options"></a>

# Options

.INDENT 0.0

* **-d *description*, --description *description***  
  Add a short description for the upload.  This is a good opportunity
  to reference a bug number.  There is no default value.
  .UNINDENT
  .INDENT 0.0
* **-u *user***  
  Set the user metadata for the upload.  This defaults to _whoami\`@\`hostname -f_.
  .UNINDENT

<a name="examples"></a>

# Examples


To upload a single log:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph-post-file /var/log/ceph/ceph-mon.`hostname`.log
    .ft P
.UNINDENT
.UNINDENT

To upload several directories:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph-post-file -d 'mon data directories' /var/log/ceph/mon/*
    .ft P
.UNINDENT
.UNINDENT

<a name="availability"></a>

# Availability


**ceph-post-file** is part of Ceph, a massively scalable, open-source, distributed storage system. Please refer to
the Ceph documentation at _http://ceph.com/docs_ for more information.

<a name="see-also"></a>

# See Also


ceph(8),
ceph-debugpack(8),

<a name="copyright"></a>

# Copyright

2010-2014, Inktank Storage, Inc. and contributors. Licensed under Creative Commons Attribution Share Alike 3.0 (CC-BY-SA-3.0)

