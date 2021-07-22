# io_submit(2) - submit asynchronous I/O blocks for processing

Linux, 2018-04-30

    #include <linux/aio_abi.h>          /* Defines needed types */
    
    int io_submit(aio_context_t ctx_id, long nr, struct iocb **iocbpp);
```

 Note: There is no glibc wrapper for this system call; see NOTES.
```

<a name="description"></a>

# Description


The
**io_submit**()
system call
queues _nr_ I/O request blocks for processing in
the AIO context _ctx\_id_.
The
_iocbpp_
argument should be an array of _nr_ AIO control blocks,
which will be submitted to context _ctx\_id_.

The
_iocb_
(I/O control block) structure defined in
_linux/aio_abi.h_
defines the parameters that control the I/O operation.

.in +4n
.EX
#include &lt;linux/aio_abi.h&gt;

struct iocb {
    __u64   aio_data;
    __u32   PADDED(aio_key, aio_rw_flags);
    __u16   aio_lio_opcode;
    __s16   aio_reqprio;
    __u32   aio_fildes;
    __u64   aio_buf;
    __u64   aio_nbytes;
    __s64   aio_offset;
    __u64   aio_reserved2;
    __u32   aio_flags;
    __u32   aio_resfd;
};
.EE
.in

The fields of this structure are as follows:

* _aio_data_  
  This is an internal field used by the kernel.
  Do not modify this field after an
  **io_submit**(2)
  call.
* _aio_key_  
  This is an internal field used by the kernel.
  Do not modify this field after an
  **io_submit**(2)
  call.
* _aio_rw_flags_  
  This defines the R/W flags passed with structure.
  The valid values are:
    * **RWF_APPEND** (since Linux 4.16)  
      
      Append data to the end of the file.
      See the description of the flag of the same name in
      **pwritev2**(2)
      as well as the description of
      **O_APPEND**
      in
      **open**(2).
      The
      _aio_offset_
      field is ignored.
      The file offset is not changed.
    * **RWF_DSYNC** (since Linux 4.7)  
      Write operation complete according to requirement of
      synchronized I/O data integrity.
      See the description of the flag of the same name in
      **pwritev2**(2)
      as well the description of
      **O_DSYNC**
      in
      **open**(2).
    * **RWF_HIPRI** (since Linux 4.6)  
      High priority request, poll if possible
    * **RWF_NOWAIT** (since Linux 4.14)  
      Don't wait if the I/O will block for operations such as
      file block allocations, dirty page flush, mutex locks,
      or a congested block device inside the kernel.
      If any of these conditions are met, the control block is returned
      immediately with a return value of
      **-EAGAIN**
      in the
      _res_
      field of the
      _io_event_
      structure (see
      **io_getevents**(2)).
    * **RWF_SYNC** (since Linux 4.7)  
      Write operation complete according to requirement of
      synchronized I/O file integrity.
      See the description of the flag of the same name in
      **pwritev2**(2)
      as well the description of
      **O_SYNC**
      in
      **open**(2).
* _aio_lio_opcode_  
  This defines the type of I/O to be performed by the iocb structure.
  The
  valid values are defined by the enum defined in
  _linux/aio_abi.h_:
* .in +4
  .EX
  enum {
      IOCB_CMD_PREAD = 0,
      IOCB_CMD_PWRITE = 1,
      IOCB_CMD_FSYNC = 2,
      IOCB_CMD_FDSYNC = 3,
      IOCB_CMD_NOOP = 6,
      IOCB_CMD_PREADV = 7,
      IOCB_CMD_PWRITEV = 8,
  };
  .EE
  .in
* _aio_reqprio_  
  This defines the requests priority.
* _aio_filedes_  
  The file descriptor on which the I/O operation is to be performed.
* _aio_buf_  
  This is the buffer used to transfer data for a read or write operation.
* _aio_nbytes_  
  This is the size of the buffer pointed to by
  _aio_buf_.
* _aio_offset_  
  This is the file offset at which the I/O operation is to be performed.
* _aio_flags_  
  This is the flag to be passed iocb structure.
  The only valid value is
  **IOCB_FLAG_RESFD**,
  which indicates that the asynchronous I/O control must signal the file
  descriptor mentioned in
  _aio_resfd_
  upon completion.
* _aio_resfd_  
  The file descriptor to signal in the event of asynchronous I/O completion.

<a name="return-value"></a>

# Return Value

On success,
**io_submit**()
returns the number of _iocb_s submitted (which may be
less than _nr_, or 0 if _nr_ is zero).
For the failure return, see NOTES.

<a name="errors"></a>

# Errors


* **EAGAIN**  
  Insufficient resources are available to queue any _iocb_s.
* **EBADF**  
  The file descriptor specified in the first _iocb_ is invalid.
* **EFAULT**  
  One of the data structures points to invalid data.
* **EINVAL**  
  The AIO context specified by _ctx\_id_ is invalid.
  _nr_ is less than 0.
  The _iocb_ at
  <i>*iocbpp[0]</i>
  is not properly initialized,
  or the operation specified is invalid for the file descriptor
  in the _iocb_.
* **ENOSYS**  
  **io_submit**()
  is not implemented on this architecture.

<a name="versions"></a>

# Versions


The asynchronous I/O system calls first appeared in Linux 2.5.

<a name="conforming-to"></a>

# Conforming to


**io_submit**()
is Linux-specific and should not be used in
programs that are intended to be portable.

<a name="notes"></a>

# Notes

Glibc does not provide a wrapper function for this system call.
You could invoke it using
**syscall**(2).
But instead, you probably want to use the
**io_submit**()
wrapper function provided by

_libaio_.

Note that the
_libaio_
wrapper function uses a different type
(_io_context_t_)


for the
_ctx_id_
argument.
Note also that the
_libaio_
wrapper does not follow the usual C library conventions for indicating errors:
on error it returns a negated error number
(the negative of one of the values listed in ERRORS).
If the system call is invoked via
**syscall**(2),
then the return value follows the usual conventions for
indicating an error: -1, with
_errno_
set to a (positive) value that indicates the error.

<a name="see-also"></a>

# See Also

**io_cancel**(2),
**io_destroy**(2),
**io_getevents**(2),
**io_setup**(2),
**aio**(7)



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
