# llseek(2) - reposition read/write file offset

Linux, 2017-09-15

    #include <sys/types.h>
    #include <unistd.h>
    
    int _llseek(unsigned int fd, unsigned long offset_high,
                unsigned long offset_low, loff_t *result,
                unsigned int whence);
```

 Note: There is no glibc wrapper for this system call; see NOTES.
```

<a name="description"></a>

# Description

The
**_llseek**()
system call repositions the offset of the open file description associated
with the file descriptor
_fd_
to
_(offset_high&lt;&lt;32) | offset_low_
bytes relative to the beginning of the file, the current file offset,
or the end of the file, depending on whether
_whence_
is
**SEEK_SET**,
**SEEK_CUR**,
or
**SEEK_END**,
respectively.
It returns the resulting file position in the argument
_result_.

This system call exists on various 32-bit platforms to support
seeking to large file offsets.

<a name="return-value"></a>

# Return Value

Upon successful completion,
**_llseek**()
returns 0.
Otherwise, a value of -1 is returned and
_errno_
is set to indicate the error.

<a name="errors"></a>

# Errors


* **EBADF**  
  _fd_
  is not an open file descriptor.
* **EFAULT**  
  Problem with copying results to user space.
* **EINVAL**  
  _whence_
  is invalid.

<a name="conforming-to"></a>

# Conforming to

This function is Linux-specific, and should not be used in programs
intended to be portable.

<a name="notes"></a>

# Notes

Glibc does not provide a wrapper for this system call.
To invoke it directly, use
**syscall**(2).
However, you probably want to use the
**lseek**(2)
wrapper function instead.

<a name="see-also"></a>

# See Also

**lseek**(2),
**open**(2),
**lseek64**(3)

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
