# dup(2) - duplicate a file descriptor

Linux, 2017-09-15

    #include <unistd.h>
    
    int dup(int oldfd);
    int dup2(int oldfd, int newfd);
    
    #define _GNU_SOURCE             /* See feature_test_macros(7) */
    #include <fcntl.h>/*ObtainO_*constantdefinitions*/
    #include <unistd.h>
    
    int dup3(int oldfd, int newfd, int flags);

<a name="description"></a>

# Description

The
**dup**()
system call creates a copy of the file descriptor
_oldfd_,
using the lowest-numbered unused file descriptor for the new descriptor.

After a successful return,
the old and new file descriptors may be used interchangeably.
They refer to the same open file description (see
**open**(2))
and thus share file offset and file status flags;
for example, if the file offset is modified by using
**lseek**(2)
on one of the file descriptors, the offset is also changed for the other.

The two file descriptors do not share file descriptor flags
(the close-on-exec flag).
The close-on-exec flag
(**FD_CLOEXEC**;
see
**fcntl**(2))
for the duplicate descriptor is off.


<a name="dup2"></a>

### dup2()

The
**dup2**()
system call performs the same task as
**dup**(),
but instead of using the lowest-numbered unused file descriptor,
it uses the file descriptor number specified in
_newfd_.
If the file descriptor
_newfd_
was previously open, it is silently closed before being reused.

The steps of closing and reusing the file descriptor
_newfd_
are performed
_atomically_.
This is important, because trying to implement equivalent functionality using
**close**(2)
and
**dup**()
would be
subject to race conditions, whereby
_newfd_
might be reused between the two steps.
Such reuse could happen because the main program is interrupted
by a signal handler that allocates a file descriptor,
or because a parallel thread allocates a file descriptor.

Note the following points:

* *  
  If
  _oldfd_
  is not a valid file descriptor, then the call fails, and
  _newfd_
  is not closed.
* *  
  If
  _oldfd_
  is a valid file descriptor, and
  _newfd_
  has the same value as
  _oldfd_,
  then
  **dup2**()
  does nothing, and returns
  _newfd_.
  

<a name="dup3"></a>

### dup3()

**dup3**()
is the same as
**dup2**(),
except that:

* *  
  The caller can force the close-on-exec flag to be set
  for the new file descriptor by specifying
  **O_CLOEXEC**
  in
  _flags_.
  See the description of the same flag in
  **open**(2)
  for reasons why this may be useful.
* *  
  
  
  
  If
  _oldfd_
  equals
  _newfd_,
  then
  **dup3**()
  fails with the error
  **EINVAL**.

<a name="return-value"></a>

# Return Value

On success, these system calls
return the new file descriptor.
On error, -1 is returned, and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors


* **EBADF**  
  _oldfd_
  isn't an open file descriptor.
* **EBADF**  
  _newfd_
  is out of the allowed range for file descriptors (see the discussion of
  **RLIMIT_NOFILE**
  in
  **getrlimit**(2)).
* **EBUSY**  
  (Linux only) This may be returned by
  **dup2**()
  or
  **dup3**()
  during a race condition with
  **open**(2)
  and
  **dup**().
* **EINTR**  
  The
  **dup2**()
  or
  **dup3**()
  call was interrupted by a signal; see
  **signal**(7).
* **EINVAL**  
  (**dup3**())
  _flags_
  contain an invalid value.
* **EINVAL**  
  (**dup3**())
  _oldfd_
  was equal to
  _newfd_.
* **EMFILE**  
  The per-process limit on the number of open file descriptors has been reached
  (see the discussion of
  **RLIMIT_NOFILE**
  in
  **getrlimit**(2)).

<a name="versions"></a>

# Versions

**dup3**()
was added to Linux in version 2.6.27;
glibc support is available starting with
version 2.9.

<a name="conforming-to"></a>

# Conforming to

**dup**(),
**dup2**():
POSIX.1-2001, POSIX.1-2008, SVr4, 4.3BSD.

**dup3**()
is Linux-specific.




<a name="notes"></a>

# Notes

The error returned by
**dup2**()
is different from that returned by
**fcntl(**..., **F_DUPFD**, ...**)**
when
_newfd_
is out of range.
On some systems,
**dup2**()
also sometimes returns
**EINVAL**
like
**F_DUPFD**.

If
_newfd_
was open, any errors that would have been reported at
**close**(2)
time are lost.
If this is of concern,
then—unless the program is single-threaded and does not allocate
file descriptors in signal handlers—the correct approach is
_not_
to close
_newfd_
before calling
**dup2**(),
because of the race condition described above.
Instead, code something like the following could be used:

.EX
    /* Obtain a duplicate of 'newfd' that can subsequently
       be used to check for close() errors; an EBADF error
       means that 'newfd' was not open. */

    tmpfd = dup(newfd);
    if (tmpfd == -1 && errno != EBADF) {
        /* Handle unexpected dup() error */
    }

    /* Atomically duplicate 'oldfd' on 'newfd' */

    if (dup2(oldfd, newfd) == -1) {
        /* Handle dup2() error */
    }

    /* Now check for close() errors on the file originally
       referred to by 'newfd' */

    if (tmpfd != -1) {
        if (close(tmpfd) == -1) {
            /* Handle errors from close */
        }
    }
.EE

<a name="see-also"></a>

# See Also

**close**(2),
**fcntl**(2),
**open**(2)

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
