# exit_group(2) - exit all threads in a process

Linux, 2008-11-27

    #include <linux/unistd.h>
    
    void exit_group(int status);

<a name="description"></a>

# Description

This system call is equivalent to
**_exit**(2)
except that it terminates not only the calling thread, but all threads
in the calling process's thread group.

<a name="return-value"></a>

# Return Value

This system call does not return.

<a name="versions"></a>

# Versions

This call is present since Linux 2.5.35.

<a name="conforming-to"></a>

# Conforming to

This call is Linux-specific.

<a name="notes"></a>

# Notes

Since glibc 2.3, this is the system call invoked when the
**_exit**(2)
wrapper function is called.

<a name="see-also"></a>

# See Also

**exit**(2)

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
