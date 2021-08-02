# rpm2cpio(8) - Extract cpio archive from RPM Package Manager (RPM) package.

Red Hat, Inc., 11 January 2001

```
rpm2cpio [filename] 
```

<a name="description"></a>

# Description

**rpm2cpio** converts the .rpm file specified as a single argument
to a cpio archive on standard out. If a '-' argument is given, an rpm stream
is read from standard in.
  
_**rpm2cpio glint-1.0-1.i386.rpm | cpio -dium**_  
_**cat glint-1.0-1.i386.rpm | rpm2cpio - | cpio -tv**_


<a name="see-also"></a>

# See Also

_rpm_(8)

<a name="author"></a>

# Author

    Erik Troan <ewt@redhat.com>
