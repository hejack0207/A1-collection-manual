# od(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

od
— dump files in various formats

<a name="synopsis"></a>

# Synopsis

```


```
    od [(miv] [(miA address_base] [(mij skip] [(miN count] [(mit type_string]...
        [file...]
    
    od [(mibcdosx] [file] [[+]offset[.][b]]

<a name="description"></a>

# Description

The
_od_
utility shall write the contents of its input files to standard output
in a user-specified format.

<a name="options"></a>

# Options

The
_od_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_,
except that the order of presentation of the
**\(mit**
options
and the
**\(mibcdosx**
options
is significant.

The following options shall be supported:

* **\(miA&nbsp;address\_base**    
  Specify the input offset base. See the EXTENDED DESCRIPTION section.
  The application shall ensure that the
  _address_base_
  option-argument is a character. The characters
  **'d'**,
  **'o'**,
  and
  **'x'**
  specify that the offset base shall be written in decimal, octal, or
  hexadecimal, respectively. The character
  **'n'**
  specifies that the offset shall not be written.
* **\(mib**  
  Interpret bytes in octal. This shall be equivalent to
  **\(mit&nbsp;o1**.
* **\(mic**  
  Interpret bytes as characters specified by the current setting of the
  _LC_CTYPE_
  category. Certain non-graphic characters appear as C escapes:
  **"NUL=\e0"**,
  **"BS=\eb"**,
  **"FF=\ef"**,
  **"NL=\en"**,
  **"CR=\er"**,
  **"HT=\et"**;
  others appear as 3-digit octal numbers.
* **\(mid**  
  Interpret
  _word_s
  (two-byte units) in unsigned decimal. This shall be equivalent to
  **\(mit&nbsp;u2**.
* **\(mij&nbsp;skip**  
  Jump over
  _skip_
  bytes from the beginning of the input. The
  _od_
  utility shall read or seek past the first
  _skip_
  bytes in the concatenated input files. If the combined input is not at
  least
  _skip_
  bytes long, the
  _od_
  utility shall write a diagnostic message to standard error and exit
  with a non-zero exit status.

By default, the
_skip_
option-argument shall be interpreted as a decimal number. With a
leading 0x or 0X, the offset shall be interpreted as a hexadecimal
number; otherwise, with a leading
**'0'**,
the offset shall be interpreted as an octal number. Appending the
character
**'b'**,
**'k'**,
or
**'m'**
to offset shall cause it to be interpreted as a multiple of 512,
1\|024, or 1\|048\|576 bytes, respectively. If the
_skip_
number is hexadecimal, any appended
**'b'**
shall be considered to be the final hexadecimal digit.

* **\(miN&nbsp;count**  
  Format no more than
  _count_
  bytes of input. By default,
  _count_
  shall be interpreted as a decimal number. With a leading 0x or 0X,
  _count_
  shall be interpreted as a hexadecimal number; otherwise, with a leading
  **'0'**,
  it shall be interpreted as an octal number. If
  _count_
  bytes of input (after successfully skipping, if
  **\(mij**
  _skip_
  is specified) are not available, it shall not be considered an error;
  the
  _od_
  utility shall format the input that is available.
* **\(mio**  
  Interpret
  _word_s
  (two-byte units) in octal. This shall be equivalent to
  **\(mit&nbsp;o2**.
* **\(mis**  
  Interpret
  _word_s
  (two-byte units) in signed decimal. This shall be equivalent to
  **\(mit&nbsp;d2**.
* **\(mit&nbsp;type\_string**    
  Specify one or more output types. See the EXTENDED DESCRIPTION
  section. The application shall ensure that the
  _type_string_
  option-argument is a string specifying the types to be used when
  writing the input data. The string shall consist of the type
  specification characters
  **a**,
  **c**,
  **d**,
  **f**,
  **o**,
  **u**,
  and
  **x**,
  specifying named character, character, signed decimal, floating point,
  octal, unsigned decimal, and hexadecimal, respectively. The type
  specification characters
  **d**,
  **f**,
  **o**,
  **u**,
  and
  **x**
  can be followed by an optional unsigned decimal integer that specifies
  the number of bytes to be transformed by each instance of the output
  type. The type specification character
  **f**
  can be followed by an optional
  **F**,
  **D**,
  or
  **L**
  indicating that the conversion should be applied to an item of type
  **float**,
  **double**,
  or
  **long double**,
  respectively. The type specification characters
  **d**,
  **o**,
  **u**,
  and
  **x**
  can be followed by an optional
  **C**,
  **S**,
  **I**,
  or
  **L**
  indicating that the conversion should be applied to an item of type
  **char**,
  **short**,
  **int**,
  or
  **long**,
  respectively. Multiple types can be concatenated within the same
  _type_string_
  and multiple
  **\(mit**
  options can be specified. Output lines shall be written for each type
  specified in the order in which the type specification characters are
  specified.
* **\(miv**  
  Write all input data. Without the
  **\(miv**
  option, any number of groups of output lines, which would be identical
  to the immediately preceding group of output lines (except for the byte
  offsets), shall be replaced with a line containing only an
  &lt;asterisk&gt;
  (\c
  **'*'**).
* **\(mix**  
  Interpret
  _word_s
  (two-byte units) in hexadecimal. This shall be equivalent to
  **\(mit&nbsp;x2**.

Multiple types can be specified by using multiple
**\(mibcdostx**
options. Output lines are written for each type specified in the order
in which the types are specified.

<a name="operands"></a>

# Operands

The following operands shall be supported:

* _file_  
  A pathname of a file to be read. If no
  _file_
  operands are specified, the standard input shall be used.

If there are no more than two operands, none of the
**\(miA**,
**\(mij**,
**\(miN**,
**\(mit**,
or
**\(miv**
options is specified, and either of the following is true: the first
character of the last operand is a
&lt;plus-sign&gt;
(\c
**'\(pl'**),
or there are two operands and the first character of the last operand
is numeric;
the last operand shall be interpreted as an offset operand on
XSI-conformant systems.
Under these conditions, the results are unspecified on systems that are
not XSI-conformant systems.

* **[+]offset[.][b]**  
  The
  _offset_
  operand specifies the offset in the file where dumping is to commence.
  This operand is normally interpreted as octal bytes. If
  **'.'**
  is appended, the offset shall be interpreted in decimal. If
  **'b'**
  is appended, the offset shall be interpreted in units of 512 bytes.

<a name="stdin"></a>

# Stdin

The standard input shall be used if no
_file_
operands are specified, and shall be used if a
_file_
operand is
**'\(mi'**
and the implementation treats the
**'\(mi'**
as meaning standard input.
Otherwise, the standard input shall not be used.
See the INPUT FILES section.

<a name="input-files"></a>

# Input Files

The input files can be any file type.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_od_:

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
  contents of diagnostic messages written to standard error.
* _LC\_NUMERIC_    
  Determine the locale for selecting the radix character used when
  writing floating-point formatted output.
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
_od_
utility shall copy sequentially each input file to standard output,
transforming the input data according to the output types specified by
the
**\(mit**
option
or the
**\(mibcdosx**
options.
If no output type is specified, the default output shall be as if
**\(mit&nbsp;oS**
had been specified.

The number of bytes transformed by the output type specifier
**c**
may be variable depending on the
_LC_CTYPE_
category.

The default number of bytes transformed by output type specifiers
**d**,
**f**,
**o**,
**u**,
and
**x**
corresponds to the various C-language types as follows. If the
_c99_
compiler is present on the system, these specifiers shall correspond to
the sizes used by default in that compiler. Otherwise, these sizes
may vary among systems that conform to POSIX.1-2008.

*  *  
  For the type specifier characters
  **d**,
  **o**,
  **u**,
  and
  **x**,
  the default number of bytes shall correspond to the size of the
  underlying implementation's basic integer type. For these specifier
  characters, the implementation shall support values of the optional
  number of bytes to be converted corresponding to the number of bytes in
  the C-language types
  **char**,
  **short**,
  **int**,
  and
  **long**.
  These numbers can also be specified by an application as the characters
  **'C'**,
  **'S'**,
  **'I'**,
  and
  **'L'**,
  respectively. The implementation shall also support the values 1, 2, 4,
  and 8, even if it provides no C-Language types of those sizes. The
  implementation shall support the decimal value corresponding to the
  C-language type
  **long long**.
  The byte order used when interpreting numeric values is
  implementation-defined, but shall correspond to the order in which a
  constant of the corresponding type is stored in memory on the system.
*  *  
  For the type specifier character
  **f**,
  the default number of bytes shall correspond to the number of bytes in
  the underlying implementation's basic double precision floating-point
  data type. The implementation shall support values of the optional
  number of bytes to be converted corresponding to the number of bytes in
  the C-language types
  **float,**
  **double**,
  and
  **long double**.
  These numbers can also be specified by an application as the characters
  **'F'**,
  **'D'**,
  and
  **'L'**,
  respectively.

The type specifier character
**a**
specifies that bytes shall be interpreted as named characters from the
International Reference Version (IRV) of the ISO/IEC&nbsp;646:\|1991 standard. Only the least
significant seven bits of each byte shall be used for this type
specification. Bytes with the values listed in the following table
shall be written using the corresponding names for those characters.  

.ce 1
**Table: Named Characters in od**
.TS
center box tab(@);
cB cB | cB cB | cB cB | cB cB
l lb | l lb | l lb | l lb.
Value@Name@Value@Name@Value@Name@Value@Name
_
\e000@nul@\e001@soh@\e002@stx@\e003@etx
\e004@eot@\e005@enq@\e006@ack@\e007@bel
\e010@bs@\e011@ht@\e012@lf or nl\u\s-3*\s+3\d@\e013@vt
\e014@ff@\e015@cr@\e016@so@\e017@si
\e020@dle@\e021@dc1@\e022@dc2@\e023@dc3
\e024@dc4@\e025@nak@\e026@syn@\e027@etb
\e030@can@\e031@em@\e032@sub@\e033@esc
\e034@fs@\e035@gs@\e036@rs@\e037@us
\e040@sp@\e177@del
.TE

* **Note:**  
  The
  **"\e012"**
  value may be written either as
  **lf**
  or
  **nl**.


The type specifier character
**c**
specifies that bytes shall be interpreted as characters specified by
the current setting of the
_LC_CTYPE_
locale category. Characters listed in the table in the Base Definitions volume of POSIX.1-2008,
_Chapter 5_, _File Format Notation_
(\c
**'\e\e'**,
**'\ea'**,
**'\eb'**,
**'\ef'**,
**'\en'**,
**'\er'**,
**'\et'**,
**'\ev'**)
shall be written as the corresponding escape sequences, except that
&lt;backslash&gt;
shall be written as a single
&lt;backslash&gt;
and a NUL shall be written as
**'\e0'**.
Other non-printable characters shall be written as one three-digit
octal number for each byte in the character. Printable multi-byte
characters shall be written in the area corresponding to the first byte
of the character; the two-character sequence
**"**"**
shall be written in the area corresponding to each remaining byte in
the character, as an indication that the character is continued. When
either the
**\(mij**
_skip_
or
**\(miN**
_count_
option is specified along with the
**c**
type specifier, and this results in an attempt to start or finish in
the middle of a multi-byte character, the result is
implementation-defined.

The input data shall be manipulated in blocks, where a block is defined
as a multiple of the least common multiple of the number of bytes
transformed by the specified output types. If the least common
multiple is greater than 16, the results are unspecified. Each input
block shall be written as transformed by each output type, one per
written line, in the order that the output types were specified. If
the input block size is larger than the number of bytes transformed by
the output type, the output type shall sequentially transform the parts
of the input block, and the output from each of the transformations
shall be separated by one or more
&lt;blank&gt;
characters.

If, as a result of the specification of the
**\(miN**
option or end-of-file being reached on the last input file, input data
only partially satisfies an output type, the input shall be extended
sufficiently with null bytes to write the last byte of the input.

Unless
**\(miA&nbsp;n**
is specified, the first output line produced for each input block shall
be preceded by the input offset, cumulative across input files, of the
next byte to be written. The format of the input offset is unspecified;
however, it shall not contain any
&lt;blank&gt;
characters, shall start at the first character of the output line,
and shall be followed by one or more
&lt;blank&gt;
characters. In addition, the offset of the byte following the last byte
written shall be written after all the input data has been processed,
but shall not be followed by any
&lt;blank&gt;
characters.

If no
**\(miA**
option is specified, the input offset base is unspecified.

<a name="exit-status"></a>

# Exit Status

The following exit values shall be returned:

* \00  
  All input files were processed successfully.
* &gt;0  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

XSI-conformant applications are warned not to use filenames starting
with
**'\(pl'**
or a first operand starting with a numeric character so that the old
functionality can be maintained by implementations, unless they specify
one of the
**\(miA**,
**\(mij**,
or
**\(miN**
options. To guarantee that one of these filenames is always
interpreted as a filename, an application could always specify the
address base format with the
**\(miA**
option.

<a name="examples"></a>

# Examples

If a file containing 128 bytes with decimal values zero to 127, in
increasing order, is supplied as standard input to the command:

    
    od (miA d (mit a


on an implementation using an input block size of 16 bytes, the
standard output, independent of the current locale setting, would be
similar to:

    
    0000000 nul soh stx etx eot enq ack bel  bs  ht  nl  vt  ff  cr  so  si
    0000016 dle dc1 dc2 dc3 dc4 nak syn etb can  em sub esc  fs  gs  rs  us
    0000032  sp   !   "   #   $   %   &   '   (   )   *   +   ,   (mi   .  /
    0000048   0   1   2   3   4   5   6   7   8   9   :   ;   <   =   >   ?
    0000064   @   A   B   C   D   E   F   G   H   I   J   K   L   M   N   O
    0000080   P   Q   R   S   T   U   V   W   X   Y   Z   [   e   ]   ^   _
    0000096   `   a   b   c   d   e   f   g   h   i   j   k   l   m   n   o
    0000112   p   q   r   s   t   u   v   w   x   y   z   {   |   }   ~ del
    0000128


Note that this volume of POSIX.1-2008 allows
**nl**
or
**lf**
to be used as the name for the ISO/IEC&nbsp;646:\|1991 standard IRV character with decimal value
10. The IRV names this character
**lf**
(line feed), but traditional implementations have referred to this
character as newline
(\c
**nl**)
and the POSIX locale character set symbolic name for the corresponding
character is a
&lt;newline&gt;.

The command:

    
    od (miA o (mit o2x2x (miN 18


on a system with 32-bit words and an implementation using an input
block size of 16 bytes could write 18 bytes in approximately the
following format:

    
    0000000 032056 031440 041123 042040 052516 044530 020043 031464
              342e   3320   4253   4420   554e   4958   2023   3334
                 342e3320      42534420      554e4958      20233334
    0000020 032472
              353a
                 353a0000
    0000022


The command:

    
    od (miA d (mit f (mit o4 (mit x4 (miN 24 (mij 0x15


on a system with 64-bit doubles (for example, IEEE&nbsp;Std&nbsp;754-1985 double
precision floating-point format) would skip 21 bytes of input data and
then write 24 bytes in approximately the following format:

    
    0000000    1.00000000000000e+00    1.57350000000000e+01
            07774000000 00000000000 10013674121 35341217270
               3ff00000    00000000    402f3851    eb851eb8
    0000016    1.40668230000000e+02
            10030312542 04370303230
               40619562    23e18698
    0000024


<a name="rationale"></a>

# Rationale

The
_od_
utility went through several names in early proposals, including
_hd_,
_xd_,
and most recently
_hexdump_.
There were several objections to all of these based on the following
reasons:

*  *  
  The
  _hd_
  and
  _xd_
  names conflicted with historical utilities that behaved differently.
*  *  
  The
  _hexdump_
  description was much more complex than needed for a simple dump
  utility.
*  *  
  The
  _od_
  utility has been available on all historical implementations and there
  was no need to create a new name for a utility so similar to the
  historical
  _od_
  utility.

The original reasons for not standardizing historical
_od_
were also fairly widespread. Those reasons are given below along with
rationale explaining why the standard developers believe that this
version does not suffer from the indicated problem:

*  *  
  The BSD and System V versions of
  _od_
  have diverged, and the intersection of features provided by both does
  not meet the needs of the user community. In fact, the System V
  version only provides a mechanism for dumping octal bytes and
  **short**s,
  signed and unsigned decimal
  **short**s,
  hexadecimal
  **short**s,
  and ASCII characters. BSD added the ability to dump
  **float**s,
  **double**s,
  named ASCII characters, and octal, signed decimal, unsigned decimal,
  and hexadecimal
  **long**s.
  The version presented here provides more normalized forms for dumping
  bytes,
  **short**s,
  **int**s,
  and
  **long**s
  in octal, signed decimal, unsigned decimal, and hexadecimal;
  **float**,
  **double**,
  and
  **long double**;
  and named ASCII as well as current locale characters.
*  *  
  It would not be possible to come up with a compatible superset of the
  BSD and System V flags that met the requirements of the standard
  developers. The historical default
  _od_
  output is the specified default output of this utility. None of the
  option letters chosen for this version of
  _od_
  conflict with any of the options to historical versions of
  _od_.
*  *  
  On systems with different sizes for
  **short**,
  **int**,
  and
  **long**,
  there was no way to ask for dumps of
  **int**s,
  even in the BSD version. Because of the way options are named, the
  name space could not be extended to solve these problems. This is why
  the
  **\(mit**
  option was added (with type specifiers more closely matched to the
  _printf_()
  formats used in the rest of this volume of POSIX.1-2008) and the optional field sizes were
  added to the
  **d**,
  **f**,
  **o**,
  **u**,
  and
  **x**
  type specifiers. It is also one of the reasons why the historical
  practice was not mandated as a required obsolescent form of
  _od_.
  (Although the old versions of
  _od_
  are not listed as an obsolescent form, implementations are urged to
  continue to recognize the older forms for several more years.) The
  **a**,
  **c**,
  **f**,
  **o**,
  and
  **x**
  types match the meaning of the corresponding format characters in the
  historical implementations of
  _od_
  except for the default sizes of the fields converted. The
  **d**
  format is signed in this volume of POSIX.1-2008 to match the
  _printf_()
  notation. (Historical versions of
  _od_
  used
  **d**
  as a synonym for
  **u**
  in this version. The System V implementation uses
  **s**
  for signed decimal; BSD uses
  **i**
  for signed decimal and
  **s**
  for null-terminated strings.) Other than
  **d**
  and
  **u**,
  all of the type specifiers match format characters in the historical
  BSD version of
  **od**.

The sizes of the C-language types
**char**,
**short**,
**int**,
**long**,
**float**,
**double**,
and
**long double**
are used even though it is recognized that there may be zero or more
than one compiler for the C language on an implementation and that they
may use different sizes for some of these types. (For example, one
compiler might use 2 bytes
**short**s,
2 bytes
**int**s,
and 4 bytes
**long**s,
while another compiler (or an option to the same compiler) uses 2 bytes
**short**s,
4 bytes
**int**s,
and 4 bytes
**long**s.)
Nonetheless, there has to be a basic size known by the implementation
for these types, corresponding to the values reported by invocations of
the
_getconf_
utility when called with
_system_var_
operands
{UCHAR_MAX},
{USHORT_MAX},
{UINT_MAX},
and
{ULONG_MAX}
for the types
**char**,
**short**,
**int**,
and
**long**,
respectively. There are similar constants required by the ISO&nbsp;C standard, but
not required by the System Interfaces volume of POSIX.1-2008 or this volume of POSIX.1-2008. They are
{FLT_MANT_DIG},
{DBL_MANT_DIG},
and
{LDBL_MANT_DIG}
for the types
**float**,
**double**,
and
**long double**,
respectively. If the optional
_c99_
utility is provided by the implementation and used as specified by
this volume of POSIX.1-2008, these are the sizes that would be provided. If an option is used
that specifies different sizes for these types, there is no guarantee
that the
_od_
utility is able to interpret binary data output by such a program
correctly.

This volume of POSIX.1-2008 requires that the numeric values of these lengths be recognized
by the
_od_
utility and that symbolic forms also be recognized. Thus, a conforming
application can always look at an array of
**unsigned long**
data elements using
_od_
**\(mit**
_uL_.

*  *  
  The method of specifying the format for the address field based on
  specifying a starting offset in a file unnecessarily tied the two
  together. The
  **\(miA**
  option now specifies the address base and the
  **\(miS**
  option specifies a starting offset.
*  *  
  It would be difficult to break the dependence on US ASCII to achieve
  an internationalized utility. It does not seem to be any harder for
  _od_
  to dump characters in the current locale than it is for the
  _ed_
  or
  _sed_
  **l**
  commands. The
  **c**
  type specifier does this without difficulty and is completely
  compatible with the historical implementations of the
  **c**
  format character when the current locale uses a superset of the ISO/IEC&nbsp;646:\|1991 standard
  as a codeset. The
  **a**
  type specifier (from the BSD
  **a**
  format character) was left as a portable means to dump ASCII (or more
  correctly ISO/IEC&nbsp;646:\|1991 standard (IRV)) so that headers produced by
  _pax_
  could be deciphered even on systems that do not use the ISO/IEC&nbsp;646:\|1991 standard as a
  subset of their base codeset.

The use of
**"**"**
as an indication of continuation of a multi-byte character in
**c**
specifier output was chosen based on seeing an implementation that uses
this method. The continuation bytes have to be marked in a way that is
not ambiguous with another single-byte or multi-byte character.

An early proposal used
**\(miS**
and
**\(min**,
respectively, for the
**\(mij**
and
**\(miN**
options eventually selected. These were changed to avoid conflicts with
historical implementations.

The original standard specified
**\(mit o2**
as the default when no output type was given. This was changed to
**\(mit oS**
(the length of a
**short**)
to accommodate a supercomputer implementation that historically used 64
bits as its default (and that defined shorts as 64 bits). This change
should not affect conforming applications. The requirement to support
lengths of 1, 2, and 4 was added at the same time to address an
historical implementation that had no two-byte data types in its C
compiler.

The use of a basic integer data type is intended to allow the
implementation to choose a word size commonly used by applications
on that architecture.

Earlier versions of this standard allowed for implementations with
bytes other than eight bits, but this has been modified in this
version.

<a name="future-directions"></a>

# Future Directions

All option and operand interfaces marked XSI may be removed
in a future version.

<a name="see-also"></a>

# See Also

__c99_\^_,
__sed_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 5_, _File Format Notation_,
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
