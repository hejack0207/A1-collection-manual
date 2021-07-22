# set_tid_address(2) - set pointer to thread ID

Linux, 2017-09-15

    #include <linux/unistd.h>
    
    long set_tid_address(int *tidptr);
```

 Note: There is no glibc wrapper for this system call; see NOTES.
```

<a name="description"></a>

# Description

For each thread, the kernel maintains two attributes (addresses) called
_set_child_tid_
and
_clear_child_tid_.
These two attributes contain the value NULL by default.

* _set_child_tid_  
  If a thread is started using
  **clone**(2)
  with the
  **CLONE_CHILD_SETTID**
  flag,
  _set_child_tid_
  is set to the value passed in the
  _ctid_
  argument of that system call.
* When
  _set_child_tid_
  is set, the very first thing the new thread does
  is to write its thread ID at this address.
* _clear_child_tid_  
  If a thread is started using
  **clone**(2)
  with the
  **CLONE_CHILD_CLEARTID**
  flag,
  _clear_child_tid_
  is set to the value passed in the
  _ctid_
  argument of that system call.

The system call
**set_tid_address**()
sets the
_clear_child_tid_
value for the calling thread to
_tidptr_.

When a thread whose
_clear_child_tid_
is not NULL terminates, then,
if the thread is sharing memory with other threads,
then 0 is written at the address specified in
_clear_child_tid_
and the kernel performs the following operation:

    futex(clear_child_tid, FUTEX_WAKE, 1, NULL, NULL, 0);

The effect of this operation is to wake a single thread that
is performing a futex wait on the memory location.
Errors from the futex wake operation are ignored.

<a name="return-value"></a>

# Return Value

**set_tid_address**()
always returns the caller's thread ID.

<a name="errors"></a>

# Errors

**set_tid_address**()
always succeeds.

<a name="versions"></a>

# Versions

This call is present since Linux 2.5.48.
Details as given here are valid since Linux 2.5.49.

<a name="conforming-to"></a>

# Conforming to

This system call is Linux-specific.

<a name="notes"></a>

# Notes

Glibc does not provide a wrapper for this system call; call it using
**syscall**(2).

<a name="see-also"></a>

# See Also

**clone**(2),
**futex**(2),
**gettid**(2)

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
