# io_setup(2) - create an asynchronous I/O context

Linux, 2017-09-15

    #include <linux/aio_abi.h>          /* Defines needed types */
    
    int io_setup(unsigned nr_events, aio_context_t *ctx_idp);
```

 Note: There is no glibc wrapper for this system call; see NOTES.
```

<a name="description"></a>

# Description


The
**io_setup**()
system call
creates an asynchronous I/O context suitable for concurrently processing
_nr\_events_ operations.
The
_ctx_idp_
argument must not point to an AIO context that already exists, and must
be initialized to 0 prior to the call.
On successful creation of the AIO context, _*ctx\_idp_ is filled in
with the resulting handle.

<a name="return-value"></a>

# Return Value

On success,
**io_setup**()
returns 0.
For the failure return, see NOTES.

<a name="errors"></a>

# Errors


* **EAGAIN**  
  The specified _nr\_events_ exceeds the user's limit of available events,
  as defined in
  _/proc/sys/fs/aio-max-nr_.
* **EFAULT**  
  An invalid pointer is passed for _ctx\_idp_.
* **EINVAL**  
  _ctx\_idp_ is not initialized, or the specified _nr\_events_
  exceeds internal limits.
  _nr\_events_ should be greater than 0.
* **ENOMEM**  
  Insufficient kernel resources are available.
* **ENOSYS**  
  **io_setup**()
  is not implemented on this architecture.

<a name="versions"></a>

# Versions


The asynchronous I/O system calls first appeared in Linux 2.5.

<a name="conforming-to"></a>

# Conforming to


**io_setup**()
is Linux-specific and should not be used in programs
that are intended to be portable.

<a name="notes"></a>

# Notes

Glibc does not provide a wrapper function for this system call.
You could invoke it using
**syscall**(2).
But instead, you probably want to use the
**io_setup**()
wrapper function provided by

_libaio_.

Note that the
_libaio_
wrapper function uses a different type
(_io_context_t&nbsp;*_)


for the
_ctx_idp_
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
**io_destroy**(2),
**io_getevents**(2),
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
