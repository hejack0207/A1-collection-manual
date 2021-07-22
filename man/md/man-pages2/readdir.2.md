# readdir(2) - read directory entry

    
    int readdir(unsigned int fd, struct old_linux_dirent *dirp,
                unsigned int count);
```

 Note: There is no glibc wrapper for this system call; see NOTES.
```

<a name="description"></a>

# Description

This is not the function you are interested in.
Look at
**readdir**(3)
for the POSIX conforming C library interface.
This page documents the bare kernel system call interface,
which is superseded by
**getdents**(2).

**readdir**()
reads one
_old_linux_dirent_
structure from the directory
referred to by the file descriptor
_fd_
into the buffer pointed to by
_dirp_.
The argument
_count_
is ignored; at most one
_old_linux_dirent_
structure is read.

The
_old_linux_dirent_
structure is declared as follows:

.in +4n
.EX
struct old_linux_dirent {
    long  d_ino;              /* inode number */
    off_t d_off;              /* offset to this _old\_linux\_dirent_ */
    unsigned short d_reclen;  /* length of this _d\_name_ */
    char  d_name[NAME_MAX+1]; /* filename (null-terminated) */
}
.EE
.in

_d_ino_
is an inode number.
_d_off_
is the distance from the start of the directory to this
_old_linux_dirent_.
_d_reclen_
is the size of
_d_name_,
not counting the terminating null byte ('\\0').
_d_name_
is a null-terminated filename.

<a name="return-value"></a>

# Return Value

On success, 1 is returned.
On end of directory, 0 is returned.
On error, -1 is returned, and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors


* **EBADF**  
  Invalid file descriptor
  _fd_.
* **EFAULT**  
  Argument points outside the calling process's address space.
* **EINVAL**  
  Result buffer is too small.
* **ENOENT**  
  No such directory.
* **ENOTDIR**  
  File descriptor does not refer to a directory.

<a name="conforming-to"></a>

# Conforming to

This system call is Linux-specific.

<a name="notes"></a>

# Notes

Glibc does not provide a wrapper for this system call; call it using
**syscall**(2).
You will need to define the
_old_linux_dirent_
structure yourself.
However, probably you should use
**readdir**(3)
instead.

This system call does not exist on x86-64.

<a name="see-also"></a>

# See Also

**getdents**(2),
**readdir**(3)

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
