# mq_open(3) - open a message queue

Linux, 2017-09-15

    #include <fcntl.h>           /* For O_* constants */
    #include <sys/stat.h>        /* For mode constants */
    #include <mqueue.h>
    
    mqd_t mq_open(const char *name, int oflag);
    mqd_t mq_open(const char *name, int oflag, mode_t mode,
                  struct mq_attr *attr);
```

 Link with -lrt.
```

<a name="description"></a>

# Description

**mq_open**()
creates a new POSIX message queue or opens an existing queue.
The queue is identified by
_name_.
For details of the construction of
_name_,
see
**mq_overview**(7).

The
_oflag_
argument specifies flags that control the operation of the call.
(Definitions of the flags values can be obtained by including
_&lt;fcntl.h&gt;_.)
Exactly one of the following must be specified in
_oflag_:

* **O_RDONLY**  
  Open the queue to receive messages only.
* **O_WRONLY**  
  Open the queue to send messages only.
* **O_RDWR**  
  Open the queue to both send and receive messages.

Zero or more of the following flags can additionally be
_OR_ed
in
_oflag_:

* **O_CLOEXEC** (since Linux 2.6.26)  
  
  Set the close-on-exec flag for the message queue descriptor.
  See
  **open**(2)
  for a discussion of why this flag is useful.
* **O_CREAT**  
  Create the message queue if it does not exist.
  The owner (user ID) of the message queue is set to the effective
  user ID of the calling process.
  The group ownership (group ID) is set to the effective group ID
  of the calling process.
  
* **O_EXCL**  
  If
  **O_CREAT**
  was specified in
  _oflag_,
  and a queue with the given
  _name_
  already exists, then fail with the error
  **EEXIST**.
* **O_NONBLOCK**  
  Open the queue in nonblocking mode.
  In circumstances where
  **mq_receive**(3)
  and
  **mq_send**(3)
  would normally block, these functions instead fail with the error
  **EAGAIN**.

If
**O_CREAT**
is specified in
_oflag_,
then two additional arguments must be supplied.
The
_mode_
argument specifies the permissions to be placed on the new queue,
as for
**open**(2).
(Symbolic definitions for the permissions bits can be obtained by including
_&lt;sys/stat.h&gt;_.)
The permissions settings are masked against the process umask.

The fields of the
_struct mq_attr_
pointed to
_attr_
specify the maximum number of messages and
the maximum size of messages that the queue will allow.
This structure is defined as follows:


.in +4n
.EX
struct mq_attr {
    long mq_flags;       /* Flags (ignored for mq_open()) */
    long mq_maxmsg;      /* Max. # of messages on queue */
    long mq_msgsize;     /* Max. message size (bytes) */
    long mq_curmsgs;     /* # of messages currently in queue
                            (ignored for mq_open()) */
};
.EE
.in

Only the
_mq_maxmsg_
and
_mq_msgsize_
fields are employed when calling
**mq_open**();
the values in the remaining fields are ignored.

If
_attr_
is NULL, then the queue is created with implementation-defined
default attributes.
Since Linux 3.5, two
_/proc_
files can be used to control these defaults; see
**mq_overview**(7)
for details.

<a name="return-value"></a>

# Return Value

On success,
**mq_open**()
returns a message queue descriptor for use by other
message queue functions.
On error,
**mq_open**()
returns
_(mqd_t)&nbsp;-1_,
with
_errno_
set to indicate the error.

<a name="errors"></a>

# Errors


* **EACCES**  
  The queue exists, but the caller does not have permission to
  open it in the specified mode.
* **EACCES**  
  _name_
  contained more than one slash.
  
* **EEXIST**  
  Both
  **O_CREAT**
  and
  **O_EXCL**
  were specified in
  _oflag_,
  but a queue with this
  _name_
  already exists.
* **EINVAL**  
  
  
  _name_
  doesn't follow the format in
  **mq_overview**(7).
* **EINVAL**  
  **O_CREAT**
  was specified in
  _oflag_,
  and
  _attr_
  was not NULL, but
  _attr-&gt;mq_maxmsg_
  or
  _attr-&gt;mq_msqsize_
  was invalid.
  Both of these fields must be greater than zero.
  In a process that is unprivileged (does not have the
  **CAP_SYS_RESOURCE**
  capability),
  _attr-&gt;mq_maxmsg_
  must be less than or equal to the
  _msg_max_
  limit, and
  _attr-&gt;mq_msgsize_
  must be less than or equal to the
  _msgsize_max_
  limit.
  In addition, even in a privileged process,
  _attr-&gt;mq_maxmsg_
  cannot exceed the
  **HARD_MAX**
  limit.
  (See
  **mq_overview**(7)
  for details of these limits.)
* **EMFILE**  
  The per-process limit on the number of open file
  and message queue descriptors has been reached
  (see the description of
  **RLIMIT_NOFILE**
  in
  **getrlimit**(2)).
* **ENAMETOOLONG**  
  _name_
  was too long.
* **ENFILE**  
  The system-wide limit on the total number of open files
  and message queues has been reached.
* **ENOENT**  
  The
  **O_CREAT**
  flag was not specified in
  _oflag_,
  and no queue with this
  _name_
  exists.
* **ENOENT**  
  _name_
  was just "/" followed by no other characters.
  
* **ENOMEM**  
  Insufficient memory.
* **ENOSPC**  
  Insufficient space for the creation of a new message queue.
  This probably occurred because the
  _queues_max_
  limit was encountered; see
  **mq_overview**(7).

<a name="attributes"></a>

# Attributes

For an explanation of the terms used in this section, see
**attributes**(7).
.TS
allbox;
lb lb lb
l l l.
Interface	Attribute	Value
T{
**mq_open**()
T}	Thread safety	MT-Safe
.TE

<a name="conforming-to"></a>

# Conforming to

POSIX.1-2001, POSIX.1-2008.

<a name="notes"></a>

# Notes


<a name="c-librarykernel-differences"></a>

### C library/kernel differences

The
**mq_open**()
library function is implemented on top of a system call of the same name.
The library function performs the check that the
_name_
starts with a slash (/), giving the
**EINVAL**
error if it does not.
The kernel system call expects
_name_
to contain no preceding slash,
so the C library function passes
_name_
without the preceding slash (i.e.,
_name+1_)
to the system call.

<a name="bugs"></a>

# Bugs

In kernels before 2.6.14,
the process umask was not applied to the permissions specified in
_mode_.

<a name="see-also"></a>

# See Also

**mq_close**(3),
**mq_getattr**(3),
**mq_notify**(3),
**mq_receive**(3),
**mq_send**(3),
**mq_unlink**(3),
**mq_overview**(7)

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
