# time(1) - time a simple command or give resource usage

"", 2017-09-15

```
time [options] command [arguments...] 
```

<a name="description"></a>

# Description

The
**time**
command runs the specified program
_command_
with the given arguments.
When
_command_
finishes,
**time**
writes a message to standard error giving timing statistics
about this program run.
These statistics consist of (i) the elapsed real time
between invocation and termination, (ii) the user CPU time
(the sum of the
_tms_utime_
and
_tms_cutime_
values in a
_struct tms_
as returned by
**times**(2)),
and (iii) the system CPU time (the sum of the
_tms_stime_
and
_tms_cstime_
values in a
_struct tms_
as returned by
**times**(2)).

Note: some shells (e.g.,
**bash**(1))
have a built-in
**time**
command that provides similar information on the usage of time and
possibly other resources.
To access the real command, you may need to specify its pathname
(something like
_/usr/bin/time_).

<a name="options"></a>

# Options


* **-p**  
  When in the POSIX locale, use the precise traditional format
* .in +4n
  .EX
  "real %f\enuser %f\ensys %f\en"
  .EE
  .in
* (with numbers in seconds)
  where the number of decimals in the output for %f is unspecified
  but is sufficient to express the clock tick accuracy, and at least one.

<a name="exit-status"></a>

# Exit Status

If
_command_
was invoked, the exit status is that of
_command_.
Otherwise, it is 127 if
_command_
could not be found, 126 if it could be found but could not be invoked,
and some other nonzero value (1–125) if something else went wrong.

<a name="environment"></a>

# Environment

The variables
**LANG**,
**LC_ALL**,
**LC_CTYPE**,
**LC_MESSAGES**,
**LC_NUMERIC**,
and
**NLSPATH**
are used for the text and formatting of the output.
**PATH**
is used to search for
_command_.
The remaining ones for the text and formatting of the output.

<a name="gnu-version"></a>

# Gnu Version

Below a description of the GNU 1.7 version of
**time**.
Disregarding the name of the utility, GNU makes it output lots of
useful information, not only about time used, but also on other
resources like memory, I/O and IPC calls (where available).
The output is formatted using a format string that can be specified
using the
_-f_
option or the
**TIME**
environment variable.

The default format string is:

.in +4n
.EX
%Uuser %Ssystem %Eelapsed %PCPU (%Xtext+%Ddata %Mmax)k
%Iinputs+%Ooutputs (%Fmajor+%Rminor)pagefaults %Wswaps
.EE
.in

When the
_-p_
option is given, the (portable) output format is used:

.in +4n
.EX
real %e
user %U
sys %S
.EE
.in


<a name="the-format-string"></a>

### The format string

The format is interpreted in the usual printf-like way.
Ordinary characters are directly copied, tab, newline
and backslash are escaped using \et, \en and \e\e,
a percent sign is represented by %%, and otherwise %
indicates a conversion.
The program
**time**
will always add a trailing newline itself.
The conversions follow.
All of those used by
**tcsh**(1)
are supported.

**Time**

* **%E**  
  Elapsed real time (in [hours:]minutes:seconds).
* **%e**  
  (Not in
  **tcsh**(1).)
  Elapsed real time (in seconds).
* **%S**  
  Total number of CPU-seconds that the process spent in kernel mode.
* **%U**  
  Total number of CPU-seconds that the process spent in user mode.
* **%P**  
  Percentage of the CPU that this job got, computed as (%U + %S) / %E.

**Memory**

* **%M**  
  Maximum resident set size of the process during its lifetime, in Kbytes.
* **%t**  
  (Not in
  **tcsh**(1).)
  Average resident set size of the process, in Kbytes.
* **%K**  
  Average total (data+stack+text) memory use of the process,
  in Kbytes.
* **%D**  
  Average size of the process's unshared data area, in Kbytes.
* **%p**  
  (Not in
  **tcsh**(1).)
  Average size of the process's unshared stack space, in Kbytes.
* **%X**  
  Average size of the process's shared text space, in Kbytes.
* **%Z**  
  (Not in
  **tcsh**(1).)
  System's page size, in bytes.
  This is a per-system constant, but varies between systems.
* **%F**  
  Number of major page faults that occurred while the process was running.
  These are faults where the page has to be read in from disk.
* **%R**  
  Number of minor, or recoverable, page faults.
  These are faults for pages that are not valid but which have
  not yet been claimed by other virtual pages.
  Thus the data
  in the page is still valid but the system tables must be updated.
* **%W**  
  Number of times the process was swapped out of main memory.
* **%c**  
  Number of times the process was context-switched involuntarily
  (because the time slice expired).
* **%w**  
  Number of waits: times that the program was context-switched voluntarily,
  for instance while waiting for an I/O operation to complete.

**I/O**

* **%I**  
  Number of filesystem inputs by the process.
* **%O**  
  Number of filesystem outputs by the process.
* **%r**  
  Number of socket messages received by the process.
* **%s**  
  Number of socket messages sent by the process.
* **%k**  
  Number of signals delivered to the process.
* **%C**  
  (Not in
  **tcsh**(1).)
  Name and command-line arguments of the command being timed.
* **%x**  
  (Not in
  **tcsh**(1).)
  Exit status of the command.

<a name="gnu-options"></a>

### GNU options


* **-f **_format_**, --format=**_format_  
  Specify output format, possibly overriding the format specified
  in the environment variable TIME.
* **-p, --portability**  
  Use the portable output format.
* **-o **_file_**, --output=**_file_  
  Do not send the results to
  _stderr_,
  but overwrite the specified file.
* **-a, --append**  
  (Used together with -o.) Do not overwrite but append.
* **-v, --verbose**  
  Give very verbose output about all the program knows about.

<a name="gnu-standard-options"></a>

### GNU standard options


* **--help**  
  Print a usage message on standard output and exit successfully.
* **-V, --version**  
  Print version information on standard output, then exit successfully.
* **--**  
  Terminate option list.

<a name="bugs"></a>

# Bugs

Not all resources are measured by all versions of UNIX,
so some of the values might be reported as zero.
The present selection was mostly inspired by the data
provided by 4.2 or 4.3BSD.

GNU time version 1.7 is not yet localized.
Thus, it does not implement the POSIX requirements.

The environment variable
**TIME**
was badly chosen.
It is not unusual for systems like
**autoconf**(1)
or
**make**(1)
to use environment variables with the name of a utility to override
the utility to be used.
Uses like MORE or TIME for options to programs
(instead of program pathnames) tend to lead to difficulties.

It seems unfortunate that
_-o_
overwrites instead of appends.
(That is, the
_-a_
option should be the default.)

Mail suggestions and bug reports for GNU
**time**
to
_bug-utils@prep.ai.mit.edu_.
Please include the version of
**time**,
which you can get by running

.in +4n
.EX
time --version
.EE
.in

and the operating system
and C compiler you used.












<a name="see-also"></a>

# See Also

**bash**(1),
**tcsh**(1),
**times**(2),
**wait3**(2)

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
