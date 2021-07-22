# io_cancel(2) - cancel an outstanding asynchronous I/O operation

Linux, 2017-09-15

    #include <linux/aio_abi.h>          /* Defines needed types */
    
    int io_cancel(aio_context_t ctx_id, struct iocb *iocb,
                  struct io_event *result);
```

 Note: There is no glibc wrapper for this system call; see NOTES.
```

<a name="description"></a>

# Description


The
**io_cancel**()
system call
attempts to cancel an asynchronous I/O operation previously submitted with
**io_submit**(2).
The
_iocb_
argument describes the operation to be canceled and the
_ctx_id_
argument is the AIO context to which the operation was submitted.
If the operation is successfully canceled, the event will be copied into
the memory pointed to by
_result_
without being placed into the
completion queue.

<a name="return-value"></a>

# Return Value

On success,
**io_cancel**()
returns 0.
For the failure return, see NOTES.

<a name="errors"></a>

# Errors


* **EAGAIN**  
  The _iocb_ specified was not canceled.
* **EFAULT**  
  One of the data structures points to invalid data.
* **EINVAL**  
  The AIO context specified by _ctx\_id_ is invalid.
* **ENOSYS**  
  **io_cancel**()
  is not implemented on this architecture.

<a name="versions"></a>

# Versions


The asynchronous I/O system calls first appeared in Linux 2.5.

<a name="conforming-to"></a>

# Conforming to


**io_cancel**()
is Linux-specific and should not be used
in programs that are intended to be portable.

<a name="notes"></a>

# Notes

Glibc does not provide a wrapper function for this system call.
You could invoke it using
**syscall**(2).
But instead, you probably want to use the
**io_cancel**()
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

**io_destroy**(2),
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
