# delete_module(2) - unload a kernel module

Linux, 2017-09-15

    int delete_module(const char *name, int flags);
```

 Note: No declaration of this system call is provided in glibc headers; see NOTES.
```

<a name="description"></a>

# Description

The
**delete_module**()
system call attempts to remove the unused loadable module entry
identified by
_name_.
If the module has an
_exit_
function, then that function is executed before unloading the module.
The
_flags_
argument is used to modify the behavior of the system call,
as described below.
This system call requires privilege.

Module removal is attempted according to the following rules:

* 1.  
  If there are other loaded modules that depend on
  (i.e., refer to symbols defined in) this module,
  then the call fails.
* 2.  
  Otherwise, if the reference count for the module
  (i.e., the number of processes currently using the module)
  is zero, then the module is immediately unloaded.
* 3.  
  If a module has a nonzero reference count,
  then the behavior depends on the bits set in
  _flags_.
  In normal usage (see NOTES), the
  **O_NONBLOCK**
  flag is always specified, and the
  **O_TRUNC**
  flag may additionally be specified.
  
  
* The various combinations for
  _flags_
  have the following effect:
    * **flags == O_NONBLOCK**  
      The call returns immediately, with an error.
    * **flags == (O_NONBLOCK | O_TRUNC)**  
      The module is unloaded immediately,
      regardless of whether it has a nonzero reference count.
    * **(flags & O_NONBLOCK) == 0**  
      If
      _flags_
      does not specify
      **O_NONBLOCK**,
      the following steps occur:
        * *  
          The module is marked so that no new references are permitted.
        * *  
          If the module's reference count is nonzero,
          the caller is placed in an uninterruptible sleep state
          (**TASK_UNINTERRUPTIBLE**)
          until the reference count is zero, at which point the call unblocks.
        * *  
          The module is unloaded in the usual way.

The
**O_TRUNC**
flag has one further effect on the rules described above.
By default, if a module has an
_init_
function but no
_exit_
function, then an attempt to remove the module fails.
However, if
**O_TRUNC**
was specified, this requirement is bypassed.

Using the
**O_TRUNC**
flag is dangerous!
If the kernel was not built with
**CONFIG_MODULE_FORCE_UNLOAD**,
this flag is silently ignored.
(Normally,
**CONFIG_MODULE_FORCE_UNLOAD**
is enabled.)
Using this flag taints the kernel (TAINT_FORCED_RMMOD).

<a name="return-value"></a>

# Return Value

On success, zero is returned.
On error, -1 is returned and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors


* **EBUSY**  
  The module is not "live"
  (i.e., it is still being initialized or is already marked for removal);
  or, the module has
  an
  _init_
  function but has no
  _exit_
  function, and
  **O_TRUNC**
  was not specified in
  _flags_.
* **EFAULT**  
  _name_
  refers to a location outside the process's accessible address space.
* **ENOENT**  
  No module by that name exists.
* **EPERM**  
  The caller was not privileged
  (did not have the
  **CAP_SYS_MODULE**
  capability),
  or module unloading is disabled
  (see
  _/proc/sys/kernel/modules_disabled_
  in
  **proc**(5)).
* **EWOULDBLOCK**  
  Other modules depend on this module;
  or,
  **O_NONBLOCK**
  was specified in
  _flags_,
  but the reference count of this module is nonzero and
  **O_TRUNC**
  was not specified in
  _flags_.

<a name="conforming-to"></a>

# Conforming to

**delete_module**()
is Linux-specific.

<a name="notes"></a>

# Notes

The
**delete_module**()
system call is not supported by glibc.
No declaration is provided in glibc headers, but, through a quirk of history,
glibc versions before 2.23 did export an ABI for this system call.
Therefore, in order to employ this system call,
it is (before glibc 2.23) sufficient to
manually declare the interface in your code;
alternatively, you can invoke the system call using
**syscall**(2).

The uninterruptible sleep that may occur if
**O_NONBLOCK**
is omitted from
_flags_
is considered undesirable, because the sleeping process is left
in an unkillable state.
As at Linux 3.7, specifying
**O_NONBLOCK**
is optional, but in future kernels it is likely to become mandatory.

<a name="linux-24-and-earlier"></a>

### Linux 2.4 and earlier

In Linux 2.4 and earlier, the system call took only one argument:

**   int delete_module(const char ***_name_**);**

If
_name_
is NULL, all unused modules marked auto-clean are removed.

Some further details of differences in the behavior of
**delete_module**()
in Linux 2.4 and earlier are
_not_
currently explained in this manual page.

<a name="see-also"></a>

# See Also

**create_module**(2),
**init_module**(2),
**query_module**(2),
**lsmod**(8),
**modprobe**(8),
**rmmod**(8)

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
