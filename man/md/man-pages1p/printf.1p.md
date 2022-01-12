# printf(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

printf
— write formatted output

<a name="synopsis"></a>

# Synopsis

```


```
    printf format [argument...]

<a name="description"></a>

# Description

The
_printf_
utility shall write formatted operands to the standard output. The
_argument_
operands shall be formatted under control of the
_format_
operand.

<a name="options"></a>

# Options

None.

<a name="operands"></a>

# Operands

The following operands shall be supported:

* _format_  
  A string describing the format to use to write the remaining operands.
  See the EXTENDED DESCRIPTION section.
* _argument_  
  The strings to be written to standard output, under the control of
  _format_.
  See the EXTENDED DESCRIPTION section.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_printf_:

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
  contents of diagnostic messages written to standard error.
* _LC\_NUMERIC_    
  Determine the locale for numeric formatting. It shall affect the
  format of numbers written using the
  **e**,
  **E**,
  **f**,
  **g**,
  and
  **G**
  conversion specifier characters (if supported).
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

See the EXTENDED DESCRIPTION section.

<a name="stderr"></a>

# Stderr

The standard error shall be used only for diagnostic messages.

<a name="output-files"></a>

# Output Files

None.

<a name="extended-description"></a>

# Extended Description

The
_format_
operand shall be used as the
_format_
string described in the Base Definitions volume of POSIX.1-2008,
_Chapter 5_, _File Format Notation_
with the following exceptions:

*  1.  
  A
  &lt;space&gt;
  in the format string, in any context other than a flag of a conversion
  specification, shall be treated as an ordinary character that is copied
  to the output.
*  2.  
  A
  **'**'
  character in the format string shall be treated as a
  **'**'
  character, not as a
  &lt;space&gt;.
*  3.  
  In addition to the escape sequences shown in the Base Definitions volume of POSIX.1-2008,
  _Chapter 5_, _File Format Notation_
  (\c
  **'\e\e'**,
  **'\ea'**,
  **'\eb'**,
  **'\ef'**,
  **'\en'**,
  **'\er'**,
  **'\et'**,
  **'\ev'**),
  **"\eddd"**,
  where
  _ddd_
  is a one, two, or three-digit octal number, shall be written as a byte
  with the numeric value specified by the octal number.
*  4.  
  The implementation shall not precede or follow output from the
  **d**
  or
  **u**
  conversion specifiers with
  &lt;blank&gt;
  characters not specified by the
  _format_
  operand.
*  5.  
  The implementation shall not precede output from the
  **o**
  conversion specifier with zeros not specified by the
  _format_
  operand.
*  6.  
  The
  **a**,
  **A**,
  **e**,
  **E**,
  **f**,
  **F**,
  **g**,
  and
  **G**
  conversion specifiers need not be supported.
*  7.  
  An additional conversion specifier character,
  **b**,
  shall be supported as follows. The argument shall be taken to be a
  string that may contain
  &lt;backslash&gt;-escape
  sequences. The following
  &lt;backslash&gt;-escape
  sequences shall be supported:
    * --  
      The escape sequences listed in the Base Definitions volume of POSIX.1-2008,
      _Chapter 5_, _File Format Notation_
      (\c
      **'\e\e'**,
      **'\ea'**,
      **'\eb'**,
      **'\ef'**,
      **'\en'**,
      **'\er'**,
      **'\et'**,
      **'\ev'**),
      which shall be converted to the characters they represent
    * --  
      **"\e0ddd"**,
      where
      _ddd_
      is a zero, one, two, or three-digit octal number that shall be
      converted to a byte with the numeric value specified by the octal
      number
    * --  
      **'\ec'**,
      which shall not be written and shall cause
      _printf_
      to ignore any remaining characters in the string operand containing it,
      any remaining string operands, and any additional characters in the
      _format_
      operand

The interpretation of a
&lt;backslash&gt;
followed by any other sequence of characters is unspecified.

Bytes from the converted string shall be written until the end of the
string or the number of bytes indicated by the precision specification
is reached. If the precision is omitted, it shall be taken to be
infinite, so all bytes up to the end of the converted string shall be
written.

*  8.  
  For each conversion specification that consumes an argument, the next
  argument operand shall be evaluated and converted to the appropriate
  type for the conversion as specified below.
*  9.  
  The
  _format_
  operand shall be reused as often as necessary to satisfy the argument
  operands. Any extra
  **c**
  or
  **s**
  conversion specifiers shall be evaluated as if a null string
  argument were supplied; other extra conversion specifications shall be
  evaluated as if a zero argument were supplied. If the
  _format_
  operand contains no conversion specifications and
  _argument_
  operands are present, the results are unspecified.
* 10.  
  If a character sequence in the
  _format_
  operand begins with a
  **'%'**
  character, but does not form a valid conversion specification, the
  behavior is unspecified.
* 11.  
  The argument to the
  **c**
  conversion specifier can be a string containing zero or more bytes. If
  it contains one or more bytes, the first byte shall be written and any
  additional bytes shall be ignored. If the argument is an empty string,
  it is unspecified whether nothing is written or a null byte is written.

The
_argument_
operands shall be treated as strings if the corresponding conversion
specifier is
**b**,
**c**,
or
**s**,
and shall be evaluated as if by the
_strtod_()
function if the corresponding conversion specifier is
**a**,
**A**,
**e**,
**E**,
**f**,
**F**,
**g**,
or
**G**.
Otherwise, they shall be evaluated as unsuffixed C integer constants,
as described by the ISO&nbsp;C standard, with the following extensions:

*  *  
  A leading
  &lt;plus-sign&gt;
  or minus-sign shall be allowed.
*  *  
  If the leading character is a single-quote or double-quote, the value
  shall be the numeric value in the underlying codeset of the character
  following the single-quote or double-quote.
*  *  
  Suffixed integer constants may be allowed.

If an argument operand cannot be completely converted into an internal
value appropriate to the corresponding conversion specification, a
diagnostic message shall be written to standard error and the utility
shall not exit with a zero exit status, but shall continue processing
any remaining operands and shall write the value accumulated at the
time the error was detected to standard output.

It is not considered an error if an argument operand is not completely
used for a
**c**
or
**s**
conversion.

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

The floating-point formatting conversion specifications of
_printf_()
are not required because all arithmetic in the shell is integer
arithmetic. The
_awk_
utility performs floating-point calculations and provides its own
**printf**
function. The
_bc_
utility can perform arbitrary-precision floating-point arithmetic, but
does not provide extensive formatting capabilities. (This
_printf_
utility cannot really be used to format
_bc_
output; it does not support arbitrary precision.) Implementations are
encouraged to support the floating-point conversions as an extension.

Note that this
_printf_
utility, like the
_printf_()
function defined in the System Interfaces volume of POSIX.1-2008 on which it is based, makes no special
provision for dealing with multi-byte characters when using the
**%c**
conversion specification or when a precision is specified in a
**%b**
or
**%s**
conversion specification. Applications should be extremely cautious
using either of these features when there are multi-byte characters in
the character set.

No provision is made in this volume of POSIX.1-2008 which allows field widths and precisions
to be specified as
**'*'**
since the
**'*'**
can be replaced directly in the
_format_
operand using shell variable substitution. Implementations can also
provide this feature as an extension if they so choose.

Hexadecimal character constants as defined in the ISO&nbsp;C standard are not
recognized in the
_format_
operand because there is no consistent way to detect the end of the
constant. Octal character constants are limited to, at most, three
octal digits, but hexadecimal character constants are only terminated
by a non-hex-digit character. In the ISO&nbsp;C standard, the
**"##"**
concatenation operator can be used to terminate a constant and follow
it with a hexadecimal character to be written. In the shell,
concatenation occurs before the
_printf_
utility has a chance to parse the end of the hexadecimal constant.

The
**%b**
conversion specification is not part of the ISO&nbsp;C standard; it has been added
here as a portable way to process
&lt;backslash&gt;-escapes
expanded in string operands as provided by the
_echo_
utility. See also the APPLICATION USAGE section of
__echo_\^_
for ways to use
_printf_
as a replacement for all of the traditional versions of the
_echo_
utility.

If an argument cannot be parsed correctly for the corresponding
conversion specification, the
_printf_
utility is required to report an error. Thus, overflow and extraneous
characters at the end of an argument being used for a numeric
conversion shall be reported as errors.

<a name="examples"></a>

# Examples

To alert the user and then print and read a series of prompts:

    
    printf "eaPlease fill in the following: enName: "
    read name
    printf "Phone number: "
    read phone


To read out a list of right and wrong answers from a file, calculate
the percentage correctly, and print them out. The numbers are
right-justified and separated by a single
&lt;tab&gt;.
The percentage is written to one decimal place of accuracy:

    
    while read right wrong ; do
        percent=$(echo "scale=1;($right*100)/($right+$wrong)" | bc)
        printf "%2d rightet%2d wronget(%s%%)en" e
            $right $wrong $percent
    done < database_file

The command:

    
    printf "%5d%4den" 1 21 321 4321 54321


produces:

    
        1  21
      3214321
    54321   0


Note that the
_format_
operand is used three times to print all of the given strings and that
a
**'0'**
was supplied by
_printf_
to satisfy the last
**%4d**
conversion specification.

The
_printf_
utility is required to notify the user when conversion errors are
detected while producing numeric output; thus, the following results
would be expected on an implementation with 32-bit twos-complement
integers when
**%d**
is specified as the
_format_
operand:  
.TS
center tab(@) box;
cB | cB | cB
cB | cB | cB
lf5 | lf5 | lf7.
@Standard
Argument@Output@Diagnostic Output
_
5a@5@printf: "5a" not completely converted
9999999999@2147483647@printf: "9999999999" arithmetic overflow
\(mi9999999999@\(mi2147483648@printf: "\(mi9999999999" arithmetic overflow
ABC@0@printf: "ABC" expected numeric value
.TE

The diagnostic message format is not specified, but these examples
convey the type of information that should be reported. Note that the
value shown on standard output is what would be expected as the return
value from the
_strtol_()
function as defined in the System Interfaces volume of POSIX.1-2008. A similar correspondence exists
between
**%u**
and
_strtoul_()
and
**%e**,
**%f**,
and
**%g**
(if the implementation supports floating-point conversions) and
_strtod_().

In a locale using the ISO/IEC&nbsp;646:\|1991 standard as the underlying codeset, the command:

    
    printf "%den" 3 +3 (mi3 e'3 e"+3 "'(mi3"


produces:

* 3  
  Numeric value of constant 3
* 3  
  Numeric value of constant 3
* \(mi3  
  Numeric value of constant \(mi3
* 51  
  Numeric value of the character
  **'3'**
  in the ISO/IEC&nbsp;646:\|1991 standard codeset
* 43  
  Numeric value of the character
  **'\(pl'**
  in the ISO/IEC&nbsp;646:\|1991 standard codeset
* 45  
  Numeric value of the character
  **'\(mi'**
  in the ISO/IEC&nbsp;646:\|1991 standard codeset

Note that in a locale with multi-byte characters, the value of a
character is intended to be the value of the equivalent of the
**wchar_t**
representation of the character as described in the System Interfaces volume of POSIX.1-2008.

<a name="rationale"></a>

# Rationale

The
_printf_
utility was added to provide functionality that has historically been
provided by
_echo_.
However, due to irreconcilable differences in the various versions of
_echo_
extant, the version has few special features, leaving those to this new
_printf_
utility, which is based on one in the Ninth Edition system.

The EXTENDED DESCRIPTION section almost exactly matches the
_printf_()
function in the ISO&nbsp;C standard, although it is described in terms of the file
format notation in the Base Definitions volume of POSIX.1-2008,
_Chapter 5_, _File Format Notation_.

Earlier versions of this standard specified that arguments for all
conversions other than
**b**,
**c**,
and
**s**
were evaluated in the same way (as C constants, but with stated
exceptions). For implementations supporting the floating-point conversions
it was not clear whether integer conversions need only accept integer
constants and floating-point conversions need only accept floating-point
constants, or whether both types of conversions should accept both
types of constants. Also by not distinguishing between them, the
requirement relating to a leading single-quote or double-quote applied
to floating-point conversions even though this provided no useful
functionality to applications that was not already available through
the integer conversions. The current standard clarifies the situation
by specifying that the arguments for floating-point conversions are
evaluated as if by
_strtod_(),
and the arguments for integer conversions are evaluated as C integer
constants, with the special treatment of leading single-quote and
double-quote applying only to integer conversions.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__awk_\^_,
__bc_\^_,
__echo_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 5_, _File Format Notation_,
_Chapter 8_, _Environment Variables_

The System Interfaces volume of POSIX.1-2008,
__fprintf_\^(\|)_,
__strtod_\^(\|)_

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
