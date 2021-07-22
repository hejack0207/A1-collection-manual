# mq_unlink(3) - remove a message queue

Linux, 2015-08-08

    #include <mqueue.h>
    
    int mq_unlink(const char *name);
```

 Link with -lrt.
```

<a name="description"></a>

# Description

**mq_unlink**()
removes the specified message queue
_name_.
The message queue name is removed immediately.
The queue itself is destroyed once any other processes that have
the queue open close their descriptors referring to the queue.

<a name="return-value"></a>

# Return Value

On success
**mq_unlink**()
returns 0; on error, -1 is returned, with
_errno_
set to indicate the error.

<a name="errors"></a>

# Errors


* **EACCES**  
  The caller does not have permission to unlink this message queue.
* **ENAMETOOLONG**  
  _name_
  was too long.
* **ENOENT**  
  There is no message queue with the given
  _name_.

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
**mq_unlink**()
T}	Thread safety	MT-Safe
.TE

<a name="conforming-to"></a>

# Conforming to

POSIX.1-2001, POSIX.1-2008.

<a name="see-also"></a>

# See Also

**mq_close**(3),
**mq_getattr**(3),
**mq_notify**(3),
**mq_open**(3),
**mq_receive**(3),
**mq_send**(3),
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
