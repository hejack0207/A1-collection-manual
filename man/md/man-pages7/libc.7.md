# libc(7) - overview of standard C libraries on Linux

Linux, 2016-12-12


<a name="description"></a>

# Description

The term "libc" is commonly used as a shorthand for
the "standard C library",
a library of standard functions that can be used by all C programs
(and sometimes by programs in other languages).
Because of some history (see below), use of the term "libc"
to refer to the standard C library is somewhat ambiguous on Linux.

<a name="glibc"></a>

### glibc

By far the most widely used C library on Linux is the GNU C Library
[](http://www.gnu.org​/software​/libc/),
often referred to as
_glibc_.
This is the C library that is nowadays used in all
major Linux distributions.
It is also the C library whose details are documented
in the relevant pages of the
_man-pages_
project (primarily in Section 3 of the manual).
Documentation of glibc is also available in the glibc manual,
available via the command
_info libc_.
Release 1.0 of glibc was made in September 1992.
(There were earlier 0.x releases.)
The next major release of glibc was 2.0, at the beginning of 1997.

The pathname
_/lib/libc.so.6_
(or something similar) is normally a symbolic link that
points to the location of the glibc library,
and executing this pathname will cause glibc to display
various information about the version installed on your system.

<a name="linux-libc"></a>

### Linux libc

In the early to mid 1990s, there was for a while
_Linux libc_,
a fork of glibc 1.x created by Linux developers who felt that glibc
development at the time was not sufficing for the needs of Linux.
Often, this library was referred to (ambiguously) as just "libc".
Linux libc released major versions 2, 3, 4, and 5,
as well as many minor versions of those releases.
Linux libc4 was the last version to use the a.out binary format,
and the first version to provide (primitive) shared library support.
Linux libc 5 was the first version to support the ELF binary format;
this version used the shared library soname
_libc.so.5_.
For a while,
Linux libc was the standard C library in many Linux distributions.

However, notwithstanding the original motivations of the Linux libc effort,
by the time glibc 2.0 was released (in 1997),
it was clearly superior to Linux libc,
and all major Linux distributions that had been using Linux libc
soon switched back to glibc.
To avoid any confusion with Linux libc versions,
glibc 2.0 and later used the shared library soname
_libc.so.6_.

Since the switch from Linux libc to glibc 2.0 occurred long ago,
_man-pages_
no longer takes care to document Linux libc details.
Nevertheless, the history is visible in vestiges of information
about Linux libc that remain in a few manual pages,
in particular, references to
_libc4_
and
_libc5_.

<a name="other-c-libraries"></a>

### Other C libraries

There are various other less widely used C libraries for Linux.
These libraries are generally smaller than glibc,
both in terms of features and memory footprint,
and often intended for building small binaries,
perhaps targeted at development for embedded Linux systems.
Among such libraries are
[_uClibc_](http://www.uclibc.org/),
[_dietlibc_](http://www.fefe.de/dietlibc/),
and
[_musl libc_](http://www.musl-libc.org/).
Details of these libraries are covered by the
_man-pages_
project, where they are known.

<a name="see-also"></a>

# See Also

**syscalls**(2),
**getauxval**(3),
**proc**(5),
**feature_test_macros**(7),
**man-pages**(7),
**standards**(7),
**vdso**(7)

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
