# file(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

file
— determine file type

<a name="synopsis"></a>

# Synopsis

```


```
    file [(midh] [(miM file] [(mim file] file...
    
    file (mii [(mih] file...

<a name="description"></a>

# Description

The
_file_
utility shall perform a series of tests in sequence on each specified
_file_
in an attempt to classify it:

*  1.  
  If
  _file_
  does not exist, cannot be read, or its file status could not be
  determined, the output shall indicate that the file was processed, but
  that its type could not be determined.
*  2.  
  If the file is not a regular file, its file type shall be identified.
  The file types directory, FIFO, socket, block special, and character
  special shall be identified as such. Other implementation-defined file
  types may also be identified. If
  _file_
  is a symbolic link, by default the link shall be resolved and
  _file_
  shall test the type of file referenced by the symbolic link. (See the
  **\(mih**
  and
  **\(mii**
  options below.)
*  3.  
  If the length of
  _file_
  is zero, it shall be identified as an empty file.
*  4.  
  The
  _file_
  utility shall examine an initial segment of
  _file_
  and shall make a guess at identifying its contents based on
  position-sensitive tests. (The answer is not guaranteed to be correct;
  see the
  **\(mid**,
  **\(miM**,
  and
  **\(mim**
  options below.)
*  5.  
  The
  _file_
  utility shall examine
  _file_
  and make a guess at identifying its contents based on context-sensitive
  default system tests. (The answer is not guaranteed to be correct.)
*  6.  
  The file shall be identified as a data file.

If
_file_
does not exist, cannot be read, or its file status could not be
determined, the output shall indicate that the file was processed, but
that its type could not be determined.

If
_file_
is a symbolic link, by default the link shall be resolved and
_file_
shall test the type of file referenced by the symbolic link.

<a name="options"></a>

# Options

The
_file_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_,
except that the order of the
**\(mim**,
**\(mid**,
and
**\(miM**
options shall be significant.

The following options shall be supported by the implementation:

* **\(mid**  
  Apply any position-sensitive default system tests and
  context-sensitive default system tests to the file. This is the
  default if no
  **\(miM**
  or
  **\(mim**
  option is specified.
* **\(mih**  
  When a symbolic link is encountered, identify the file as a symbolic
  link. If
  **\(mih**
  is not specified and
  _file_
  is a symbolic link that refers to a nonexistent file,
  _file_
  shall identify the file as a symbolic link, as if
  **\(mih**
  had been specified.
* **\(mii**  
  If a file is a regular file, do not attempt to classify the type of the
  file further, but identify the file as specified in the STDOUT section.
* **\(miM&nbsp;file**  
  Specify the name of a file containing position-sensitive tests that
  shall be applied to a file in order to classify it (see the EXTENDED
  DESCRIPTION). No position-sensitive default system tests nor
  context-sensitive default system tests shall be applied unless the
  **\(mid**
  option is also specified.
* **\(mim&nbsp;file**  
  Specify the name of a file containing position-sensitive tests that
  shall be applied to a file in order to classify it (see the EXTENDED
  DESCRIPTION).

If the
**\(mim**
option is specified without specifying the
**\(mid**
option or the
**\(miM**
option, position-sensitive default system tests shall be applied after
the position-sensitive tests specified by the
**\(mim**
option. If the
**\(miM**
option is specified with the
**\(mid**
option, the
**\(mim**
option, or both, or the
**\(mim**
option is specified with the
**\(mid**
option, the concatenation of the position-sensitive tests specified by
these options shall be applied in the order specified by the appearance
of these options. If a
**\(miM**
or
**\(mim**
_file_
option-argument is
**\(mi**,
the results are unspecified.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _file_  
  A pathname of a file to be tested.

<a name="stdin"></a>

# Stdin

The standard input shall be used if a
_file_
operand is
**'\(mi'**
and the implementation treats the
**'\(mi'**
as meaning standard input.
Otherwise, the standard input shall not be used.

<a name="input-files"></a>

# Input Files

The
_file_
can be any file type.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_file_:

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
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

In the POSIX locale, the following format shall be used to identify
each operand,
_file_
specified:

    
    "%s: %sen", <file>, <type>


The values for &lt;_type_&gt; are unspecified, except that in the POSIX
locale, if
_file_
is identified as one of the types listed in the following table,
&lt;_type_&gt; shall contain (but is not limited to) the corresponding
string, unless the file is identified by a position-sensitive test
specified by a
**\(miM**
or
**\(mim**
option. Each
&lt;space&gt;
shown in the strings shall be exactly one
&lt;space&gt;.  

.ce 1
**Table 4-9: File Utility Output Strings**
.TS
center tab(@) box;
cB | cB | cB
l | l | l.
If _file_ is:@&lt;_type_&gt; shall contain the string:@Notes
_
Nonexistent@cannot open

Block special@block special@1
Character special@character special@1
Directory@directory@1
FIFO@fifo@1
Socket@socket@1
Symbolic link@symbolic link to@1
Regular file@regular file@1,2
Empty regular file@empty@3
Regular file that cannot be read@cannot open@3

Executable binary@executable@3,4,6
_ar_ archive library (see _ar_)@archive@3,4,6
Extended _cpio_ format (see _pax_)@cpio archive@3,4,6
Extended _tar_ format (see **ustar** in _pax_)@tar archive@3,4,6

Shell script@commands text@3,5,6
C-language source@c program text@3,5,6
FORTRAN source@fortran program text@3,5,6

Regular file whose type cannot be determined@data@3
.TE

* **Notes:**  
    *  1.  
      This is a file type test.
    *  2.  
      This test is applied only if the
      **\(mii**
      option is specified.
    *  3.  
      This test is applied only if the
      **\(mii**
      option is not specified.
    *  4.  
      This is a position-sensitive default system test.
    *  5.  
      This is a context-sensitive default system test.
    *  6.  
      Position-sensitive default system tests and context-sensitive
      default system tests are not applied if the
      **\(miM**
      option is specified unless the
      **\(mid**
      option is also specified.


In the POSIX locale, if
_file_
is identified as a symbolic link (see the
**\(mih**
option), the following alternative output format shall be used:

    
    "%s: %s %sen", <file>, <type>, <contents of link>"


If the file named by the
_file_
operand does not exist, cannot be read, or the type of the file named
by the
_file_
operand cannot be determined, this shall not be considered an error
that affects the exit status.

<a name="stderr"></a>

# Stderr

The standard error shall be used only for diagnostic messages.

<a name="output-files"></a>

# Output Files

None.

<a name="extended-description"></a>

# Extended Description

A file specified as an option-argument to the
**\(mim**
or
**\(miM**
options shall contain one position-sensitive test per line, which shall
be applied to the file. If the test succeeds, the message field of the
line shall be printed and no further tests shall be applied, with the
exception that tests on immediately following lines beginning with a
single
**'&gt;'**
character shall be applied.

Each line shall be composed of the following four
&lt;tab&gt;-separated
fields. (Implementations may allow any combination of one or more
white-space characters other than
&lt;newline&gt;
to act as field separators.)

* _offset_  
  An unsigned number (optionally preceded by a single
  **'&gt;'**
  character) specifying the
  _offset_,
  in bytes, of the value in the file that is to be compared against the
  _value_
  field of the line. If the file is shorter than the specified offset,
  the test shall fail.

If the
_offset_
begins with the character
**'&gt;'**,
the test contained in the line shall not be applied to the file unless
the test on the last line for which the
_offset_
did not begin with a
**'&gt;'**
was successful. By default, the
_offset_
shall be interpreted as an unsigned decimal number. With a leading 0x
or 0X, the
_offset_
shall be interpreted as a hexadecimal number; otherwise, with a leading
0, the
_offset_
shall be interpreted as an octal number.

* _type_  
  The type of the value in the file to be tested. The type shall consist
  of the type specification characters
  **d**,
  **s**,
  and
  **u**,
  specifying signed decimal, string, and unsigned decimal, respectively.

The
_type_
string shall be interpreted as the bytes from the file starting at the
specified
_offset_
and including the same number of bytes specified by the
_value_
field. If insufficient bytes remain in the file past the
_offset_
to match the
_value_
field, the test shall fail.

The type specification characters
**d**
and
**u**
can be followed by an optional unsigned decimal integer that specifies
the number of bytes represented by the type. The type specification
characters
**d**
and
**u**
can be followed by an optional
**C**,
**S**,
**I**,
or
**L**,
indicating that the value is of type
**char**,
**short**,
**int**,
or
**long**,
respectively.

The default number of bytes represented by the type specifiers
**d**,
**f**,
and
**u**
shall correspond to their respective C-language types as follows. If
the system claims conformance to the C-Language Development Utilities
option, those specifiers shall correspond to the default sizes used in
the
_c99_
utility. Otherwise, the default sizes shall be implementation-defined.

For the type specifier characters
**d**
and
**u**,
the default number of bytes shall correspond to the size of a basic
integer type of the implementation. For these specifier
characters, the implementation shall support values of the optional
number of bytes to be converted corresponding to the number of bytes in
the C-language types
**char**,
**short**,
**int**,
or
**long**.
These numbers can also be specified by an application as the characters
**C**,
**S**,
**I**,
and
**L**,
respectively. The byte order used when interpreting numeric values is
implementation-defined, but shall correspond to the order in which a
constant of the corresponding type is stored in memory on the system.

All type specifiers, except for
**s**,
can be followed by a mask specifier of the form &_number_. The mask
value shall be AND'ed with the value of the input file before the
comparison with the
_value_
field of the line is made. By default, the mask shall be interpreted as
an unsigned decimal number. With a leading 0x or 0X, the mask shall be
interpreted as an unsigned hexadecimal number; otherwise, with a
leading 0, the mask shall be interpreted as an unsigned octal number.

The strings
**byte**,
**short**,
**long**,
and
**string**
shall also be supported as type fields, being interpreted as
**dC**,
**dS**,
**dL**,
and
**s**,
respectively.

* _value_  
  The
  _value_
  to be compared with the value from the file.

If the specifier from the type field is
**s**
or
**string**,
then interpret the value as a string. Otherwise, interpret it as a
number. If the value is a string, then the test shall succeed only when
a string value exactly matches the bytes from the file.

If the
_value_
is a string, it can contain the following sequences:

* \e_character_  
  The
  &lt;backslash&gt;-escape
  sequences as specified in the Base Definitions volume of POSIX.1-2008,
  _Table 5-1_, _Escape Sequences and Associated Actions_
  (\c
  **'\e\e'**,
  **'\ea'**,
  **'\eb'**,
  **'\ef'**,
  **'\en'**,
  **'\er'**,
  **'\et'**,
  **'\ev'**).
  In addition, the escape sequence
  **'\e&nbsp;'**
  (the
  &lt;backslash&gt;
  character followed by a
  &lt;space&gt;
  character) shall be recognized to represent a
  &lt;space&gt;
  character. The results of using any other character, other than an
  octal digit, following the
  &lt;backslash&gt;
  are unspecified.
* \e_octal_  
  Octal sequences that can be used to represent characters with specific
  coded values. An octal sequence shall consist of a
  &lt;backslash&gt;
  followed by the longest sequence of one, two, or three octal-digit
  characters (01234567).

By default, any value that is not a string shall be interpreted as a
signed decimal number. Any such value, with a leading 0x or 0X, shall
be interpreted as an unsigned hexadecimal number; otherwise, with a
leading zero, the value shall be interpreted as an unsigned octal
number.

If the value is not a string, it can be preceded by a character
indicating the comparison to be performed. Permissible characters and
the comparisons they specify are as follows:

* =  
  The test shall succeed if the value from the file equals the
  _value_
  field.
* &lt;  
  The test shall succeed if the value from the file is less than the
  _value_
  field.
* &gt;  
  The test shall succeed if the value from the file is greater than the
  _value_
  field.
* &  
  The test shall succeed if all of the set bits in the
  _value_
  field are set in the value from the file.
* ^  
  The test shall succeed if at least one of the set bits in the
  _value_
  field is not set in the value from the file.
* x  
  The test shall succeed if the file is large enough to contain a value
  of the type specified starting at the offset specified.

* _message_  
  The
  _message_
  to be printed if the test succeeds. The
  _message_
  shall be interpreted using the notation for the
  _printf_
  formatting specification; see
  _printf_.
  If the
  _value_
  field was a string, then the value from the file shall be the argument
  for the
  _printf_
  formatting specification; otherwise, the value from the file shall be
  the argument.  

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

The
_file_
utility can only be required to guess at many of the file types because
only exhaustive testing can determine some types with certainty. For
example, binary data on some implementations might match the initial
segment of an executable or a
_tar_
archive.

Note that the table indicates that the output contains the stated
string. Systems may add text before or after the string. For
executables, as an example, the machine architecture and various facts
about how the file was link-edited may be included. Note also that on
systems that recognize shell script files starting with
**"#!"**
as executable files, these may be identified as executable binary files
rather than as shell scripts.

<a name="examples"></a>

# Examples

Determine whether an argument is a binary executable file:

    
    file (mi|(mi "$1" | grep (miq ':.*executable' &&
        printf "%s is executable.en$1"


<a name="rationale"></a>

# Rationale

The
**\(mif**
option was omitted because the same effect can (and should) be obtained
using the
_xargs_
utility.

Historical versions of the
_file_
utility attempt to identify the following types of files: symbolic
link, directory, character special, block special, socket,
_tar_
archive,
_cpio_
archive, SCCS archive, archive library, empty,
_compress_
output,
_pack_
output, binary data, C source, FORTRAN source, assembler source,
_nroff_/\c
_troff_/\c
_eqn_/\c
_tbl_
source
_troff_
output, shell script, C shell script, English text, ASCII text, various
executables, APL workspace, compiled terminfo entries, and CURSES
screen images. Only those types that are reasonably well specified in
POSIX or are directly related to POSIX utilities are listed in the
table.

Historical systems have used a \`\`magic file'' named
**/etc/magic**
to help identify file types. Because it is generally useful for users
and scripts to be able to identify special file types, the
**\(mim**
flag and a portable format for user-created magic files has been
specified. No requirement is made that an implementation of
_file_
use this method of identifying files, only that users be permitted to
add their own classifying tests.

In addition, three options have been added to historical practice. The
**\(mid**
flag has been added to permit users to cause their tests to follow any
default system tests. The
**\(mii**
flag has been added to permit users to test portably for regular files
in shell scripts. The
**\(miM**
flag has been added to permit users to ignore any default system
tests.

The POSIX.1-2008 description of default system tests and the interaction
between the
**\(mid**,
**\(miM**,
and
**\(mim**
options did not clearly indicate that there were two types of \`\`default
system tests''. The \`\`position-sensitive tests'' determine file types
by looking for certain string or binary values at specific offsets in
the file being examined. These position-sensitive tests were
implemented in historical systems using the magic file described above.
Some of these tests are now built into the
_file_
utility itself on some implementations so the output can provide more
detail than can be provided by magic files. For example, a magic file
can easily identify a
**core**
file on most implementations, but cannot name the program file that
dropped the core. A magic file could produce output such as:

    
    /home/dwc/core: ELF 32-bit MSB core file SPARC Version 1


but by building the test into the
_file_
utility, you could get output such as:

    
    /home/dwc/core: ELF 32-bit MSB core file SPARC Version 1, from 'testprog'


These extended built-in tests are still to be treated as
position-sensitive default system tests even if they are not listed in
**/etc/magic**
or any other magic file.

The context-sensitive default system tests were always built into the
_file_
utility. These tests looked for language constructs in text files
trying to identify shell scripts, C, FORTRAN, and other computer
language source files, and even plain text files. With the addition of
the
**\(mim**
and
**\(miM**
options the distinction between position-sensitive and
context-sensitive default system tests became important because the
order of testing is important. The context-sensitive system default
tests should never be applied before any position-sensitive tests even
if the
**\(mid**
option is specified before a
**\(mim**
option or
**\(miM**
option due to the high probability that the context-sensitive system
default tests will incorrectly identify arbitrary text files as text
files before position-sensitive tests specified by the
**\(mim**
or
**\(miM**
option would be applied to give a more accurate identification.

Leaving the meaning of
**\(miM \(mi**
and
**\(mim \(mi**
unspecified allows an existing prototype of these options to continue
to work in a backwards-compatible manner. (In that implementation,
**\(miM \(mi**
was roughly equivalent to
**\(mid**
in POSIX.1-2008.)

The historical
**\(mic**
option was omitted as not particularly useful to users or portable
shell scripts. In addition, a reasonable implementation of the
_file_
utility would report any errors found each time the magic file is
read.

The historical format of the magic file was the same as that specified
by the Rationale in the ISO&nbsp;POSIX-2:\|1993 standard for the
_offset_,
_value_,
and
_message_
fields; however, it used less precise type fields than the format
specified by the current normative text. The new type field values are
a superset of the historical ones.

The following is an example magic file:

    
    0  short     070707              cpio archive
    0  short     0143561             Byte-swapped cpio archive
    0  string    070707              ASCII cpio archive
    0  long      0177555             Very old archive
    0  short     0177545             Old archive
    0  short     017437              Old packed data
    0  string    e037e036            Packed data
    0  string    e377e037            Compacted data
    0  string    e037e235            Compressed data
    >2 byte&0x80 >0                  Block compressed
    >2 byte&0x1f x                   %d bits
    0  string    e032e001            Compiled Terminfo Entry
    0  short     0433                Curses screen image
    0  short     0434                Curses screen image
    0  string    <ar>                System V Release 1 archive
    0  string    !<arch>en__.SYMDEF  Archive random library
    0  string    !<arch>             Archive
    0  string    ARF_BEGARF          PHIGS clear text archive
    0  long      0x137A2950          Scalable OpenFont binary
    0  long      0x137A2951          Encrypted scalable OpenFont binary


The use of a basic integer data type is intended to allow the
implementation to choose a word size commonly used by applications
on that architecture.

Earlier versions of this standard allowed for implementations with
bytes other than eight bits, but this has been modified in this
version.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__ar_\^_,
__ls_\^_,
__pax_\^_,
__printf_\^_

The Base Definitions volume of POSIX.1-2008,
_Table 5-1_, _Escape Sequences and Associated Actions_,
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
