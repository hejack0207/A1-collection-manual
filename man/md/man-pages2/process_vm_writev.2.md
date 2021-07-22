# process_vm_readv(2) - transfer data between process address spaces

Linux, 2017-09-15

    #include <sys/uio.h>
    
    ssize_t process_vm_readv(pid_t pid,
                             const struct iovec *local_iov,
                             unsigned long liovcnt,
                             const struct iovec *remote_iov,
                             unsigned long riovcnt,
                             unsigned long flags);
    
    ssize_t process_vm_writev(pid_t pid,
                              const struct iovec *local_iov,
                              unsigned long liovcnt,
                              const struct iovec *remote_iov,
                              unsigned long riovcnt,
                              unsigned long flags);
```

 .in -4n Feature Test Macro Requirements for glibc (see feature_test_macros(7)): .in 
 process_vm_readv(), process_vm_writev(): .RS 4 _GNU_SOURCE .RE
```

<a name="description"></a>

# Description

These system calls transfer data between the address space
of the calling process ("the local process") and the process identified by
_pid_
("the remote process").
The data moves directly between the address spaces of the two processes,
without passing through kernel space.

The
**process_vm_readv**()
system call transfers data from the remote process to the local process.
The data to be transferred is identified by
_remote_iov_
and
_riovcnt_:
_remote_iov_
is a pointer to an array describing address ranges in the process
_pid_,
and
_riovcnt_
specifies the number of elements in
_remote_iov_.
The data is transferred to the locations specified by
_local_iov_
and
_liovcnt_:
_local_iov_
is a pointer to an array describing address ranges in the calling process,
and
_liovcnt_
specifies the number of elements in
_local_iov_.

The
**process_vm_writev**()
system call is the converse of
**process_vm_readv**()—it
transfers data from the local process to the remote process.
Other than the direction of the transfer, the arguments
_liovcnt_,
_local_iov_,
_riovcnt_,
and
_remote_iov_
have the same meaning as for
**process_vm_readv**().

The
_local_iov_
and
_remote_iov_
arguments point to an array of
_iovec_
structures, defined in
_&lt;sys/uio.h&gt;_
as:

.in +4n
.EX
struct iovec {
    void  *iov_base;    /* Starting address */
    size_t iov_len;     /* Number of bytes to transfer */
};
.EE
.in

Buffers are processed in array order.
This means that
**process_vm_readv**()
completely fills
_local_iov[0]_
before proceeding to
_local_iov[1]_,
and so on.
Likewise,
_remote_iov[0]_
is completely read before proceeding to
_remote_iov[1]_,
and so on.

Similarly,
**process_vm_writev**()
writes out the entire contents of
_local_iov[0]_
before proceeding to
_local_iov[1]_,
and it completely fills
_remote_iov[0]_
before proceeding to
_remote_iov[1]_.

The lengths of
_remote_iov[i].iov_len_
and
_local_iov[i].iov_len_
do not have to be the same.
Thus, it is possible to split a single local buffer
into multiple remote buffers, or vice versa.

The
_flags_
argument is currently unused and must be set to 0.

The values specified in the
_liovcnt_
and
_riovcnt_
arguments must be less than or equal to
**IOV_MAX**
(defined in
_&lt;limits.h&gt;_
or accessible via the call
_sysconf(_SC_IOV_MAX)_).



The count arguments and
_local_iov_
are checked before doing any transfers.
If the counts are too big, or
_local_iov_
is invalid,
or the addresses refer to regions that are inaccessible to the local process,
none of the vectors will be processed
and an error will be returned immediately.

Note, however, that these system calls do not check the memory regions
in the remote process until just before doing the read/write.
Consequently, a partial read/write (see RETURN VALUE)
may result if one of the
_remote_iov_
elements points to an invalid memory region in the remote process.
No further reads/writes will be attempted beyond that point.
Keep this in mind when attempting to read data of unknown length
(such as C strings that are null-terminated) from a remote process,
by avoiding spanning memory pages (typically 4&nbsp;KiB) in a single remote
_iovec_
element.
(Instead, split the remote read into two
_remote_iov_
elements and have them merge back into a single write
_local_iov_
entry.
The first read entry goes up to the page boundary,
while the second starts on the next page boundary.)

Permission to read from or write to another process
is governed by a ptrace access mode
**PTRACE_MODE_ATTACH_REALCREDS**
check; see
**ptrace**(2).

<a name="return-value"></a>

# Return Value

On success,
**process_vm_readv**()
returns the number of bytes read and
**process_vm_writev**()
returns the number of bytes written.
This return value may be less than the total number of requested bytes,
if a partial read/write occurred.
(Partial transfers apply at the granularity of
_iovec_
elements.
These system calls won't perform a partial transfer that splits a single
_iovec_
element.)
The caller should check the return value to determine whether
a partial read/write occurred.

On error, -1 is returned and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors


* **EFAULT**  
  The memory described by
  _local_iov_
  is outside the caller's accessible address space.
* **EFAULT**  
  The memory described by
  _remote_iov_
  is outside the accessible address space of the process
  _pid_.
* **EINVAL**  
  The sum of the
  _iov_len_
  values of either
  _local_iov_
  or
  _remote_iov_
  overflows a
  _ssize_t_
  value.
* **EINVAL**  
  _flags_
  is not 0.
* **EINVAL**  
  _liovcnt_
  or
  _riovcnt_
  is too large.
* **ENOMEM**  
  Could not allocate memory for internal copies of the
  _iovec_
  structures.
* **EPERM**  
  The caller does not have permission to access the address space of the process
  _pid_.
* **ESRCH**  
  No process with ID
  _pid_
  exists.

<a name="versions"></a>

# Versions

These system calls were added in Linux 3.2.
Support is provided in glibc since version 2.15.

<a name="conforming-to"></a>

# Conforming to

These system calls are nonstandard Linux extensions.

<a name="notes"></a>

# Notes

The data transfers performed by
**process_vm_readv**()
and
**process_vm_writev**()
are not guaranteed to be atomic in any way.

These system calls were designed to permit fast message passing
by allowing messages to be exchanged with a single copy operation
(rather than the double copy that would be required
when using, for example, shared memory or pipes).




<a name="example"></a>

# Example

The following code sample demonstrates the use of
**process_vm_readv**().
It reads 20 bytes at the address 0x10000 from the process with PID 10
and writes the first 10 bytes into
_buf1_
and the second 10 bytes into
_buf2_.

.EX
#include &lt;sys/uio.h&gt;

int
main(void)
{
    struct iovec local[2];
    struct iovec remote[1];
    char buf1[10];
    char buf2[10];
    ssize_t nread;
    pid_t pid = 10;             /* PID of remote process */

    local[0].iov_base = buf1;
    local[0].iov_len = 10;
    local[1].iov_base = buf2;
    local[1].iov_len = 10;
    remote[0].iov_base = (void *) 0x10000;
    remote[0].iov_len = 20;

    nread = process_vm_readv(pid, local, 2, remote, 1, 0);
    if (nread != 20)
        return 1;
    else
        return 0;
}
.EE

<a name="see-also"></a>

# See Also

**readv**(2),
**writev**(2)

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
