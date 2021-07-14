# switch_root(8) - switch to another filesystem as the root of the mount tree

util-linux, June 2009

```
switch_root [-hV] 
 switch_root newroot init [arg...]
```

<a name="description"></a>

# Description

**switch_root**
moves already mounted /proc, /dev, /sys and /run to
_newroot_
and makes
_newroot_
the new root filesystem and starts
_init_
process.

**WARNING: switch_root removes recursively all files and directories on the current root filesystem.**


<a name="options"></a>

# Options


* **-h, --help**  
  Display help text and exit.
* **-V, --version**  
  Display version information and exit.
  

<a name="return-value"></a>

# Return Value

**switch_root**
returns 0 on success and 1 on failure.


<a name="notes"></a>

# Notes

switch_root will fail to function if
**newroot**
is not the root of a mount. If you want to switch root into a directory that
does not meet this requirement then you can first use a bind-mounting trick to
turn any directory into a mount point:

    .RS
    mount --bind $DIR $DIR
    .RE


<a name="see-also"></a>

# See Also

**chroot**(2),
**init**(8),
**mkinitrd**(8),
**mount**(8)

<a name="authors"></a>

# Authors

    Peter Jones <pjones@redhat.com>
    Jeremy Katz <katzj@redhat.com>
    Karel Zak <kzak@redhat.com>

<a name="availability"></a>

# Availability

The switch_root command is part of the util-linux package and is available from
https://www.kernel.org/pub/linux/utils/util-linux/.
