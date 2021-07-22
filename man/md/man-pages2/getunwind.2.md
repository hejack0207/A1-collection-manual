# getunwind(2) - copy the unwind data to caller's buffer

Linux, 2017-09-15

    #include <syscall.h>
    #include <linux/unwind.h>
    
    long getunwind(void *buf, size_t buf_size);
```

 Note: There is no glibc wrapper for this system call; see NOTES.
```

<a name="description"></a>

# Description

_Note: this function is obsolete._

The
IA-64-specific
**getunwind**()
system call copies the kernel's call frame
unwind data into the buffer pointed to by
_buf_
and returns the size of the unwind data;
this data describes the gate page (kernel code that
is mapped into user space).

The size of the buffer
_buf_
is specified in
_buf_size_.
The data is copied only if
_buf_size_
is greater than or equal to the size of the unwind data and
_buf_
is not NULL;
otherwise, no data is copied, and the call succeeds,
returning the size that would be needed to store the unwind data.

The first part of the unwind data contains an unwind table.
The rest contains the associated unwind information, in no particular order.
The unwind table contains entries of the following form:

.in +4n
.EX
u64 start;      (64-bit address of start of function)
u64 end;        (64-bit address of end of function)
u64 info;       (BUF-relative offset to unwind info)
.EE
.in

An entry whose
_start_
value is zero indicates the end of the table.
For more information about the format, see the
_IA-64 Software Conventions and Runtime Architecture_
manual.

<a name="return-value"></a>

# Return Value

On success,
**getunwind**()
returns the size of the unwind data.
On error, -1 is returned and
_errno_
is set to indicate the error.

<a name="errors"></a>

# Errors

**getunwind**()
fails with the error
**EFAULT**
if the unwind info can't be stored in the space specified by
_buf_.

<a name="versions"></a>

# Versions

This system call is available since Linux 2.4.

<a name="conforming-to"></a>

# Conforming to

This system call is Linux-specific,
and is available only on the IA-64 architecture.

<a name="notes"></a>

# Notes

This system call has been deprecated.
The modern way to obtain the kernel's unwind data is via the
**vdso**(7).

Glibc does not provide a wrapper for this system call;
in the unlikely event that you want to call it, use
**syscall**(2).

<a name="see-also"></a>

# See Also

**getauxval**(3)

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
