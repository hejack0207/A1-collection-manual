# ceph-clsinfo(8) - show class object information

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

    ceph-clsinfo [ options ] ... filename
```


```

<a name="description"></a>

# Description


**ceph-clsinfo** can show name, version, and architecture information
about a specific class object.

<a name="options"></a>

# Options

.INDENT 0.0

* **-n, --name**  
  Shows the class name
  .UNINDENT
  .INDENT 0.0
* **-v, --version**  
  Shows the class version
  .UNINDENT
  .INDENT 0.0
* **-a, --arch**  
  Shows the class architecture
  .UNINDENT

<a name="availability"></a>

# Availability


**ceph-clsinfo** is part of Ceph, a massively scalable, open-source, distributed storage system. Please
refer to the Ceph documentation at _http://ceph.com/docs_ for more
information.

<a name="see-also"></a>

# See Also


ceph(8)

<a name="copyright"></a>

# Copyright

2010-2014, Inktank Storage, Inc. and contributors. Licensed under Creative Commons Attribution Share Alike 3.0 (CC-BY-SA-3.0)

