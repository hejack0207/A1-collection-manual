# ioctl_userfaultfd(2) - create a file descriptor for handling page faults in user

Linux, 2017-09-15

space

<a name="synopsis"></a>

# Synopsis

    #include <sys/ioctl.h>
    
    int ioctl(int fd, int cmd, ...);

<a name="description"></a>

# Description

Various
**ioctl**(2)
operations can be performed on a userfaultfd object (created by a call to
**userfaultfd**(2))
using calls of the form:

.in +4n
.EX
ioctl(fd, cmd, argp);
.EE
.in
In the above,
_fd_
is a file descriptor referring to a userfaultfd object,
_cmd_
is one of the commands listed below, and
_argp_
is a pointer to a data structure that is specific to
_cmd_.

The various
**ioctl**(2)
operations are described below.
The
**UFFDIO_API,**
**UFFDIO_REGISTER**,
and
**UFFDIO_UNREGISTER**
operations are used to
_configure_
userfaultfd behavior.
These operations allow the caller to choose what features will be enabled and
what kinds of events will be delivered to the application.
The remaining operations are
_range_
operations.
These operations enable the calling application to resolve page-fault
events.


<a name="uffdio_api"></a>

### UFFDIO_API

(Since Linux 4.3.)
Enable operation of the userfaultfd and perform API handshake.

The
_argp_
argument is a pointer to a
_uffdio_api_
structure, defined as:

.in +4n
.EX
struct uffdio_api {
    __u64 api;        /* Requested API version (input) */
    __u64 features;   /* Requested features (input/output) */
    __u64 ioctls;     /* Available ioctl() operations (output) */
};
.EE
.in

The
_api_
field denotes the API version requested by the application.

The kernel verifies that it can support the requested API version,
and sets the
_features_
and
_ioctls_
fields to bit masks representing all the available features and the generic
**ioctl**(2)
operations available.

For Linux kernel versions before 4.11, the
_features_
field must be initialized to zero before the call to
_UFFDIO_API_,
and zero (i.e., no feature bits) is placed in the
_features_
field by the kernel upon return from
**ioctl**(2).

Starting from Linux 4.11, the
_features_
field can be used to ask whether particular features are supported
and explicitly enable userfaultfd features that are disabled by default.
The kernel always reports all the available features in the
_features_
field.

To enable userfaultfd features the application should set
a bit corresponding to each feature it wants to enable in the
_features_
field.
If the kernel supports all the requested features it will enable them.
Otherwise it will zero out the returned
_uffdio_api_
structure and return
**EINVAL**.


The following feature bits may be set:

* **UFFD_FEATURE_EVENT_FORK** (since Linux 4.11)  
  When this feature is enabled,
  the userfaultfd objects associated with a parent process are duplicated
  into the child process during
  **fork**(2)
  and a
  **UFFD_EVENT_FORK**
  event is delivered to the userfaultfd monitor
* **UFFD_FEATURE_EVENT_REMAP** (since Linux 4.11)  
  If this feature is enabled,
  when the faulting process invokes
  **mremap**(2),
  the userfaultfd monitor will receive an event of type
  **UFFD_EVENT_REMAP**.
* **UFFD_FEATURE_EVENT_REMOVE** (since Linux 4.11)  
  If this feature is enabled,
  when the faulting process calls
  **madvise**(2)
  with the
  **MADV_DONTNEED**
  or
  **MADV_REMOVE**
  advice value to free a virtual memory area
  the userfaultfd monitor will receive an event of type
  **UFFD_EVENT_REMOVE**.
* **UFFD_FEATURE_EVENT_UNMAP** (since Linux 4.11)  
  If this feature is enabled,
  when the faulting process unmaps virtual memory either explicitly with
  **munmap**(2),
  or implicitly during either
  **mmap**(2)
  or
  **mremap**(2).
  the userfaultfd monitor will receive an event of type
  **UFFD_EVENT_UNMAP**.
* **UFFD_FEATURE_MISSING_HUGETLBFS** (since Linux 4.11)  
  If this feature bit is set,
  the kernel supports registering userfaultfd ranges on hugetlbfs
  virtual memory areas
* **UFFD_FEATURE_MISSING_SHMEM** (since Linux 4.11)  
  If this feature bit is set,
  the kernel supports registering userfaultfd ranges on shared memory areas.
  This includes all kernel shared memory APIs:
  System V shared memory,
  **tmpfs**(5),
  shared mappings of
  _/dev/zero_,
  **mmap**(2)
  with the
  **MAP_SHARED**
  flag set,
  **memfd_create**(2),
  and so on.
* **UFFD_FEATURE_SIGBUS** (since Linux 4.14)  
  
  If this feature bit is set, no page-fault events
  (**UFFD_EVENT_PAGEFAULT**)
  will be delivered.
  Instead, a
  **SIGBUS**
  signal will be sent to the faulting process.
  Applications using this
  feature will not require the use of a userfaultfd monitor for processing
  memory accesses to the regions registered with userfaultfd.

The returned
_ioctls_
field can contain the following bits:



* **1 &lt;&lt; _UFFDIO_API**  
  The
  **UFFDIO_API**
  operation is supported.
* **1 &lt;&lt; _UFFDIO_REGISTER**  
  The
  **UFFDIO_REGISTER**
  operation is supported.
* **1 &lt;&lt; _UFFDIO_UNREGISTER**  
  The
  **UFFDIO_UNREGISTER**
  operation is supported.

This
**ioctl**(2)
operation returns 0 on success.
On error, -1 is returned and
_errno_
is set to indicate the cause of the error.
Possible errors include:

* **EFAULT**  
  _argp_
  refers to an address that is outside the calling process's
  accessible address space.
* **EINVAL**  
  The userfaultfd has already been enabled by a previous
  **UFFDIO_API**
  operation.
* **EINVAL**  
  The API version requested in the
  _api_
  field is not supported by this kernel, or the
  _features_
  field passed to the kernel includes feature bits that are not supported
  by the current kernel version.
  
  
  
  
  
  
  
  

<a name="uffdio_register"></a>

### UFFDIO_REGISTER

(Since Linux 4.3.)
Register a memory address range with the userfaultfd object.
The pages in the range must be "compatible".

Up to Linux kernel 4.11,
only private anonymous ranges are compatible for registering with
**UFFDIO_REGISTER**.

Since Linux 4.11,
hugetlbfs and shared memory ranges are also compatible with
**UFFDIO_REGISTER**.

The
_argp_
argument is a pointer to a
_uffdio_register_
structure, defined as:

.in +4n
.EX
struct uffdio_range {
    __u64 start;    /* Start of range */
    __u64 len;      /* Length of range (bytes) */
};

struct uffdio_register {
    struct uffdio_range range;
    __u64 mode;     /* Desired mode of operation (input) */
    __u64 ioctls;   /* Available ioctl() operations (output) */
};
.EE
.in

The
_range_
field defines a memory range starting at
_start_
and continuing for
_len_
bytes that should be handled by the userfaultfd.

The
_mode_
field defines the mode of operation desired for this memory region.
The following values may be bitwise ORed to set the userfaultfd mode for
the specified range:

* **UFFDIO_REGISTER_MODE_MISSING**  
  Track page faults on missing pages.
* **UFFDIO_REGISTER_MODE_WP**  
  Track page faults on write-protected pages.

Currently, the only supported mode is
**UFFDIO_REGISTER_MODE_MISSING**.

If the operation is successful, the kernel modifies the
_ioctls_
bit-mask field to indicate which
**ioctl**(2)
operations are available for the specified range.
This returned bit mask is as for
**UFFDIO_API**.

This
**ioctl**(2)
operation returns 0 on success.
On error, -1 is returned and
_errno_
is set to indicate the cause of the error.
Possible errors include:



* **EBUSY**  
  A mapping in the specified range is registered with another
  userfaultfd object.
* **EFAULT**  
  _argp_
  refers to an address that is outside the calling process's
  accessible address space.
* **EINVAL**  
  An invalid or unsupported bit was specified in the
  _mode_
  field; or the
  _mode_
  field was zero.
* **EINVAL**  
  There is no mapping in the specified address range.
* **EINVAL**  
  _range.start_
  or
  _range.len_
  is not a multiple of the system page size; or,
  _range.len_
  is zero; or these fields are otherwise invalid.
* **EINVAL**  
  There as an incompatible mapping in the specified address range.
  
  
  

<a name="uffdio_unregister"></a>

### UFFDIO_UNREGISTER

(Since Linux 4.3.)
Unregister a memory address range from userfaultfd.
The pages in the range must be "compatible" (see the description of
**UFFDIO_REGISTER**.)

The address range to unregister is specified in the
_uffdio_range_
structure pointed to by
_argp_.

This
**ioctl**(2)
operation returns 0 on success.
On error, -1 is returned and
_errno_
is set to indicate the cause of the error.
Possible errors include:

* **EINVAL**  
  Either the
  _start_
  or the
  _len_
  field of the
  _ufdio_range_
  structure was not a multiple of the system page size; or the
  _len_
  field was zero; or these fields were otherwise invalid.
* **EINVAL**  
  There as an incompatible mapping in the specified address range.
* **EINVAL**  
  There was no mapping in the specified address range.
  

<a name="uffdio_copy"></a>

### UFFDIO_COPY

(Since Linux 4.3.)
Atomically copy a continuous memory chunk into the userfault registered
range and optionally wake up the blocked thread.
The source and destination addresses and the number of bytes to copy are
specified by the
_src_, _dst_, and _len_
fields of the
_uffdio_copy_
structure pointed to by
_argp_:

.in +4n
.EX
struct uffdio_copy {
    __u64 dst;    /* Source of copy */
    __u64 src;    /* Destination of copy */
    __u64 len;    /* Number of bytes to copy */
    __u64 mode;   /* Flags controlling behavior of copy */
    __s64 copy;   /* Number of bytes copied, or negated error */
};
.EE
.in

The following value may be bitwise ORed in
_mode_
to change the behavior of the
**UFFDIO_COPY**
operation:

* **UFFDIO_COPY_MODE_DONTWAKE**  
  Do not wake up the thread that waits for page-fault resolution

The
_copy_
field is used by the kernel to return the number of bytes
that was actually copied, or an error (a negated
_errno_-style
value).


If the value returned in
_copy_
doesn't match the value that was specified in
_len_,
the operation fails with the error
**EAGAIN**.
The
_copy_
field is output-only;
it is not read by the
**UFFDIO_COPY**
operation.

This
**ioctl**(2)
operation returns 0 on success.
In this case, the entire area was copied.
On error, -1 is returned and
_errno_
is set to indicate the cause of the error.
Possible errors include:

* **EAGAIN**  
  The number of bytes copied (i.e., the value returned in the
  _copy_
  field)
  does not equal the value that was specified in the
  _len_
  field.
* **EINVAL**  
  Either
  _dst_
  or
  _len_
  was not a multiple of the system page size, or the range specified by
  _src_
  and
  _len_
  or
  _dst_
  and
  _len_
  was invalid.
* **EINVAL**  
  An invalid bit was specified in the
  _mode_
  field.
* **ENOENT** (since Linux 4.11)  
  The faulting process has changed
  its virtual memory layout simultaneously with an outstanding
  _UFFDIO_COPY_
  operation.
* **ENOSPC** (from Linux 4.11 until Linux 4.13)  
  The faulting process has exited at the time of a
  _UFFDIO_COPY_
  operation.
* **ESRCH** (since Linux 4.13)  
  The faulting process has exited at the time of a
  _UFFDIO_COPY_
  operation.
  

<a name="uffdio_zeropage"></a>

### UFFDIO_ZEROPAGE

(Since Linux 4.3.)
Zero out a memory range registered with userfaultfd.

The requested range is specified by the
_range_
field of the
_uffdio_zeropage_
structure pointed to by
_argp_:

.in +4n
.EX
struct uffdio_zeropage {
    struct uffdio_range range;
    __u64 mode;     /* Flags controlling behavior of copy */
    __s64 zeropage; /* Number of bytes zeroed, or negated error */
};
.EE
.in

The following value may be bitwise ORed in
_mode_
to change the behavior of the
**UFFDIO_ZERO**
operation:

* **UFFDIO_ZEROPAGE_MODE_DONTWAKE**  
  Do not wake up the thread that waits for page-fault resolution.

The
_zeropage_
field is used by the kernel to return the number of bytes
that was actually zeroed,
or an error in the same manner as
**UFFDIO_COPY**.


If the value returned in the
_zeropage_
field doesn't match the value that was specified in
_range.len_,
the operation fails with the error
**EAGAIN**.
The
_zeropage_
field is output-only;
it is not read by the
**UFFDIO_ZERO**
operation.

This
**ioctl**(2)
operation returns 0 on success.
In this case, the entire area was zeroed.
On error, -1 is returned and
_errno_
is set to indicate the cause of the error.
Possible errors include:

* **EAGAIN**  
  The number of bytes zeroed (i.e., the value returned in the
  _zeropage_
  field)
  does not equal the value that was specified in the
  _range.len_
  field.
* **EINVAL**  
  Either
  _range.start_
  or
  _range.len_
  was not a multiple of the system page size; or
  _range.len_
  was zero; or the range specified was invalid.
* **EINVAL**  
  An invalid bit was specified in the
  _mode_
  field.
* **ESRCH** (since Linux 4.13)  
  The faulting process has exited at the time of a
  _UFFDIO_ZEROPAGE_
  operation.
  

<a name="uffdio_wake"></a>

### UFFDIO_WAKE

(Since Linux 4.3.)
Wake up the thread waiting for page-fault resolution on
a specified memory address range.

The
**UFFDIO_WAKE**
operation is used in conjunction with
**UFFDIO_COPY**
and
**UFFDIO_ZEROPAGE**
operations that have the
**UFFDIO_COPY_MODE_DONTWAKE**
or
**UFFDIO_ZEROPAGE_MODE_DONTWAKE**
bit set in the
_mode_
field.
The userfault monitor can perform several
**UFFDIO_COPY**
and
**UFFDIO_ZEROPAGE**
operations in a batch and then explicitly wake up the faulting thread using
**UFFDIO_WAKE**.

The
_argp_
argument is a pointer to a
_uffdio_range_
structure (shown above) that specifies the address range.

This
**ioctl**(2)
operation returns 0 on success.
On error, -1 is returned and
_errno_
is set to indicate the cause of the error.
Possible errors include:

* **EINVAL**  
  The
  _start_
  or the
  _len_
  field of the
  _ufdio_range_
  structure was not a multiple of the system page size; or
  _len_
  was zero; or the specified range was otherwise invalid.

<a name="return-value"></a>

# Return Value

See descriptions of the individual operations, above.

<a name="errors"></a>

# Errors

See descriptions of the individual operations, above.
In addition, the following general errors can occur for all of the
operations described above:

* **EFAULT**  
  _argp_
  does not point to a valid memory address.
* **EINVAL**  
  (For all operations except
  **UFFDIO_API**.)
  The userfaultfd object has not yet been enabled (via the
  **UFFDIO_API**
  operation).

<a name="conforming-to"></a>

# Conforming to

These
**ioctl**(2)
operations are Linux-specific.

<a name="bugs"></a>

# Bugs

In order to detect available userfault features and
enable some subset of those features
the userfaultfd file descriptor must be closed after the first
**UFFDIO_API**
operation that queries features availability and reopened before
the second
**UFFDIO_API**
operation that actually enables the desired features.

<a name="example"></a>

# Example

See
**userfaultfd**(2).

<a name="see-also"></a>

# See Also

**ioctl**(2),
**mmap**(2),
**userfaultfd**(2)

_Documentation/vm/userfaultfd.txt_
in the Linux kernel source tree

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
