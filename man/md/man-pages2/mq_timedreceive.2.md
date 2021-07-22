# mq_receive(3) - receive a message from a message queue

Linux, 2017-09-15

    #include <mqueue.h>
    
    ssize_t mq_receive(mqd_t mqdes, char *msg_ptr,
                       size_t msg_len, unsigned int *msg_prio);
    
    #include <time.h>
    #include <mqueue.h>
    
    ssize_t mq_timedreceive(mqd_t mqdes, char *msg_ptr,
                       size_t msg_len, unsigned int *msg_prio,
                       const struct timespec *abs_timeout);
```

 Link with -lrt. 
 .in -4n Feature Test Macro Requirements for glibc (see feature_test_macros(7)): .in 
 mq_timedreceive(): .RS 4 _POSIX_C_SOURCE&nbsp;>=&nbsp;200112L .RE
```

<a name="description"></a>

# Description

**mq_receive**()
removes the oldest message with the highest priority from
the message queue referred to by the message queue descriptor
_mqdes_,
and places it in the buffer pointed to by
_msg_ptr_.
The
_msg_len_
argument specifies the size of the buffer pointed to by
_msg_ptr_;
this must be greater than or equal to the
_mq_msgsize_
attribute of the queue (see
**mq_getattr**(3)).
If
_msg_prio_
is not NULL, then the buffer to which it points is used
to return the priority associated with the received message.

If the queue is empty, then, by default,
**mq_receive**()
blocks until a message becomes available,
or the call is interrupted by a signal handler.
If the
**O_NONBLOCK**
flag is enabled for the message queue description,
then the call instead fails immediately with the error
**EAGAIN**.

**mq_timedreceive**()
behaves just like
**mq_receive**(),
except that if the queue is empty and the
**O_NONBLOCK**
flag is not enabled for the message queue description, then
_abs_timeout_
points to a structure which specifies how long the call will block.
This value is an absolute timeout in seconds and nanoseconds
since the Epoch, 1970-01-01 00:00:00 +0000 (UTC),
specified in the following structure:

.in +4n
.EX
struct timespec {
    time_t tv_sec;        /* seconds */
    long   tv_nsec;       /* nanoseconds */
};
.EE
.in

If no message is available,
and the timeout has already expired by the time of the call,
**mq_timedreceive**()
returns immediately.

<a name="return-value"></a>

# Return Value

On success,
**mq_receive**()
and
**mq_timedreceive**()
return the number of bytes in the received message;
on error, -1 is returned, with
_errno_
set to indicate the error.

<a name="errors"></a>

# Errors


* **EAGAIN**  
  The queue was empty, and the
  **O_NONBLOCK**
  flag was set for the message queue description referred to by
  _mqdes_.
* **EBADF**  
  The descriptor specified in
  _mqdes_
  was invalid or not opened for reading.
* **EINTR**  
  The call was interrupted by a signal handler; see
  **signal**(7).
* **EINVAL**  
  The call would have blocked, and
  _abs_timeout_
  was invalid, either because
  _tv_sec_
  was less than zero, or because
  _tv_nsec_
  was less than zero or greater than 1000 million.
* **EMSGSIZE**  
  _msg_len_
  was less than the
  _mq_msgsize_
  attribute of the message queue.
* **ETIMEDOUT**  
  The call timed out before a message could be transferred.

<a name="attributes"></a>

# Attributes

For an explanation of the terms used in this section, see
**attributes**(7).
.TS
allbox;
lbw31 lb lb
l l l.
Interface	Attribute	Value
T{
**mq_receive**(),
**mq_timedreceive**()
T}	Thread safety	MT-Safe
.TE

<a name="conforming-to"></a>

# Conforming to

POSIX.1-2001, POSIX.1-2008.

<a name="notes"></a>

# Notes

On Linux,
**mq_timedreceive**()
is a system call, and
**mq_receive**()
is a library function layered on top of that system call.

<a name="see-also"></a>

# See Also

**mq_close**(3),
**mq_getattr**(3),
**mq_notify**(3),
**mq_open**(3),
**mq_send**(3),
**mq_unlink**(3),
**mq_overview**(7),
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
