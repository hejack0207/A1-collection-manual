# tabs(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

tabs
— set terminal tabs

<a name="synopsis"></a>

# Synopsis

```


```
    tabs [(min|(mia|(mia2|(mic|(mic2|(mic3|(mif|(mip|(mis|(miu] [(miT type]
    
    tabs [(miT type] n[[sep[+]n]...]

<a name="description"></a>

# Description

The
_tabs_
utility shall display a series of characters that first clears the
hardware terminal tab settings and then initializes the tab stops at
the specified positions
and optionally adjusts the margin.

The phrase \`\`tab-stop position
_N_''
shall be taken to mean that, from the start of a line of output,
tabbing to position
_N_
shall cause the next character output to be in the (\c
_N_+1)th
column position on that line. The maximum number of tab stops allowed
is terminal-dependent.

It need not be possible to implement
_tabs_
on certain terminals. If the terminal type obtained from the
_TERM_
environment variable or
**\(miT**
option represents such a terminal, an appropriate diagnostic message
shall be written to standard error and
_tabs_
shall exit with a status greater than zero.

<a name="options"></a>

# Options

The
_tabs_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_,
except for various extensions: the options
**\(mia2**,
**\(mic2**,
and
**\(mic3**
are multi-character.

The following options shall be supported:

* **\(min**  
  Specify repetitive tab stops separated by a uniform number of column
  positions,
  _n_,
  where
  _n_
  is a single-digit decimal number. The default usage of
  _tabs_
  with no arguments shall be equivalent to
  _tabs_
  \(mi8. When
  **\(mi0**
  is used, the tab stops shall be cleared and no new ones set.
* **\(mia**  
  1,10,16,36,72  
  Assembler, applicable to some mainframes.
* **\(mia2**  
  1,10,16,40,72  
  Assembler, applicable to some mainframes.
* **\(mic**  
  1,8,12,16,20,55  
  COBOL, normal format.
* **\(mic2**  
  1,6,10,14,49  
  COBOL, compact format (columns 1 to 6 omitted).
* **\(mic3**  
  1,6,10,14,18,22,26,30,34,38,42,46,50,54,58,62,67  
  COBOL compact format (columns 1 to 6 omitted), with more tabs than
  **\(mic2**.
* **\(mif**  
  1,7,11,15,19,23  
  FORTRAN
* **\(mip**  
  1,5,9,13,17,21,25,29,33,37,41,45,49,53,57,61  
  PL/1
* **\(mis**  
  1,10,55  
  SNOBOL
* **\(miu**  
  1,12,20,44  
  Assembler, applicable to some mainframes.
* **\(miT&nbsp;type**  
  Indicate the type of terminal. If this option is not supplied and the
  _TERM_
  variable is unset or null, an unspecified default terminal type shall
  be used. The setting of
  _type_
  shall take precedence over the value in
  _TERM_.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* n**[[sep[**+**]n]**...**]**  
  A single command line argument that consists of one or more tab-stop
  values (\c
  _n_)
  separated by a separator character (\c
  _sep_)
  which is either a
  &lt;comma&gt;
  or a
  &lt;blank&gt;
  character. The application shall ensure that the tab-stop values are
  positive decimal integers in strictly ascending order. If any tab-stop
  value (except the first one) is preceded by a
  &lt;plus-sign&gt;,
  it is taken as an increment to be added to the previous value. For
  example, the tab lists 1,10,20,30 and
  **"1**10**+10**+10"
  are considered to be identical.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_tabs_:

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
  multi-byte characters in arguments).
* _LC\_MESSAGES_    
  Determine the locale that should be used to affect the format and
  contents of diagnostic messages written to standard error.
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.
* _TERM_  
  Determine the terminal type. If this variable is unset or null, and if
  the
  **\(miT**
  option is not specified, an unspecified default terminal type shall be
  used.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

If standard output is a terminal, the appropriate sequence to clear and
set the tab stops may be written to standard output in an unspecified
format. If standard output is not a terminal, undefined results
occur.

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

This utility makes use of the terminal's hardware tabs and the
_stty_
_tabs_
option.

This utility is not recommended for application use.

Some integrated display units might not have escape sequences to set
tab stops, but may be set by internal system calls. On these
terminals,
_tabs_
works if standard output is directed to the terminal; if output is
directed to another file, however,
_tabs_
fails.

<a name="examples"></a>

# Examples

None.

<a name="rationale"></a>

# Rationale

Consideration was given to having the
_tput_
utility handle all of the functions described in
_tabs_.
However, the separate
_tabs_
utility was retained because it seems more intuitive to use a command
named
_tabs_
than
_tput_
with a new option. The
_tput_
utility does not support setting or clearing tabs, and no known
historical version of
_tabs_
supports the capability of setting arbitrary tab stops.

The System V
_tabs_
interface is very complex; the version in this volume of POSIX.1-2008 has a reduced feature
list, but many of the features omitted were restored as part of the
XSI option even though the supported languages and coding styles are
primarily historical.

There was considerable sentiment for specifying only a means of
resetting the tabs back to a known state—presumably the \`\`standard''
of tabs every eight positions. The following features were omitted:

*  *  
  Setting tab stops via the first line in a file, using \(mi\|\(mi\c
  _file_.
  Since even the SVID has no complete explanation of this feature, it is
  doubtful that it is in widespread use.

In an early proposal, a
**\(mit**
_tablist_
option was added for consistency with
_expand_;
this was later removed when inconsistencies with the historical list of
tabs were identified.

Consideration was given to adding a
**\(mip**
option that would output the current tab settings so that they could be
saved and then later restored. This was not accepted because querying
the tab stops of the terminal is not a capability in historical
_terminfo_
or
_termcap_
facilities and might not be supported on a wide range of terminals.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__expand_\^_,
__stty_\^_,
__tput_\^_,
__unexpand_\^_

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
