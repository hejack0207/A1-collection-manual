# cat(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

cat
— concatenate and print files

<a name="synopsis"></a>

# Synopsis

```


```
    cat [(miu] [file...]

<a name="description"></a>

# Description

The
_cat_
utility shall read files in sequence and shall write their contents
to the standard output in the same sequence.

<a name="options"></a>

# Options

The
_cat_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following option shall be supported:

* **\(miu**  
  Write bytes from the input file to the standard output without delay as
  each is read.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _file_  
  A pathname of an input file. If no
  _file_
  operands are specified, the standard input shall be used. If a
  _file_
  is
  **'\(mi'**,
  the
  _cat_
  utility shall read from the standard input at that point in the
  sequence. The
  _cat_
  utility shall not close and reopen standard input when it is referenced
  in this way, but shall accept multiple occurrences of
  **'\(mi'**
  as a
  _file_
  operand.

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

The input files can be any file type.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_cat_:

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

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

The standard output shall contain the sequence of bytes read from the
input files. Nothing else shall be written to the standard output.

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
  All input files were output successfully.
* &gt;0  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

The
**\(miu**
option has value in prototyping non-blocking reads from FIFOs. The
intent is to support the following sequence:

    
    mkfifo foo
    cat (miu foo > /dev/tty13 &
    cat (miu > foo


It is unspecified whether standard output is or is not buffered in the
default case. This is sometimes of interest when standard output is
associated with a terminal, since buffering may delay the output. The
presence of the
**\(miu**
option guarantees that unbuffered I/O is available. It is
implementation-defined whether the
_cat_
utility buffers output if the
**\(miu**
option is not specified. Traditionally, the
**\(miu**
option is implemented using the equivalent of the
_setvbuf_()
function defined in the System Interfaces volume of POSIX.1-2008.

<a name="examples"></a>

# Examples

The following command:

    
    cat myfile


writes the contents of the file
**myfile**
to standard output.

The following command:

    
    cat doc1 doc2 > doc.all


concatenates the files
**doc1**
and
**doc2**
and writes the result to
**doc.all**.

Because of the shell language mechanism used to perform output
redirection, a command such as this:

    
    cat doc doc.end > doc


causes the original data in
**doc**
to be lost.

The command:

    
    cat start (mi middle (mi end > file


when standard input is a terminal, gets two arbitrary pieces of input
from the terminal with a single invocation of
_cat_.
Note, however, that if standard input is a regular file, this would be
equivalent to the command:

    
    cat start (mi middle /dev/null end > file


because the entire contents of the file would be consumed by
_cat_
the first time
**'\(mi'**
was used as a
_file_
operand and an end-of-file condition would be detected immediately when
**'\(mi'**
was referenced the second time.

<a name="rationale"></a>

# Rationale

Historical versions of the
_cat_
utility include the
**\(mie**,
**\(mit**,
and
**\(miv**,
options which permit the ends of lines,
&lt;tab&gt;
characters, and invisible characters, respectively, to be rendered visible
in the output. The standard developers omitted these options because
they provide too fine a degree of control over what is made visible,
and similar output can be obtained using a command such as:

    
    sed (min l pathname


The latter also has the advantage that its output is unambiguous,
whereas the output of historical
_cat_
**\(mietv**
is not.

The
**\(mis**
option was omitted because it corresponds to different functions in BSD
and System V-based systems. The BSD
**\(mis**
option to squeeze blank lines can be accomplished by the shell script
shown in the following example:

    
    sed (min '
    # Write non-empty lines.
    /./   {
          p
          d
          }
    # Write a single empty line, then look for more empty lines.
    /^$/  p
    # Get next line, discard the held <newline> (empty line),
    # and look for more empty lines.
    :Empty
    /^$/  {
          N
          s/.//
          b Empty
          }
    # Write the non-empty line before going back to search
    # for the first in a set of empty lines.
          p
    '


The System V
**\(mis**
option to silence error messages can be accomplished by redirecting the
standard error. Note that the BSD documentation for
_cat_
uses the term \`\`blank line'' to mean the same as the POSIX \`\`empty
line'': a line consisting only of a
&lt;newline&gt;.

The BSD
**\(min**
option was omitted because similar functionality can be obtained from
the
**\(min**
option of the
_pr_
utility.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__more_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
_Section 12.2_, _Utility Syntax Guidelines_

The System Interfaces volume of POSIX.1-2008,
__setvbuf_\^(\|)_

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
