# s390_sthyi(2) - emulate STHYI instruction

Linux Programmer's Manual, 2018-02-02

    #include <asm/unistd.h>
    
    int s390_sthyi(unsigned long function_code, void *resp_buffer,
                   uint64_t *return_code, unsigned long flags);

<a name="description"></a>

# Description

The
**s390_sthyi**()
system call emulates the STHYI (Store Hypervisor Information) instruction.
It provides hardware resource information for the machine and its
virtualization levels.
This includes CPU type and capacity, as well as the machine model and
other metrics.

The
_function_code_
argument indicates which function to perform.
The following code(s) are supported:

* 0  
  Return CP (Central Processor) and IFL (Integrated Facility for Linux)
  capacity information.

The
_resp_buffer_
argument specifies the address of a response buffer.
If the system call returns 0,
the response buffer will be filled with CPU capacity information.
Otherwise, the response buffer's content is unchanged.

The
_return_code_
argument stores the return code of the STHYI instruction,
using one of the following values:

* 0  
  Success.
* 4  
  Unsupported function code.

For further details about
_return_code_,
_function_code_,
and
_resp_buffer_,
see the reference given in NOTES.

The
_flags_
argument is provided to allow for future extensions and currently
must be set to 0.

<a name="return-value"></a>

# Return Value

On success (that is: emulation succeeded), the return value of
**s390_sthyi**()
matches the condition code of the STHYI instructions, which is a value
in the range [0..3].
A return value of 0 indicates that CPU capacity information is stored in
_*resp_buffer_.
A return value of 3 indicates "unsupported function code" and the content of
_*resp_buffer_
is unchanged.
The return values 1 and 2 are reserved.

On error, -1 is returned, and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors


* **EFAULT**  
  The value specified in
  _resp_buffer_
  or
  _return_code_
  is not a valid address.
* **EINVAL**  
  The value specified in
  _flags_
  is nonzero.
* **ENOMEM**  
  Allocating memory for handling the CPU capacity information failed.
* **EOPNOTSUPP**  
  The value specified in
  _function_code_
  is not valid.

<a name="versions"></a>

# Versions

This system call is available since Linux 4.15.

<a name="conforming-to"></a>

# Conforming to

This Linux-specific system call is available only on the s390 architecture.

<a name="notes"></a>

# Notes

Glibc does not provide a wrapper for this system call, use
**syscall**(2)
to call it.

For details of the STHYI instruction, see
[](https://www.ibm.com​/support​/knowledgecenter​/SSB27U_6.3.0​/com.ibm.zvm.v630.hcpb4​/hcpb4sth.htm).

<a name="see-also"></a>

# See Also

**syscall**(2)

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
