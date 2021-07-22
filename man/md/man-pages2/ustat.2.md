# ustat(2) - get filesystem statistics

Linux, 2017-09-15

    #include <sys/types.h>
    #include <unistd.h>    /* libc[45] */
    #include <ustat.h>     /* glibc2 */
    
    int ustat(dev_t dev, struct ustat *ubuf);

<a name="description"></a>

# Description

**ustat**()
returns information about a mounted filesystem.
_dev_
is a device number identifying a device containing
a mounted filesystem.
_ubuf_
is a pointer to a
_ustat_
structure that contains the following
members:

.in +4n
.EX
daddr_t f_tfree;      /* Total free blocks */
ino_t   f_tinode;     /* Number of free inodes */
char    f_fname[6];   /* Filsys name */
char    f_fpack[6];   /* Filsys pack name */
.EE
.in

The last two fields,
_f_fname_
and
_f_fpack_,
are not implemented and will
always be filled with null bytes ('\\0').

<a name="return-value"></a>

# Return Value

On success, zero is returned and the
_ustat_
structure pointed to by
_ubuf_
will be filled in.
On error, -1 is returned, and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors


* **EFAULT**  
  _ubuf_
  points outside of your accessible address space.
* **EINVAL**  
  _dev_
  does not refer to a device containing a mounted filesystem.
* **ENOSYS**  
  The mounted filesystem referenced by
  _dev_
  does not support this operation, or any version of Linux before
  1.3.16.

<a name="conforming-to"></a>

# Conforming to

SVr4.



<a name="notes"></a>

# Notes

**ustat**()
is deprecated and has been provided only for compatibility.
All new programs should use
**statfs**(2)
instead.

<a name="hp-ux-notes"></a>

### HP-UX notes

The HP-UX version of the
_ustat_
structure has an additional field,
_f_blksize_,
that is unknown elsewhere.
HP-UX warns:
For some filesystems, the number of free inodes does not change.
Such filesystems will return -1 in the field
_f_tinode_.


For some filesystems, inodes are dynamically allocated.
Such filesystems will return the current number of free inodes.

<a name="see-also"></a>

# See Also

**stat**(2),
**statfs**(2)

<a name="colophon"></a>

# Colophon

This page is part of release 4.16 of the Linux
_man-pages_
project.
A description of the project,
information about reporting bugs,
and the latest version of this page,
can be found at
https://www.kernel.org/doc/man-pages/.
