# read(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

read
— read a line from standard input

<a name="synopsis"></a>

# Synopsis

```


```
    read [(mir] var...

<a name="description"></a>

# Description

The
_read_
utility shall read a single line from standard input.

By default, unless the
**\(mir**
option is specified,
&lt;backslash&gt;
shall act as an escape character. An unescaped
&lt;backslash&gt;
shall preserve the literal value of the following character, with the
exception of a
&lt;newline&gt;.
If a
&lt;newline&gt;
follows the
&lt;backslash&gt;,
the
_read_
utility shall interpret this as line continuation. The
&lt;backslash&gt;
and
&lt;newline&gt;
shall be removed before splitting the input into fields. All other
unescaped
&lt;backslash&gt;
characters shall be removed after splitting the input into fields.

If standard input is a terminal device and the invoking shell is
interactive,
_read_
shall prompt for a continuation line when it reads an input line ending
with a
&lt;backslash&gt;
&lt;newline&gt;,
unless the
**\(mir**
option is specified.

The terminating
&lt;newline&gt;
(if any) shall be removed from the input and the results shall be split
into fields as in the shell for the results of parameter expansion (see
_Section 2.6.5_, _Field Splitting_);
the first field shall be assigned to the first variable
_var_,
the second field to the second variable
_var_,
and so on. If there are fewer fields than there are
_var_
operands, the remaining
_var_s
shall be set to empty strings. If there are fewer
_var_s
than fields, the last
_var_
shall be set to a value comprising the following elements:

*  *  
  The field that corresponds to the last
  _var_
  in the normal assignment sequence described above
*  *  
  The delimiter(s) that follow the field corresponding to the last
  _var_
*  *  
  The remaining fields and their delimiters, with trailing
  _IFS_
  white space ignored

The setting of variables specified by the
_var_
operands shall affect the current shell execution environment; see
_Section 2.12_, _Shell Execution Environment_.
If it is called in a subshell or separate utility execution
environment, such as one of the following:

    
    (read foo)
    nohup read ...
    find . (miexec read ... e;


it shall not affect the shell variables in the caller's environment.

<a name="options"></a>

# Options

The
_read_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following option is supported:

* **\(mir**  
  Do not treat a
  &lt;backslash&gt;
  character in any special way. Consider each
  &lt;backslash&gt;
  to be part of the input line.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _var_  
  The name of an existing or nonexisting shell variable.

<a name="stdin"></a>

# Stdin

The standard input shall be a text file.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_read_:

* _IFS_  
  Determine the internal field separators used to delimit fields; see
  _Section 2.5.3_, _Shell Variables_.
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
* _PS2_  
  Provide the prompt string that an interactive shell shall write to
  standard error when a line ending with a
  &lt;backslash&gt;
  &lt;newline&gt;
  is read and the
  **\(mir**
  option was not specified.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

Not used.

<a name="stderr"></a>

# Stderr

The standard error shall be used for diagnostic messages and
prompts for continued input.

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
  End-of-file was detected or an error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

The
**\(mir**
option is included to enable
_read_
to subsume the purpose of the
_line_
utility, which is not included in POSIX.1-2008.

<a name="examples"></a>

# Examples

The following command:

    
    while read (mir xx yy
    do
        printf "%s %sen$yy$xx"
    done < input_file


prints a file with the first field of each line moved to the end of the
line.

<a name="rationale"></a>

# Rationale

The
_read_
utility historically has been a shell built-in. It was separated off
into its own utility to take advantage of the richer description of
functionality introduced by this volume of POSIX.1-2008.

Since
_read_
affects the current shell execution environment,
it is generally provided as a shell regular built-in. If it is called
in a subshell or separate utility execution environment, such as one of
the following:

    
    (read foo)
    nohup read ...
    find . (miexec read ... e;


it does not affect the shell variables in the environment of the
caller.

Although the standard input is required to be a text file, and
therefore will always end with a
&lt;newline&gt;
(unless it is an empty file), the processing of continuation lines
when the
**\(mir**
option is not used can result in the input not ending with a
&lt;newline&gt;.
This occurs if the last line of the input file ends with a
&lt;backslash&gt;
&lt;newline&gt;.
It is for this reason that \`\`if any'' is used in \`\`The terminating
&lt;newline&gt;
(if any) shall be removed from the input'' in the description.
It is not a relaxation of the requirement for standard input to
be a text file.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

_Chapter 2_, _Shell Command Language_

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
