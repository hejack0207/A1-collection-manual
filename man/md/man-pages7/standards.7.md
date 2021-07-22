# standards(7) - C and UNIX Standards

Linux, 2017-11-26


<a name="description"></a>

# Description

The CONFORMING TO section that appears in many manual pages identifies
various standards to which the documented interface conforms.
The following list briefly describes these standards.

* **V7**  
  Version 7 (also known as Seventh Edition) UNIX,
  released by AT&T/Bell Labs in 1979.
  After this point, UNIX systems diverged into two main dialects:
  BSD and System V.
* **4.2BSD**  
  This is an implementation standard defined by the 4.2 release
  of the
  _Berkeley Software Distribution_,
  released by the University of California at Berkeley.
  This was the first Berkeley release that contained a TCP/IP
  stack and the sockets API.
  4.2BSD was released in 1983.
* Earlier major BSD releases included
  _3BSD_
  (1980),
  _4BSD_
  (1980),
  and
  _4.1BSD_
  (1981).
* **4.3BSD**  
  The successor to 4.2BSD, released in 1986.
* **4.4BSD**  
  The successor to 4.3BSD, released in 1993.
  This was the last major Berkeley release.
* **System V**  
  This is an implementation standard defined by AT&T's milestone 1983
  release of its commercial System V (five) release.
  The previous major AT&T release was
  _System III_,
  released in 1981.
* **System V release 2 (SVr2)**  
  This was the next System V release, made in 1985.
  The SVr2 was formally described in the
  _System V Interface Definition version 1_
  (_SVID 1_)
  published in 1985.
* **System V release 3 (SVr3)**  
  This was the successor to SVr2, released in 1986.
  This release was formally described in the
  _System V Interface Definition version 2_
  (_SVID 2_).
* **System V release 4 (SVr4)**  
  This was the successor to SVr3, released in 1989.
  This version of System V is described in the "Programmer's Reference
  Manual: Operating System API (Intel processors)" (Prentice-Hall
  1992, ISBN 0-13-951294-2)
  This release was formally described in the
  _System V Interface Definition version 3_
  (_SVID 3_),
  and is considered the definitive System V release.
* **SVID 4**  
  System V Interface Definition version 4, issued in 1995.
  Available online at
  .UR http://www.sco.com​/developers​/devspecs/
  .UE .
* **C89**  
  This was the first C language standard, ratified by ANSI
  (American National Standards Institute) in 1989
  (_X3.159-1989_).
  Sometimes this is known as
  _ANSI C_,
  but since C99 is also an
  ANSI standard, this term is ambiguous.
  This standard was also ratified by
  ISO (International Standards Organization) in 1990
  (_ISO/IEC 9899:1990_),
  and is thus occasionally referred to as
  _ISO C90_.
* **C99**  
  This revision of the C language standard was ratified by ISO in 1999
  (_ISO/IEC 9899:1999_).
  Available online at
  .UR http://www.open-std.org​/jtc1​/sc22​/wg14​/www​/standards
  .UE .
* **C11**  
  This revision of the C language standard was ratified by ISO in 2011
  (_ISO/IEC 9899:2011_).
* **POSIX.1-1990**  
  "Portable Operating System Interface for Computing Environments".
  IEEE 1003.1-1990 part 1, ratified by ISO in 1990
  (_ISO/IEC 9945-1:1990_).
  The term "POSIX" was coined by Richard Stallman.
* **POSIX.2**  
  IEEE Std 1003.2-1992,
  describing commands and utilities, ratified by ISO in 1993
  (_ISO/IEC 9945-2:1993_).
* **POSIX.1b** (formerly known as _POSIX.4_)  
  IEEE Std 1003.1b-1993,
  describing real-time facilities
  for portable operating systems, ratified by ISO in 1996
  (_ISO/IEC 9945-1:1996_).
* **POSIX.1c**  
  IEEE Std 1003.1c-1995, which describes the POSIX threads interfaces.
* **POSIX.1d**  
  IEEE Std 1003.1c-1999, which describes additional real-time extensions.
* **POSIX.1g**  
  IEEE Std 1003.1g-2000, which describes networking APIs (including sockets).
* **POSIX.1j**  
  IEEE Std 1003.1j-2000, which describes advanced real-time extensions.
* **POSIX.1-1996**  
  A 1996 revision of POSIX.1 which incorporated POSIX.1b and POSIX.1c.
* **XPG3**  
  Released in 1989, this was the first significant release of the
  _X/Open Portability Guide_,
  produced by the
  X/Open Company, a multivendor consortium.
  This multivolume guide was based on the POSIX standards.
* **XPG4**  
  A revision of the X/Open Portability Guide, released in 1992.
* **XPG4v2**  
  A 1994 revision of XPG4.
  This is also referred to as
  _Spec 1170_,
  where 1170 referred to the number of interfaces
  defined by this standard.
* **SUS (SUSv1)**  
  Single UNIX Specification.
  This was a repackaging of XPG4v2 and other X/Open standards
  (X/Open Curses Issue 4 version 2,
  X/Open Networking Service (XNS) Issue 4).
  Systems conforming to this standard can be branded
  _UNIX 95_.
* **SUSv2**  
  Single UNIX Specification version 2.
  Sometimes also referred to as
  _XPG5_.
  This standard appeared in 1997.
  Systems conforming to this standard can be branded
  _UNIX 98_.
  See also
  .UR http://www.UNIX-systems.org​/version2/
  .UE .)
* **POSIX.1-2001, SUSv3**  
  This was a 2001 revision and consolidation of the
  POSIX.1, POSIX.2, and SUS standards into a single document,
  conducted under the auspices of the Austin Group
  .UR http://www.opengroup.org​/austin/
  .UE .
  The standard is available online at
  .UR http://www.unix-systems.org​/version3/
  .UE ,
  and the interfaces that it describes are also available in the Linux
  manual pages package under sections 1p and 3p (e.g., "man 3p open").
* The standard defines two levels of conformance:
  _POSIX conformance_,
  which is a baseline set of interfaces required of a conforming system;
  and
  _XSI Conformance_,
  which additionally mandates a set of interfaces
  (the "XSI extension") which are only optional for POSIX conformance.
  XSI-conformant systems can be branded
  _UNIX 03_.
  (XSI conformance constitutes the
  _Single UNIX Specification version 3_
  (_SUSv3_).)
* The POSIX.1-2001 document is broken into four parts:
* **XBD**:
  Definitions, terms and concepts, header file specifications.
* **XSH**:
  Specifications of functions (i.e., system calls and library
  functions in actual implementations).
* **XCU**:
  Specifications of commands and utilities
  (i.e., the area formerly described by POSIX.2).
* **XRAT**:
  Informative text on the other parts of the standard.
* POSIX.1-2001 is aligned with C99, so that all of the
  library functions standardized in C99 are also
  standardized in POSIX.1-2001.
* Two Technical Corrigenda (minor fixes and improvements)
  of the original 2001 standard have occurred:
  TC1 in 2003 (also known as
  _POSIX.1-2003_),
  and TC2 in 2004 (also known as
  _POSIX.1-2004_).
* **POSIX.1-2008, SUSv4**  
  Work on the next revision of POSIX.1/SUS was completed and
  ratified in 2008.
* The changes in this revision are not as large as those
  that occurred for POSIX.1-2001/SUSv3,
  but a number of new interfaces are added
  and various details of existing specifications are modified.
  Many of the interfaces that were optional in
  POSIX.1-2001 become mandatory in the 2008 revision of the standard.
  A few interfaces that are present in POSIX.1-2001 are marked
  as obsolete in POSIX.1-2008, or removed from the standard altogether.
* The revised standard is broken into the same four parts as POSIX.1-2001,
  and again there are two levels of conformance: the baseline
  _POSIX Conformance_,
  and
  _XSI Conformance_,
  which mandates an additional set of interfaces
  beyond those in the base specification.
* In general, where the CONFORMING TO section of a manual page
  lists POSIX.1-2001, it can be assumed that the interface also
  conforms to POSIX.1-2008, unless otherwise noted.
* Technical Corrigendum 1 (minor fixes and improvements)
  of this standard was released in 2013
  (also known as
  _POSIX.1-2013_).
* Technical Corrigendum 2 of this standard was released in 2016
  (also known as
  _POSIX.1-2016_).
* Further information can be found on the Austin Group web site,
  .UR http://www.opengroup.org​/austin/
  .UE .

<a name="see-also"></a>

# See Also

**getconf**(1),
**confstr**(3),
**pathconf**(3),
**sysconf**(3),
**attributes**(7),
**feature_test_macros**(7),
**libc**(7),
**posixoptions**(7)

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
