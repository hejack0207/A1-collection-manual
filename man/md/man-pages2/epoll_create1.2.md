# epoll_create(2) - open an epoll file descriptor

Linux, 2017-09-15

    #include <sys/epoll.h>
    
    int epoll_create(int size);
    int epoll_create1(int flags);

<a name="description"></a>

# Description

**epoll_create**()
creates a new
**epoll**(7)
instance.
Since Linux 2.6.8, the
_size_
argument is ignored, but must be greater than zero; see NOTES below.

**epoll_create**()
returns a file descriptor referring to the new epoll instance.
This file descriptor is used for all the subsequent calls to the
**epoll**
interface.
When no longer required, the file descriptor returned by
**epoll_create**()
should be closed by using
**close**(2).
When all file descriptors referring to an epoll instance have been closed,
the kernel destroys the instance
and releases the associated resources for reuse.

<a name="epoll_create1"></a>

### epoll_create1()

If
_flags_
is 0, then, other than the fact that the obsolete
_size_
argument is dropped,
**epoll_create1**()
is the same as
**epoll_create**().
The following value can be included in
_flags_
to obtain different behavior:

* **EPOLL_CLOEXEC**  
  Set the close-on-exec
  (**FD_CLOEXEC**)
  flag on the new file descriptor.
  See the description of the
  **O_CLOEXEC**
  flag in
  **open**(2)
  for reasons why this may be useful.

<a name="return-value"></a>

# Return Value

On success,
these system calls
return a nonnegative file descriptor.
On error, -1 is returned, and
_errno_
is set to indicate the error.

<a name="errors"></a>

# Errors


* **EINVAL**  
  _size_
  is not positive.
* **EINVAL**  
  (**epoll_create1**())
  Invalid value specified in
  _flags_.
* **EMFILE**  
  The per-user limit on the number of epoll instances imposed by
  _/proc/sys/fs/epoll/max_user_instances_
  was encountered.
  See
  **epoll**(7)
  for further details.
* **EMFILE**  
  The per-process limit on the number of open file descriptors has been reached.
* **ENFILE**  
  The system-wide limit on the total number of open files has been reached.
* **ENOMEM**  
  There was insufficient memory to create the kernel object.

<a name="versions"></a>

# Versions

**epoll_create**()
was added to the kernel in version 2.6.
Library support is provided in glibc starting with version 2.3.2.



**epoll_create1**()
was added to the kernel in version 2.6.27.
Library support is provided in glibc starting with version 2.9.

<a name="conforming-to"></a>

# Conforming to

**epoll_create**()
is Linux-specific.

<a name="notes"></a>

# Notes

In the initial
**epoll_create**()
implementation, the
_size_
argument informed the kernel of the number of file descriptors
that the caller expected to add to the
**epoll**
instance.
The kernel used this information as a hint for the amount of
space to initially allocate in internal data structures describing events.
(If necessary, the kernel would allocate more space
if the caller's usage exceeded the hint given in
_size_.)
Nowadays,
this hint is no longer required
(the kernel dynamically sizes the required data structures
without needing the hint), but
_size_
must still be greater than zero,
in order to ensure backward compatibility when new
**epoll**
applications are run on older kernels.

<a name="see-also"></a>

# See Also

**close**(2),
**epoll_ctl**(2),
**epoll_wait**(2),
**epoll**(7)

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
