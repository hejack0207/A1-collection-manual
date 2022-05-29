# installkernel(8) - tool to script kernel installation

Wed Apr 14 2010

```
installkernel <kernel-version> <bootimage> <mapfile>
```


<a name="description"></a>

# Description

**installkernel** installs a new kernel image onto the system from
the Linux source tree. It is called by the Linux kernel makefiles when
**make install** is invoked there.

The new kernel is installed into {directory}/vmlinuz-{version}. If a
symbolic link {directory}/vmlinuz already exists, it is refreshed by
making a link from {directory}/vmlinuz to the new kernel, and the
previously installed kernel is available as {directory}/vmlinuz.old.


<a name="see-also"></a>

# See Also

**grubby(8)**
**new-kernel-pkg(8)**


<a name="authors"></a>

# Authors

    Erik Troan
    Jeremy Katz
    Peter Jones
