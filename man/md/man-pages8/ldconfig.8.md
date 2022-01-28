# ldconfig(8) - configure dynamic linker run-time bindings

GNU, 2017-09-15

```
/sbin/ldconfig [-nNvXV] [-f conf] [-C cache] [-r root] directory\... 
 /sbin/ldconfig -l [-v] library\... 
 /sbin/ldconfig -p
```

<a name="description"></a>

# Description

**ldconfig**
creates the necessary links and cache to the most recent shared
libraries found in the directories specified on the command line,
in the file
_/etc/ld.so.conf_,
and in the trusted directories,
_/lib_
and
_/usr/lib_
(on some 64-bit architectures such as x86-64,
_/lib_
and
_/usr/lib_
are the trusted directories for 32-bit libraries, while
_/lib64_
and
_/usr/lib64_
are used for 64-bit libraries).

The cache is used by the run-time linker,
_ld.so_
or
_ld-linux.so_.
**ldconfig**
checks the header and filenames of the libraries it encounters when
determining which versions should have their links updated.

**ldconfig**
will attempt to deduce the type of ELF libraries (i.e., libc5 or libc6/glibc)
based on what C libraries, if any, the library was linked against.





Some existing libraries do not contain enough information
to allow the deduction of their type.
Therefore, the
_/etc/ld.so.conf_
file format allows the specification of an expected type.
This is used
_only_
for those ELF libraries which we can not work out.
The format
is "dirname=TYPE", where TYPE can be libc4, libc5, or libc6.
(This syntax also works on the command line.)
Spaces are
_not_
allowed.
Also see the
**-p**
option.
**ldconfig**
should normally be run by the superuser as it may require write
permission on some root owned directories and files.

<a name="options"></a>

# Options


* **-c** _fmt_, **--format=_fmt_**  
  (Since glibc 2.2)
  Cache format to use:
  _old_,
  _new_,
  or
  _compat_
  (default).
* **-C **_cache_  
  Use
  _cache_
  instead of
  _/etc/ld.so.cache_.
* **-f **_conf_  
  Use
  _conf_
  instead of
  _/etc/ld.so.conf_.
  
* **-i**, **--ignore-aux-cache**  
  (Since glibc 2.7)
  
  Ignore auxiliary cache file.
* **-l**  
  (Since glibc 2.2)
  Library mode.
  Manually link individual libraries.
  Intended for use by experts only.
* **-n**  
  Process only the directories specified on the command line.
  Don't process the trusted directories,
  nor those specified in
  _/etc/ld.so.conf_.
  Implies
  **-N**.
* **-N**  
  Don't rebuild the cache.
  Unless
  **-X**
  is also specified, links are still updated.
* **-p**, **--print-cache**  
  Print the lists of directories and candidate libraries stored in
  the current cache.
* **-r **_root_  
  Change to and use
  _root_
  as the root directory.
* **-v**, **--verbose**  
  Verbose mode.
  Print current version number, the name of each directory as it
  is scanned, and any links that are created.
  Overrides quiet mode.
* **-V**, **--version**  
  Print program version.
* **-X**  
  Don't update links.
  Unless
  **-N**
  is also specified, the cache is still rebuilt.

<a name="files"></a>

# Files





* _/lib/ld.so_  
  Run-time linker/loader.
* _/etc/ld.so.conf_  
  File containing a list of directories, one per line,
  in which to search for libraries.
* _/etc/ld.so.cache_  
  File containing an ordered list of libraries found in the directories
  specified in
  _/etc/ld.so.conf_,
  as well as those found in the trusted directories.

<a name="see-also"></a>

# See Also

**ldd**(1),
**ld.so**(8)

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
