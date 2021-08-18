# ps(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

ps
— report process status

<a name="synopsis"></a>

# Synopsis

```


```
    ps [(miaA] [(midefl] [(mig grouplist]*? [(miG grouplist]
        [(min namelist]*? [(mio format]... [(mip proclist] [(mit termlist]
        [(miu userlist]*? [(miU userlist]

<a name="description"></a>

# Description

The
_ps_
utility shall write information about processes, subject to having
appropriate privileges to obtain information about those processes.

By default,
_ps_
shall select all processes with the same effective user ID as the
current user and the same controlling terminal as the invoker.

<a name="options"></a>

# Options

The
_ps_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported:

* **\(mia**  
  Write information for all processes associated with terminals.
  Implementations may omit session leaders from this list.
* **\(miA**  
  Write information for all processes.
* **\(mid**  
  Write information for all processes, except session leaders.
* **\(mie**  
  Write information for all processes.
  (Equivalent to
  **\(miA**.)
* **\(mif**  
  Generate a
  **full**
  listing. (See the STDOUT section for the contents of a
  **full**
  listing.)
* **\(mig&nbsp;grouplist**  
  Write information for processes whose session leaders are given in
  _grouplist_.
  The application shall ensure that the
  _grouplist_
  is a single argument in the form of a
  &lt;blank&gt;
  or
  &lt;comma&gt;-separated
  list.
* **\(miG&nbsp;grouplist**  
  Write information for processes whose real group ID numbers are given
  in
  _grouplist_.
  The application shall ensure that the
  _grouplist_
  is a single argument in the form of a
  &lt;blank&gt;
  or
  &lt;comma&gt;-separated
  list.
* **\(mil**  
  Generate a
  **long**
  listing. (See STDOUT for the contents of a
  **long**
  listing.)
* **\(min&nbsp;namelist**  
  Specify the name of an alternative system
  _namelist_
  file in place of the default. The name of the default file and the
  format of a
  _namelist_
  file are unspecified.
* **\(mio&nbsp;format**  
  Write information according to the format specification given in
  _format_.
  This is fully described in the STDOUT section. Multiple
  **\(mio**
  options can be specified; the format specification shall be interpreted
  as the
  &lt;space&gt;-separated
  concatenation of all the
  _format_
  option-arguments.
* **\(mip&nbsp;proclist**  
  Write information for processes whose process ID numbers are given in
  _proclist_.
  The application shall ensure that the
  _proclist_
  is a single argument in the form of a
  &lt;blank&gt;
  or
  &lt;comma&gt;-separated
  list.
* **\(mit&nbsp;termlist**  
  Write information for processes associated with terminals given in
  _termlist_.
  The application shall ensure that the
  _termlist_
  is a single argument in the form of a
  &lt;blank&gt;
  or
  &lt;comma&gt;-separated
  list. Terminal identifiers shall be given in an implementation-defined
  format.
  On XSI-conformant systems, they shall be given in one of two forms:
  the device's filename (for example,
  **tty04**)
  or, if the device's filename starts with
  **tty**,
  just the identifier following the characters
  **tty**
  (for example,
  **"04"**).
* **\(miu&nbsp;userlist**  
  Write information for processes whose user ID numbers or login names
  are given in
  _userlist_.
  The application shall ensure that the
  _userlist_
  is a single argument in the form of a
  &lt;blank&gt;
  or
  &lt;comma&gt;-separated
  list. In the listing, the numerical user ID shall be written unless the
  **\(mif**
  option is used, in which case the login name shall be written.
* **\(miU&nbsp;userlist**  
  Write information for processes whose real user ID numbers or login
  names are given in
  _userlist_.
  The application shall ensure that the
  _userlist_
  is a single argument in the form of a
  &lt;blank&gt;
  or
  &lt;comma&gt;-separated
  list.

With the exception of
**\(mif**,
**\(mil**,
**\(min**
_namelist_,
and
**\(mio**
_format_,
all of the options shown are used to select processes. If any are
specified, the default list shall be ignored and
_ps_
shall select the processes represented by the inclusive OR of
all the selection-criteria options.

<a name="operands"></a>

# Operands

None.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_ps_:

* _COLUMNS_  
  Override the system-selected horizontal display line size, used to
  determine the number of text columns to display. See the Base Definitions volume of POSIX.1-2008,
  _Chapter 8_, _Environment Variables_
  for valid values and results when it is unset or null.
* _LANG_  
  Provide a default value for the internationalization variables that are
  unset or null. (See the Base Definitions volume of POSIX.1-2008,
  _Section 8.2_, _Internationalization Variables_
  the precedence of internationalization variables used to determine the
  values of locale categories.)
* _LC\_ALL_  
  If set to a non-empty string value, override the values of all the
  other internationalization variables.
* _LC\_CTYPE_  
  Determine the locale for the interpretation of sequences of bytes of
  text data as characters (for example, single-byte as opposed to
  multi-byte characters in arguments).
* _LC\_MESSAGES_    
  Determine the locale that should be used to affect the format and
  contents of diagnostic messages written to standard error and
  informative messages written to standard output.
* _LC\_TIME_  
  Determine the format and contents of the date and time strings
  displayed.
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.
* _TZ_  
  Determine the timezone used to calculate date and time strings
  displayed. If
  _TZ_
  is unset or null, an unspecified default timezone shall be used.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

When the
**\(mio**
option is not specified, the standard output format is unspecified.  

On XSI-conformant systems, the output format shall be as follows.
The column headings and descriptions of the columns in a
_ps_
listing are given below. The precise meanings of these fields are
implementation-defined. The letters
**'f'**
and
**'l'**
(below) indicate the option (\c
**full**
or
**long**)
that shall cause the corresponding heading to appear;
**all**
means that the heading always appears. Note that these two options
determine only what information is provided for a process; they do not
determine which processes are listed.
.TS
tab(@);
lB l lw(11c).
F@(l)@T{
Flags (octal and additive) associated with the process.
T}
S@(l)@The state of the process.
UID@(f,l)@T{
The user ID number of the process owner; the login name is printed
under the
**\(mif**
option.
T}
PID@(all)@T{
The process ID of the process; it is possible to kill a process if this
datum is known.
T}
PPID@(f,l)@The process ID of the parent process.
C@(f,l)@Processor utilization for scheduling.
PRI@(l)@T{
The priority of the process; higher numbers mean lower priority.
T}
NI@(l)@T{
Nice value; used in priority computation.
T}
ADDR@(l)@The address of the process.
SZ@(l)@T{
The size in blocks of the core image of the process.
T}
WCHAN@(l)@T{
The event for which the process is waiting or sleeping; if blank, the
process is running.
T}
STIME@(f)@Starting time of the process.
TTY@(all)@The controlling terminal for the process.
TIME@(all)@T{
The cumulative execution time for the process.
T}
CMD@(all)@T{
The command name; the full command name and its arguments are written
under the
**\(mif**
option.
T}
.TE

A process that has exited and has a parent, but has not yet been waited
for by the parent, shall be marked
**defunct**.

Under the option
**\(mif**,
_ps_
tries to determine the command name and arguments given when the
process was created by examining memory or the swap area. Failing
this, the command name, as it would appear without the option
**\(mif**,
is written in square brackets.

The
**\(mio**
option allows the output format to be specified under user control.

The application shall ensure that the format specification is a list of
names presented as a single argument,
&lt;blank&gt;
or
&lt;comma&gt;-separated.
Each variable has a default header. The default header can be overridden
by appending an
&lt;equals-sign&gt;
and the new text of the header. The rest of the characters in the
argument shall be used as the header text. The fields specified shall
be written in the order specified on the command line, and should be
arranged in columns in the output. The field widths shall be selected
by the system to be at least as wide as the header text (default or
overridden value). If the header text is null, such as
**\(mio**
_user_=,
the field width shall be at least as wide as the default header text.
If all header text fields are null, no header line shall be written.

The following names are recognized in the POSIX locale:

* **ruser**  
  The real user ID of the process. This shall be the textual user ID, if
  it can be obtained and the field width permits, or a decimal
  representation otherwise.
* **user**  
  The effective user ID of the process. This shall be the textual user
  ID, if it can be obtained and the field width permits, or a decimal
  representation otherwise.
* **rgroup**  
  The real group ID of the process. This shall be the textual group ID,
  if it can be obtained and the field width permits, or a decimal
  representation otherwise.
* **group**  
  The effective group ID of the process. This shall be the textual group
  ID, if it can be obtained and the field width permits, or a decimal
  representation otherwise.
* **pid**  
  The decimal value of the process ID.
* **ppid**  
  The decimal value of the parent process ID.
* **pgid**  
  The decimal value of the process group ID.
* **pcpu**  
  The ratio of CPU time used recently to CPU time available in the same
  period, expressed as a percentage. The meaning of \`\`recently'' in this
  context is unspecified. The CPU time available is determined in an
  unspecified manner.
* **vsz**  
  The size of the process in (virtual) memory in 1\|024 byte units as a
  decimal integer.
* **nice**  
  The decimal value of the nice value of the process; see
  _nice_.
* **etime**  
  In the POSIX locale, the elapsed time since the process was started, in
  the form:

    
    [[dd(mi]hh:]mm:ss


where
_dd_
shall represent the number of days,
_hh_
the number of hours,
_mm_
the number of minutes, and
_ss_
the number of seconds. The
_dd_
field shall be a decimal integer. The
_hh_,
_mm_,
and
_ss_
fields shall be two-digit decimal integers padded on the left with
zeros.

* **time**  
  In the POSIX locale, the cumulative CPU time of the process in the
  form:

    
    [dd(mi]hh:mm:ss


The
_dd_,
_hh_,
_mm_,
and
_ss_
fields shall be as described in the
**etime**
specifier.

* **tty**  
  The name of the controlling terminal of the process (if any) in the
  same format used by the
  _who_
  utility.
* **comm**  
  The name of the command being executed (\c
  _argv_[0]
  value) as a string.
* **args**  
  The command with all its arguments as a string. The implementation may
  truncate this value to the field width; it is implementation-defined
  whether any further truncation occurs. It is unspecified whether the
  string represented is a version of the argument list as it was passed
  to the command when it started, or is a version of the arguments as
  they may have been modified by the application. Applications cannot
  depend on being able to modify their argument list and having that
  modification be reflected in the output of
  _ps_.

Any field need not be meaningful in all implementations. In such a
case a
&lt;hyphen&gt;
(\c
**'\(mi'**)
should be output in place of the field value.

Only
**comm**
and
**args**
shall be allowed to contain
&lt;blank&gt;
characters; all others shall not. Any implementation-defined variables
shall be specified in the system documentation along with the default
header and indicating whether the field may contain
&lt;blank&gt;
characters.

The following table specifies the default header to be used in the
POSIX locale corresponding to each format specifier.  

.ce 1
**TableNames: Variable**
.TS
center tab(@) box;
cB cB | cB cB
lB lB | lB lB.
Format Specifier@Default Header@Format Specifier@Default Header
_
args@COMMAND@ppid@PPID
comm@COMMAND@rgroup@RGROUP
etime@ELAPSED@ruser@RUSER
group@GROUP@time@TIME
nice@NI@tty@TT
pcpu@%CPU@user@USER
pgid@PGID@vsz@VSZ
pid@PID
.TE

<a name="stderr"></a>

# Stderr

The standard error shall be used only for diagnostic messages.

<a name="output-files"></a>

# Output Files

None.

<a name="extended-description"></a>

# Extended Description

None.

<a name="exit-status"></a>

# Exit Status

The following exit values shall be returned:

* \00  
  Successful completion.
* &gt;0  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

Things can change while
_ps_
is running; the snapshot it gives is only true for an instant, and
might not be accurate by the time it is displayed.

The
**args**
format specifier is allowed to produce a truncated version of the
command arguments. In some implementations, this information is no
longer available when the
_ps_
utility is executed.

If the field width is too narrow to display a textual ID, the system
may use a numeric version. Normally, the system would be expected to
choose large enough field widths, but if a large number of fields were
selected to write, it might squeeze fields to their minimum sizes to
fit on one line. One way to ensure adequate width for the textual IDs
is to override the default header for a field to make it larger than
most or all user or group names.

There is no special quoting mechanism for header text. The header text
is the rest of the argument. If multiple header changes are needed,
multiple
**\(mio**
options can be used, such as:

    
    ps (mio "user=User Name" (mio pid=Processe ID


On some implementations, especially multi-level secure systems,
_ps_
may be severely restricted and produce information only about child
processes owned by the user.

<a name="examples"></a>

# Examples

The command:

    
    ps (mio user,pid,ppid=MOM (mio args


writes at least the following in the POSIX locale:

    
      USER   PID   MOM   COMMAND
    helene    34    12   ps (mio uid,pid,ppid=MOM (mio args


The contents of the
**COMMAND**
field need not be the same in all implementations, due to possible
truncation.

<a name="rationale"></a>

# Rationale

There is very little commonality between BSD and System V
implementations of
_ps_.
Many options conflict or have subtly different usages. The standard
developers attempted to select a set of options for the base standard
that were useful on a wide range of systems and selected options that
either can be implemented on both BSD and System V-based systems
without breaking the current implementations or where the options are
sufficiently similar that any changes would not be unduly problematic
for users or implementors.

It is recognized that on some implementations, especially multi-level
secure systems,
_ps_
may be nearly useless. The default output has therefore been chosen
such that it does not break historical implementations and also is
likely to provide at least some useful information on most systems.

The major change is the addition of the format specification
capability. The motivation for this invention is to provide a mechanism
for users to access a wider range of system information, if the system
permits it, in a portable manner. The fields chosen to appear in this volume of POSIX.1-2008
were arrived at after considering what concepts were likely to be both
reasonably useful to the \`\`average'' user and had a reasonable chance
of being implemented on a wide range of systems. Again it is recognized
that not all systems are able to provide all the information and,
conversely, some may wish to provide more. It is hoped that the
approach adopted will be sufficiently flexible and extensible to
accommodate most systems. Implementations may be expected to introduce
new format specifiers.

The default output should consist of a short listing containing the
process ID, terminal name, cumulative execution time, and command name
of each process.

The preference of the standard developers would have been to make the
format specification an operand of the
_ps_
command. Unfortunately, BSD usage precluded this.

At one time a format was included to display the environment array of
the process. This was deleted because there is no portable way to
display it.

The
**\(miA**
option is equivalent to the BSD
**\(mig**
and the SVID
**\(mie**.
Because the two systems differed, a mnemonic compromise was selected.

The
**\(mia**
option is described with some optional behavior because the SVID omits
session leaders, but BSD does not.

In an early proposal, format specifiers appeared for priority and start
time. The former was not defined adequately in this volume of POSIX.1-2008 and was removed in
deference to the defined nice value; the latter because elapsed time
was considered to be more useful.

In a new BSD version of
_ps_,
a
**\(miO**
option can be used to write all of the default information, followed by
additional format specifiers. This was not adopted because the default
output is implementation-defined. Nevertheless, this is a useful
option that should be reserved for that purpose. In the
**\(mio**
option for the POSIX Shell and Utilities
_ps_,
the format is the concatenation of each
**\(mio**.
Therefore, the user can have an alias or function that defines the
beginning of their desired format and add more fields to the end of the
output in certain cases where that would be useful.

The format of the terminal name is unspecified, but the descriptions of
_ps_,
_talk_,
_who_,
and
_write_
require that they all use the same format.

The
**pcpu**
field indicates that the CPU time available is determined in an
unspecified manner. This is because it is difficult to express an
algorithm that is useful across all possible machine architectures.
Historical counterparts to this value have attempted to show percentage
of use in the recent past, such as the preceding minute. Frequently,
these values for all processes did not add up to 100%. Implementations
are encouraged to provide data in this field to users that will help
them identify processes currently affecting the performance of the
system.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__kill_\^_,
__nice_\^_,
__renice_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
_Section 12.2_, _Utility Syntax Guidelines_

<a name="copyright"></a>

# Copyright

Portions of this text are reprinted and reproduced in electronic form
from IEEE Std 1003.1, 2013 Edition, Standard for Information Technology
-- Portable Operating System Interface (POSIX), The Open Group Base
Specifications Issue 7, Copyright (C) 2013 by the Institute of
Electrical and Electronics Engineers, Inc and The Open Group.
(This is POSIX.1-2008 with the 2013 Technical Corrigendum 1 applied.) In the
event of any discrepancy between this version and the original IEEE and
The Open Group Standard, the original IEEE and The Open Group Standard
is the referee document. The original Standard can be obtained online at
http://www.unix.org/online.html .

Any typographical or formatting errors that appear
in this page are most likely
to have been introduced during the conversion of the source files to
man page format. To report such errors, see
https://www.kernel.org/doc/man-pages/reporting_bugs.html .
