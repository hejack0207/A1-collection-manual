# sync_file_range(2) - sync a file segment with disk

Linux, 2017-09-15

    #define _GNU_SOURCE         /* See feature_test_macros(7) */
    #include <fcntl.h>
    
    int sync_file_range(int fd, off64_t offset, off64_t nbytes,
                        unsigned int flags);

<a name="description"></a>

# Description

**sync_file_range**()
permits fine control when synchronizing the open file referred to by the
file descriptor
_fd_
with disk.

_offset_
is the starting byte of the file range to be synchronized.
_nbytes_
specifies the length of the range to be synchronized, in bytes; if
_nbytes_
is zero, then all bytes from
_offset_
through to the end of file are synchronized.
Synchronization is in units of the system page size:
_offset_
is rounded down to a page boundary;
_(offset+nbytes-1)_
is rounded up to a page boundary.

The
_flags_
bit-mask argument can include any of the following values:

* **SYNC_FILE_RANGE_WAIT_BEFORE**  
  Wait upon write-out of all pages in the specified range
  that have already been submitted to the device driver for write-out
  before performing any write.
* **SYNC_FILE_RANGE_WRITE**  
  Initiate write-out of all dirty pages in the specified
  range which are not presently submitted write-out.
  Note that even this may block if you attempt to
  write more than request queue size.
* **SYNC_FILE_RANGE_WAIT_AFTER**  
  Wait upon write-out of all pages in the range
  after performing any write.

Specifying
_flags_
as 0 is permitted, as a no-op.

<a name="warning"></a>

### Warning

This system call is extremely dangerous and should not be used in portable
programs.
None of these operations writes out the file's metadata.
Therefore, unless the application is strictly performing overwrites of
already-instantiated disk blocks, there are no guarantees that the data will
be available after a crash.
There is no user interface to know if a write is purely an overwrite.
On filesystems using copy-on-write semantics (e.g.,
_btrfs_)
an overwrite of existing allocated blocks is impossible.
When writing into preallocated space,
many filesystems also require calls into the block
allocator, which this system call does not sync out to disk.
This system call does not flush disk write caches and thus does not provide
any data integrity on systems with volatile disk write caches.

<a name="some-details"></a>

### Some details

**SYNC_FILE_RANGE_WAIT_BEFORE**
and
**SYNC_FILE_RANGE_WAIT_AFTER**
will detect any
I/O errors or
**ENOSPC**
conditions and will return these to the caller.

Useful combinations of the
_flags_
bits are:

* **SYNC_FILE_RANGE_WAIT_BEFORE | SYNC_FILE_RANGE_WRITE**  
  Ensures that all pages
  in the specified range which were dirty when
  **sync_file_range**()
  was called are placed
  under write-out.
  This is a start-write-for-data-integrity operation.
* **SYNC_FILE_RANGE_WRITE**  
  Start write-out of all dirty pages in the specified range which
  are not presently under write-out.
  This is an asynchronous flush-to-disk
  operation.
  This is not suitable for data integrity operations.
* **SYNC_FILE_RANGE_WAIT_BEFORE** (or **SYNC_FILE_RANGE_WAIT_AFTER**)  
  Wait for
  completion of write-out of all pages in the specified range.
  This can be used after an earlier
  **SYNC_FILE_RANGE_WAIT_BEFORE | SYNC_FILE_RANGE_WRITE**
  operation to wait for completion of that operation, and obtain its result.
* **SYNC_FILE_RANGE_WAIT_BEFORE | SYNC_FILE_RANGE_WRITE | SYNC_FILE_RANGE_WAIT_AFTER**  
  This is a write-for-data-integrity operation
  that will ensure that all pages in the specified range which were dirty when
  **sync_file_range**()
  was called are committed to disk.

<a name="return-value"></a>

# Return Value

On success,
**sync_file_range**()
returns 0; on failure -1 is returned and
_errno_
is set to indicate the error.

<a name="errors"></a>

# Errors


* **EBADF**  
  _fd_
  is not a valid file descriptor.
* **EINVAL**  
  _flags_
  specifies an invalid bit; or
  _offset_
  or
  _nbytes_
  is invalid.
* **EIO**  
  I/O error.
* **ENOMEM**  
  Out of memory.
* **ENOSPC**  
  Out of disk space.
* **ESPIPE**  
  _fd_
  refers to something other than a regular file, a block device, or
  a directory.

<a name="versions"></a>

# Versions

**sync_file_range**()
appeared on Linux in kernel 2.6.17.

<a name="conforming-to"></a>

# Conforming to

This system call is Linux-specific, and should be avoided
in portable programs.

<a name="notes"></a>

# Notes


<a name="sync_file_range2"></a>

### sync_file_range2()

Some architectures (e.g., PowerPC, ARM)
need 64-bit arguments to be aligned in a suitable pair of registers.

On such architectures, the call signature of
**sync_file_range**()
shown in the SYNOPSIS would force
a register to be wasted as padding between the
_fd_
and
_offset_
arguments.
(See
**syscall**(2)
for details.)
Therefore, these architectures define a different
system call that orders the arguments suitably:

.in +4n
.EX
**int sync_file_range2(int **_fd_**, unsigned int **_flags_**,**
**                     off64_t **_offset_**, off64_t **_nbytes_**);**
.EE
.in

The behavior of this system call is otherwise exactly the same as
**sync_file_range**().

A system call with this signature first appeared on the ARM architecture
in Linux 2.6.20, with the name
**arm_sync_file_range**().
It was renamed in Linux 2.6.22,
when the analogous system call was added for PowerPC.
On architectures where glibc support is provided,
glibc transparently wraps
**sync_file_range2**()
under the name
**sync_file_range**().

<a name="see-also"></a>

# See Also

**fdatasync**(2),
**fsync**(2),
**msync**(2),
**sync**(2)

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
