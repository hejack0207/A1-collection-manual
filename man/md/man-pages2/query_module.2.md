# query_module(2) - query the kernel for various bits pertaining to modules

Linux, 2017-09-15

    #include <linux/module.h>
    
    int query_module(const char *name, int which, void *buf,
                     size_t bufsize, size_t *ret);
```

 Note: No declaration of this system call is provided in glibc headers; see NOTES.
```

<a name="description"></a>

# Description

_Note_:
This system call is present only in kernels before Linux 2.6.

**query_module**()
requests information from the kernel about loadable modules.
The returned information is placed in the buffer pointed to by
_buf_.
The caller must specify the size of
_buf_
in
_bufsize_.
The precise nature and format of the returned information
depend on the operation specified by
_which_.
Some operations require
_name_
to identify a currently loaded module, some allow
_name_
to be NULL, indicating the kernel proper.

The following values can be specified for
_which_:

* **0**  
  Returns success, if the kernel supports
  **query_module**().
  Used to probe for availability of the system call.
* **QM_MODULES**  
  Returns the names of all loaded modules.
  The returned buffer consists of a sequence of null-terminated strings;
  _ret_
  is set to the number of
  modules.
  
* **QM_DEPS**  
  Returns the names of all modules used by the indicated module.
  The returned buffer consists of a sequence of null-terminated strings;
  _ret_
  is set to the number of modules.
  
* **QM_REFS**  
  Returns the names of all modules using the indicated module.
  This is the inverse of
  **QM_DEPS**.
  The returned buffer consists of a sequence of null-terminated strings;
  _ret_
  is set to the number of modules.
  
* **QM_SYMBOLS**  
  Returns the symbols and values exported by the kernel or the indicated
  module.
  The returned buffer is an array of structures of the following form
  
* .in +4n
  .EX
  struct module_symbol {
      unsigned long value;
      unsigned long name;
  };
  .EE
  .in
* followed by null-terminated strings.
  The value of
  _name_
  is the character offset of the string relative to the start of
  _buf_;
  _ret_
  is set to the number of symbols.
* **QM_INFO**  
  Returns miscellaneous information about the indicated module.
  The output buffer format is:
* .in +4n
  .EX
  struct module_info {
      unsigned long address;
      unsigned long size;
      unsigned long flags;
  };
  .EE
  .in
* where
  _address_
  is the kernel address at which the module resides,
  _size_
  is the size of the module in bytes, and
  _flags_
  is a mask of
  **MOD_RUNNING**,
  **MOD_AUTOCLEAN**,
  and so on, that indicates the current status of the module
  (see the Linux kernel source file
  _include/linux/module.h_).
  _ret_
  is set to the size of the
  _module_info_
  structure.

<a name="return-value"></a>

# Return Value

On success, zero is returned.
On error, -1 is returned and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors


* **EFAULT**  
  At least one of
  _name_,
  _buf_,
  or
  _ret_
  was outside the program's accessible address space.
* **EINVAL**  
  Invalid
  _which_;
  or
  _name_
  is NULL (indicating "the kernel"),
  but this is not permitted with the specified value of
  _which_.
  
* **ENOENT**  
  No module by that
  _name_
  exists.
* **ENOSPC**  
  The buffer size provided was too small.
  _ret_
  is set to the minimum size needed.
* **ENOSYS**  
  **query_module**()
  is not supported in this version of the kernel
  (e.g., the kernel is version 2.6 or later).

<a name="versions"></a>

# Versions

This system call is present on Linux only up until kernel 2.4;
it was removed in Linux 2.6.


<a name="conforming-to"></a>

# Conforming to

**query_module**()
is Linux-specific.

<a name="notes"></a>

# Notes

Some of the information that was formerly available via
**query_module**()
can be obtained from
_/proc/modules_,
_/proc/kallsyms_,
and the files under the directory
_/sys/module_.

The
**query_module**()
system call is not supported by glibc.
No declaration is provided in glibc headers, but,
through a quirk of history, glibc does export an ABI for this system call.
Therefore, in order to employ this system call,
it is sufficient to manually declare the interface in your code;
alternatively, you can invoke the system call using
**syscall**(2).

<a name="see-also"></a>

# See Also

**create_module**(2),
**delete_module**(2),
**get_kernel_syms**(2),
**init_module**(2),
**lsmod**(8),
**modinfo**(8)

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
