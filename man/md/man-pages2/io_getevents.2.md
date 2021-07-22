# io_getevents(2) - read asynchronous I/O events from the completion queue

Linux, 2017-09-15

    #include <linux/aio_abi.h>         /* Defines needed types */
    #include <linux/time.h>            /* Defines 'struct timespec' */
    
    int io_getevents(aio_context_t ctx_id, long min_nr, long nr,
                     struct io_event *events, struct timespec *timeout);
```

 Note: There is no glibc wrapper for this system call; see NOTES.
```

<a name="description"></a>

# Description


The
**io_getevents**()
system call
attempts to read at least _min\_nr_ events and
up to _nr_ events from the completion queue of the AIO context
specified by _ctx\_id_.

The _timeout_ argument specifies the amount of time to wait for events,
and is specified as a relative timeout in a structure of the following form:

.in +4n
.EX
struct timespec {
    time_t tv_sec;      /* seconds */
    long   tv_nsec;     /* nanoseconds [0 .. 999999999] */
};
.EE
.in

The specified time will be rounded up to the system clock granularity
and is guaranteed not to expire	early.

Specifying
_timeout_
as NULL means block indefinitely until at least
_min_nr_
events have been obtained.

<a name="return-value"></a>

# Return Value

On success,
**io_getevents**()
returns the number of events read.
This may be 0, or a value less than
_min_nr_,
if the
_timeout_
expired.
It may also be a nonzero value less than
_min_nr_,
if the call was interrupted by a signal handler.

For the failure return, see NOTES.

<a name="errors"></a>

# Errors


* **EFAULT**  
  Either _events_ or _timeout_ is an invalid pointer.
* **EINTR**  
  Interrupted by a signal handler; see
  **signal**(7).
* **EINVAL**  
  _ctx\_id_ is invalid.
  _min\_nr_ is out of range or _nr_ is
  out of range.
* **ENOSYS**  
  **io_getevents**()
  is not implemented on this architecture.

<a name="versions"></a>

# Versions


The asynchronous I/O system calls first appeared in Linux 2.5.

<a name="conforming-to"></a>

# Conforming to


**io_getevents**()
is Linux-specific and should not be used in
programs that are intended to be portable.

<a name="notes"></a>

# Notes

Glibc does not provide a wrapper function for this system call.
You could invoke it using
**syscall**(2).
But instead, you probably want to use the
**io_getevents**()
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

<a name="bugs"></a>

# Bugs

An invalid
_ctx_id_
may cause a segmentation fault instead of generating the error
**EINVAL**.

<a name="see-also"></a>

# See Also


**io_cancel**(2),
**io_destroy**(2),
**io_setup**(2),
**io_submit**(2),
**aio**(7),
**time**(7)



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
