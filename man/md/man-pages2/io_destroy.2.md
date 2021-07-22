# io_destroy(2) - destroy an asynchronous I/O context

Linux, 2017-09-15

    #include <linux/aio_abi.h>          /* Defines needed types */
    
    int io_destroy(aio_context_t ctx_id);
```

 Note: There is no glibc wrapper for this system call; see NOTES.
```

<a name="description"></a>

# Description


The
**io_destroy**()
system call
will attempt to cancel all outstanding asynchronous I/O operations against
_ctx_id_,
will block on the completion of all operations
that could not be canceled, and will destroy the
_ctx_id_.

<a name="return-value"></a>

# Return Value

On success,
**io_destroy**()
returns 0.
For the failure return, see NOTES.

<a name="errors"></a>

# Errors


* **EFAULT**  
  The context pointed to is invalid.
* **EINVAL**  
  The AIO context specified by _ctx\_id_ is invalid.
* **ENOSYS**  
  **io_destroy**()
  is not implemented on this architecture.

<a name="versions"></a>

# Versions


The asynchronous I/O system calls first appeared in Linux 2.5.

<a name="conforming-to"></a>

# Conforming to


**io_destroy**()
is Linux-specific and should not be used in programs
that are intended to be portable.

<a name="notes"></a>

# Notes

Glibc does not provide a wrapper function for this system call.
You could invoke it using
**syscall**(2).
But instead, you probably want to use the
**io_destroy**()
wrapper function provided by

_libaio_.

Note that the
_libaio_
wrapper function uses a different type
(_io_context_t_)


for the
_ctx_id_
argument.
Note also that the
_libaio_
wrapper does not follow the usual C library conventions for indicating errors:
on error it returns a negated error number
(the negative of one of the values listed in ERRORS).
If the system call is invoked via
**syscall**(2),
then the return value follows the usual conventions for
indicating an error: -1, with
_errno_
set to a (positive) value that indicates the error.

<a name="see-also"></a>

# See Also

**io_cancel**(2),
**io_getevents**(2),
**io_setup**(2),
**io_submit**(2),
**aio**(7)



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
