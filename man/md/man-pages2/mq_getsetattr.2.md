# mq_getsetattr(2) - get/set message queue attributes

Linux, 2017-09-15

    #include <sys/types.h>
    #include <mqueue.h>
    
    int mq_getsetattr(mqd_t mqdes, struct mq_attr *newattr,
                     struct mq_attr *oldattr);
```

 Note: There is no glibc wrapper for this system call; see NOTES.
```

<a name="description"></a>

# Description

Do not use this system call.

This is the low-level system call used to implement
**mq_getattr**(3)
and
**mq_setattr**(3).
For an explanation of how this system call operates,
see the description of
**mq_setattr**(3).

<a name="conforming-to"></a>

# Conforming to

This interface is nonstandard; avoid its use.

<a name="notes"></a>

# Notes

Glibc does not provide a wrapper for this system call; call it using
**syscall**(2).
(Actually, never call it unless you are writing a C library!)

<a name="see-also"></a>

# See Also

**mq_getattr**(3),
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
