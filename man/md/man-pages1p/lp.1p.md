# lp(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

lp
— send files to a printer

<a name="synopsis"></a>

# Synopsis

```


```
    lp [(mic] [(mid dest] [(min copies] [(mimsw] [(mio option]... [(mit title] [file...]

<a name="description"></a>

# Description

The
_lp_
utility shall copy the input files to an output destination in an
unspecified manner. The default output destination should be to a
hardcopy device, such as a printer or microfilm recorder, that produces
non-volatile, human-readable documents. If such a device is not
available to the application, or if the system provides no such device,
the
_lp_
utility shall exit with a non-zero exit status.

The actual writing to the output device may occur some time after the
_lp_
utility successfully exits. During the portion of the writing that
corresponds to each input file, the implementation shall guarantee
exclusive access to the device.

The
_lp_
utility shall associate a unique
_request ID_
with each request.

Normally, a banner page is produced to separate and identify each print
job. This page may be suppressed by implementation-defined
conditions, such as an operator command or one of the
**\(mio**
_option_
values.

<a name="options"></a>

# Options

The
_lp_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported:

* **\(mic**  
  Exit only after further access to any of the input files is no longer
  required. The application can then safely delete or modify the files
  without affecting the output operation. Normally, files are not
  copied, but are linked whenever possible. If the
  **\(mic**
  option is not given, then the user should be careful not to remove any
  of the files before the request has been printed in its entirety. It
  should also be noted that in the absence of the
  **\(mic**
  option, any changes made to the named files after the request is made
  but before it is printed may be reflected in the printed output.
  On some implementations,
  **\(mic**
  may be on by default.
* **\(mid&nbsp;dest**  
  Specify a string that names the destination (\c
  _dest_).
  If
  _dest_
  is a printer, the request shall be printed only on that specific
  printer. If
  _dest_
  is a class of printers, the request shall be printed on the first
  available printer that is a member of the class. Under certain
  conditions (printer unavailability, file space limitation, and so on),
  requests for specific destinations need not be accepted. Destination
  names vary between systems.

If
**\(mid**
is not specified, and neither the
_LPDEST_
nor
_PRINTER_
environment variable is set, an unspecified destination is used. The
**\(mid**
_dest_
option shall take precedence over
_LPDEST_,
which in turn shall take precedence over
_PRINTER_.
Results are undefined when
_dest_
contains a value that is not a valid destination name.

* **\(mim**  
  Send mail (see
  __mailx_\^_)
  after the files have been printed. By default, no mail is sent upon
  normal completion of the print request.
* **\(min&nbsp;copies**  
  Write
  _copies_
  number of copies of the files, where
  _copies_
  is a positive decimal integer. The methods for producing multiple
  copies and for arranging the multiple copies when multiple
  _file_
  operands are used are unspecified, except that each file shall be
  output as an integral whole, not interleaved with portions of other
  files.
* **\(mio&nbsp;option**  
  Specify printer-dependent or class-dependent
  _option_s.
  Several such
  _option_s
  may be collected by specifying the
  **\(mio**
  option more than once.
* **\(mis**  
  Suppress messages from
  _lp_.
* **\(mit&nbsp;title**  
  Write
  _title_
  on the banner page of the output.
* **\(miw**  
  Write a message on the user's terminal after the files have been
  printed. If the user is not logged in, then mail shall be sent
  instead.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _file_  
  A pathname of a file to be output. If no
  _file_
  operands are specified, or if a
  _file_
  operand is
  **'\(mi'**,
  the standard input shall be used. If a
  _file_
  operand is used, but the
  **\(mic**
  option is not specified, the process performing the writing to the
  output device may have user and group permissions that differ from that
  of the process invoking
  _lp_.

<a name="stdin"></a>

# Stdin

The standard input shall be used only if no
_file_
operands are specified, or if a
_file_
operand is
**'\(mi'**.
See the INPUT FILES section.

<a name="input-files"></a>

# Input Files

The input files shall be text files.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_lp_:

* _LANG_  
  Provide a default value for the internationalization variables that are
  unset or null. (See the Base Definitions volume of POSIX.1-2008,
  _Section 8.2_, _Internationalization Variables_
  for the precedence of internationalization variables used to determine
  the values of locale categories.)
* _LC\_ALL_  
  If set to a non-empty string value, override the values of all the
  other internationalization variables.
* _LC\_CTYPE_  
  Determine the locale for the interpretation of sequences of bytes of
  text data as characters (for example, single-byte as opposed to
  multi-byte characters in arguments and input files).
* _LC\_MESSAGES_    
  Determine the locale that should be used to affect the format and
  contents of diagnostic messages written to standard error and
  informative messages written to standard output.
* _LC\_TIME_  
  Determine the format and contents of date and time strings displayed in
  the
  _lp_
  banner page, if any.
* _LPDEST_  
  Determine the destination. If the
  _LPDEST_
  environment variable is not set, the
  _PRINTER_
  environment variable shall be used. The
  **\(mid**
  _dest_
  option takes precedence over
  _LPDEST_.
  Results are undefined when
  **\(mid**
  is not specified and
  _LPDEST_
  contains a value that is not a valid destination name.
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.
* _PRINTER_  
  Determine the output device or destination. If the
  _LPDEST_
  and
  _PRINTER_
  environment variables are not set, an unspecified output device is
  used. The
  **\(mid**
  _dest_
  option and the
  _LPDEST_
  environment variable shall take precedence over
  _PRINTER_.
  Results are undefined when
  **\(mid**
  is not specified,
  _LPDEST_
  is unset, and
  _PRINTER_
  contains a value that is not a valid device or destination name.
* _TZ_  
  Determine the timezone used to calculate date and time strings
  displayed in the
  _lp_
  banner page, if any. If
  _TZ_
  is unset or null, an unspecified default timezone shall be used.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

The
_lp_
utility shall write a
_request ID_
to the standard output, unless
**\(mis**
is specified. The format of the message is unspecified. The request
ID can be used on systems supporting the historical
_cancel_
and
_lpstat_
utilities.

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
  All input files were processed successfully.
* &gt;0  
  No output device was available, or an error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

The
_pr_
and
_fold_
utilities can be used to achieve reasonable formatting for the
implementation's default page size.

A conforming application can use one of the
_file_
operands only with the
**\(mic**
option or if the file is publicly readable and guaranteed to be
available at the time of printing. This is because POSIX.1-2008 gives
the implementation the freedom to queue up the request for printing at
some later time by a different process that might not be able to access
the file.

<a name="examples"></a>

# Examples


*  1.  
  To print file
  _file_:

    
    lp (mic file


*  2.  
  To print multiple files with headers:

    
    pr file1 file2 | lp


<a name="rationale"></a>

# Rationale

The
_lp_
utility was designed to be a basic version of a utility that is already
available in many historical implementations. The standard developers
considered that it should be implementable simply as:

    
    cat "$@" > /dev/lp


after appropriate processing of options, if that is how the
implementation chose to do it and if exclusive access could be granted
(so that two users did not write to the device simultaneously).
Although in the future the standard developers may add other options to
this utility, it should always be able to execute with no options or
operands and send the standard input to an unspecified output device.

This volume of POSIX.1-2008 makes no representations concerning the format of the printed
output, except that it must be \`\`human-readable'' and \`\`non-volatile''.
Thus, writing by default to a disk or tape drive or a display terminal
would not qualify. (Such destinations are not prohibited when
**\(mid**
_dest_,
_LPDEST_,
or
_PRINTER_
are used, however.)

This volume of POSIX.1-2008 is worded such that a \`\`print job'' consisting of multiple input
files, possibly in multiple copies, is guaranteed to print so that any
one file is not intermixed with another, but there is no statement that
all the files or copies have to print out together.

The
**\(mic**
option may imply a spooling operation, but this is not required. The
utility can be implemented to wait until the printer is ready and then
wait until it is finished. Because of that, there is no attempt to
define a queuing mechanism (priorities, classes of output, and so on).

On some historical systems, the request ID reported on the STDOUT
can be used to later cancel or find the status of a request using
utilities not defined in this volume of POSIX.1-2008.

Although the historical System V
_lp_
and BSD
_lpr_
utilities have provided similar functionality, they used different
names for the environment variable specifying the destination printer.
Since the name of the utility here is
_lp_,
_LPDEST_
(used by the System V
_lp_
utility) was given precedence over
_PRINTER_
(used by the BSD
_lpr_
utility). Since environments of users frequently contain one or the
other environment variable, the
_lp_
utility is required to recognize both. If this was not done, many
applications would send output to unexpected output devices when users
moved from system to system.

Some have commented that
_lp_
has far too little functionality to make it worthwhile. Requests have
proposed additional options or operands or both that added
functionality. The requests included:

*  *  
  Wording
  _requiring_
  the output to be \`\`hardcopy''
*  *  
  A requirement for multiple printers
*  *  
  Options for supporting various page-description languages

Given that a compliant system is not required to even have a printer,
placing further restrictions upon the behavior of the printer is not
useful. Since hardcopy format is so application-dependent, it is
difficult, if not impossible, to select a reasonable subset of
functionality that should be required on all compliant systems.

The term _unspecified_ is used in this section in lieu of
_implementation-defined_ as most known implementations would not be
able to make definitive statements in their conformance documents; the
existence and usage of printers is very dependent on how the system
administrator configures each individual system.

Since the default destination, device type, queuing mechanisms, and
acceptable forms of input are all unspecified, usage guidelines for
what a conforming application can do are as follows:

*  *  
  Use the command in a pipeline, or with
  **\(mic**,
  so that there are no permission problems and the files can be safely
  deleted or modified.
*  *  
  Limit output to text files of reasonable line lengths and printable
  characters and include no device-specific formatting information, such
  as a page description language. The meaning of \`\`reasonable'' in this
  context can only be answered as a quality-of-implementation issue, but
  it should be apparent from historical usage patterns in the industry
  and the locale. The
  _pr_
  and
  _fold_
  utilities can be used to achieve reasonable formatting for the default
  page size of the implementation.

Alternatively, the application can arrange its installation in such a
way that it requires the system administrator or operator to provide
the appropriate information on
_lp_
options and environment variable values.

At a minimum, having this utility in this volume of POSIX.1-2008 tells the industry that
conforming applications require a means to print output and provides at
least a command name and
_LPDEST_
routing mechanism that can be used for discussions between vendors,
application developers, and users. The use of \`\`should'' in the
DESCRIPTION of
_lp_
clearly shows the intent of the standard developers, even if they
cannot mandate that all systems (such as laptops) have printers.

This volume of POSIX.1-2008 does not specify what the ownership of the process performing the
writing to the output device may be. If
**\(mic**
is not used, it is unspecified whether the process performing the
writing to the output device has permission to read
_file_
if there are any restrictions in place on who may read
_file_
until after it is printed. Also, if
**\(mic**
is not used, the results of deleting
_file_
before it is printed are unspecified.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__mailx_\^_

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
